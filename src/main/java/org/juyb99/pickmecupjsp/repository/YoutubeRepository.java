package org.juyb99.pickmecupjsp.repository;

import io.github.cdimascio.dotenv.Dotenv;
import lombok.Getter;
import org.juyb99.pickmecupjsp.dto.httpclient.APIClientParam;
import org.juyb99.pickmecupjsp.dto.httpclient.HttpMethod;
import org.juyb99.pickmecupjsp.model.Youtube;
import org.juyb99.pickmecupjsp.util.httpclient.APIClient;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class YoutubeRepository extends APIClient {
    private final String SUPABASE_URL = "https://%s.supabase.co/rest/v1/youtube"
            .formatted(Dotenv.configure().ignoreIfMissing().load().get("SUPABASE_PROJECT_URL"));
    private final String SUPABASE_API_KEY = Dotenv.configure().ignoreIfMissing().load().get("SUPABASE_API_KEY");
    private static final Logger logger = Logger.getLogger(YoutubeRepository.class.getName());

    @Getter
    private final static YoutubeRepository instance = new YoutubeRepository();

    public static void main(String[] args) {
        YoutubeRepository youtubeRepository = new YoutubeRepository();
        List<Youtube> youtube = youtubeRepository.findByAll();
        logger.info(youtube.toString());
    }

    public List<Youtube> findByAll() {
        String query = URLEncoder.encode("select=*,category(*)", StandardCharsets.UTF_8);
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "?%s".formatted(query))
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJsonList(response, Youtube.class);
    }

    public Youtube findById(long id) {
        String query = URLEncoder.encode("id=eq.%s".formatted(id), StandardCharsets.UTF_8);
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "?%s".formatted(query))
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJson(response, Youtube.class);
    }

    public List<Youtube> findByTitle(String title) {
        String query = URLEncoder.encode("select=*,category(*)", StandardCharsets.UTF_8);
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "?%s".formatted(query))
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJsonList(response, Youtube.class)
                .stream().filter((youtube) -> youtube.title().equals(title)).collect(Collectors.toList());
    }

    public List<Youtube> findByTheme(String theme) {
        String query = URLEncoder.encode("select=*,category(*)", StandardCharsets.UTF_8);
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "?%s".formatted(query)) // TODO: 하.. supabase 조인 드럽게 복잡하네. 문서 어딨냐 대체...
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJsonList(response, Youtube.class)
                .stream().filter((youtube) -> youtube.category().equals(theme)).collect(Collectors.toList());
    }
}
