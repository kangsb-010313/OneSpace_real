<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-투표화면</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/asidedefault.css">
        <link rel="stylesheet" href="../../assets/css/voting.css">
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
                                        <a href="#">팀자랑</a>
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

                    <div id="content">
                        <div id="team-aside">
                            <h2>팀페이지</h2>
                            
                            <div class="team-list-section">
                                <!-- <h3>우리팀 목록</h3> -->
                                <a href="#" class="btn-outline3 teamlist-btn">팀 원밀리언</a>
                                <a href="#" class="btn-outline3 teamlist-btn">팀 저스트절크</a>
                            </div>
                            <a href="#" class="btn-outline2 teamadd-btn">팀 등록하기</a>
                        </div>

                        <div id="main-content">
                            <h2>팀 원밀리언</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                            <div class="team-wrote-wrap">
                                <div class="post-container">
                                    <div class="post-header">
                                        <h4 class="post-title">팀 원밀리언 연습일정 투표</h4>
                                    </div>
                                    <span class="post-date">2025-07-30</span>
                                    
                                    <div class="post-content">
                                        <p>다음 연습 일정 투표 진행합니다.</p>
                                        <p>모든 팀원 빠른 투표 부탁드립니다.</p>
                                    </div>

                                    <!-- ▼▼▼▼▼ 이 부분이 새로 추가된 투표 섹션입니다 ▼▼▼▼▼ -->
                                    <div class="vote-section-wrap">
                                        <ol class="vote-items-container">
                                            <!-- 투표 옵션 1 -->
                                            <li>
                                                <div class="vote-option">
                                                    <a href="#" class="vote-item-card">
                                                        <div class="favorite-count">🔥 6</div> 
                                                        <img src="../../assets/images/연습실사진01.jpg" alt="네스트 연습실">
                                                        <div class="card-content-wrapper">
                                                            <div class="card-main-info">
                                                                <div class="info-left">
                                                                    <p class="item-title">1. 네스트 연습실 101호</p>
                                                                    <p class="item-datetime">8/4(월) 15:00-17:00</p>
                                                                </div>
                                                                <div class="info-right">
                                                                    <p class="item-price">16,000 원</p>
                                                                </div>
                                                            </div>
                                                            <div class="card-sub-info">
                                                                <p class="item-info">실외화 가능/주차/최대7인</p>
                                                                <p class="item-location">
                                                                    <img src="../../assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <div class="vote-action-area">
                                                        <button type="button" class="btn-vote">투표</button>
                                                        <div class="voter-list">
                                                            <span>강수빈</span>
                                                            <span>이현진</span>
                                                            <span>신현석</span>
                                                            <span>정영민</span>
                                                            <span>정성찬</span>
                                                            <span>박원빈</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <!-- 투표 옵션 2 -->
                                            <li>
                                                <div class="vote-option">
                                                    <a href="#" class="vote-item-card">
                                                        <div class="favorite-count">🔥 3</div> 
                                                        <img src="../../assets/images/연습실사진02.jpg" alt="두번째 연습실">
                                                        <div class="card-content-wrapper">
                                                            <div class="card-main-info">
                                                                <div class="info-left">
                                                                    <p class="item-title">2. 퍼스트 연습실 A홀</p>
                                                                    <p class="item-datetime">8/4(월) 18:00-20:00</p>
                                                                </div>
                                                                <div class="info-right">
                                                                    <p class="item-price">18,000 원</p>
                                                                </div>
                                                            </div>
                                                            <div class="card-sub-info">
                                                                <p class="item-info">주차/최대15인</p>
                                                                <p class="item-location">
                                                                    <img src="../../assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <div class="vote-action-area">
                                                        <button type="button" class="btn-vote">투표</button>
                                                        <div class="voter-list">
                                                            <!-- 투표자가 없을 경우 이 영역은 비어있습니다. -->
                                                            <span>신현석</span>
                                                            <span>정영민</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                            <!-- 투표 옵션 3 -->
                                            <li>
                                                <div class="vote-option">
                                                    <a href="#" class="vote-item-card">
                                                        <div class="favorite-count">🔥 7</div> 
                                                        <img src="../../assets/images/연습실사진03.jpg" alt="세번째 연습실">
                                                        <div class="card-content-wrapper">
                                                            <div class="card-main-info">
                                                                <div class="info-left">
                                                                    <p class="item-title">3. 드림 스튜디오</p>
                                                                    <p class="item-datetime">8/5(화) 19:00-21:00</p>
                                                                </div>
                                                                <div class="info-right">
                                                                    <p class="item-price">15,000 원</p>
                                                                </div>
                                                            </div>
                                                            <div class="card-sub-info">
                                                                <p class="item-info">실외화 가능/최대5인</p>
                                                                <p class="item-location">
                                                                    <img src="../../assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </a>
                                                    <div class="vote-action-area">
                                                        <button type="button" class="btn-vote">투표</button>
                                                        <div class="voter-list">
                                                            <!-- 투표자가 없을 경우 이 영역은 비어있습니다. -->
                                                            <span>이현진</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ol>
                                    </div>
                                    <!-- ▲▲▲▲▲ 여기까지 투표 섹션입니다 ▲▲▲▲▲ -->

                                    <div class="post-actions">
                                        <button type="submit" id="btn-share" class="btn-action">공유하기</button>
                                        <a href="#" class="btn-action">바로 예약하기</a>
                                    </div>
                                </div>
                            </div>


                        </div>

                    </div>
<!-- ------------------------------------------------------------------------------------------------------ -->
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