<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-메인화면</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/asidedefault.css">
        <link rel="stylesheet" href="../../assets/css/teammain.css">
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

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

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
                            <h2>팀 일정</h2>
                            <div class="team-schedule-search-box">
                                <form class="team-schedule-search-form">
                                    <input type="text" placeholder="검색어를 입력해주세요." class="team-schedule-input">
                                    <button type="submit" class="team-schedule-btn">검색</button>
                                </form>
                            </div>

                            <div id="team-schedule-list">
                                <table>
                                    <colgroup>
                                        <col style="width:130px">
                                        <col style="width:730px">
                                        <col style="width:100px">
                                    
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>작성팀</th>
                                            <th>제목</th>
                                            <th>작성일</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <td>팀 원밀리언</td>
                                            <td>팀 원밀리언 연습 후기</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        <tr>
                                            <td>팀 원밀리언</td>
                                            <td>팀 원밀리언 새벽연습 관련 공지글입니다.</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        <tr>
                                            <td>팀 저스트절크</td>
                                            <td>팀 저스트절크 연습일정 투표</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        <tr>
                                            <td>팀 원밀리언</td>
                                            <td>팀 원밀리언 연습일정 확인</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        <tr>
                                            <td>팀 원밀리언</td>
                                            <td>팀 원밀리언 연습일정 투표</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        <tr>
                                            <td>팀 저스트절크</td>
                                            <td>팀 저스트절크 등록되었습니다.</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        <tr>
                                            <td>팀 원밀리언</td>
                                            <td>팀 원밀리언 등록되었습니다.</td>
                                            <td>2025-07-30</td>
                                        </tr>
                                        
                                    </tbody>

                                </table>

                            </div>

                            <div class="load-more-container">
                                <button id="load-more-btn">더보기</button>
                            </div>

                        </div>

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