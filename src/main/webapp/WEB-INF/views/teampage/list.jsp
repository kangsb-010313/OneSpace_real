<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-리스트</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamlist.css">

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
                            <h2>팀 원밀리언</h2>

                            <div class="team-management-links">
                                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/톱니바퀴아이콘.jpg" class="team-setting">팀관리</a>
                                <a href="#"><img src="${pageContext.request.contextPath}/assets/images/톱니바퀴아이콘.jpg" class="team-setting">팀원관리</a>
                            </div>
                            <!-- 일반공지/팀자랑 등록 링크 -->
                            <div class="registration-links">
                                <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/writeform?teamPostType=일반공지">일반공지등록</a>
                                <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/writeform?teamPostType=팀자랑">팀자랑 등록하기</a>
                            </div>

                            <div id="team-search-voting">
                                <div class="team-schedule-search-box">
                                    <form class="team-schedule-search-form">
                                        <input type="text" placeholder="검색어를 입력해주세요." class="team-schedule-input">
                                        <button type="submit" class="team-schedule-btn">검색</button>
                                    </form>
                                </div>

                                <div class="btn-area">
                                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/writeform?teamPostType=투표" class="btn-make">투표만들기</a>
                                </div>
                            </div>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                            <div id="team-schedule-list">
                                <table>
                                    <colgroup>
                                        <col style="width:130px">
                                        <col style="width:730px">
                                        <col style="width:100px">
                                    
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>카테고리</th>
                                            <th>제목</th>
                                            <th>작성일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
	                                    <c:forEach items="${teamPostList}" var="teamPostVO">
	                                        <tr>
	                                            <td>${teamPostVO.teamPostType}</td> <%-- 글 종류 (카테고리) --%>
	                                            <td>
                                                    <%-- ▼▼▼▼▼ 글보기 링크 추가 ▼▼▼▼▼ --%>
                                                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/${teamPostVO.teamPostNo}">${teamPostVO.teamPostTitle}</a>
                                                </td> 
	                                            <td>${teamPostVO.teamWriteDate}</td> <%-- 작성일 --%>
	                                        </tr>
	                                    </c:forEach>
                                    </tbody>

                                </table>

                            </div>

                            <div class="load-more-container">
                                <button id="load-more-btn">더보기</button>
                            </div>

                        </div>

                    </div>
<!-- ------------------------------------------------------------------------------------------------------ -->
                </div>
                <!-- container -->

            </main>
            <!-- /컨텐츠 영역---------------------------------------------- -->



            <!-- 푸터 영역------------------------------------------------ -->
			<c:import url="/WEB-INF/views/include/footer.jsp" />
            <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->
    </body>

</html>