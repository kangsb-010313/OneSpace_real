package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.RoomAttachmentVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomVO;

@Repository
public class RoomRepository {

	@Autowired
	private SqlSession sqlSession;

	// 연습실(방) 전체 리스트
	public List<RoomVO> selectRoomList(long userNo) {
		System.out.println("RoomRepository.selectRoomList()");
		List<RoomVO> roomList = sqlSession.selectList("room.selectRoomList", userNo);

		return roomList;
	}

	// UserNo 로 SpaceNo 조회
	public Long selectSpacesNoByUserNo(long userNo) {
		System.out.println("RoomRepository.selectSpacesNoByUserNo()");
		Long spacesNo = sqlSession.selectOne("room.selectSpacesNoByUserNo", userNo);

		return spacesNo;
	}
	
	
	//연습실 등록
	public int insertRoom(RoomVO roomVO){
		System.out.println("RoomService.insertRoom()");
      
		int count = sqlSession.insert("room.insertRoom", roomVO);
		return count;
	}
	
	
	//이용요금 등록
	public int insertRoomPrices(RoomPriceVO roomPriceVO){
		System.out.println("RoomService.insertRoomPrices()");
      
		int count = sqlSession.insert("room.insertRoomPrices", roomPriceVO);
		return count;
	}
	
	//연습실에 대표 이미지경로 업데이트
	public int updateThumbImg(RoomVO roomVO){
		System.out.println("RoomService.updateThumbImg()");
      
		int count = sqlSession.insert("room.updateThumbImg", roomVO);
		return count;
	}
	
	//연습실 사진 등록
	public int insertRoomPhoto(RoomAttachmentVO roomAttachmentVO){
		System.out.println("RoomService.insertRoomPhoto()");
      
		int count = sqlSession.insert("room.insertRoomPhoto", roomAttachmentVO);
		return count;
	}
	
	
	/*
	 * // 조회 public RoomsVO select_room_with_prices(Long roomNo) { return
	 * sql.selectOne("room.select_room_with_prices", roomNo); } public
	 * List<RoomsVO.RoomAttachment> select_photos(Long roomNo) { return
	 * sql.selectList("room.select_photos", roomNo); }
	 * 
	 * // 기본 저장/수정 public int insert_room(RoomsVO vo) { return
	 * sql.insert("room.insert_room", vo); } public int update_room(RoomsVO vo) {
	 * return sql.update("room.update_room", vo); }
	 * 
	 * // 가격 교체 public int delete_prices_by_room(Long roomNo) { return
	 * sql.delete("room.delete_prices_by_room", roomNo); } public int
	 * insert_prices_batch(List<RoomPriceVO> list) { return
	 * sql.insert("room.insert_prices_batch", list); }
	 * 
	 * // 사진 교체 public int delete_photos_by_room(Long roomNo){ return
	 * sql.delete("room.delete_photos_by_room", roomNo); } public int
	 * insert_photo(RoomsVO.RoomAttachment a){ return
	 * sql.insert("room.insert_photo", a); }
	 * 
	 */
}