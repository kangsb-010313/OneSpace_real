package com.javaex.service;

import com.javaex.repository.PrideRepository;
import com.javaex.vo.PrideVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * [Service] 팀자랑(Pride)
 * - 기본: teamPostType 고정(원래처럼 팀자랑만 보이게)
 * - teamNo 필터(선택) 지원
 * - 목록/상세 + 이미지 번들
 */
@Service
@Transactional(readOnly = true)
public class PrideService {

    private final PrideRepository repo;

    // ⚠️ DB에 저장된 실제 값으로 맞추세요. ("TEAM_PRIDE" 또는 "팀자랑")
    private static final String DEFAULT_TYPE = "TEAM_PRIDE";

    public PrideService(PrideRepository repo) {
        this.repo = repo;
    }

    /** type 파라미터가 비면 기본값으로 고정 */
    private String normalizeType(String type) {
        return (type == null || type.isBlank()) ? null : type;
    }

    /* =======================
     *  목록(카드)
     * ======================= */

    /** 카드 리스트 (팀 필터 없음) */
    public List<PrideVO> getCards(int page, int size) {
        return getCards(null, page, size, DEFAULT_TYPE);
    }

    /** 카드 리스트 (팀 필터/타입 지원) */
    public List<PrideVO> getCards(Long teamNo, int page, int size, String type) {
        int safeSize = (size <= 0) ? 12 : size;
        int safePage = (page <= 0) ? 1 : page;
        int offset   = (safePage - 1) * safeSize;
        String t     = normalizeType(type);
        return repo.selectPrideCards(t, teamNo, safeSize, offset);
    }

    /** 총 개수 (팀 필터/타입 반영) */
    public int getTotalCount(Long teamNo, String type) {
        return repo.countPride(normalizeType(type), teamNo);
    }

    /** API용 페이징 응답 */
    public Map<String, Object> pageApiModel(Long teamNo, int page, int size, String type) {
        int safeSize = (size <= 0) ? 12 : size;
        int safePage = (page <= 0) ? 1 : page;
        int offset   = (safePage - 1) * safeSize;
        String t     = normalizeType(type);

        List<PrideVO> list = repo.selectPrideCards(t, teamNo, safeSize, offset);
        int total          = repo.countPride(t, teamNo);

        Map<String, Object> res = new HashMap<>();
        res.put("list", list);
        res.put("totalCount", total);
        res.put("page", safePage);
        res.put("size", safeSize);
        res.put("hasMore", safePage * safeSize < total);
        return res;
    }

    /** JSP 렌더링용 페이징 모델 */
    public Map<String, Object> getPridePage(String type, Long teamNo, int page, int size) {
        String t     = normalizeType(type);
        int safeSize = (size <= 0) ? 12 : size;

        int total = repo.countPride(t, teamNo);
        int totalPages = Math.max(1, (int) Math.ceil(total / (double) safeSize));
        int safePage   = Math.min(Math.max(page, 1), totalPages);
        int offset     = (safePage - 1) * safeSize;

        List<PrideVO> content = repo.selectPrideCards(t, teamNo, safeSize, offset);

        int blockSize = 5;
        int startPage = ((safePage - 1) / blockSize) * blockSize + 1;
        int endPage   = Math.min(startPage + blockSize - 1, totalPages);

        Map<String, Object> model = new HashMap<>();
        model.put("content", content);
        model.put("page", safePage);
        model.put("size", safeSize);
        model.put("totalElements", total);
        model.put("totalPages", totalPages);
        model.put("hasPrev", safePage > 1);
        model.put("hasNext", safePage < totalPages);
        model.put("startPage", startPage);
        model.put("endPage", endPage);
        model.put("teamNo", teamNo);
        model.put("teamPostType", t);
        return model;
    }

    /* =======================
     *  상세 + 이미지
     * ======================= */

    public PrideVO getDetail(String type, Long id) {
        return repo.selectPrideDetail(normalizeType(type), id);
    }

    

    public PrideVO getDetail(Long id) {
        return getDetail(DEFAULT_TYPE, id);  // ★ 여기! null 넘기지 말고 기본값으로
    }

    public List<String> getImages(Long id) {
        return repo.selectPrideImages(id);
    }

    public Map<String, Object> getDetailModel(String type, Long id) {
        PrideVO post = getDetail(type, id);
        if (post == null) return null;
        Map<String, Object> model = new HashMap<>();
        model.put("post", post);
        model.put("images", getImages(id));
        return model;
    }

    public Map<String, Object> getDetailBundle(Long id) {
        PrideVO pride = getDetail(id);
        if (pride == null) return null;
        Map<String, Object> res = new HashMap<>();
        res.put("pride", pride);
        res.put("images", getImages(id));
        return res;
    }
}
