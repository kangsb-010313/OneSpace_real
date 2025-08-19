package com.javaex.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.SpacesVO;
import com.javaex.vo.RoomsVO;

@Repository
public class PracticeroomRepository {
	
	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//메소드일반
	//--전체리스트 가져오기
	public List<SpacesVO> practiceroomSelectList() {
		System.out.println("PracticeroomRepository.practiceroomSelectList()");
		
		List<SpacesVO> practiceroomSelectList = sqlSession.selectList("practiceroom.selectList");
		
		return practiceroomSelectList;
	}
	
	public List<SpacesVO> practiceroomSelectPaged(int offset, int size) {
        Map<String, Object> p = new HashMap<>();
        p.put("offset", offset);
        p.put("size", size);
        return sqlSession.selectList("practiceroom.selectPaged", p);
    }
	
	public PracticeroomRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public SpacesVO selectZoneDetail(Long spacesNo) {
        return sqlSession.selectOne("practiceroom.selectZoneDetail", spacesNo);
    }

    public List<RoomsVO> selectRoomsBySpace(Long spacesNo) {
        return sqlSession.selectList("practiceroom.selectRoomsBySpace", spacesNo);
    }
}
