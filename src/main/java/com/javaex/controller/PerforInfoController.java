package com.javaex.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.PerforInfoService;
import com.javaex.vo.PerforInfoVO;

@Controller
@RequestMapping("/onespace/perforinfo")
public class PerforInfoController {

    @Autowired
    private PerforInfoService service;

    // ==================================
    // 세션 헬퍼들 (여러 형태 지원)
    // ==================================
    private Long get_userno(HttpSession session) {
        Object v = session.getAttribute("authUserNo");
        if (v instanceof Long)    return (Long) v;
        if (v instanceof Integer) return ((Integer) v).longValue();
        if (v instanceof String)  { try { return Long.parseLong((String) v);} catch (Exception ignore) {} }

        Object au = session.getAttribute("authUser");
        if (au != null) {
            // VO/DTO에 getUserNo() 또는 getNo()가 있을 수 있음
            try {
                var m = au.getClass().getMethod("getUserNo");
                Object noVal = m.invoke(au);
                if (noVal instanceof Long)    return (Long) noVal;
                if (noVal instanceof Integer) return ((Integer) noVal).longValue();
                if (noVal instanceof String)  return Long.parseLong((String) noVal);
            } catch (Exception ignore) {}
            try {
                var m = au.getClass().getMethod("getNo");
                Object noVal = m.invoke(au);
                if (noVal instanceof Long)    return (Long) noVal;
                if (noVal instanceof Integer) return ((Integer) noVal).longValue();
                if (noVal instanceof String)  return Long.parseLong((String) noVal);
            } catch (Exception ignore) {}
            if (au instanceof Map<?, ?> map) {
                Object noVal = map.get("userNo");
                if (noVal == null) noVal = map.get("no");
                if (noVal instanceof Long)    return (Long) noVal;
                if (noVal instanceof Integer) return ((Integer) noVal).longValue();
                if (noVal instanceof String)  { try { return Long.parseLong((String) noVal);} catch (Exception ignore) {} }
            }
        }
        return null;
    }

    private String get_username(HttpSession session) {
        Object v = session.getAttribute("authUserName");
        if (v != null) return String.valueOf(v);

        Object au = session.getAttribute("authUser");
        if (au != null) {
            // UserVO.getUserName() 우선
            try {
                var m = au.getClass().getMethod("getUserName");
                Object nv = m.invoke(au);
                if (nv != null) return String.valueOf(nv);
            } catch (Exception ignore) {}
            // 그다음 getName()
            try {
                var m = au.getClass().getMethod("getName");
                Object nv = m.invoke(au);
                if (nv != null) return String.valueOf(nv);
            } catch (Exception ignore) {}
            // Map 형태 지원
            if (au instanceof Map<?, ?> map) {
                Object nv = map.get("userName");
                if (nv == null) nv = map.get("name");
                if (nv != null) return String.valueOf(nv);
            }
        }
        return null;
    }

    // ==================================
    // 목록 (페이징)
    // ==================================
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "10") int size,
                       Model model) {

        if (page < 1) page = 1;
        if (size < 1 || size > 100) size = 10;

        long total = service.count();
        int totalPages = (int) Math.ceil((double) total / size);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        int offset = (page - 1) * size;

        List<PerforInfoVO> list = service.list_paged(offset, size);

        // 페이지 블록
        int blockSize = 5;
        int blockStart = ((page - 1) / blockSize) * blockSize + 1;
        int blockEnd = Math.min(blockStart + blockSize - 1, totalPages);
        boolean hasPrev = page > 1;
        boolean hasNext = page < totalPages;

        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("total", total);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("blockStart", blockStart);
        model.addAttribute("blockEnd", blockEnd);
        model.addAttribute("hasPrev", hasPrev);
        model.addAttribute("hasNext", hasNext);

        return "admin/perforinfo/perforlist";
    }

    // 글쓰기 폼
    @GetMapping("/writeForm")
    public String writeForm() {
        return "admin/perforinfo/perforlist_write";
    }

    // 글쓰기 처리: 작성자명은 "글 쓴 계정 이름"으로 고정 저장
    @PostMapping("/write")
    public String writeSubmit(
            @RequestParam("infoPostTitle") String infoPostTitle,
            @RequestParam(value = "infoOutUrl", required = false) String infoOutUrl,
            @RequestParam("infoPostType") String infoPostType,
            @RequestParam(value = "deadlineDate", required = false) String deadlineDate,
            @RequestParam(value = "infoArea", required = false) String infoArea,
            @RequestParam(value = "infoContent", required = false) String infoContent,
            @RequestParam(value = "perforImg", required = false) MultipartFile perforImg,
            HttpSession session
    ) {
        Long userNo = get_userno(session);
        if (userNo == null) {
            return "redirect:/onespace/loginForm";
        }
        String userName = get_username(session);

        PerforInfoVO vo = new PerforInfoVO();
        vo.setUserNo(userNo);
        vo.setInfoPostTitle(infoPostTitle);
        vo.setInfoOutUrl(infoOutUrl);
        vo.setInfoPostType(infoPostType);
        vo.setInfoArea(infoArea);
        vo.setInfoContent(infoContent);

        // 작성자 = 로그인 계정 이름으로 저장
        vo.setAgencyName(userName != null ? userName : "");

        if (deadlineDate != null && !deadlineDate.isBlank()) {
            try { vo.setDeadlineDate(LocalDate.parse(deadlineDate)); }
            catch (Exception e) { vo.setDeadlineDate(null); }
        }

        // 파일 저장 로직은 생략, 파일명만 저장 (선택)
        if (perforImg != null && !perforImg.isEmpty()) {
            vo.setPerforImg(perforImg.getOriginalFilename());
        } else {
            vo.setPerforImg(null);
        }
        vo.setInfoImg(null);

        Long newNo = service.add(vo);
        if (newNo == null) {
            return "redirect:/onespace/perforinfo/list";
        }
        return "redirect:/onespace/perforinfo/view?no=" + newNo;
    }

    // 상세
    @GetMapping("/view")
    public String view(@RequestParam("no") Long no, Model model) {
        PerforInfoVO vo = service.get(no);
        model.addAttribute("vo", vo);
        return "admin/perforinfo/perforlist_view";
    }
}
