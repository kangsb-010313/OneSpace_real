<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀페이지-메인</title>
    <%-- 올바른 CSS 경로로 수정 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teammain.css">
</head>
<body>
    <div id="wrap">

        <!-- 헤더 영역------------------------------------------------ -->
        <c:import url="/WEB-INF/views/include/header.jsp" />
        <!-- /헤더 영역------------------------------------------------ -->

        <!-- 컨텐츠 영역 -->
        <main>
            <div class="container">
                <div id="content">

	               	<!-- 팀페이지 aside ---------------------------------------------->
					<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
					<!-- 팀페이지 aside ---------------------------------------------->

                    <!-- Main Content: 모든 팀 게시글 동적 생성 -->
                    <div id="main-content">
                        <h2>팀 일정</h2>
                        <div class="team-schedule-search-box">
                            <form class="team-schedule-search-form">
                                <input type="text" placeholder="검색어를 입력해주세요." class="team-schedule-input">
                                <button type="submit" class="team-schedule-btn">검색</button>
                            </form>
                        </div>

                        <div id="team-schedule-list">
                            <table>
                                <colgroup>
                                    <col style="width:130px">
                                    <col style="width:730px">
                                    <col style="width:100px">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>작성팀</th>
                                        <th>제목</th>
                                        <th>작성일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty allPostsList}">
                                            <c:forEach items="${allPostsList}" var="post">
                                                <tr>
                                                    <td>${post.teamName}</td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/onespace/teams/${post.teamNo}/posts/${post.teamPostNo}">${post.teamPostTitle}</a>
                                                    </td>
                                                    <td>${post.teamWriteDate}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3">아직 작성된 게시글이 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <div class="load-more-container">
                            <button id="load-more-btn">더보기</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- 푸터 영역------------------------------------------------ -->
		<c:import url="/WEB-INF/views/include/footer.jsp" />
        <!-- /푸터 영역------------------------------------------------ -->

    </div>
</body>
</html>
