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

    public PrideService(PrideRepository repo){ 
        this.repo = repo; 
    }

    /**
     * 팀자랑 목록 페이징 조회
     * @param page - 현재 페이지 번호(0부터 시작)
     * @param size - 한 페이지에 보여줄 글 개수
     * @return Map: items(목록), last(마지막 페이지 여부)
     */
    public Map<String,Object> page(int page, int size){
        int offset = page * size; // LIMIT 시작 위치
        List<PrideVO> items = repo.selectPridePage(offset, size); // DB에서 목록 조회
        long total = repo.countPride(); // 전체 글 수
        boolean last = offset + items.size() >= total; // 마지막 페이지 여부 계산

        Map<String,Object> res = new HashMap<>();
        res.put("items", items);
        res.put("last", last);
        res.put("total", total); // 전체 건수도 추가해주면 더 편리
        return res;
    }

    /**
     * 특정 게시글 상세 조회
     * @param teamPostNo - 글 번호
     * @return PrideVO (없으면 임시 데이터 반환)
     */
    public PrideVO get(Long teamPostNo){
        PrideVO pride = repo.selectPrideOne(teamPostNo);
        if (pride == null) {
            // DB에 글이 없을 경우 임시 값 반환 (테스트용)
            pride = new PrideVO();
            pride.setTeamPostTitle("임시 제목");
            pride.setTeamContent("DB에 데이터가 없어 임시로 보여줍니다.");
            pride.setInstaAccount("temp_insta");
            pride.setTeamName("임시 팀");
        }
        return pride;
    }

    /**
     * 글 등록
     * @param pride - 저장할 PrideVO 객체
     */
    public void write(PrideVO pride){ 
        repo.insertPride(pride); 
    }
}
