<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

  <head>
    <meta charset="UTF-8">
    <title>원스페이스 | 공연 및 대회 정보</title>
    <link rel="stylesheet" href="../../../assets/css/reset.css">
    <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
    <link rel="stylesheet" href="../../../assets/css/perforlist.css">
  </head>

  <body>
    <div id="wrap">

      <!-- 헤더 영역------------------------------------------------ -->
      <c:import url="/WEB-INF/views/include/header.jsp" />
      <!-- /헤더 영역------------------------------------------------ -->

      <!-- 컨텐츠 영역---------------------------------------------- -->
      <main>
        <div class="container">

          <h2 class="perforlist-title">공연 및 대회 정보</h2>

          <div class="perforlist-list">
            <table class="perforlist-table">
              <colgroup>
                <col style="width:120px" />
                <col />
                <col style="width:160px" />
              </colgroup>
              <thead>
                <tr>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>마감일</th>
                </tr>
              </thead>

              <c:choose>
                <c:when test="${not empty list}">
                  <tbody>
                    <c:forEach var="item" items="${list}">
                      <tr>
                        <td class="cate">[<c:out value="${item.infoPostType}" />]</td>

                        <c:url var="viewUrl" value="/onespace/perforinfo/view">
                          <c:param name="no" value="${item.infoPostNo}" />
                        </c:url>
                        <td class="tit">
                          <a href="${viewUrl}">
                            <c:out value="${item.infoPostTitle}" />
                          </a>
                        </td>

                        <td class="date"><c:out value="${item.deadlineDate}" /></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </c:when>
                <c:otherwise>
                  <tbody>
                    <tr><td colspan="3" class="empty">등록된 정보가 없습니다.</td></tr>
                  </tbody>
                </c:otherwise>
              </c:choose>
            </table>
          </div>

          <!-- 글쓰기 버튼: 로그인 사용자에게만 보이게 -->
          <div class="btn-area">
            <c:if test="${not empty sessionScope.authUser or not empty sessionScope.authUserNo}">
              <a href="<c:url value='/onespace/perforinfo/writeForm'/>" class="btn-write">글쓰기</a>
            </c:if>
          </div>

          <!-- 페이지네이션 -->
          <nav class="pagination" aria-label="페이지네이션">
            <c:if test="${hasPrev}">
              <c:url var="prevUrl" value="/onespace/perforinfo/list">
                <c:param name="page" value="${page-1}" />
                <c:param name="size" value="${size}" />
              </c:url>
              <a class="page-plain" href="${prevUrl}">◀</a>
            </c:if>

            <c:forEach var="p" begin="${blockStart}" end="${blockEnd}">
              <c:choose>
                <c:when test="${p == page}">
                  <span class="page-plain is-active">${p}</span>
                </c:when>
                <c:otherwise>
                  <c:url var="pageUrl" value="/onespace/perforinfo/list">
                    <c:param name="page" value="${p}" />
                    <c:param name="size" value="${size}" />
                  </c:url>
                  <a class="page-plain" href="${pageUrl}">${p}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>

            <c:if test="${hasNext}">
              <c:url var="nextUrl" value="/onespace/perforinfo/list">
                <c:param name="page" value="${page+1}" />
                <c:param name="size" value="${size}" />
              </c:url>
              <a class="page-plain" href="${nextUrl}">▶</a>
            </c:if>
          </nav>

        </div>
      </main>

      <!-- 푸터 -->
      <jsp:include page="/WEB-INF/views/include/footer.jsp" />
    </div>
  </body>
</html>
