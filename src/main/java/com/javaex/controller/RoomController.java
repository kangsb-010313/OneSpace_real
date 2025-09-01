package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.RoomService;
import com.javaex.vo.RoomsVO;

@Controller
@RequestMapping("/host/rooms")
public class RoomController {
	
	@Autowired
    private RoomService roomService;

	//룸리스트 출력
	 /** 신규 등록 폼 */
    @GetMapping("/list")
    public String list(@RequestParam("spacesNo") Long spacesNo, Model model) {
    	System.out.println(spacesNo);
    	List<RoomsVO> roomList = roomService.exeSelectRoomList(spacesNo);
    	System.out.println(roomList);
    	model.addAttribute("roomList", roomList);
        return "admin/host/host_manage_added"; // 화면 경로에 맞게 수정
    }
	
	

}
 