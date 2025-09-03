package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.RoomService;
import com.javaex.vo.RoomVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/host/rooms")
public class RoomController {

	@Autowired
	private RoomService roomService;

	// 연습실(방) 전체 리스트
	@RequestMapping(value = "/list", method = { RequestMethod.GET, RequestMethod.POST })
	private String list(HttpSession session, Model model) {
		System.out.println("RoomController.selectRoomList()");

		// 세션에서 회원번호 구하기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		// 세션값이 없으면(로그인 안하면)
		if (authUser == null) {
			// 로그인폼으로 리다이렉트
			return "redirect:/user/loginForm";

		} else {
			// 세션값이 있으면(로그인 했으면)
			long userNo = authUser.getUserNo();

			List<RoomVO> roomList = roomService.exeSelectRoomList(userNo);
			System.out.println("roomList" + roomList);

			if (roomList.size() != 0) {
				// 룸리스트가 있으면 리스트출력
				System.out.println("룸리스트 있으면");
				model.addAttribute("roomList", roomList);

				return "admin/host/host_room_list";
			} else {
				// 룸리스트가 없으면 룸 등록 폼으로 리다이렉트
				System.out.println("룸리스트 없으면");
				return "redirect:/host/rooms/new";
			}

		}

	}

	//연습실(룸) 등록폼
	@GetMapping("/new")
	public String formNew(HttpSession session, Model model) {
		System.out.println("RoomController.formNew()");

		// 세션에서 회원번호 구하기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		
		if (authUser == null) {
			// 세션값이 없으면(로그인 안하면)
			// 로그인폼으로 리다이렉트
			return "redirect:/user/loginForm";

		} else {
			// 세션값이 있으면(로그인 했으면)
			long userNo = authUser.getUserNo();
			Long spacesNo = roomService.exeSelectSpacesNoByUserNo(userNo);
			
			if(spacesNo == null ) {
				//건물등록을 안했으면 건물등록폼으로
				return "redirect:/host/spaces/new";
				
			}else {
				//건물등록을 했으면 등록폼으로
				return "admin/host/host_info2"; // 화면 경로에 맞게 수정
			}
		}
	}
	
	
	//연습실(룸) 등록
	@PostMapping("/save")
	public String insert(@ModelAttribute RoomVO roomVO, HttpSession session) {
		System.out.println("RoomController.insert()");
		
		// 세션에서 회원번호 구하기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		
		if (authUser == null) {
			// 세션값이 없으면(로그인 안하면)
			// 로그인폼으로 리다이렉트
			return "redirect:/user/loginForm";

		} else {
			// 세션값이 있으면(로그인 했으면)
			long userNo = authUser.getUserNo();
			Long spacesNo = roomService.exeSelectSpacesNoByUserNo(userNo);
			
			//현재 로그인 사용자의 건물번호를 넣어준다
			roomVO.setSpacesNo(spacesNo);
			
			roomService.exeRoomAdd(roomVO);
			return "redirect:/host/rooms/list";
		}
		
	}

}
