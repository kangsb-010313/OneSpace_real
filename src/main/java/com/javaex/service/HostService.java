package com.javaex.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.repository.HostRepository;
import com.javaex.vo.FacilityInfoVO;
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
    
    /** [추가] 전체 시설 목록을 가져오는 메소드 */
    public List<FacilityInfoVO> getAllFacilities() {
        return hostRepository.selectAllFacilities();
    }

    /** 
     * [수정] 시설 정보 교체 저장
     * @param spacesno 어느 공간에 속한 시설인지 (FK)
     * @param facilityNos 새로 저장할 시설 ID 목록
     */
    @Transactional
    public void replaceFacilities(Long spacesno, List<Long> facilityNos) {
        System.out.println("HostService.replaceFacilities() - 시설 정보 교체 시작");

        // 1. 이 공간(spacesno)에 연결된 기존 시설 정보를 모두 삭제합니다.
        hostRepository.deleteFacilitiesBySpacesno(spacesno);

        // 2. 새로 전달받은 시설 ID 목록이 있다면, 하나씩 다시 저장합니다.
        if (facilityNos != null && !facilityNos.isEmpty()) {
            for (Long facilityNo : facilityNos) {
                // 3. ID가 null이 아닌 경우에만 저장
                if(facilityNo != null) {
                    hostRepository.insertFacility(spacesno, facilityNo);
                }
            }
        }
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
