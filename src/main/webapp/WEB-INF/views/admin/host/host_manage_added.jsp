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

<c:url var="urlSpacesNew"  value="/onespace/hostcenter/spaces/new"/>
<c:url var="urlSpacesList" value="/onespace/hostcenter/spaces"/>
<c:url var="urlSpaceInfo"  value="/onespace/hostcenter/info"/>

<!-- 탭 -->
<div class="tab-btns">
  <button class="tab"        type="button" onclick="location.href='${urlSpacesNew}'">기본 정보 관리</button>
  <button class="tab active" type="button" onclick="location.href='${urlSpacesList}'">내 공간 관리</button>
</div>

<!-- 공간 카드 전체 -->
<div class="space-manage-container">
  <h2 class="main-title">내 공간 관리</h2>

  <c:choose>
    <c:when test="${empty spaces}">
      <div class="btn-wrapper">
        <a href="${urlSpacesNew}" class="btn-host-manage">새 공간 등록하기</a>
      </div>
    </c:when>

    <c:otherwise>
      <c:forEach var="space" items="${spaces}">
        <div class="space-item">
          <!-- ✅ 변경: repimg가 있을 때만 업로드 이미지 출력 (디폴트 이미지 사용 안 함) -->
          <c:if test="${not empty space.repimg}">
			  <img class="space-thumb"
			       src="${pageContext.request.contextPath}/uploads/${space.repimg}"
			       alt="공간 사진"/>
		 </c:if>

          <div class="space-contents">
            <div class="space-info">
              <div class="row">
                <div class="label">공간명</div>
                <div class="value"><c:out value="${space.spacename}" default="(이름 없음)"/></div>
              </div>
              <div class="row">
                <div class="label">주소</div>
				 <div class="value">
				   <c:out value="${space.address}" default=""/> <c:out value="${space.addressdetail}" default=""/>
				 </div>
              </div>
            </div>

            <div class="space-edit">
             <button class="btn-edit" type="button"
			        onclick="location.href='${pageContext.request.contextPath}/onespace/hostcenter/rooms/${room.roomNo}/edit?spacesNo=${room.spacesNo}'">
			  수정하기
			</button>

            </div>
          </div>
        </div>
      </c:forEach>

      <div class="btn-wrapper">
        <a href="${urlSpacesNew}" class="btn-host-manage">새 공간 등록하기</a>
      </div>
    </c:otherwise>
  </c:choose>
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
