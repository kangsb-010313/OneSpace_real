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
    public String form_spaces_new(HttpSession session, Model model) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";
        // 필요 시 기본값 model.addAttribute(...)
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    // ★ 공간 생성(저장) — 폼 action: POST /onespace/hostcenter/spaces
    @PostMapping("/spaces")
    public String spaces_create(@ModelAttribute HostVO vo, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";
        vo.setUserno(userno);              // 소문자 필드 사용 가정
        hostService.createSpace(vo);       // 서비스 메서드명에 맞게 구현
        return "redirect:/onespace/hostcenter/spaces";
    }

    // 공간 수정 폼 (기존)
    @GetMapping("/info")
    public String form_spaces_edit(@RequestParam("spacesno") Long spacesNo,
                                   Model model,
                                   HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";

        HostVO space = hostService.getSpace(spacesNo);
        if (space == null || !space.getUserno().equals(userno)) {
            return "redirect:/onespace/hostcenter/spaces";
        }
        model.addAttribute("space", space);
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    // ★ 공간 수정(저장) — 폼 action: POST /onespace/hostcenter/info
    @PostMapping("/info")
    public String spaces_update(@ModelAttribute HostVO vo, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";

        // 권한 체크(내 글만 수정)
        HostVO old = hostService.getSpace(vo.getSpacesno()); // vo 안에 spacesno 있어야 함
        if (old == null || !old.getUserno().equals(userno)) {
            return "redirect:/onespace/hostcenter/spaces";
        }
        vo.setUserno(userno);
        hostService.updateSpace(vo);
        return "redirect:/onespace/hostcenter/spaces";
    }

    // 연습실 등록 폼
    @GetMapping("/rooms/new")
    public String form_rooms(@RequestParam("spacesNo") Long spacesNo, Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";
        model.addAttribute("spacesNo", spacesNo);
        return "forward:/WEB-INF/views/admin/host/host_info2.jsp";
    }

    // ★ 연습실 저장 — 폼 action: POST /onespace/hostcenter/rooms
    @PostMapping("/rooms")
    public String rooms_create(@ModelAttribute /*RoomsVO 또는 DTO*/ Object vo,
                               @RequestParam(value="files", required=false) org.springframework.web.multipart.MultipartFile[] files,
                               HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/onespace/loginForm";
        // hostService.saveRoom(vo, files); // 실제 구현에 맞게 호출
        return "redirect:/onespace/hostcenter/spaces";
    }
}
