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
    public List<SpacesVO> getPagedList(int offset, int size) {
        return practiceroomRepository.practiceroomSelectPaged(offset, size);
    }
    
    // 페이징된 연습실 공간 목록 조회
    public SpacesVO getZoneDetail(Long spacesNo) {
    	return practiceroomRepository.selectZoneDetail(spacesNo);
    }
    
    // 공간에 속한 방 목록 조회
    public List<RoomsVO> getRoomsBySpace(Long spacesNo) {
    	return practiceroomRepository.selectRoomsBySpace(spacesNo);
    }
    
    // 방 정보 조회
    public RoomsVO getRoomByNo(Long roomNo) {
    	return practiceroomRepository.selectRoomByNo(roomNo);
    }
    
 	// 공간의 상세 정보 조회
    public SpacesVO getZoneDetailByRoom(Long roomNo) {
        RoomsVO room = getRoomByNo(roomNo);
        return practiceroomRepository.selectZoneDetail(room.getSpacesNo());
    }
    
    // 페이징된 연습실 공간 목록 조회
    public List<SpacesVO> getFavoriteSpaces(int userNo) {
    	return practiceroomRepository.selectFavoriteSpaces(userNo);
    }
    
    // 사용자의 찜 후보 목록 조회
    public List<Map<String, Object>> getFavoriteCandidates(int userNo) {
    	return practiceroomRepository.selectFavoriteCandidates(userNo);
    }
    
    // 사용자의 소속 팀 목록 조회
    public List<TeamVO> getTeamsForUser(int userNo) {
    	return practiceroomRepository.selectTeamsByUser(userNo);
    }
    
    // 슬롯
    public List<SlotVO> getRoomSlots(ReserveInfoVO reserveInfoVO) {
        List<RoomPriceVO> roomPriceList = practiceroomRepository.selectRoomPricesByDate(reserveInfoVO);
        List<SlotVO> slotList = new ArrayList<>();
        for (int i = 0; i < 24; i++) slotList.add(new SlotVO(reserveInfoVO.getRoomNo(), reserveInfoVO.getTargetDate(), i, 0));
        for (RoomPriceVO rule : roomPriceList) {
            int start = Integer.parseInt(rule.getStartTime().substring(0, 2));
            int end = Integer.parseInt(rule.getEndTime().substring(0, 2));
            int price = rule.getHourlyPrice();
            for (int j = start; j < end; j++) slotList.get(j).setPrice(price);
        }
        return slotList;
    }
    
    // 찜 추가
    public Map<String, Object> addFavorite(Long roomNo, String teamName, HttpSession session) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return Map.of("success", false, "message", "로그인 필요");

        boolean result = practiceroomRepository.insertStudioWishlist(authUser.getUserNo(), roomNo) > 0;
        return result ?
            Map.of("success", true, "message", "팀 " + teamName + "에 대한 찜이 추가되었습니다.") :
            Map.of("success", false, "message", "찜 추가 실패");
    }
    
    // 찜 삭제
    public Map<String, Object> removeFavorite(Long roomNo, HttpSession session) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return Map.of("success", false, "message", "로그인 필요");

        boolean result = practiceroomRepository.deleteStudioWishlist(authUser.getUserNo(), roomNo) > 0;
        return result ?
            Map.of("success", true, "message", "찜이 해제되었습니다.") :
            Map.of("success", false, "message", "찜 해제 실패");
    }
    
    // 후보 추가
    public Map<String, Object> addVoteOption(Long roomNo, String voteDate, String voteTime, Integer voteNo, int voteStatus, HttpSession session) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return Map.of("success", false, "message", "로그인 필요");

        boolean result = practiceroomRepository.insertVoteOption(authUser.getUserNo(), roomNo, voteDate, voteTime, voteNo, voteStatus);
        return result ?
            Map.of("success", true, "message", "후보가 추가되었습니다.",
                   "roomNo", roomNo, "voteDate", voteDate, "voteTime", voteTime, "voteStatus", voteStatus) :
            Map.of("success", false, "message", "후보 추가 실패");
    }
}
