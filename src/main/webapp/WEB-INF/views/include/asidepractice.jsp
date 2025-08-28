<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="team-aside">
    <h2>팀페이지</h2>
    
    <div class="team-list-section">
        <%-- ▼▼▼▼▼ 모든 팀 목록을 동적으로 출력 ▼▼▼▼▼ --%>
        <c:forEach var="team" items="${allTeams}">
            <button type="button" class="btn-outline3 teamlist-btn">
                &nbsp&nbsp&nbsp팀 ${team.teamName}
            </button>
        </c:forEach>
    </div>
    
</div>

<script>
document.addEventListener("DOMContentLoaded", function(){
    const teamButtons = document.querySelectorAll(".teamlist-btn");

    teamButtons.forEach(btn => {
        btn.addEventListener("click", function(){
            // 모든 버튼에서 active 제거
            teamButtons.forEach(b => b.classList.remove("active"));
            // 현재 클릭한 버튼만 active 추가
            this.classList.add("active");
        });
    });
});
</script>

<style>
.btn-outline3.teamlist-btn {
    display: block;
    box-sizing: border-box;
    width: 100%;
    margin-bottom: 12px;
    border: 1.5px solid #704CE4;
    color: #704CE4;
    font-size: 16px;
    font-weight: 500;
    border-radius: 5px;
    padding: 14px 0;
    background: #fff;
    text-align: left;
    transition: background 0.2s, color 0.2s;
}

#team-aside .team-list-section a {
    padding-left: 10px;
}

.btn-outline3.teamlist-btn:hover {
    background: #704CE4;
    color: #fff;
}

/* 클릭 후 고정 스타일 */
.btn-outline3.active {
    background: #704CE4;
    color: #fff;
    border-color: #0056b3;
}


/* /aside---------------------------------------------- */

</style>
