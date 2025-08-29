package com.javaex.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javaex.service.RoomService;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;

@Controller
@RequestMapping("/onespace/hostcenter/rooms")
public class RoomController {
	
    private final RoomService roomService;

    public RoomController(RoomService roomService) {
        this.roomService = roomService;
    }

    /* ========== 폼/뷰 ========== */

    /** 신규 등록 폼 */
    @GetMapping("/new")
    public String formNew(@RequestParam("spacesNo") Long spacesNo, Model model) {
        model.addAttribute("spacesNo", spacesNo);
        return "admin/host/host_info2"; // 화면 경로에 맞게 수정
    }

    /** 상세 보기 (필요할 때만 사용) */
    @GetMapping("/{roomNo}")
    public String view(@PathVariable Long roomNo, Model model) {
        RoomsVO vo = roomService.get_detail(roomNo); // JOIN 한 번 + 사진 별도
        model.addAttribute("vo", vo);
        return "admin/host/host_manage_added"; // 화면 경로에 맞게 수정
    }

    /* ========== 저장/수정 ========== */

    /**
     * 저장(신규/수정 공용): 기본정보 → 가격 완전교체 → 사진 완전교체
     *
     * 프런트에서 아래 배열 파라미터가 들어온다고 가정
     * - dayType[], startTime[], endTime[], hourlyPrice[]
     * - photoName[](storedFileName), originName[], photoPath[], contentType[], fileSize[]
     */
    @PostMapping("/save")
    public String save(@ModelAttribute RoomsVO vo,
                       @RequestParam(value = "dayType",     required = false) List<String>  dayType,
                       @RequestParam(value = "startTime",   required = false) List<String>  startTime,
                       @RequestParam(value = "endTime",     required = false) List<String>  endTime,
                       @RequestParam(value = "hourlyPrice", required = false) List<String>  hourlyPrice,

                       @RequestParam(value = "photos", required = false) MultipartFile[] photos,
                       
                       RedirectAttributes ra) {
				        // ★★★★★ 디버깅 코드 추가 ★★★★★
				        System.out.println("========================================");
				        System.out.println("[RoomController] /save 요청 진입");
				        if (photos != null && photos.length > 0) {
				            System.out.println("전달된 파일 개수: " + photos.length);
				            for(MultipartFile mf : photos) {
				                System.out.println(" - 원본 파일명: " + mf.getOriginalFilename());
				                System.out.println(" - 파일 크기: " + mf.getSize());
				            }
				        } else {
				            System.out.println("전달된 파일이 없습니다.");
				        }
				        System.out.println("========================================");
        
        
        
        

        // ★★★★★ 1. 빠져있던 prices 리스트 생성 로직을 여기에 다시 추가합니다. ★★★★★
        List<RoomPriceVO> prices = new ArrayList<>();
        if (dayType != null) {
            for (int i = 0; i < dayType.size(); i++) {
                RoomPriceVO p = new RoomPriceVO();
                p.setDayType(safeGet(dayType, i));
                p.setStartTime(safeGet(startTime, i));
                p.setEndTime(safeGet(endTime, i));
                
                String priceStr = safeGet(hourlyPrice, i);
                if (priceStr != null && !priceStr.isBlank()) {
                    try {
                        p.setHourlyPrice(Integer.valueOf(priceStr.trim()));
                    } catch (NumberFormatException e) {
                        p.setHourlyPrice(null); // 숫자가 아니면 null
                    }
                }
                prices.add(p);
            }
        }
        
        // ★★★★★ 2. 이제 정상적으로 `prices` 변수를 사용할 수 있습니다.
        roomService.saveRoomAndDetails(vo, prices, photos);

        ra.addFlashAttribute("msg", "연습실이 성공적으로 등록/수정되었습니다.");
        return "redirect:/onespace/hostcenter/spaces";
    }
    
    // ★★★★★ 3. prices 리스트를 만들기 위해 필요한 유틸리티 메소드를 다시 추가합니다.
    private static String safeGet(List<String> list, int idx) {
        return (list != null && list.size() > idx) ? list.get(idx) : null;
    }


}
 