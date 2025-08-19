package com.javaex.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.javaex.service.PerforInfoService;
import com.javaex.vo.PerforInfoVO;

@Controller
@RequestMapping("/onespace/perforinfo")
public class PerforInfoController {

    @Autowired
    private PerforInfoService service;

    /** ----- 세션 유틸 ----- */
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

    /** 작성 폼 */
    @GetMapping("/writeForm")
    public String writeForm(HttpSession session) {
        if (get_userno(session) == null) {
            return "redirect:/onespace/loginForm";
        }
        return "admin/perforinfo/perforlist_write";
    }

    /** 작성 처리 (업로드 포함: DB에는 파일명만 저장) */
    @PostMapping("/write")
    public String write(PerforInfoVO vo, HttpSession session) {
        Long userno = get_userno(session);
        String username = get_username(session);
        if (userno == null) {
            return "redirect:/onespace/loginForm";
        }

        vo.setUserNo(userno);
        vo.setUsername(username);
        vo.setAgencyName(username);

        if (vo.getInfoImgFile() != null && !vo.getInfoImgFile().isEmpty()) {
            String savedName = service.exeUpload(vo.getInfoImgFile());
            if (savedName != null) vo.setInfoImg(savedName);
        }

        Long postNo = service.insert(vo);
        return "redirect:/onespace/perforinfo/view?no=" + postNo;
    }

    /** 목록 */
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

    /** 상세 */
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

    /** 업로드 파일 서빙 (경로 탈출 방지 + 서비스와 동일 루트 사용) */
    @GetMapping("/upload/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serve(@PathVariable String filename) throws IOException {
        // filename에 경로 요소 금지
        if (filename.contains("..") || filename.contains("/") || filename.contains("\\")) {
            return ResponseEntity.badRequest().build();
        }

        File file = new File(PerforInfoService.UPLOAD_ROOT, filename).getAbsoluteFile();
        boolean exists = file.exists() && file.canRead();

        System.out.println("[IMG] request='" + filename + "'");
        System.out.println("      path='" + file.getAbsolutePath() + "', exists=" + exists);

        if (!exists) return ResponseEntity.notFound().build();

        FileSystemResource resource = new FileSystemResource(file);
        return ResponseEntity.ok()
                .contentType(MediaTypeFactory.getMediaType(filename)
                        .orElse(MediaType.APPLICATION_OCTET_STREAM))
                .cacheControl(CacheControl.noCache())
                .body(resource); 
    }
}
