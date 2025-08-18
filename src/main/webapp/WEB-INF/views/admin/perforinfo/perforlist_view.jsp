<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 공연 및 대회 정보</title>
        <link rel="stylesheet" href="../../../assets/css/reset.css">
        <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../../assets/css/perforlist_view.css">
    </head>

    <body>
        <div id="wrap">

            <!-- 헤더 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->

            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

<h2 class="infoview-title">공연 및 대회 정보</h2>

<div class="infoview-meta">
  <div class="meta-title">
    <span class="meta-label-title">제목</span>
    <span class="meta-value-title">${vo.infoPostTitle}</span>
  </div>
  <div class="meta-row">
    <span class="meta-label">작성일</span>
    <span class="meta-value">${vo.infoWriteDate}</span>
  </div>
  <div class="meta-row">
    <span class="meta-label">작성자</span>
    <span class="meta-value">${vo.username}</span>
    
    <c:if test="${isOwner}">
      <a href="${pageContext.request.contextPath}/onespace/perforinfo/modifyForm?no=${vo.infoPostNo}" class="btn-edit">수정하기</a>
    </c:if>
  </div>
</div>

<div class="infoview-main">
  <c:if test="${not empty vo.perforImg}">
    <div class="infoview-image">
      <img src="${vo.perforImg}" alt="공연 포스터">
    </div>
  </c:if>

  <div class="infoview-right">
    <div class="infoview-details">
      <div class="detail-row">마감 날짜: ${vo.deadlineDate}</div>
      <div class="detail-row">위치: ${vo.infoArea}</div>
      <c:if test="${not empty vo.infoOutUrl}">
        <div class="detail-row">
          <a href="${vo.infoOutUrl}" target="_blank">${vo.infoOutUrl}</a>
        </div>
      </c:if>
    </div>

    <div class="infoview-content">
      ${vo.infoContent}
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
