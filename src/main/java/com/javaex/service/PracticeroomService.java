package com.javaex.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.javaex.repository.PracticeroomRepository;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SpacesVO;

@Service
public class PracticeroomService {
	
    private final PracticeroomRepository practiceroomRepository;
    
    public PracticeroomService(PracticeroomRepository practiceroomRepository) {
        this.practiceroomRepository = practiceroomRepository;
    }
    
    public List<SpacesVO> getList() {
        return practiceroomRepository.practiceroomSelectList();
    }
    
    public List<SpacesVO> getPagedList(int offset, int size) {
        return practiceroomRepository.practiceroomSelectPaged(offset, size);
    }
    
    public SpacesVO getZoneDetail(Long spacesNo) {
        return practiceroomRepository.selectZoneDetail(spacesNo);
    }
    
    public List<RoomsVO> getRoomsBySpace(Long spacesNo) {
        return practiceroomRepository.selectRoomsBySpace(spacesNo);
    }
    
    public List<SpacesVO> getFavoriteSpaces(Long userNo) {
        return practiceroomRepository.selectFavoriteSpaces(userNo);
    }
    
    public List<Map<String, Object>> getFavoriteCandidates(Long userNo) {
        return practiceroomRepository.selectFavoriteCandidates(userNo);
    }
    
    public List<Map<String, Object>> getRoomSlots(Long roomNo, LocalDate date) {
        String dayType = (date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY)
                ? "주말" : "평일";

        List<Map<String, Object>> rows = practiceroomRepository.selectRoomPricesByDayType(roomNo, dayType);

        // 00~24 슬롯 초기화
        List<Map<String, Object>> slots = new ArrayList<>();
        for (int h = 0; h < 24; h++) {
            Map<String, Object> slot = new HashMap<>();
            slot.put("start", h);
            slot.put("end", h + 1);
            slot.put("price", null);   // 가격 없으면 선택 불가 처리
            slots.add(slot);
        }

        // 요금 구간을 시간 단위로 확장
        for (Map<String, Object> r : rows) {
            LocalTime st = LocalTime.parse(r.get("startTime").toString()); // "10:00:00"
            LocalTime et = LocalTime.parse(r.get("endTime").toString());   // "22:00:00"
            int sh = st.getHour();
            int eh = et.getHour();
            int price = Integer.parseInt(String.valueOf(r.get("hourlyPrice")));

            for (int h = sh; h < eh && h < 24; h++) {
                slots.get(h).put("price", price);
            }
        }
        return slots;
    }
}
