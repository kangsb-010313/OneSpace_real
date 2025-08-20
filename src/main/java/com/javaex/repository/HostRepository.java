package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.javaex.vo.SpacesVO;

@Repository
public class HostRepository {

    private final SqlSession sqlSession;
    private static final String NS = "host.";

    public HostRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<SpacesVO> findSpacesByUser(Long userno) {
        return sqlSession.selectList(NS + "spaces_by_user", userno);
    }
}
