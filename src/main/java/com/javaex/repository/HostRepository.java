package com.javaex.repository; 

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FacilityInfoVO;
import com.javaex.vo.HostVO;

@Repository
public class HostRepository {

    private final SqlSession sqlSession;
    private static final String NS = "host.";

    public HostRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    /** 유저별 공간 리스트 */
    public List<HostVO> findSpacesByUser(Long userno) {
        return sqlSession.selectList(NS + "spaces_by_user", userno);
    }

    /** 단건 조회 */
    public HostVO findSpaceByNo(Long spacesNo) {
        return sqlSession.selectOne(NS + "space_by_no", spacesNo);
    }

    /** 신규 저장 */
    public int insertSpace(HostVO vo) {
        return sqlSession.insert(NS + "insert_space", vo);
    }

    /** 수정 저장 */
    public int updateSpace(HostVO vo) {
        return sqlSession.update(NS + "update_space", vo);
    }

    /** 시설 전체 삭제 */
    public int deleteFacilitiesBySpacesno(Long spacesno) {
        return sqlSession.delete(NS + "delete_facilities_by_spacesno", spacesno);
    }
    
    /** [추가] 모든 시설 정보 목록을 가져오는 메소드 */
    public List<FacilityInfoVO> selectAllFacilities() {
        // "host" 네임스페이스에 있는 "selectAllFacilities" 쿼리를 호출합니다.
        return sqlSession.selectList(NS + "selectAllFacilities");
    }

    /** 시설 1건 삽입: String facilityName -> Long facilityNo 로 변경 */
    public int insertFacility(Long spacesno, Long facilityNo) { // ★★★ 타입을 Long으로 변경
        Map<String, Object> p = new HashMap<>();
        p.put("spacesNo", spacesno);
        p.put("facilityNo", facilityNo); // ★★★ key도 "facilityNo"로 변경
        return sqlSession.insert(NS + "insert_facility", p);
    }
}
