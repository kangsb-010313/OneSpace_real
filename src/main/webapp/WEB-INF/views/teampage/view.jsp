<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기 - ${post.teamPostTitle}</title> <%-- 게시글 제목으로 타이틀 설정 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <%-- 글 종류에 따라 다른 CSS 파일 로드 (공통은 위에서, 개별은 여기서) --%>
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
        <c:when test="${post.teamPostType == '연습일정'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/finreservation.css">
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
                        <%--  글 종류에 따른 메인 제목 변경 --%>
                        <h2 class="main-content-title">
                            <c:choose>
                                <c:when test="${post.teamPostType == '일반공지'}">일반 공지</c:when>
                                <c:when test="${post.teamPostType == '팀자랑'}">팀 자랑</c:when>
                                <c:when test="${post.teamPostType == '투표'}">투표</c:when>
                                <c:when test="${post.teamPostType == '연습일정'}">연습일정 확인</c:when>
                                <c:otherwise>게시글</c:otherwise>
                            </c:choose>
                        </h2>

                        <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                        <div class="team-wrote-wrap">
                            <div class="post-container">
                                <div class="post-header">
                                    <h4 class="post-title">${post.teamPostTitle}</h4>
                                </div>
                                <span class="post-date">${post.teamWriteDate}</span>
                                
                                <%-- 글 종류에 따른 내용 표시 (조건부) --%>
                                <div class="post-content">
                                    <%-- 팀자랑 글 내용 시작 --%>
								    <c:choose>
								        <%-- Case 1: 팀자랑 글 내용 --%>
								        <c:when test="${post.teamPostType == '팀자랑'}">
								            <div class="post-author-info">
								                <strong>팀 ${post.teamName}</strong>
								                <span>${post.instaAccount}</span>
								            </div>
								            <div class="post-text-content">
								                <p>${post.teamContent}</p>
								            </div>
								            <div class="post-image-gallery">
								                <c:forEach items="${post.attachments}" var="file">
								                    <img src="${pageContext.request.contextPath}/onespace/display/${file.teamStoredFileName}" 
								                         alt="${file.teamOriginFileName}" class="attached-image">
								                </c:forEach>
								            </div>
								        </c:when>
								
								        <%-- Case 2: '연습일정' 글일 때 보여줄 특별한 레이아웃 (새로 추가) --%>
								        <c:when test="${post.teamPostType == '연습일정'}">
							            
								            <div class="reservation-page-wrap">
								                <!-- 좌측: 확정된 연습실 정보 -->
								                <div class="left-column">
								                    <h3 class="section-title">#확정된 연습실 정보</h3>
								                    <div class="vote-option">
								                        <a href="#" class="vote-item-card">
								                            <img src="${pageContext.request.contextPath}/onespace/display/${confirmedOption.picturesNo}" alt="연습실 이미지">
								                            <div class="card-content-wrapper">
								                                <div class="card-main-info">
								                                    <div class="info-left">
								                                        <p class="item-title">${confirmedOption.roomName}</p>
								                                        <p class="item-datetime">${confirmedOption.voteDate} ${confirmedOption.startTime} ~ ${confirmedOption.endTime}</p>
								                                    </div>
								                                    <div class="info-right">
								                                        <p class="item-price">${confirmedOption.totalPrice} 원</p>
								                                    </div>
								                                </div>
								                            </div>
								                        </a>
								                    </div>
								                    
								                    <h3 class="section-title">#연습일정 참여 팀원</h3>
										            <div class="voted-members">
<%-- 										                <c:forEach items="${voters}" var="voter" varStatus="loop">
										                    <span>${voter.userName}</span><c:if test="${not loop.last}"></c:if>
										                </c:forEach> --%>
										                <c:forEach items="${voters}" var="voter">
													        <div class="voter-item">${voter.userName}</div>
													    </c:forEach>
										            </div>
								                </div>
								                <!-- 우측: 최종 예약 정보 -->
								                <div class="right-column">
								                    <div class="reservation-details">
								                        <h3>예약정보</h3>
								                        <ul class="reservation-info-list">
								                            <li><span class="label">예약자명</span><span class="value">${sessionScope.authUser.userName}</span></li>
								                            <li><span class="label">참여인원</span><span class="value">${fn:length(voters)}명</span></li>
								                            <li><span class="label">예약날짜</span><span class="value">${confirmedOption.voteDate} ${confirmedOption.startTime}~${confirmedOption.endTime}</span></li>
								                        </ul>
								                    </div>
								                    <div class="refund-policy">
								                        <h3>환불규정안내</h3>
								                        <p>이용 2일전: 총 금액의 100% 환불</p>
								                        <p>이용 전날~당일: 환불 불가</p>
								                    </div>
								                </div>
								            </div>
								        </c:when>
								        
								        <%-- Case 3: 그 외 모든 글(일반공지, 투표 등)의 기본 내용 --%>
								        <c:otherwise>
								            <p>${post.teamContent}</p>
								            <div class="post-image-gallery">
								                <c:forEach items="${post.attachments}" var="file">
								                    <img src="${pageContext.request.contextPath}/onespace/display/${file.teamStoredFileName}" 
								                         alt="${file.teamOriginFileName}" class="attached-image">
								                </c:forEach>
								            </div>
								            
								            <%-- '투표' 타입일 때만 투표 옵션 표시 --%>
								            <c:if test="${post.teamPostType == '투표'}">
								                <div class="vote-section-wrap">
								                    <ol class="vote-items-container">
								                        <c:forEach items="${voteOptions}" var="option" varStatus="status">
								                            <li>
								                                <div class="vote-option">
								                                    <a href="#" class="vote-item-card">
								                                        <div class="favorite-count">🔥 ${option.competitionCount}</div>
								                                        <img src="${pageContext.request.contextPath}/onespace/display/${option.picturesNo}" alt="${option.roomName}">
								                                        <div class="card-content-wrapper">
								                                            <div class="card-main-info">
								                                                <div class="info-left">
								                                                    <p class="item-title">${status.count}. ${option.roomName}</p>
								                                                    <p class="item-datetime">${option.voteDate} ${option.startTime} ~ ${option.endTime}</p>
								                                                </div>
								                                                <div class="info-right">
								                                                    <p class="item-price">${option.totalPrice} 원</p>
								                                                </div>
								                                            </div>
								                                        </div>
								                                    </a>
								                                    <div class="vote-action-area">
                                                                        <%-- ▼▼▼▼▼ 버튼 클래스를 동적으로 변경 ▼▼▼▼▼ --%>
                                                                        <c:set var="isVoted" value="false" />
                                                                        <c:forEach items="${userVotedList}" var="votedNo">
                                                                            <c:if test="${votedNo == option.voteNo}">
                                                                                <c:set var="isVoted" value="true" />
                                                                            </c:if>
                                                                        </c:forEach>
								                                        <button type="button" class="btn-vote ${isVoted ? 'active' : ''}" data-voteno="${option.voteNo}">투표</button>
                                                                        <%-- ▲▲▲▲▲ 여기까지 수정 ▲▲▲▲▲ --%>
								                                        <div class="voter-list" id="voter-list-${option.voteNo}"></div>
								                                    </div>
								                                </div>
								                            </li>
								                        </c:forEach>
								                    </ol>
								                </div>
								            </c:if>
								        </c:otherwise>
								    </c:choose>
                                    <%-- 투표 전용 섹션 끝 --%>
                                </div>
                                <%-- 글 종류에 따른 내용 표시 끝 --%>
                                
                                <div class="post-actions">
                                    <%-- 버튼 종류에 따른 분기 --%>
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
							                        <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/${post.teamPostNo}/confirm" class="btn-action">바로 예약하기</a>
								                </c:when>
								                
								                <%-- '연습일정'일 때 버튼 --%>
                                                <c:when test="${post.teamPostType == '연습일정'}">
                                                    <button type="button" class="btn-action btn-share" id="kakao-share-btn">공유하기</button>
								                    <a href="${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/list" class="btn-action">목록</a>
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
                                    <c:if test="${sessionScope.authUser.userNo == post.userNo && post.teamPostType != '투표' && post.teamPostType != '연습일정'}">
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
	                        description: "${post.teamContent}",
	                        imageUrl: "", //대표 이미지 url
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
	        
	    
	    });
	</script>
    
    <script>
	$(document).ready(function() {

	    // 페이지 로딩 시, 각 후보의 투표자 목록을 가져옵니다.
	    $(".voter-list").each(function() {
	        var voteNo = $(this).attr("id").replace("voter-list-", "");
	        if (voteNo) { fetchVoters(voteNo); }
	    });
	
	    // '투표' 버튼 클릭 이벤트
	    $(".btn-vote").on("click", function() {
	        var $button = $(this); // 클릭된 버튼 요소를 변수에 저장
	        var voteNo = $button.data("voteno");
	        var postNo = "${post.teamPostNo}";

            // (핵심) 이미 'active' 클래스가 있다면 (즉, 이미 투표했다면) 아무것도 하지 않음
            if ($button.hasClass('active')) {
                // 여기서 나중에 '투표 취소' 로직을 넣을 수 있습니다.
                // alert("이미 투표한 후보입니다.");
                return;
            }

	        $.ajax({
	            url: "${pageContext.request.contextPath}/onespace/api/addvote",
	            type: "POST", 
                data: { voteNo: voteNo, postNo: postNo },
	            success: function(result) {
	                if (result) {
	                    // 성공 시, 버튼에 'active' 클래스 추가하여 보라색으로 만듦
                        $button.addClass('active');
	                    // 투표자 목록 실시간 갱신
	                    fetchVoters(voteNo);
	                } else {
	                    // 서버에서 false를 반환한 경우 (이미 다른 후보에게 투표했거나 등)
	                    alert("이미 투표하셨거나 오류가 발생했습니다.");
	                }
	            },
	            error: function() { 
                    alert("투표 처리 중 오류가 발생했습니다."); 
                }
	        });
	    });
	
	    // 투표자 목록을 가져와서 화면에 뿌려주는 함수
	    function fetchVoters(voteNo) {
	        $.ajax({
	            url: "${pageContext.request.contextPath}/onespace/api/getvoters",
	            type: "GET", 
                data: { voteNo: voteNo },
	            success: function(voterList) {
	                var voterListDiv = $("#voter-list-" + voteNo);
	                voterListDiv.empty();
	                voterList.forEach(function(voter) {
	                    voterListDiv.append("<span>" + voter.userName + "</span>");
	                });
	            }
	        });
	    }

	});
	</script>
        
        
        
    </body>
</html>
