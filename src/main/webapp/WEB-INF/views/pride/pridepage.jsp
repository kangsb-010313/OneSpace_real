<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스-팀자랑</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/pridepage.css">
    </head>

    <body>
        <div id="wrap">

            <!-- 헤더 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->





            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

                  <section class="pride-detail">
                <h1 class="page-title">팀 자랑</h1>

                <!-- 글제목/정보 -->
                
                <div class="post-meta">
                <div class="post-title">
                    <span class="post-label-title">제목</span>
                    <span class="post-value-title">원밀리언 연습 후기</span>
                    <span></span>
                </div>

                <div class="post-team">
                    <span class="post-label-team">작성팀</span>
                    <span class="post-value-team">팀 원밀리언 <span class="team-id">@1milliondance</span></span>
                    <span></span>
                </div>

                <div class="post-date">
                    <span class="post-label-date">작성일</span>
                    <span class="post-value-date">2025-08-01</span>
                    <span></span>
                </div>
                </div>
                <!--사진-->
                <div class="media-grid">
                    <img src="../../assets/images/팀자랑사진01.jpg" alt="사진1">
                    <img src="../../assets/images/팀자랑사진02.jpg" alt="사진2">
                    <img src="../../assets/images/팀자랑사진03.jpg" alt="사진2">
                    
                </div>

                <!-- 본문 -->
                <div class="post-body">
                    <p>
                    홍대 N 스튜디오 연습실 조명이 좋아서 어떤 동영상도 예쁘게 나와요!<br>
                    이번에도 3인팀으로 모여서 춤 연습과 준비 중이에요! 많은 관심 부탁드려요!<br>
                    자세한 내용은 인스타그램의 공식계정을 확인해주세요 :)
                    </p>
                </div>
                </section>  

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