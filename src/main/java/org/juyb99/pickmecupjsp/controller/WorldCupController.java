package org.juyb99.pickmecupjsp.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.BaseController;
import org.juyb99.pickmecupjsp.model.Youtube;
import org.juyb99.pickmecupjsp.service.YoutubeService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/worldcup")
public class WorldCupController extends BaseController {
    private final YoutubeService youtubeService;

    public WorldCupController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        youtubeService = (YoutubeService) servletContext.getAttribute("YoutubeService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String category = req.getParameter("category");
        HttpSession session = req.getSession();

        if (category == null) {
            category = URLEncoder.encode("아이돌", StandardCharsets.UTF_8);
        }

//        List<Youtube> youtubeList = youtubeService.readYoutubeByTheme(category);
//        session.setAttribute("youtubeList", youtubeList);
        view(req, resp, "worldcup");
    }
}
