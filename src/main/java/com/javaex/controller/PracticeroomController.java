package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.PracticeroomService;

@Controller
@RequestMapping(value="/onespace")
public class PracticeroomController {
	//필드
	private final PracticeroomService practiceroomService;
	//생성자
	public PracticeroomController(PracticeroomService practiceroomService) {
        this.practiceroomService = practiceroomService;
    }
	//메소드 gs
	
	//메소드 일반
	
	//http://localhost:8888/onespace/practice1_main
	@RequestMapping(value="/practice1_main", method={RequestMethod.GET, RequestMethod.POST})
	public String main() {
        System.out.println("PracticeroomController.main()");
        practiceroomService.doSomethingForMain();
        return "practiceroom/practice1_main";
    }
}

