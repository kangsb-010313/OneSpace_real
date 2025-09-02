<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>원스페이스-팀자랑</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/basicdefault.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/pridepage.css'/>">
</head>

<body>
<div id="wrap">

    <!-- 헤더 -->
    <c:import url="/WEB-INF/views/include/header.jsp" />

    <!-- 컨텐츠 -->
    <main>
      <div class="container">
        <section class="pride-detail">
          <h1 class="page-title">팀 자랑</h1>

          <c:set var="p" value="${empty pride ? post : pride}"/>

          <div class="post-meta">
            <div class="post-title">
              <span class="post-label-title">제목</span>
              <span class="post-value-title"><c:out value="${p.teamPostTitle}"/></span>
            </div>

            <div class="post-team">
              <span class="post-label-team">작성팀</span>
              <span class="post-value-team">
                <c:out value="${p.teamName}"/>
                <span class="team-id"><c:out value="${p.instaAccount}"/></span>
              </span>
            </div>

            <div class="post-date">
              <span class="post-label-date">작성일</span>
              <span class="post-value-date">
                <c:choose>
                  <c:when test="${not empty p.writeDateText}">
                    <c:out value="${p.writeDateText}"/>
                  </c:when>
                  <c:otherwise>
                    <fmt:formatDate value="${p.teamWriteDate}" pattern="yyyy-MM-dd"/>
                  </c:otherwise>
                </c:choose>
              </span>
            </div>
          </div>

          <div class="media-grid">
            <c:forEach var="img" items="${images}">
              <img loading="lazy" src="<c:url value='${img}'/>" alt="첨부 이미지">
            </c:forEach>
            <c:if test="${empty images}">
              <img src="<c:url value='/assets/images/default_team.jpg'/>" alt="기본 이미지">
            </c:if>
          </div>

          <div class="post-body">
            <c:out value="${p.teamContent}"/>
          </div>
        </section>
      </div>
    </main>

    <!-- 푸터 -->
    <c:import url="/WEB-INF/views/include/footer.jsp" />

</div>
</body>
</html>
