package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.AttachService;
import com.javaex.service.HostService;
import com.javaex.service.RoomService;
import com.javaex.vo.FacilityInfoVO;
import com.javaex.vo.HostVO;
import com.javaex.vo.UserVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/host")
public class HostController {

	@Autowired
	private HostService hostService;
	@Autowired
	private AttachService attachService;
	@Autowired
	private RoomService roomService;

	/* --------------------- 세션 유틸 --------------------- */
	private Long get_login_userno(HttpSession session) {
		Object v = session.getAttribute("authUserNo");
		if (v instanceof Long)
			return (Long) v;
		if (v instanceof Integer)
			return ((Integer) v).longValue();
		return null;
	}

	/* 루트 → /spaces */
	@RequestMapping(value = { "", "/" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String index() {
		return "redirect:/host/spaces";
	}

	// 건물///////////////////////////////////////////////////////////////////////
	/* 신규 등록 폼 + 수정폼 */
	@GetMapping("/spaces/new")
	public String form_new(Model model, HttpSession session) {
		// 세션에서 회원번호 구하기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		// 세션값이 없으면(로그인 안하면)
		if (authUser == null) {
			// 로그인폼으로 리다이렉트
			return "redirect:/user/loginForm";

		} else {
			long userno = authUser.getUserNo();
			HostVO hostVO = hostService.getSpaceByUserNo(userno);

			if (hostVO == null) {
				System.out.println("등록폼으로 이동");
				// 시설안내 리스트
				List<FacilityInfoVO> facilityInfoList = hostService.getAllFacilities();
				model.addAttribute("facilityInfoList", facilityInfoList);
				return "admin/host/host_info";
			} else {
				System.out.println("수정폼으로 이동");
				model.addAttribute("space", hostVO);
				return "admin/host/host_edit";
			}
		}

	}
	
	//저장
    @PostMapping("/spaces/insert")
    public String insert(@ModelAttribute HostVO vo,
                         @RequestParam(value = "repImage", required = false) MultipartFile repImage,
                         @RequestParam(value = "facilityNos", required = false) List<Long> facilityNos, 
                         HttpSession session) {
    	
    	// 세션에서 회원번호 구하기
		UserVO authUser = (UserVO) session.getAttribute("authUser");
		// 세션값이 없으면(로그인 안하면)
		if (authUser == null) {
			// 로그인폼으로 리다이렉트
			return "redirect:/user/loginForm";

		} else {
			long userno = authUser.getUserNo();
			vo.setUserno(userno);
			
	        // ★★★★★ 2. 파일 처리 로직을 AttachService에 위임합니다.
	        if (repImage != null && !repImage.isEmpty()) {
	            // (1) 공용 AttachService를 호출하여 파일을 저장하고, 그 정보를 Map으로 받습니다.
	            Map<String, Object> fileInfo = attachService.saveFile(repImage);
	            
	            // (2) 파일 저장이 성공했다면, 저장된 파일명(saveName)을 HostVO의 repimg 필드에 세팅합니다.
	            if (fileInfo != null) {
	                vo.setRepimg((String) fileInfo.get("saveName"));
	            }
	        }
	      
	        hostService.createSpace(vo); // useGeneratedKeys -> vo.spacesno
			
	        // 저장 후 방 등록으로 이동
	        return "redirect:/host/spaces/new";
		}
    	
    }

}