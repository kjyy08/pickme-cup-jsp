package org.juyb99.pickmecupjsp.common.config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import lombok.Getter;
import org.juyb99.pickmecupjsp.repository.GeminiRepository;
import org.juyb99.pickmecupjsp.repository.YoutubeRepository;
import org.juyb99.pickmecupjsp.service.GeminiService;
import org.juyb99.pickmecupjsp.service.YoutubeService;

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
        sce.getServletContext().setAttribute("YoutubeRepository", YoutubeRepository.getInstance());
        sce.getServletContext().setAttribute("YoutubeService", YoutubeService.getInstance());

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Servlet context destroyed.");
    }
}