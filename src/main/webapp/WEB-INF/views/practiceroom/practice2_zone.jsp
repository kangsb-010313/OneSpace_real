<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | ${zone.spaceName}</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/practice2_zone.css">

</head>
<body>
  <div class="wrap">
    
	<!-- 헤더 영역------------------------------------------------ -->
	<c:import url="/WEB-INF/views/include/header.jsp" />
	<!-- /헤더 영역------------------------------------------------ -->
    
    <main>
      <div class="container">
      
      	<div class="title-box">
            <div class="spacer"></div>
            <h2 class="page-title">${zone.spaceName}</h2>
		    <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/onespace/practice4_list'">
			  찜리스트<span style="color:#ff3333;">❤</span>
			</button>
        </div>
      	
			<!-- Main Content -->
            <div id="main-content" class="zone">

            <main class="main">
              
              
              <!--  <div class="detail-main align-start"> -->
              <div class="two-col">
                <!-- 왼쪽: 공간 상세 -->
                <div class="detail-main-left">
                  <!-- 대표 이미지 -->
                  <c:if test="${not empty zone.spaceLink}">
                  <c:set var="raw" value="${zone.spaceLink}" />
                    <!--  <div style="border-radius: 22px; overflow: hidden; margin-bottom: 24px; margin-left: 30px; margin-right: 50px;">-->
                    <div>
                      <!-- 대표 이미지 -->
						<c:choose>
						  <c:when test="${not empty zone.repImg}">
						    <!-- 업로드된 대표 이미지 -->
						    <div>
						      <img class="main-photo" src="${pageContext.request.contextPath}/uploads/${zone.repImg}" alt="${zone.spaceName} 대표사진">
						    </div>
						  </c:when>
						  
						</c:choose>
                    </div>
                  </c:if>

                  <div class="section-title">${zone.spaceName}</div>
                  <div class="section-subtitle">${zone.spaceSummary}</div>

                  <div class="desc-box">
                    ${zone.spaceInfo}
                  </div>

                  <div class="section-title">주소</div>
                  <div class="address">${zone.address} ${zone.addressDetail}</div>

                  <!-- 구글 지도 -->
                  <div class="map-wrap">
                    <div id="map" style="width:100%;height:400px"></div>
                    <script>
					  function getLatLngFromAddress(address, callback) {
					    const apiKey = "AIzaSyDZfZ-aDUeEP3W-VW_n2FEVSDzuiK8k5iE";
					    const url = `https://maps.googleapis.com/maps/api/geocode/json?address=\${encodeURIComponent(address)}&key=\${apiKey}`;
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
                        getLatLngFromAddress("${zone.address}", function(lat, lng) {
                          var center = { lat: lat, lng: lng };
                          var map = new google.maps.Map(document.getElementById('map'), {
                            zoom: 17,
                            center: center
                          });
                          var marker = new google.maps.Marker({
                            position: center,
                            map: map,
                            title: "${zone.spaceName}"
                          });
                        });
                      }
                    </script>
                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZfZ-aDUeEP3W-VW_n2FEVSDzuiK8k5iE&callback=initMap" async defer></script>
                  </div>
                </div>

                <!-- 오른쪽: 방 목록 -->
                <div class="zone-right">
                  <div class="room-list">
                    <c:forEach var="room" items="${rooms}">
                      <div class="room-card">
                        <a href="${pageContext.request.contextPath}/onespace/practice3_room?roomNo=${room.roomNo}">
                          <div class="room-thumb-wrap">
		                    <img class="room-thumb" src="${pageContext.request.contextPath}/uploads/${zone.repImg}" alt="${zone.spaceName} 대표사진">
                            <div class="room-title">${room.roomName}</div>
                          </div>
                          <div class="room-bottom-row">
                            <div>
                              <div class="room-meta"><span style="font-weight:bold; color:#ACACAC">•  수용 인원&nbsp;&nbsp;&nbsp;</span> 최대 ${room.capacity}인</div>
                              <div class="room-price"> <span style="font-weight:bold; color:#ACACAC">•  공간 면적&nbsp;&nbsp;&nbsp;</span> ${room.area}</div>
                            </div>
                            <!-- <div class="room-like">♡<span>0</span></div> -->
                          </div>
                        </a>
                      </div>
                    </c:forEach>

                    <!-- 방이 없을 때 -->
                    <c:if test="${empty rooms}">
                      <div style="padding:16px;color:#888;">등록된 방이 없습니다.</div>
                    </c:if>
                  </div>
                  
                  
                </div>
                <!-- /zone-right -->
              </div>
            </main>

          </div>
        </div>
    </main>
    
  </div>
  
  <!-- 푸터 영역------------------------------------------------ -->
  <c:import url="/WEB-INF/views/include/footer.jsp" />
  <!-- /푸터 영역----------------------------------------------- -->
    
</body>
</html>