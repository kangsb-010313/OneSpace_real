<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스-팀자랑</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/pride.css">
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

                  <section class="pride">
                    <div class="main-head">
                      <h1>팀 자랑</h1>
                      <button class="write-btn" type="button">글쓰기</button>
                    </div>

                    <div class="team-grid">
            <!-- 카드 1 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀 연습 사진01.jpg" alt="팀 원밀리언 프로필 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 원밀리언</h2>
                <p class="team-id">@1milliondance</p>
                <p class="team-desc">#mood #느좋연습실 #조명좋음 #원밀리언</p>
              </div>
            </article>

            <!-- 카드 2 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진02.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 아우라</h2>
                <p class="team-id">@aura_official</p>
                <p class="team-desc">#힙합 #단체군무 #에너지</p>
              </div>
            </article>

            <!-- 카드 3 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진03.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 네오스</h2>
                <p class="team-id">@neos_dance</p>
                <p class="team-desc">#걸리시 #하이틴무드 #컨셉촬영</p>
              </div>
            </article>

            <!-- 카드 4 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진04.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 비전</h2>
                <p class="team-id">@vision.crew</p>
                <p class="team-desc">#코레오 #뮤비커버 #영상팀</p>
              </div>
            </article>

            <!-- 카드 5 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진05.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 모션</h2>
                <p class="team-id">@motion_kr</p>
                <p class="team-desc">#팝핀 #프리스타일 #배틀러</p>
              </div>
            </article>

            <!-- 카드 6 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진06.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 플레인</h2>
                <p class="team-id">@plane.dance</p>
                <p class="team-desc">#재즈 #테크닉 #무대연출</p>
              </div>
            </article>

            <!-- 카드 7 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진07.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 하이드</h2>
                <p class="team-id">@hide.musical</p>
                <p class="team-desc">#뮤지컬 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 8 -->
            <article class="team-card">
              <img src="../../assets/images/댄스팀연습사진08.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 코브라</h2>
                <p class="team-id">@cobra.dnace</p>
                <p class="team-desc">#현대무용 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 9 -->
            <article class="team-card">
              <img src="../../assets/images/팀자랑사진04.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 다이아몬드</h2>
                <p class="team-id">@diamond.dnace</p>
                <p class="team-desc">#칼군무 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 10 -->
            <article class="team-card">
              <img src="../../assets/images/팀자랑사진02.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 플라워</h2>
                <p class="team-id">@flower.dnace</p>
                <p class="team-desc">#현대무용 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 11 -->
            <article class="team-card">
              <img src="../../assets/images/팀자랑사진03.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 JP</h2>
                <p class="team-id">@japan.dnace</p>
                <p class="team-desc">#댄스 #일본 #무대연출</p>
              </div>
            </article>

            <!-- 카드 12 -->
            <article class="team-card">
              <img src="../../assets/images/팀자랑사진01.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 엘레강스</h2>
                <p class="team-id">@Elegant.dnace</p>
                <p class="team-desc">#발레 #우아함 #무대연출</p>
              </div>
            </article>

                </div>

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