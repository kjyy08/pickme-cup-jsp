package org.juyb99.pickmecupjsp.controller.views;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.Controller;
import org.juyb99.pickmecupjsp.domain.Category;
import org.juyb99.pickmecupjsp.service.CategoryService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeController extends Controller {
    private final CategoryService categoryService;

    public HomeController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        this.categoryService = (CategoryService) servletContext.getAttribute("CategoryService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.readAllCategories();
        req.setAttribute("categories", JsonUtil.toJson(categories));
        view(req, resp, "index");
    }

}
