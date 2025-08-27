package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.PracticeroomService;
import com.javaex.service.TeampageService;
import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SlotVO;
import com.javaex.vo.SpacesVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/onespace")
public class PracticeroomController {

	@Autowired
	private PracticeroomService practiceroomService;
	
	@Autowired
	private TeampageService teampageService;


	// http://localhost:8888/onespace/practice1_main
	// 최초 진입: 8장만
	@RequestMapping(value = "/practice1_main", method = { RequestMethod.GET, RequestMethod.POST })
	public String main(org.springframework.ui.Model model) {
		model.addAttribute("rooms", practiceroomService.getPagedList(0, 8));
		return "practiceroom/practice1_main";
	}

	// 무한 스크롤용 API
	@GetMapping("/api/practicerooms")
	@ResponseBody
	public List<SpacesVO> listApi(@RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "4") int size) { // 추가 4장씩
		int offset = page * size;
		return practiceroomService.getPagedList(offset, size);
	}

	// zone 페이지 (연습실 상세)
	@GetMapping("/practice2_zone")
	public String zone(@RequestParam("spacesNo") Long spacesNo, Model model) {
		SpacesVO zoneDetail = practiceroomService.getZoneDetail(spacesNo);
		List<RoomsVO> roomList = practiceroomService.getRoomsBySpace(spacesNo);

		model.addAttribute("zone", zoneDetail);
		model.addAttribute("rooms", roomList);

		return "practiceroom/practice2_zone";
	}
	
	// ROOM 상세 페이지 로드
	@GetMapping("/practice3_room")
	public String room(@RequestParam("roomNo") Long roomNo, HttpSession session, Model model) {
		System.out.println("PracticeroomController.room()");
		
		//userNo 세션에서 꺼낸다
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
		int userNo = authUser.getUserNo();
		System.out.println("userNo from session: " + userNo);
		
		RoomsVO room = practiceroomService.getRoomByNo(roomNo);
	    model.addAttribute("room", room);

	    SpacesVO zone = practiceroomService.getZoneDetail(room.getSpacesNo());
	    model.addAttribute("zone", zone);

	    List<TeamVO> teams = practiceroomService.getTeamsForUser(userNo);
        model.addAttribute("teams", teams);
        
	    return "practiceroom/practice3_room";
	}
	
	// 찜리스트
	@GetMapping("/practice4_list")
	public String favoritesList(Model model, HttpSession session) {
		System.out.println("PracticeroomController.favoritesList()");
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		
        // 1. 로그인 체크
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
		int userNo = authUser.getUserNo();

		List<SpacesVO> favoriteSpaces = practiceroomService.getFavoriteSpaces(userNo);
		System.out.println("favoriteSpaces=" + favoriteSpaces);
		model.addAttribute("favoriteSpaces", favoriteSpaces);

		model.addAttribute("favoriteCandidates", practiceroomService.getFavoriteCandidates(userNo));

		//로그인한 사용자의 팀리스트
		List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
		model.addAttribute("allTeams", userTeamList); 
		
		return "practiceroom/practice4_list";
	}
	
	// 방 시간대별 슬롯 정보
	@PostMapping("/api/room-slots")
	@ResponseBody
	public List<SlotVO> getRoomSlots(ReserveInfoVO reserveInfoVO) {
		System.out.println("PracticeroomController.getRoomSlots()");

		System.out.println(reserveInfoVO);

		List<SlotVO> slotList = practiceroomService.getRoomSlots(reserveInfoVO);

		return slotList;
	}
	
	// 찜 추가
	@PostMapping("/api/favorite")
	@ResponseBody
	public Map<String, Object> addFavorite(@RequestParam Long roomNo, @RequestParam String teamName, HttpSession session) {
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		int userNo = authUser.getUserNo();
		System.out.println("addFavorite: userNo from session: " + userNo);
	    
	    boolean result = practiceroomService.addFavorite(userNo, roomNo);
	    if (result) {
	        return Map.of("success", true, "message", "팀 " + teamName + "에 대한 찜이 추가되었습니다.");
	    } else {
	        return Map.of("success", false, "message", "찜 추가 실패");
	    }
	}
	
	// 찜 목록 삭제
	@PostMapping("/api/favorite/remove")
	@ResponseBody
	public Map<String, Object> removeFavorite(@RequestParam Long roomNo, HttpSession session) {
	    UserVO authUser = (UserVO) session.getAttribute("authUser");
	    if (authUser == null) {
	        return Map.of("success", false, "message", "로그인 필요");
	    }
	    int userNo = authUser.getUserNo();
	    System.out.println("removeFavorite: userNo=" + userNo + ", roomNo=" + roomNo);

	    boolean result = practiceroomService.removeFavorite(userNo, roomNo);
	    if (result) {
	        return Map.of("success", true, "message", "찜이 해제되었습니다.");
	    } else {
	        return Map.of("success", false, "message", "찜 해제 실패");
	    }
	}
	
	
}
