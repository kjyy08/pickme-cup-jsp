package org.juyb99.pickmecupjsp.common.Exception;

import lombok.Getter;

@Getter
public class APIException extends RuntimeException {
    private final int statusCode;

    public APIException(int statusCode, String message) {
        super("API 요청 실패 - " + statusCode + ": " + message);
        this.statusCode = statusCode;
    }
}
