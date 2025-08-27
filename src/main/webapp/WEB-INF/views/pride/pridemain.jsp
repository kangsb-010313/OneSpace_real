<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스-팀자랑</title>
        <link rel="stylesheet" href="<c:url value='/assets/css/reset.css'/>">
		<link rel="stylesheet" href="<c:url value='/assets/css/basicdefault.css'/>">
		<link rel="stylesheet" href="<c:url value='/assets/css/pride.css'/>">
    </head>

    <body>
        <div id="wrap">

            <!-- 헤더 영역------------------------------------------------ -->
           <c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->





            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

                  <section class="pride">
                    <div class="main-head">
                      <h1>팀 자랑</h1>
                    </div>

                    <div class="team-grid">
            <!-- 카드 1 -->
            <article class="team-card">
            	<a class="card-link" href="<c:url value='/pride/detail/1'/>" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀 연습 사진01.jpg" alt="팀 원밀리언 프로필 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 원밀리언</h2>
                <p class="team-id">@1milliondance</p>
                <p class="team-desc">#mood #느좋연습실 #조명좋음 #원밀리언</p>
              </div>
            </article>

            <!-- 카드 2 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진02.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 아우라</h2>
                <p class="team-id">@aura_official</p>
                <p class="team-desc">#힙합 #단체군무 #에너지</p>
              </div>
            </article>

            <!-- 카드 3 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진03.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 네오스</h2>
                <p class="team-id">@neos_dance</p>
                <p class="team-desc">#걸리시 #하이틴무드 #컨셉촬영</p>
              </div>
            </article>

            <!-- 카드 4 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진04.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 비전</h2>
                <p class="team-id">@vision.crew</p>
                <p class="team-desc">#코레오 #뮤비커버 #영상팀</p>
              </div>
            </article>

            <!-- 카드 5 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진05.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 모션</h2>
                <p class="team-id">@motion_kr</p>
                <p class="team-desc">#팝핀 #프리스타일 #배틀러</p>
              </div>
            </article>

            <!-- 카드 6 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진06.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 플레인</h2>
                <p class="team-id">@plane.dance</p>
                <p class="team-desc">#재즈 #테크닉 #무대연출</p>
              </div>
            </article>

            <!-- 카드 7 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진07.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 하이드</h2>
                <p class="team-id">@hide.musical</p>
                <p class="team-desc">#뮤지컬 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 8 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/댄스팀연습사진08.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 코브라</h2>
                <p class="team-id">@cobra.dnace</p>
                <p class="team-desc">#현대무용 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 9 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/팀자랑사진04.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 다이아몬드</h2>
                <p class="team-id">@diamond.dnace</p>
                <p class="team-desc">#칼군무 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 10 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/팀자랑사진02.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 플라워</h2>
                <p class="team-id">@flower.dnace</p>
                <p class="team-desc">#현대무용 #웅장함 #무대연출</p>
              </div>
            </article>

            <!-- 카드 11 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/팀자랑사진03.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 JP</h2>
                <p class="team-id">@japan.dnace</p>
                <p class="team-desc">#댄스 #일본 #무대연출</p>
              </div>
            </article>

            <!-- 카드 12 -->
            <article class="team-card">
            	<a class="card-link" href="/pride/detail/1" aria-label="상세보기"></a>
              <img src="../../assets/images/팀자랑사진01.jpg" alt="팀 이미지" />
              <div class="team-info">
                <h2 class="team-title">팀 엘레강스</h2>
                <p class="team-id">@Elegant.dnace</p>
                <p class="team-desc">#발레 #우아함 #무대연출</p>
              </div>
            </article>

                </div>

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