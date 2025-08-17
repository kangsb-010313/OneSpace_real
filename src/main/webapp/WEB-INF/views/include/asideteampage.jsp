<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="team-aside">
    <h2>팀페이지</h2>
    
    <div class="team-list-section">
        <%-- ▼▼▼▼▼ 모든 팀 목록을 동적으로 출력 ▼▼▼▼▼ --%>
        <c:forEach var="team" items="${allTeams}">
            <a href="${pageContext.request.contextPath}/onespace/teams/${team.teamNo}/posts/list" class="btn-outline3 teamlist-btn">팀 ${team.teamName}</a>
        </c:forEach>
    </div>
    <a href="#" class="btn-outline2 teamadd-btn">팀 등록하기</a>
</div>