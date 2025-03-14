package org.juyb99.pickmecupjsp.controller.api;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.Controller;
import org.juyb99.pickmecupjsp.service.GeminiService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/api/llm/gemini")
public class GeminiController extends Controller {
    private final GeminiService geminiService;

    public GeminiController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        geminiService = (GeminiService) servletContext.getAttribute("GeminiService");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession httpSession = req.getSession();
        String winner = (String) httpSession.getAttribute("winner");
        List<String> promptList = geminiService.runPromptChaining(
                "이상형 월드컵 우승자 %s의 소개, 특징, 성과 등을 포함해서 볼드체와 리스트 기호를 사용하지 않고 5줄의 일반 텍스트를 작성해주세요.".formatted(winner),
                "%s와 관련없는 내용은 응답하지 마세요.".formatted(winner));
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().println(JsonUtil.toJson(promptList));
    }
}
