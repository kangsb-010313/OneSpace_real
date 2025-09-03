package com.javaex.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.repository.RoomRepository;
import com.javaex.vo.RoomAttachmentVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomVO;

@Service
public class RoomService {

	@Autowired
	private RoomRepository roomRepository;
	
	@Autowired
	private AttachService attachService;

	// 연습실(방) 전체 리스트
	public List<RoomVO> exeSelectRoomList(long userNo) {
		System.out.println("RoomService.selectRoomList()");

		List<RoomVO> roomList = roomRepository.selectRoomList(userNo);

		return roomList;
	}
	
	
   //UserNo 로 SpaceNo 조회
   public Long exeSelectSpacesNoByUserNo(long userNo){
      System.out.println("RoomService.selectSpacesNoByUserNo()");
      
      Long spacesNo = roomRepository.selectSpacesNoByUserNo(userNo);
      
      return spacesNo;
   }
	   

   //연습실 등록
   @Transactional
   public Long exeRoomAdd(RoomVO roomVO){
      System.out.println("RoomService.exeRoomAdd()");
      
      long count = 0;
      System.out.println("==연습실 등록전VO================================");
      System.out.println(roomVO);
      System.out.println("-----------------------------------------------");
      //방기본정보 저장
      roomRepository.insertRoom(roomVO);
      System.out.println("==연습실 등록후VO================================");
      System.out.println(roomVO);
      System.out.println("-----------------------------------------------");
      
     
      //roomPrices저장
      for(int i=0; i<roomVO.getHourlyPrices().size(); i++) {
    	  
    	  //이용요금VO 만들기
    	  RoomPriceVO roomPriceVO = new RoomPriceVO();
    	  roomPriceVO.setRoomNo(roomVO.getRoomNo());
    	  roomPriceVO.setDayType(roomVO.getDayTypes().get(i));
    	  roomPriceVO.setStartTime(roomVO.getStartTimes().get(i));
    	  roomPriceVO.setEndTime(roomVO.getEndTimes().get(i));;
    	  roomPriceVO.setHourlyPrice(roomVO.getHourlyPrices().get(i));

    	  System.out.println("==이용요금VO================================");
    	  System.out.println(roomPriceVO);
    	  System.out.println("-----------------------------------------------");
    	      
    	  
    	  //이용요금저장하기
    	  count = roomRepository.insertRoomPrices(roomPriceVO);
      }
            
 
      // 대표이미지 업데이트
      MultipartFile thumbFile = roomVO.getThumbFile();
      Map<String, Object> thumbFileInfo = attachService.saveFile(thumbFile);
      roomVO.setThumbImg((String)thumbFileInfo.get("saveName"));
	  
      System.out.println("==연습실 대표이미지 파일명 있는지================================");
	  System.out.println(roomVO);
	  System.out.println("-----------------------------------------------");
      
      count = roomRepository.updateThumbImg(roomVO);
      
      
      // 나머지이미지 저장
      for(int i=0; i<roomVO.getPhotos().size(); i++) {
    	  Map<String, Object> photoInfo = attachService.saveFile(roomVO.getPhotos().get(i));
    	  RoomAttachmentVO roomAttachmentVO = new RoomAttachmentVO();
    	  roomAttachmentVO.setRoomNo(roomVO.getRoomNo());
    	  roomAttachmentVO.setRefType("ROOM");
    	  roomAttachmentVO.setStoredFileName((String)photoInfo.get("saveName"));
    	  roomAttachmentVO.setOriginFileName((String)photoInfo.get("orgName"));
    	  roomAttachmentVO.setFilePath((String)photoInfo.get("filePath"));
    	  
          System.out.println("==나머지 이미지VO================================");
    	  System.out.println(roomAttachmentVO);
    	  System.out.println("-----------------------------------------------");
      
    	  count = roomRepository.insertRoomPhoto(roomAttachmentVO);
      }
      
      return count;
   }
	   
	
	
	

	/*
	 * public RoomService(RoomRepository repo, AttachService attachService) {
	 * this.repo = repo; this.attachService = attachService; }
	 * 
	 * @Transactional public void saveRoomAndDetails(RoomsVO vo, List<RoomPriceVO>
	 * prices, MultipartFile[] photos) {
	 * System.out.println("RoomService.saveRoomAndDetails() - 모든 정보 저장 시작");
	 * 
	 * // 2. Room 기본 정보 먼저 저장/수정하여 roomNo를 확보합니다. // (썸네일은 아직 비어있습니다.)
	 * create_or_update_room(vo); Long roomNo = vo.getRoomNo();
	 * 
	 * // 3. 가격 정보들을 DB에서 모두 지우고 새로 저장합니다 ( 완전 교체 방식) replace_prices(roomNo,
	 * prices);
	 * 
	 * // 4. 사진 정보들을 처리합니다. // (1) 기존 사진들을 DB에서 모두 삭제합니다.
	 * repo.delete_photos_by_room(roomNo);
	 * 
	 * // (2) 첫 번째로 저장되는 파일을 썸네일로 지정하기 위한 플래그 boolean isFirstFile = true;
	 * 
	 * if (photos != null) { for (MultipartFile file : photos) { // (3) 파일이 비어있지 않은
	 * 경우에만 저장 로직을 실행합니다. if (file != null && !file.isEmpty()) { // (4)
	 * AttachService를 호출하여 파일을 실제 폴더에 저장하고, 그 결과(정보)를 Map으로 받습니다. Map<String,
	 * Object> fileInfo = attachService.saveFile(file);
	 * 
	 * if (fileInfo != null) { // (5) DB에 저장할 RoomAttachment 객체를 만들고 정보를 채웁니다.
	 * RoomAttachment attachment = new RoomsVO.RoomAttachment();
	 * attachment.setRefType("ROOM"); // 이 파일이 '연습실'에 속한 파일임을 명시
	 * attachment.setRefNo(roomNo); // FK (방금 생성/수정한 연습실 번호)
	 * attachment.setStoredFileName((String) fileInfo.get("saveName"));
	 * attachment.setOriginFileName((String) fileInfo.get("orgName"));
	 * attachment.setFilePath((String) fileInfo.get("filePath"));
	 * 
	 * // (6) Repository를 통해 roomAttachments 테이블에 파일 정보를 저장합니다.
	 * repo.insert_photo(attachment);
	 * 
	 * // (7) 만약 이 파일이 성공적으로 저장된 '첫 번째' 파일이라면, if (isFirstFile) { // rooms 테이블의
	 * thumbImg 컬럼을 이 파일의 저장된 이름으로 업데이트합니다. vo.setThumbImg((String)
	 * fileInfo.get("saveName")); repo.update_room(vo); // update_room 메소드는 썸네일도 함께
	 * 업데이트합니다. isFirstFile = false; // 플래그를 false로 바꿔, 다음 파일부터는 썸네일로 지정되지 않도록 합니다.
	 * } } } } } }
	 * 
	 * @Transactional(readOnly = true) public RoomsVO get_detail(Long roomNo) {
	 * RoomsVO vo = repo.select_room_with_prices(roomNo); // JOIN 한 번 if (vo ==
	 * null) return null; //vo.setPhotos(repo.select_photos(roomNo)); // 사진은 분리 조회
	 * return vo; }
	 * 
	 * @Transactional public Long create_or_update_room(RoomsVO vo) { if
	 * (vo.getRoomNo() == null) repo.insert_room(vo); else repo.update_room(vo);
	 * return vo.getRoomNo(); }
	 * 
	 * @Transactional public void replace_prices(Long roomNo, List<RoomPriceVO>
	 * prices) { repo.delete_prices_by_room(roomNo); if (prices != null &&
	 * !prices.isEmpty()) { for (RoomPriceVO p : prices) p.setRoomNo(roomNo);
	 * repo.insert_prices_batch(prices); } }
	 */

}