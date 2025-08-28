package com.javaex.service;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.javaex.repository.UserRepository;
import com.javaex.vo.UserVO;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private final RestTemplate rest = new RestTemplate();
    private final ObjectMapper om = new ObjectMapper();

    /* ===== Kakao API Key 주입 (서비스에서만 사용) ===== */
    @Value("${kakao.rest-api-key}")
    private String kakaoRestApiKey;

    @Value("${kakao.redirect-uri}")
    private String kakao_redirect_uri;  // ★ 서비스에서만 관리

    @Value("${kakao.client-secret:}")
    private String kakaoClientSecret;   // 옵션

    /* ===== 회원가입/로그인(기존) ===== */
    public int exeJoin(UserVO userVO) {
        System.out.println("UserServic.exeJoin()");
        return userRepository.userInsert(userVO);
    }

    public UserVO exeLogin(UserVO userVO) {
        System.out.println("UserService.exeLogin()");
        return userRepository.userSelectOneByIdPw(userVO);
    }

    /* ===== 카카오: authorize URL 생성 (컨트롤러에서 호출) ===== */
    public String kakaoBuildAuthorizeUrl() {
        System.out.println("[KAKAO] authorize.redirect_uri = " + kakao_redirect_uri); // 디버깅용
        return UriComponentsBuilder
                .fromHttpUrl("https://kauth.kakao.com/oauth/authorize")
                .queryParam("client_id", kakaoRestApiKey)
                .queryParam("redirect_uri", kakao_redirect_uri)  // ★ 토큰요청과 동일
                .queryParam("response_type", "code")
                .build(true)
                .toUriString();
    }

    /* ===== 카카오 로그인 처리 ===== */
    public UserVO exeLoginKakao(String code) {
        System.out.println("UserService.exeLoginKakao() code=" + code);
        System.out.println("[KAKAO] token.redirect_uri = " + kakao_redirect_uri);

        // 1) 토큰 발급
        String accessToken = getKakaoAccessToken(code);

        // 2) 유저 정보 조회
        KakaoUser ku = getKakaoUser(accessToken);

        // 3) upsert (kakaoId 기준)
        UserVO found = userRepository.findByKakaoId(String.valueOf(ku.id));
        if (found == null) {
            UserVO toInsert = new UserVO();
            toInsert.setKakaoId(String.valueOf(ku.id));
            toInsert.setUserId("kakao_" + ku.id);
            toInsert.setUserName(ku.nickname != null ? ku.nickname : "kakao_user");
            toInsert.setEmail(ku.email);
            userRepository.insertKakaoUser(toInsert);
            found = userRepository.findByKakaoId(String.valueOf(ku.id));
        } else {
            found.setUserName(ku.nickname != null ? ku.nickname : found.getUserName());
            if (ku.email != null && !ku.email.isEmpty()) {
                found.setEmail(ku.email);
            }
            userRepository.updateKakaoUser(found);
        }
        return found;
    }

    /* ===== Kakao OAuth Helpers ===== */

    private String getKakaoAccessToken(String code) {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAcceptCharset(java.util.List.of(StandardCharsets.UTF_8));

        MultiValueMap<String, String> form = new LinkedMultiValueMap<>();
        form.add("grant_type", "authorization_code");
        form.add("client_id", kakaoRestApiKey);
        form.add("redirect_uri", kakao_redirect_uri);  // ★ authorize와 동일
        form.add("code", code);
        if (kakaoClientSecret != null && !kakaoClientSecret.isBlank()) {
            form.add("client_secret", kakaoClientSecret);
        }

        HttpEntity<MultiValueMap<String, String>> req = new HttpEntity<>(form, headers);

        try {
            ResponseEntity<String> res = rest.postForEntity(tokenUrl, req, String.class);
            if (!res.getStatusCode().is2xxSuccessful()) {
                throw new IllegalStateException("kakao token http error: " + res.getStatusCode());
            }
            JsonNode root = om.readTree(res.getBody());
            String accessToken = root.path("access_token").asText(null);
            if (accessToken == null) throw new IllegalStateException("no access_token in kakao response");
            return accessToken;
        } catch (RestClientException | IllegalStateException e) {
            throw new RuntimeException("failed to get kakao access token", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private KakaoUser getKakaoUser(String accessToken) {
        String meUrl = "https://kapi.kakao.com/v2/user/me";

        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);

        HttpEntity<Void> req = new HttpEntity<>(headers);

        try {
            ResponseEntity<String> res = rest.exchange(meUrl, HttpMethod.GET, req, String.class);
            if (!res.getStatusCode().is2xxSuccessful()) {
                throw new IllegalStateException("kakao me http error: " + res.getStatusCode());
            }
            JsonNode root = om.readTree(res.getBody());

            long id = root.path("id").asLong();
            JsonNode account = root.path("kakao_account");
            String email = account.path("email").asText(null);

            String nickname = null;
            JsonNode profile = account.path("profile");
            if (profile.isObject()) {
                nickname = profile.path("nickname").asText(null);
            }

            KakaoUser ku = new KakaoUser();
            ku.id = id;
            ku.email = email;
            ku.nickname = nickname;
            return ku;
        } catch (RestClientException | IllegalStateException e) {
            throw new RuntimeException("failed to fetch kakao user", e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // 간단 DTO
    private static class KakaoUser {
        long   id;
        String email;
        String nickname;
    }
}
