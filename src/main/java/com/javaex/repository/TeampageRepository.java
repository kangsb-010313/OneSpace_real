package com.javaex.repository;

import java.util.List;

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
	
	
	// TODO: aside 출력을 위한 모든 팀 목록을 가져오는 메서드
	// public List<TeamVO> selectAllTeams() {
	//    return sqlSession.selectList("teampage.selectAllTeams"); // MyBatis 쿼리 추가 필요
	// }

	// TODO: 특정 팀 정보를 가져오는 메서드 (팀 이름 등)
	// public TeamVO selectTeamInfo(int teamNo) {
	//    return sqlSession.selectOne("teampage.selectTeamInfo", teamNo); // MyBatis 쿼리 추가 필요
	// }
	
}
