package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.PracticeroomService;
import com.javaex.service.TeampageService;
import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.SlotVO;
import com.javaex.vo.SpacesVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/practice")
public class PracticeroomController {

    @Autowired
    private PracticeroomService practiceroomService;

    @Autowired
    private TeampageService teampageService;

    // 메인
    @RequestMapping(value = "/practice1_main", method = { RequestMethod.GET, RequestMethod.POST })
    public String main(Model model) {
    	
    	System.out.println(practiceroomService.getPagedList(0, 8));
    	
        model.addAttribute("rooms", practiceroomService.getPagedList(0, 8));
        return "practiceroom/practice1_main";
    }

    // 무한 스크롤 API
    @GetMapping("/api/practicerooms")
    @ResponseBody
    public List<SpacesVO> listApi(@RequestParam(defaultValue = "0") int page,
                                  @RequestParam(defaultValue = "4") int size) {
        return practiceroomService.getPagedList(page * size, size);
    }

    // zone 상세
    @GetMapping("/practice2_zone")
    public String zone(@RequestParam("spacesNo") Long spacesNo, Model model) {
        model.addAttribute("zone", practiceroomService.getZoneDetail(spacesNo));
        model.addAttribute("rooms", practiceroomService.getRoomsBySpace(spacesNo));
        return "practiceroom/practice2_zone";
    }

    // room 상세
    @GetMapping("/practice3_room")
    public String room(@RequestParam("roomNo") Long roomNo, HttpSession session, Model model) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return "redirect:/onespace/loginForm";

        model.addAttribute("room", practiceroomService.getRoomByNo(roomNo));
        model.addAttribute("zone", practiceroomService.getZoneDetailByRoom(roomNo));
        model.addAttribute("teams", practiceroomService.getTeamsForUser(authUser.getUserNo()));
        return "practiceroom/practice3_room";
    }

    // 찜 리스트
    @GetMapping("/practice4_wish")
    public String favoritesList(Model model, HttpSession session) {
        UserVO authUser = (UserVO) session.getAttribute("authUser");
        if (authUser == null) return "redirect:/onespace/loginForm";

        int userNo = authUser.getUserNo();
        model.addAttribute("favoriteSpaces", practiceroomService.getFavoriteSpaces(userNo));
        model.addAttribute("favoriteCandidates", practiceroomService.getFavoriteCandidates(userNo));
        model.addAttribute("allTeams", teampageService.exeGetUserTeams(userNo));
        return "practiceroom/practice4_wish";
    }

    // 슬롯 조회
    @PostMapping("/api/room-slots")
    @ResponseBody
    public List<SlotVO> getRoomSlots(ReserveInfoVO reserveInfoVO) {
        return practiceroomService.getRoomSlots(reserveInfoVO);
    }

    // 찜 추가
    @PostMapping("/api/favorite")
    @ResponseBody
    public Map<String, Object> addFavorite(@RequestParam Long roomNo, 
                                           @RequestParam String teamName, 
                                           HttpSession session) {
        return practiceroomService.addFavorite(roomNo, teamName, session);
    }

    // 찜 삭제
    @PostMapping("/api/favorite/remove")
    @ResponseBody
    public Map<String, Object> removeFavorite(@RequestParam Long roomNo, HttpSession session) {
        return practiceroomService.removeFavorite(roomNo, session);
    }

    // 후보 추가
    @PostMapping("/api/vote-option")
    @ResponseBody
    public Map<String, Object> addVoteOption(@RequestParam Long roomNo,
                                             @RequestParam String voteDate,
                                             @RequestParam String voteTime,
                                             @RequestParam(required = false, defaultValue = "0") Integer voteNo,
                                             @RequestParam(required = false, defaultValue = "0") int voteStatus,
                                             HttpSession session) {
        return practiceroomService.addVoteOption(roomNo, voteDate, voteTime, voteNo, voteStatus, session);
    }
	
}
