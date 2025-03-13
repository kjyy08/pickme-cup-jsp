package org.juyb99.pickmecupjsp.service;

import jakarta.servlet.ServletContext;
import lombok.Getter;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.domain.Youtube;
import org.juyb99.pickmecupjsp.repository.YoutubeRepository;

import java.util.List;

public class YoutubeService {
    @Getter
    private final static YoutubeService instance = new YoutubeService();
    private final YoutubeRepository youtubeRepository;

    private YoutubeService() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        youtubeRepository = (YoutubeRepository) servletContext.getAttribute("YoutubeRepository");
    }

    public List<Youtube> readYoutubeByAll() {
        List<Youtube> youtubeList = youtubeRepository.findByAll();
        return youtubeList;
    }

    public List<Youtube> readYoutubeByTheme(String theme) {
        List<Youtube> youtubeList = youtubeRepository.findByTheme(theme);
        return youtubeList;
    }

    public List<Youtube> readYoutubeByTitle(String title) {
        List<Youtube> youtubeList = youtubeRepository.findByTitle(title);
        return youtubeList;
    }

    public void updateTotalWinsById(long id) {
        youtubeRepository.updateTotalWinsById(id);
    }
}
