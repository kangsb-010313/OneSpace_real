<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀페이지-메인</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teammain.css">
</head>
<body>
    <div id="wrap">

        <!-- 헤더 영역------------------------------------------------ -->
        <c:import url="/WEB-INF/views/include/header.jsp" />
        <!-- /헤더 영역------------------------------------------------ -->

        <!-- 컨텐츠 영역 -->
        <main>
            <div class="container">
                <div id="content">

	               	<!-- 팀페이지 aside ---------------------------------------------->
					<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
					<!-- 팀페이지 aside ---------------------------------------------->

                    <!-- Main Content: 모든 팀 게시글 동적 생성 -->
                    <div id="main-content">
                        <h2>팀 일정</h2>
                        <div class="team-schedule-search-box">
                            <form class="team-schedule-search-form">
                                <input type="text" placeholder="검색어를 입력해주세요." class="team-schedule-input">
                                <button type="submit" class="team-schedule-btn">검색</button>
                            </form>
                        </div>

                        <div id="team-schedule-list">
                            <table>
                                <colgroup>
                                    <col style="width:130px">
                                    <col style="width:730px">
                                    <col style="width:100px">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>작성팀</th>
                                        <th>제목</th>
                                        <th>작성일</th>
                                    </tr>
                                </thead>
                                <tbody id="post-list-body">
                                    <c:choose>
                                        <c:when test="${not empty allPostsList}">
                                            <c:forEach items="${allPostsList}" var="post">
                                                <tr>
                                                    <td>${post.teamName}</td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/team/teams/${post.teamNo}/posts/${post.teamPostNo}">${post.teamPostTitle}</a>
                                                    </td>
                                                    <td>${post.teamWriteDate}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3">아직 작성된 게시글이 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <div class="load-more-container">
                            <button id="load-more-btn">더보기</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- 푸터 영역------------------------------------------------ -->
		<c:import url="/WEB-INF/views/include/footer.jsp" />
        <!-- /푸터 영역------------------------------------------------ -->

    </div>
    
    <script>
	$(document).ready(function() {
	    // 1. 보여줄 게시글의 초기 개수와, 한 번에 몇 개씩 더 보여줄지 설정합니다.
	    const itemsPerPage = 10;
	    let itemsShown = itemsPerPage;
	
	    // 2. tbody 안에 있는 모든 행(tr)을 가져옵니다.
	    const allRows = $("#post-list-body tr");
	    const totalRows = allRows.length;
	
	    // 3. 처음에는 설정된 개수(10개)만큼만 보여주고 나머지는 숨깁니다.
	    allRows.hide(); // 모든 행을 일단 숨기고
	    allRows.slice(0, itemsShown).show(); // 0번째부터 10번째까지만 보여줍니다.
	
	    // 4. 게시글이 10개 이하이면 '더보기' 버튼을 처음부터 숨깁니다.
	    if (totalRows <= itemsPerPage) {
	        $("#load-more-btn").hide();
	    }
	
	    // 5. '더보기' 버튼 클릭 이벤트
	    $("#load-more-btn").on("click", function() {
	        // 다음에 보여줄 게시글의 끝 인덱스를 계산합니다.
	        const nextItemsEnd = itemsShown + itemsPerPage;
	        
	        // 숨겨져 있던 다음 10개의 행을 화면에 부드럽게 나타나게 합니다.
	        allRows.slice(itemsShown, nextItemsEnd).show();
	        
	        // 현재까지 보여준 게시글 수를 업데이트합니다.
	        itemsShown = nextItemsEnd;
	
	        // 6. 모든 게시글을 다 보여줬다면 '더보기' 버튼을 숨깁니다.
	        if (itemsShown >= totalRows) {
	            $("#load-more-btn").hide();
	        }
	    });
	});
	</script>
</body>
</html>
