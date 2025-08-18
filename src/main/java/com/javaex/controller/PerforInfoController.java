package com.javaex.controller;

import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        return null;
    }

    private String get_username(HttpSession session) {
        Object v = session.getAttribute("authUserName");
        return (v != null) ? String.valueOf(v) : null;
    }

    // 목록
    @RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
    public String list(Model model) {
        System.out.println("PerforInfoController.list()");
        List<PerforInfoVO> list = service.list();
        model.addAttribute("list", list);
        return "admin/perforinfo/perforlist";
    }

    // 글쓰기 폼
    @RequestMapping(value="/writeForm", method={RequestMethod.GET, RequestMethod.POST})
    public String writeForm() {
        System.out.println("PerforInfoController.writeForm()");
        return "admin/perforinfo/perforlist_write";
    }

    // 글쓰기 처리 (폼 name 유지: title/url/category/closedate/region/content)
    @RequestMapping(value="/write", method={RequestMethod.GET, RequestMethod.POST})
    public String writeSubmit(
            @RequestParam("title") String title,
            @RequestParam(value="url", required=false) String url,
            @RequestParam("category") String category,                 // → infoPostType
            @RequestParam(value="closedate", required=false) String closedate, // → deadlineDate
            @RequestParam(value="region", required=false) String region,       // → infoArea
            @RequestParam(value="content", required=false) String content,
            @RequestParam(value="agencyName", required=false) String agencyName, // 선택 입력
            HttpSession session
    ) {
        System.out.println("PerforInfoController.writeSubmit()");

        PerforInfoVO vo = new PerforInfoVO();

        // 세션값
        Long userno = get_userno(session);
        String username = get_username(session);

        // DB 스키마(infowrite)에 맞춰 매핑
        vo.setUserNo(userno);
        vo.setInfoPostTitle(title);
        vo.setInfoOutUrl(url);
        vo.setInfoPostType(category);
        vo.setInfoArea(region);
        vo.setInfoContent(content);

        // agencyName: 폼 값이 없으면 작성자명으로 세팅(원치 않으면 null 유지)
        if (agencyName != null && !agencyName.isBlank()) {
            vo.setAgencyName(agencyName);
        } else {
            vo.setAgencyName(username);
        }

        // 마감일 파싱 (input type="date" 가정: yyyy-MM-dd)
        if (closedate != null && !closedate.isBlank()) {
            try {
                vo.setDeadlineDate(LocalDate.parse(closedate));
            } catch (Exception e) {
                vo.setDeadlineDate(null);
            }
        }

        // 이미지 컬럼은 현재 폼 없음 → null
        vo.setPerforImg(null);
        vo.setInfoImg(null);

        Long newNo = service.add(vo); // 반환: infoPostNo
        return "redirect:/onespace/perforinfo/view?no=" + newNo;
    }

    // 상세
    @RequestMapping(value="/view", method={RequestMethod.GET, RequestMethod.POST})
    public String view(@RequestParam("no") Long no, Model model) {
        System.out.println("PerforInfoController.view()");
        PerforInfoVO vo = service.get(no); // 매퍼에서 where infoPostNo = #{no}
        model.addAttribute("vo", vo);
        return "admin/perforinfo/perforlist_view";
    }
}
