package org.juyb99.pickmecupjsp.service;

import jakarta.servlet.ServletContext;
import lombok.Getter;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.domain.GameItem;
import org.juyb99.pickmecupjsp.dto.request.GameItemRequestDTO;
import org.juyb99.pickmecupjsp.repository.GameItemRepository;

import java.util.List;
import java.util.stream.Collectors;

public class GameItemService {
    @Getter
    private final static GameItemService instance = new GameItemService();
    private final GameItemRepository gameItemRepository;

    private GameItemService() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        gameItemRepository = (GameItemRepository) servletContext.getAttribute("GameItemRepository");
    }

    public List<GameItem> readAllGameItem() {
        return gameItemRepository.findAll();
    }

    public List<GameItem> readGameItemByTheme(String theme) {
        return gameItemRepository.findByTheme(theme);
    }

    public List<GameItem> readGameItemByTitle(String title) {
        return gameItemRepository.findByTitle(title);
    }

    public List<GameItem> saveItem(List<GameItemRequestDTO> gameItemRequestDTO) {
        return gameItemRequestDTO.stream()
                .map(gameItemRepository::save)
                .collect(Collectors.toList());
    }

    public void updateTotalWinsById(long id) {
        gameItemRepository.updateTotalWinsById(id);
    }
}
