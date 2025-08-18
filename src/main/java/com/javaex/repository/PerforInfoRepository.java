package com.javaex.repository;

import java.util.List; // ✅ 이걸로!
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.javaex.vo.PerforInfoVO;

@Repository
public class PerforInfoRepository {

    private final SqlSession sqlSession;
    private static final String NS = "perforinfo.";

    // ✅ 생성자 주입
    public PerforInfoRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<PerforInfoVO> list() {
        return sqlSession.selectList(NS + "list");
    }

    public PerforInfoVO get(long no) {
        return sqlSession.selectOne(NS + "get", no);
    }

    public int insert(PerforInfoVO vo) {
        return sqlSession.insert(NS + "insert", vo);
    }
}
