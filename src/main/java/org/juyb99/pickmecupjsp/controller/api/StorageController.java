package org.juyb99.pickmecupjsp.controller.api;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.juyb99.pickmecupjsp.common.Exception.APIException;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.common.controller.Controller;
import org.juyb99.pickmecupjsp.service.StorageService;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 15,      // 최대 파일 크기 15MB
        maxRequestSize = 1024 * 1024 * 50    // 전체 요청 최대 크기 50MB
)
@WebServlet("/s3/images")
public class StorageController extends Controller {
    private final StorageService storageService;

    public StorageController() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        storageService = (StorageService) servletContext.getAttribute("StorageService");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("file");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        fileName = generateUUIDFileName(fileName);
        byte[] imageBytes = convertToByteArray(filePart);

        try {
            String imageUrl = storageService.uploadImage(fileName, imageBytes);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().println(JsonUtil.toJson(Map.of("imgUrl", imageUrl)));
            resp.getWriter().flush();
            resp.getWriter().close();
        } catch (APIException e) {
            resp.setStatus(e.getStatusCode());
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"서버 내부 오류가 발생했습니다.\"}");
        }
    }

    // 기존 확장자를 유지하고 UUID로 파일 이름 변경
    private String generateUUIDFileName(String originalFileName) {
        String uuid = UUID.randomUUID().toString(); // 랜덤 UUID 생성
        String extension = "";

        int dotIndex = originalFileName.lastIndexOf(".");
        if (dotIndex != -1) {
            extension = originalFileName.substring(dotIndex); // 확장자 추출 (예: .jpg, .png)
        }

        return uuid + extension; // UUID + 기존 확장자
    }

    private byte[] convertToByteArray(Part part) throws IOException {
        try (InputStream in = part.getInputStream()) {
            return in.readAllBytes();
        }
    }
}
