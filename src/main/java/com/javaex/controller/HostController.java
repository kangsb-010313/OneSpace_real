package com.javaex.controller;

import java.util.List;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.javaex.service.HostService;
import com.javaex.vo.HostVO;

@Controller
@RequestMapping("/onespace/hostcenter")
public class HostController {

    private final HostService hostService;

    public HostController(HostService hostService) {
        this.hostService = hostService;
    }

    private Long get_login_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long) return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        return null;
    }

    // 루트 → 내 공간 관리
    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/onespace/hostcenter/spaces";
    }

    // 내 공간 관리 (리스트)
    @GetMapping("/spaces")
    public String spaces(Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";
        List<HostVO> list = hostService.getSpacesByUser(userno);
        model.addAttribute("spaces", list);
        return "/admin/host/host_manage_added";
    }

    // 공간 등록 폼 (신규)
    @GetMapping("/spaces/new")
    public String form_spaces_new() {
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    // 공간 수정 폼 (기존)  ← ★ 수정하기 버튼이 여기를 타서 404가 해결됨
    @GetMapping("/info")
    public String form_spaces_edit(@RequestParam("spacesno") Long spacesNo,
                                   Model model,
                                   HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";

        HostVO space = hostService.getSpace(spacesNo);
        if (space == null || !space.getUserno().equals(userno)) {
            // 남의 공간 접근 차단: 리스트로 돌려보냄
            return "redirect:/onespace/hostcenter/spaces";
        }
        model.addAttribute("space", space);
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    // 연습실 등록 폼
    @GetMapping("/rooms/new")
    public String form_rooms(@RequestParam("spacesNo") Long spacesNo, Model model) {
        model.addAttribute("spacesNo", spacesNo);
        return "forward:/WEB-INF/views/admin/host/host_info2.jsp";
    }
}
