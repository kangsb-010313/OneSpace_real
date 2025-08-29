package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.PracticeroomService;
import com.javaex.service.TeampageService;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamReciptVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVotePostVO;
import com.javaex.vo.TeamVoteResultVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

 
@Controller
@RequestMapping(value="/team")
public class TeampageController {

	//필드
	@Autowired
	private TeampageService teampageService;
	
	@Autowired
	private PracticeroomService practiceroomService;
	
	
	//메소드 일반
	
	/**
	 * 팀 스페이스 메인 페이지
	 * 로그인한 유저가 속한 모든 팀의 게시글을 최신순으로 
	 * @param session 로그인 유저 정보를 확인하기 위한 세션
	 * @param model   View로 데이터를 전달하기 위한 모델
	 * @return "teampage/teammain" 팀 메인 페이지 경로
	 */
    @RequestMapping(value="/teammain", method= {RequestMethod.GET, RequestMethod.POST})
    public String teamMain(HttpSession session, Model model) {
        System.out.println("TeampageController.teamMain()");
        
        // 1. 로그인 체크
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
        
        int userNo = authUser.getUserNo();
        
        // 2. 서비스로부터 데이터 가져오기
        //   - 로그인한 유저가 속한 모든 팀 리스트 (Aside)
        //   - 해당 팀들의 모든 게시글 리스트 (Main Content)
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        List<TeamPostVO> allPostsList = teampageService.exeGetAllUserPosts(userNo);
        
        // 3. 모델에 데이터 담기
        // View에 데이터 전달
        model.addAttribute("allTeams", userTeamList); 
        model.addAttribute("allPostsList", allPostsList);
        
        return "teampage/teammain";
    }
    
	
	// -- 팀페이지 팀 등록 폼
	/**
	 * 새로운 팀을 생성하는 폼 페이지로 이동합니다.
	 * @param session 로그인 유저 정보를 확인하기 위한 세션
	 * @param model   사이드바에 유저의 팀 목록을 표시하기 위한 모델
	 * @return "teampage/teamadd" 팀 생성 폼 페이지 경로
	 */
	@RequestMapping(value="/teamaddform", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamAddForm(HttpSession session, Model model) {
		System.out.println("TeampageController.teamAddForm()");
		
	    // aside에 팀 목록을 표시하기 위해 현재 로그인한 유저의 팀 리스트를 전달
	    UserVO authUser = (UserVO)session.getAttribute("authUser");
	    if(authUser == null) {
	        return "redirect:/onespace/loginForm";
	    }
	    
	    int userNo = authUser.getUserNo();
	    List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
	    model.addAttribute("allTeams", userTeamList);
		
		return "teampage/teamadd";
	}
	
	
	//팀페이지 팀 등록
	/**
	 * 팀 생성 폼에서 받은 정보로 새로운 팀을 생성
	 * 팀 생성 후, 생성자를 '팀장'으로 자동 등록합니다.
	 * @param teamVO  폼에서 전송된 팀 정보(팀 이름, 인스타 계정 등)
	 * @param session 팀 생성자(로그인 유저) 정보를 가져오기 위한 세션
	 * @return 생성된 팀의 게시글 리스트 페이지로 리다이렉트
	 */
	@RequestMapping(value="/teamadd", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamAdd(TeamVO teamVO, HttpSession session) { // 폼 데이터를 TeamVO로 바로
	    System.out.println("TeampageController.teamAdd()");
	    

	    UserVO authUser = (UserVO)session.getAttribute("authUser");
	    if(authUser == null) {
	        return "redirect:/onespace/loginForm"; // 로그인 안했으면 로그인폼으로
	    }
	     
	    int userNo = authUser.getUserNo();
	    
	    // 팀 생성 + 생성자를 팀원으로 등록
	    int newTeamNo = teampageService.exeAddTeam(teamVO, userNo);
	    
	    // 팀 생성이 완료되면 방금 만든 팀의 게시글 리스트 페이지로 이동
	    return "redirect:/onespace/teams/" + newTeamNo + "/posts/list";
	}
    
	
    // --팀페이지 전체 리스트 (특정 팀의 리스트)
	/**
	 * 특정 팀의 게시글 리스트 페이지
	 * @param teamNo  조회할 팀의 고유 번호
	 * @param session 로그인 유저 정보를 확인하기 위한 세션
	 * @param model   View로 데이터를 전달하기 위한 모델
	 * @return "teampage/list" 특정 팀 게시글 리스트 페이지 경로
	 */
    @RequestMapping(value="/teams/{teamNo}/posts/list", method= {RequestMethod.GET, RequestMethod.POST})
    public String list(@PathVariable("teamNo") int teamNo, 
    				   HttpSession session, 
    				   Model model) {
        System.out.println("TeampageController.list() for teamNo: " + teamNo);
        
        //로그인 체크
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
       
        // 서비스로부터 특정 팀의 게시글 목록과 팀 정보를 가져옴
        List<TeamPostVO> teamPostList = teampageService.exeListByTeam(teamNo);	
        model.addAttribute("teamPostList", teamPostList);
        
        
        // 특정 팀 정보 가져오기 (팀 이름 등)
        TeamVO currentTeam = teampageService.exeGetTeamInfo(teamNo);
        if (currentTeam != null) {
            model.addAttribute("teamName", currentTeam.getTeamName());
        } else {
            model.addAttribute("teamName", "알 수 없는 팀"); // 팀 정보가 없을 경우 대비
        }
        
        model.addAttribute("teamNo", teamNo); // 현재 보고 있는 팀의 teamNo를 JSP로 전달
        
        // 사이드바를 위한 유저의 전체 팀 목록
        int userNo = authUser.getUserNo();
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        model.addAttribute("allTeams", userTeamList); 

        return "teampage/list"; 
    }
	
	//--팀페이지 일반공지등록, 팀자랑등록, 투표만들기등록 폼
	/**
	 * 게시글(일반공지, 팀자랑, 투표) 작성 폼으로 이동
	 * '투표' 타입일 경우, 찜 목록에서 가져온 투표 후보 목록을 함께 전달
	 * @param teamNo       게시글을 작성할 팀의 고유 번호
	 * @param teamPostType 작성할 게시글의 종류 ('일반공지', '팀자랑', '투표')
	 * @param session      로그인 유저 정보를 확인하기 위한 세션
	 * @param model        View로 데이터를 전달하기 위한 모델
	 * @return "teampage/postWriteForm" 게시글 작성 폼 페이지 경로
	 */
    // URL: /onespace/teams/{teamNo}/posts/writeform?type={teamPostType}
	@RequestMapping(value="/teams/{teamNo}/posts/writeform", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamwriteForm(@PathVariable("teamNo") int teamNo,						// teamNo를 PathVariable로 받음
								@RequestParam("teamPostType") String teamPostType, 		// JSP에서 param.teamPostType으로 전달받은 값
								HttpSession session, 
								Model model) {
		System.out.println("TeampageController.teamwriteForm()");
		
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		
		if(authUser==null) {
			return "redirect:/onespace/loginForm";
		}
		
	    int userNo = authUser.getUserNo(); // userNo 가져오기
	    
	    // 글쓰기 종류가 '투표'일 경우에만
	    /*
	    if ("투표".equals(teamPostType)) {
	        // 서비스에서 투표 후보 목록을 가져옵니다.
	        List<TeamVotePostVO> voteCandidates = teampageService.exeGetVoteCandidates(userNo); 
	        model.addAttribute("voteCandidates", voteCandidates); // 모델에 "voteCandidates" 라는 이름으로 담기
	        System.out.println("불러온 투표 후보 목록: " + voteCandidates);
	    }
		*/
	    
	    List<Map<String, Object>> voteCandidates = practiceroomService.getFavoriteCandidates(userNo);

	    model.addAttribute("voteCandidates", voteCandidates);
	    System.out.println("불러온 투표 후보 목록: " + voteCandidates);
	    
		model.addAttribute("authUser", authUser);
		model.addAttribute("teamPostType", teamPostType); // 글 종류 JSP 전달용
        model.addAttribute("teamNo", teamNo); // teamNo도 JSP로 전달 (hidden input에 사용)
		
        //exeGetAllTeams() 대신 exeGetUserTeams() 사용
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        model.addAttribute("allTeams", userTeamList);

        TeamVO currentTeam = teampageService.exeGetTeamInfo(teamNo);
        model.addAttribute("currentTeam", currentTeam); // instaAccount를 포함한 팀 정보 전체를 전달
        
        if (currentTeam != null) {
            model.addAttribute("teamName", currentTeam.getTeamName());
        } else {
            model.addAttribute("teamName", "알 수 없는 팀");
        }
		
        
		return "teampage/postWriteForm";
	}
	
	//--팀페이지 글 등록
	/**
	 * 작성된 게시글 정보를 DB에 최종 등록
	 * '투표' 글일 경우, 선택된 후보(voteNoList) 정보도 함께 처리
	 * @param teamNo       게시글이 속한 팀의 고유 번호
	 * @param teamPostVO   폼에서 전송된 게시글 정보(제목, 내용, 파일 등)
	 * @param voteNoList   '투표' 글일 경우, 폼에서 전송된 투표 후보들의 고유 번호 리스트
	 * @param session      작성자(로그인 유저) 정보를 가져오기 위한 세션
	 * @return 해당 팀의 게시글 리스트 페이지로 리다이렉트
	 */
	// URL: /onespace/teams/{teamNo}/posts/teamwriteadd
	@RequestMapping(value="teams/{teamNo}/posts/teamwriteadd", method= {RequestMethod.GET, RequestMethod.POST})
	public String write(@PathVariable("teamNo") int teamNo,
						@ModelAttribute TeamPostVO teamPostVO,
						@RequestParam(value="voteNo", required=false) List<Integer> voteNoList,
						HttpSession session) {
		
		System.out.println("TeampageController.write()");
		System.out.println("넘어온 투표 번호 리스트: " + voteNoList); // 넘어오는지 로그로 확인
		
		

	    // 첨부된 파일이 있는지 먼저 확인
	    if (teamPostVO.getFiles() != null && teamPostVO.getFiles().length > 0) {
	        System.out.println("--- 첨부된 파일 목록 ---");
	        // 파일 개수만큼 반복
	        for (MultipartFile file : teamPostVO.getFiles()) {
	            // 파일 이름이 비어있지 않은 실제 파일일 경우에만 출력
	            if (!file.getOriginalFilename().isEmpty()) {
	                System.out.println("첨부파일명: " + file.getOriginalFilename());
	            }
	        }
	        System.out.println("----------------------");
	    }
		
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
		
		int userNo = authUser.getUserNo();
		
		teamPostVO.setUserNo(userNo); // 작성자 userNo 설정
        teamPostVO.setTeamNo(teamNo); // URL에서 받은 teamNo 설정
		
		teampageService.exeAdd(teamPostVO, voteNoList);
		
		return "redirect:/onespace/teams/" + teamNo + "/posts/list";
	}
	
    
	 //--팀페이지 등록 글 보기
	/**
	 * 특정 게시글의 상세 내용을 보여주는 페이지
	 * 게시글 종류('투표', '연습일정' 등)에 따라 다른 추가 정보를 조회하여 전달
	 * @param teamNo       게시글이 속한 팀의 고유 번호
	 * @param teamPostNo   조회할 게시글의 고유 번호
	 * @param session      로그인 유저 정보를 확인하기 위한 세션
	 * @param model        View로 데이터를 전달하기 위한 모델
	 * @return "teampage/view" 게시글 상세 보기 페이지 경로
	 */
	 // URL: /onespace/teams/{teamNo}/posts/{teamPostNo}
	 @RequestMapping(value="/teams/{teamNo}/posts/{teamPostNo}", method= {RequestMethod.GET, RequestMethod.POST})
	 public String viewPost(@PathVariable("teamNo") int teamNo, 
	                        @PathVariable("teamPostNo") int teamPostNo,
	                        HttpSession session,
	                        Model model) {
	     System.out.println("TeampageController.viewPost() for teamPostNo: " + teamPostNo);
	     
	     UserVO authUser = (UserVO)session.getAttribute("authUser");
	     if(authUser == null) { return "redirect:/onespace/loginForm"; }
	     
	     // --- 기본 정보 조회 및 모델에 추가 ---
	     int userNo = authUser.getUserNo();
	     TeamPostVO post = teampageService.exeGetPost(teamPostNo);
	     TeamVO currentTeam = teampageService.exeGetTeamInfo(teamNo);
	     List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
	     
	     model.addAttribute("post", post);
	     model.addAttribute("teamNo", teamNo);
	     model.addAttribute("teamName", currentTeam.getTeamName());
	     model.addAttribute("allTeams", userTeamList);
	     model.addAttribute("isMember", teampageService.isUserMember(userNo, teamNo));
	
	     // --- (핵심) 게시글 종류에 따라 추가 정보 조회 ---
	     if (post != null) {
	         String postType = post.getTeamPostType();
	
	         if ("투표".equals(postType)) {
	             // '투표' 글일 경우: 투표 옵션 목록 조회
	             List<TeamVotePostVO> voteOptions = teampageService.getVoteOptions(teamPostNo);
	             model.addAttribute("voteOptions", voteOptions);
	             
	             // (핵심) 현재 로그인한 유저가 이 게시글의 어떤 후보에게 투표했는지 목록 조회
	             List<Integer> userVotedList = teampageService.exeGetUserVotedOptions(userNo, teamPostNo);
	             model.addAttribute("userVotedList", userVotedList);
	
	         } else if ("연습일정".equals(postType)) {
	             // '연습일정' 글일 경우: 확정된 예약 정보 조회
	             String content = post.getTeamContent();
	             
	             // 1. 내용에서 숨겨둔 voteNo 추출
	             if (content != null && content.startsWith("[CONFIRMED_VOTE_NO:")) {
	                 try {
	                     int start = content.indexOf(":") + 1;
	                     int end = content.indexOf("]");
	                     int confirmedVoteNo = Integer.parseInt(content.substring(start, end));
	                     
	                     // 2. voteNo로 상세 정보(연습실 정보 + 투표자 목록) 조회
	                     Map<String, Object> confirmedInfo = teampageService.exeGetReservationInfoByVoteNo(confirmedVoteNo);
	                     
	                     // 3. 모델에 담기
	                     if (confirmedInfo != null) {
	                         model.addAttribute("confirmedOption", confirmedInfo.get("topOption"));
	                         model.addAttribute("voters", confirmedInfo.get("voters"));
	                         model.addAttribute("reserverName", confirmedInfo.get("reserverName")); 
	                     }
	                     
	                 } catch (Exception e) {
	                     System.out.println("연습일정 정보 파싱 실패: " + e.getMessage());
	                 }
	             }
	         }
	     }
	
	     return "teampage/view";
	 }
    
	
    // -- 팀페이지 등록글 수정 폼
    // URL: /onespace/teams/{teamNo}/posts/{teamPostNo}/modifyform
    @RequestMapping(value="/teams/{teamNo}/posts/{teamPostNo}/modifyform", method= {RequestMethod.GET, RequestMethod.POST})
    public String modifyForm(@PathVariable("teamNo") int teamNo,
                             @PathVariable("teamPostNo") int teamPostNo,
                             HttpSession session,
                             Model model) {
        System.out.println("TeampageController.modifyForm()");
        
        // 로그인 체크 (필수) 등록자만 수정 가능
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }

        // 기존 게시글 정보 가져오기
        TeamPostVO post = teampageService.exeGetPost(teamPostNo);

        // 작성자 본인인지 확인 (보안 강화)
        if (post == null || post.getUserNo() != authUser.getUserNo()) {
            return "redirect:/onespace/teams/" + teamNo + "/posts/" + teamPostNo; // 상세 페이지로 돌려보냄
        }
        
        model.addAttribute("post", post); // 수정할 게시글 정보
        model.addAttribute("teamNo", teamNo); // 현재 팀 번호
        
        int userNo = authUser.getUserNo();
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        model.addAttribute("allTeams", userTeamList);
        
        
        TeamVO currentTeam = teampageService.exeGetTeamInfo(teamNo);
        
        if (currentTeam != null) {
            model.addAttribute("teamName", currentTeam.getTeamName());
        } else {
            model.addAttribute("teamName", "알 수 없는 팀");
        }
        
        return "teampage/postModifyForm"; 
    }

    // -- 팀페이지 등록글 수정 처리
    // URL: /onespace/teams/{teamNo}/posts/modify
    @RequestMapping(value="/teams/{teamNo}/posts/modify", method= {RequestMethod.GET, RequestMethod.POST}) // 수정 처리는 POST로 받음
    public String modify(@PathVariable("teamNo") int teamNo,
                         TeamPostVO teamPostVO, // 폼에서 넘어온 데이터 (teamPostNo, teamPostType, teamPostTitle, teamContent)
                         HttpSession session) {
        System.out.println("TeampageController.modify()");

        // 로그인 체크 (필수)
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
        
        // 작성자 userNo 설정 (보안: 세션에서 가져와 다시 설정)
        teamPostVO.setUserNo(authUser.getUserNo()); 
        
        // teamNo 설정
        teamPostVO.setTeamNo(teamNo);

        teampageService.exeModify(teamPostVO); // 서비스 호출하여 DB 업데이트

        // 수정 후 해당 게시글 상세 페이지로 리다이렉트
        return "redirect:/onespace/teams/" + teamNo + "/posts/" + teamPostVO.getTeamPostNo();
    }
    
	
    // -- 팀페이지 등록글 삭제
    // URL: /onespace/teams/{teamNo}/posts/{teamPostNo}/delete
    @RequestMapping(value="/teams/{teamNo}/posts/{teamPostNo}/delete", method= {RequestMethod.GET, RequestMethod.POST})
    public String delete(@PathVariable("teamNo") int teamNo,
                         @PathVariable("teamPostNo") int teamPostNo,
                         HttpSession session) {
        
        System.out.println("TeampageController.delete()");
        
        // 로그인한 사용자인지 확인
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm"; // 로그인 안 했으면 로그인 페이지로
        }
        
        // 서비스에 삭제 요청
        // 본인 글만 삭제 버튼이 보이므로 바로 삭제
        int userNo = authUser.getUserNo();
        teampageService.exeDelete(teamPostNo, userNo);

        // 삭제 후 해당 팀의 게시글 리스트로 리다이렉트
        return "redirect:/onespace/teams/" + teamNo + "/posts/list";
    }

	
    // -- 팀원 관리 페이지 보여주기
    @RequestMapping(value="/teams/{teamNo}/manage", method=RequestMethod.GET)
    public String memberManage(@PathVariable("teamNo") int teamNo, 
    						   Model model, 
    						   HttpSession session) {
        System.out.println("TeampageController.memberManage() for team: " + teamNo);

        // 로그인한 유저가 이 팀의 '팀장'인지 확인
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null || !teampageService.isUserTeamLeader(authUser.getUserNo(), teamNo)) {
            // 팀장이 아니면, 해당 팀 게시글 목록으로 돌려보냄 -> 어느 페이지로 보내는가 나을까.. 일단 이렇게 간다
            return "redirect:/onespace/teams/" + teamNo + "/posts/list";
        }
        
        Map<String, Object> manageInfo = teampageService.exeGetMemberInfo(teamNo);
        
        model.addAttribute("teamInfo", manageInfo.get("teamInfo"));
        model.addAttribute("memberList", manageInfo.get("memberList"));
        
        // aside에 필요한 팀 목록도 추가
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(authUser.getUserNo());
        model.addAttribute("allTeams", userTeamList);
        
        return "teampage/teammember";
    }

    // -- 가입 신청 승인 처리
    @RequestMapping(value="/teams/{teamNo}/approve/{userNo}", method=RequestMethod.POST)
    public String approveMember(@PathVariable("teamNo") int teamNo, 
    							@PathVariable("userNo") int userNo, 
    							HttpSession session) {
        System.out.println("TeampageController.approveMember()");
        
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null || !teampageService.isUserTeamLeader(authUser.getUserNo(), teamNo)) {
            return "redirect:/onespace/teams/" + teamNo + "/posts/list";
        }
        
        teampageService.exeApproveMember(teamNo, userNo);
        
        return "redirect:/onespace/teams/" + teamNo + "/manage";
    }

    // -- 가입 신청 거부, 팀원 삭제 처리 -> 거부, 삭제 같은 개념
    @RequestMapping(value="/teams/{teamNo}/remove/{userNo}", method=RequestMethod.POST)
    public String removeMember(@PathVariable("teamNo") int teamNo, 
    						   @PathVariable("userNo") int userNo, 
    						   HttpSession session) {
        System.out.println("TeampageController.removeMember()");
        
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null || !teampageService.isUserTeamLeader(authUser.getUserNo(), teamNo)) {
            return "redirect:/onespace/teams/" + teamNo + "/posts/list";
        }
        
        teampageService.exeRemoveMember(teamNo, userNo);
        
        return "redirect:/onespace/teams/" + teamNo + "/manage";
    }
	

    // -- 팀원 가입 신청 처리
    @RequestMapping(value="/teams/{teamNo}/join", method=RequestMethod.POST)
    public String requestJoin(@PathVariable("teamNo") int teamNo, HttpSession session) {
        System.out.println("TeampageController.requestJoin() for team: " + teamNo);
        
        // 1. 로그인 정보 가져오기
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if (authUser == null) {
            // 로그인 안 했으면 로그인 페이지로 (보통은 여기까지 못 옴)
            return "redirect:/onespace/loginForm";
        }
        int userNo = authUser.getUserNo();
        
        // 2. 서비스에 가입 신청 로직 위임
        teampageService.exeRequestJoin(teamNo, userNo);
        
        // 3. 신청 완료 후 메인 페이지로 이동(팀이 없으면 아무 리스트도 안 보임)
        return "redirect:/onespace/teammain";
    }
	
	 // ==================== 투표/예약 관련 API ====================
	
	 // API '투표하기' 버튼 클릭 시 호출 (Ajax)
	/**
	 * [API] '투표하기' 요청을 Ajax로 처리
	 * @param voteNo  투표할 후보의 고유 번호
	 * @param postNo  투표가 속한 게시글의 고유 번호
	 * @param session 로그인 유저(투표자) 정보를 가져오기 위한 세션
	 * @return 투표 성공 시 true, 실패 시 false
	 */
    @ResponseBody
    @RequestMapping(value="/api/addvote", method=RequestMethod.POST)
    public boolean addVote(@RequestParam("voteNo") int voteNo,
                           @RequestParam("postNo") int postNo,
                           HttpSession session) {
        System.out.println("API: /api/addvote");
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if (authUser == null) { return false; }
        return teampageService.exeAddVote(authUser.getUserNo(), voteNo, postNo);
    }

    // API 특정 후보의 투표자 목록 실시간 조회 (Ajax)
    @ResponseBody
    @RequestMapping(value="/api/getvoters", method=RequestMethod.GET)
    public List<TeamVoteResultVO> getVoters(@RequestParam("voteNo") int voteNo) {
        System.out.println("API: /api/getvoters");
        return teampageService.exeGetVoters(voteNo);
    }
    
    // API '투표 취소하기' 버튼 클릭 시 호출 (Ajax)
    @ResponseBody
    @RequestMapping(value="/api/removevote", method=RequestMethod.POST)
    public boolean removeVote(@RequestParam("voteNo") int voteNo,
                              HttpSession session) {
        System.out.println("API: /api/removevote");
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if (authUser == null) { 
            return false; 
        }
        
        return teampageService.exeRemoveVote(authUser.getUserNo(), voteNo);
    }
	
	/**
	 * [페이지 이동] '바로 예약하기' 버튼 클릭 시, 예약 확정 페이지로 이동
	 * 예약 가능한 최다 득표 후보 정보를 조회하여 전달
	 * @param teamNo       현재 팀의 고유 번호
	 * @param postNo       '투표' 게시글의 고유 번호
	 * @param model        View로 데이터를 전달하기 위한 모델
	 * @param session      로그인 유저 정보를 확인하기 위한 세션
	 * @return "teampage/reservationConfirm" 예약 확정 페이지 경로
	 */
    @RequestMapping(value="/teams/{teamNo}/posts/{postNo}/confirm", method=RequestMethod.GET)
    public String showConfirmPage(@PathVariable("teamNo") int teamNo,
                                  @PathVariable("postNo") int postNo,
                                  Model model,
                                  HttpSession session) {
        System.out.println("TeampageController.showConfirmPage()");
        
        // Aside를 위한 팀 목록 조회 로직 ---
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm"; // 로그인 안했으면 바로 로그인폼으로
        }
        // 서비스 호출해서 현재 유저의 팀 목록 가져오기
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(authUser.getUserNo());
        // 모델에 "allTeams" 라는 이름으로 담기 (asideteampage.jsp가 이 이름을 사용함)
        model.addAttribute("allTeams", userTeamList);
        
        // 서비스에서 최다 득표 후보 정보 + 투표자 목록을 한 번에 가져옴
        Map<String, Object> reservationInfo = teampageService.getReservationInfo(postNo);
        
        // 만약 확정된 후보가 없으면 (아무도 투표 안했으면) 원래 투표 페이지로 돌려보냄
        if(reservationInfo == null || reservationInfo.get("topOption") == null) {
            System.out.println("투표자가 없어 예약 페이지로 이동할 수 없습니다.");
            return "redirect:/onespace/teams/" + teamNo + "/posts/" + postNo;
        }
        
        // JSP(View)로 데이터 전달
        model.addAttribute("confirmedOption", reservationInfo.get("topOption")); // 확정된 연습실 정보
        model.addAttribute("voters", reservationInfo.get("voters"));           // 투표자 목록 
        model.addAttribute("teamNo", teamNo);                                  // 현재 팀 번호
        model.addAttribute("originalPostNo", postNo);                          // 원래 투표 게시글 번호
        

        return "teampage/reservationConfirm"; 
    }

	/**
	 * [API] '결제하기' 요청을 Ajax로 처리하고 최종적으로 예약을 확정
	 * 새로운 '연습일정' 게시글 생성, 영수증 저장, 관련 상태 값 변경을 트랜잭션으로 처리
	 * @param teamNo         현재 팀의 고유 번호
	 * @param receiptVO      예약 확정 폼에서 전송된 데이터(결제수단, 연락처 등)
	 * @param roomName       게시글 제목에 사용할 연습실 이름
	 * @param originalPostNo 원본 '투표' 게시글의 고유 번호
	 * @param session        결제자(로그인 유저) 정보를 가져오기 위한 세션
	 * @return 새로 생성된 '연습일정' 게시글의 URL 경로
	 */
    @ResponseBody  
    @RequestMapping(value="/teams/{teamNo}/payment/execute", method=RequestMethod.POST)
    public String executePayment(@PathVariable("teamNo") int teamNo,
                                 @ModelAttribute TeamReciptVO receiptVO,
                                 @RequestParam("roomName") String roomName,
                                 @RequestParam("originalPostNo") int originalPostNo,
                                 HttpSession session) {
        System.out.println("TeampageController.executePayment()");
        
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm"; // 로그인 안했으면 로그인폼으로
        }
        
        // 폼 데이터에 없는 추가 정보(세션의 userNo)를 VO에 설정
        receiptVO.setUserNo(authUser.getUserNo());
        
        // 서비스에 최종 저장 로직 위임 (이 안에서 글 생성 + 영수증 생성 모두 처리됨)
        int newPracticePostNo = teampageService.exeCreateReceiptAndPost(receiptVO, teamNo, roomName, originalPostNo, authUser);
        
        //결제 확인 모달창에서 확인 누르고 이동
        return "/onespace/teams/" + teamNo + "/posts/" + newPracticePostNo;
    }


    
	
}
