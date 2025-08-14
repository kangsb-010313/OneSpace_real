<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스-메인화면</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/main.css">
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
                                <a href="#" class="btn-outline login-btn">로그인</a>
                                <div class="host-signup-group">
                                    <a href="#" class="btn-outline host-btn">호스트센터</a>
                                    <a href="#" class="btn-outline signup-btn">회원가입</a>
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
                    <!-- 검색창 START -->
                    <div class="search-bar">
                        <input type="text" placeholder="#찾는 공간이 있나요?">
                    </div>

                    <div class="space-list">
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진01.jpg" alt="퍼스트연습실">
                            <div class="card-content">
                                <div class="card-title">퍼스트 연습실</div>
                                <div class="card-price">7,000원 ~ 12,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        강동구 | 실외화 가능/ 주차/ 최대15인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진02.jpg" alt="넥스트연습실">
                            <div class="card-content">
                                <div class="card-title">네스트 연습실</div>
                                <div class="card-price">10,000원 ~ 17,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        광진구 | 최대 7인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진03.jpg" alt="퍼스트스튜디오">
                            <div class="card-content">
                                <div class="card-title">드림 스튜디오</div>
                                <div class="card-price">3,000원 ~ 7,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">   
                                        동대문구 | 실외화 가능/ 주차/ 최대 15인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진04.jpg" alt="퍼스트연습실2">
                            <div class="card-content">
                                <div class="card-title">픽스튜디오</div>
                                <div class="card-price">7,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        강동구 | 최대 7인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진05.jpg" alt="넥스트연습실2">
                            <div class="card-content">
                                <div class="card-title">넥스트 연습실</div>
                                <div class="card-price">10,000원 ~ 17,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        강동구 | 최대 5인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진06.jpg" alt="퍼스트스튜디오2">
                            <div class="card-content">
                                <div class="card-title">퍼스트스튜디오</div>
                                <div class="card-price">3,000원 ~ 7,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        동대문구 | 실외화 가능/ 주차/ 최대 20인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진07.jpg" alt="퍼스트연습실3">
                            <div class="card-content">
                                <div class="card-title">건대 네스트</div>
                                <div class="card-price">6,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        동대문구 | 실외화 가능/ 최대 7인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진08.jpg" alt="빅스튜디오">
                            <div class="card-content">
                                <div class="card-title">우리스튜디오</div>
                                <div class="card-price">8,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        광진구 | 주차/ 최대 15인
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- sapce-list -->

                    <h2 class="section-title">#우리팀 좀 보세요!</h2>
                    <div class="team-list">
                        
                            <a class="team-card" href="팀자랑_게시글1_URL">
                                <img src="../../assets/images/팀자랑사진01.jpg" alt="팀1" />
                            </a>
                            <a class="team-card" href="팀자랑_게시글2_URL">
                                <img src="../../assets/images/팀자랑사진02.jpg" alt="팀2" />
                            </a>
                            <a class="team-card" href="팀자랑_게시글3_URL">
                                <img src="../../assets/images/팀자랑사진03.jpg" alt="팀3" />
                            </a>
                            <a class="team-card" href="팀자랑_게시글4_URL">
                                <img src="../../assets/images/팀자랑사진04.jpg" alt="팀4" />
                            </a>
                            <a class="team-card" href="팀자랑_게시글1_URL">
                                <img src="../../assets/images/팀자랑사진01.jpg" alt="팀1" />
                            </a>
                            <a class="team-card" href="팀자랑_게시글2_URL">
                                <img src="../../assets/images/팀자랑사진02.jpg" alt="팀2" />
                            </a>
                            
                        <!-- 필요 개수만큼 추가 -->
                    </div>

                </div>
                <!-- container -->

            </main>




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