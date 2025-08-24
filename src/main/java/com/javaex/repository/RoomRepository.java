package com.javaex.repository;

import java.util.List;

import com.javaex.vo.RoomsVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO.RoomAttachment;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoomRepository {

    private static final String NS = "room.";
    @Autowired private SqlSessionTemplate sqlsession;

    // rooms
    public List<RoomsVO> select_rooms_by_spacesno(Long spacesNo) {
        return sqlsession.selectList(NS + "select_rooms_by_spacesno", spacesNo);
    }
    public RoomsVO select_room_detail(Long roomNo) {
        return sqlsession.selectOne(NS + "select_room_detail", roomNo);
    }
    public int insert_room(RoomsVO vo) {
        return sqlsession.insert(NS + "insert_room", vo);
    }
    public int update_room(RoomsVO vo) {
        return sqlsession.update(NS + "update_room", vo);
    }
    public int delete_room(Long roomNo) {
        return sqlsession.delete(NS + "delete_room", roomNo);
    }

    // prices (RoomPriceVO)
    public int insert_price(RoomPriceVO vo) {
        return sqlsession.insert(NS + "insert_price", vo);
    }
    public int delete_prices_by_room(Long roomNo) {
        return sqlsession.delete(NS + "delete_prices_by_room", roomNo);
    }
    public List<RoomPriceVO> select_prices(Long roomNo) {
        return sqlsession.selectList(NS + "select_prices", roomNo);
    }

    // photos
    public int insert_photo(RoomsVO.RoomAttachment vo) {
        return sqlsession.insert(NS + "insert_photo", vo);
    }
    public List<RoomsVO.RoomAttachment> select_photos(Long roomNo) {
        return sqlsession.selectList(NS + "select_photos", roomNo);
    }
    public int delete_photos_by_room(Long roomNo) {
        return sqlsession.delete(NS + "delete_photos_by_room", roomNo);
    }
}
