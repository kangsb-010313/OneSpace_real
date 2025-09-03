package com.javaex.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.repository.PracticeroomRepository;
import com.javaex.vo.FacilityInfoVO;
import com.javaex.vo.FavoriteVO;
import com.javaex.vo.ReservationVO;
import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SlotVO;
import com.javaex.vo.SpacesVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.UserVO;
import com.javaex.vo.VoteOptionVO;
import com.javaex.vo.VoteVO;

import jakarta.servlet.http.HttpSession;

@Service
public class PracticeroomService {

	@Autowired
	private PracticeroomRepository practiceroomRepository;

	// 모든 연습실 공간 목록 조회
	public List<SpacesVO> getPagedList(int offset, int size) {
		return practiceroomRepository.practiceroomSelectPaged(offset, size);
	}

	// 페이징된 연습실 공간 목록 조회
	public SpacesVO getZoneDetail(Long spacesNo) {
		SpacesVO spacesVO = practiceroomRepository.selectZoneDetail(spacesNo);

		List<FacilityInfoVO> checkedFacilityList = practiceroomRepository.selectCheckedFacilities(spacesNo);
		spacesVO.setCheckedFacilityList(checkedFacilityList);

		return spacesVO;
	}

	// 공간에 속한 방 목록 조회
	public List<RoomsVO> getRoomsBySpace(Long spacesNo) {
		return practiceroomRepository.selectRoomsBySpace(spacesNo);
	}

	// 방 정보 조회
	public RoomsVO getRoomByNo(Long roomNo) {
		// 방기본정보
		RoomsVO roomsVO = practiceroomRepository.selectRoomByNo(roomNo);

		// 가격규칙
		List<RoomPriceVO> roomPriceList = practiceroomRepository.selectRoomPrices(roomNo);

		// 방기본정보<--가격규칙
		roomsVO.setPrices(roomPriceList);

		return roomsVO;
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
		
		System.out.println(reserveInfoVO);
		
		//가격규칙가져오기
		List<RoomPriceVO> roomPriceList = practiceroomRepository.selectRoomPricesByDate(reserveInfoVO);
		
		//예약된 시간 가져오기
		List<ReservationVO> reservationList = practiceroomRepository.selectReservation(reserveInfoVO);
		
		List<SlotVO> slotList = new ArrayList<>();
		for (int i = 0; i < 24; i++)
			slotList.add(new SlotVO(reserveInfoVO.getRoomNo(), reserveInfoVO.getTargetDate(), i, 0));
		for (RoomPriceVO rule : roomPriceList) {
			int start = Integer.parseInt(rule.getStartTime().substring(0, 2));
			int end = Integer.parseInt(rule.getEndTime().substring(0, 2));
			int price = rule.getHourlyPrice();
			for (int j = start; j < end; j++)
				slotList.get(j).setPrice(price);
		}
		
		for(int i=0; i<reservationList.size(); i++) {
			int voteTime = Integer.parseInt( reservationList.get(i).getVoteTime());
			
			for(int s=0; s<slotList.size(); s++) {
				int slotNo = slotList.get(s).getSlotNo();
				
				if(voteTime == slotNo) {
					slotList.get(s).setState(1);
					break;
				}
				
			}
			
		}
		
		return slotList;
	}

	// 찜 추가
	public Map<String, Object> addFavorite(Long roomNo, HttpSession session) {
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null)
			return Map.of("success", false, "message", "로그인 필요");

		boolean result = practiceroomRepository.insertStudioWishlist(authUser.getUserNo(), roomNo) > 0;
		return result ? Map.of("success", true, "message", "찜이 추가되었습니다.")
				: Map.of("success", false, "message", "찜 추가 실패");
	}

	// 찜 삭제
	public Map<String, Object> removeFavorite(Long roomNo, HttpSession session) {
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null)
			return Map.of("success", false, "message", "로그인 필요");

		boolean result = practiceroomRepository.deleteStudioWishlist(authUser.getUserNo(), roomNo) > 0;
		return result ? Map.of("success", true, "message", "찜이 해제되었습니다.")
				: Map.of("success", false, "message", "찜 해제 실패");
	}

	// 후보 추가
	@Transactional
	public long addVoteOption(int roomNo, String voteDate, String voteTime, Long voteNo, int voteStatus,
			long userNo) {
		
		long totalPrice = 0L;
		int startHour = 0;
		int endHour = 0;
		
		// 1) 금액 계산
		//합계구하기///////////////////////////////////////////////////////////
		ReserveInfoVO reserveInfoVO = new ReserveInfoVO();
		reserveInfoVO.setRoomNo(roomNo);
		reserveInfoVO.setTargetDate(voteDate);
		
		List<RoomPriceVO> roomPriceList = practiceroomRepository.selectRoomPricesByDate(reserveInfoVO);

		startHour = Integer.parseInt(voteTime.split("~")[0].split(":")[0]);
		endHour = Integer.parseInt(voteTime.split("~")[1].split(":")[0]);
		
		for (RoomPriceVO priceRule : roomPriceList) {
			int start = Integer.parseInt(priceRule.getStartTime().substring(0, 2));
			int end = Integer.parseInt(priceRule.getEndTime().substring(0, 2));
			int price = priceRule.getHourlyPrice();

			for (int h = startHour; h < endHour; h++) {
				if (h >= start && h < end) {
					totalPrice += price;
				}
			}
		}
		//합계구하기///////////////////////////////////////////////////////////
		
		//투표저장(회원번호, 합계) --> 투표번호
		VoteVO voteVO = new VoteVO();
		voteVO.setUserNo(userNo);
		voteVO.setTotalPrice(totalPrice);
		int count = practiceroomRepository.insertVotes(voteVO);
		
		System.out.println("=====================================");
		System.out.println(voteVO);
		System.out.println("=====================================");
		//예약시간 저장(회원번호, 투표번호, 연습실번호, 날짜, 시간 03~ 05
		
		for(int i=startHour;  i<endHour; i++) {
			VoteOptionVO voteOptionVO = new VoteOptionVO(userNo, voteVO.getVoteNo(), roomNo, voteDate, ""+i );
			
			System.out.println("=====================================");
			System.out.println(voteOptionVO);
			System.out.println("=====================================");
			practiceroomRepository.insertVotesOption(voteOptionVO);
			
		}
		
		//                                             voteTime (시작시간   끝시간)   
		//예약시간 저장(회원번호, 투표번호, 연습실번호, 날짜, 시간 1 24
		
		//시작시간 ~끝시간
		//    vo(회원번호, 투표번호, 연습실번호, 날짜, 시간)
		
		// 2) votes 테이블 insert (totalPrice 포함)
//		Long generatedVoteNo = practiceroomRepository.insertVote(authUser.getUserNo(), totalPrice, null);
//
//		// 3) voteOptions insert
//		boolean ok = practiceroomRepository.insertVoteOption(authUser.getUserNo(), roomNo, voteDate, voteTime,
//				generatedVoteNo, voteStatus);
//
//		return ok ? Map.of("success", true, "message", "후보가 추가되었습니다.", "voteNo", voteNo, "totalPrice", totalPrice)
//				: Map.of("success", false, "message", "후보 추가 실패");
//		
		return voteVO.getVoteNo();
	}

	// 후보 삭제
	public Map<String, Object> removeVoteOption(long voteNo, HttpSession session) {
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		if (authUser == null)
			return Map.of("success", false, "message", "로그인 필요");

		boolean ok = practiceroomRepository.deleteVote(authUser.getUserNo(), voteNo);
		practiceroomRepository.deleteVoteOption(voteNo);
		
		return ok ? Map.of("success", true, "message", "후보가 삭제되었습니다.")
				: Map.of("success", false, "message", "후보 삭제 실패");
	}

	// 검색
	public List<SpacesVO> searchSpaces(String keyword) {
		return practiceroomRepository.searchSpaces(keyword);
	}

	// 방리스트
	public List<Map<String, Object>> getRoomAttachments(Long roomNo) {
		return practiceroomRepository.selectRoomAttachments(roomNo);
	}

	// 찜리스트 가져오기
	public List<FavoriteVO> exeFavoritesList(long userNo) {

		List<FavoriteVO> favoritesList = practiceroomRepository.selectFavoritesList(userNo);
		
		//건물이 선택 시설리스트 추가
		for(int i=0; i<favoritesList.size(); i++) {
			long spaceNo = favoritesList.get(i).getSpacesNo();
			List<FacilityInfoVO> selectedFacilityInfoList = practiceroomRepository.selectCheckedFacilities(spaceNo);
			
			favoritesList.get(i).setSelectedFacilityInfoList(selectedFacilityInfoList);
		}
		
		return favoritesList;
	}

}
