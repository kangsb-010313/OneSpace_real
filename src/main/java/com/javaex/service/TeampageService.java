package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.repository.TeampageRepository;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVoteOptionVO;

@Service
public class TeampageService {

	//필드
	@Autowired
	private TeampageRepository teampageRepository;
	
	
	//생성자
	
	
	//메소드gs
	
	
	//메소드일반
	
	//-- 팀페이지 팀 등록 (가장 기본 방식)
	public int exeAddTeam(TeamVO teamVO, int userNo) {
		System.out.println("TeampageService.exeAddTeam()");
		
		// 1. 팀을 만들기 전, 누가 만드는지 userNo를 teamVO에 설정
		teamVO.setUserNo(userNo);
		
		// 2. Repository를 호출하여 teams 테이블에 팀 정보 INSERT
		teampageRepository.insertTeam(teamVO);
		
		// 3. 방금 내가(userNo) 만든 팀의 teamNo를 다시 DB에서 SELECT로 가져오기
		int newTeamNo = teampageRepository.selectNewTeamNo(userNo);
		
		// 4. 가져온 teamNo와 userNo를 이용해 team_members 테이블에 팀원 정보 INSERT
		teampageRepository.insertTeamMember(newTeamNo, userNo);
		
		// 5. Controller에게 새로 생성된 teamNo를 반환
		return newTeamNo;
	}
	
	
	
	
    // -- 로그인 유저가 속한 팀 리스트 가져오기 (for teammain aside)
    public List<TeamVO> exeGetUserTeams(int userNo) {
        System.out.println("TeampageService.exeGetUserTeams()");
        return teampageRepository.selectTeamsByUserNo(userNo);
    }
    
    // -- 로그인 유저가 속한 모든 팀의 게시글 가져오기 (for teammain content)
    public List<TeamPostVO> exeGetAllUserPosts(int userNo) {
        System.out.println("TeampageService.exeGetAllUserPosts()");
        return teampageRepository.selectPostsByUserTeams(userNo);
    }
    
    
	
    // --팀페이지 전체 리스트 (특정 팀의 리스트)
    public List<TeamPostVO> exeListByTeam(int teamNo){
    	
        System.out.println("TeampageService.exeListByTeam()");
        
        List<TeamPostVO> teamPostList = teampageRepository.teampageSelectListByTeamNo(teamNo);
        
        return teamPostList;
    }
	
	//--팀페이지 글 등록
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
	
    // -- 팀페이지 등록글 수정 처리
    public int exeModify(TeamPostVO teamPostVO) {
        System.out.println("TeampageService.exeModify()");
        int count = teampageRepository.teampageUpdate(teamPostVO);
        return count;
    }
    
    // -- 팀페이지 등록글 삭제
    public int exeDelete(int teamPostNo, int authUserNo) {
        System.out.println("TeampageService.exeDelete()");
        
        // (선택적 보안 강화) 삭제하려는 게시글 정보를 가져와서 작성자가 맞는지 한번 더 확인
        TeamPostVO post = teampageRepository.teampageSelectPostByNo(teamPostNo);
        if (post != null && post.getUserNo() == authUserNo) {
            // 작성자가 일치하면 삭제 진행
            return teampageRepository.teampageDelete(teamPostNo);
        } else {
            // 작성자가 아니거나 게시글이 없으면 0을 반환 (삭제 실패)
            return 0; 
        }
    }

	 // 사용자의 찜 목록을 투표 후보로 가져오기
	    public List<TeamVoteOptionVO> exeGetWishlistForVote(int userNo) {
	        System.out.println("TeampageService.exeGetWishlistForVote()");
	        return teampageRepository.selectWishlistForVote(userNo);
	    }

	
}
