package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    // 팀자랑 리스트 (DB에서 첫 페이지 12개)
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue="0") int page,
                       @RequestParam(defaultValue="12") int size,
                       Model model){
        Map<String,Object> p = service.page(page, size);

        @SuppressWarnings("unchecked")
        List<PrideVO> items = (List<PrideVO>) p.get("items");

        model.addAttribute("list", items);
        model.addAttribute("total", p.get("total"));
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        return "pride/pridemain";
    }

    // 팀자랑 목록 데이터 API (무한스크롤/Ajax용)
    @ResponseBody
    @GetMapping("/api")
    public Map<String,Object> api(@RequestParam(defaultValue="0") int page,
                                  @RequestParam(defaultValue="12") int size){
        return service.page(page, size);
    }

    // 팀자랑 상세
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        PrideVO pride = service.get(id);
        if (pride == null) {
            return "redirect:/pride/list";
        }
        model.addAttribute("pride", pride);
        return "pride/pridepage";
    }

    // ✅ 글쓰기는 팀페이지에서 처리 → 아래 두 메서드는 삭제
    // @GetMapping("/teampage/postWriteForm") ...
    // @PostMapping("/write") ...
}
