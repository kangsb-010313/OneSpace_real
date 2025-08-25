package com.javaex.repository;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;

@Repository
public class RoomRepository {

    private final SqlSessionTemplate sql;
    public RoomRepository(SqlSessionTemplate sql) { this.sql = sql; }

    // 조회
    public RoomsVO select_room_with_prices(Long roomNo) {
        return sql.selectOne("room.select_room_with_prices", roomNo);
    }
    public List<RoomsVO.RoomAttachment> select_photos(Long roomNo) {
        return sql.selectList("room.select_photos", roomNo);
    }

    // 기본 저장/수정
    public int insert_room(RoomsVO vo) { return sql.insert("room.insert_room", vo); }
    public int update_room(RoomsVO vo) { return sql.update("room.update_room", vo); }

    // 가격 교체
    public int delete_prices_by_room(Long roomNo) { return sql.delete("room.delete_prices_by_room", roomNo); }
    public int insert_prices_batch(List<RoomPriceVO> list) { return sql.insert("room.insert_prices_batch", list); }

    // 사진 교체
    public int delete_photos_by_room(Long roomNo){ return sql.delete("room.delete_photos_by_room", roomNo); }
    public int insert_photo(RoomsVO.RoomAttachment a){ return sql.insert("room.insert_photo", a); }
}
