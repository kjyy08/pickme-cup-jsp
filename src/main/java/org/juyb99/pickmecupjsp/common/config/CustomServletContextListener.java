package org.juyb99.pickmecupjsp.common.config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import lombok.Getter;
import org.juyb99.pickmecupjsp.repository.CategoryRepository;
import org.juyb99.pickmecupjsp.repository.GameItemRepository;
import org.juyb99.pickmecupjsp.repository.GeminiRepository;
import org.juyb99.pickmecupjsp.repository.StorageRepository;
import org.juyb99.pickmecupjsp.service.CategoryService;
import org.juyb99.pickmecupjsp.service.GameItemService;
import org.juyb99.pickmecupjsp.service.GeminiService;
import org.juyb99.pickmecupjsp.service.StorageService;

@WebListener
public class CustomServletContextListener implements ServletContextListener {
    @Getter
    private static ServletContext servletContext;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Servlet context initialized.");
        servletContext = sce.getServletContext();
        registerServicesInContext(sce);
    }

    private void registerServicesInContext(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("GeminiRepository", GeminiRepository.getInstance());
        sce.getServletContext().setAttribute("GeminiService", GeminiService.getInstance());
        sce.getServletContext().setAttribute("GameItemRepository", GameItemRepository.getInstance());
        sce.getServletContext().setAttribute("GameItemService", GameItemService.getInstance());
        sce.getServletContext().setAttribute("CategoryRepository", CategoryRepository.getInstance());
        sce.getServletContext().setAttribute("CategoryService", CategoryService.getInstance());
        sce.getServletContext().setAttribute("StorageRepository", StorageRepository.getInstance());
        sce.getServletContext().setAttribute("StorageService", StorageService.getInstance());

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Servlet context destroyed.");
    }
}