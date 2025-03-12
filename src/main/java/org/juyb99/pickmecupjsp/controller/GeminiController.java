package org.juyb99.pickmecupjsp.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.BaseController;
import org.juyb99.pickmecupjsp.service.GeminiService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/api/llm/gemini")
public class GeminiController extends BaseController {
    private final GeminiService geminiService;

    public GeminiController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        geminiService = (GeminiService) servletContext.getAttribute("GeminiService");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession httpSession = req.getSession();
        String winner = req.getParameter("winner");
        List<String> promptList = geminiService.runPromptChaining(
                "아이돌 %s의 소개, 특징, 성과, 대표곡 등을 포함해서 볼드체와 리스트 기호를 사용하지 않고 5줄의 일반 텍스트를 작성해주세요.".formatted(winner),
                "다른 대표곡을 5곡정도 { artist: title } 형식으로 가수 이름과 곡의 제목만 출력하고 볼드체와 리스트 기호를 사용하지 않고 일반 텍스트로 작성해주세요.");
//        req.setAttribute("promptList", promptList);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(JsonUtil.toJson(promptList));

    }
}
