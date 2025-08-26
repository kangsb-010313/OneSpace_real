package com.javaex.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.PrideService;
import com.javaex.vo.PrideVO;

@Controller
@RequestMapping("/pride")
public class PrideController {

    private final PrideService service;
    public PrideController(PrideService service){ this.service = service; }

    //* 팀자랑 리스트 페이지 요청 처리
    @GetMapping("/list")
    public String list(){
    	return "pride/pridemain";
    }
    
    //팀자랑 목록 데이터 API (Ajax, 무한스크롤 등에서 사용 가능)
    @ResponseBody
    @GetMapping("/api")
    public Map<String,Object> api(@RequestParam(defaultValue="0") int page,
                                  @RequestParam(defaultValue="12") int size){
        return service.page(page, size);
    }

    //글쓰기 화면 요청 처리
    @GetMapping("/teampage/postWriteForm")
    public String writeForm(Model model){
        model.addAttribute("pride", new PrideVO());
        return "teampage/postWriteForm";
    }

    //글쓰기 요청 처리
    @PostMapping("/write")
    public String write(@ModelAttribute PrideVO pride){
        service.write(pride);
        return "redirect:/pride/list";
    }

    // * 팀자랑 상세 페이지 요청 처리
    @GetMapping("/detail/{id}")
    public String detailNoDb(@PathVariable Long id) {
        return "pride/pridepage";   // /WEB-INF/views/pride/pridepage.jsp
    }
}
