package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.repository.TeampageRepository;
import com.javaex.vo.TeamAttachmentsVO;
import com.javaex.vo.TeamMemberVO;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVoteOptionVO;
import com.javaex.vo.TeamVotePostVO;

@Service
public class TeampageService {

	//필드
	@Autowired
	private TeampageRepository teampageRepository;
	@Autowired
	private AttachService attachService;
	
	
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
		
		// 4. 팀 생성자를 '팀장'/'승인' 상태로 팀원에 추가
		teampageRepository.insertTeamMember(newTeamNo, userNo, "팀장", "승인");
		
		// 5. 환영 게시글 자동 생성 로직
		// 5-1. 게시글 정보를 담을 TeamPostVO 객체 생성
		TeamPostVO welcomePost = new TeamPostVO();
		welcomePost.setTeamNo(newTeamNo); // 방금 만든 팀 번호
		welcomePost.setUserNo(userNo);    // 팀 리더(생성자)의 번호
		welcomePost.setTeamPostType("일반공지"); // 게시글 타입
		welcomePost.setTeamPostTitle("팀 " + teamVO.getTeamName() + " 등록되었습니다.");
		welcomePost.setTeamContent("팀 " + teamVO.getTeamName() + " 정상적으로 등록되었습니다. 연습일정부터 연습실 예약까지 손쉽게 사용해보세요.");
		
		// 5-2. 게시글 등록을 위해 기존의 글쓰기 Repository 메소드 재사용
		teampageRepository.teampageInsert(welcomePost);
		
		// 6. Controller에게 새로 생성된 teamNo를 반환
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
	
	
    // 팀페이지 글 등록
    public void exeAdd(TeamPostVO teamPostVO) { // 반환타입을 void로 변경-> 리턴 안 시켜줘도 됨
        System.out.println("TeampageService.exeAdd()");

        // 1. 게시글 정보 저장 (posts 테이블)
        teampageRepository.teampageInsert(teamPostVO);

        // 2. 방금 저장한 게시글의 번호(PK)를 다시 조회해서 가져오기
        int postNo = teampageRepository.selectLastPostNo(teamPostVO.getUserNo());
        System.out.println("방금 저장된 게시글의 번호는: " + postNo);


        // 3. 첨부파일 저장 (teamAttachments 테이블)
        MultipartFile[] files = teamPostVO.getFiles();
        if (files != null && !files[0].getOriginalFilename().isEmpty()) {
            for (MultipartFile file : files) {
                // (1) 파일 저장 및 정보 받기
                TeamAttachmentsVO attachmentVO = attachService.exeSave(file);

                // (2) 파일 정보에 게시글 번호 세팅
                attachmentVO.setPostNo(postNo);

                // (3) 파일 정보 DB에 저장
                teampageRepository.insertAttachment(attachmentVO);
            }
        }
    }
	
    
    // --팀페이지 등록 글 보기
    public TeamPostVO exeGetPost(int teamPostNo) {
        System.out.println("TeampageService.exeGetPost()");
        
        // 1. 기존처럼 게시글의 기본 정보 가져옴
        TeamPostVO post = teampageRepository.teampageSelectPostByNo(teamPostNo);

        // 2. 게시글 정보가 성공적으로 조회되면
        if (post != null) {
            // 3. 위에서 가져온 게시글의 번호(teamPostNo)를 이용해서 첨부파일 목록을 추가로 가져옴
            List<TeamAttachmentsVO> attachments = teampageRepository.selectAttachments(teamPostNo);
            
            // 4. 가져온 첨부파일 목록을 post 객체의 주머니에 넣음(1단계에서 만든 필드)
            post.setAttachments(attachments);
        }
        
        return post;
    }
    
    /**
     * 투표 만들기 폼에 필요한 후보 목록을 가져오는 서비스 로직
     * @param userNo 현재 로그인한 사용자의 번호
     * @return 투표 후보 정보 리스트
     */
    public List<TeamVotePostVO> exeGetVoteCandidates(int userNo) {
        System.out.println("TeampageService.exeGetVoteCandidates()");
        return teampageRepository.selectVoteCandidates(userNo);
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
        
        TeamPostVO post = teampageRepository.teampageSelectPostByNo(teamPostNo);
        if (post != null && post.getUserNo() == authUserNo) {
            // 1. (추가) 자식 테이블인 첨부파일부터 먼저 삭제합니다.
            teampageRepository.deleteAttachments(teamPostNo);
            
            // 2. 그 다음에 부모 테이블인 게시글을 삭제합니다.
            return teampageRepository.teampageDelete(teamPostNo);
        } else {
            return 0; 
        }
    }

	 // 사용자의 찜 목록을 투표 후보로 가져오기
	    public List<TeamVoteOptionVO> exeGetWishlistForVote(int userNo) {
	        System.out.println("TeampageService.exeGetWishlistForVote()");
	        return teampageRepository.selectWishlistForVote(userNo);
	    }
	    
	// 특정 유저가 특정 팀의 멤버인지 확인하는 메소드
	public boolean isUserMember(int userNo, int teamNo) {
	    System.out.println("TeampageService.isUserMember()");
	    // 멤버 수가 0보다 크면 true(멤버임), 아니면 false(멤버 아님)를 반환
	    int count = teampageRepository.selectMemberCount(userNo, teamNo);
	    return count > 0;
	}
	
	// TeampageService.java


	// 특정 게시글이 해당 팀의 첫 환영 게시글인지 확인하는 메소드
	public boolean isWelcomePost(int teamPostNo, int teamNo) {
	    System.out.println("TeampageService.isWelcomePost()");
	    
	    // Repository를 통해 해당 팀의 첫 게시글 번호를 가져온다.
	    // Integer는 null을 담을 수 있어, 게시글이 하나도 없을 때의 오류를 방지합니다.
	    Integer firstPostNo = teampageRepository.selectFirstPostNo(teamNo);
	    
	    // 첫 게시글이 존재하고, 현재 게시글 번호와 일치하는지 확인
	    if (firstPostNo != null && firstPostNo.intValue() == teamPostNo) {
	        return true;
	    }
	    
	    return false;
	}
	
	

	// 팀원 관리 페이지 데이터 가져오기
	public Map<String, Object> exeGetMemberInfo(int teamNo) {
	    System.out.println("TeampageService.exeGetMemberInfo()");
	    
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    // 1. 팀 정보 가져오기 (페이지 제목 등에 사용)
	    TeamVO teamInfo = teampageRepository.selectTeamInfoByNo(teamNo);
	    resultMap.put("teamInfo", teamInfo);
	    
	    // 2. 팀 멤버 목록 가져오기
	    List<TeamMemberVO> memberList = teampageRepository.selectMembersByTeamNo(teamNo);
	    resultMap.put("memberList", memberList);
	    
	    return resultMap;
	}
	
	// 유저가 팀의 리더인지 확인하는 서비스 로직
	public boolean isUserTeamLeader(int userNo, int teamNo) {
	    System.out.println("TeampageService.isUserTeamLeader()");
	    return teampageRepository.isUserTeamLeader(userNo, teamNo) > 0;
	}


	// 멤버 상태 변경 (가입 승인)
	public void exeApproveMember(int teamNo, int userNo) {
	    System.out.println("TeampageService.exeApproveMember()");
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("teamNo", teamNo);
	    params.put("userNo", userNo);
	    params.put("status", "승인");
	    
	    teampageRepository.updateMemberStatus(params);
	}

	// 멤버 삭제 (가입 거부, 팀원 내보내기)
	public void exeRemoveMember(int teamNo, int userNo) {
	    System.out.println("TeampageService.exeRemoveMember()");
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("teamNo", teamNo);
	    params.put("userNo", userNo);
	    
	    teampageRepository.deleteMember(params);
	}

	// 팀원 가입 신청 처리
	public void exeRequestJoin(int teamNo, int userNo) {
	    System.out.println("TeampageService.exeRequestJoin()");
	    
	    // 기존의 insertTeamMember 메소드를 재사용하여 '보류' 상태의 팀원을 추가합니다.
	    teampageRepository.insertTeamMember(teamNo, userNo, "팀원", "보류");
	}
	
}
