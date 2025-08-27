package com.javaex.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.repository.PracticeroomRepository;
import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SlotVO;
import com.javaex.vo.SpacesVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Service
public class PracticeroomService {
	
    private final PracticeroomRepository practiceroomRepository;
    
    public PracticeroomService(PracticeroomRepository practiceroomRepository) {
        this.practiceroomRepository = practiceroomRepository;
    }
    
    // 모든 연습실 공간 목록 조회
    public List<SpacesVO> getList() {
        return practiceroomRepository.practiceroomSelectList();
    }
    
    // 페이징된 연습실 공간 목록 조회
    public List<SpacesVO> getPagedList(int offset, int size) {
        return practiceroomRepository.practiceroomSelectPaged(offset, size);
    }
    
    // 특정 공간의 상세 정보 조회
    public SpacesVO getZoneDetail(Long spacesNo) {
    	
    	// 룸
    	// 룸사진리스트
    	
        return practiceroomRepository.selectZoneDetail(spacesNo);
    }
    
    // 특정 공간에 속한 방 목록 조회
    public List<RoomsVO> getRoomsBySpace(Long spacesNo) {
        return practiceroomRepository.selectRoomsBySpace(spacesNo);
    }
    
    // 특정 사용자가 찜한 공간 목록 조회
    public List<SpacesVO> getFavoriteSpaces(int userNo) {
    	System.out.println("PracticeroomRepository.getFavoriteSpaces()");
    	
        return practiceroomRepository.selectFavoriteSpaces(userNo);
    }
    
    // 특정 사용자의 찜 후보 목록 조회
    public List<Map<String, Object>> getFavoriteCandidates(int userNo) {
        return practiceroomRepository.selectFavoriteCandidates(userNo);
    }
    
    // 날짜별 방 가격 슬롯 목록 조회
    public List<SlotVO> getRoomSlots(ReserveInfoVO reserveInfoVO) {
    	System.out.println("PracticeroomService.getRoomSlots()");
        System.out.println(reserveInfoVO);

        List<RoomPriceVO> roomPriceList = practiceroomRepository.selectRoomPricesByDate(reserveInfoVO);
        List<SlotVO> slotList = new ArrayList<>(); 
        for (int i = 0; i < 24; i++) {
            slotList.add(new SlotVO(reserveInfoVO.getRoomNo(), reserveInfoVO.getTargetDate(), i, 0));
        }
        for (RoomPriceVO rule : roomPriceList) {
            int start = Integer.parseInt(rule.getStartTime().substring(0, 2));
            int end = Integer.parseInt(rule.getEndTime().substring(0, 2));
            int price = rule.getHourlyPrice();
            for (int j = start; j < end; j++) {
                slotList.get(j).setPrice(price);
            }
        }
        return slotList;
    }
    
    // 특정 방 정보 조회
    public RoomsVO getRoomByNo(Long roomNo) {
        return practiceroomRepository.selectRoomByNo(roomNo);
    }
    
    // 찜 목록에 추가
    public boolean addFavorite(int userNo, Long roomNo) {
    	System.out.println("addFavorite");
    	// insert 결과 행수 반환(1이면 성공)
        int rows = practiceroomRepository.insertStudioWishlist(userNo, roomNo);
        return rows > 0;
    }
    
    // 특정 사용자의 소속 팀 목록 조회
    public List<TeamVO> getTeamsForUser(int userNo) {
        return practiceroomRepository.selectTeamsByUser(userNo);
    }
    
    // 찜 목록 삭제
    public boolean removeFavorite(int userNo, Long roomNo) {
        System.out.println("PracticeroomService.removeFavorite() userNo=" + userNo + ", roomNo=" + roomNo);
        int rows = practiceroomRepository.deleteStudioWishlist(userNo, roomNo);
        return rows > 0;
    }
    
 // 날짜 시간 추가
    public boolean addVoteOption(int userNo, Long roomNo, String voteDate, String voteTime, Integer voteNo) {
        return practiceroomRepository.insertVoteOption(userNo, roomNo, voteDate, voteTime, voteNo);
    }
    
    
}
