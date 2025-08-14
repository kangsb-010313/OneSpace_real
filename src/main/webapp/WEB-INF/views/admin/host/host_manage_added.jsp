<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 내 공간 관리</title>
        <link rel="stylesheet" href="../../../assets/css/reset.css">
        <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../../assets/css/host_manage_added.css">
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

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   여기(main container)안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

                    <!-- 탭 -->
                    <div class="tab-btns">
                        <button class="tab active">기본 정보 관리</button>
                        <button class="tab">내 공간 관리</button>
                    </div>

                    <!-- 공간 카드 전체 -->
                    <div class="space-manage-container">
                        <h2 class="main-title">내 공간 관리</h2>

                        <!-- 공간 카드 1 -->
                        <div class="space-item">
                            <!-- 이미지 -->
                            <img
                              class="space-thumb"
                              src="../../../assets/images/room1.jpg"
                              alt="공간 사진"
                            />
                          
                            <!-- 정보 + 버튼 -->
                            <div class="space-contents">
                              <!-- 정보 -->
                              <div class="space-info">
                                <div class="row">
                                  <div class="label">공간명</div>
                                  <div class="value">연습실 1</div>
                                </div>
                                <div class="row">
                                  <div class="label">주소</div>
                                  <div class="value">서울특별시 강남구 87번길 6 B1 102호</div>
                                </div>
                                <div class="row">
                                  <div class="label">공간 면적</div>
                                  <div class="value">165㎡</div>
                                </div>
                                <div class="row">
                                  <div class="label">시설 안내</div>
                                  <div class="value">주차, 실외화, 실내 화장실, 스피커</div>
                                </div>
                              </div>
                          
                              <!-- 수정 버튼 -->
                              <div class="space-edit">
                                <button class="btn-edit">수정하기</button>
                              </div>
                            </div>
                          </div>

                        <!-- 공간 카드 2 -->
                        <div class="space-item">
                            <!-- 이미지 -->
                            <img
                              class="space-thumb"
                              src="../../../assets/images/room1.jpg"
                              alt="공간 사진"
                            />

                            <!-- 정보 + 버튼 -->
                            <div class="space-contents">
                              <!-- 정보 -->
                              <div class="space-info">
                                <div class="row">
                                  <div class="label">공간명</div>
                                  <div class="value">연습실 2</div>
                                </div>
                                <div class="row">
                                  <div class="label">주소</div>
                                  <div class="value">서울특별시 강남구 87번길 6 B1 102호</div>
                                </div>
                                <div class="row">
                                  <div class="label">공간 면적</div>
                                  <div class="value">165㎡</div>
                                </div>
                                <div class="row">
                                  <div class="label">시설 안내</div>
                                  <div class="value">주차, 실외화, 실내 화장실, 스피커</div>
                                </div>
                              </div>
                          
                              <!-- 수정 버튼 -->
                              <div class="space-edit">
                                <button class="btn-edit">수정하기</button>
                              </div>
                            </div>
                          </div>

                        <!-- 공간 카드 3 -->
                        <div class="space-item">
                          <!-- 이미지 -->
                          <img
                            class="space-thumb"
                            src="../../../assets/images/room1.jpg"
                            alt="공간 사진"
                          />
                        
                          <!-- 정보 + 버튼 -->
                          <div class="space-contents">
                            <!-- 정보 -->
                            <div class="space-info">
                              <div class="row">
                                <div class="label">공간명</div>
                                <div class="value">연습실 3</div>
                              </div>
                              <div class="row">
                                <div class="label">주소</div>
                                <div class="value">서울특별시 강남구 87번길 6 B1 102호</div>
                              </div>
                              <div class="row">
                                <div class="label">공간 면적</div>
                                <div class="value">165㎡</div>
                              </div>
                              <div class="row">
                                <div class="label">시설 안내</div>
                                <div class="value">주차, 실외화, 실내 화장실, 스피커</div>
                              </div>
                            </div>
                        
                            <!-- 수정 버튼 -->
                            <div class="space-edit">
                              <button class="btn-edit">수정하기</button>
                            </div>
                          </div>
                        </div>
                        

                        <!-- 버튼 -->
                        <div class="btn-wrapper">
                        <a href="#" class="btn-host-manage">새 공간 등록하기</a>
                        </div>
                    </div>     










<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

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