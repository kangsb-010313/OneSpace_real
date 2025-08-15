package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.TeampageService;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping(value="onespace")
public class TeampageController {

	//필드
	@Autowired
	private TeampageService teampageService;
	
	//생성자
	
	//메소드 gs
	
	//메소드 일반
	
	//--팀페이지 전체 리스트
	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
	public String list() {
		System.out.println("TeampageController.list()");
		
		return "teampage/list"; 
	}
	
	//--팀페이지 일반공지등록 폼
	@RequestMapping(value="/writeform", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamwriteForm(HttpSession session, Model model) {
		System.out.println("TeampageController.teamwriteform()");
		
		return "teampage/writeform";
	}
	
	//--일반공지등록
	@RequestMapping(value="/teamwriteadd", method= {RequestMethod.GET, RequestMethod.POST})
	public String write() {
		System.out.println("TeampageController.write()");
		
		
		
		return "";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
