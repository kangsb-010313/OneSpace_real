package com.javaex.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.HostVO;

@Repository
public class HostRepository {

    @Autowired
    private SqlSession sqlSession;

    public HostVO select_host_by_userno(Long userno) {
        return sqlSession.selectOne("host.select_host_by_userno", userno);
    }

    public List<HostVO> select_spaces_by_userno(Long userno) {
        return sqlSession.selectList("host.select_spaces_by_userno", userno);
    }

    public int insert_space(HostVO vo) {
        return sqlSession.insert("host.insert_space", vo);
    }

    public int update_space(HostVO vo) {
        return sqlSession.update("host.update_space", vo);
    }

    public int update_rep_image_url(Long spacesno, String url) {
        Map<String, Object> p = new HashMap<>();
        p.put("spacesno", spacesno);
        p.put("rep_image_url", url);
        return sqlSession.update("host.update_rep_image_url", p);
    }
}
