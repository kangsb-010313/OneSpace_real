package com.javaex.controller;

import com.javaex.service.PrideService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@Controller
@RequestMapping
public class PrideController {

    private final PrideService prideService;

    public PrideController(PrideService prideService) {
        this.prideService = prideService;
    }

    @GetMapping("/pride")
    public String redirectToList() { return "redirect:/pride/list"; }

 
    @GetMapping("/pride/list")
    public String list(@RequestParam(name="type",  required=false) String type,   // 기본값 주지 않음!
                       @RequestParam(name="teamNo", required=false) Long teamNo,
                       @RequestParam(name="page",  defaultValue="1")  int page,
                       @RequestParam(name="size",  defaultValue="12") int size,
                       Model model) {
        var m = prideService.getPridePage(type, teamNo, page, size);
        model.addAllAttributes(m);
        model.addAttribute("list", m.get("content"));      // pridemain.jsp 호환
        return "pride/pridemain";
    }

    // 상세: /pride/{id} 와 /pride/detail/{id} 둘 다 허용
    @GetMapping({"/pride/{id}", "/pride/detail/{id}"})
    public String detail(@PathVariable Long id,
                         @RequestParam(name="type", required=false) String type,
                         @RequestParam(name="teamNo", required=false) Long teamNo,
                         @RequestParam(name="page", defaultValue="1") int page,
                         @RequestParam(name="size", defaultValue="12") int size,
                         Model model) {
        var m = prideService.getDetailModel(type, id);
        if (m == null) {
            // 404 페이지 없으면 목록으로 돌려보내도 됨
            return "redirect:/pride/list?page="+page+"&size="+size
                   + (type!=null? "&type="+type : "")
                   + (teamNo!=null? "&teamNo="+teamNo : "");
        }
        model.addAllAttributes(m);                // post, images
        model.addAttribute("pride", m.get("post"));// ★ 기존 JSP 호환 별칭
        model.addAttribute("post",  m.get("post"));// 안전하게 post도 유지
        model.addAttribute("teamPostType", type);
        model.addAttribute("teamNo", teamNo);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        return "pride/pridepage";
    }

    // 목록 API (JSON)
    @GetMapping("/api/pride")
    @ResponseBody
    public Map<String, Object> listApi(@RequestParam(name = "teamNo", required = false) Long teamNo,
                                       @RequestParam(name = "page", defaultValue = "1") int page,
                                       @RequestParam(name = "size", defaultValue = "12") int size,
                                       @RequestParam(name = "type", required = false) String type) {
        return prideService.pageApiModel(teamNo, page, size, type);
    }

    // 상세 API (JSON)
    @GetMapping("/api/pride/{id}")
    public ResponseEntity<Map<String, Object>> detailApi(@PathVariable Long id,
                                                         @RequestParam(name = "type", required = false) String type) {
        Map<String, Object> m = prideService.getDetailModel(type, id);
        return (m == null) ? ResponseEntity.status(HttpStatus.NOT_FOUND).build()
                           : ResponseEntity.ok(m);
    }
}
