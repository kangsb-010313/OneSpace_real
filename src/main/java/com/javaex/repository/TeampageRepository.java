package com.javaex.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.TeamPostVO;

@Repository
public class TeampageRepository {

	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//생성자
	
	
	//메소드 gs
	
	
	//메소드 일반
	
	//--일반공지 글 등록하기
	public int teampageInsert(TeamPostVO teamPostVO) {
		System.out.println("TeampageRepository.teampageInsert()");
		
		int count = sqlSession.insert("teampage.insert", teamPostVO);
		
		return count;
	}
	
}
