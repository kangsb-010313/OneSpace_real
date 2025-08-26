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
import com.javaex.service.RoomService;
import com.javaex.vo.HostVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.TeamAttachmentsVO;

@Controller
@RequestMapping("/onespace/hostcenter")
public class HostController {

    @Autowired private HostService hostService;
    @Autowired private AttachService attachService;
    @Autowired private RoomService roomService;

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

        // 기존: model.addAttribute("list", list);
        model.addAttribute("spaces", list);   // ★ JSP가 기대하는 키로 변경

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

    /** 연습실 수정 폼: /onespace/hostcenter/rooms/{roomNo}/edit */
    @GetMapping("/rooms/{roomNo}/edit")
    public String editRoom(@PathVariable Long roomNo,
                           @RequestParam(required = false) Long spacesNo,
                           Model model) {
        // 반드시 인스턴스 주입된 roomService 사용!
        RoomsVO vo = roomService.get_detail(roomNo);   // room + prices + photos
        if (vo == null) return "redirect:/onespace/hostcenter/spaces";

        // spacesNo 파라미터가 안 오면 DB에서 가져온 값 사용
        if (spacesNo == null) spacesNo = vo.getSpacesNo();

        model.addAttribute("vo", vo);           // ★ info2.jsp는 ${vo.*}로 프리필
        model.addAttribute("spacesNo", spacesNo);
        return "admin/host/host_info2";        // 연습실 폼
    }

    /** (신규) 잘못 들어온 /rooms/edit → 정상 경로로 리다이렉트 */
    @GetMapping("/rooms/edit")
    public String roomsEditRedirect(@RequestParam(required = false) Long roomNo,
                                    @RequestParam(required = false) Long spacesNo) {
        // roomNo 없이 들어오면 목록으로 회피 (404 방지)
        if (roomNo == null) {
            return "redirect:/onespace/hostcenter/spaces";
        }
        String url = "/onespace/hostcenter/rooms/" + roomNo + "/edit";
        if (spacesNo != null) url += "?spacesNo=" + spacesNo;
        return "redirect:" + url;
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
