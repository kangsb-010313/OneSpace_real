<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 연습실찜하기</title>
  <link rel="stylesheet" href="../../assets/css/reset.css">
  <link rel="stylesheet" href="../../assets/css/practice.css">
  <link rel="stylesheet" href="../../assets/css/asidedefault.css">
  <link rel="stylesheet" href="../../assets/css/basicdefault.css">
  <c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
    /* 간단 레이아웃: 좌/우 */
    .detail-container { display:flex; gap:32px; align-items:flex-start; padding:24px 0; }
    .left-col { flex: 1 1 60%; }
    .right-col { width: 320px; flex: 0 0 320px; }

    .main-photo { width:100%; height:400px; object-fit:cover; border-radius:12px; display:block; }
    .thumb-row { display:flex; gap:8px; margin-top:12px; flex-wrap:wrap; }
    .thumb-row img { width:90px; height:66px; object-fit:cover; border-radius:6px; border:1px solid #eee; cursor:pointer; }

    .room-info-card {
      background:#fff; border:1px solid #eee; padding:16px; border-radius:10px;
      box-shadow: 0 1px 2px rgba(0,0,0,0.04);
    }
    .room-info-card h3 { margin:0 0 8px 0; font-size:18px; }
    .room-info-text { white-space: pre-wrap; color:#333; font-size:14px; line-height:1.6; }

    /* 이미지 fallback */
    .placeholder { background:#f5f5f5; display:flex; align-items:center; justify-content:center; color:#bbb; }
  </style>
</head>
<body>
  <div class="wrap">
    <header>
      <c:import url="/WEB-INF/views/include/header.jsp" />
    </header>

    <main>
      <div class="container">
        <h2 style="margin-top:18px;">${room.roomName}</h2>
        <div style="width:90%; border-bottom:1px solid #e9e9f0; margin-bottom:18px;"></div>

        <div class="detail-container">
          <!-- LEFT: 대표 이미지 (room.roomInfo 기반) -->
          <div class="left-col">
            <c:set var="rawAll" value="${room.roomInfo}" />
            <c:choose>
              <c:when test="${not empty rawAll}">
                <c:set var="firstRaw" value="${fn:trim(fn:split(rawAll, ',')[0])}" />
				<img class="main-photo" src="${ctx}/assets/images/${zone.spaceLink}" alt="${zone.spaceName}" 
     				onerror="this.onerror=null;this.src='${ctx}/assets/images/placeholder.jpg'"/>
                
              </c:when>

              <c:otherwise>
                <div class="placeholder">이미지 없음</div>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- 오른쪽: roomInfo(이미지 갤러리 또는 텍스트) -->
          <div class="right-col">
            <div class="room-info-card">
              <h3>방 정보</h3>

              <c:choose>
                <%-- 만약 roomInfo에 이미지 확장자가 포함되어 있으면 이미지 목록으로 표시 --%>
                <c:when test="${not empty rawAll and (fn:contains(rawAll,'.jpg') or fn:contains(rawAll,'.jpeg') or fn:contains(rawAll,'.png') or fn:contains(rawAll,'.gif'))}">
                  <div style="display:flex; flex-direction:column; gap:8px;">
                    <c:forEach var="img" items="${fn:split(rawAll, ',')}">
                      <c:set var="iTrim" value="${fn:trim(img)}" />
                      <c:choose>
                        <c:when test="${fn:startsWith(iTrim,'http')}">
                          <img style="width:100%; height:120px; object-fit:cover; border-radius:6px;"
                               src="${iTrim}" alt="room image" onerror="this.onerror=null;this.src='${ctx}/assets/images/placeholder.jpg'"/>
                        </c:when>
                        <c:when test="${fn:startsWith(iTrim,'/')}">
                          <img style="width:100%; height:120px; object-fit:cover; border-radius:6px;"
                               src="${iTrim}" alt="room image" onerror="this.onerror=null;this.src='${ctx}/assets/images/placeholder.jpg'"/>
                        </c:when>
                        <c:otherwise>
                          <img style="width:100%; height:120px; object-fit:cover; border-radius:6px;"
                               src="${ctx}/assets/images/${iTrim}" alt="room image" onerror="this.onerror=null;this.src='${ctx}/assets/images/placeholder.jpg'"/>
                        </c:otherwise>
                      </c:choose>
                    </c:forEach>
                  </div>
                </c:when>

                <c:otherwise>
                  <%-- 텍스트(줄바꿈 유지) --%>
                  <div class="room-info-text">
                    <c:out value="${room.roomInfo}" />
                  </div>
                </c:otherwise>
              </c:choose>

              <!-- 추가 정보(예: 수용인원/면적) -->
              <hr style="margin:12px 0 10px;">
              <div><strong>수용인원:</strong> ${room.capacity}명</div>
              <div><strong>면적:</strong> ${room.area}</div>
              
              <div class="team-like-list" style="margin-top:12px;">
			    <div class="team-like-row" style="display:flex;gap:8px;align-items:center;margin-bottom:8px;">
			      <button class="btn-outline btn-w120" type="button">팀 원밀리언</button>
			      <button class="btn-like" type="button">찜하기</button>
			    </div>
			    <div class="team-like-row" style="display:flex;gap:8px;align-items:center;">
			      <button class="btn-outline btn-w120" type="button">팀 저스트절크</button>
			      <button class="btn-like" type="button">찜하기</button>
			    </div>
			  </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->

    <script>
    document.addEventListener('DOMContentLoaded', function() {
	  const likeBtns = Array.from(document.querySelectorAll('.btn-like'));
	  const teamBtns = Array.from(document.querySelectorAll('.btn-outline'));
	
	  function resetAll() {
	    likeBtns.forEach(b => b.textContent = '찜하기');
	    teamBtns.forEach(b => b.classList.remove('active'));
	  }
	
	  likeBtns.forEach(btn => {
	    btn.addEventListener('click', function() {
	      const row = btn.closest('.team-like-row');
	      const teamBtn = row ? row.querySelector('.btn-outline') : null;
	      const willLike = btn.textContent.trim() === '찜하기';
	      resetAll();
	      if (willLike) {
	        btn.textContent = '찜';
	        if (teamBtn) teamBtn.classList.add('active');
	      }
	    });
	  });
	
	  teamBtns.forEach(btn => {
	    btn.addEventListener('click', function() {
	      const row = btn.closest('.team-like-row');
	      const likeBtn = row ? row.querySelector('.btn-like') : null;
	      resetAll();
	      if (likeBtn) likeBtn.textContent = '찜';
	      btn.classList.add('active');
	    });
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
