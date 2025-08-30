package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.repository.PrideRepository;
import com.javaex.vo.PrideVO;

/**
 * [Service] 팀자랑 전용 비즈니스 로직
 * - 컨트롤러에서 요청된 '팀자랑' 데이터만 조회하도록 보장
 * - API 응답용 페이로드(페이지네이션) 구성
 * - 상세 + 첨부이미지 번들 제공
 */
@Service
@Transactional(readOnly = true)
public class PrideService {

    private final PrideRepository repo;

    public PrideService(PrideRepository repo) {
        this.repo = repo;
    }

    /** DB에 저장된 teamPostType 값에 맞게 변경 (예: "TEAM_PRIDE") */
    private static final String TYPE = "팀자랑";

    /** 카드 리스트 조회 (페이지는 1부터) */
    public List<PrideVO> getCards(int page, int size) {
        int safeSize = size <= 0 ? 12 : size;
        int safePage = page <= 0 ? 1 : page;
        int offset = (safePage - 1) * safeSize;
        return repo.selectPrideCards(TYPE, safeSize, offset);
    }

    /** 총 개수 (페이징용) */
    public int getTotalCount() {
        return repo.countPride(TYPE);
    }

    /** 상세 1건 */
    public PrideVO getDetail(Long id) {
        return repo.selectPrideDetail(TYPE, id);
    }

    /** 상세 이미지 목록 */
    public List<String> getImages(Long id) {
    	  return repo.selectPrideImages(id);
    	}

    /** 상세 + 이미지 번들 (컨트롤러에서 한 번에 쓰기) */
    public Map<String, Object> getDetailBundle(Long id) {
        PrideVO pride = getDetail(id);
        if (pride == null) return null;
        Map<String, Object> res = new HashMap<>();
        res.put("pride", pride);
        res.put("images", getImages(id));
        return res;
    }

    /** API 응답용 페이지네이션 페이로드 (무한스크롤/목록 Ajax) */
    public Map<String, Object> page(int page, int size) {
        int safeSize = size <= 0 ? 12 : size;
        int safePage = page <= 0 ? 1 : page;
        int offset = (safePage - 1) * safeSize;

        List<PrideVO> list = repo.selectPrideCards(TYPE, safeSize, offset);
        int total = repo.countPride(TYPE);

        Map<String, Object> res = new HashMap<>();
        res.put("list", list);
        res.put("totalCount", total);
        res.put("page", safePage);
        res.put("size", safeSize);
        res.put("hasMore", safePage * safeSize < total);
        return res;
    }
}
