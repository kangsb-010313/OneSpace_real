package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.TeampageService;
import com.javaex.vo.TeamPostVO;
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
	//--팀페이지 전체 리스트
//	@RequestMapping(value="/list", method= {RequestMethod.GET, RequestMethod.POST})
//	public String list(Model model) {
//		System.out.println("TeampageController.list()");
//		
//		List<TeamPostVO> teamPostList = teampageService.exeList();
//		System.out.println(teamPostList);
//		
//		model.addAttribute("teamPostList", teamPostList);
//		
//		return "teampage/list"; 
//	}
	
    // --팀페이지 전체 리스트 (특정 팀의 리스트)
    // URL을 /onespace/teams/{teamNo}/posts/list 와 같이 변경하는 것이 RESTful합니다.
    @RequestMapping(value="/teams/{teamNo}/posts/list", method= {RequestMethod.GET, RequestMethod.POST})
    public String list(@PathVariable("teamNo") int teamNo, Model model) {
        System.out.println("TeampageController.list() for teamNo: " + teamNo);
        
        // TODO: teampageService.exeList() 대신 teamNo에 해당하는 리스트만 가져오는 서비스 메서드를 호출해야 합니다.
        // 예: List<TeamPostVO> teamPostList = teampageService.exeListByTeam(teamNo);
        List<TeamPostVO> teamPostList = teampageService.exeListByTeam(teamNo);	//특정 팀의 게시글만 가져옴
        System.out.println(teamPostList);
        
        model.addAttribute("teamPostList", teamPostList);
        model.addAttribute("teamNo", teamNo); // 현재 보고 있는 팀의 teamNo를 JSP로 전달
        
        //model.addAttribute("teamName", "선택된 팀 이름(" + teamNo + ")"); // 임시로 하드코딩 + teamNo 추가
        // 실제로는 teampageService.exeGetTeamInfo(teamNo) 로 가져와야 함
        
        // TODO: 팀 이름도 model에 담아주면 좋을 것 같습니다.
        // 예: TeamVO currentTeam = teampageService.getTeamInfo(teamNo);
        // model.addAttribute("currentTeamName", currentTeam.getTeamName());

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
		
		model.addAttribute("authUser", authUser);
		model.addAttribute("teamPostType", teamPostType); // 글 종류 JSP 전달용
        model.addAttribute("teamNo", teamNo); // teamNo도 JSP로 전달 (hidden input에 사용)
        
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
		
//		return "redirect:/onespace/list";
		return "redirect:/onespace/teams/" + teamNo + "/posts/list"; // 예시 URL, 실제 리스트 URL에 맞춰야 함
	}
	
	
	
}
