package com.javaex.controller;

import java.util.HashMap;
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

    public PrideController(PrideService service) {
        this.service = service;
    }

    // 팀자랑 리스트 (첫 페이지 12개)
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue="1") int page,
                       @RequestParam(defaultValue="12") int size,
                       Model model) {
        List<PrideVO> list = service.getCards(page, size); // ← PrideVO 리스트
        model.addAttribute("list", list);
        model.addAttribute("totalCount", service.getTotalCount());
        return "pride/pridemain";
    }

    // 팀자랑 목록 데이터 API (무한스크롤/Ajax용)
    @ResponseBody
    @GetMapping("/api")
    public Map<String, Object> api(@RequestParam(defaultValue = "1") int page,
                                   @RequestParam(defaultValue = "12") int size) {

        // 서비스에 page()가 없으면 아래처럼 바로 구성해도 됩니다.
        List<PrideVO> list = service.getCards(page, size);
        int total = service.getTotalCount();

        Map<String, Object> res = new HashMap<>();
        res.put("list", list);
        res.put("totalCount", total);
        res.put("page", page);
        res.put("size", size);
        res.put("hasMore", page * size < total);
        return res;
    }

 // PrideController.java
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
      PrideVO pride = service.getDetail(id);
      if (pride == null) return "redirect:/pride/pridemain";
      model.addAttribute("pride", pride);
      model.addAttribute("images", service.getImages(id)); // ★ 추가
      return "pride/pridepage";
    }
}
