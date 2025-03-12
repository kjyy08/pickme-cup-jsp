package org.juyb99.pickmecupjsp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.controller.BaseController;

import java.io.IOException;

@WebServlet("/")
public class HomeController extends BaseController {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        view(req, resp, "index");
    }
}
