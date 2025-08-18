package com.javaex.controller;

import java.util.List;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.javaex.service.PerforInfoService;
import com.javaex.vo.PerforInfoVO;

@Controller
@RequestMapping("/onespace/perforinfo")
public class PerforInfoController {

    private final PerforInfoService service;

    public PerforInfoController(PerforInfoService service) {
        this.service = service;
    }

    private Long get_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long) return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        return null;
    }

    private String get_username(HttpSession session) {
        Object v = session.getAttribute("authUserName");
        return (v != null) ? String.valueOf(v) : null;
    }

    // 목록
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "10") int size,
                       Model model, HttpSession session) {

        long total = service.count();
        int offset = (page - 1) * size;
        List<PerforInfoVO> list = service.listPaged(offset, size);

        model.addAttribute("list", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("authUserNo", get_userno(session));
        model.addAttribute("authUserName", get_username(session));

        return "admin/perforinfo/perforlist";
    }

    // 작성폼
    @GetMapping("/writeForm")
    public String writeForm(HttpSession session) {
        if (get_userno(session) == null) {
            return "redirect:/onespace/loginForm";
        }
        return "admin/perforinfo/perforlist_write";
    }

    // 작성 처리
    @PostMapping("/write")
    public String write(@ModelAttribute PerforInfoVO vo, HttpSession session) {
        Long userno = get_userno(session);
        String username = get_username(session);

        if (userno == null) {
            return "redirect:/onespace/loginForm";
        }

        vo.setUserNo(userno);
        vo.setUsername(username);
        Long postNo = service.insert(vo);

        return "redirect:/onespace/perforinfo/view?no=" + postNo;
    }

    // 상세보기
    @GetMapping("/view")
    public String view(@RequestParam("no") long no, Model model, HttpSession session) {
        PerforInfoVO vo = service.get(no);
        if (vo == null) {
            return "redirect:/onespace/perforinfo/list";
        }

        Long loginNo = get_userno(session);
        boolean isOwner = (loginNo != null && loginNo.equals(vo.getUserNo()));

        model.addAttribute("vo", vo);
        model.addAttribute("isOwner", isOwner);
        model.addAttribute("authUserNo", loginNo);

        return "admin/perforinfo/perforlist_view";
    }
}
