<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 로그인</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
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

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   여기(main container)안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

<!-- 로그인 폼 시작 -->
	<div class="login-main">
	  <div class="login-wrap">
	    <h2 class="login-title">로그인</h2>
	</div>

  <div class="login-wrap">
    <button type="button" class="btn-kakao">
      <img src="${pageContext.request.contextPath}/assets/images/kakaotalk.jpg" alt="카카오톡" />
      카카오로 로그인
    </button>

    <div class="divider"><span>또는</span></div>

    <!-- ✅ 컨트롤러 매핑과 파라미터 이름을 정확히 맞춤 -->
    <form class="login-form"
          method="post"
          action="${pageContext.request.contextPath}/onespace/login">

	      <!-- ✅ name은 반드시 userId / password -->
	      <input type="text"     placeholder="아이디"   name="userId" />
	      <input type="password" placeholder="비밀번호" name="password" />
	
	      <div class="login-options">
	        <label class="remember">
	          <input type="checkbox" /> 로그인 기억하기
	        </label>
	        <span class="find-pw">비밀번호 찾기</span>
	      </div>
	
	      <button type="submit" class="btn-login-main">아이디로 로그인하기</button>
	
	      <div class="for-join">
	        아직 One Space 회원이 아니신가요?
	        <a href="${pageContext.request.contextPath}/onespace/signupForm">회원가입</a>
	      </div>
	
	      <!-- ✅ 에러 표시 (컨트롤러에서 ?error=1 로 보냄) -->
	      <c:if test="${param.error == '1'}">
	        <p class="error" style="margin-top:10px;">아이디 또는 비밀번호를 확인해주세요.</p>
	      </c:if>
    </form>
  </div>
</div>
<!-- 로그인 폼 끝 -->


                










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