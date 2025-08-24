package com.javaex.service;

import java.util.List;

import com.javaex.repository.RoomRepository;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO.RoomAttachment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RoomService {

    @Autowired private RoomRepository roomRepository;

    public List<RoomsVO> list_by_spaces(Long spacesNo) {
        return roomRepository.select_rooms_by_spacesno(spacesNo);
    }

    public RoomsVO get_detail(Long roomNo) {
        RoomsVO vo = roomRepository.select_room_detail(roomNo);
        if (vo != null) {
            vo.setPhotos(roomRepository.select_photos(roomNo));
            vo.setPrices(roomRepository.select_prices(roomNo)); // List<RoomPriceVO>
        }
        return vo;
    }

    @Transactional
    public Long create_room_with_prices_photos(RoomsVO vo,
                                               List<RoomPriceVO> prices,
                                               List<RoomAttachment> photos) {

        roomRepository.insert_room(vo); // generated key -> vo.roomNo
        Long roomNo = vo.getRoomNo();

        if (prices != null) {
            for (RoomPriceVO p : prices) {
                p.setRoomNo(roomNo.intValue()); // RoomPriceVO.roomNo는 int
                roomRepository.insert_price(p);
            }
        }
        if (photos != null) {
            for (RoomAttachment a : photos) {
                a.setRoomNo(roomNo);
                roomRepository.insert_photo(a);
            }
        }
        return roomNo;
    }

    @Transactional
    public void update_room_with_prices(RoomsVO vo, List<RoomPriceVO> prices) {
        roomRepository.update_room(vo);
        roomRepository.delete_prices_by_room(vo.getRoomNo());
        if (prices != null) {
            for (RoomPriceVO p : prices) {
                p.setRoomNo(vo.getRoomNo().intValue());
                roomRepository.insert_price(p);
            }
        }
    }

    @Transactional
    public void delete_room_cascade(Long roomNo) {
        roomRepository.delete_prices_by_room(roomNo);
        roomRepository.delete_photos_by_room(roomNo);
        roomRepository.delete_room(roomNo);
    }
}
