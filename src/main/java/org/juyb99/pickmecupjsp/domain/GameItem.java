package org.juyb99.pickmecupjsp.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public record GameItem(@JsonProperty("id") long id,
                       @JsonProperty("resource_url") String resourceUrl,
                       @JsonProperty("title") String title,
                       @JsonProperty("total_wins") int totalWins,
                       @JsonProperty("category_theme") String category) {
}
