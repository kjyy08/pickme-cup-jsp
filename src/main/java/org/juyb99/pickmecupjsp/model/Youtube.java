package org.juyb99.pickmecupjsp.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public record Youtube(@JsonProperty("id") long id, @JsonProperty("youtube_link") String youtubeLink,
                      @JsonProperty("title") String title,
                      @JsonProperty("total_wins") int totalWins,
                      @JsonProperty("category_theme") String category) {
}
