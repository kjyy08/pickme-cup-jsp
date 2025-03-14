package org.juyb99.pickmecupjsp.common.repository;

import org.juyb99.pickmecupjsp.common.Exception.APIException;
import org.juyb99.pickmecupjsp.dto.httpclient.APIClientParam;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Optional;
import java.util.logging.Logger;

public abstract class Repository {
    protected final Logger logger;
    protected final HttpClient httpClient;

    protected Repository() {
        this.logger = Logger.getLogger(this.getClass().getName());
        this.httpClient = HttpClient.newBuilder().build();
        logger.info("Initializing API client");
    }

    /**
     * API 호출을 수행하고 응답 본문을 반환합니다.
     *
     * @param param API 요청 파라미터
     * @return API 응답 본문
     */
    protected Optional<String> requestAPI(APIClientParam param) {
        logger.info("Calling API client");
        HttpResponse<String> response;
        try {
            response = sendRequest(param);
            logger.info("\nstatusCode: " + response.statusCode());
            logger.info("\nbody: " + response.body());
        } catch (IOException | InterruptedException e) {
            handleApiError(e);
            return Optional.empty();
        }

        int statusCode = response.statusCode();
        if (statusCode >= 400) {
            throw new APIException(statusCode, response.body());
        }

        return Optional.of(response.body());
    }

    /**
     * HTTP 요청을 생성하고 전송합니다.
     *
     * @param param API 요청 파라미터 객체
     * @return HTTP 응답 객체
     * @throws IOException, InterruptedException 전송 중 발생하는 예외
     */
    protected HttpResponse<String> sendRequest(APIClientParam param) throws IOException, InterruptedException {
        HttpRequest.BodyPublisher bodyPublisher;

        if (param.body() instanceof byte[]) {
            bodyPublisher = HttpRequest.BodyPublishers.ofByteArray((byte[]) param.body());
        } else if (param.body() instanceof String) {
            bodyPublisher = HttpRequest.BodyPublishers.ofString((String) param.body());
        } else {
            throw new IllegalArgumentException("Unsupported request body type");
        }

        return httpClient.send(HttpRequest.newBuilder()
                .uri(URI.create(param.url()))
                .method(param.method().getName(), bodyPublisher)
                .headers(param.headers())
                .build(), HttpResponse.BodyHandlers.ofString());
    }

    /**
     * API 호출 중 발생한 예외를 처리합니다.
     *
     * @param e 발생한 예외
     */
    protected void handleApiError(Exception e) {
        logger.severe(e.getMessage());
    }
}
