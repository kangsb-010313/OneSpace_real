<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 연습실찜하기</title>
  <link rel="stylesheet" href="../../assets/css/reset.css">
  <link rel="stylesheet" href="../../assets/css/practice.css">
  <link rel="stylesheet" href="../../assets/css/asidedefault.css">
  <link rel="stylesheet" href="../../assets/css/basicdefault.css">
</head>
<body>
  <div class="wrap">
    <!-- 헤더 영역------------------------------------------------ -->
    <header>
      <c:import url="/WEB-INF/views/include/header.jsp" />
    </header>
    <!-- /헤더 영역------------------------------------------------ -->

    <main>
      <div class="container">
        <div class="main-section">
          <div class="content-area">
            <div class="filter-bar">
              <button class="btn-list" onclick="location.href='file:///C:/javaStudy/onespace_front/views/practiceroom/practice4_list.html'">
                찜리스트<span style="color:#ff3333;">❤</span>
              </button>
            </div>
            <main class="main">
              <div class="page-title">연습실찜하기</div>
              <div style="width: 90%; border-bottom: 1px solid #e4e2ef; margin-left: 30px;"></div>

              <div class="detail-main align-start">
                <!-- 왼쪽: 사진 영역 -->
                <div class="detail-main-left">
                  <div class="main-photo-wrap">
                    <img src="C:/javaStudy/onespace_front/assets/images/연습실찜하기사진01.jpg" class="main-photo" alt="메인사진">
                  </div>

                  <div class="photo-grid">
                    <img src="C:/javaStudy/onespace_front/assets/images/연습실찜하기사진01.jpg" class="sub-photo" alt="서브1">
                    <img src="C:/javaStudy/onespace_front/assets/images/연습실찜하기사진01.jpg" class="sub-photo" alt="서브2">
                    <img src="C:/javaStudy/onespace_front/assets/images/연습실찜하기사진01.jpg" class="sub-photo" alt="서브3">
                    <img src="C:/javaStudy/onespace_front/assets/images/연습실찜하기사진01.jpg" class="sub-photo" alt="서브4">
                  </div>
                </div>

                <!-- 오른쪽: 설명/버튼 -->
                <aside class="room-right">
                  <div class="room-card">
                    <div class="section">
                      <div class="room-title">네스트 연습실 에이홀</div>
                      <div class="section-h">공간소개</div>
                      <div class="section-b">
                        • 가로 5m X 세로 4m 대략 6평대<br>
                        &nbsp;&nbsp;(3~7인 사용 추천)<br>
                        • 공간면적 약 20m<sup>2</sup><br>
                        • 수용인원 최대 7명
                      </div>
                    </div>

                    <div class="section">
                      <div class="section-h">시설안내</div>
                      <div class="section-b">
                        대관 비용은<br>
                        • 오전 (00시~15시) 6,000원<br>
                        • 오후 (15시~24시) 7,000원<br>
                        • 새벽통대관(00시~06시) 27,000원 입니다.<br><br>
                        • 태블릿 비치(조명 개별 조정 및 음악 재생 가능)<br>
                        • 블루투스 스피커<br>
                        • 냉난방 시설
                      </div>
                    </div>

                    <div class="section">
                      <div class="section-h">가격안내</div>
                      <div class="section-b">
                        • 00~16시 15000원<br>
                        • 16~18시 20000원<br>
                        • 18~24시 25000원
                      </div>
                    </div>

                    <div class="team-like-list">
                      <div class="team-like-row">
                        <button class="btn-outline btn-w120" id="team1">팀 원밀리언</button>
                        <button class="btn-like" id="likeBtn1">찜하기</button>
                      </div>
                      <div class="team-like-row">
                        <button class="btn-outline btn-w120" id="team2">팀 저스트절크</button>
                        <button class="btn-like" id="likeBtn2">찜하기</button>
                      </div>
                    </div>
                  </div>
                </aside>
              </div>
            </main>
          </div>
          <!-- /content-area -->
        </div>
        <!-- /main-section -->
      </div>
      <!-- container -->
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->

    <script>
      const teams = [
        { likeBtn: document.getElementById('likeBtn1'), teamBtn: document.getElementById('team1') },
        { likeBtn: document.getElementById('likeBtn2'), teamBtn: document.getElementById('team2') }
      ];

      teams.forEach((team, index) => {
        team.likeBtn.addEventListener('click', () => {
          const isLiked = team.likeBtn.textContent === '찜하기';

          // 모든 버튼 초기화
          teams.forEach(t => {
            t.likeBtn.textContent = '찜하기';
            t.teamBtn.classList.remove('active');
          });

          // 클릭한 버튼만 상태 변경
          if (isLiked) {
            team.likeBtn.textContent = '찜';
            team.teamBtn.classList.add('active');
          }
        });
      });
    </script>
  </div>

  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
  </footer>
  <!-- /푸터 영역------------------------------------------------ -->
</body>
</html>
