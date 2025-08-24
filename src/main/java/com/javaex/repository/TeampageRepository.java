package com.javaex.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.TeamAttachmentsVO;
import com.javaex.vo.TeamMemberVO;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVoteOptionVO;
import com.javaex.vo.TeamVotePostVO;

@Repository
public class TeampageRepository {

	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//생성자
	
	
	//메소드 gs
	
	
	//메소드 일반
	
	//-- 팀페이지 팀 등록
    // teams 테이블에 팀 정보 추가
    public void insertTeam(TeamVO teamVO) {
        System.out.println("TeampageRepository.insertTeam()");
        // XML의 insertTeam 쿼리를 호출 teamVO에는 userNo도 ㅇㅇ
        sqlSession.insert("teampage.insertTeam", teamVO);
    }
    
    // 특정 사용자가 가장 최근에 만든 팀의 번호를 조회
    public int selectNewTeamNo(int userNo) {
        System.out.println("TeampageRepository.selectNewTeamNo()");
        int teamNo = sqlSession.selectOne("teampage.selectNewTeamNo", userNo);
        return teamNo;
    }
    
    //team_members 테이블에 팀원 정보 추가 (position, status 포함)
    public void insertTeamMember(int teamNo, int userNo, String position, String status) {
        System.out.println("TeampageRepository.insertTeamMember() - position: " + position + ", status: " + status);
        
        // 파라미터를 Map에 담아서 전달 
        Map<String, Object> params = new HashMap<>();
        params.put("teamNo", teamNo);
        params.put("userNo", userNo);
        params.put("position", position);
        params.put("status", status);
        
        sqlSession.insert("teampage.insertTeamMember", params);
    }
    
    // 특정 팀에 특정 유저가 몇 명 있는지 카운트 (0 또는 1)
    public int selectMemberCount(int userNo, int teamNo) {
        System.out.println("TeampageRepository.selectMemberCount()");
        Map<String, Integer> params = new HashMap<>();
        params.put("userNo", userNo);
        params.put("teamNo", teamNo);
        return sqlSession.selectOne("teampage.selectMemberCount", params);
    }
    
	
    // -- 유저 번호로 해당 유저가 속한 팀 목록 조회
    public List<TeamVO> selectTeamsByUserNo(int userNo) {
        System.out.println("TeampageRepository.selectTeamsByUserNo()");
        return sqlSession.selectList("teampage.selectTeamsByUserNo", userNo);
    }
    
    // -- 유저 번호로 해당 유저가 속한 모든 팀의 게시물 조회
    public List<TeamPostVO> selectPostsByUserTeams(int userNo) {
        System.out.println("TeampageRepository.selectPostsByUserTeams()");
        return sqlSession.selectList("teampage.selectPostsByUserTeams", userNo);
    }
    
    
	
    // --팀페이지 전체 리스트 (특정 팀의 리스트)
    public List<TeamPostVO> teampageSelectListByTeamNo(int teamNo){
    	
        System.out.println("TeampageRepository.teampageSelectListByTeamNo()");
        
        // teamNo를 파라미터로 전달
        List<TeamPostVO> teamPostList = sqlSession.selectList("teampage.selectListByTeamNo", teamNo);
        
        return teamPostList;
    }
	
	
	//--팀페이지 글 등록
	public int teampageInsert(TeamPostVO teamPostVO) {
		System.out.println("TeampageRepository.teampageInsert()");
		
		int count = sqlSession.insert("teampage.insert", teamPostVO);
		
		return count;
	}
	
    // 마지막 게시글 번호 가져오기
    public int selectLastPostNo(int userNo) {
        System.out.println("TeampageRepository.selectLastPostNo()");
        return sqlSession.selectOne("teampage.selectLastPostNo", userNo);
    }

    // 첨부파일 정보 저장
    public int insertAttachment(TeamAttachmentsVO teamAttachmentsVO) {
        System.out.println("TeampageRepository.insertAttachment()");
        return sqlSession.insert("teampage.insertAttachment", teamAttachmentsVO);
    }
    
    // 특정 게시글의 첨부파일 목록 가져오기
    public List<TeamAttachmentsVO> selectAttachments(int postNo) {
        System.out.println("TeampageRepository.selectAttachments()");
        return sqlSession.selectList("teampage.selectAttachmentsByPostNo", postNo);
    }
	
	//--팀페이지 등록 글 보기
    public TeamPostVO teampageSelectPostByNo(int teamPostNo) {
    	
        System.out.println("TeampageRepository.teampageSelectPostByNo()");
        
        TeamPostVO post = sqlSession.selectOne("teampage.selectPostByNo", teamPostNo);
        
        return post;
    }
    
    /**
     * 투표 만들기 폼에 필요한 후보 목록을 조회합니다.
     * (아직 게시물로 등록되지 않은, 사용자의 투표 후보 목록)
     * @param userNo 현재 로그인한 사용자의 번호
     * @return 투표 후보 정보가 담긴 List
     */
    public List<TeamVotePostVO> selectVoteCandidates(int userNo) {
        System.out.println("TeampageRepository.selectVoteCandidates()");
        List<TeamVotePostVO> candidates = sqlSession.selectList("teampage.selectVoteCandidates", userNo);
        return candidates;
    }
    
    //투표 등록할 때 후보등록
    public List<TeamVotePostVO> selectVoteOptionsByPostNo(int postNo) {
        System.out.println("TeampageRepository.selectVoteOptionsByPostNo()");
        return sqlSession.selectList("teampage.selectVoteOptionsByPostNo", postNo);
    }

	
	 // votes 테이블에 postNo 업데이트
	 public int updatePostNoInVotes(Map<String, Object> params) {
	     System.out.println("TeampageRepository.updatePostNoInVotes()");
	     return sqlSession.update("teampage.updatePostNoInVotes", params);
	 }
	
	 // voteOptions 테이블의 status 업데이트
	 public int updateStatusInVoteOptions(Map<String, Object> params) {
	     System.out.println("TeampageRepository.updateStatusInVoteOptions()");
	     return sqlSession.update("teampage.updateStatusInVoteOptions", params);
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
    
    // -- 팀페이지 등록글 수정 처리
    public int teampageUpdate(TeamPostVO teamPostVO) {
        System.out.println("TeampageRepository.teampageUpdate()");
        
        int count = sqlSession.update("teampage.update", teamPostVO);
        
        return count;
    }
    
    // -- 팀페이지 등록글 삭제
    public int teampageDelete(int teamPostNo) {
        System.out.println("TeampageRepository.teampageDelete()");
        
        int count = sqlSession.delete("teampage.delete", teamPostNo);
        
        return count;
    }
    
    //-- 팀페이지 파일첨부 삭제
    public int deleteAttachments(int postNo) {
        System.out.println("TeampageRepository.deleteAttachments()");
        return sqlSession.delete("teampage.deleteAttachmentsByPostNo", postNo);
    }

	 // 사용자의 찜 목록을 투표 후보로 가져오기
	 public List<TeamVoteOptionVO> selectWishlistForVote(int userNo) {
	     System.out.println("TeampageRepository.selectWishlistForVote()");
	     // 호출하는 SQL 아이디를 새로운 쿼리 아이디로 변경
	     return sqlSession.selectList("teampage.selectWishlistForVote", userNo);
	 }


	// 특정 팀의 첫 번째 게시글(가장 작은 teamPostNo) 번호를 조회
	 public Integer selectFirstPostNo(int teamNo) {
	     System.out.println("TeampageRepository.selectFirstPostNo()");
	     return sqlSession.selectOne("teampage.selectFirstPostNo", teamNo);
	 }


	// 팀원 관리 페이지에 필요한 멤버 목록 가져오기
	 public List<TeamMemberVO> selectMembersByTeamNo(int teamNo) {
	     System.out.println("TeampageRepository.selectMembersByTeamNo()");
	     return sqlSession.selectList("teampage.selectMembersByTeamNo", teamNo);
	 }
	 
	// 유저가 팀의 리더인지 확인
	 public int isUserTeamLeader(int userNo, int teamNo) {
	     System.out.println("TeampageRepository.isUserTeamLeader()");
	     Map<String, Object> params = new HashMap<>();
	     params.put("userNo", userNo);
	     params.put("teamNo", teamNo);
	     return sqlSession.selectOne("teampage.isUserTeamLeader", params);
	 }


	 // 팀원 상태 업데이트 (승인 시 사용)
	 public int updateMemberStatus(Map<String, Object> params) {
	     System.out.println("TeampageRepository.updateMemberStatus()");
	     return sqlSession.update("teampage.updateMemberStatus", params);
	 }

	 // 팀원 삭제 (거부, 강퇴 시 사용)
	 public int deleteMember(Map<String, Object> params) {
	     System.out.println("TeampageRepository.deleteMember()");
	     return sqlSession.delete("teampage.deleteMember", params);
	 }
	
}
