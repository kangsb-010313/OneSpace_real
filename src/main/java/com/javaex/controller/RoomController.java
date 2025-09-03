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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.RoomService;
import com.javaex.vo.HostVO;
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

	/** 신규 등록 폼 + 수정폼 */
	@GetMapping("/rooms/new")
	public String formNew(Model model) {
		model.addAttribute("spacesNo", 1);
		return "admin/host/host_info2"; // 화면 경로에 맞게 수정
	}
	
	//저장(insert)
	
	
/*
	@PostMapping("/rooms/insert")
	public String insert(@ModelAttribute RoomsVO vo,
			@RequestParam(value = "dayType", required = false) List<String> dayType,
			@RequestParam(value = "startTime", required = false) List<String> startTime,
			@RequestParam(value = "endTime", required = false) List<String> endTime,
			@RequestParam(value = "hourlyPrice", required = false) List<String> hourlyPrice,
			@RequestParam(value = "photos", required = false) MultipartFile photos,

			RedirectAttributes ra) {
		// ★★★★★ 디버깅 코드 추가 ★★★★★
		System.out.println("========================================");
		System.out.println("[RoomController] /save 요청 진입");
		if (photos != null && photos.length > 0) {
			System.out.println("전달된 파일 개수: " + photos.length);
			for (MultipartFile mf : photos) {
				System.out.println(" - 원본 파일명: " + mf.getOriginalFilename());
				System.out.println(" - 파일 크기: " + mf.getSize());
			}
		} else {
			System.out.println("전달된 파일이 없습니다.");
		}
		System.out.println("========================================");

		return null;

	}
*/
}
