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
        return hostRepository.insertSpace(vo); // useGeneratedKeys로 spacesno 세팅
    }

    /** 공간 수정 */
    @Transactional
    public int updateSpace(HostVO vo) {
        normalize(vo);
        validate_for_update(vo);
        return hostRepository.updateSpace(vo);
    }

    /** 시설 교체 저장: (스키마 미사용 시) no-op */
    @Transactional
    public void replaceFacilities(Long spacesno, List<String> names) {
        // 필요 시 facilityInfo 연동 로직 추가
    }

    /* --------------------- 내부 유틸 --------------------- */

    private void normalize(HostVO vo) {
        if (vo == null) return;

        vo.setSpacename(safe(vo.getSpacename()));
        vo.setSpacesummary(safe(vo.getSpacesummary()));
        vo.setSpaceinfo(safe(vo.getSpaceinfo()));

        vo.setFacilities(safe(vo.getFacilities()));
        vo.setAddress(safe(vo.getAddress()));
        vo.setAddressdetail(safe(vo.getAddressdetail()));
        vo.setPostcode(safe(vo.getPostcode()));
        vo.setSpacelink(safe(vo.getSpacelink()));

        vo.setEmail(safe(vo.getEmail()));
        vo.setPhone(safe(vo.getPhone()));
        vo.setTel(safe(vo.getTel()));
        vo.setRepimg(safe(vo.getRepimg())); // 업로드 성공 시 파일명 세팅
    }

    private String safe(String s) { return (s == null) ? "" : s.trim(); }

    private void validate_for_create(HostVO vo) {
        if (vo.getUserno() == null) throw new IllegalArgumentException("userno가 필요합니다.");
        if (safe(vo.getSpacename()).isEmpty()) throw new IllegalArgumentException("공간명은 필수입니다.");
        if (safe(vo.getAddress()).isEmpty()) throw new IllegalArgumentException("주소는 필수입니다.");
    }

    private void validate_for_update(HostVO vo) {
        if (vo.getUserno() == null) throw new IllegalArgumentException("userno가 필요합니다.");
        if (vo.getSpacesno() == null) throw new IllegalArgumentException("spacesno(pk)가 필요합니다.");
        if (safe(vo.getSpacename()).isEmpty()) throw new IllegalArgumentException("공간명은 필수입니다.");
        if (safe(vo.getAddress()).isEmpty()) throw new IllegalArgumentException("주소는 필수입니다.");
    }
}
