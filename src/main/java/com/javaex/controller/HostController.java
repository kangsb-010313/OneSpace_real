package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.HostService;
import com.javaex.vo.HostVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/onespace/hostcenter")
public class HostController {

    // 필드
    @Autowired
    private HostService hostService;

    // --호스트센터 루트 -> /spaces 로 리다이렉트
    @RequestMapping(value={"", "/"}, method={RequestMethod.GET, RequestMethod.POST})
    public String index() {
        System.out.println("HostController.index()");
        return "redirect:/onespace/hostcenter/spaces";
    }

    // --내 공간 관리(리스트 화면)
    @RequestMapping(value="/spaces", method={RequestMethod.GET, RequestMethod.POST})
    public String spaces(Model model, HttpSession session) {
        System.out.println("HostController.spaces()");

        // 로그인 체크
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            System.out.println("HostController.spaces(): not logged in");
            return "redirect:/onespace/loginForm";
        }

        Long userno = Long.valueOf(authUser.getUserNo()); // int -> Long
        List<HostVO> list = hostService.list_spaces(userno);

        System.out.println("HostController.spaces(): userno=" + userno);
        System.out.println("HostController.spaces(): list.size=" + (list == null ? "null" : list.size()));

        model.addAttribute("spaces", list);
        model.addAttribute("tab", "spaces");

        // B안: ViewResolver 무시, 물리경로로 forward (파일은 그대로)
        return "forward:/WEB-INF/views/admin/host/host_manage_added.jsp";
    }

    // --기본 정보 관리(추가/수정 화면)
    @RequestMapping(value="/info", method={RequestMethod.GET, RequestMethod.POST})
    public String info(Model model, HttpSession session) {
        System.out.println("HostController.info()");

        // 로그인 체크
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            System.out.println("HostController.info(): not logged in");
            return "redirect:/onespace/loginForm";
        }

        Long userno = Long.valueOf(authUser.getUserNo()); // int -> Long
        HostVO hostinfo = hostService.gethostinfo(userno);
        if (hostinfo == null) {
            hostinfo = new HostVO(); // JSP NPE 방지
            System.out.println("HostController.info(): hostinfo is null -> new HostVO()");
        } else {
            System.out.println("HostController.info(): loaded hostinfo for userno=" + userno);
        }

        model.addAttribute("hostInfo", hostinfo);
        model.addAttribute("tab", "info");

        // B안: ViewResolver 무시, 물리경로로 forward
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }
}
