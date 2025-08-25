package com.javaex.controller;

import java.io.FileInputStream;
import java.io.OutputStream;
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

import com.javaex.service.TeampageService;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamReciptVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVotePostVO;
import com.javaex.vo.TeamVoteResultVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping(value="/onespace")
public class TeampageController {

	//필드
	@Autowired
	private TeampageService teampageService;
	
	//생성자
	
	//메소드 gs
	
	//메소드 일반
	
    // --팀페이지 메인 (팀 선택 전, 모든 팀의 게시글 리스트)
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
        model.addAttribute("allTeams", userTeamList); 
        model.addAttribute("allPostsList", allPostsList);
        
        return "teampage/teammain";
    }
    
	
	// -- 팀페이지 팀 등록 폼
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
	@RequestMapping(value="/teamadd", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamAdd(TeamVO teamVO, HttpSession session) { // 폼 데이터를 TeamVO로 바로 받습니다.
	    System.out.println("TeampageController.teamAdd()");
	    

	    UserVO authUser = (UserVO)session.getAttribute("authUser");
	    if(authUser == null) {
	        return "redirect:/onespace/loginForm"; // 로그인 안했으면 로그인폼으로
	    }
	    
	    int userNo = authUser.getUserNo();
	    
	    // 팀 생성 + 생성자를 팀원으로 등록
	    int newTeamNo = teampageService.exeAddTeam(teamVO, userNo);
	    
	    // 팀 생성이 완료되면, 방금 만든 팀의 게시글 리스트 페이지로 이동합니다.
	    return "redirect:/onespace/teams/" + newTeamNo + "/posts/list";
	}
    
	
    // --팀페이지 전체 리스트 (특정 팀의 리스트)
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
       
        List<TeamPostVO> teamPostList = teampageService.exeListByTeam(teamNo);	//특정 팀의 게시글만 가져옴
//        System.out.println(teamPostList);
        model.addAttribute("teamPostList", teamPostList);
        
        
        // 특정 팀 정보 가져오기 (팀 이름 등)
        TeamVO currentTeam = teampageService.exeGetTeamInfo(teamNo);
        if (currentTeam != null) {
            model.addAttribute("teamName", currentTeam.getTeamName());
        } else {
            model.addAttribute("teamName", "알 수 없는 팀"); // 팀 정보가 없을 경우 대비
        }
        
        model.addAttribute("teamNo", teamNo); // 현재 보고 있는 팀의 teamNo를 JSP로 전달
        
        int userNo = authUser.getUserNo();
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        model.addAttribute("allTeams", userTeamList); 

        return "teampage/list"; 
    }
	
	//--팀페이지 일반공지등록, 팀자랑등록, 투표만들기등록 폼
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
	    if ("투표".equals(teamPostType)) {
	        // 서비스에서 투표 후보 목록을 가져옵니다.
	        List<TeamVotePostVO> voteCandidates = teampageService.exeGetVoteCandidates(userNo); 
	        model.addAttribute("voteCandidates", voteCandidates); // 모델에 "voteCandidates" 라는 이름으로 담기
	        System.out.println("불러온 투표 후보 목록: " + voteCandidates);
	    }
		
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
	
    // 이미지 파일 출력 메소드
    @RequestMapping(value="/display/{saveName}", method = RequestMethod.GET)
    public void display(@PathVariable("saveName") String saveName,
                        HttpServletResponse response) {
        
        System.out.println("이미지 출력 요청: " + saveName);
        
        // 1. 이미지가 저장된 폴더 경로를 지정
//        String saveDir = "C:\\javaStudy\\upload\\";
        
        // --- 여기부터 수정 ---
        String saveDir;
        String osName = System.getProperty("os.name").toLowerCase();

        // 윈도우일 경우
        if (osName.contains("win")) {
            // 윈도우 경로
            saveDir = "C:\\javaStudy\\upload\\";
        }
        // 맥 또는 리눅스일 경우
        else { 
            // 맥 경로 (AttachService와 동일하게 설정)
            saveDir = System.getProperty("user.home") + "/upload/";
        }
        // --- 여기까지 수정 ---
        
        // 2. 출력할 이미지 파일의 전체 경로
        String filePath = saveDir + saveName;
        
        try {
            // 3. 파일에서 데이터를 읽어올 InputStream
            FileInputStream fis = new FileInputStream(filePath);
            
            // 4. 읽어온 데이터를 브라우저로 보낼 OutputStream
            OutputStream os = response.getOutputStream();
            
            byte[] buffer = new byte[1024];
            int bytesRead;
            
            // 5. 파일 끝까지 1KB씩 반복해서 읽고, 읽자마자 브라우저로 쏴줌여
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            
            // 6. 파이프 닫아
            os.close();
            fis.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(saveName + " 이미지 파일을 찾을 수 없습니다.");
        }
    }
    
    
	 //--팀페이지 등록 글 보기
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
            // 팀장이 아니면, 해당 팀 게시글 목록으로 돌려보냄 -> 어느 페이지로 보내는가 나을까.. 
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
	
    /**
     * [1단계: 페이지 로딩] '바로 예약하기' 버튼 클릭 시, 예약 정보를 확인하는 페이지로 이동시킵니다.
     * @param teamNo 현재 팀 번호
     * @param postNo '투표' 게시글 원본 번호
     * @param model JSP로 데이터를 전달하기 위한 객체
     * @return "teampage/reservationConfirm.jsp"
     */
    @RequestMapping(value="/teams/{teamNo}/posts/{postNo}/confirm", method=RequestMethod.GET)
    public String showConfirmPage(@PathVariable("teamNo") int teamNo,
                                  @PathVariable("postNo") int postNo,
                                  Model model) {
        System.out.println("TeampageController.showConfirmPage()");
        
        // [수정] 서비스에서 최다 득표 후보 정보 + 투표자 목록을 한 번에 가져옴
        Map<String, Object> reservationInfo = teampageService.getReservationInfo(postNo);
        
        // 만약 확정된 후보가 없으면 (아무도 투표 안했으면) 원래 투표 페이지로 돌려보냄
        if(reservationInfo == null || reservationInfo.get("topOption") == null) {
            System.out.println("투표자가 없어 예약 페이지로 이동할 수 없습니다.");
            return "redirect:/onespace/teams/" + teamNo + "/posts/" + postNo;
        }
        
        // JSP(View)로 데이터 전달
        model.addAttribute("confirmedOption", reservationInfo.get("topOption")); // 확정된 연습실 정보
        model.addAttribute("voters", reservationInfo.get("voters"));           // [신규] 투표자 목록 추가
        model.addAttribute("teamNo", teamNo);                                  // 현재 팀 번호
        model.addAttribute("originalPostNo", postNo);                          // 원래 투표 게시글 번호
        
        // 새로 만든 JSP 파일로 요청을 넘김 (Forward)
        return "teampage/reservationConfirm"; 
    }

    /**
     * [2단계: 최종 실행] '결제하기' 버튼 클릭 시, 실제 결제 및 DB 저장 로직을 처리합니다.
     * @param teamNo 현재 팀 번호
     * @param receiptVO reservationConfirm.jsp의 form 데이터를 담아올 VO 객체
     * @param roomName (hidden input) 게시글 제목 생성을 위한 연습실 이름
     * @param session 로그인한 사용자 정보를 가져오기 위한 세션
     * @return 새로 생성된 '연습일정' 게시글의 상세 보기 페이지로 이동 (Redirect)
     */
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
        
        // 모든 처리가 끝나면, 새로 생성된 '연습일정' 게시글 상세 보기 페이지로 이동
        return "redirect:/onespace/teams/" + teamNo + "/posts/" + newPracticePostNo;
    }


    
	
}
