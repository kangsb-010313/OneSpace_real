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

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   여기(main container)안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->



<h2 class="infoview-title">공연 및 대회 정보</h2>

<div class="infoview-meta">
  <div class="meta-title">
    <span class="meta-label-title">제목</span>
    <span class="meta-value-title">한림예고 실용무용과 정기공연 안내</span>
    <span></span>
  </div>
  <div class="meta-row">
    <span class="meta-label">작성일</span>
    <span class="meta-value">2025-07-31</span>
    <span></span>
  </div>
  <div class="meta-row">
    <span class="meta-label">작성자</span>
    <span class="meta-value">한림예고 실무과</span>
    <a href="#" class="btn-edit">수정하기</a>
  </div>
</div>

<div class="infoview-main">
  <div class="infoview-image">
    <img src="../../../assets/images/instagram.jpg" alt="공연 포스터">
  </div>

  <div class="infoview-right">
    <div class="infoview-details">
      <div class="detail-row">마감 날짜: 6/30</div>
      <div class="detail-row">위치: 서울특별시 광진구</div>
      <div class="detail-row">
        <a href="https://www.instagram.com/p/DDGn17z25tb/" target="_blank">
          https://www.instagram.com/p/DDGn17z25tb/
        </a>
      </div>
    </div>

    <div class="infoview-content">
      한림예고 실용무용과 정기공연 &lt;TAKE MY HAND (WE ARE FAMILY)&gt; 안내입니다.
    </div>
  </div>
</div>




  
  
  



  

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

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