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
            <header>
                <div class="container">
                    <div class="header-inner">
                        <h1 class="logo"><a href="#">원 스페이스</a></h1>
                        <div class="header-right">
                            <nav class="nav">
                                <ul>
                                    <li>
                                        <a class="click" href="#">팀페이지</a>
                                    </li>
                                    <li>
                                        <a href="#">연습실찜하기</a>
                                    </li>
                                    <li>
                                        <a href="#">공연 및 대회 정보</a>
                                    </li>
                                    <li>
                                        <a href="#" class="space">팀자랑</a>
                                    </li>
                                </ul>
                            </nav>

                            <div class="header-buttons">
                                <span class="username">강수빈 님</span>
                                <div class="host-signup-group">
                                    <a href="#" class="btn-outline host-btn">호스트센터</a>
                                    <a href="#" class="btn-outline signup-btn">로그아웃</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </header>
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
            <footer>
                <div class="container">
                    <div class="footer-top">
                        <span class="footer-logo">원 스페이스</span>
                        <span class="footer-links">
                        배너광고 문의 | 이용약관 | 개인정보처리방침 | 운영정책 | 콘텐츠산업진흥법에 의한 표시 | 고객 문의
                        </span>
                    </div>
                    <div class="footer-info">
                        상호명: 주식회사 춤사위 | 대표: 홍길동 | 사업자등록번호: 230-81-10313 | 통신판매업신고번호: 2025-서울영등포-1093<br>
                        영업소재지: 서울특별시 강동구 천호대로 1027 5층 501호 | 이메일: cheonho@onespace.kr | 제휴문의: marketing@onespace.kr<br>
                        대표전화: 1599-1234(평일 오후 2시 ~ 오후 6시) | 온라인 1:1 문의 바로가기(평일 오전 10시 ~ 오후 6시)<br>
                    </div>
                    <div class="footer-warning">
                        원스페이스는 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 원스페이스는 공간 거래정보 및 거래에 대해 책임지지 않습니다.
                    </div>
                    <div class="footer-copy">
                        Copyright 춤사위 Corp.All Rights Reserved.
                    </div>
                </div>
            </footer>
            <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->
    </body>

</html>