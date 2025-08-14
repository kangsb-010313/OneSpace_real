package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="onespace")
public class TeampageController {

	//필드
	
	//생성자
	
	//메소드 gs
	
	//메소드 일반
	
	//--팀페이지 전체 리스트
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamlist() {
		System.out.println("TeampageController.teamlist()");
		
		return "teampage/list";
	}
	
	
	//--팀페이지 일반공지등록
	@RequestMapping(value="/teamwriteform", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamwriteForm() {
		System.out.println("TeampageController.teamwriteform()");
		
		return "teampage/writeform";
	}
	
	
}
