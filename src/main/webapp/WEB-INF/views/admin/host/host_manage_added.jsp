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
              <c:import url="/WEB-INF/views/include/header.jsp" />
             <!-- /헤더 영역------------------------------------------------ -->




            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   여기(main container)안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

                    <!-- 탭 -->
                    <div class="tab-btns">
					  <button class="tab active" type="button"
					          onclick="location.href='${pageContext.request.contextPath}/onespace/hostcenter/info'">기본 정보 관리</button>
					  <button class="tab" type="button"
					          onclick="location.href='${pageContext.request.contextPath}/onespace/hostcenter/spaces'">내 공간 관리</button>
					</div>

                    <!-- 공간 카드 전체 -->
                    <div class="space-manage-container">
                        <h2 class="main-title">내 공간 관리</h2>

                        <%-- [변경] 빈/목록 분기 --%>
                        <c:choose>
                          <%-- [변경] 빈 상태: spaces가 비었을 때 버튼만 노출 --%>
                          <c:when test="${empty spaces}">
                            <div class="btn-wrapper">
                              <a href="${pageContext.request.contextPath}/onespace/hostcenter/info" class="btn-host-manage">새 공간 등록하기</a>
                            </div>
                          </c:when>

                          <%-- [변경] 목록 상태: spaces가 있을 때 카드 반복 렌더링 --%>
                          <c:otherwise>
                            <c:forEach var="space" items="${spaces}">
                              <div class="space-item">
                                <!-- 이미지: 임시 고정 이미지 (대표이미지 붙이면 교체) -->
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
                                      <div class="value"><c:out value="${space.spacename}" default="(이름 없음)"/></div>
                                    </div>
                                    <div class="row">
                                      <div class="label">주소</div>
                                      <div class="value"><c:out value="${space.address}" default=""/></div>
                                    </div>
                                    <%-- 면적/시설 안내는 컬럼 생기면 추가 --%>
                                  </div>

                                  <!-- 수정 버튼: info로 이동 (spacesno 전달) -->
                                  <div class="space-edit">
                                    <button class="btn-edit" type="button"
                                      onclick="location.href='${pageContext.request.contextPath}/onespace/hostcenter/info?spacesno=${space.spacesno}'">
                                      수정하기
                                    </button>
                                  </div>
                                </div>
                              </div>
                            </c:forEach>

                            <!-- 하단: 새 공간 추가 버튼 유지 -->
                            <div class="btn-wrapper">
                              <a href="${pageContext.request.contextPath}/onespace/hostcenter/info" class="btn-host-manage">새 공간 등록하기</a>
                            </div>
                          </c:otherwise>
                        </c:choose>
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