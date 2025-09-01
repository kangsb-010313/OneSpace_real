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
				
				<!-- 상단 타이틀 영역 -->
                <div class="title-box">
                    <div class="spacer"></div>
                    <h2 class="page-title">${zone.spaceName}</h2>
                    <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/practice/practice4_wish'">
                        찜리스트<span style="color:#ff3333;">❤</span>
                    </button>
                </div>

                <!-- Main Content -->
                <div id="main-content" class="zone">
                    <main class="main">

                        <div class="two-col">
                            <!-- 왼쪽: 공간 상세 -->
                            <div class="detail-main-left">
                                <!-- 대표 이미지 -->
                                <%-- spaceLink 값을 raw에 세팅 (추후 확장 가능) --%>
                                <c:set var="raw" value="${zone.spaceLink}" />
                                <div>
                                    <!-- 대표 이미지 -->
                                    <c:choose>
                                        <c:when test="${not empty zone.repImg}">
                                            <!-- 업로드된 대표 이미지 -->
                                            <div>
                                                <img class="main-photo" src="${pageContext.request.contextPath}/uploads/${zone.repImg}" alt="${zone.spaceName} 대표사진">
                                            </div>
                                        </c:when>
                                        <c:otherwise>
							            <!-- 이미지 없을 때도 동일한 높이의 빈 박스 -->
							            <div class="main-photo placeholder-photo">
							                이미지가 없습니다
							            </div>
							        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <%-- 공간 이름/설명 --%>
                                <div class="section-title">${zone.spaceName}</div>
                                <div class="section-subtitle">${zone.spaceSummary}</div>
                                
                                <%-- 상세 설명 (공간 정보) --%>
                                <div class="desc-box">
                                    ${zone.spaceInfo}
                                </div>
                                
                                <%-- 주소 표시 --%>
                                <div class="section-title">주소</div>
                                <div class="address">${zone.address} ${zone.addressDetail}</div>

                                <!-- 구글 지도 -->
                                <div class="map-wrap">
                                	<!-- 지도 출력 영역 -->
                                    <div id="map" style="width:100%;height:400px"></div>
                                    <script>
                                        function getLatLngFromAddress(address, callback) {
                                            const apiKey = "AIzaSyDZfZ-aDUeEP3W-VW_n2FEVSDzuiK8k5iE";
                                            const url = `https://maps.googleapis.com/maps/api/geocode/json?address=\${encodeURIComponent(address)}&key=\${apiKey}`;
                                         	
                                            // fetch로 API 호출
                                            fetch(url)
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.status === "OK") {
                                                    	// 정상 응답일 경우 첫 번째 결과의 좌표 가져오기
                                                        const location = data.results[0].geometry.location;
                                                        callback(location.lat, location.lng);
                                                    } else {
                                                        alert("위도/경도 찾기 실패: " + data.status);
                                                    }
                                                });
                                        }
                                        // Google Map 초기화
                                        function initMap() {
                                            getLatLngFromAddress("${zone.address}", function(lat, lng) {
                                                var center = { lat: lat, lng: lng };
                                                
                                             	// 지도 객체 생성
                                                var map = new google.maps.Map(document.getElementById('map'), {
                                                    zoom: 17,
                                                    center: center
                                                });
                                             	
                                             	// 마커 추가
                                                var marker = new google.maps.Marker({
                                                    position: center,
                                                    map: map,
                                                    title: "${zone.spaceName}" // 마커 제목
                                                });
                                            });
                                        }
                                    </script>
                                    <!-- Google Maps JavaScript API 호출 -->
                                    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZfZ-aDUeEP3W-VW_n2FEVSDzuiK8k5iE&callback=initMap" async defer></script>
                                </div>
                            </div>

                            <!-- 오른쪽: 방 목록 -->
                            <div class="zone-right">
                                <div class="room-list">
                                	<%-- 해당 공간(zone)에 속한 room 목록 반복 출력 --%>
                                    <c:forEach var="room" items="${rooms}">
                                        <div class="room-card">
                                            <a href="${pageContext.request.contextPath}/practice/practice3_room?roomNo=${room.roomNo}">
                                                <div class="room-thumb-wrap">
                                                	<%-- 방 썸네일 (대표 이미지 재사용... 이거 바꿔야하나) --%>
                                                    <img class="room-thumb" src="${pageContext.request.contextPath}/uploads/${zone.repImg}" alt="${zone.spaceName} 대표사진">
                                                    <div class="room-title">${room.roomName}</div>
                                                </div>
                                                <div class="room-bottom-row">
                                                    <div>
                                                        <div class="room-meta">
                                                            <span style="font-weight:bold; color:#ACACAC">•  수용 인원&nbsp;&nbsp;&nbsp;</span>
                                                            최대 ${room.capacity}인
                                                        </div>
                                                        <div class="room-price">
                                                            <span style="font-weight:bold; color:#ACACAC">•  공간 면적&nbsp;&nbsp;&nbsp;</span>
                                                            ${room.area}
                                                        </div>
                                                    </div>
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
