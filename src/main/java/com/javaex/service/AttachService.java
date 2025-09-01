package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class AttachService {

	
    @Value("${file.upload-dir}")
    private String saveDir;
	
    /**
     * 이 메소드가 이제 모든 파일 저장을 담당합니다.
     * @param file Controller로부터 전달받은 파일
     * @return 저장된 파일의 정보(원본명, 저장명, 경로, 크기)가 담긴 Map 객체
     */
    public Map<String, Object> saveFile(MultipartFile file) {
        System.out.println("AttachService.saveFile()");

        // 파일이 비어있으면 아무 작업도 하지 않고 null을 반환합니다.
        if (file == null || file.isEmpty()) {
            return null;
        }

        // ===================================================================
        // [파일 저장 경로 설정] - 개발 환경과 배포 환경에 맞게 하나만 주석 해제하여 사용
        // ===================================================================
        // 1. EC2(리눅스) 서버 배포 환경
        // String saveDir = "/home/ubuntu/onespace_uploads/";

        // 2. 윈도우 로컬 개발 환경
        //String saveDir = "C:\\onespace_uploads\\";
        // ===================================================================
        
        // 지정된 경로에 폴더가 없으면 자동으로 생성합니다.
        File dir = new File(saveDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 1. 파일 정보 추출
        String orgName = file.getOriginalFilename(); // 원본 파일명 (예: "강아지.jpg")
        String exName = orgName.substring(orgName.lastIndexOf(".")); // 확장자 (예: ".jpg")
        String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName; // 저장될 파일명 (중복 방지)
        String filePath = saveDir + saveName; // 저장될 파일의 전체 경로
        long fileSize = file.getSize(); // 파일 크기

        // 2. 실제 파일을 하드디스크에 저장
        try {
            byte[] fileData = file.getBytes();
            OutputStream os = new FileOutputStream(filePath);
            BufferedOutputStream bos = new BufferedOutputStream(os);
            bos.write(fileData);
            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
            return null; // 저장 중 오류 발생 시 null 반환
        }

        // 3. 저장된 파일 정보를 Map에 담아 반환 (이 정보를 Service에서 사용)
        Map<String, Object> fileInfo = new HashMap<>();
        fileInfo.put("orgName", orgName);
        fileInfo.put("saveName", saveName);
        fileInfo.put("filePath", filePath);
        fileInfo.put("fileSize", fileSize);
        
        System.out.println("파일 저장 완료: " + fileInfo);
        return fileInfo;
    }
}
