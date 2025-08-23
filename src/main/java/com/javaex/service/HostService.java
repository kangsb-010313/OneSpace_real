package com.javaex.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.repository.HostRepository;
import com.javaex.vo.HostVO;

@Service
public class HostService {

    private final HostRepository hostRepository;

    public HostService(HostRepository hostRepository) {
        this.hostRepository = hostRepository;
    }

    /** 내 공간 목록 */
    public List<HostVO> getSpacesByUser(Long userno) {
        return hostRepository.findSpacesByUser(userno);
    }

    /** 단건 조회 */
    public HostVO getSpace(Long spacesNo) {
        return hostRepository.findSpaceByNo(spacesNo);
    }

    /** 공간 생성(신규 저장) */
    @Transactional
    public int createSpace(HostVO vo) {
        normalize(vo);
        validate_for_create(vo);
        // HostRepository에 insert 메서드 필요
        return hostRepository.insertSpace(vo);
    }

    /** 공간 수정(저장) */
    @Transactional
    public int updateSpace(HostVO vo) {
        normalize(vo);
        validate_for_update(vo);
        // HostRepository에 update 메서드 필요
        return hostRepository.updateSpace(vo);
    }

    /* --------------------- 내부 유틸 --------------------- */

    /** null → "" 및 앞뒤 공백 정리 등 */
    private void normalize(HostVO vo) {
        if (vo == null) return;

        vo.setSpacename(trim(vo.getSpacename()));
        vo.setSpacesummary(trim(vo.getSpacesummary()));
        vo.setSpaceinfo(trim(vo.getSpaceinfo()));

        vo.setFacilities(trim(vo.getFacilities()));   // 체크박스 콤마 문자열
        vo.setAddress(trim(vo.getAddress()));
        vo.setAddressdetail(trim(vo.getAddressdetail()));
        vo.setPostcode(trim(vo.getPostcode()));
        vo.setSpacelink(trim(vo.getSpacelink()));

        vo.setEmail(trim(vo.getEmail()));
        vo.setPhone(trim(vo.getPhone()));
        vo.setTel(trim(vo.getTel()));
        // 대표 이미지 파일명/경로 필드가 있다면 동일하게 트리밍
        // vo.setRepImageName(trim(vo.getRepImageName()));
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }

    /** 필수값 체크(신규) */
    private void validate_for_create(HostVO vo) {
        if (vo.getUserno() == null) throw new IllegalArgumentException("userno가 필요합니다.");
        if (isBlank(vo.getSpacename())) throw new IllegalArgumentException("공간명은 필수입니다.");
        if (isBlank(vo.getAddress())) throw new IllegalArgumentException("주소는 필수입니다.");
        // 필요한 필드 추가 체크 가능
    }

    /** 필수값 체크(수정) */
    private void validate_for_update(HostVO vo) {
        if (vo.getUserno() == null) throw new IllegalArgumentException("userno가 필요합니다.");
        if (vo.getSpacesno() == null) throw new IllegalArgumentException("spacesno(pk)가 필요합니다.");
        if (isBlank(vo.getSpacename())) throw new IllegalArgumentException("공간명은 필수입니다.");
        if (isBlank(vo.getAddress())) throw new IllegalArgumentException("주소는 필수입니다.");
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
