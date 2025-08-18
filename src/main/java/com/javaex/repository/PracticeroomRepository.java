package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.PracticeroomVO;

@Repository
public class PracticeroomRepository {
	
	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//메소드일반
	//--전체리스트 가져오기(게시판리스트)
	public List<PracticeroomVO> practiceroomSelectList() {
		System.out.println("PracticeroomRepository.practiceroomSelectList()");
		
		List<PracticeroomVO> practiceroomSelectList = sqlSession.selectList("practiceroom.selectList");
		
		return practiceroomSelectList;
	}
	
}
