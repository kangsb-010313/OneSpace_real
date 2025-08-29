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

    // ===== HTTP 통신 유틸 =====
    private final RestTemplate rest = new RestTemplate();
    private final ObjectMapper om = new ObjectMapper();

    /* ===== Kakao API Key 주입 (application.properties에서 가져옴) ===== */
    @Value("${kakao.rest-api-key}")
    private String kakaoRestApiKey;

    @Value("${kakao.redirect-uri}")
    private String kakao_redirect_uri;  // 서비스에서만 관리 / redirect_uri (authorize & token 요청 동일하게)

    @Value("${kakao.client-secret:}")
    private String kakaoClientSecret;   // client_secret (선택)

    /* ===== 회원가입/로그인(기존) ===== */
    public int exeJoin(UserVO userVO) {
        System.out.println("UserServic.exeJoin()");
        return userRepository.userInsert(userVO);
    }

    public UserVO exeLogin(UserVO userVO) {
        System.out.println("UserService.exeLogin()");
        return userRepository.userSelectOneByIdPw(userVO);
    }
    
    /* ===================== 카카오 OAuth 로그인 ===================== */

    /* ===== 카카오: authorize URL 생성 (컨트롤러에서 호출) ===== */
    public String kakaoBuildAuthorizeUrl() {
        System.out.println("[KAKAO] authorize.redirect_uri = " + kakao_redirect_uri); // 디버깅용
        return UriComponentsBuilder
                .fromHttpUrl("https://kauth.kakao.com/oauth/authorize")
                .queryParam("client_id", kakaoRestApiKey) 		  // 앱 REST API 키
                .queryParam("redirect_uri", kakao_redirect_uri)  // 콜백 URI / 토큰요청과 동일
                .queryParam("response_type", "code")			// authorization code 방식
                .build(true)
                .toUriString();
    }

    /* ===== 2) 카카오 로그인 처리 (인가 코드 받아서 DB 처리까지) ===== */
    public UserVO exeLoginKakao(String code) {
        System.out.println("UserService.exeLoginKakao() code=" + code);
        System.out.println("[KAKAO] token.redirect_uri = " + kakao_redirect_uri);

        // 2-1) 인가 코드 → Access Token 발급
        String accessToken = getKakaoAccessToken(code);

        // 2-2) Access Token → 사용자 정보 조회
        KakaoUser ku = getKakaoUser(accessToken);

        // 2-3) DB upsert (kakaoId 기준)
        UserVO found = userRepository.findByKakaoId(String.valueOf(ku.id));
        if (found == null) {
        	// 신규 회원가입
            UserVO toInsert = new UserVO();
            toInsert.setKakaoId(String.valueOf(ku.id));
            toInsert.setUserId("kakao_" + ku.id);	// 내부 userId 대체값
            toInsert.setUserName(ku.nickname != null ? ku.nickname : "kakao_user");
            toInsert.setEmail(ku.email);
            userRepository.insertKakaoUser(toInsert);
            // 삽입 후 다시 조회
            found = userRepository.findByKakaoId(String.valueOf(ku.id));
        } else {
        	// 기존 회원 → 닉네임/이메일 최신화
            found.setUserName(ku.nickname != null ? ku.nickname : found.getUserName());
            if (ku.email != null && !ku.email.isEmpty()) {
                found.setEmail(ku.email);
            }
            userRepository.updateKakaoUser(found);
        }
        return found;
    }

    /* ===== Kakao OAuth Helpers ===== */

    /** 인가 코드(code) → Access Token 요청 */
    private String getKakaoAccessToken(String code) {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";

        // 요청 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.setAcceptCharset(java.util.List.of(StandardCharsets.UTF_8));

        // 요청 바디 (폼 데이터)
        MultiValueMap<String, String> form = new LinkedMultiValueMap<>();
        form.add("grant_type", "authorization_code");
        form.add("client_id", kakaoRestApiKey);
        form.add("redirect_uri", kakao_redirect_uri);  // authorize와 동일
        form.add("code", code);
        if (kakaoClientSecret != null && !kakaoClientSecret.isBlank()) {
            form.add("client_secret", kakaoClientSecret);
        }

        HttpEntity<MultiValueMap<String, String>> req = new HttpEntity<>(form, headers);

        try {
        	// POST 요청
            ResponseEntity<String> res = rest.postForEntity(tokenUrl, req, String.class);
            if (!res.getStatusCode().is2xxSuccessful()) {
                throw new IllegalStateException("kakao token http error: " + res.getStatusCode());
            }
            // JSON 파싱
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

    /** Access Token → 사용자 정보 조회 */
    private KakaoUser getKakaoUser(String accessToken) {
        String meUrl = "https://kapi.kakao.com/v2/user/me";

        // 요청 헤더 (Bearer 토큰)
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);

        HttpEntity<Void> req = new HttpEntity<>(headers);

        try {
        	// GET 요청
            ResponseEntity<String> res = rest.exchange(meUrl, HttpMethod.GET, req, String.class);
            if (!res.getStatusCode().is2xxSuccessful()) {
                throw new IllegalStateException("kakao me http error: " + res.getStatusCode());
            }
            // JSON 파싱
            JsonNode root = om.readTree(res.getBody());

            long id = root.path("id").asLong();
            JsonNode account = root.path("kakao_account");
            String email = account.path("email").asText(null);

            String nickname = null;
            JsonNode profile = account.path("profile");
            if (profile.isObject()) {
                nickname = profile.path("nickname").asText(null);
            }

            // DTO 생성
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

    /* ===================== 내부 DTO ===================== */
    // 카카오에서 가져온 사용자 정보를 임시 저장할 DTO
    private static class KakaoUser {
        long   id;			// 카카오 고유 ID
        String email;		// 이메일
        String nickname;	// 닉네임
    }
}
