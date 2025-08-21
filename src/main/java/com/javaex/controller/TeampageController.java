package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.TeampageService;
import com.javaex.vo.TeamPostVO;
import com.javaex.vo.TeamVO;
import com.javaex.vo.TeamVoteOptionVO;
import com.javaex.vo.UserVO;

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
        //   - 로그인한 유저가 속한 모든 팀 리스트 (for Aside)
        //   - 해당 팀들의 모든 게시글 리스트 (for Main Content)
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
		
	    // aside에 팀 목록을 표시하기 위해 현재 로그인한 유저의 팀 리스트를 전달합니다.
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
	    
	    // 로그인한 사용자 정보를 가져옵니다.
	    UserVO authUser = (UserVO)session.getAttribute("authUser");
	    if(authUser == null) {
	        return "redirect:/onespace/loginForm"; // 로그인 안했으면 로그인폼으로
	    }
	    
	    int userNo = authUser.getUserNo();
	    
	    // 서비스에 팀 생성 로직을 위임합니다.
	    // 팀 생성 + 생성자를 팀원으로 등록하는 작업이 한번에 이루어집니다.
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
        
        // 현재 보고 있는 팀의 teamNo를 JSP로 전달

        model.addAttribute("teamNo", teamNo); // 현재 보고 있는 팀의 teamNo를 JSP로 전달
        
        // aside에 뿌려줄 *로그인 유저의* 팀 목록 가져오기 [수정]
        int userNo = authUser.getUserNo();
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        model.addAttribute("allTeams", userTeamList); // aside.jsp가 사용하는 모델 이름 'allTeams'로 전달

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
	        // exeGetVoteOptions 대신 exeGetWishlistForVote 호출
	        List<TeamVoteOptionVO> voteOptions = teampageService.exeGetWishlistForVote(userNo); 
	        model.addAttribute("voteOptions", voteOptions);
	        System.out.println("불러온 찜 목록: " + voteOptions);
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
						TeamPostVO teamPostVO, 
						HttpSession session) {
		
		System.out.println("TeampageController.write()");
		
		UserVO authUser = (UserVO)session.getAttribute("authUser");
		
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
		
		int userNo = authUser.getUserNo();
		
		teamPostVO.setUserNo(userNo); // 작성자 userNo 설정
        teamPostVO.setTeamNo(teamNo); // URL에서 받은 teamNo 설정!
		
		teampageService.exeAdd(teamPostVO);
		
		return "redirect:/onespace/teams/" + teamNo + "/posts/list";
	}
	
	//--팀페이지 등록 글 보기
	// URL: /onespace/teams/{teamNo}/posts/{teamPostNo} (또는 /onespace/posts/{teamPostNo}로 단순화도 가능)
    @RequestMapping(value="/teams/{teamNo}/posts/{teamPostNo}", method= {RequestMethod.GET, RequestMethod.POST})
    public String viewPost(@PathVariable("teamNo") int teamNo, // 리스트로 돌아갈 때 필요할 수 있음
                           @PathVariable("teamPostNo") int teamPostNo,
                           HttpSession session,
                           Model model) {
        System.out.println("TeampageController.viewPost() for teamPostNo: " + teamPostNo);
        
        //로그인 체크 추가
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }
        
        int userNo = authUser.getUserNo();
        
        // 현재 로그인한 유저가 이 팀의 멤버인지 확인하는 로직
        boolean isMember = teampageService.isUserMember(userNo, teamNo);
        model.addAttribute("isMember", isMember); // 결과를 모델에 담아 JSP로 전달
        
        //  현재 보고 있는 글이 '환영 게시글'인지 확인
        boolean isWelcomePost = teampageService.isWelcomePost(teamPostNo, teamNo);
        model.addAttribute("isWelcomePost", isWelcomePost);

        TeamPostVO post = teampageService.exeGetPost(teamPostNo);
        model.addAttribute("post", post); // 게시글 정보를 "post"라는 이름으로 JSP에 전달

        // JSP에서 '목록으로' 돌아갈 때 현재 팀 번호가 필요할 수 있으므로 전달
        model.addAttribute("teamNo", teamNo); 
        
        List<TeamVO> userTeamList = teampageService.exeGetUserTeams(userNo);
        model.addAttribute("allTeams", userTeamList);

        TeamVO currentTeam = teampageService.exeGetTeamInfo(teamNo);
        if (currentTeam != null) {
            model.addAttribute("teamName", currentTeam.getTeamName());
        } else {
            model.addAttribute("teamName", "알 수 없는 팀");
        }

        return "teampage/view"; // 게시글 상세 보기를 위한 JSP 파일 이름 (예: view.jsp)
    }
	
    // -- 팀페이지 등록글 수정 폼
    // URL: /onespace/teams/{teamNo}/posts/{teamPostNo}/modifyform
    @RequestMapping(value="/teams/{teamNo}/posts/{teamPostNo}/modifyform", method= {RequestMethod.GET, RequestMethod.POST})
    public String modifyForm(@PathVariable("teamNo") int teamNo,
                             @PathVariable("teamPostNo") int teamPostNo,
                             HttpSession session,
                             Model model) {
        System.out.println("TeampageController.modifyForm()");
        
        // 로그인 체크 (필수)
        UserVO authUser = (UserVO)session.getAttribute("authUser");
        if(authUser == null) {
            return "redirect:/onespace/loginForm";
        }

        // 기존 게시글 정보 가져오기
        TeamPostVO post = teampageService.exeGetPost(teamPostNo);

        // 작성자 본인인지 확인 (보안 강화)
        if (post == null || post.getUserNo() != authUser.getUserNo()) {
            // TODO: 권한 없음 페이지 또는 에러 처리
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
        
        return "teampage/postModifyForm"; // 글쓰기 폼이랑 같이 사용
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
        
        // 서비스에 삭제 요청 (작성자 본인인지 확인하는 로직은 서비스나 컨트롤러에 추가할 수 있습니다)
        // 여기서는 본인 글만 삭제 버튼이 보이므로 바로 삭제를 진행합니다.
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
            // 팀장이 아니면, 해당 팀 게시글 목록으로 돌려보냄
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

    // -- 가입 신청 거부 또는 팀원 삭제 처리
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
            // 로그인 안 했으면 로그인 페이지로 (보통은 여기까지 올 수 없음)
            return "redirect:/onespace/loginForm";
        }
        int userNo = authUser.getUserNo();
        
        // 2. 서비스에 가입 신청 로직 위임
        teampageService.exeRequestJoin(teamNo, userNo);
        
        // 3. 신청 완료 후, 사용자에게 알림을 주고 메인 페이지나 다른 적절한 페이지로 이동
        // TODO: "가입 신청이 완료되었습니다. 팀장의 승인을 기다려주세요." 같은 알림 페이지를 만들어주면 더 좋습니다.
        //       우선은 팀 메인 페이지로 리다이렉트합니다.
        return "redirect:/onespace/teammain";
    }

	
	
	
	
	
}
