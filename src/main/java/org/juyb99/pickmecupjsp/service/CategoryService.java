package org.juyb99.pickmecupjsp.service;

import jakarta.servlet.ServletContext;
import lombok.Getter;
import org.juyb99.pickmecupjsp.common.config.CustomServletContextListener;
import org.juyb99.pickmecupjsp.domain.Category;
import org.juyb99.pickmecupjsp.dto.request.CategoryRequestDTO;
import org.juyb99.pickmecupjsp.repository.CategoryRepository;

import java.util.List;

public class CategoryService {
    @Getter
    private final static CategoryService instance = new CategoryService();
    private final CategoryRepository categoryRepository;

    private CategoryService() {
        ServletContext servletContext = CustomServletContextListener.getServletContext();
        categoryRepository = (CategoryRepository) servletContext.getAttribute("CategoryRepository");
    }

    public List<Category> readAllCategories() {
        return categoryRepository.findAll();
    }

    public Category readCategoryByTheme(String theme) {
        return categoryRepository.findByTheme(theme);
    }

    public Category saveCategory(CategoryRequestDTO categoryRequestDTO) {
        return categoryRepository.save(categoryRequestDTO);
    }

}
