package com.javaex.service;

import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.repository.HostRepository;
import com.javaex.vo.HostVO;

@Service
public class HostService {

    @Autowired
    private HostRepository hostRepository;

    @Value("${upload.dir:uploads}")
    private String upload_dir;

    @Value("${upload.url-prefix:/uploads/}")
    private String url_prefix;

    public HostVO get_host_info(Long userno) {
        HostVO vo = hostRepository.select_host_by_userno(userno);
        if (vo == null) {
            vo = new HostVO();
            vo.setuserno(userno);
            vo.sethidden_in_search(0);
            vo.setrefund_agreed(0);
        }
        return vo;
    }

    public List<HostVO> list_spaces(Long userno) {
        return hostRepository.select_spaces_by_userno(userno);
    }

    public Long save_host_info(Long userno, HostVO form, MultipartFile repImage) {
        form.setuserno(userno);

        if (form.getspacesno() == null) {
            hostRepository.insert_space(form);
        } else {
            hostRepository.update_space(form);
        }

        if (repImage != null && !repImage.isEmpty()) {
            String url = save_file(repImage, "host_rep");
            hostRepository.update_rep_image_url(form.getspacesno(), url);
        }
        return form.getspacesno();
    }

    private String save_file(MultipartFile file, String prefix) {
        try {
            Path dir = Paths.get(upload_dir).toAbsolutePath();
            if (!Files.exists(dir)) Files.createDirectories(dir);

            String ts = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            String original = file.getOriginalFilename();
            String ext = "";
            if (original != null && original.contains(".")) {
                ext = original.substring(original.lastIndexOf("."));
            }
            String filename = prefix + "_" + ts + ext;
            Path target = dir.resolve(filename);
            Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
            return url_prefix + filename;
        } catch (Exception e) {
            throw new RuntimeException("file save failed", e);
        }
    }
}
