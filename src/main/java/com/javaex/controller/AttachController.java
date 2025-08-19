package com.javaex.controller;

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

import com.javaex.service.AttachService;

import java.io.File;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping("/attach")
public class AttachController {

    @Autowired
    private AttachService attachService;

    // os별 저장 루트 폴더 (서비스와 동일 로직)
    private String basedir() {
        String os = System.getProperty("os.name").toLowerCase();
        return os.contains("win") ? "C:\\javaStudy\\upload\\" : "/data/upload/";
    }

    @RequestMapping(value="/form", method={RequestMethod.GET, RequestMethod.POST})
    public String form() {
        return "attach/form";
    }

    @RequestMapping(value="/upload", method={RequestMethod.GET, RequestMethod.POST})
    public String upload(@RequestParam("file") MultipartFile file, Model model) {
        String saveName = attachService.exeUpload(file);

        // 뷰에서 바로 쓸 수 있는 접근 URL 만들어서 넘김
        String fileUrl = "/attach/img/" + saveName;
        model.addAttribute("saveName", saveName);
        model.addAttribute("fileUrl", fileUrl);

        return "attach/result";
    }

    // **** 이미지 바이너리 서빙 엔드포인트 (가장 중요) ****
    @GetMapping("/img/{name}")
    @ResponseBody
    public ResponseEntity<Resource> serveImage(@PathVariable("name") String name) {
        File file = new File(basedir(), name);
        if (!file.exists() || !file.isFile()) {
            return ResponseEntity.notFound().build();
        }

        Resource resource = new FileSystemResource(file);
        MediaType mediaType = MediaTypeFactory.getMediaType(resource).orElse(MediaType.APPLICATION_OCTET_STREAM);

        return ResponseEntity.ok()
                .contentType(mediaType)
                .cacheControl(CacheControl.maxAge(30, TimeUnit.DAYS)) // 캐시 선택
                .body(resource);
    }

    @RequestMapping(value="/result", method={RequestMethod.GET, RequestMethod.POST})
    public String result() {
        return "attach/result";
    }
}
