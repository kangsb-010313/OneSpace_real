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

    // 루트 리다이렉트
    @GetMapping("/pride")
    public String redirectToList() {
        return "redirect:/pride/list";
    }

    // 목록 + 페이징 (JSP)
    @GetMapping("/pride/list")
    public String list(@RequestParam(name = "type",   required = false) String type,   // 서비스에서 기본 타입 보정
                       @RequestParam(name = "teamNo", required = false) Long teamNo,
                       @RequestParam(name = "page",   defaultValue = "1")  int page,
                       @RequestParam(name = "size",   defaultValue = "5")  int size,   // ★ 기본 5
                       Model model) {

        // 서비스가 size를 최대 5로 보정하므로 여기서는 그대로 위임
        Map<String, Object> m = prideService.getPridePage(type, teamNo, page, size);

        // JSP에서 쓰는 키들 주입
        model.addAllAttributes(m);
        model.addAttribute("list", m.get("content"));   // pridemain.jsp는 items="${list}" 사용
        return "pride/pridemain";
    }

    // 상세 ( /pride/{id}, /pride/detail/{id} 모두 허용 )
    @GetMapping({"/pride/{id}", "/pride/detail/{id}"})
    public String detail(@PathVariable Long id,
                         @RequestParam(name = "type",   required = false) String type,
                         @RequestParam(name = "teamNo", required = false) Long teamNo,
                         @RequestParam(name = "page",   defaultValue = "1") int page,
                         @RequestParam(name = "size",   defaultValue = "5") int size,   // ★ 기본 5
                         Model model) {

        Map<String, Object> m = prideService.getDetailModel(type, id);
        if (m == null) {
            // 상세 없으면 목록으로 리다이렉트 (현재 페이징/필터 유지)
            StringBuilder sb = new StringBuilder("redirect:/pride/list?page=").append(page)
                    .append("&size=").append(size);
            if (type != null && !type.isBlank())  sb.append("&type=").append(type);
            if (teamNo != null)                   sb.append("&teamNo=").append(teamNo);
            return sb.toString();
        }

        // JSP에서 post / pride 둘 다 참조 가능하도록 별칭 제공
        model.addAllAttributes(m);                 // post, images
        model.addAttribute("pride", m.get("post"));
        model.addAttribute("teamPostType", type);  // 링크 파라미터 유지용
        model.addAttribute("teamNo", teamNo);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        return "pride/pridepage";
    }

    // 목록 API (JSON)
    @GetMapping("/api/pride")
    @ResponseBody
    public Map<String, Object> listApi(@RequestParam(name = "teamNo", required = false) Long teamNo,
                                       @RequestParam(name = "page",   defaultValue = "1") int page,
                                       @RequestParam(name = "size",   defaultValue = "5") int size,   // ★ 기본 5
                                       @RequestParam(name = "type",   required = false) String type) {
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
