<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-예약확정화면</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/finreservation.css">
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
                                        <h4 class="post-title">팀 원밀리언 연습일정 확인</h4>
                                    </div>
                                    <span class="post-date">2025-07-30</span>
                                    
                                    <div class="post-content">
                                        <!-- ▼▼▼▼▼ 예약 페이지 전체 컨테이너 ▼▼▼▼▼ -->
                                        <div class="reservation-page-wrap">
                                            
                                            <!-- 좌측: 선택된 연습실 정보 -->
                                            <div class="left-column">
                                                <h3 class="section-title">#예약 연습실 보러가기</h3>
                                                <!-- ▼▼▼▼▼ 이 부분을 투표 페이지의 카드와 동일한 구조로 변경 ▼▼▼▼▼ -->
                                                <div class="vote-option">
                                                    <a href="#" class="vote-item-card">
                                                        <img src="../../assets/images/연습실사진01.jpg" alt="네스트 연습실">
                                                        <div class="card-content-wrapper">
                                                            <div class="card-main-info">
                                                                <div class="info-left">
                                                                    <p class="item-title">네스트 연습실 101호</p>
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
                                                </div>
                                                <!-- ▲▲▲▲▲ 카드 구조 변경 끝 ▲▲▲▲▲ -->
                                                
                                                <h3 class="section-title">#이 연습일정에 투표한 멤버들</h3>
                                                <div class="voted-members">
                                                    <span>강수빈</span>
                                                    <span>이현진</span>
                                                    <span>신현석</span>
                                                    <span>정영민</span>
                                                </div>
                                            </div>

                                            <!-- 우측: 예약 및 결제 정보 -->
                                            <div class="right-column">
                                                <div class="reservation-details">
                                                    <h3>예약정보</h3>
                                                    <ul class="reservation-info-list">
                                                        <li>
                                                            <span class="label">예약자명</span>
                                                            <span class="value">강수빈</span>
                                                        </li>
                                                        <li>
                                                            <span class="label">예약인원</span>
                                                            <span class="value">4명</span>
                                                        </li>
                                                        <li>
                                                            <span class="label">예약날짜</span>
                                                            <span class="value">8/4(월) 15:00~17:00</span>
                                                        </li>
                                                    </ul>
                                                </div>

                                                <div class="refund-policy">
                                                    <h3>환불규정안내</h3>
                                                    <p>이용 2일전: 총 금액의 100% 환불</p>
                                                    <p>이용 전날~당일: 환불 불가</p>
                                                </div>
                                                
                                                <div class="final-amount">
                                                    <span>총 금액</span>
                                                    <span class="amount-value">20,000 원</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ▲▲▲▲▲ 예약 페이지 전체 컨테이너 끝 ▲▲▲▲▲ -->
                                    </div>


                                    <div class="payment-action">
                                        <button type="submit" class="btn-payment">공유하기</button>
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