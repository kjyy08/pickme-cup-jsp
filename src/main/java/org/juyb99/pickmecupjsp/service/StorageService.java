package org.juyb99.pickmecupjsp.service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;
import org.juyb99.pickmecupjsp.common.Exception.APIException;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.repository.StorageRepository;

public class StorageService {
    @Getter
    private final static StorageService instance = new StorageService();
    private final StorageRepository storageRepository;

    private StorageService() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        storageRepository = (StorageRepository) servletContext.getAttribute("StorageRepository");
    }

    public String uploadImage(String fileName, byte[] imageBytes) {
        return storageRepository.uploadImage(fileName, imageBytes)
                .orElseThrow(() -> new APIException(HttpServletResponse.SC_BAD_REQUEST, "Failed to upload image"));
    }
}
