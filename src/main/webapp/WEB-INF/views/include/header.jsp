<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header>
  <div class="container">
    <div class="header-inner">
      <h1 class="logo">
        <a class="click" href="${pageContext.request.contextPath}/onespace/main">원 스페이스</a>
      </h1>

      <div class="header-right">
        <nav class="nav">
		    <ul>
		        <li><a href="${pageContext.request.contextPath}/team/teammain">팀페이지</a></li>
		        <li><a href="${pageContext.request.contextPath}/practice/practice1_main">연습실찜하기</a></li>
		        <li><a href="${pageContext.request.contextPath}/perfoinfo/list">공연 및 대회 정보</a></li>
		        <li><a href="${pageContext.request.contextPath}/pride/list">팀자랑</a></li>
		    </ul>
		</nav> 

        <c:choose>
          <%-- 로그인 상태 --%>
          <c:when test="${not empty sessionScope.authUser}">
            <div class="header-buttons">
              <span class="username">${sessionScope.authUser.userName} 님</span>
              <div class="host-signup-group">
                <a href="${pageContext.request.contextPath}/host" class="btn-outline host-btn">호스트센터</a>
                <a href="${pageContext.request.contextPath}/user/logout" class="btn-outline login-btn">로그아웃</a>
              </div>
            </div>
          </c:when>

          <%-- 비로그인 상태 --%>
          <c:otherwise>
            <div class="header-buttons">
              <a href="${pageContext.request.contextPath}/user/loginForm" class="btn-outline login-btn">로그인</a>
              <div class="host-signup-group">
                <a href="#" class="btn-outline host-btn">호스트센터</a>
                <a href="${pageContext.request.contextPath}/user/signupForm" class="btn-outline signup-btn">회원가입</a>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</header>
