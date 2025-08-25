package com.javaex.service;

import com.javaex.repository.PrideRepository;
import com.javaex.vo.PrideVO;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class PrideService {
    private final PrideRepository repo;
    public PrideService(PrideRepository repo){ this.repo = repo; }

    public Map<String,Object> page(int page, int size){
        int offset = page * size;
        List<PrideVO> items = repo.selectPridePage(offset, size);
        long total = repo.countPride();
        boolean last = offset + items.size() >= total;

        Map<String,Object> res = new HashMap<>();
        res.put("items", items);
        res.put("last", last);
        return res;
    }

    public PrideVO get(Long teamPostNo){
        PrideVO pride = repo.selectPrideOne(teamPostNo);
        if (pride == null) {
            pride = new PrideVO();
            pride.setTeamPostTitle("임시 제목");
            pride.setTeamContent("DB에 데이터가 없어 임시로 보여줍니다.");
            pride.setInstaAccount("temp_insta");
            pride.setTeamName("임시 팀");
        }
        return pride;
    }
    
    

    public void write(PrideVO pride){ repo.insertPride(pride); }
}
