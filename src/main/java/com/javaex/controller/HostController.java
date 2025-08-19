package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

        // ViewResolver 무시, 물리경로로 forward (파일은 그대로)
        return "forward:/WEB-INF/views/admin/host/host_manage_added.jsp";
    }

    // --기본 정보 관리(추가/수정 화면)
    @RequestMapping(value="/info", method={RequestMethod.GET, RequestMethod.POST})
    public String info(Model model,
                       HttpSession session,
                       @RequestParam(value="spacesno", required=false) Long spacesno) {
        System.out.println("HostController.info()");

        // 로그인 체크
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) {
            System.out.println("HostController.info(): not logged in");
            return "redirect:/onespace/loginForm";
        }

        Long userno = Long.valueOf(authUser.getUserNo()); // int -> Long

        // [기존] 호스트 기본정보 (필요 시 사용)
        HostVO hostinfo = hostService.gethostinfo(userno);
        if (hostinfo == null) {
            hostinfo = new HostVO(); // JSP NPE 방지
            System.out.println("HostController.info(): hostinfo is null -> new HostVO()");
        } else {
            System.out.println("HostController.info(): loaded hostinfo for userno=" + userno);
        }

        // [추가] 수정 모드면 단건 조회, 아니면 빈 객체
        HostVO space;
        if (spacesno != null) {
            space = hostService.get_space_for_edit(userno, spacesno);
            if (space == null) {
                // 남의 글이거나 없는 글이면 목록으로
                return "redirect:/onespace/hostcenter/spaces";
            }
        } else {
            space = new HostVO();
            space.setUserno(userno);
        }

        model.addAttribute("hostInfo", hostinfo);
        model.addAttribute("space", space); // ★ 폼 프리필용
        model.addAttribute("tab", "info");

        // 물리경로 forward
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    // --저장 (신규/수정 공용)
    @RequestMapping(value="/info/save", method=RequestMethod.POST)
    public String save(@ModelAttribute HostVO vo, HttpSession session) {
        System.out.println("HostController.save()");
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return "redirect:/onespace/loginForm";

        Long userno = Long.valueOf(authUser.getUserNo());
        vo.setUserno(userno); // 보안: 세션 기준으로 고정

        if (vo.getSpacesno() == null) {
            // 신규
            hostService.insert_space(vo);
        } else {
            // 수정: 소유자 검증
            HostVO owner = hostService.get_space_for_edit(userno, vo.getSpacesno());
            if (owner == null) {
                return "redirect:/onespace/hostcenter/spaces";
            }
            hostService.update_space(vo);
        }
        return "redirect:/onespace/hostcenter/spaces";
    }
}
