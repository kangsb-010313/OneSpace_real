package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.repository.HostRepository;
import com.javaex.vo.FacilityInfoVO;
import com.javaex.vo.HostVO;

@Service
public class HostService {

	@Autowired
	private HostRepository hostRepository;

	/** 단건 조회 by userNo */
	public HostVO getSpaceByUserNo(Long userNo) {

		List<FacilityInfoVO> checkedFacilityList = null;

		// 기본 건물정보
		HostVO hostVO = hostRepository.findSpaceByUserNo(userNo);
		if (hostVO != null) {
			// 선택한 시설정보리스트
			checkedFacilityList = hostRepository.selectCheckedFacilities(hostVO.getSpacesno());

			// 기본 건물정보에 선택한 시설정보리스트를 추가한다
			hostVO.setCheckedFacilityList(checkedFacilityList);
		}

		return hostVO;
	}

	/** [추가] 전체 시설 목록을 가져오는 메소드 */
	public List<FacilityInfoVO> getAllFacilities() {
		return hostRepository.selectAllFacilities();
	}

	/** 공간 생성(신규 저장) */
	@Transactional
	public int createSpace(HostVO vo) {
		normalize(vo);
		validate_for_create(vo);
		//vo저장
		hostRepository.insertSpace(vo); // useGeneratedKeys로 spacesno 세팅
		
		  
        System.out.println("-------------------------");
        System.out.println(vo);
        System.out.println("-------------------------");
		
        //시설관리 저장
        for(int i=0; i<vo.getFacilityNos().size(); i++) {
        	System.out.println("시설저장" + vo.getFacilityNos().get(i));
        	
        	FacilityInfoVO facilityInfoVO = new FacilityInfoVO();
        	facilityInfoVO.setSpacesNo((long)vo.getSpacesno());
        	facilityInfoVO.setFacilityNo((long)vo.getFacilityNos().get(i));
        	
        	hostRepository.insertFacility(facilityInfoVO);
        }
       
		return 1;
	}

	/* --------------------- 내부 유틸 --------------------- */

	private void normalize(HostVO vo) {
		if (vo == null)
			return;

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

	private String safe(String s) {
		return (s == null) ? "" : s.trim();
	}

	private void validate_for_create(HostVO vo) {
		if (vo.getUserno() == null)
			throw new IllegalArgumentException("userno가 필요합니다.");
		if (safe(vo.getSpacename()).isEmpty())
			throw new IllegalArgumentException("공간명은 필수입니다.");
		if (safe(vo.getAddress()).isEmpty())
			throw new IllegalArgumentException("주소는 필수입니다.");
	}

	private void validate_for_update(HostVO vo) {
		if (vo.getUserno() == null)
			throw new IllegalArgumentException("userno가 필요합니다.");
		if (vo.getSpacesno() == null)
			throw new IllegalArgumentException("spacesno(pk)가 필요합니다.");
		if (safe(vo.getSpacename()).isEmpty())
			throw new IllegalArgumentException("공간명은 필수입니다.");
		if (safe(vo.getAddress()).isEmpty())
			throw new IllegalArgumentException("주소는 필수입니다.");
	}

}