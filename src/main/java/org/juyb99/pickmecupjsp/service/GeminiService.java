package org.juyb99.pickmecupjsp.service;

import jakarta.servlet.ServletContext;
import lombok.Getter;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.dto.gemini.GeminiModel;
import org.juyb99.pickmecupjsp.dto.gemini.GeminiRequest;
import org.juyb99.pickmecupjsp.repository.GeminiRepository;

import java.util.ArrayList;
import java.util.List;

public class GeminiService {
    @Getter
    private final static GeminiService instance = new GeminiService();
    private final GeminiRepository geminiRepository;

    private GeminiService() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        geminiRepository = (GeminiRepository) servletContext.getAttribute("GeminiRepository");
    }

    public List<String> runPromptChaining(String... prompts) {
        // 첫 번째 프롬프트에 대해 Gemini API 호출
        List<String> promptList = new ArrayList<>();
        String respoonse = requestGeminiModel(prompts[0]);//.replace("**", "").replace("*", "\n");
        promptList.add(respoonse);

        // 두 번째 프롬프트부터 순차적으로 체이닝
        for (int i = 1; i < prompts.length; i++) {
            String promptText = "%s 를 바탕으로 %s 프롬프트를 수행하세요.".formatted(respoonse, prompts[i]);
            respoonse = requestGeminiModel(promptText);//.replace("**", "").replace("*", "\t");
            promptList.add(respoonse);
        }

        return promptList;
    }

    public String requestGeminiModel(String prompt) {
        return geminiRepository.requestGeminiAPI(prompt,
                GeminiModel.BASE,
                new GeminiRequest.SystemInstruction(),
                new GeminiRequest.GenerationConfig()
        ).candidates().get(0).content().parts().get(0).text();
    }
}
