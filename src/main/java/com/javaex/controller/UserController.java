package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.UserService;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/onespace")
public class UserController {

    // 필드
    @Autowired
    private UserService userService;

    // --회원가입 폼 (GET)
    @GetMapping("/signupForm")
    public String joinform() {
        System.out.println("usercontroller.joinform()");
        return "admin/auth/signup";
    }

    // --회원가입 (POST) : html name에 맞춰 받기
    @PostMapping("/signup")
    public String join(
            @RequestParam("name") String name,
            @RequestParam("id") String id,
            @RequestParam("email") String email,
            @RequestParam("pw") String pw,
            @RequestParam(value = "pw_confirm", required = false) String pwConfirm
    ) {
        System.out.println("usercontroller.join()");

        // 비밀번호 확인 체크 (옵션)
        if (pwConfirm != null && !pw.equals(pwConfirm)) {
            // 메시지는 쿼리스트링으로 전달하거나, 모델에 담아도 됨
            return "redirect:/onespace/signupForm?error=pw_mismatch";
        }

        UserVO uservo = new UserVO();
        uservo.setUserName(name);     // html name  -> vo userName
        uservo.setUserId(id);         // html id    -> vo userId
        uservo.setEmail(email);       // html email -> vo email
        uservo.setPassword(pw);       // html pw    -> vo password

        userService.exeJoin(uservo);
        return "onespace/joinCompleted";
    }

    // --로그인 폼 (GET)
    @GetMapping("/loginForm")
    public String loginform() {
        System.out.println("usercontroller.loginform()");
        return "admin/auth/login";
    }

    // --로그인 (POST) : html name에 맞춰 받기
    @PostMapping("/login")
    public String login(
            @RequestParam("id") String id,
            @RequestParam("pw") String pw,
            HttpSession session
    ) {
        System.out.println("usercontroller.login()");

        UserVO param = new UserVO();
        param.setUserId(id);       // html id -> vo userId
        param.setPassword(pw);     // html pw -> vo password

        UserVO authUser = userService.exeLogin(param);
        System.out.println(authUser);
        
//        if (authUser == null) {
//            // 아이디/비번 불일치
//            return "redirect:/onespace/loginForm?error=1";
//        }

        session.setAttribute("authUser", authUser);
        return "";
    }

    // (선택) 주소창으로 /signup, /login GET 들어올 때 폼으로 돌리기
    @GetMapping("/signup")
    public String signup_get_redirect() {
        return "redirect:/onespace/signupForm";
    }

    @GetMapping("/login")
    public String login_get_redirect() {
        return "redirect:/onespace/loginForm";
    }
}
