package com.javaex.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class AttachService {

    // os별 저장 루트 폴더 반환
    private String basedir() {
        String os = System.getProperty("os.name").toLowerCase();
        return os.contains("win") ? "C:\\javaStudy\\upload\\" : "/data/upload/";
    }

    public String exeUpload(MultipartFile file) {
        System.out.println("AttachService.exeUpload()");

        String orgName = file.getOriginalFilename();
        if (orgName == null || orgName.isEmpty()) throw new IllegalArgumentException("파일이 비어있음");

        String ext = orgName.substring(orgName.lastIndexOf('.') + 1);
        String saveName = System.currentTimeMillis() + java.util.UUID.randomUUID().toString() + "." + ext;

        String dir = basedir();
        java.io.File folder = new java.io.File(dir);
        if (!folder.exists()) folder.mkdirs(); // 폴더 없으면 생성

        String filePath = dir + saveName;

        try (java.io.OutputStream os = new java.io.BufferedOutputStream(new java.io.FileOutputStream(filePath))) {
            os.write(file.getBytes());
        } catch (java.io.IOException e) {
            throw new RuntimeException("파일 저장 실패: " + filePath, e);
        }

        // DB 저장 필요하면 여기서 처리 (orgName, ext, saveName, filePath, size...)
        return saveName; // 저장된 실제 파일명만 리턴
    }
}
