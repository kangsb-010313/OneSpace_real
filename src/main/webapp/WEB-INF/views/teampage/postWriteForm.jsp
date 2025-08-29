<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>팀페이지-게시글등록</title> <%-- 제목을 좀 더 일반적인 것으로 변경 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">

    
        <%-- ▼▼▼▼▼ 글 종류에 따라 다른 CSS 파일 로드 ▼▼▼▼▼ --%>
    <c:choose>
        <c:when test="${param.teamPostType == '일반공지'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamwriteform.css">
        </c:when>
        <c:when test="${param.teamPostType == '투표'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/makevote.css">
        </c:when>
        <c:when test="${param.teamPostType == '팀자랑'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teampriwriteform.css">
        </c:when>
        <c:otherwise>
             <%-- 기본 CSS 또는 에러 처리 (필요하다면 기본 폼을 위한 CSS를 여기에 추가할 수 있습니다) --%>
        </c:otherwise>
    </c:choose>
    
</head>

<body>
    <div id="wrap">
        <!-- 헤더 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
        <!-- /헤더 영역------------------------------------------------ -->

        <!-- 컨텐츠 영역---------------------------------------------- -->
        <main>
            <div class="container">
                <div id="content">
                
                	<!-- 팀페이지 aside ---------------------------------------------->
					<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
					<!-- 팀페이지 aside ---------------------------------------------->

                    <div id="main-content">
                        <%-- ▼▼▼▼▼ 글 종류에 따라 제목 변경 ▼▼▼▼▼ --%>
                        <h2 class="post-type-title">
                            <c:choose>
                                <c:when test="${param.teamPostType == '일반공지'}">일반공지등록</c:when>
                                <c:when test="${param.teamPostType == '팀자랑'}">팀자랑 등록</c:when>
                                <c:when test="${param.teamPostType == '투표'}">투표만들기</c:when>
                                <c:otherwise>게시글 등록 실패</c:otherwise> <%-- 기본값 또는 에러 메시지 --%>
                            </c:choose>
                        </h2>

                        <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                        <div class="post-register-wrap">
                            <%-- ▼▼▼▼▼ form action과 method 변경 및 숨겨진 필드 추가 ▼▼▼▼▼ --%>
                            <form action="${pageContext.request.contextPath}/team/teams/${teamNo}/posts/teamwriteadd" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="teamPostType" value="${param.teamPostType}"> <%-- 글 종류 전달 --%>
                                <input type="hidden" name="teamNo" value="${teamNo}"> 

                                <!-- 제목 입력 영역 (공통) -->
                                <div class="form-group title-group">
                                    <label for="post-title">제목</label>
                                    <input type="text" id="post-title" name="teamPostTitle" placeholder="제목을 입력하세요">
                                </div>

                                <!-- 
								<c:if test="${param.teamPostType == '투표'}">
								    <div class="form-group vote-list-group">
								        <label>투표목록</label>
								        
								        <%-- 컨트롤러에서 받은 voteCandidates 리스트가 있는지 확인 --%>
								        <c:choose>
								            <%-- 리스트가 비어있지 않다면, forEach를 사용해 반복 --%>
								            <c:when test="${not empty voteCandidates}">
								                <ol class="vote-items-container">
								                    <%-- "voteCandidates" 리스트의 각 항목을 "candidate"라는 변수로 반복 --%>
								                    <c:forEach items="${voteCandidates}" var="candidate">
								                    
						                    	        <input type="hidden" name="voteNo" value="${candidate.voteNo}">
								                    
								                        <li>
								                            <div class="vote-item-card">
								                                <%-- 이미지: candidate 변수의 picturesNo 필드를 사용 --%>
								                                <img src="${pageContext.request.contextPath}/uploads/${candidate.picturesNo}" alt="후보 이미지">
								                                <div class="card-content-wrapper">
								                                    <div class="card-main-info">
								                                        <div class="info-left">
								                                            <%-- 연습실 이름과 날짜/시간: candidate 변수의 필드들 사용 --%>
								                                            <p class="item-title">${candidate.roomName}</p>
                        													<p class="item-datetime">${candidate.voteDate} ${candidate.startTime} ~ ${candidate.endTime}</p> 
								                                        </div>
								                                        <div class="info-right">
								                                            <%-- 가격: candidate 변수의 totalPrice 필드 사용 --%>
								                                            <p class="item-price">${candidate.totalPrice} 원</p>
								                                        </div>
								                                    </div>
								                                    <div class="card-sub-info">
								                                        <%-- 부가정보와 주소: candidate 변수의 필드들 사용 --%>
													                    <%-- spacesGuideNo 필드에 값이 있을 때만 p 태그를 보여줌 --%>
													                    <c:if test="${not empty candidate.spacesGuideNo}">
													                        <p class="item-info">${candidate.spacesGuideNo}</p>
													                    </c:if>
								                                        <p class="item-location">
								                                            <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon">
								                                            ${candidate.address}
								                                        </p>
								                                    </div>
								                                </div>
								                            </div>
								                        </li>
								                    </c:forEach>
								                </ol>
								            </c:when>
								            <%-- 만약 리스트가 비어있다면, 안내 메시지 표시 --%>
								            <c:otherwise>
								                <div class="wishlist-container" style="padding: 20px; text-align: center;">
								                    <p>투표로 만들 후보가 없습니다.<br>먼저 '찜 목록'에서 연습실의 날짜와 시간을 선택해주세요.</p>
								                </div>
								            </c:otherwise>
								        </c:choose>
								    </div>
								</c:if>
								-->
								<c:if test="${param.teamPostType == '투표'}">
								    <div class="form-group vote-list-group">
								        <label>투표목록</label>
								        
								        <%-- 컨트롤러에서 받은 voteCandidates 리스트가 있는지 확인 --%>
								        <c:choose>
								            <%-- 리스트가 비어있지 않다면, forEach를 사용해 반복 --%>
								            <c:when test="${not empty voteCandidates}">
								                <ol class="vote-items-container">
								                    <%-- "voteCandidates" 리스트의 각 항목을 "candidate"라는 변수로 반복 --%>
								                    <c:forEach items="${voteCandidates}" var="candidate">
								                    
						                    	        <input type="hidden" name="voteNo" value="${candidate['voteNo']}">
								                    
								                        <li>
								                            <div class="vote-item-card">
								                                <%-- 이미지: candidate 변수의 picturesNo 필드를 사용 --%>
								                                <img src="${pageContext.request.contextPath}/uploads/${candidate['picturesNo']}" alt="후보 이미지">
								                                <div class="card-content-wrapper">
								                                    <div class="card-main-info">
								                                        <div class="info-left">
								                                            <%-- 연습실 이름과 날짜/시간: candidate 변수의 필드들 사용 --%>
								                                            <p class="item-title">${candidate['spaceName']}</p>
                        													<p class="item-datetime">${candidate['voteDate']} ${candidate['startHour']}:00 ~ ${candidate['endHour']}:00</p> 
								                                        </div>
								                                        <div class="info-right">
								                                            <%-- 가격: candidate 변수의 totalPrice 필드 사용 --%>
								                                            <p class="item-price"><fmt:formatNumber value="${candidate.totalPrice}" pattern="#,###" /> 원</p>
								                                        </div>
								                                    </div>
								                                    <div class="card-sub-info">
								                                        <%-- 부가정보와 주소: candidate 변수의 필드들 사용 --%>
													                    <%-- spacesGuideNo 필드에 값이 있을 때만 p 태그를 보여줌 --%>
													                    <c:if test="${not empty candidate.spacesGuideNo}">
													                        <p class="item-info">${candidate.spacesGuideNo}</p>
													                    </c:if>
								                                        <p class="item-location">
								                                            <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon">
								                                            ${candidate['address']}
								                                        </p>
								                                    </div>
								                                </div>
								                            </div>
								                        </li>
								                    </c:forEach>
								                </ol>
								            </c:when>
								            <%-- 만약 리스트가 비어있다면, 안내 메시지 표시 --%>
								            <c:otherwise>
								                <div class="wishlist-container" style="padding: 20px; text-align: center;">
								                    <p>투표로 만들 후보가 없습니다.<br>먼저 '찜 목록'에서 연습실의 날짜와 시간을 선택해주세요.</p>
								                </div>
								            </c:otherwise>
								        </c:choose>
								    </div>
								</c:if>

                                <!-- 글 내용 및 파일 첨부 영역 (공통) -->
                                <div class="form-group content-group">
                                    <div class="content-header">
                                        <label for="post-content">글내용</label>
                                        <div class="file-attach-section">
                                            <label for="file-upload" class="btn-file-attach">파일첨부</label>
                                            <input type="file" id="file-upload" name="files" multiple="multiple" >
                                        </div>
                                    </div>
                                    
                                    <div class="content-box">
                                        <textarea id="post-content" name="teamContent" placeholder="내용을 입력하세요"></textarea>
                                        <div id="file-preview-zone"></div>
                                    </div>
                                </div>

                                <!-- 하단 버튼 영역 (공통) -->
                                <div class="form-actions">
                                    <a href="${pageContext.request.contextPath}/team/teams/${teamNo}/posts/list" class="btn-cancel">취소</a>
                                    <button type="submit" class="btn-submit">등록</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- /컨텐츠 영역---------------------------------------------- -->

        <!-- 푸터 영역------------------------------------------------ -->
		<c:import url="/WEB-INF/views/include/footer.jsp" />
        <!-- /푸터 영역------------------------------------------------ -->
    </div>
    
    <!-- 파일 미리보기 -->
	<script>
	    document.addEventListener('DOMContentLoaded', function() {
	        const fileInput = document.getElementById('file-upload');
	        const previewZone = document.getElementById('file-preview-zone');
	
	        if (fileInput && previewZone) {
	            fileInput.addEventListener('change', function(event) {
	                const files = event.target.files;
	                previewZone.innerHTML = ""; // 기존 미리보기 지우기
	
	                Array.from(files).forEach(file => {
	                    if (file.type.startsWith('image/')) {
	                        const reader = new FileReader();
	                        reader.onload = function(e) {
	                            const img = document.createElement('img');
	                            img.src = e.target.result;
	                            img.style.maxWidth = '120px';
	                            img.style.maxHeight = '120px';
	                            img.style.margin = '5px';
	                            previewZone.appendChild(img);
	                        };
	                        reader.readAsDataURL(file);
	                    }
	                });
	            });
	        }
	    });
	</script>
</body>
</html>
