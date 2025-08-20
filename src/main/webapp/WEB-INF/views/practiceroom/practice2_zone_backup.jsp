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
        <!-- 메인 컨텐츠 -->
        <div class="main-section">
          <div class="content-area">
            <div class="filter-bar">
              <button class="btn-list" onclick="location.href='file:///C:/javaStudy/onespace_front/views/practiceroom/practice4_list.html'">
                찜리스트<span style="color:#ff3333;">❤</span>
              </button>
            </div>
            <main class="main">
              <h2 class="page-title">연습실찜하기</h2>
              <div style="width: 90%; border-bottom: 1px solid #e4e2ef; margin-left: 50px;"></div>
              <div class="detail-main align-start">
                <!-- 왼쪽: 대표 이미지 + 공간 설명 -->
                <div class="detail-main-left">
                  <div style="border-radius: 22px; overflow: hidden; margin-bottom: 24px; margin-left: 30px; margin-right: 50px;">
                    <img class="main-photo" src="C:\javaStudy\onespace_front\assets\images\네스트연습실대표사진.jpg" alt="네스트 연습실 대표사진">
                  </div>
                  <div class="section-title" style="margin-top:30px;">네스트 연습실</div>
                  <div class="section-subtitle">[건대입구역 5분] 분위기 1등 조명 있는 연습실</div>
                  <div class="desc-box">
                    안녕하세요! 운영 5년 만에 공간이 리뉴얼 되었습니다.<br>
                    #사용후기는 instagram @neststudio_kondae 로 확인 가능합니다! 🎵<br>
                    <b>#입구 안내</b><br>
                    광진구 자양동 6-1 지하 (긍정맥주 맞은편),<br>
                    작은 골목 왁싱샵 입구가 아닌 큰 길로 나오셔서 네스트 연습실<br>
                    간판 확인 후 계단으로 내려오세요.<br>
                    <b>#시설 안내</b><br>
                    MAIN HALL (약 18평) 15~20인 적합<br>
                    오전(00시~15시) 19,000원<br>
                    오후(15시~24시) 10,000원<br>
                    새벽통대관(00시~06시) 37,000원<br>
                    A HALL (약 6평) 3~4인<br>
                    오전(00시~15시) 6,000원<br>
                    오후(15시~24시) 7,000원<br>
                    새벽통대관(00시~06시) 27,000원<br>
                    B HALL (약 5평) 2인<br>
                    오전(00시~15시) 5,500원<br>
                    오후(15시~24시) 5,500원<br>
                    새벽통대관(00시~06시) 25,000원
                  </div><br>
                  <img src="C:\javaStudy\onespace_front\assets\images\시설안내.jpg">
                  <div class="section-title">시설 안내</div>
                  <ul class="facility-list">
                    <li>1.모든 태블릿 비치 (조명 개별 색상 및 밝기 조절, 음악 재생 용도)</li>
                    <li>2.블루투스 스피커</li>
                    <li>3.냉난방 시설</li>
                    <li>4.전용 주차 불가 (공영주차장 3분거리)</li>
                  </ul>
                  <div class="section-title">예약 시 주의사항</div>
                  <ul class="notice-list">
                    <li>1.음식물 반입 불가 (물, 음료 제외)</li>
                    <li>2.퇴실 시 에어컨, 조명 OFF</li>
                    <li>3.실외화, 힐 (테이핑) 착용 가능</li>
                    <li>4.예약 취소 및 환불, 법적으로 이용일 기준 3일 전까지 가능</li>
                    <li>5.실내 금연 (전자담배xxxxxxx)</li>
                    <li>5.시설물 파손 주의 (파손 시 배상 청구)</li>
                  </ul>
                  <div class="section-title">환불 규정</div>
                  <ul class="refund-list">
                    <li><b>이용 2일전: 총 금액의 100% 환불</b></li>
                    <li><b>이용 전날~당일: 환불 불가</b></li>
                  </ul>
                  <div class="section-title">네스트 연습실</div>
                  <div class="address">서울 광진구 자양동 6-1 지하</div>
                  <div class="map-wrap">
                    <!-- 구글 지도 표시 영역 -->
                    <div id="map" style="width:100%;height:400px"></div>
                    <script>
                      function getLatLngFromAddress(address, callback) {
                        const apiKey = "AIzaSyDZfZ-aDUeEP3W-VW_n2FEVSDzuiK8k5iE";
                        const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${apiKey}`;
                        fetch(url)
                          .then(response => response.json())
                          .then(data => {
                            if (data.status === "OK") {
                              const location = data.results[0].geometry.location;
                              callback(location.lat, location.lng);
                            } else {
                              alert("위도/경도 찾기 실패: " + data.status);
                            }
                          });
                      }
                      function initMap() {
                        getLatLngFromAddress("서울 광진구 자양동 6-1", function(lat, lng) {
                          var center = { lat: lat, lng: lng };
                          var map = new google.maps.Map(document.getElementById('map'), {
                            zoom: 17,
                            center: center
                          });
                          var marker = new google.maps.Marker({
                            position: center,
                            map: map,
                            title: "네스트 연습실"
                          });
                        });
                      }
                    </script>
                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZfZ-aDUeEP3W-VW_n2FEVSDzuiK8k5iE&callback=initMap" async defer></script>
                    <br><br>
                  </div>
                </div>

                <!-- 오른쪽: 룸 리스트 -->
                <div class="zone-right">
                  <div class="room-list">
                    <div class="room-card">
                      <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice3_room.html">
                        <div class="room-thumb-wrap">
                          <img class="room-thumb" src="C:\javaStudy\onespace_front\assets\images\네스트연습실서브사진1.jpg" alt="101호">
                          <div class="room-title">101호</div>
                        </div>
                        <div class="room-bottom-row">
                          <div>
                            <div class="room-meta">최대 7인</div>
                            <div class="room-price">7,000~12,000 원</div>
                          </div>
                          <div class="room-like">♡<span>25</span></div>
                        </div>
                      </a>
                    </div>

                    <div class="room-card">
                      <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice3_room.html">
                        <div class="room-thumb-wrap">
                          <img class="room-thumb" src="C:\javaStudy\onespace_front\assets\images\네스트연습실서브사진2.jpg" alt="102호">
                          <div class="room-title">102호</div>
                        </div>
                        <div class="room-bottom-row">
                          <div>
                            <div class="room-meta">최대 15인</div>
                            <div class="room-price">10,000~12,000 원</div>
                          </div>
                          <div class="room-like">♡<span>13</span></div>
                        </div>
                      </a>
                    </div>

                    <div class="room-card">
                      <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice3_room.html">
                        <div class="room-thumb-wrap">
                          <img class="room-thumb" src="C:\javaStudy\onespace_front\assets\images\네스트연습실서브사진3.jpg" alt="102호">
                          <div class="room-title">102호</div>
                        </div>
                        <div class="room-bottom-row">
                          <div>
                            <div class="room-meta">최대 20인</div>
                            <div class="room-price">15,000 원</div>
                          </div>
                          <div class="room-like">♡<span>13</span></div>
                        </div>
                      </a>
                    </div>
                  </div>
                </div>
                <!-- /zone-right -->
              </div>
              <!-- /detail-main -->
            </main>
          </div>
          <!-- /content-area -->
        </div>
        <!-- /main-section -->
      </div>
      <!-- /container -->
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->
  </div>

  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
  </footer>
  <!-- /푸터 영역----------------------------------------------- -->
  
</body>
</html>
