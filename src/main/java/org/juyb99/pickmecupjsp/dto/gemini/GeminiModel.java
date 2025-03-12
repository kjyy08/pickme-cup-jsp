package org.juyb99.pickmecupjsp.dto.gemini;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public enum GeminiModel {
    BASE("gemini-2.0-flash"), REASONING("gemini-2.0-flash-thinking-exp-01-21");

    private final String name;

    GeminiModel(String name) {
        this.name = name;
    }
}
