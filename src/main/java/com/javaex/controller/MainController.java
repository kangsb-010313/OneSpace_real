package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/onespace")
public class MainController {
	
	//필드
	
	//생성자
	
	//메소드 gs
	
	//메소드 일반
		
	//--사이트 시작 페이지
	@RequestMapping(value="/main", method= {RequestMethod.GET, RequestMethod.POST})
	public String main() {
		System.out.println("MainController.main()테스트");
		
		return "practiceroom/practice1_main";
	}
	

}
