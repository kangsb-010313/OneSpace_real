<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>팀페이지-팀등록</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamadd.css">
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
                        
                        
                        
                        
<%--                             <h2>팀 등록하기</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

                            <!-- 팀 등록 폼 시작 -->
                            <div class="team-registration-form">
                                <form action="${pageContext.request.contextPath}/team/teamadd" method="get">
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

 --%>
 
						     <%-- ▼▼▼ 제목 동적 변경 ▼▼▼ --%>
						    <c:choose>
						        <c:when test="${not empty teamVO}">
						            <h2>팀 정보 수정</h2>
						        </c:when>
						        <c:otherwise>
						            <h2>팀 등록하기</h2>
						        </c:otherwise>
						    </c:choose>
						
						    <div class="team-registration-form">
						        <%-- ▼▼▼ form 태그 위치를 바깥으로 이동 ▼▼▼ --%>
						        <form method="post" 
						              action="${not empty teamVO ? pageContext.request.contextPath.concat('/team/teams/modify') : pageContext.request.contextPath.concat('/team/teamadd')}">
						            
						            <%-- 수정일 경우에만 hidden input 추가 --%>
						            <c:if test="${not empty teamVO}">
						                <input type="hidden" name="teamNo" value="${teamVO.teamNo}">
						            </c:if>
						
						            <div class="form-group">
						                <label for="team-name">팀 이름 <span class="red">*</span></label>
						                <input type="text" id="team-name" name="teamName" placeholder="팀 이름을 입력하세요." value="${teamVO.teamName}">
						            </div>
						            <div class="form-group">
						                <label for="team-insta">팀 인스타계정</label>
						                <input type="text" id="team-insta" name="instaAccount" placeholder="팀 인스타 계정을 첨부해주세요." value="${teamVO.instaAccount}">
						            </div>
						            <div class="form-actions">
						                <button type="submit" class="btn-submit">
						                    ${not empty teamVO ? '수정' : '등록'}
						                </button>
						            </div>
						        </form>
						    </div>
 
                        </div>
                        <!-- main-content -->
 
                    </div>
                    <!-- content -->
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