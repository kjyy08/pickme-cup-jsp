package org.juyb99.pickmecupjsp.dto.httpclient;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public enum HttpMethod {
    GET("GET"), POST("POST"), PUT("PUT"), PATCH("PATCH"), DELETE("DELETE");

    private final String name;

    HttpMethod(String name) {
        this.name = name;
    }
}
