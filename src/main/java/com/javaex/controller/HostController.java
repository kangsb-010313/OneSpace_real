package com.javaex.controller;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.HostService;
import com.javaex.vo.HostVO;

@Controller
@RequestMapping(value="/onespace/hostcenter")
public class HostController {

    @Autowired
    private HostService hostService;

    // 로그인 사용자 번호를 세션에서 꺼내는 헬퍼 (프로젝트 세션키에 맞춰 수정)
    private Long get_login_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long) return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        return 1L; // 임시 기본값
    }
    
    @GetMapping({"", "/"})
    public String hostcenter_root() {
        return "redirect:/onespace/hostcenter/spaces";
    }

    @GetMapping("/info")
    public String info(Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        HostVO hostInfo = hostService.get_host_info(userno);

        model.addAttribute("hostInfo", hostInfo);
        model.addAttribute("tab", "info");
        return "/host/host_info";
    }

    @PostMapping("/info/save")
    public String info_save(@ModelAttribute HostVO form,
                            @RequestParam(value = "repImage", required = false) MultipartFile repImage,
                            HttpSession session) {
        Long userno = get_login_userno(session);
        hostService.save_host_info(userno, form, repImage);
        return "redirect:/onespace/hostcenter/info";
    }

    @GetMapping("/spaces")
    public String spaces(Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        List<HostVO> list = hostService.list_spaces(userno);

        model.addAttribute("spaces", list);
        model.addAttribute("tab", "spaces");
        return "/host/host_manage_added";
    }
}
