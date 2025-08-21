<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-팀원관리</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teammember.css">
    </head>

    <body>
        <div id="wrap">

	        <!-- 헤더 영역 (모든 JSP에서 공통 부분) -->
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
                            <h2>팀원 관리</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                            <div class="team-wrote-wrap">
                                <div class="post-container">
                                    <div class="post-header">
                                        <h4 class="post-title">${teamInfo.teamName} 팀원관리</h4>
                                    </div>

                                    <div class="post-content">
                                        
                                        <div id="team-member-list">
                                            <table>
                                                <colgroup>
                                                    <col style="width: 130px;">
                                                    <col style="width: auto;">
                                                    <col style="width: 240px;">
                                                    <col style="width: 240px;">
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th>구분</th>
                                                        <th>이름</th>
                                                        <th>가입일</th>
                                                        <th>관리</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    
                                                    <c:forEach items="${memberList}" var="member">
						                                <tr>
						                                    <td>${member.position}</td>
						                                    <td>${member.userName}</td>
						                                    <td>${member.joinedDate}</td>
						                                    <td>
						                                        <div class="action-buttons">
						                                            <c:choose>
						                                                <%-- Case 1: 신청자(보류 상태)일 경우 '거부', '승인' 버튼 --%>
						                                                <c:when test="${member.status == '보류'}">
						                                                    <form action="${pageContext.request.contextPath}/onespace/teams/${teamInfo.teamNo}/remove/${member.userNo}" method="post" style="display:inline;">
						                                                        <button type="submit" class="btn-manage">거부</button>
						                                                    </form>
						                                                    <form action="${pageContext.request.contextPath}/onespace/teams/${teamInfo.teamNo}/approve/${member.userNo}" method="post" style="display:inline;">
						                                                        <button type="submit" class="btn-manage">승인</button>
						                                                    </form>
						                                                </c:when>
						                                                
						                                                <%-- Case 2: 일반 팀원(승인 상태)일 경우 '삭제' 버튼 --%>
						                                                <c:when test="${member.position == '팀원' && member.status == '승인'}">
						                                                    <form action="${pageContext.request.contextPath}/onespace/teams/${teamInfo.teamNo}/remove/${member.userNo}" method="post" style="display:inline;">
						                                                        <button type="submit" class="btn-manage">삭제</button>
						                                                    </form>
						                                                </c:when>
						                                                
						                                                <%-- Case 3: 팀장일 경우 아무 버튼도 없음 --%>
						                                                <c:otherwise>
						                                                    <%-- 아무것도 표시하지 않음 --%>
						                                                </c:otherwise>
						                                            </c:choose>
						                                        </div>
						                                    </td>
						                                </tr>
						                            </c:forEach>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                        

                                    </div>

                                </div>
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
        <!-- wrap -->
    </body>

</html>