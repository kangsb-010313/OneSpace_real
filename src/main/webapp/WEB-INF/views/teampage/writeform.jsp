<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-일반공지등록폼</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamwriteform.css">
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
                            <h2>일반공지등록</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                            <!-- ▼▼▼▼▼ 이 부분이 새로 추가된 공지 등록 폼입니다 ▼▼▼▼▼ -->
                            <div class="post-register-wrap">
                                <form action="${pageContext.request.contextPath}/onespace/teamwriteadd" method="get">
                                    <!-- 제목 입력 영역 -->
                                    <div class="form-group title-group">
                                        <label for="post-title">제목</label>
                                        <input type="text" id="post-title" name="teamPostTitle" placeholder="제목을 입력하세요">
                                    </div>

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
                                            <textarea id="post-content" name="teamContent" placeholder="내용을 입력하세요"></textarea>
                                            <!-- 첨부된 파일 미리보기가 표시될 영역 -->
                                            <div id="file-preview-zone"></div>
                                        </div>
                                    </div>

                                    <!-- 하단 버튼 영역 -->
                                    <div class="form-actions">
                                        <a href="${pageContext.request.contextPath}/onespace/list" class="btn-cancel">취소</a>
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