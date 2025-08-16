package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamVO;

@Repository
public class TeampageRepository {

	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//생성자
	
	
	//메소드 gs
	
	
	//메소드 일반
//	// --팀페이지 전체 리스트
//	public List<TeamPostVO> teampageSelectList(){
//		System.out.println("TeampageRepository.teampageSelectList()");
//		
//		List<TeamPostVO> teamPostList = sqlSession.selectList("teampage.selectListByTeamNo");
//		
//		return teamPostList;
//	}
	
    // -- 특정 팀의 게시글 리스트 조회
    public List<TeamPostVO> teampageSelectListByTeamNo(int teamNo){
    	
        System.out.println("TeampageRepository.teampageSelectListByTeamNo()");
        
        // teamNo를 파라미터로 전달
        List<TeamPostVO> teamPostList = sqlSession.selectList("teampage.selectListByTeamNo", teamNo);
        
        return teamPostList;
    }
	
	
	//--일반공지 글 등록하기
	public int teampageInsert(TeamPostVO teamPostVO) {
		System.out.println("TeampageRepository.teampageInsert()");
		
		int count = sqlSession.insert("teampage.insert", teamPostVO);
		
		return count;
	}
	
	//--팀페이지 등록 글 보기
    public TeamPostVO teampageSelectPostByNo(int teamPostNo) {
    	
        System.out.println("TeampageRepository.teampageSelectPostByNo()");
        
        TeamPostVO post = sqlSession.selectOne("teampage.selectPostByNo", teamPostNo);
        
        return post;
    }

    // -- 모든 팀 목록 조회
    public List<TeamVO> selectAllTeams() {
        System.out.println("TeampageRepository.selectAllTeams()");
        
        List<TeamVO> allTeams = sqlSession.selectList("teampage.selectAllTeams");
        
        return allTeams;
    }

    // -- 특정 팀 정보 조회
    public TeamVO selectTeamInfoByNo(int teamNo) {
        System.out.println("TeampageRepository.selectTeamInfoByNo()");
        
        TeamVO teamInfo = sqlSession.selectOne("teampage.selectTeamInfoByNo", teamNo);
        
        return teamInfo;
    }
    
    // -- 게시글 수정
    public int teampageUpdate(TeamPostVO teamPostVO) {
        System.out.println("TeampageRepository.teampageUpdate()");
        int count = sqlSession.update("teampage.update", teamPostVO);
        return count;
    }
    
	
}
