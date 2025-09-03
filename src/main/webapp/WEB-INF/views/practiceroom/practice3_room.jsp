<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>원스페이스 | 연습실찜하기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/practice3_room.css">
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
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
                    <h2 class="page-title">${room.roomName}</h2>
                    <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/practice/practice4_wish'">
                    찜리스트<span style="color:#ff3333;">❤</span>
                    </button>
                </div>
                
                <div class="detail-container">
                    <!-- 왼쪽 대표 이미지 (room.roomInfo) -->
                    <div class="left-col">
                        <!-- <img id="mainPhoto" class="main-photo" src="${ctx}/uploads/${zone.repImg}" alt="${room.roomName}"/> -->
                        <div id="mainPhoto" class="main-photo"
						     style="background-image:url('${ctx}/uploads/${zone.repImg}'); background-size:cover; background-position:center;" onclick="resetMainImage()">
						</div>

                        <!-- 2x2 그리드 -->
                        <div class="thumb-grid">
                            <div class="thumb-quad quad-tl" role="button" tabindex="0"
                                style="background-image: url('${ctx}/uploads/${zone.repImg}');"
                                data-full="${ctx}/uploads/${zone.repImg}" 
                                onclick="swapMainImageFromQuad(this)" 
                                onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
                            </div>
                            <div class="thumb-quad quad-tr" role="button" tabindex="0"
                                style="background-image: url('${ctx}/uploads/${zone.repImg}');"
                                data-full="${ctx}/uploads/${zone.repImg}" 
                                onclick="swapMainImageFromQuad(this)" 
                                onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
                            </div>
                            <div class="thumb-quad quad-bl" role="button" tabindex="0"
                                style="background-image: url('${ctx}/uploads/${zone.repImg}');"
                                data-full="${ctx}/uploads/${zone.repImg}" 
                                onclick="swapMainImageFromQuad(this)" 
                                onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
                            </div>
                            <div class="thumb-quad quad-br" role="button" tabindex="0"
                                style="background-image: url('${ctx}/uploads/${zone.repImg}');"
                                data-full="${ctx}/uploads/${zone.repImg}" 
                                onclick="swapMainImageFromQuad(this)" 
                                onkeydown="if(event.key==='Enter') swapMainImageFromQuad(this)">
                            </div>
                        </div>
                    </div>

                    <!-- 오른쪽: roomInfo -->
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
							    <!-- 팀 선택 기능 제거 -->
							    <button class="btn-like" type="button"
							        data-room-no="${room.roomNo}">
							        찜하기
							    </button>
							</div>
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
	    var ctx = '${ctx}';
	    
	    // 찜 버튼(팀 구분 없음, roomNo만 사용)
	    const likeBtns = document.querySelectorAll('.btn-like[data-room-no]');
	    console.log('찜하기 버튼 개수:', likeBtns.length);
	    
	    likeBtns.forEach(btn => {
	        btn.addEventListener('click', function() {
	            if (btn.disabled) return;
	            
	            const roomNo = btn.getAttribute('data-room-no');
	            if (!roomNo) {
	                alert('roomNo가 없습니다');
	                return;
	            }
	            
	            const originalText = btn.textContent;
	            btn.disabled = true;
	            btn.textContent = '처리중...';
	            
	            // roomNo만 서버로 전송
	            fetch(ctx + '/practice/api/favorite', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                credentials: 'same-origin',
	                body: 'roomNo=' + encodeURIComponent(roomNo)
	            })
	            .then(res => res.json())
	            .then(json => {
	                if (json && json.success) {
	                    btn.textContent = '찜';
	                    alert(json.message || '찜 추가 완료');
	                    window.location.href = ctx + '/practice/practice4_wish';
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
        var main = document.getElementById('mainPhoto');
        if (!main) return;

        // 썸네일의 background-image / position 가져오기
        var bgImage = window.getComputedStyle(el).backgroundImage;
        var bgPosition = window.getComputedStyle(el).backgroundPosition;

        main.style.backgroundImage = bgImage;
        main.style.backgroundPosition = bgPosition;
        main.style.backgroundSize = "200% 200%"; // 클릭했을 때만 확대 적용

        // active 표시
        document.querySelectorAll('.thumb-quad').forEach(e => e.classList.remove('active'));
        el.classList.add('active');
    }
    
    // 원본 전체 사진으로 되돌리기
    function resetMainImage() {
        var main = document.getElementById('mainPhoto');
        if (!main) return;

        // 원본 전체 사진으로 되돌리기
        main.style.backgroundImage = "url('${ctx}/uploads/${zone.repImg}')";
        main.style.backgroundPosition = "center";
        main.style.backgroundSize = "cover";

        // 썸네일 active 표시 해제
        document.querySelectorAll('.thumb-quad').forEach(e => e.classList.remove('active'));
    }
	</script>
    
    </div>

    <!-- 푸터 영역------------------------------------------------ -->
    <c:import url="/WEB-INF/views/include/footer.jsp" />
    <!-- /푸터 영역----------------------------------------------- -->
    
</body>
</html>
