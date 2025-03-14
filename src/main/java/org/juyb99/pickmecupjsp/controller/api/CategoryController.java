package org.juyb99.pickmecupjsp.controller.api;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.Exception.APIException;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.Controller;
import org.juyb99.pickmecupjsp.dto.request.CategoryRequestDTO;
import org.juyb99.pickmecupjsp.service.CategoryService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet("/api/category")
public class CategoryController extends Controller {
    private final CategoryService categoryService;
    private final Logger logger = Logger.getLogger(this.getClass().getName());

    public CategoryController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        categoryService = (CategoryService) servletContext.getAttribute("CategoryService");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestBody = req.getReader().lines().collect(Collectors.joining());

        try {
            CategoryRequestDTO categoryRequestDTO = JsonUtil.fromJson(requestBody, CategoryRequestDTO.class);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().println(JsonUtil.toJson(categoryService.saveCategory(categoryRequestDTO)));
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
}
