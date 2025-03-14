package org.juyb99.pickmecupjsp.controller.api;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.Exception.APIException;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.Controller;
import org.juyb99.pickmecupjsp.domain.GameItem;
import org.juyb99.pickmecupjsp.dto.request.GameItemRequestDTO;
import org.juyb99.pickmecupjsp.service.GameItemService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/api/items/*")
public class GameItemController extends Controller {
    private final GameItemService gameItemService;

    public GameItemController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        gameItemService = (GameItemService) servletContext.getAttribute("GameItemService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        if (!pathInfo.equals("/")) {
            routeGetMethod(req, resp);
            return;
        }

        List<GameItem> gameItemList = gameItemService.readAllGameItem();
        responseGameItemListAsJson(resp, gameItemList);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestBody = req.getReader().lines().collect(Collectors.joining());

        try {
            List<GameItemRequestDTO> gameItemRequestDTO = JsonUtil.fromJsonList(requestBody, GameItemRequestDTO.class);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().println(JsonUtil.toJson(gameItemService.saveItem(gameItemRequestDTO)));
            resp.getWriter().flush();
            resp.getWriter().close();
        } catch (APIException e) {
            resp.setStatus(e.getStatusCode());
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"서버 내부 오류가 발생했습니다.\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();

        if (pathInfo != null) {
            routePutMethod(req, resp);
        }
    }

    private void responseGameItemListAsJson(HttpServletResponse resp, List<GameItem> gameItemList) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(JsonUtil.toJson(gameItemList));
    }

    private void routeGetMethod(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); // 예: "/theme/아이돌" 또는 "/title/뉴진스 - Hype Boy" 뉴진스의 하입보이요~
        String[] pathParts = pathInfo.split("/");

        if (pathParts.length < 3) { // 올바른 요청이 아닐 경우
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid API request format.");
            return;
        }

        String type = pathParts[1];
        String value = pathParts[2];

        switch (type) {
            case "title" -> requestTitleAPI(resp, value);
            case "theme" -> requestThemeAPI(resp, value);
            default -> resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid endpoint.");
        }
    }

    private void requestTitleAPI(HttpServletResponse resp, String title) throws IOException {
        List<GameItem> gameItemList = gameItemService.readGameItemByTitle(title);
        responseGameItemListAsJson(resp, gameItemList);
    }

    private void requestThemeAPI(HttpServletResponse resp, String theme) throws IOException {
        List<GameItem> gameItemList = gameItemService.readGameItemByTheme(theme);
        responseGameItemListAsJson(resp, gameItemList);
    }

    private void routePutMethod(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        String path = pathInfo.split("/")[1];

        switch (path) {
            case "title" -> updateTotalWins(req, resp);
            default -> resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid endpoint.");
        }
    }

    private void updateTotalWins(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(req.getInputStream());
        long id = jsonNode.get("item_id").asLong();
        gameItemService.updateTotalWinsById(id);
    }
}
