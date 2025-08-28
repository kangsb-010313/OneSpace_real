package com.javaex.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.repository.TeampageRepository;
import com.javaex.vo.TeamAttachmentsVO;
import com.javaex.vo.TeamMemberVO;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamReciptVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVoteOptionVO;
import com.javaex.vo.TeamVotePostVO;
import com.javaex.vo.TeamVoteResultVO;
import com.javaex.vo.UserVO;

@Service
public class TeampageService {

	//필드
	@Autowired
	private TeampageRepository teampageRepository;
	@Autowired
	private AttachService attachService;
	
	
	//메소드일반
	
	//-- 팀페이지 팀 등록 
	/**
	 * 새로운 팀을 생성하고, 생성자를 '팀장'으로 팀원 목록에 추가
	 * 팀 생성 시 환영 게시글을 자동으로 생성
	 * @param teamVO 팀 생성에 필요한 정보
	 * @param userNo 팀을 생성하는 유저의 고유 번호
	 * @return 새로 생성된 팀의 고유 번호(teamNo)
	 */
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
    /**
     * 특정 유저가 '승인' 상태로 소속된 모든 팀의 목록을 조회 (사이드바에 사용)
     * @param userNo 유저의 고유 번호
     * @return 팀 정보(TeamVO) 리스트
     */
    public List<TeamVO> exeGetUserTeams(int userNo) {
        System.out.println("TeampageService.exeGetUserTeams()");
        return teampageRepository.selectTeamsByUserNo(userNo);
    }
    
    // -- 로그인 유저가 속한 모든 팀의 게시글 가져오기 (for teammain content)
    /**
     * 특정 유저가 소속된 모든 팀의 전체 게시글을 최신순으로 조회 (팀 메인 페이지용)
     * @param userNo 유저의 고유 번호
     * @return 게시글 정보(TeamPostVO) 리스트
     */
    public List<TeamPostVO> exeGetAllUserPosts(int userNo) {
        System.out.println("TeampageService.exeGetAllUserPosts()");
        return teampageRepository.selectPostsByUserTeams(userNo);
    }
    
    
	
    // --팀페이지 전체 리스트 (특정 팀의 리스트)
	/**
	 * 특정 팀(teamNo)에 속한 모든 게시글을 조회
	 * @param teamNo 조회할 팀의 고유 번호
	 * @return 게시글 정보(TeamPostVO) 리스트
	 */
    public List<TeamPostVO> exeListByTeam(int teamNo){
    	
        System.out.println("TeampageService.exeListByTeam()");
        
        List<TeamPostVO> teamPostList = teampageRepository.teampageSelectListByTeamNo(teamNo);
        
        return teamPostList;
    }
	
	
    // 팀페이지 글 등록
	/**
	 * 새로운 게시글을 등록. 첨부파일과 투표 정보도 함께 처리
	 * @param teamPostVO 게시글 정보(제목, 내용, 타입, 파일 등)
	 * @param voteNoList '투표' 글일 경우, 등록할 후보들의 고유 번호 리스트
	 */
    @Transactional
    public void exeAdd(TeamPostVO teamPostVO, List<Integer> voteNoList) { // 반환타입을 void로 변경-> 리턴 안 시켜줘도 됨
        System.out.println("TeampageService.exeAdd()");

        // 1. 게시글 정보 저장 (posts 테이블)
        teampageRepository.teampageInsert(teamPostVO);

        // 2. 방금 저장한 게시글의 번호(PK)를 다시 조회해서 가져오기
        int postNo = teampageRepository.selectLastPostNo(teamPostVO.getUserNo());
        System.out.println("방금 저장된 게시글의 번호는: " + postNo);
        
        if ("투표".equals(teamPostVO.getTeamPostType()) && voteNoList != null && !voteNoList.isEmpty()) {
            Map<String, Object> params = new HashMap<>();
            params.put("postNo", postNo);
            params.put("voteNoList", voteNoList);

            teampageRepository.updatePostNoInVotes(params); // votes 테이블 업데이트
            teampageRepository.updateStatusInVoteOptions(params); // voteOptions 상태 업데이트
        }


        // 3. 첨부파일 저장 로직 변경
        MultipartFile[] files = teamPostVO.getFiles();
        if (files != null && !files[0].getOriginalFilename().isEmpty()) {
            for (MultipartFile file : files) {
                
                // (1) AttachService를 호출하여 파일을 실제 폴더에 저장하고, 그 정보를 Map으로 받음
                Map<String, Object> fileInfo = attachService.saveFile(file);

                // (2) 파일 저장에 성공했다면, DB에 저장할 정보를 TeamAttachmentsVO에 담음
                if (fileInfo != null) {
                    TeamAttachmentsVO attachmentVO = new TeamAttachmentsVO();
                    attachmentVO.setPostNo(postNo); // 어느 게시글에 속한 파일인지 (FK)
                    attachmentVO.setTeamOriginFileName((String) fileInfo.get("orgName"));
                    attachmentVO.setTeamStoredFileName((String) fileInfo.get("saveName"));
                    attachmentVO.setTeamFilePath((String) fileInfo.get("filePath"));
                    attachmentVO.setTeamFileSize((Long) fileInfo.get("fileSize"));

                    // (3) TeampageRepository를 통해 'teamAttachments' 테이블에 파일 정보를 저장
                    teampageRepository.insertAttachment(attachmentVO);
                }
            }
        }
    }
	
    
    // --팀페이지 등록 글 보기
	/**
	 * 게시글 한 개의 상세 정보를 조회
	 * 게시글의 기본 정보와 함께 첨부파일 목록도 함께 가져오긔
	 * @param teamPostNo 조회할 게시글의 고유 번호
	 * @return 게시글 정보(TeamPostVO) 객체
	 */
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
	 * '투표 만들기' 폼에 보여줄, 유저가 찜한 투표 후보 목록을 조회
	 * (아직 게시물로 등록되지 않고, voteStatus가 0인 후보들)
	 * @param userNo 현재 로그인한 유저의 고유 번호
	 * @return 투표 후보 정보(TeamVotePostVO) 리스트
	 */
    public List<TeamVotePostVO> exeGetVoteCandidates(int userNo) {
        System.out.println("TeampageService.exeGetVoteCandidates()");
        return teampageRepository.selectVoteCandidates(userNo);
    }
    
	/**
	 * 특정 '투표' 게시글에 포함된 모든 후보 목록을 조회
	 * (경쟁팀 수, 예약 완료 여부 등의 추가 정보 포함)
	 * @param postNo 조회할 '투표' 게시글의 고유 번호
	 * @return 투표 후보 정보(TeamVotePostVO) 리스트
	 */
    public List<TeamVotePostVO> getVoteOptions(int postNo) {
        System.out.println("TeampageService.getVoteOptions()");
        return teampageRepository.selectVoteOptionsByPostNo(postNo);
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
	
	// ==================== 투표 기능 관련 ====================
	// 투표 기록하기 (같은 후보 중복 투표 방지)
	@Transactional
	public boolean exeAddVote(int userNo, int voteNo, int postNo) {
	    System.out.println("TeampageService.exeAddVote()");
	    
	    // [방어 로직] 해당 투표가 이미 마감되었는지 확인
	    int postStatus = teampageRepository.selectPostStatusByVoteNo(voteNo);
	    if (postStatus != 0) {
	        System.out.println("오류: 이미 마감된 투표(postStatus=" + postStatus + ")에 투표 시도.");
	        return false;
	    }
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("voteNo", voteNo);

	    // 1. 이 후보에게 이미 투표했는지 확인
	    int count = teampageRepository.checkIfUserVotedForOption(params);
	    
	    // 2. 투표한 기록이 없으면(0이면) 새로 추가
	    if (count == 0) {
	        teampageRepository.insertVoteResult(params);
	        return true; // 성공
	    } else {
	        return false; // 이미 투표함 (실패)
	    }
	}
	
	// 특정 유저가 특정 게시글에서 투표한 후보(voteNo) 목록 가져오기
	public List<Integer> exeGetUserVotedOptions(int userNo, int postNo) {
	    System.out.println("TeampageService.exeGetUserVotedOptions()");
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("postNo", postNo);
	    
	    return teampageRepository.selectUserVotedOptionsInPost(params);
	}

	// 특정 후보에 투표한 유저 목록 가져오기
	public List<TeamVoteResultVO> exeGetVoters(int voteNo) {
	    System.out.println("TeampageService.exeGetVoters()");
	    return teampageRepository.selectVotersByVoteNo(voteNo);
	}
	
	/**
	 * 투표 취소 로직
	 * @param userNo 현재 로그인한 사용자 번호
	 * @param voteNo 취소할 투표 후보 번호
	 * @return 삭제 성공 시 true, 실패 시 false
	 */
	public boolean exeRemoveVote(int userNo, int voteNo) {
	    System.out.println("TeampageService.exeRemoveVote()");
	    
	    // [방어 로직] 해당 투표가 이미 마감되었는지 확인
	    int postStatus = teampageRepository.selectPostStatusByVoteNo(voteNo);
	    if (postStatus != 0) {
	        System.out.println("오류: 이미 마감된 투표(postStatus=" + postStatus + ")는 취소할 수 없음.");
	        return false;
	    }
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("voteNo", voteNo);

	    int count = teampageRepository.deleteVoteResult(params);

	    return count > 0; // 1개 이상 삭제되었으면 true 반환
	}
	
	// ==================== 예약 확정 기능 관련 ====================

	/**
	 * '예약 확인' 페이지에 필요한 정보를 조회
	 * 예약 가능한 후보들 중 최다 득표 후보 1개와 해당 후보의 투표자 목록을 반환
	 * @param postNo '투표' 게시글의 고유 번호
	 * @return 최다 득표 후보 정보와 투표자 목록이 담긴 Map
	 */
	public Map<String, Object> getReservationInfo(int postNo) {
	    System.out.println("TeampageService.getReservationInfo()");
	    
        // 1. '예약 가능한' 후보들을 득표수 순으로 가져옴
        List<TeamVotePostVO> availableOptions = teampageRepository.selectAvailableVoteOptionsRanked(postNo);
        
        // 2. 예약 가능한 후보가 아무도 없으면 null을 반환
        if (availableOptions == null || availableOptions.isEmpty()) {
            return null; 
        }
        
        // 3. 목록의 가장 첫 번째 항목이 '예약 가능한 최다 득표 후보'
        TeamVotePostVO topOption = availableOptions.get(0);
        
        // 4. 해당 후보의 상세 정보와 투표자 목록을 조회
        List<TeamVoteResultVO> voters = teampageRepository.selectVotersByVoteNo(topOption.getVoteNo());
        
        // 5. 두 정보를 Map에 담아서 Controller로 전달
        Map<String, Object> reservationInfo = new HashMap<>();
        reservationInfo.put("topOption", topOption);
        reservationInfo.put("voters", voters);
	    
	    return reservationInfo;
	}

	/**
	 * [트랜잭션] 최종 결제를 실행하고 관련 데이터를 모두 업데이트
	 * 1. '연습일정' 게시글 생성
	 * 2. 영수증 정보 저장
	 * 3. 결제된 후보 상태를 2(예약확정)로 변경
	 * 4. 나머지 후보 상태를 3(투표종료)로 변경
	 * 5. 원본 투표 게시글 상태를 1(예약완료)로 변경
	 * @param receiptVO      결제 정보가 담긴 VO
	 * @param teamNo         현재 팀 번호
	 * @param roomName       '연습일정' 글 제목에 사용할 연습실 이름
	 * @param originalPostNo 원본 '투표' 게시글 번호
	 * @param authUser       로그인 유저 정보
	 * @return 새로 생성된 '연습일정' 게시글의 고유 번호
	 */
	@Transactional
	public int exeCreateReceiptAndPost(TeamReciptVO receiptVO, int teamNo, String roomName, int originalPostNo, UserVO authUser) {
	    System.out.println("TeampageService.exeCreateReceiptAndPost()");

	    // 1. '연습일정' 타입의 새 게시글 VO를 생성하고 데이터를 채웁니다.
	    TeamPostVO newPost = new TeamPostVO();
	    newPost.setTeamNo(teamNo);
	    newPost.setUserNo(authUser.getUserNo());
	    newPost.setTeamPostTitle("[연습일정 확정] " + roomName); // JSP에서 넘겨받은 roomName 사용
	    
	    // 오류나던 부분을 수정합니다. 이제 receiptVO에 voteNo가 담겨서 넘어옵니다.
	    newPost.setTeamContent("[CONFIRMED_VOTE_NO:" + receiptVO.getVoteNo() + "]");
	    newPost.setTeamPostType("연습일정");
	    
	    // 2. '연습일정' 게시글을 DB에 INSERT
	    teampageRepository.insertNewPost(newPost);
	    int newPostNo = newPost.getTeamPostNo(); 
	    
	    // 3. 영수증(TeamReciptVO) 정보 저장
	    // reservationTime(String) 필드에 맞게 Date 객체를 "yyyy-MM-dd HH:mm:ss" 형태의 문자열로 변환하여 저장
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    receiptVO.setReservationTime(sdf.format(new Date()));
	    teampageRepository.insertReceipt(receiptVO);
	    
	    // 4-1. '결제된' 후보(voteNo)의 상태만 2(예약확정)로 변경합니다.
	    int confirmedVoteNo = receiptVO.getVoteNo();
	    teampageRepository.updateVoteStatusByVoteNo(confirmedVoteNo, 2);
	    
	    // 4-2. 원본 투표 게시글에 속한 '나머지 모든' 후보들의 상태를 3(투표종료)으로 변경합니다.
	    teampageRepository.updateOtherVoteStatusInPost(originalPostNo, confirmedVoteNo, 3);
	    
	    // 5. !!!원본 투표 게시글 자체의 상태를 1('예약완료')로 변경 (기존 코드 유지)
	    Map<String, Object> params = new HashMap<>();
	    params.put("postNo", originalPostNo);
	    params.put("status", 1);
	    teampageRepository.updatePostStatus(params);

	    System.out.println("TeampageService.exeCreateReceiptAndPost() 종료: 새 게시글 번호 " + newPostNo);

	    // 6. 모든 작업이 성공하면, 새로 생성된 게시글 번호를 Controller로 반환
	    return newPostNo;
	}

	
	// voteNo로 예약 정보(후보 상세 + 투표자 목록) 조회
	public Map<String, Object> exeGetReservationInfoByVoteNo(int voteNo) {
	    System.out.println("TeampageService.exeGetReservationInfoByVoteNo()");
	    
	    TeamVotePostVO topOption = teampageRepository.getVoteOptionDetail(voteNo);
	    List<TeamVoteResultVO> voters = teampageRepository.selectVotersByVoteNo(voteNo);
	    
	    // Repository를 호출하여 실제 예약자 이름을 조회
	    String reserverName = teampageRepository.selectReserverNameByVoteNo(voteNo);
	    
	    Map<String, Object> reservationInfo = new HashMap<>();
	    reservationInfo.put("topOption", topOption);
	    reservationInfo.put("voters", voters);
	    reservationInfo.put("reserverName", reserverName); 
	    
	    return reservationInfo;
	}
	
	
}
