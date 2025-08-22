package com.javaex.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.PracticeroomService;
import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SlotVO;
import com.javaex.vo.SpacesVO;

@Controller
@RequestMapping("/onespace")
public class PracticeroomController {

	private final PracticeroomService practiceroomService;

	// 생성자 자동 생성 & 주입
	public PracticeroomController(PracticeroomService s) {
		this.practiceroomService = s;
	}

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

	// 찜리스트
	@GetMapping("/practice4_list")
	public String favoritesList(Model model) {
		Long userNo = 1L;

		List<SpacesVO> favoriteSpaces = practiceroomService.getFavoriteSpaces(userNo);
		model.addAttribute("favoriteSpaces", favoriteSpaces);

		model.addAttribute("favoriteCandidates", practiceroomService.getFavoriteCandidates(userNo));

		return "practiceroom/practice4_list";
	}

	@PostMapping("/api/room-slots")
	@ResponseBody
	public List<SlotVO> getRoomSlots(ReserveInfoVO reserveInfoVO) {
		System.out.println("PracticeroomController.getRoomSlots()");

		System.out.println(reserveInfoVO);

		List<SlotVO> slotList = practiceroomService.getRoomSlots(reserveInfoVO);

		return slotList;
	}
}
