package com.javaex.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVO;

@Repository
public class UserRepository {
	//필드
	@Autowired
	private SqlSession sqlSession;
	
	//메소드일반
	//--user저장(회원가입)
		public int userInsert(UserVO userVO) {
			System.out.println("UserRepository.userInsert()");
			
			int count = sqlSession.insert("user.insert", userVO);
			
			return count;
		}
		
		
		//--user정보가져오기(id password) -->세션저장용
		public UserVO userSelectOneByIdPw(UserVO userVO) {
			System.out.println("UserRepository.userSelectOneByIdPw()");
			
			//System.out.println(userVO);  //id pw   0x999
			
			UserVO authUser = sqlSession.selectOne("user.selectOneByIdPw", userVO);  
			
			//System.out.println(authUser); //다 들어있다  0x567

			return authUser;
			
		}
		
		/* ==================== 카카오 관련 ==================== */

		//--카카오 아이디로 단건 조회
		public UserVO findByKakaoId(String kakaoId) { // ✅ 서비스/컨트롤러와 통일
			System.out.println("UserRepository.findByKakaoId()");
			return sqlSession.selectOne("user.selectOneByKakaoId", kakaoId);
		}

		//--이메일로 단건 조회(기존회원 탐색/연동용)
		public UserVO findByEmail(String email) {
			System.out.println("UserRepository.findByEmail()");
			return sqlSession.selectOne("user.selectOneByEmail", email);
		}

		//--카카오 최소정보로 가입(처음 카카오 로그인 시)
		public int insertKakaoUser(UserVO vo) { // ✅ 서비스/컨트롤러와 통일
			System.out.println("UserRepository.insertKakaoUser()");
			return sqlSession.insert("user.insertKakao", vo);
		}

		//--기존 회원에 kakaoId 연동
		public int updateKakaoUser(long userNo, String kakaoId) { // ✅ 서비스/컨트롤러와 통일
			System.out.println("UserRepository.updateKakaoUser()");
			UserVO param = new UserVO();
			param.setUserNo((int) userNo); // UserVO가 int 타입이므로 캐스팅
			param.setKakaoId(kakaoId);
			return sqlSession.update("user.updateKakaoIdByUserNo", param);
		}
		
		// (2) 프로필 갱신(닉네임/이메일) — ★ Service에서 found(UserVO)로 호출되는 버전
		public int updateKakaoUser(UserVO vo) {
			System.out.println("UserRepository.updateKakaoUser(profile)");
			return sqlSession.update("user.updateKakaoProfileByUserNo", vo);
		}

}
