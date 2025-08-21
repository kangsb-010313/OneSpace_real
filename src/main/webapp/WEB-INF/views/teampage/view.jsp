<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기 - ${post.teamPostTitle}</title> <%-- 게시글 제목으로 타이틀 설정 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    
    <%-- ▼▼▼▼▼ 글 종류에 따라 다른 CSS 파일 로드 (공통은 위에서, 개별은 여기서) ▼▼▼▼▼ --%>
    <c:choose>
        <c:when test="${post.teamPostType == '일반공지'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamwrote.css">
        </c:when>
        <c:when test="${post.teamPostType == '팀자랑'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teampriwrote.css">
        </c:when>
        <c:when test="${post.teamPostType == '투표'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/voting.css">
        </c:when>
        <c:otherwise>
            <%-- 기본 상세 페이지 CSS (필요 시) --%>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/postview.css"> 
        </c:otherwise>
    </c:choose>
</head>
<body>
    <div id="wrap">
        <!-- 헤더 영역 (모든 JSP에서 공통 부분) -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
        <!-- /헤더 영역------------------------------------------------ -->

        <main>
            <div class="container">
                <div id="content">
                
                	<!-- 팀페이지 aside ---------------------------------------------->
					<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
					<!-- 팀페이지 aside ---------------------------------------------->

                    <div id="main-content">
                        <%-- ▼▼▼▼▼ 글 종류에 따른 메인 제목 변경 ▼▼▼▼▼ --%>
                        <h2 class="main-content-title">
                            <c:choose>
                                <c:when test="${post.teamPostType == '일반공지'}">일반 공지</c:when>
                                <c:when test="${post.teamPostType == '팀자랑'}">팀 자랑</c:when>
                                <c:when test="${post.teamPostType == '투표'}">투표</c:when>
                                <c:otherwise>게시글</c:otherwise>
                            </c:choose>
                        </h2>
                        <%-- ▲▲▲▲▲ 여기까지 ▲▲▲▲▲ --%>

                        <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                        <div class="team-wrote-wrap">
                            <div class="post-container">
                                <div class="post-header">
                                    <h4 class="post-title">${post.teamPostTitle}</h4>
                                </div>
                                <span class="post-date">${post.teamWriteDate}</span>
                                
                                <%-- ▼▼▼▼▼ 글 종류에 따른 내용 표시 (조건부) ▼▼▼▼▼ --%>
                                <div class="post-content">
                                    <%-- 팀자랑 글 내용 시작 --%>
                                    <c:if test="${post.teamPostType == '팀자랑'}">
                                        <div class="post-author-info">
                                            <strong>팀 ${post.teamName}</strong>
                                            <span>${post.instaAccount}</span> <%-- teamPostVO에 instaAccount 필드가 있어야 합니다 --%>
                                        </div>
                                        <div class="post-text-content">
                                            <p>${post.teamContent}</p>
                                        </div>
                                        <!-- 첨부 이미지 표시 영역 (예시) -->
                                        <div class="post-image-gallery">
                                            <!-- 실제로는 DB에 저장된 이미지 경로를 반복문으로 출력합니다 -->
                                            <img src="${pageContext.request.contextPath}/assets/images/댄스팀 연습 사진01.jpg" alt="팀 연습 사진 1" class="attached-image">
                                            <img src="${pageContext.request.contextPath}/assets/images/댄스팀연습사진02.jpg" alt="팀 연습 사진 2" class="attached-image">
                                        </div>
                                    </c:if>
                                    <%-- 팀자랑 글 내용 끝 --%>

                                    <%-- 일반공지/투표 글 내용 (기본 내용) 시작 --%>
                                    <c:if test="${post.teamPostType == '일반공지' || post.teamPostType == '투표'}">
                                        <p>${post.teamContent}</p>
                                    </c:if>
                                    <%-- 일반공지/투표 글 내용 끝 --%>

                                    <%-- 투표 전용 섹션 시작 --%>
                                    <c:if test="${post.teamPostType == '투표'}">
                                        <div class="vote-section-wrap">
                                            <ol class="vote-items-container">
                                                <!-- 투표 옵션 1 -->
                                                <li>
                                                    <div class="vote-option">
                                                        <a href="#" class="vote-item-card">
                                                            <div class="favorite-count">🔥 6</div> 
                                                            <img src="${pageContext.request.contextPath}/assets/images/연습실사진01.jpg" alt="네스트 연습실">
                                                            <div class="card-content-wrapper">
                                                                <div class="card-main-info">
                                                                    <div class="info-left">
                                                                        <p class="item-title">1. 네스트 연습실 101호</p>
                                                                        <p class="item-datetime">8/4(월) 15:00-17:00</p>
                                                                    </div>
                                                                    <div class="info-right">
                                                                        <p class="item-price">16,000 원</p>
                                                                    </div>
                                                                </div>
                                                                <div class="card-sub-info">
                                                                    <p class="item-info">실외화 가능/주차/최대7인</p>
                                                                    <p class="item-location">
                                                                        <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <div class="vote-action-area">
                                                            <button type="button" class="btn-vote">투표</button>
                                                            <div class="voter-list">
                                                                <span>강수빈</span>
                                                                <span>이현진</span>
                                                                <span>신현석</span>
                                                                <span>정영민</span>
                                                                <span>정성찬</span>
                                                                <span>박원빈</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <!-- 투표 옵션 2 -->
                                                <li>
                                                    <div class="vote-option">
                                                        <a href="#" class="vote-item-card">
                                                            <div class="favorite-count">🔥 3</div> 
                                                            <img src="${pageContext.request.contextPath}/assets/images/연습실사진02.jpg" alt="두번째 연습실">
                                                            <div class="card-content-wrapper">
                                                                <div class="card-main-info">
                                                                    <div class="info-left">
                                                                        <p class="item-title">2. 퍼스트 연습실 A홀</p>
                                                                        <p class="item-datetime">8/4(월) 18:00-20:00</p>
                                                                    </div>
                                                                    <div class="info-right">
                                                                        <p class="item-price">18,000 원</p>
                                                                    </div>
                                                                </div>
                                                                <div class="card-sub-info">
                                                                    <p class="item-info">주차/최대15인</p>
                                                                    <p class="item-location">
                                                                        <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <div class="vote-action-area">
                                                            <button type="button" class="btn-vote">투표</button>
                                                            <div class="voter-list">
                                                                <span>신현석</span>
                                                                <span>정영민</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <!-- 투표 옵션 3 -->
                                                <li>
                                                    <div class="vote-option">
                                                        <a href="#" class="vote-item-card">
                                                            <div class="favorite-count">🔥 7</div> 
                                                            <img src="${pageContext.request.contextPath}/assets/images/연습실사진03.jpg" alt="세번째 연습실">
                                                            <div class="card-content-wrapper">
                                                                <div class="card-main-info">
                                                                    <div class="info-left">
                                                                        <p class="item-title">3. 드림 스튜디오</p>
                                                                        <p class="item-datetime">8/5(화) 19:00-21:00</p>
                                                                    </div>
                                                                    <div class="info-right">
                                                                        <p class="item-price">15,000 원</p>
                                                                    </div>
                                                                </div>
                                                                <div class="card-sub-info">
                                                                    <p class="item-info">실외화 가능/최대5인</p>
                                                                    <p class="item-location">
                                                                        <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <div class="vote-action-area">
                                                            <button type="button" class="btn-vote">투표</button>
                                                            <div class="voter-list">
                                                                <span>이현진</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ol>
                                        </div>
                                    </c:if>
                                    <%-- 투표 전용 섹션 끝 --%>
                                </div>
                                <%-- ▲▲▲▲▲ 글 종류에 따른 내용 표시 끝 ▲▲▲▲▲ --%>
                                
                                <div class="post-actions">
                                    <%-- 버튼 종류에 따른 분기 (예시) --%>
								    <c:choose>
								        <%-- Case 1: 팀 멤버인 경우 --%>
								        <c:when test="${isMember}">
								            <c:choose>
								                <%-- 1-1: '팀자랑' 글일 때 --%>
								                <c:when test="${post.teamPostType == '팀자랑'}">
								                    <button type="button" class="btn-action" id="btn-pride">팀자랑 가서보기</button>
								                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/list" class="btn-action">목록</a>
								                </c:when>
								                
								                <%-- 1-2: '투표' 글일 때 --%>
								                <c:when test="${post.teamPostType == '투표'}">
								                    <button type="button" class="btn-action btn-share" id="kakao-share-btn">공유하기</button>
								                    <button type="button" class="btn-action">바로 예약하기</button>
								                </c:when>
								
								                <%-- 1-3: '일반 공지' 또는 그 외 모든 글일 때 --%>
								                <c:otherwise>
								                    <button type="button" class="btn-action btn-share" id="kakao-share-btn">공유하기</button>
								                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/list" class="btn-action">목록</a>
								                </c:otherwise>
								            </c:choose>
								        </c:when>
								
								        <%-- Case 2: 팀 멤버가 아닌 경우 --%>
										<c:otherwise>
										   
										    <form action="${pageContext.request.contextPath}/onespace/teams/${teamNo}/join" method="post">
										        <button type="submit" class="btn-action" onclick="return confirm('이 팀에 가입을 신청하시겠습니까?');">팀원 가입 신청</button>
										    </form>
										</c:otherwise>
								    </c:choose>

                                    <%-- 작성자만 수정/삭제 버튼 보이도록 (공통) --%>
                                    <c:if test="${sessionScope.authUser.userNo == post.userNo && post.teamPostType != '투표'}">
                                        <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/${post.teamPostNo}/modifyform" class="btn-action">수정</a>
										<a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/${post.teamPostNo}/delete" 
										   onclick="return confirm('정말로 이 게시글을 삭제하시겠습니까?');" 
										   class="btn-action">삭제</a>

                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <!-- /컨텐츠 영역---------------------------------------------- -->

        <!-- 푸터 영역------------------------------------------------ -->
		<c:import url="/WEB-INF/views/include/footer.jsp" />
        <!-- /푸터 영역------------------------------------------------ -->
        </div>
        
        
        
    <!-- ▼▼▼▼▼ 카카오 공유 기능 스크립트 추가 ▼▼▼▼▼ -->
    <!-- 1. 카카오 SDK 불러오기 -->
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js"
            integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" 
            crossorigin="anonymous">
    </script>

    <!-- 2. 카카오 SDK 초기화 및 공유 기능 구현 -->
	<!-- 2. 모든 버튼 기능을 이 하나의 script 태그 안에서 관리합니다. -->
	<script>
	    // 페이지의 모든 HTML 요소가 완전히 로드된 후에 이 안의 코드가 실행되도록 보장합니다.
	    document.addEventListener('DOMContentLoaded', function() {
	    
	        // 기능 (1): 카카오 SDK 초기화
	        try {
	            // 여기에 본인의 카카오 자바스크립트 키를 넣습니다.
	            Kakao.init('2ea5d5cfa151794faf308425365c73cd');
	            console.log("Kakao SDK가 성공적으로 초기화되었습니다.");
	        } catch(e) {
	            console.error("Kakao SDK 초기화 중 오류가 발생했습니다:", e);
	        }
	        
	        // 기능 (2): 카카오 공유하기 버튼
	        // id가 'kakao-share-btn'인 버튼을 찾아서 기능을 연결합니다.
	        const kakaoShareButton = document.getElementById('kakao-share-btn');
	        if (kakaoShareButton) {
	            kakaoShareButton.addEventListener('click', function() {
	                const postUrl = window.location.href; // 현재 페이지 주소
	
	                Kakao.Share.sendDefault({
	                    objectType: 'feed',
	                    content: {
	                        title: `[${post.teamName}] ${post.teamPostTitle}`,
	                        description: "${post.teamContent}", // EL 표현식은 따옴표 안에 있어도 잘 작동합니다.
	                        imageUrl: "", // 여기에 대표 이미지가 있다면 URL을 넣어주세요.
	                        link: { mobileWebUrl: postUrl, webUrl: postUrl },
	                    },
	                    buttons: [
	                        {
	                            title: '게시글 보러가기',
	                            link: { mobileWebUrl: postUrl, webUrl: postUrl },
	                        },
	                    ],
	                });
	            });
	        }
	        
	        // 기능 (3): 팀원 가입 신청 버튼
	        // id가 'joinButton'인 버튼을 찾아서 기능을 연결합니다.
		    const joinButton = document.getElementById('joinButton');
		    if (joinButton) {
		        joinButton.addEventListener('click', function() {
		            if(confirm("이 팀에 가입을 신청하시겠습니까?")) {
		                // 추후 팀원 가입 신청 로직을 여기에 연결합니다.
		                // 예시: location.href = '${pageContext.request.contextPath}/onespace/teams/${teamNo}/join';
		                alert('팀원 가입 신청 기능은 구현 예정입니다.');
		            }
		        });
		    }
	    
	    });
	</script>
    
    
        
        
        
    </body>
</html>
