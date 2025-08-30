package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.javaex.repository.PrideRepository;
import com.javaex.vo.PrideVO;

@Service
public class PrideService {

    private final PrideRepository repo;

    public PrideService(PrideRepository repo) {
        this.repo = repo;
    }

    /** 팀자랑 목록 페이징 조회 */
    public Map<String, Object> page(int page, int size) {
        int offset = page * size;
        List<PrideVO> items = repo.selectPridePage(offset, size); // <-- var 대신 명시적 타입
        long total = repo.countPride();

        Map<String, Object> res = new HashMap<>();
        res.put("items", items);
        res.put("total", total);
        res.put("last", offset + items.size() >= total);
        return res;
    }

    /** 팀자랑 상세 */
    public PrideVO get(Long teamPostNo) {
        return repo.selectPrideOne(teamPostNo);
    }

    // 작성(INSERT)은 다른 모듈에서 처리하므로 이 서비스에는 없음
}
