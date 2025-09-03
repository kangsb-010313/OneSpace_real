<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>원스페이스 | 내 공간 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/host_manage_added.css">
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
		      <button class="tab active" type="button" onclick="location.href='${pageContext.request.contextPath}/host/spaces/new'">기본 정보 관리</button>
		      <button class="tab"        type="button" onclick="location.href='${pageContext.request.contextPath}/host/rooms/list'">내 공간 관리</button>
	        </div>

            <!-- 공간 카드 전체 -->
            <div class="space-manage-container">
               <h2 class="main-title">내 공간 관리</h2>

               <c:forEach var="roomVO" items="${roomList}">
                  <div class="space-item">
                     <img class="space-thumb" src="${pageContext.request.contextPath}/uploads/${roomVO.thumbImg}" alt="공간 사진" />

                     <div class="space-contents">
                        <div class="space-info">
                           <div class="row">
                              <div class="label">공간명</div>
                              <div class="value">
                                 ${roomVO.roomName}
                              </div>
                           </div>
                           <div class="row">
                              <div class="label">소개</div>
                              <div class="value">
                                 ${roomVO.roomInfo}
                              </div>
                           </div>
                           <div class="row">
                              <div class="label">면적</div>
                              <div class="value">
                                 ${roomVO.area}
                              </div>
                           </div>
                           
                        </div>

                        <div class="space-edit">
                           <a href="" class="btn-edit">수정하기</button>
                           </a>
                        </div>
                     </div>
                  </div>
               </c:forEach>
   
                  <div class="btn-wrapper">
                     <a href="${pageContext.request.contextPath}/host/rooms/new" class="btn-host-manage">새 공간 등록하기</a>
                  </div>
            </div>

            <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

         </div>
      </main>
      <!-- /컨텐츠 영역---------------------------------------------- -->

      <!-- 푸터 영역------------------------------------------------ -->
      <c:import url="/WEB-INF/views/include/footer.jsp" />
      <!-- /푸터 영역------------------------------------------------ -->

   </div>
</body>
</html>
