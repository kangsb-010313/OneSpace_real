<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-투표만들기등록폼</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/asidedefault.css">
        <link rel="stylesheet" href="../../assets/css/makevote.css">
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
                            <h2>투표만들기</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                            <!-- ▼▼▼▼▼ 이 부분이 새로 추가된 공지 등록 폼입니다 ▼▼▼▼▼ -->
                            <div class="post-register-wrap">
                                <form action="#">
                                    <!-- 제목 입력 영역 -->
                                    <div class="form-group title-group">
                                        <label for="post-title">제목</label>
                                        <input type="text" id="post-title" placeholder="제목을 입력하세요">
                                    </div>

                                    <!-- ▼▼▼▼▼ '투표 목록' 섹션이 아래와 같이 수정되었습니다 ▼▼▼▼▼ -->
                                    <div class="form-group vote-list-group">
                                        <label>투표목록</label>
                                        <!-- div에서 ol(ordered list)로 변경하고, 각 항목을 li로 감쌉니다. -->
                                        <ol class="vote-items-container">
                                            <!-- 첫 번째 카드 -->
                                            <li>
                                                <a href="#" class="vote-item-card">
                                                    <img src="../../assets/images/연습실사진01.jpg" alt="네스트 연습실">
                                                    <!-- [변경] 카드 콘텐츠 구조 시작 -->
                                                    <div class="card-content-wrapper">
                                                        <div class="card-main-info">
                                                            <div class="info-left">
                                                                <p class="item-title">네스트 연습실 101호</p>
                                                                <!-- 투표 페이지에는 날짜/시간 정보가 없으므로 해당 p태그는 제외합니다. -->
                                                                 <p class="item-datetime">8/4(월) 15:00-17:00</p> 
                                                            </div>
                                                            <div class="info-right">
                                                                <p class="item-price">10,000 원</p> <!-- '최종가격' 텍스트 제거하고 숫자만 표시 -->
                                                            </div>
                                                        </div>
                                                        <div class="card-sub-info">
                                                            <p class="item-info">실외화 가능/주차/최대7인</p>
                                                            <p class="item-location">
                                                                <img src="../../assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <!-- [변경] 카드 콘텐츠 구조 끝 -->
                                                </a>
                                            </li>

                                            <!-- 두 번째 카드 -->
                                            <li>
                                                <a href="#" class="vote-item-card">
                                                    <img src="../../assets/images/연습실사진02.jpg" alt="네스트 연습실">
                                                    <div class="card-content-wrapper">
                                                        <div class="card-main-info">
                                                            <div class="info-left">
                                                                <p class="item-title">네스트 연습실 101호</p>
                                                                <p class="item-datetime">8/4(월) 15:00-17:00</p> 
                                                            </div>
                                                            <div class="info-right">
                                                                <p class="item-price">20,000 원</p>
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
                                            </li>

                                            <!-- 세 번째 카드 -->
                                            <li>
                                                <a href="#" class="vote-item-card">
                                                    <img src="../../assets/images/연습실사진03.jpg" alt="네스트 연습실">
                                                    <div class="card-content-wrapper">
                                                        <div class="card-main-info">
                                                            <div class="info-left">
                                                                <p class="item-title">네스트 연습실 101호</p>
                                                                <p class="item-datetime">8/4(월) 15:00-17:00</p> 
                                                            </div>
                                                            <div class="info-right">
                                                                <p class="item-price">25,000 원</p>
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
                                            </li>
                                        </ol>
                                    </div>
                                    <!-- ▲▲▲▲▲ 여기까지 '투표 목록' 영역입니다 ▲▲▲▲▲ -->

                                    <!-- 글 내용 및 파일 첨부 영역 -->
                                    <div class="form-group content-group">
                                        <div class="content-header">
                                            <label for="post-content">글내용</label>
                                            <div class="file-attach-section">
                                                <label for="file-upload" class="btn-file-attach">파일첨부</label>
                                                <input type="file" id="file-upload" multiple>
                                            </div>
                                        </div>
                                        <div class="content-box">
                                            <textarea id="post-content" placeholder="내용을 입력하세요"></textarea>
                                            <!-- 첨부된 파일 미리보기가 표시될 영역 -->
                                            <div id="file-preview-zone"></div>
                                        </div>
                                    </div>

                                    <!-- 하단 버튼 영역 -->
                                    <div class="form-actions">
                                        <a href="#" class="btn-cancel">취소</a>
                                        <button type="submit" class="btn-submit">등록</button>
                                    </div>
                                </form>
                            </div>
                            <!-- ▲▲▲▲▲ 여기까지가 공지 등록 폼입니다 ▲▲▲▲▲ -->




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