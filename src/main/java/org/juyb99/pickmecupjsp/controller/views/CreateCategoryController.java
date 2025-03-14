package org.juyb99.pickmecupjsp.controller.views;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.controller.Controller;

import java.io.IOException;

@WebServlet("/create-category")
public class CreateCategoryController extends Controller {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        view(req, resp, "category-create");
    }
}
