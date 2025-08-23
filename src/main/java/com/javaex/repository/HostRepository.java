package com.javaex.repository;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
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
}
