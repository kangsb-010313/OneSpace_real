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
            <c:import url="/WEB-INF/views/include/header.jsp" />
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
	  <a href="https://kauth.kakao.com/oauth/authorize?client_id=c46b2aca376b12ea792014ccacdcb09a&redirect_uri=http://localhost:8888/auth/kakao/callback&response_type=code"
	     class="btn-kakao">
	    <img src="${pageContext.request.contextPath}/assets/images/kakaotalk.jpg" alt="카카오톡" />
	    카카오로 로그인
	  </a>
	</div>


    <div class="divider"><span>또는</span></div>

    <form class="login-form"
          method="post"
          action="${pageContext.request.contextPath}/onespace/login">

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
              <c:import url="/WEB-INF/views/include/footer.jsp" />
             <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->
    </body>

</html>