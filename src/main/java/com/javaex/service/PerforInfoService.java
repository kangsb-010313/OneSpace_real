package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.repository.PerforInfoRepository;
import com.javaex.vo.PerforInfoVO;

@Service
public class PerforInfoService {

    // 필드
    @Autowired
    private PerforInfoRepository repository;

    // 메소드 일반

    //--전체 개수 조회
    public long count() {
        System.out.println("PerforInfoService.count()");
        return repository.count();
    }

    //--페이징 목록 조회
    public List<PerforInfoVO> listPaged(int offset, int size) {
        System.out.println("PerforInfoService.listPaged()");
        return repository.listPaged(offset, size);
    }

    //--단건 조회
    public PerforInfoVO get(Long no) {
        System.out.println("PerforInfoService.get()");
        return repository.get(no);
    }

    //--작성 처리
    @Transactional
    public Long insert(PerforInfoVO vo) {
        System.out.println("PerforInfoService.insert()");
        repository.insert(vo);
        return vo.getInfoPostNo(); // PK 반환
    }
}
