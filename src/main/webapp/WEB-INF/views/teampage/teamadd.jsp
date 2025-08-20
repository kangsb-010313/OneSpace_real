<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-팀등록</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/asidedefault.css">
        <link rel="stylesheet" href="../../assets/css/teamadd.css">
    </head>

    <body>
        <div id="wrap">

            <!-- 헤더 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->





            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

                    <div id="content">
                    
	                	<!-- 팀페이지 aside ---------------------------------------------->
						<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
						<!-- 팀페이지 aside ---------------------------------------------->

                        <div id="main-content">
                            <h2>팀 등록하기</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

                            <!-- 팀 등록 폼 시작 -->
                            <div class="team-registration-form">
                                <form action="${pageContext.request.contextPath}/onespace/teamadd" method="get">
                                    <div class="form-group">
                                        <label for="team-name">팀 이름 <span class="red">*</span></label>
                                        <input type="text" id="team-name" name="teamName" placeholder="팀 이름을 입력하세요.">
                                    </div>
                                    <div class="form-group">
                                        <label for="team-insta">팀 인스타계정</label>
                                        <input type="text" id="team-insta" name="instaAccount" placeholder="팀 인스타 계정을 첨부해주세요.">
                                    </div>
                                    <div class="form-actions">
                                        <button type="submit" class="btn-submit">등록</button>
                                    </div>
                                </form>
                            </div>
                            <!-- 팀 등록 폼 끝 -->

                        </div>

                    </div>
<!-- ------------------------------------------------------------------------------------------------------ -->
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