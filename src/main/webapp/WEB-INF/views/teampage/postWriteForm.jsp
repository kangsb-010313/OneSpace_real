<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>팀페이지-게시글등록</title> <%-- 제목을 좀 더 일반적인 것으로 변경 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">

    
        <%-- ▼▼▼▼▼ 글 종류에 따라 다른 CSS 파일 로드 (이 부분을 다시 넣어주세요!) ▼▼▼▼▼ --%>
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
    <%-- ▲▲▲▲▲ 여기까지 다시 넣어주시면 됩니다 ▲▲▲▲▲ --%>
    
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
                        <%-- ▲▲▲▲▲ 여기까지 ▼▼▼▼▼ --%>

                        <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                        <div class="post-register-wrap">
                            <%-- ▼▼▼▼▼ form action과 method 변경 및 숨겨진 필드 추가 ▼▼▼▼▼ --%>
                            <form action="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/teamwriteadd" method="post">
                                <input type="hidden" name="teamPostType" value="${param.teamPostType}"> <%-- 글 종류 전달 --%>
                                <input type="hidden" name="teamNo" value="${teamNo}"> 
                                <%-- 
                                    여기에 teamNo도 숨겨서 전달하거나, URL PathVariable로 받거나 해야 합니다.
                                    예: <input type="hidden" name="teamNo" value="${param.teamNo}"> 
                                --%>

                                <!-- 제목 입력 영역 (공통) -->
                                <div class="form-group title-group">
                                    <label for="post-title">제목</label>
                                    <input type="text" id="post-title" name="teamPostTitle" placeholder="제목을 입력하세요">
                                </div>


                                <%-- ▼▼▼▼▼ 글 종류에 따라 다른 내용 추가 ▼▼▼▼▼ --%>
                                <c:if test="${param.teamPostType == '팀자랑'}">
                                    <div class="form-group instagram-group">
                                        <label>인스타계정</label>
                                        <span>${currentTeam.instaAccount}</span> 
                                        <%-- 실제 값을 입력받으려면 input 태그를 사용해야 합니다. span은 보여주기만 함 --%>
                                        <%-- <input type="text" name="instagramAccount" placeholder="인스타 계정 입력"> --%>
                                    </div>
                                </c:if>
                                
                                <%-- ▼▼▼▼▼ 글 종류가 '투표'일 때만 이 부분이 보이도록 수정 ▼▼▼▼▼ --%>
<%-- 								<c:if test="${param.teamPostType == '투표'}">
								    <div class="form-group vote-list-group">
								        <label>투표 목록</label>
								
								        컨트롤러에서 받은 찜 목록(voteOptions)을 반복문으로 출력
								        <div class="wishlist-container">
								            <c:choose>
								                <c:when test="${not empty voteOptions}">
								                    <ul>
								                        <c:forEach items="${voteOptions}" var="option">
								                            <li>
								                                <strong>[${option.spaceName}]</strong> ${option.roomName} 
								                                (${option.address})
								                            </li>
								                        </c:forEach>
								                    </ul>
								                </c:when>
								                <c:otherwise>
								                    <p>찜한 연습실이 없습니다. 먼저 연습실을 찜해주세요.</p>
								                </c:otherwise>
								            </c:choose>
								        </div>
								    </div>
								</c:if> --%>


                                 <c:if test="${param.teamPostType == '투표'}">
                                    <div class="form-group vote-list-group">
                                        <label>투표목록</label>
                                        <ol class="vote-items-container">
                                            <li>
                                                <a href="#" class="vote-item-card">
                                                    <img src="${pageContext.request.contextPath}/assets/images/연습실사진01.jpg" alt="네스트 연습실">
                                                    <div class="card-content-wrapper">
                                                        <div class="card-main-info">
                                                            <div class="info-left">
                                                                <p class="item-title">네스트 연습실 101호</p>
                                                                <p class="item-datetime">8/4(월) 15:00-17:00</p> 
                                                            </div>
                                                            <div class="info-right">
                                                                <p class="item-price">10,000 원</p>
                                                            </div>
                                                        </div>
                                                        <div class="card-sub-info">
                                                            <p class="item-info">실외화 가능/주차/최대7인</p>
                                                            <p class="item-location">
                                                                <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                            </p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <!-- ... 나머지 투표 카드들 ... -->
                                            <li>
                                                <a href="#" class="vote-item-card">
                                                    <img src="${pageContext.request.contextPath}/assets/images/연습실사진02.jpg" alt="네스트 연습실">
                                                    <div class="card-content-wrapper">
                                                        <div class="card-main-info">
                                                            <div class="info-left">
                                                                <p class="item-title">네스트 연습실 101호</p>
                                                                <p class="item-datetime">8/4(월) 15:00-17:00</p> 
                                                            </div>
                                                            <div class="info-right">
                                                                <p class="item-price">20,000 원</p>
                                                            </div>
                                                        </div>
                                                        <div class="card-sub-info">
                                                            <p class="item-info">실외화 가능/주차/최대7인</p>
                                                            <p class="item-location">
                                                                <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                            </p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="vote-item-card">
                                                    <img src="${pageContext.request.contextPath}/assets/images/연습실사진03.jpg" alt="네스트 연습실">
                                                    <div class="card-content-wrapper">
                                                        <div class="card-main-info">
                                                            <div class="info-left">
                                                                <p class="item-title">네스트 연습실 101호</p>
                                                                <p class="item-datetime">8/4(월) 15:00-17:00</p> 
                                                            </div>
                                                            <div class="info-right">
                                                                <p class="item-price">25,000 원</p>
                                                            </div>
                                                        </div>
                                                        <div class="card-sub-info">
                                                            <p class="item-info">실외화 가능/주차/최대7인</p>
                                                            <p class="item-location">
                                                                <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                            </p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                        </ol>
                                    </div>
                                </c:if> 
                                <%-- ▲▲▲▲▲ 여기까지 ▼▼▼▼▼ --%>

                                <!-- 글 내용 및 파일 첨부 영역 (공통) -->
                                <div class="form-group content-group">
                                    <div class="content-header">
                                        <label for="post-content">글내용</label>
                                        <div class="file-attach-section">
                                            <label for="file-upload" class="btn-file-attach">파일첨부</label>
                                            <input type="file" id="file-upload" multiple>
                                        </div>
                                    </div>
                                    <div class="content-box">
                                        <textarea id="post-content" name="teamContent" placeholder="내용을 입력하세요"></textarea>
                                        <div id="file-preview-zone"></div>
                                    </div>
                                </div>

                                <!-- 하단 버튼 영역 (공통) -->
                                <div class="form-actions">
                                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/list" class="btn-cancel">취소</a>
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
</body>
</html>
