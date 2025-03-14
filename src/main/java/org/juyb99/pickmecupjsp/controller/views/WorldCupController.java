package org.juyb99.pickmecupjsp.controller.views;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.Controller;
import org.juyb99.pickmecupjsp.service.GameItemService;

import java.io.IOException;

@WebServlet("/worldcup")
public class WorldCupController extends Controller {
    private final GameItemService gameItemService;

    public WorldCupController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        gameItemService = (GameItemService) servletContext.getAttribute("YoutubeService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        view(req, resp, "worldcup");
    }
}
