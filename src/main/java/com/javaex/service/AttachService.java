package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.vo.TeamAttachmentsVO;

@Service
public class AttachService {

    // 파일을 저장하고, 그 파일의 정보를 VO에 담아 반환하는 메소드
    public TeamAttachmentsVO exeSave(MultipartFile file) { 
        System.out.println("AttachService.exeSave()");

        // OS에 따라 파일 저장 경로 설정
//        String osName = System.getProperty("os.name").toLowerCase();
//        String saveDir = osName.contains("win") ? "C:\\javaStudy\\upload\\" : "/data/upload/";
        
        // --- 여기부터 수정 ---
        String saveDir;
        String osName = System.getProperty("os.name").toLowerCase();

        // 윈도우일 경우
        if (osName.contains("win")) {
            saveDir = "C:\\javaStudy\\upload\\";
        } 
        // 맥 또는 리눅스일 경우
        else { 
            // 사용자 홈 디렉토리 경로를 가져와서 그 하위에 upload 폴더를 사용합니다.
            // 예: /Users/사용자이름/upload/
            saveDir = System.getProperty("user.home") + "/upload/";
        }
        
        // upload 폴더가 없으면 자동으로 생성해주는 로직
        File dir = new File(saveDir);
        if (!dir.exists()) {
            dir.mkdirs(); // mkdirs()는 필요한 상위 폴더까지 모두 생성합니다.
        }

        // 1. 파일 정보 추출
        String orgName = file.getOriginalFilename();
        String exName = orgName.substring(orgName.lastIndexOf("."));
        String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
        String filePath = saveDir + saveName;
        long fileSize = file.getSize();

        // 2. VO에 파일 정보 담기
        TeamAttachmentsVO attachmentVO = new TeamAttachmentsVO(); // ★★★ 생성하는 객체 타입도 수정
        attachmentVO.setTeamOriginFileName(orgName);
        attachmentVO.setTeamStoredFileName(saveName);
        attachmentVO.setTeamFilePath(filePath);
        attachmentVO.setTeamFileSize(fileSize);

        // 3. 실제 파일을 하드디스크에 저장
        try {
            byte[] fileData = file.getBytes();
            OutputStream os = new FileOutputStream(filePath);
            BufferedOutputStream bos = new BufferedOutputStream(os);
            bos.write(fileData);
            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 파일 정보가 담긴 VO 객체를 반환
        return attachmentVO;
    }
}
