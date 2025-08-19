package com.javaex.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.PracticeroomService;
import com.javaex.vo.PracticeroomVO;

@Controller
@RequestMapping("/onespace")
public class PracticeroomController {
    
	private final PracticeroomService practiceroomService;
	
	// 생성자 자동 생성 & 주입
    public PracticeroomController(PracticeroomService s) {
    	this.practiceroomService = s;
    }
    
    //http://localhost:8888/onespace/practice1_main
    // 최초 진입: 8장만
    @RequestMapping(value="/practice1_main", method={RequestMethod.GET, RequestMethod.POST})
    public String main(org.springframework.ui.Model model) {
        model.addAttribute("rooms", practiceroomService.getPagedList(0, 8));
        return "practiceroom/practice1_main";
    }
    
    // 무한 스크롤용 API
    @GetMapping("/api/practicerooms")
    @ResponseBody
    public List<PracticeroomVO> listApi(@RequestParam(defaultValue="0") int page,
                                        @RequestParam(defaultValue="4") int size) { // 추가 4장씩
        int offset = page * size;
        return practiceroomService.getPagedList(offset, size);
    }
}
