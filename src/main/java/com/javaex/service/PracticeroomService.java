package com.javaex.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javaex.repository.PracticeroomRepository;
import com.javaex.vo.PracticeroomVO;

@Service
public class PracticeroomService {

    private final PracticeroomRepository practiceroomRepository;

    public PracticeroomService(PracticeroomRepository practiceroomRepository) {
        this.practiceroomRepository = practiceroomRepository;
    }

    public List<PracticeroomVO> getList() {
        return practiceroomRepository.practiceroomSelectList();
    }
    
    public List<PracticeroomVO> getPagedList(int offset, int size) {
        return practiceroomRepository.practiceroomSelectPaged(offset, size);
    }
}
