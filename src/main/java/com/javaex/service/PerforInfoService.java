package com.javaex.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.javaex.repository.PerforInfoRepository;
import com.javaex.vo.PerforInfoVO;

@Service
public class PerforInfoService {

    private final PerforInfoRepository repository;

    public PerforInfoService(PerforInfoRepository repository) {
        this.repository = repository;
    }

    public long count() {
        return repository.count();
    }

    public List<PerforInfoVO> listPaged(int offset, int size) {
        return repository.listPaged(offset, size);
    }

    public PerforInfoVO get(Long no) {
        return repository.get(no);
    }

    @Transactional
    public Long insert(PerforInfoVO vo) {
        repository.insert(vo);
        return vo.getInfoPostNo(); // PK 반환
    }
}
