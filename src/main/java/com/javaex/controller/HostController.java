package com.javaex.controller;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.AttachService;
import com.javaex.service.HostService;
import com.javaex.vo.HostVO;
import com.javaex.vo.TeamAttachmentsVO;

@Controller
@RequestMapping("/onespace/hostcenter")
public class HostController {

    @Autowired private HostService hostService;
    @Autowired private AttachService attachService;

    /* --------------------- 세션 유틸 --------------------- */
    private Long get_login_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long)    return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        return null;
    }

    /* 루트 → /spaces */
    @RequestMapping(value = {"", "/"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String index() {
        return "redirect:/onespace/hostcenter/spaces";
    }

    /* 내 공간 관리(리스트) */
    @GetMapping("/spaces")
    public String spaces(Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/user/loginform";
        List<HostVO> list = hostService.getSpacesByUser(userno);
        model.addAttribute("list", list);
        return "forward:/WEB-INF/views/admin/host/host_manage_added.jsp";
    }

    /* 신규 등록 폼 */
    @GetMapping("/spaces/new")
    public String form_new(Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/user/loginform";
        HostVO empty = new HostVO();
        empty.setUserno(userno);
        model.addAttribute("space", empty);
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }

    /* 수정 폼 */
    @GetMapping("/spaces/{spacesNo}/edit")
    public String form_edit(@PathVariable Long spacesNo, Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/user/loginform";
        HostVO vo = hostService.getSpace(spacesNo);
        if (vo == null || vo.getUserno() == null || !vo.getUserno().equals(userno)) {
            return "redirect:/onespace/hostcenter/spaces";
        }
        model.addAttribute("space", vo);
        return "forward:/WEB-INF/views/admin/host/host_info2.jsp";
    }

    /* 신규 저장 */
    @PostMapping("/spaces/insert")
    public String insert(@ModelAttribute HostVO vo,
                         @RequestParam(value = "repImage", required = false) MultipartFile repImage,
                         HttpSession session) {

        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/user/loginform";
        vo.setUserno(userno);

        if (repImage != null && !repImage.isEmpty()) {
            TeamAttachmentsVO att = attachService.exeSave(repImage);
            if (att != null) vo.setRepimg(att.getTeamStoredFileName());
        }

        hostService.createSpace(vo); // useGeneratedKeys -> vo.spacesno
        // 저장 후 방 등록으로 이동
        return "redirect:/onespace/hostcenter/rooms/new?spacesNo=" + vo.getSpacesno();
    }

    /* 수정 저장 */
    @PostMapping("/spaces/update")
    public String update(@ModelAttribute HostVO vo,
                         @RequestParam(value = "repImage", required = false) MultipartFile repImage,
                         HttpSession session) {

        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/user/loginform";
        vo.setUserno(userno);

        if (repImage != null && !repImage.isEmpty()) {
            TeamAttachmentsVO att = attachService.exeSave(repImage);
            if (att != null) vo.setRepimg(att.getTeamStoredFileName());
        }

        hostService.updateSpace(vo);
        return "redirect:/onespace/hostcenter/spaces";
    }

    /* (선택) 단건 보기 */
    @GetMapping("/spaces/{spacesNo}")
    public String view(@PathVariable Long spacesNo, Model model, HttpSession session) {
        Long userno = get_login_userno(session);
        if (userno == null) return "redirect:/user/loginform";
        HostVO vo = hostService.getSpace(spacesNo);
        if (vo == null || !userno.equals(vo.getUserno())) {
            return "redirect:/onespace/hostcenter/spaces";
        }
        model.addAttribute("space", vo);
        return "forward:/WEB-INF/views/admin/host/host_info.jsp";
    }
}
