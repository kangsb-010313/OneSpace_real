package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/onespace")
public class UserController {
	
	//필드
	
	//메소드 일반
	// --회원가입 폼
	@RequestMapping(value = "/joinform", method = { RequestMethod.GET, RequestMethod.POST })
	public String joinForm() {
		System.out.println("UserController.joinFrom()test.");
		
		return "admin/auth/signup";
	}
	// --회원가입
	
	// --로그인 폼
	
	// --로그인
	
	// --로그아웃
	
	// --회원정보 수정폼
	
	
	

}
