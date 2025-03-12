package org.juyb99.pickmecupjsp.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.BaseController;
import org.juyb99.pickmecupjsp.domain.Youtube;
import org.juyb99.pickmecupjsp.service.YoutubeService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/youtube/*")
public class YoutubeController extends BaseController {
    private final YoutubeService youtubeService;

    public YoutubeController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        youtubeService = (YoutubeService) servletContext.getAttribute("YoutubeService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        String requestUri = req.getRequestURI();


        if (pathInfo != null) {
            routeYoutubeRequest(req, resp);
            return;
        }

        List<Youtube> youtubeList = youtubeService.readYoutubeByAll();
        responseYoutubeListAsJson(resp, youtubeList);
    }

    private void responseYoutubeListAsJson(HttpServletResponse resp, List<Youtube> youtubeList) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(JsonUtil.toJson(youtubeList));
    }

    private void routeYoutubeRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); // 예: "/theme/3" 또는 "/title/아이돌"
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
        List<Youtube> youtubeList = youtubeService.readYoutubeByTitle(title);
        responseYoutubeListAsJson(resp, youtubeList);
    }

    private void requestThemeAPI(HttpServletResponse resp, String theme) throws IOException {
        List<Youtube> youtubeList = youtubeService.readYoutubeByTheme(theme);
        responseYoutubeListAsJson(resp, youtubeList);
    }
}
