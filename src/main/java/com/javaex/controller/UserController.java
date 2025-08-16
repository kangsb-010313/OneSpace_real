package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        return "admin/auth/signup"; // 뷰 경로: 프로젝트에 맞게 유지
    }

    // --회원가입 (GET/POST 허용: 수업 스타일 유지)
    @RequestMapping(value = "/signup", method = { RequestMethod.GET, RequestMethod.POST })
    public String join(@ModelAttribute UserVO userVO) {
        System.out.println("UserController.join()  param=" + userVO);

        try {
            userService.exeJoin(userVO);
            // 가입 성공 페이지
            return "onespace/signupCompleted"; 

        } catch (DuplicateKeyException e) {
            System.out.println("중복아이디: " + e.getMessage());
            return "redirect:/onespace/signup?error=dup"; // 폼으로 리다이렉트 + 에러표시

        } catch (Exception e) {
            System.out.println("회원가입 예외: " + e);
            return "redirect:/onespace/signup?error=fail";
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

        // 기대 필드: userId, password
        UserVO authUser = userService.exeLogin(userVO);
        System.out.println("authUser=" + authUser);

        if (authUser == null) {
            // 아이디/비번 불일치 → 폼으로
        	return "redirect:/onespace/loginForm?error=1";
        }

        // 세션 로그인
        session.setAttribute("authUser", authUser);

        // 로그인 성공 후 이동 (원하면 /onespace/home 등으로 변경)
        return "redirect:/onespace/main";
    }

 
}
