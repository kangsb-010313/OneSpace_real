package com.javaex.repository; 

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FacilityInfoVO;
import com.javaex.vo.HostVO;

@Repository
public class HostRepository {

	@Autowired
    private SqlSession sqlSession;
    private static final String NS = "host.";

    /** 단건 조회 by userNo */
    public HostVO findSpaceByUserNo(Long userNo) {
    	System.out.println(userNo);
        return sqlSession.selectOne(NS + "space_by_userNo", userNo);
    }
    
    /** [추가] 모든 시설 정보 목록을 가져오는 메소드 */
    public List<FacilityInfoVO> selectAllFacilities() {
        // "host" 네임스페이스에 있는 "selectAllFacilities" 쿼리를 호출합니다.
        return sqlSession.selectList(NS + "selectAllFacilities");
    }
    
	/* 선택한 시설관리 */
    public List<FacilityInfoVO> selectCheckedFacilities(long spaceNo) {
        // "host" 네임스페이스에 있는 "selectAllFacilities" 쿼리를 호출합니다.
    	
        return sqlSession.selectList(NS + "selectCheckedFacilities", spaceNo);
    }
    
    /** 신규 저장 */
    public int insertSpace(HostVO vo) {
        return sqlSession.insert(NS + "insert_space", vo);
    }
    
    /** update */
    public int updateSpace(HostVO vo) {
    	System.out.println("-------");
    	System.out.println(vo);
    	return sqlSession.update(NS + "update_space", vo);
    }
    
    /** delete facility */
    public int deleteFacility(Long spacesNo) {
    	return sqlSession.delete(NS + "delect_facility", spacesNo); 
    }

    /** 시설체크박스 저장 */
    public int insertFacility(FacilityInfoVO vo) {
        return sqlSession.insert(NS + "insert_facility", vo);
    }

}
