package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.repository.TeampageRepository;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamVO;

@Service
public class TeampageService {

	//필드
	@Autowired
	private TeampageRepository teampageRepository;
	
	
	//생성자
	
	
	//메소드gs
	
	
	//메소드일반
//	//--팀페이지 전체 리스트
//	public List<TeamPostVO> exeList(){
//		System.out.println("TeampageService.exeList()");
//		
//		List<TeamPostVO> teamPostList = teampageRepository.teampageSelectList();
//		
//		return teamPostList;
//	}
	
    // -- 특정 팀의 게시글 리스트 조회
    public List<TeamPostVO> exeListByTeam(int teamNo){
    	
        System.out.println("TeampageService.exeListByTeam()");
        
        List<TeamPostVO> teamPostList = teampageRepository.teampageSelectListByTeamNo(teamNo);
        
        return teamPostList;
    }
	
	//--일반공지 글 등록하기
	public int exeAdd(TeamPostVO teamPostVO) {
		System.out.println("TeampageService.exeAdd()");
		
		int count = teampageRepository.teampageInsert(teamPostVO);
		
		return count;
	}
	
	//--팀페이지 등록 글 보기
    public TeamPostVO exeGetPost(int teamPostNo) {
    	
        System.out.println("TeampageService.exeGetPost()");
        
        TeamPostVO post = teampageRepository.teampageSelectPostByNo(teamPostNo);
        
        return post;
    }
    
    // -- 모든 팀 목록 조회
    public List<TeamVO> exeGetAllTeams() {
        System.out.println("TeampageService.exeGetAllTeams()");
        
        List<TeamVO> allTeams = teampageRepository.selectAllTeams();
        
        return allTeams;
    }

    // -- 특정 팀 정보 조회
    public TeamVO exeGetTeamInfo(int teamNo) {
        System.out.println("TeampageService.exeGetTeamInfo()");
        
        TeamVO teamInfo = teampageRepository.selectTeamInfoByNo(teamNo);
        
        return teamInfo;
    }
	
    // -- 게시글 수정
    public int exeModify(TeamPostVO teamPostVO) {
        System.out.println("TeampageService.exeModify()");
        int count = teampageRepository.teampageUpdate(teamPostVO);
        return count;
    }
	
	
}
