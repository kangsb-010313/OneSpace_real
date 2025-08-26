<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    
    <%-- ▼▼▼▼▼ 글 종류에 따라 다른 CSS 파일 로드 ▼▼▼▼▼ --%>
    <c:choose>
        <c:when test="${post.teamPostType == '일반공지'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamwriteform.css">
        </c:when>
        <c:when test="${post.teamPostType == '투표'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/makevote.css">
        </c:when>
        <c:when test="${post.teamPostType == '팀자랑'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teampriwriteform.css">
        </c:when>
        <c:otherwise>
             <%-- 기본 CSS 또는 에러 처리 (필요하다면) --%>
        </c:otherwise>
    </c:choose>
</head>

<body>
    <div id="wrap">
        <!-- 헤더 영역 -->
        <c:import url="/WEB-INF/views/include/header.jsp" />

        <!-- 컨텐츠 영역 -->
        <main>
            <div class="container">
                <div id="content">
                
                	<!-- 팀페이지 aside ---------------------------------------------->
					<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
					<!-- 팀페이지 aside ---------------------------------------------->

                    <div id="main-content">
                        <h2 class="post-type-title">
                            <c:choose>
                                <c:when test="${post.teamPostType == '일반공지'}">일반공지 수정</c:when>
                                <c:when test="${post.teamPostType == '팀자랑'}">팀자랑 수정</c:when>
                                <c:when test="${post.teamPostType == '투표'}">투표 수정</c:when>
                                <c:otherwise>게시글 수정</c:otherwise>
                            </c:choose>
                        </h2>
                        
                        <div class="post-register-wrap">
                            <form action="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/modify" method="post">
                                <input type="hidden" name="teamPostNo" value="${post.teamPostNo}">
                                <input type="hidden" name="teamPostType" value="${post.teamPostType}">
                                <input type="hidden" name="teamNo" value="${teamNo}">

                                <!-- 제목 입력 영역 -->
                                <div class="form-group title-group">
                                    <label for="post-title">제목</label>
                                    <input type="text" id="post-title" name="teamPostTitle" value="${post.teamPostTitle}" placeholder="제목을 입력하세요">
                                </div>

                                <!-- 글 종류에 따라 다른 내용 추가 (팀자랑) -->
                                <c:if test="${post.teamPostType == '팀자랑'}">
                                    <div class="form-group instagram-group">
                                        <label>인스타계정</label>
										<span>${post.instaAccount}</span> 
                                    </div>
                                </c:if>

                                <!-- 투표 글은 modifyForm으로 넘어오지 않지만, 혹시 모를 경우를 대비하여 투표 항목은 수정할 수 없음을 명시 -->
                                <c:if test="${post.teamPostType == '투표'}">
                                    <div class="form-group vote-list-group">
                                        <label>투표목록</label>
                                        <ol class="vote-items-container">
                                            <li>투표 게시글은 수정할 수 없습니다.</li>
                                            <li>(관리자에게 문의하세요)</li>
                                        </ol>
                                    </div>
                                </c:if>

                                <!-- 글 내용 및 파일 첨부 영역 -->
                                <div class="form-group content-group">
                                    <div class="content-header">
                                        <label for="post-content">글내용</label>
                                        <div class="file-attach-section">
                                            <label for="file-upload" class="btn-file-attach">파일첨부</label>
                                            <input type="file" id="file-upload" multiple>
                                        </div>
                                    </div>
                                    <div class="content-box">
                                        <textarea id="post-content" name="teamContent" placeholder="내용을 입력하세요">${post.teamContent}</textarea>
                                        <div id="file-preview-zone">
                                        	<%-- 컨트롤러에서 보내준 기존 첨부파일 목록을 반복문으로 출력 --%>
									        <c:forEach items="${post.attachments}" var="file">
									            <div class="preview-item" id="file-${file.teamfileNo}">
													<c:forEach items="${post.attachments}" var="file">
													    <img src="${pageContext.request.contextPath}/uploads/${file.teamStoredFileName}" alt="${file.teamOriginFileName}"
													    class="preview-img">
													</c:forEach>
									                <%-- 삭제 버튼 추가 --%>
									                <span class="remove-btn" data-fileno="${file.teamfileNo}">X</span>
									            </div>
									        </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <!-- 하단 버튼 영역 -->
                                <div class="form-actions">
                                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/${post.teamPostNo}" class="btn-cancel">취소</a>
                                    <button type="submit" class="btn-submit">수정</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- 푸터 영역 -->
        <c:import url="/WEB-INF/views/include/footer.jsp" />
    </div>
</body>
</html>
