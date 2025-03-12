package org.juyb99.pickmecupjsp.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public record Category(@JsonProperty("id") long id, @JsonProperty("theme") String theme) {
}
