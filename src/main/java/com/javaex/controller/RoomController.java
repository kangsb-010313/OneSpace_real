package com.javaex.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javaex.service.RoomService;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.RoomsVO.RoomAttachment;

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

                       @RequestParam(value = "photoName",   required = false) List<String>  storedFileName,
                       @RequestParam(value = "originName",  required = false) List<String>  originFileName,
                       @RequestParam(value = "photoPath",   required = false) List<String>  filePath,
                       @RequestParam(value = "contentType", required = false) List<String>  contentType,
                       @RequestParam(value = "fileSize",    required = false) List<Long>    fileSize,
                       RedirectAttributes ra) {

        // 0) 썸네일 기본값: 폼에서 thumbImg가 비어 있으면 첫 번째 사진으로
        if ((vo.getThumbImg() == null || vo.getThumbImg().isBlank())
                && storedFileName != null && !storedFileName.isEmpty()) {
            vo.setThumbImg(storedFileName.get(0));
        }

        // 1) room 기본 저장/수정 (useGeneratedKeys 로 roomNo 세팅됨)
        Long roomNo = roomService.create_or_update_room(vo);

        // 2) 가격 리스트 빌드 후 완전교체
        List<RoomPriceVO> prices = new ArrayList<>();
        if (dayType != null) {
            int n = dayType.size();
            for (int i = 0; i < n; i++) {
                RoomPriceVO p = new RoomPriceVO();
                p.setDayType(dayType.get(i));
                p.setStartTime(safeGet(startTime, i));
                p.setEndTime(safeGet(endTime, i));

                // String → Integer 변환
                String priceStr = safeGet(hourlyPrice, i);
                if (priceStr != null && !priceStr.isBlank()) {
                    try {
                        p.setHourlyPrice(Integer.valueOf(priceStr.trim()));
                    } catch (NumberFormatException e) {
                        p.setHourlyPrice(null);
                    }
                } else {
                    p.setHourlyPrice(null);
                }

                prices.add(p);
            }
        }
        roomService.replace_prices(roomNo, prices);

        // 3) 사진 리스트 빌드 후 완전교체 (업로드는 다른 곳에서 이미 처리)
        List<RoomAttachment> photos = new ArrayList<>();
        if (storedFileName != null) {
            int n = storedFileName.size();
            for (int i = 0; i < n; i++) {
                RoomAttachment a = new RoomAttachment();
                a.setStoredFileName(storedFileName.get(i));
                a.setOriginFileName(safeGet(originFileName, i, storedFileName.get(i)));
                a.setFilePath(safeGet(filePath, i, "/uploads/rooms/" + roomNo + "/"));
                a.setContentType(safeGet(contentType, i, "image/jpeg"));
                a.setFileSize(safeGet(fileSize, i, 0L));
                photos.add(a);
            }
        }
        roomService.replace_photos(roomNo, photos);

        // 4) 저장 완료 → 목록(내 공간 관리)로 깔끔하게! (roomNo 절대 붙이지 않기)
        ra.addFlashAttribute("msg", "연습실이 등록/수정되었습니다.");
        return "redirect:/onespace/hostcenter/spaces";
        // 혹시 특정 공간 대시보드로 가고 싶으면:
        // return "redirect:/onespace/hostcenter/spaces/" + vo.getSpacesNo();
    }

    /* ========== 유틸 ========== */

    private static String safeGet(List<String> list, int idx) {
        return (list != null && list.size() > idx) ? list.get(idx) : null;
    }

    private static String safeGet(List<String> list, int idx, String def) {
        return (list != null && list.size() > idx && list.get(idx) != null) ? list.get(idx) : def;
    }

    private static Long safeGet(List<Long> list, int idx, Long def) {
        return (list != null && list.size() > idx && list.get(idx) != null) ? list.get(idx) : def;
    }
}
