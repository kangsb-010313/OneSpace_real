<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 기본정보</title>
        <link rel="stylesheet" href="../../../assets/css/reset.css">
        <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../../assets/css/host_info.css">
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

                <!-- 타이틀 & 밑줄 -->
                <div class="main-title-box">
                  <h2 class="main-title">기본정보</h2>
                </div>
                <!-- 안내문구 & 체크박스 -->
                <div class="maininfo-row">
                  <div class="maininfo-guide">공간 정보를 입력해주세요.</div>
                  <label class="maininfo-hide-label">
                    검색창에 가려지기
                    <input type="checkbox" class="maininfo-hide-chk">
                  </label>
                </div>
                <!-- 회색 밑줄 -->
                <div class="main-bottomline"></div>

                <!-- 입력 폼 -->
                <form>
                  <!-- 공간정보 -->
                  <section class="form-section">
                    <div class="input-group">
                      <label for="space-name">공간명</label>
                      <span class="char-count">1자/18자</span>
                      <input id="space-name" type="text" maxlength="18" placeholder="고유 업체명을 입력해주세요. (예: 인디워커스 하이브 회의실)">
                    </div>
                    <div class="input-group">
                      <label for="space-desc">공간 한 줄 소개</label>
                      <span class="char-count">0자/200자</span>
                      <input id="space-desc" type="text" maxlength="500" placeholder="공간의 특징점을 한 문장으로 작성해주세요.">
                    </div>
                    <div class="input-group">
                      <label for="space-detail">공간소개</label>
                      <span class="char-count">0자/500자(최소 20자)</span>
                      <textarea id="space-detail" rows="4" maxlength="500" placeholder="게스트들에게 필요한 공간 정보를 상세하게 소개해주세요."></textarea>
                    </div>
                  </section>
                  <!-- 시설 안내 -->
                  <section class="form-section">
                    <div class="section-title">시설 안내</div>
                    <div class="facility-list">
                      <label><input type="checkbox">음향/마이크</label>
                      <label><input type="checkbox">의자/테이블</label>
                      <label><input type="checkbox">화이트 보드</label>
                      <label><input type="checkbox">전신 거울</label>
                      <label><input type="checkbox">조명</label>
                      <label><input type="checkbox">탈의실</label>
                      <label><input type="checkbox">주차</label>
                      <label><input type="checkbox">인터넷/WIFI</label>
                      <label><input type="checkbox">TV/프로젝터</label>
                      <label><input type="checkbox">내부 화장실</label>
                      <label><input type="checkbox">금연</label>
                      <label><input type="checkbox">장비 대여</label>
                      <label><input type="checkbox">실외화 가능</label>
                      <label><input type="checkbox">외부음식 반입 금지</label>
                    </div>
                  </section>
                  <!-- 환불 규정 -->
                  <section class="form-section">
                    <div class="refund-row">
                      <div>
                        <b class="refund-title">환불 규정</b>
                        <ul class="refund-list">
                          <li>- 이용 2일 전: 결제 금액 100% 환불 가능</li>
                          <li>- 이용 전날~당일: 환불 불가</li>
                        </ul>
                    </div>

                      <label class="refund-check">
                        <input type="checkbox"> 환불 규정을 확인하고 이해했습니다.
                      </label>
                    </div>
                  </section>
                  <!-- 대표 이미지 -->
                  <section class="form-section img-section">
                    <div class="img-header">
                      <div class="section-title">대표 이미지</div>
                      <span class="img-guide">2048 * 1158 권장, 최대 3MB <br>이미지 파일(JPG, PNG, JPEG)</span>
                    </div>
                    <div class="img-box">
                      <b>대표 이미지 등록 불가 유형</b>
                      <ul>
                        <li>- 텍스트, 로고, 도형이 합성된 이미지</li>
                        <li>- 여러 이미지를 합성한 콜라주 이미지</li>
                        <li>- 홍보물, 포스터 이미지</li>
                        <li>- 지도 이미지</li>
                        <li>- 노출 등 제 3자에게 수치심을 주는 이미지</li>
                      </ul>
                    </div>
                    
                   <div class="attach-btn-wrap">
                    <label class="btn-solid attach-btn">
                      파일첨부
                      <input type="file" hidden>
                    </label>
                  </div>
                  
                  </section>
                  <!-- 주소 -->
                  <section class="form-section">
                    <div class="section-title">주소(위치)</div>
                    <div class="addr-alert">
                        공간 주소는 최초 등록 이후 직접 변경할 수 없습니다.
                        <a href="#" class="blue-link">고객센터</a>를 통해 주소 변경을 요청해주세요.
                    </div>

                    <div class="addr-row">
                      <input type="text" class="addr-input-long" placeholder="실제 서비스되는 공간의 주소를 입력해주세요.">
                      <button class="addr-btn">주소 등록</button>
                    </div>
                    <input type="text" class="addr-detail" placeholder="상세 주소">
                  </section>

                  <!-- 연락처 이메일 -->
                  <section class="contact-section">
                    <div class="section-title">연락처 정보를 입력해 주세요.</div>
                    <div class="contact-flex">
                        <div class="email-row">
                          <label>이메일</label>
                          <div class="email-inputs">
                            <input type="text" class="email-id">
                            <span class="at">@</span>
                            <input type="text" class="email-domain">
                            <select class="email-select">
                              <option>직접입력</option>
                              <option>gmail.com</option>
                              <option>naver.com</option>
                              <option>hanmail.net</option>
                              <option>daum.net</option>
                              <option>hotmail.com</option>
                              <option>nate.com</option>
                              <option>icloud.com</option>
                            </select>
                          </div>
                        </div>

                    </div>
                    <!--전화-->
                    <div class="phone-flex-row">
                        <div class="phone-col">
                            <label>휴대폰</label>
                            <input type="text" placeholder="하이픈 빼고 입력해주세요.">
                        </div>
                        <div class="phone-col">
                            <label class="phone-label-bold">
                              대표전화
                              <span class="same-phone">
                                <input type="checkbox" id="same-phone">
                                <span class="chk-label">휴대폰과 동일</span>
                              </span>
                            </label>
                            <input type="text" placeholder="하이픈 빼고 입력해주세요.">
                        </div>
                    </div>
                    <div class="phone-desc">해당 휴대폰으로 예약 관련 알림톡을 받아 보실 수 있습니다.</div>

                  </section>
                  <!-- 버튼 -->
                  <div class="btn-row">
                    <button class="btn prev-btn">이전</button>
                    <button class="btn save-btn">저장</button>
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