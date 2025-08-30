package com.javaex.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.ReserveInfoVO;
import com.javaex.vo.RoomPriceVO;
import com.javaex.vo.RoomsVO;
import com.javaex.vo.SpacesVO;
import com.javaex.vo.TeamVO;


@Repository
public class PracticeroomRepository {
	
	// 필드
	@Autowired
	private SqlSession sqlSession;
	
	// SqlSession을 주입받는 생성자
	public PracticeroomRepository(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
	
	// 메소드일반
	// 전체리스트 가져오기
	public List<SpacesVO> practiceroomSelectList() {
		System.out.println("PracticeroomRepository.practiceroomSelectList()");
		
		List<SpacesVO> practiceroomSelectList = sqlSession.selectList("practiceroom.selectList");
		
		return practiceroomSelectList;
	}
	
	// 페이징된 연습실 공간 목록 조회
	public List<SpacesVO> practiceroomSelectPaged(int offset, int size) {
        Map<String, Object> p = new HashMap<>();
        p.put("offset", offset);
        p.put("size", size);
        return sqlSession.selectList("practiceroom.selectPaged", p);
    }
	
	// 공간의 상세 정보 조회
    public SpacesVO selectZoneDetail(Long spacesNo) {
        return sqlSession.selectOne("practiceroom.selectZoneDetail", spacesNo);
    }
    
    // 공간에 속한 방 목록 조회
    public List<RoomsVO> selectRoomsBySpace(Long spacesNo) {
        return sqlSession.selectList("practiceroom.selectRoomsBySpace", spacesNo);
    }
    
    // 사용자가 찜한 공간 목록 조회
    public List<SpacesVO> selectFavoriteSpaces(int userNo) {
    	System.out.println("PracticeroomRepository.selectFavoriteSpaces()");
        return sqlSession.selectList("practiceroom.selectFavoriteSpaces", userNo);
    }
    
    // 사용자의 찜 후보 목록 조회
    public List<Map<String, Object>> selectFavoriteCandidates(int userNo) {
        return sqlSession.selectList("practiceroom.selectFavoriteCandidates", userNo);
    }
    
    // 룸 가격 리스트 가져오기
    public List<RoomPriceVO> selectRoomPricesByDate(ReserveInfoVO reserveInfoVO) {
    	System.out.println("PracticeroomRepository.selectRoomPricesByDate()");
    	
        return sqlSession.selectList("practiceroom.selectRoomPricesByDate", reserveInfoVO);
    }
    
    // 방 정보 조회
    public RoomsVO selectRoomByNo(Long roomNo) {
        return sqlSession.selectOne("practiceroom.selectRoomByNo", roomNo);
    }
    
    // 찜 목록에 새 항목 삽입
    public int insertStudioWishlist(int userNo, Long roomNo) {
        Map<String, Object> p = new HashMap<>();
        p.put("userNo", userNo);
        p.put("roomNo", roomNo);
        System.out.println("insertStudioWishlist");
        return sqlSession.insert("practiceroom.insertStudioWishlist", p);
    }
    
    // 사용자의 소속 팀 목록 조회
    public List<TeamVO> selectTeamsByUser(int userNo) {
        return sqlSession.selectList("practiceroom.selectTeamsByUser", userNo);
    }
    
    // 찜 목록 삭제
    public int deleteStudioWishlist(int userNo, Long roomNo) {
        Map<String, Object> p = new HashMap<>();
        p.put("userNo", userNo);
        p.put("roomNo", roomNo);
        System.out.println("deleteStudioWishlist: userNo=" + userNo + ", roomNo=" + roomNo);
        return sqlSession.delete("practiceroom.deleteStudioWishlist", p);
    }
    
    // 날짜 시간 추가
    public boolean insertVoteOption(int userNo, int roomNo, String voteDate, String voteTime, long voteNo, int voteStatus) {
        Map<String, Object> p = new HashMap<>();
        p.put("userNo", userNo);
        p.put("roomNo", roomNo);      // Long
        p.put("voteDate", voteDate);
        p.put("voteTime", voteTime);
        p.put("voteNo", voteNo);      // Long
        p.put("voteStatus", voteStatus);

        int rows = sqlSession.insert("practiceroom.insertVoteOption", p);
        return rows == 1;
    }
    
    // 후보 추가
    public Long insertVote(int userNo, Long totalPrice, Long postNo) {
        Map<String, Object> p = new HashMap<>();
        p.put("userNo", userNo);
        p.put("totalPrice", totalPrice);
        p.put("postNo", postNo); // null 가능
        sqlSession.insert("practiceroom.insertVote", p);
        // useGeneratedKeys 로 p에 voteNo가 들어옴
        Object key = p.get("voteNo");
        return (key == null) ? null : ((Number) key).longValue();
    }
    
    // 후보 삭제
    public boolean deleteVoteOption(int userNo, long reservationNo) {
    	Map<String, Object> p = new HashMap<>();
        p.put("userNo", userNo);
        p.put("reservationNo", reservationNo);
        int rows = sqlSession.delete("practiceroom.deleteVoteOption", p);
        System.out.println("[삭제 실행] reservationNo=" + reservationNo + ", userNo=" + userNo + ", rows=" + rows);
        return rows == 1;
    }
    
    // 검색
    public List<SpacesVO> searchSpaces(String keyword) {
        return sqlSession.selectList("practiceroom.searchSpaces", "%" + keyword + "%");
    }	
    
}
