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

    public PrideVO get(Long teamPostNo){ return repo.selectPrideOne(teamPostNo); }

    public void write(PrideVO pride){ repo.insertPride(pride); }
}
