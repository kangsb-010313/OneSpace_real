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
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.PerforInfoService;
import com.javaex.vo.PerforInfoVO;

@Controller
@RequestMapping("/onespace/perforinfo")
public class PerforInfoController {

    @Autowired
    private PerforInfoService service;

    // ---- 업로드 루트 (OS별 분기)
    private final String uploadRoot =
            System.getProperty("os.name").toLowerCase().contains("win")
                    ? "C:/javaStudy/upload/"
                    : "/data/upload/";

    // ---- 세션 유틸
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

    // ---- 작성 폼
    @RequestMapping(value = "/writeForm", method = {RequestMethod.GET, RequestMethod.POST})
    public String writeForm(HttpSession session) {
        System.out.println("PerforInfoController.writeForm()");
        if (get_userno(session) == null) {
            return "redirect:/onespace/loginForm";
        }
        return "admin/perforinfo/perforlist_write";
    }

    // ---- 작성 처리 (업로드 폴더 자동 생성 + OS별 분기)
    @RequestMapping(value = "/write", method = {RequestMethod.GET, RequestMethod.POST})
    public String write(@ModelAttribute PerforInfoVO vo, HttpSession session) {
        System.out.println("PerforInfoController.write()");

        Long userno = get_userno(session);
        String username = get_username(session);
        if (userno == null) {
            return "redirect:/onespace/loginForm";
        }

        vo.setUserNo(userno);
        vo.setUsername(username);
        vo.setAgencyName(username);

        MultipartFile file = vo.getInfoImgFile();
        if (file != null && !file.isEmpty()) {
            String savedName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            vo.setInfoImg(savedName); // DB에는 파일명만 저장

            // 폴더 없으면 생성
            File dir = new File(uploadRoot);
            if (!dir.exists()) {
                boolean mk = dir.mkdirs();
                System.out.println("upload dir created? " + mk + " : " + dir.getAbsolutePath());
            }

            try {
                File dest = new File(dir, savedName);
                file.transferTo(dest);
                System.out.println("saved file: " + dest.getAbsolutePath());
            } catch (IOException e) {
                System.err.println("File save failed: " + e.getMessage());
            }
        }

        Long postNo = service.insert(vo);
        return "redirect:/onespace/perforinfo/view?no=" + postNo;
    }

    // ---- 목록 보기
    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "10") int size,
                       Model model, HttpSession session) {
        System.out.println("PerforInfoController.list()");

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

    // ---- 상세 보기
    @RequestMapping(value = "/view", method = {RequestMethod.GET, RequestMethod.POST})
    public String view(@RequestParam("no") long no, Model model, HttpSession session) {
        System.out.println("PerforInfoController.view()");

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

    // ---- 정적 매핑 없이 파일 서빙: /upload/{filename} 와 /onespace/perforinfo/upload/{filename} 둘 다 지원
    @GetMapping(path = {"/upload/{filename:.+}", "/../upload/{filename:.+}", "/../../upload/{filename:.+}"})
    @ResponseBody
    public ResponseEntity<Resource> serveFromNested(@PathVariable String filename) {
        // 위 해킹은 안전치 않음 — 대신 아래와 같이 절대 경로 매핑을 추가:
        return serve(filename);
    }

    @GetMapping(path = {"/onespace/perforinfo/upload/{filename:.+}", "/upload/{filename:.+}"})
    @ResponseBody
    public ResponseEntity<Resource> serve(@PathVariable String filename) {
        File file = new File(uploadRoot, filename);
        FileSystemResource resource = new FileSystemResource(file);

        if (!resource.exists() || !resource.isReadable()) {
            return ResponseEntity.notFound().build();
        }

        MediaType mediaType = MediaTypeFactory.getMediaType(filename)
                .orElse(MediaType.APPLICATION_OCTET_STREAM);

        return ResponseEntity.ok()
                .contentType(mediaType)
                .cacheControl(CacheControl.noCache())
                .body(resource);
    }
}
