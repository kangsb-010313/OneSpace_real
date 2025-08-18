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

    // 목록
    public List<PerforInfoVO> list() {
        return repository.list();
    }

    // 단건 조회
    public PerforInfoVO get(Long no) {
        return repository.get(no);
    }

    // 글 등록
    @Transactional
    public Long add(PerforInfoVO vo) {
        repository.insert(vo);
        if (vo.getInfoPostNo() == null) {
            throw new IllegalStateException("auto-increment key not returned");
        }
        return vo.getInfoPostNo();
    }
}
