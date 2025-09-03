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
 * - 기본: 타입 필터 비적용(= 모든 글 포함). type 파라미터가 오면 그 값으로 필터.
 * - teamNo 필터(선택) 지원
 * - 목록/상세 + 이미지 번들
 * - 페이지당 개수: 기본 8, 최대 8
 */
@Service
@Transactional(readOnly = true)
public class PrideService {

    private final PrideRepository repo;

    /** 필요 시 쓸 기본 타입 (DB가 'TEAM_PRIDE' 또는 '팀자랑') — 기본에선 사용하지 않음 */
    private static final String DEFAULT_TYPE = "TEAM_PRIDE";

    /** 페이지 크기(기본/최대) */
    private static final int DEFAULT_PAGE_SIZE = 8;
    private static final int MAX_PAGE_SIZE     = 8;

    /** 페이지네이션 블록 크기 (1~5, 6~10 ...) */
    private static final int PAGE_BLOCK_SIZE   = 5;

    public PrideService(PrideRepository repo) {
        this.repo = repo;
    }

    /** type 파라미터가 비면 필터 끔(null) — 목록/상세 모두 안전 */
    private String normalizeType(String type) {
        return (type == null || type.isBlank()) ? null : type;
    }

    /** 페이지당 개수: 기본 8, 최대 8 */
    private int coerceSize(int size) {
        return (size <= 0) ? DEFAULT_PAGE_SIZE : Math.min(size, MAX_PAGE_SIZE);
    }

    /* =======================
     *  목록(카드)
     * ======================= */

    /** 카드 리스트 (팀 필터 없음, 타입 필터도 기본 미적용) */
    public List<PrideVO> getCards(int page, int size) {
        return getCards(null, page, size, null);
    }

    /** 카드 리스트 (teamNo/type 필터 지원) */
    public List<PrideVO> getCards(Long teamNo, int page, int size, String type) {
        int safeSize = coerceSize(size);
        int safePage = (page <= 0) ? 1 : page;
        int offset   = (safePage - 1) * safeSize;
        String t     = normalizeType(type);
        return repo.selectPrideCards(t, teamNo, safeSize, offset);
    }

    /** 총 개수 (teamNo/type 반영) */
    public int getTotalCount(Long teamNo, String type) {
        return repo.countPride(normalizeType(type), teamNo);
    }

    /** 목록 API 응답 */
    public Map<String, Object> pageApiModel(Long teamNo, int page, int size, String type) {
        int safeSize = coerceSize(size);
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
        int safeSize = coerceSize(size);

        int total = repo.countPride(t, teamNo);
        int totalPages = Math.max(1, (int) Math.ceil(total / (double) safeSize));
        int safePage   = Math.min(Math.max(page, 1), totalPages);
        int offset     = (safePage - 1) * safeSize;

        List<PrideVO> content = repo.selectPrideCards(t, teamNo, safeSize, offset);

        // 페이지 블록(1~5, 6~10 ...)
        int startPage = ((safePage - 1) / PAGE_BLOCK_SIZE) * PAGE_BLOCK_SIZE + 1;
        int endPage   = Math.min(startPage + PAGE_BLOCK_SIZE - 1, totalPages);

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

    /** 상세 (type이 오면 필터, 아니면 전체 허용) */
    public PrideVO getDetail(String type, Long id) {
        return repo.selectPrideDetail(normalizeType(type), id);
    }

    /** 상세 (기본: 타입 필터 끔) */
    public PrideVO getDetail(Long id) {
        return getDetail(null, id);
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
