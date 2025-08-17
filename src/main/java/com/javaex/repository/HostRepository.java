package com.javaex.repository;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.javaex.vo.HostVO;

@Repository
public class HostRepository {

    private static final String NS = "host."; // host.xml의 namespace

    @Autowired
    private SqlSessionTemplate sqlsession;

    public HostVO select_host_by_userno(Long userno) {
        Map<String,Object> p = new HashMap<>();
        p.put("userno", userno);
        return sqlsession.selectOne(NS + "select_host_by_userno", p);
    }

    public List<HostVO> select_spaces_by_userno(Long userno) {
        Map<String,Object> p = new HashMap<>();
        p.put("userno", userno);
        return sqlsession.selectList(NS + "select_spaces_by_userno", p);
    }

    public int insert_space(HostVO vo) {
        return sqlsession.insert(NS + "insert_space", vo);
    }

    public int update_space(HostVO vo) {
        return sqlsession.update(NS + "update_space", vo);
    }

    public int update_rep_image_url(Long spacesno, String rep_image_url) {
        Map<String,Object> p = new HashMap<>();
        p.put("spacesno", spacesno);
        p.put("rep_image_url", rep_image_url);
        return sqlsession.update(NS + "update_rep_image_url", p);
    }
}
