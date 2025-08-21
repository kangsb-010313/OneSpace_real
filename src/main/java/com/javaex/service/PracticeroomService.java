package com.javaex.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.javaex.repository.PracticeroomRepository;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SpacesVO;

@Service
public class PracticeroomService {
	
    private final PracticeroomRepository practiceroomRepository;
    
    public PracticeroomService(PracticeroomRepository practiceroomRepository) {
        this.practiceroomRepository = practiceroomRepository;
    }
    
    public List<SpacesVO> getList() {
        return practiceroomRepository.practiceroomSelectList();
    }
    
    public List<SpacesVO> getPagedList(int offset, int size) {
        return practiceroomRepository.practiceroomSelectPaged(offset, size);
    }
    
    public SpacesVO getZoneDetail(Long spacesNo) {
        return practiceroomRepository.selectZoneDetail(spacesNo);
    }
    
    public List<RoomsVO> getRoomsBySpace(Long spacesNo) {
        return practiceroomRepository.selectRoomsBySpace(spacesNo);
    }
    
    public List<SpacesVO> getFavoriteSpaces(Long userNo) {
        return practiceroomRepository.selectFavoriteSpaces(userNo);
    }
    
    public List<Map<String, Object>> getFavoriteCandidates(Long userNo) {
        return practiceroomRepository.selectFavoriteCandidates(userNo);
    }
}
