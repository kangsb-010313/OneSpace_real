package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.repository.TeampageRepository;
import com.javaex.vo.TeamPostVO;

@Service
public class TeampageService {

	//필드
	@Autowired
	private TeampageRepository teampageRepository;
	
	
	//생성자
	
	
	//메소드gs
	
	
	//메소드일반
	
	//--일반공지 글 등록하기
	public int exeAdd(TeamPostVO teamPostVO) {
		System.out.println("TeampageService.exeAdd()");
		
		int count = teampageRepository.teampageInsert(teamPostVO);
		
		return count;
	}
	
	
}
