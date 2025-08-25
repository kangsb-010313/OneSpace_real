package com.javaex.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.javaex.repository.RoomRepository;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;

@Service
public class RoomService {

    private final RoomRepository repo;
    public RoomService(RoomRepository repo) { this.repo = repo; }

    @Transactional(readOnly = true)
    public RoomsVO get_detail(Long roomNo) {
        RoomsVO vo = repo.select_room_with_prices(roomNo); // JOIN 한 번
        if (vo == null) return null;
        vo.setPhotos(repo.select_photos(roomNo));          // 사진은 분리 조회
        return vo;
    }

    @Transactional
    public Long create_or_update_room(RoomsVO vo) {
        if (vo.getRoomNo() == null) repo.insert_room(vo);
        else repo.update_room(vo);
        return vo.getRoomNo();
    }

    @Transactional
    public void replace_prices(Long roomNo, List<RoomPriceVO> prices) {
        repo.delete_prices_by_room(roomNo);
        if (prices != null && !prices.isEmpty()) {
            for (RoomPriceVO p : prices) p.setRoomNo(roomNo);
            repo.insert_prices_batch(prices);
        }
    }

    @Transactional
    public void replace_photos(Long roomNo, List<RoomsVO.RoomAttachment> photos) {
        repo.delete_photos_by_room(roomNo);
        if (photos != null) {
            for (RoomsVO.RoomAttachment a : photos) {
                a.setRefType("ROOM");
                a.setRefNo(roomNo);
                repo.insert_photo(a);
            }
        }
    }
}
