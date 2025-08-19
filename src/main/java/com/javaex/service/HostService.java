package com.javaex.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.javaex.repository.HostRepository;
import com.javaex.vo.HostVO;

@Service
public class HostService {

    @Autowired
    private HostRepository hostRepository;

    public HostVO gethostinfo(Long userno) {
        if (userno == null) return null;
        return hostRepository.select_host_by_userno(userno);
    }

    public List<HostVO> list_spaces(Long userno) {
        if (userno == null) return java.util.List.of();
        return hostRepository.select_spaces_by_userno(userno);
    }

    // ★ 추가: 소유자 검증 포함 단건 조회
    public HostVO get_space_for_edit(Long userno, Long spacesno) {
        if (userno == null || spacesno == null) return null;
        return hostRepository.select_space_one(userno, spacesno);
    }

    public int insert_space(HostVO vo) { return hostRepository.insert_space(vo); }
    public int update_space(HostVO vo) { return hostRepository.update_space(vo); }
}
