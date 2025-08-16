<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 회원가입</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/signup.css">
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
<!-- MAIN (회원가입 폼) -->
    
      
    <div class="signup-main">
        <div class="signup-wrap">
            <h2 class="signup-title">회원가입</h2>
        </div>
        <div class="signup-wrap">
            <form class="signup-form">
                <input type="text" placeholder="이름" name="name" />
                <input type="text" placeholder="아이디" name="id" />
                <input type="email" placeholder="이메일" name="email" />
                <input type="password" placeholder="비밀번호" name="pw" />
                <div class="pw-rule">-문자/숫자/특수문자 중 2가지 이상 조합 (8~30자)</div>
                <input type="password" placeholder="비밀번호 확인" name="pw_confirm" />
                
                <!-- 체크박스 영역 -->
                <div class="checkbox-area">
                    <!-- ... 기존 체크박스들 ... -->
                </div>

                <button type="submit" class="btn-join">회원가입</button>

                <div class="divider"><span>또는</span></div>

                <button type="button" class="btn-kakao">
                    <img src="../../../assets/images/kakaotalk.jpg" /> 카카오로 회원가입
                </button>
            </form>
        </div>
    </div>







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