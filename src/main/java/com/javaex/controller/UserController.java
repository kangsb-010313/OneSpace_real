package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.javaex.service.UserService;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
    @Autowired
    private UserService userService;

    /* ===================== 회원가입 ===================== */

    /** 회원가입 폼 이동 */
    @RequestMapping(value = {"/signupForm"}, method = { RequestMethod.GET, RequestMethod.POST })
    public String joinForm() {
        System.out.println("UserController.joinForm()");
        return "admin/auth/signup"; // JSP: /WEB-INF/views/admin/auth/signup.jsp
    }

    /** 회원가입 처리 */
    @RequestMapping(value = "/signup", method = { RequestMethod.GET, RequestMethod.POST })
    public String join(@ModelAttribute UserVO userVO) {
        System.out.println("UserController.join()  param=" + userVO);

        try {
            userService.exeJoin(userVO); // DB insert
            System.out.println("가입 성공");
            return "admin/auth/signup_complete"; // 가입 완료 페이지
        } catch (DuplicateKeyException e) {
            // 아이디 중복 예외
            System.out.println("중복아이디: " + e.getMessage());
            return "redirect:/user/signupForm";
        } catch (Exception e) {
            // 기타 예외
            System.out.println("회원가입 예외: " + e);
            return "admin/auth/signup";
        }
    }

    /* ===================== 일반 로그인 ===================== */

    /** 로그인 폼 이동 */
    @RequestMapping(value = {"/loginForm"}, method = { RequestMethod.GET, RequestMethod.POST })
    public String loginForm() {
        System.out.println("UserController.loginForm()");
        return "admin/auth/login"; // JSP: /WEB-INF/views/admin/auth/login.jsp
    }

    /** 로그인 처리 */
    @RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(@ModelAttribute UserVO userVO, HttpSession session) {
        System.out.println("UserController.login");

        // 1) 서비스에서 아이디/비번으로 조회
        UserVO authUser = userService.exeLogin(userVO);
        System.out.println("authUser=" + authUser);

        // 2) 로그인 실패
        if (authUser == null) {
            return "redirect:/user/loginForm?error=1";
        }

        // 3) 로그인 성공 → 세션 저장
        session.setAttribute("authUser", authUser);              	 	// 전체 객체
        session.setAttribute("authUserNo", authUser.getUserNo()); 		// pk
        session.setAttribute("authUserName", authUser.getUserName()); 	// 이름

        return "redirect:/onespace/main"; // 메인으로 리다이렉트
    }

    /* ===================== 로그아웃 ===================== */

    /** 로그아웃 처리 */
    @RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session) {
        System.out.println("UserController.logout()");
        if (session != null) session.invalidate(); // 세션 전체 초기화
        return "redirect:/onespace/main";
    }

    /* ===================== 카카오 로그인 ===================== */

    /** 
     * 	1) 로그인 시작
     *  - 카카오 로그인 버튼 누르면 여기로 진입
     *  - 서비스에서 "authorize URL" 생성 후 redirect
     */
    @GetMapping("/auth/kakao/login")
    public String kakaoLoginStart() {
        String url = userService.kakaoBuildAuthorizeUrl(); // client_id, redirect_uri 포함
        return "redirect:" + url; // 카카오 인증창으로 이동
    }

    /**
     * 	2) 카카오 콜백
     *  - 사용자가 카카오 인증을 완료하면 카카오가 code를 붙여 여기로 호출
     *  - code → accessToken → 사용자 정보 조회 → DB 저장(upsert)
     *  - 로그인 세션 세팅 후 메인으로 리다이렉트
     */
    @GetMapping("/auth/kakao/callback")
    public String kakaoCallback(@RequestParam(required = false) String code,
                                @RequestParam(required = false) String error,
                                HttpSession session,
                                Model model) {
        // 1) 인증 실패
        if (error != null || code == null) {
            return "redirect:/user/loginForm?error=oauth";
        }
 
        // 2) 서비스 위임 → 토큰/유저정보 조회 & DB 처리
        UserVO authUser = userService.exeLoginKakao(code);

        // 3) 로그인 실패
        if (authUser == null) {
            return "redirect:/user/loginForm?error=oauth2";
        }

        // 4) 로그인 성공 → 세션에 저장
        session.setAttribute("authUser", authUser);
        session.setAttribute("authUserNo", authUser.getUserNo());
        session.setAttribute("authUserName", authUser.getUserName());
        session.setAttribute("authLoginType", "KAKAO"); // 구분값

        return "redirect:/onespace/main";
    }
}