package org.juyb99.pickmecupjsp.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public record Category(@JsonProperty("id") long id, @JsonProperty("theme") String theme,
                       @JsonProperty("item_type") ItemType itemType,
                       @JsonProperty("play_count") int playCount, @JsonProperty("theme_img_url") String themeImgUrl) {
}
