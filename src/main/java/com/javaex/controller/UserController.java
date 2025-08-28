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
@RequestMapping(value="/onespace")
public class UserController {

    // 필드
    @Autowired
    private UserService userService;

    // --회원가입폼
    @RequestMapping(value = {"/signupForm"}, method = { RequestMethod.GET, RequestMethod.POST })
    public String joinForm() {
        System.out.println("UserController.joinForm()");
        return "admin/auth/signup";
    }

    // --회원가입
    @RequestMapping(value = "/signup", method = { RequestMethod.GET, RequestMethod.POST })
    public String join(@ModelAttribute UserVO userVO) {
        System.out.println("UserController.join()  param=" + userVO);

        try {
            userService.exeJoin(userVO);
            System.out.println("가입 성공");
            return "admin/auth/signup_complete";
        } catch (DuplicateKeyException e) {
            System.out.println("중복아이디: " + e.getMessage());
            return "redirect:/onespace/signupForm";
        } catch (Exception e) {
            System.out.println("회원가입 예외: " + e);
            return "admin/auth/signup";
        }
    }

    // --로그인폼
    @RequestMapping(value = {"/loginForm"}, method = { RequestMethod.GET, RequestMethod.POST })
    public String loginForm() {
        System.out.println("UserController.loginForm()");
        return "admin/auth/login";
    }

    // --로그인
    @RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(@ModelAttribute UserVO userVO, HttpSession session) {
        System.out.println("UserController.login");

        UserVO authUser = userService.exeLogin(userVO);
        System.out.println("authUser=" + authUser);

        if (authUser == null) {
            return "redirect:/onespace/loginForm?error=1";
        }

        session.setAttribute("authUser", authUser);
        session.setAttribute("authUserNo", authUser.getUserNo());
        session.setAttribute("authUserName", authUser.getUserName());

        return "redirect:/onespace/main";
    }

    // --로그아웃
    @RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
    public String logout(HttpSession session) {
        System.out.println("UserController.logout()");
        if (session != null) session.invalidate();
        return "redirect:/onespace/main";
    }

    /* ===================== 카카오 로그인 ===================== */

    /** 로그인 시작: 카카오 authorize로 리다이렉트 (서비스가 URL 생성) */
    @GetMapping("/auth/kakao/login")
    public String kakaoLoginStart() {
        String url = userService.kakaoBuildAuthorizeUrl(); // ★ 서비스에서만 redirect_uri 관리
        return "redirect:" + url;
    }

    /** 콜백: code만 받아 서비스에 위임 */
    @GetMapping("/auth/kakao/callback")
    public String kakaoCallback(@RequestParam(required = false) String code,
                                @RequestParam(required = false) String error,
                                HttpSession session,
                                Model model) {
        if (error != null || code == null) {
            return "redirect:/onespace/loginForm?error=oauth";
        }

        UserVO authUser = userService.exeLoginKakao(code);
        if (authUser == null) {
            return "redirect:/onespace/loginForm?error=oauth2";
        }

        session.setAttribute("authUser", authUser);
        session.setAttribute("authUserNo", authUser.getUserNo());
        session.setAttribute("authUserName", authUser.getUserName());
        session.setAttribute("authLoginType", "KAKAO");

        return "redirect:/onespace/main";
    }
}
