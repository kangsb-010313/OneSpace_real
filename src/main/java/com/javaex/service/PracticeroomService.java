package com.javaex.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.javaex.repository.PracticeroomRepository;
import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SlotVO;
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
    
    //룸가격리스트 가져오기
    public List<SlotVO> getRoomSlots(ReserveInfoVO reserveInfoVO) {
    	System.out.println("PracticeroomService.getRoomSlots()");
    	
    	reserveInfoVO.setRoomNo(24);
    	reserveInfoVO.setTargetDate("2025-08-23");
    	
    	
    	// 1) DB에서 날짜 기반 요금 구간 조회
        List<RoomPriceVO> roomPriceList = practiceroomRepository.selectRoomPricesByDate(reserveInfoVO);
        
        // 2) 24시간 데이터 작성
        List<SlotVO> slotList = new ArrayList<SlotVO>(); 
        for(int i=0; i<24; i++) {
        	SlotVO slotVO = new SlotVO(reserveInfoVO.getRoomNo(), reserveInfoVO.getTargetDate(), i, 0 );
        	slotList.add(slotVO);
        }
        for(int i=0; i<roomPriceList.size(); i++ ) {
        	RoomPriceVO rule = roomPriceList.get(i);
        	int start = Integer.parseInt(rule.getStartTime().substring(0,2));
        	int end = Integer.parseInt(rule.getEndTime().substring(0,2));
        	int price = rule.getHourlyPrice();
        	
        	System.out.println(rule);
        	
        	for(int j=start; j<end; j++) {
        		slotList.get(j).setPrice(price);
        	}
        }
        
        return slotList;
    }
    
    public RoomsVO getRoomByNo(Long roomNo) {
        return practiceroomRepository.selectRoomByNo(roomNo);
    }
}
