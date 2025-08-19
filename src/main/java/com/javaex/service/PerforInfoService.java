package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.repository.PerforInfoRepository;
import com.javaex.vo.PerforInfoVO;

@Service
public class PerforInfoService {

    @Autowired
    private PerforInfoRepository repo;

    /** 업로드 루트(단일 진실 소스) */
    public static final String UPLOAD_ROOT;
    static {
        String os = System.getProperty("os.name").toLowerCase();
        UPLOAD_ROOT = os.contains("win") ? "C:/javaStudy/upload/" : "/data/upload/";
        File dir = new File(UPLOAD_ROOT);
        if (!dir.exists()) dir.mkdirs();
        System.out.println("[UPLOAD] ROOT = " + new File(UPLOAD_ROOT).getAbsolutePath());
    }

    /** 파일 저장하고 저장파일명만 반환 (DB에는 파일명만 넣기) */
    public String exeUpload(MultipartFile file) {
        if (file == null || file.isEmpty()) return null;

        // 원본 파일명 확보 & 확장자 분리
        String org = file.getOriginalFilename();
        String baseName = null;
        String ext = "";

        if (org != null && !org.isBlank()) {
            String justName = new File(org).getName();               // 경로 제거
            int dot = justName.lastIndexOf('.');
            if (dot >= 0 && dot < justName.length() - 1) {
                baseName = justName.substring(0, dot);
                ext = justName.substring(dot);                       // ".png"
            } else {
                baseName = justName;
            }
        }

        // 저장파일명 규칙: timestamp_originalName (공백 -> _)
        String saveName;
        if (baseName != null) {
            String safeBase = baseName.replaceAll("\\s+", "_");
            saveName = System.currentTimeMillis() + "_" + safeBase + ext;
        } else {
            // 원본명 없으면 uuid 사용
            saveName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + ext;
        }

        String path = UPLOAD_ROOT + saveName;

        try (OutputStream os = new FileOutputStream(path);
             BufferedOutputStream bos = new BufferedOutputStream(os)) {
            bos.write(file.getBytes());
            System.out.println("[UPLOAD] saved file: " + path);
            return saveName; // DB에는 파일명만 저장
        } catch (IOException e) {
            System.out.println("[UPLOAD] file save failed: " + e.getMessage());
            return null;
        }
    }

    // ---------- CRUD 위임 ----------

    public long count() {
        return repo.count();
    }

    public List<PerforInfoVO> listPaged(int offset, int size) {
        return repo.listPaged(offset, size);
    }

    /** insert 후 auto_increment 키가 vo.infoPostNo 에 세팅되도록 매퍼에서 useGeneratedKeys 처리 */
    public Long insert(PerforInfoVO vo) {
        repo.insert(vo);
        return vo.getInfoPostNo();
    }

    public PerforInfoVO get(long no) {
        return repo.get(no);
    }
}
