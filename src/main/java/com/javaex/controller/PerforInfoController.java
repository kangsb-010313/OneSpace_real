package com.javaex.controller;

import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.PerforInfoService;
import com.javaex.vo.PerforInfoVO;

@Controller
@RequestMapping(value="/onespace/perforinfo")
public class PerforInfoController {

    @Autowired
    private PerforInfoService service;

    // 로그인 사용자 번호 헬퍼
    private Long get_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long) return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        return null; // 비로그인 허용 시 null
    }

    private String get_username(HttpSession session) {
        Object v = session.getAttribute("authUserName");
        return (v != null) ? String.valueOf(v) : null;
    }

    // --목록 페이지
    @RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
    public String list(Model model) {
        System.out.println("PerforInfoController.list()");
        List<PerforInfoVO> list = service.list();
        model.addAttribute("list", list);
        return "admin/perforinfo/perforlist"; 
    }

    // --글쓰기 폼
    @RequestMapping(value="/writeForm", method={RequestMethod.GET, RequestMethod.POST})
    public String writeForm() {
        System.out.println("PerforInfoController.writeForm()");
        return "admin/perforinfo/perforlist_write"; 
    }

    // --글쓰기 처리
    @RequestMapping(value="/write", method={RequestMethod.GET, RequestMethod.POST})
    public String writeSubmit(
            @RequestParam("title") String title,
            @RequestParam(value="url", required=false) String url,
            @RequestParam("category") String category,
            @RequestParam(value="closedate", required=false) String closedate,
            @RequestParam(value="region", required=false) String region,
            @RequestParam(value="content", required=false) String content,
            HttpSession session
    ) {
        System.out.println("PerforInfoController.writeSubmit()");

        PerforInfoVO vo = new PerforInfoVO();
        vo.setTitle(title);
        vo.setUrl(url);
        vo.setCategory(category);
        vo.setRegion(region);
        vo.setContent(content);

        if (closedate != null && !closedate.isBlank()) {
            vo.setClosedate(LocalDate.parse(closedate));
        }

        Long userno = get_userno(session);
        String username = get_username(session);
        vo.setUserno(userno);
        vo.setUsername(username);

        Long newNo = service.add(vo);
        return "redirect:/onespace/perforinfo/view?no=" + newNo;
    }

    // --상세 페이지
    @RequestMapping(value="/view", method={RequestMethod.GET, RequestMethod.POST})
    public String view(@RequestParam("no") Long no, Model model) {
        System.out.println("PerforInfoController.view()");
        PerforInfoVO vo = service.get(no);
        model.addAttribute("vo", vo);
        return "admin/perforinfo/perforlist_view";  
    }
}
