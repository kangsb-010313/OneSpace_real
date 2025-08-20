package com.javaex.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.javaex.repository.HostRepository;
import com.javaex.vo.HostVO;

@Service
public class HostService {

    private final HostRepository hostRepository;

    public HostService(HostRepository hostRepository) {
        this.hostRepository = hostRepository;
    }

    public List<HostVO> getSpacesByUser(Long userno) {
        return hostRepository.findSpacesByUser(userno);
    }

    public HostVO getSpace(Long spacesNo) {
        return hostRepository.findSpaceByNo(spacesNo);
    }
}
