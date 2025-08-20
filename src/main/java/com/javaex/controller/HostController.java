package com.javaex.controller;

import java.util.List;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.javaex.service.HostService;
import com.javaex.vo.SpacesVO;

@Controller
@RequestMapping("/onespace/hostcenter")
public class HostController {

    @Autowired
    private HostService hostService;

    // 세션 헬퍼: authUserNo를 Long으로 꺼내기
    private Long get_login_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long) return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        return null;
    }

    // 루트 → 내 공간 관리로 리다이렉트
    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/onespace/hostcenter/spaces";
    }

    // 내 공간 관리 (리스트)
    @GetMapping("/spaces")
    public String spaces(Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";

        List<SpacesVO> list = hostService.getSpacesByUser(userno);
        model.addAttribute("spaces", list);

        return "/admin/host/host_manage_added";
    }

    // 공간 등록 폼
    @GetMapping("/spaces/new")
    public String form_spaces() {
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    // 연습실 등록 폼
    @GetMapping("/rooms/new")
    public String form_rooms(@RequestParam("spacesNo") Long spacesNo, Model model) {
        model.addAttribute("spacesNo", spacesNo);
        return "forward:/WEB-INF/views/admin/host/host_info2.jsp";
    }
}
