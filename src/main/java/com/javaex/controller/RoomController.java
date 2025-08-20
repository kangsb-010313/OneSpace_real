package com.javaex.controller;

import java.util.ArrayList;
import java.util.List;

import com.javaex.service.RoomService;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.RoomsVO.RoomPrices;
import com.javaex.vo.RoomsVO.RoomAttachment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/onespace/hostcenter/rooms")
public class RoomController {

    @Autowired private RoomService roomService;

   

    // 연습실 저장
    @PostMapping("/save")
    public String save(@ModelAttribute RoomsVO vo,
                       @RequestParam(value="dayType", required=false) List<String> dayType,
                       @RequestParam(value="startTime", required=false) List<String> startTime,
                       @RequestParam(value="endTime", required=false) List<String> endTime,
                       @RequestParam(value="hourlyPrice", required=false) List<String> hourlyPrice,
                       @RequestParam(value="files", required=false) MultipartFile[] files) {

        List<RoomPrices> prices = build_prices(dayType, startTime, endTime, hourlyPrice);

        // TODO: files 처리해서 photos 구성 (예: 업로드 후 저장 경로/파일명 세팅)
        List<RoomAttachment> photos = null;

        Long roomNo = roomService.create_room_with_prices_photos(vo, prices, photos);
        return "redirect:/onespace/hostcenter/rooms/" + roomNo;
    }

    // 상세 보기
    @GetMapping("/{roomNo}")
    public String view(@PathVariable Long roomNo, Model model) {
        RoomsVO room = roomService.get_detail(roomNo);
        model.addAttribute("room", room);
        return "forward:/WEB-INF/views/admin/host/host_manage_added.jsp";
    }

    // 수정 폼
    @GetMapping("/{roomNo}/edit")
    public String form_edit(@PathVariable Long roomNo, Model model) {
        RoomsVO room = roomService.get_detail(roomNo);
        model.addAttribute("room", room);
        model.addAttribute("spacesNo", room != null ? room.getSpacesNo() : null);
        return "forward:/WEB-INF/views/admin/host/host_info2.jsp";
    }

    // 수정 저장
    @PostMapping("/{roomNo}/update")
    public String update(@PathVariable Long roomNo,
                         @ModelAttribute RoomsVO vo,
                         @RequestParam(value="dayType", required=false) List<String> dayType,
                         @RequestParam(value="startTime", required=false) List<String> startTime,
                         @RequestParam(value="endTime", required=false) List<String> endTime,
                         @RequestParam(value="hourlyPrice", required=false) List<String> hourlyPrice) {

        vo.setRoomNo(roomNo);
        roomService.update_room_with_prices(vo, build_prices(dayType, startTime, endTime, hourlyPrice));
        return "redirect:/onespace/hostcenter/rooms/" + roomNo;
    }

    // 삭제
    @PostMapping("/{roomNo}/delete")
    public String delete(@PathVariable Long roomNo,
                         @RequestParam("spacesNo") Long spacesNo) {
        roomService.delete_room_cascade(roomNo);
        return "redirect:/onespace/hostcenter/rooms/new?spacesNo=" + spacesNo;
    }

    // 유틸: 배열 -> 리스트
    private List<RoomPrices> build_prices(List<String> dayType,
                                          List<String> startTime,
                                          List<String> endTime,
                                          List<String> hourlyPrice) {
        List<RoomPrices> prices = new ArrayList<>();
        if (dayType == null || startTime == null || endTime == null || hourlyPrice == null) return prices;

        int n = Math.min(Math.min(dayType.size(), startTime.size()),
                         Math.min(endTime.size(), hourlyPrice.size()));

        for (int i = 0; i < n; i++) {
            RoomPrices p = new RoomPrices();
            p.setDayType(dayType.get(i));
            p.setStartTime(startTime.get(i));
            p.setEndTime(endTime.get(i));
            p.setHourlyPrice(hourlyPrice.get(i));
            prices.add(p);
        }
        return prices;
    }
}
