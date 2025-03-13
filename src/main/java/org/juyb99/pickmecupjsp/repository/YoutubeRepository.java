package org.juyb99.pickmecupjsp.repository;

import io.github.cdimascio.dotenv.Dotenv;
import lombok.Getter;
import org.juyb99.pickmecupjsp.domain.Youtube;
import org.juyb99.pickmecupjsp.dto.httpclient.APIClientParam;
import org.juyb99.pickmecupjsp.dto.httpclient.HttpMethod;
import org.juyb99.pickmecupjsp.util.httpclient.APIClient;
import org.juyb99.pickmecupjsp.util.json.JsonUtil;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class YoutubeRepository extends APIClient {
    private final String SUPABASE_URL = "https://%s.supabase.co/rest/v1/"
            .formatted(Dotenv.configure().ignoreIfMissing().load().get("SUPABASE_PROJECT_URL"));
    private final String SUPABASE_API_KEY = Dotenv.configure().ignoreIfMissing().load().get("SUPABASE_API_KEY");
    private static final Logger logger = Logger.getLogger(YoutubeRepository.class.getName());

    @Getter
    private final static YoutubeRepository instance = new YoutubeRepository();

    public static void main(String[] args) {
        YoutubeRepository youtubeRepository = new YoutubeRepository();
        List<Youtube> youtube = youtubeRepository.findByTitle("tripleS - Girls Never Die");
        logger.info(youtube.toString());
        youtubeRepository.updateTotalWinsById(4);
    }

    public List<Youtube> findByAll() {
        String query = "select=*,category(*)";
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "youtube?%s".formatted(query))
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJsonList(response, Youtube.class);
    }

    public Youtube findById(long id) {
        String query = "id=eq.%s".formatted(id);
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "youtube?%s".formatted(query))
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJson(response, Youtube.class);
    }

    public List<Youtube> findByTitle(String title) {
        String query = "select=*&title=eq.%s".formatted(URLEncoder.encode(title, StandardCharsets.UTF_8));
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "youtube?%s".formatted(query))
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJsonList(response, Youtube.class);
    }

    public List<Youtube> findByTheme(String theme) {
        String query = "select=*&category_theme=eq.%s".formatted(URLEncoder.encode(theme, StandardCharsets.UTF_8));
        String response = requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "youtube?%s".formatted(query)) // TODO: 하.. supabase 조인 드럽게 복잡하네. 문서 어딨냐 대체...
                .method(HttpMethod.GET)
                .body("")
                .headers(new String[]{"apikey", SUPABASE_API_KEY, "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY)})
                .build()).orElseThrow(() -> new RuntimeException("Supabase API request failed"));

        return JsonUtil.fromJsonList(response, Youtube.class);
    }

    public void updateTotalWinsById(long id) {
        String body = JsonUtil.toJson(Map.of("youtube_id", id));
        requestAPI(APIClientParam.builder()
                .url(SUPABASE_URL + "rpc/increment_total_wins")
                .method(HttpMethod.POST)
                .body(body)
                .headers(new String[]{
                        "apikey", SUPABASE_API_KEY,
                        "Authorization", "Bearer %s".formatted(SUPABASE_API_KEY),
                        "Content-Type", "application/json"
                })
                .build()).orElseThrow(() -> new RuntimeException("Supabase RPC request failed"));
    }
}
