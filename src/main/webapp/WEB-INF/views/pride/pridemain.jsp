<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>원스페이스-팀자랑</title>
    <!-- CSS 연결 -->
    <link rel="stylesheet" href="<c:url value='/assets/css/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/basicdefault.css'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/pride.css'/>">

    <!-- 페이지네이션 disabled 스타일 (필요 시 pride.css로 옮겨도 됨) -->
    <style>
      .page-link.disabled{ pointer-events:none; opacity:.45; }
    </style>
</head>

<body>
<div id="wrap">

    <!-- 공통 헤더 -->
    <c:import url="/WEB-INF/views/include/header.jsp" />

    <!-- 컨텐츠 영역 -->
    <main>
        <div class="container">

            <section class="pride">
                <div class="main-head">
                    <h1>팀 자랑</h1>
                </div>

                <!-- 카드 그리드 -->
                <div class="team-grid">

                    <!-- 빈 목록 처리 -->
                    <c:if test="${empty list}">
                        <div class="empty-list">등록된 게시글이 없습니다.</div>
                    </c:if>

                    <!-- DB 카드 반복 -->
                    <c:forEach var="item" items="${list}">
                        <!-- 상세 링크: 현재 목록 상태(type/teamNo/page/size) 유지 -->
                        <c:url var="detailUrl" value="/pride/detail/${item.teamPostNo}">
                            <c:if test="${not empty teamPostType}">
                                <c:param name="type" value="${teamPostType}"/>
                            </c:if>
                            <c:if test="${not empty teamNo}">
                                <c:param name="teamNo" value="${teamNo}"/>
                            </c:if>
                            <c:param name="page" value="${page}"/>
                            <c:param name="size" value="${size}"/>
                        </c:url>

                        <!-- 썸네일: 없으면 기본 이미지 -->
                        <c:set var="thumb" value="${empty item.thumbnailUrl ? '/assets/images/default_team.jpg' : item.thumbnailUrl}" />

                        <article class="team-card">
                            <a class="card-link" href="${detailUrl}" aria-label="상세보기"></a>

                            <img class="team-thumb"
                                 loading="lazy"
                                 src="<c:url value='${thumb}'/>"
                                 alt="<c:out value='${item.teamName}'/> 이미지"
                                 onerror="this.onerror=null;this.src='<c:url value='/assets/images/default_team.jpg'/>';" />

                            <div class="team-info">
                                <h2 class="team-title"><c:out value="${item.teamPostTitle}"/></h2>
                                <p class="team-id"><c:out value="${item.instaAccount}"/></p>
                                <p class="team-desc"><c:out value='${item.teamContent}'/></p>
                            </div>
                        </article>
                    </c:forEach>
                    <!-- DB 카드 반복 끝 -->
                </div>
                <!-- 카드 그리드 끝 -->

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <!-- 처음 / 이전 : 1페이지면 안 보임 -->
                    <c:if test="${page > 1}">
                        <c:url var="firstUrl" value="/pride/list">
                            <c:param name="page" value="1"/>
                            <c:param name="size" value="${size}"/>
                            <c:if test="${not empty teamPostType}"><c:param name="type" value="${teamPostType}"/></c:if>
                            <c:if test="${not empty teamNo}"><c:param name="teamNo" value="${teamNo}"/></c:if>
                        </c:url>
                        <a class="page-link" href="${firstUrl}">« 처음</a>

                        <c:url var="prevUrl" value="/pride/list">
                            <c:param name="page" value="${page-1}"/>
                            <c:param name="size" value="${size}"/>
                            <c:if test="${not empty teamPostType}"><c:param name="type" value="${teamPostType}"/></c:if>
                            <c:if test="${not empty teamNo}"><c:param name="teamNo" value="${teamNo}"/></c:if>
                        </c:url>
                        <a class="page-link" href="${prevUrl}">‹ 이전</a>
                    </c:if>

                    <%-- 숫자 5개 고정 블록: startPage 기준으로 5칸 표시 --%>
                    <c:set var="blockEnd" value="${startPage + 4}"/>
                    <c:forEach var="p" begin="${startPage}" end="${blockEnd}">
                        <c:choose>
                            <%-- 존재하는 페이지면 링크 --%>
                            <c:when test="${p <= totalPages}">
                                <c:url var="pageUrl" value="/pride/list">
                                    <c:param name="page" value="${p}"/>
                                    <c:param name="size" value="${size}"/>
                                    <c:if test="${not empty teamPostType}"><c:param name="type" value="${teamPostType}"/></c:if>
                                    <c:if test="${not empty teamNo}"><c:param name="teamNo" value="${teamNo}"/></c:if>
                                </c:url>
                                <a class="page-link ${p==page ? 'active' : ''}" href="${pageUrl}">${p}</a>
                            </c:when>
                            <%-- 없는 페이지면 비활성 숫자 출력 --%>
                            <c:otherwise>
                                <span class="page-link disabled">${p}</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- 다음 / 마지막 : 마지막 페이지면 안 보임 -->
                    <c:if test="${page < totalPages}">
                        <c:url var="nextUrl" value="/pride/list">
                            <c:param name="page" value="${page+1}"/>
                            <c:param name="size" value="${size}"/>
                            <c:if test="${not empty teamPostType}"><c:param name="type" value="${teamPostType}"/></c:if>
                            <c:if test="${not empty teamNo}"><c:param name="teamNo" value="${teamNo}"/></c:if>
                        </c:url>
                        <a class="page-link" href="${nextUrl}">다음 ›</a>

                        <c:url var="lastUrl" value="/pride/list">
                            <c:param name="page" value="${totalPages}"/>
                            <c:param name="size" value="${size}"/>
                            <c:if test="${not empty teamPostType}"><c:param name="type" value="${teamPostType}"/></c:if>
                            <c:if test="${not empty teamNo}"><c:param name="teamNo" value="${teamNo}"/></c:if>
                        </c:url>
                        <a class="page-link" href="${lastUrl}">마지막 »</a>
                    </c:if>
                </div>

            </section>
        </div>
    </main>

    <!-- 푸터 -->
    <c:import url="/WEB-INF/views/include/footer.jsp" />

</div>
</body>
</html>
