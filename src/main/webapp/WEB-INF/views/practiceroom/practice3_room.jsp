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
			  <%-- mainSrc 계산: 1) zone.spaceLink 우선 2) room.roomInfo 첫번째 3) placeholder --%>
			  <c:choose>
			    <c:when test="${not empty zone && not empty zone.spaceLink}">
			      <c:set var="z" value="${fn:trim(zone.spaceLink)}"/>
			      <c:choose>
			        <c:when test="${fn:startsWith(z,'http')}">
			          <c:set var="mainSrc" value="${z}" />
			        </c:when>
			        <c:when test="${fn:startsWith(z,'/')}">
			          <c:set var="mainSrc" value="${z}" />
			        </c:when>
			        <c:otherwise>
			          <c:set var="mainSrc" value="${ctx}/assets/images/${z}" />
			        </c:otherwise>
			      </c:choose>
			    </c:when>
			
			    <c:when test="${not empty room.roomInfo}">
			      <c:set var="firstRaw" value="${fn:trim(fn:split(room.roomInfo, ',')[0])}" />
			      <c:choose>
			        <c:when test="${fn:startsWith(firstRaw,'http')}">
			          <c:set var="mainSrc" value="${firstRaw}" />
			        </c:when>
			        <c:when test="${fn:startsWith(firstRaw,'/')}">
			          <c:set var="mainSrc" value="${firstRaw}" />
			        </c:when>
			        <c:otherwise>
			          <c:set var="mainSrc" value="${ctx}/assets/images/${firstRaw}" />
			        </c:otherwise>
			      </c:choose>
			    </c:when>
			
			    <c:otherwise>
			      <c:set var="mainSrc" value="${ctx}/assets/images/placeholder.jpg" />
			    </c:otherwise>
			  </c:choose>
			
			  <%-- 메인 이미지 --%>
			  <img id="mainPhoto" class="main-photo"
			       src="${mainSrc}"
			       alt="${room.roomName}"
			       onerror="this.onerror=null;this.src='${ctx}/assets/images/placeholder.jpg'"/>
			
			  <!-- 2x2 그리드: 각 썸네일은 mainSrc의 사분면을 보여줌 -->
				<div class="thumb-grid">
				  <div class="thumb-quad quad-tl" role="button" tabindex="0"
				       style="background-image: url('${mainSrc}');"
				       data-full="${mainSrc}" onclick="swapMainImageFromQuad(this)" onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
				  </div>
				
				  <div class="thumb-quad quad-tr" role="button" tabindex="0"
				       style="background-image: url('${mainSrc}');"
				       data-full="${mainSrc}" onclick="swapMainImageFromQuad(this)" onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
				  </div>
				
				  <div class="thumb-quad quad-bl" role="button" tabindex="0"
				       style="background-image: url('${mainSrc}');"
				       data-full="${mainSrc}" onclick="swapMainImageFromQuad(this)" onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
				  </div>
				
				  <div class="thumb-quad quad-br" role="button" tabindex="0"
				       style="background-image: url('${mainSrc}');"
				       data-full="${mainSrc}" onclick="swapMainImageFromQuad(this)" onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
				  </div>
				</div>
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
				<c:if test="${not empty teams}">
				  <c:forEach var="team" items="${teams}">
				    <div class="team-like-row" style="display:flex;gap:8px;align-items:center;margin-bottom:8px;"
				         data-team-id="${team.teamNo}" data-team-name="${team.teamName}">
				    <button class="btn-outline btn-w120" type="button" data-team-id="${team.teamNo}">
				      <c:out value="${team.teamName}" />
				    </button>
				    <button class="btn-like" type="button"
				            data-room-no="${room.roomNo}"
				            data-team-id="${team.teamNo}"
				            data-team-name="${team.teamName}">
				      찜하기
				    </button>
				    </div>
				  </c:forEach>
				</c:if>
				
				<c:if test="${empty teams}">
			    <div style="color:#888;">선택 가능한 팀이 없습니다.</div>
			    </c:if>
			  </div>
				
            </div>
          </div>
        </div>
      </div>
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->

    <script>
    <!--
    document.addEventListener('DOMContentLoaded', function() {
	  const likeBtns = Array.from(document.querySelectorAll('.btn-like'));
	  const teamBtns = Array.from(document.querySelectorAll('.btn-outline'));
	
	  function resetAll() {
	    likeBtns.forEach(b => b.textContent = '찜하기');
	    teamBtns.forEach(b => b.classList.remove('active'));
	  }
	  
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
    -->
    // --- 찜하기 AJAX 핸들러 ---
    document.addEventListener('DOMContentLoaded', function() {
	  // ctx는 JSP 상단에서 c:set으로 선언되어 있으므로 여기서 사용
	  var ctx = '${ctx}';
	
	  // 찜 버튼(각 팀 행 안에 있는 .btn-like[data-room-no])
	  const likeBtns = document.querySelectorAll('.btn-like[data-room-no]');
	  console.log('찜하기 버튼 개수:', likeBtns.length);
	
	  likeBtns.forEach(btn => {
	    btn.addEventListener('click', function() {
	      // 이미 처리중이면 무시
	      if (btn.disabled) return;
	
	      // 버튼이 속한 행(row)과 팀 아이디 읽기
	      const row = btn.closest('.team-like-row');
	      const teamId = row ? row.getAttribute('data-team-id') : '';
	      const teamName = row ? (row.getAttribute('data-team-name') || (row.querySelector('.btn-outline')?.textContent.trim() || '')) : '';
	      const roomNo = btn.getAttribute('data-room-no');
	      if (!teamId) { alert('팀을 먼저 선택하거나, 팀이 존재하는지 확인하세요.'); return; }
	      if (!roomNo) { alert('roomNo가 없습니다'); return; }
	      
	
	      // 팀이 선택되어야 하는 로직(선택 요구하면 확인)
	      // 만약 팀 선택과 무관하게 바로 보내고 싶으면 아래 체크를 제거하세요.
	      if (!teamId) {
	        // 선택된 row에 data-team-id가 없으면 안내
	        alert('팀을 먼저 선택하거나, 팀이 존재하는지 확인하세요.');
	        return;
	      }
	
	      if (!roomNo) {
	        alert('roomNo가 없습니다');
	        return;
	      }
	
	      // UI: 처리중 표시
	      const originalText = btn.textContent;
	      btn.disabled = true;
	      btn.textContent = '처리중...';
	
	      // --- 여기서 teamId와 roomNo를 함께 서버로 전송 ---
	      fetch(ctx + '/onespace/api/favorite', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	        credentials: 'same-origin',
	        body: 'roomNo=' + encodeURIComponent(roomNo) +
	              '&teamId=' + encodeURIComponent(teamId) +
	              '&teamName=' + encodeURIComponent(teamName)
	      })
	      .then(res => res.json())
	      .then(json => {
	        if (json && json.success) {
	          btn.textContent = '찜';
	          alert(json.message || '찜 추가 완료');
	          window.location.href = ctx + '/onespace/practice4_list';
	        } else {
	          alert(json.message || '찜 추가 실패');
	          btn.disabled = false;
	          btn.textContent = originalText || '찜하기';
	        }
	      })
	      .catch(err => {
	        console.error('찜 요청 실패', err);
	        alert('네트워크/서버 오류');
	        btn.disabled = false;
	        btn.textContent = originalText || '찜하기';
	      });
	    });
	  });
	});
    
    function swapMainImage(thumbEl) {
        var full = thumbEl.getAttribute('data-full');
        if (!full) return;
        var main = document.getElementById('mainPhoto');
        if (!main) return;
        main.src = full;
        main.onerror = function() { this.onerror = null; this.src = '${ctx}/assets/images/placeholder.jpg'; };
      }
    
    function swapMainImageFromQuad(el) {
        var full = el.getAttribute('data-full') || '';
        if (!full) return;
        var main = document.getElementById('mainPhoto');
        if (!main) return;
        main.src = full;
        main.onerror = function() { this.onerror = null; this.src = '${ctx}/assets/images/placeholder.jpg'; };

        // 선택 상태 토글 (한 개만 active)
        document.querySelectorAll('.thumb-quad').forEach(e => e.classList.remove('active'));
        el.classList.add('active');
      }
    
	</script>
  </div>

  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
  </footer>
  <!-- /푸터 영역------------------------------------------------ -->
</body>
</html>
