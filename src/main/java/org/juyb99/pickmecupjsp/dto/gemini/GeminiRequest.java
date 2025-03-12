package org.juyb99.pickmecupjsp.dto.gemini;

import lombok.Builder;

import java.util.List;

@Builder
public record GeminiRequest(List<Content> contents, SystemInstruction systemInstruction,
                            GenerationConfig generationConfig) {

    public record Content(List<Part> parts) {
        public Content(String text) {
            this(List.of(new Part(text)));
        }
    }

    /**
     * Gemini 시스템 안내를 설정하는 클래스
     *
     * @param parts
     */
    public record SystemInstruction(String role, List<Part> parts) {
        public SystemInstruction() {
            this("user", List.of(new Part("use korean, no markdown")));
        }

        public static SystemInstruction of(String text) {
            return new SystemInstruction("user", List.of(new Part(text)));
        }
    }

    /**
     * Gemini 출력 옵션을 설정하는 클래스
     *
     * @param temperature
     * @param topK
     * @param topP
     * @param maxOutputTokens
     * @param responseMimeType
     */
    public record GenerationConfig(float temperature, int topK, float topP, int maxOutputTokens,
                                   String responseMimeType) {
        public GenerationConfig() {
            this(1.0f, 40, 0.95f, 8192, "text/plain");
        }
    }

    public record Part(String text) {
    }
}
