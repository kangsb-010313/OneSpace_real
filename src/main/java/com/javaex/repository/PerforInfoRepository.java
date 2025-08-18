package com.javaex.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.javaex.vo.PerforInfoVO;

@Repository
public class PerforInfoRepository {

    private final SqlSession sqlSession;
    private static final String NS = "perforinfo.";

    public PerforInfoRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public long count() {
        return sqlSession.selectOne(NS + "count");
    }

    public List<PerforInfoVO> listPaged(int offset, int size) {
        Map<String, Object> p = new HashMap<>();
        p.put("offset", offset);
        p.put("size", size);
        return sqlSession.selectList(NS + "list_paged", p);
    }

    // 단일 파라미터를 Map으로 넘겨 #{no} 사용 가능하게
    public PerforInfoVO get(long no) {
        Map<String, Object> p = new HashMap<>();
        p.put("no", no);
        return sqlSession.selectOne(NS + "get", p);
    }

    public int insert(PerforInfoVO vo) {
        return sqlSession.insert(NS + "insert", vo);
    }
}
