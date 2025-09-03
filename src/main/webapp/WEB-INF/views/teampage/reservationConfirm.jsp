<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 정보 확인 및 결제</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/finreservation.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    // JSP의 Context Path를 JavaScript 변수로 저장
    const CONTEXT_PATH = "${pageContext.request.contextPath}";
	</script>
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
                        <h2 class="main-content-title">예약 정보 확인 및 결제</h2>
                        
                        <form id="paymentForm" action="${pageContext.request.contextPath}/team/teams/${teamNo}/payment/execute" method="post">
                            <!-- 서버로 보낼 숨겨진 데이터들 -->
                            <input type="hidden" name="originalPostNo" value="${originalPostNo}">
                            <input type="hidden" name="voteNo" value="${confirmedOption.voteNo}">
                            <input type="hidden" name="roomNo" value="${confirmedOption.roomNo}">
                            <input type="hidden" name="roomName" value="${confirmedOption.roomName}">
                            
                            <div class="reservation-page-wrap">
                            
                                <!-- 좌측: 확정된 연습실 정보 -->
                                <div class="left-column">
                                    <h3 class="section-title">#예약하실 연습실 정보</h3>
                                    <div class="vote-option">
                                        <a href="${pageContext.request.contextPath}/practice/practice3_room?roomNo=${confirmedOption.roomNo}" class="vote-item-card">
                                            <img src="${pageContext.request.contextPath}/uploads/${confirmedOption.thumbImg}" alt="연습실 이미지">
                                            <div class="card-content-wrapper">
                                                <div class="card-main-info">
                                                    <div class="info-left">
                                                        <p class="item-title">${confirmedOption.roomName}</p>
                                                        <p class="item-datetime">${confirmedOption.voteDate} ${confirmedOption.startTime} ~ ${confirmedOption.endTime}</p>
                                                    </div>
                                                    <div class="info-right">
                                                        <p class="item-price"><fmt:formatNumber value="${confirmedOption.totalPrice}" pattern="#,###" /> 원</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    
                                    <h3 class="section-title">#연습일정 참여 팀원</h3>
                                    <div class="voted-members">
									    <c:forEach items="${voters}" var="voter">
									        <div class="voter-item">${voter.userName}</div>
									    </c:forEach>
                                    </div>
                                </div>
                                
                                <!-- 우측: 최종 예약 정보 -->
                                <div class="right-column">
                                    <div class="reservation-details">
                                        <h3>예약자 정보</h3>
                                        <ul class="reservation-info-list">
                                            <li><span class="label">예약자명</span><span class="value">${sessionScope.authUser.userName}</span></li>
                                            <li><span class="label">참여인원</span><span class="value">${fn:length(voters)}명</span></li>
                                            <li><span class="label">예약날짜</span><span class="value">${confirmedOption.voteDate} ${confirmedOption.startTime} ~ ${confirmedOption.endTime}</span></li>
                                            <li>
                                                <span class="label">연락처</span>
                                                <input type="text" name="phoneNum" value="" placeholder="연락처를 입력하세요">
                                            </li>
                                            <li>
                                                <span class="label">결제수단</span>
                                                <div class="payment-methods">
                                                    <label><input type="radio" name="paymentMethod" value="카카오페이" checked> 카카오페이</label>
                                                    <label><input type="radio" name="paymentMethod" value="신용카드"> 신용카드</label>
                                                    <label><input type="radio" name="paymentMethod" value="계좌이체"> 계좌이체</label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    
                                    <div class="refund-policy">
                                        <h3>환불규정안내</h3>
                                        <p>이용 2일전: 총 금액의 100% 환불</p>
                                        <p>이용 전날~당일: 환불 불가</p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="post-actions" style="justify-content: right; margin-top: 30px;">
                                <button type="submit" class="btn-action">총 <fmt:formatNumber value="${confirmedOption.totalPrice}" pattern="#,###" />원 결제하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        
        <!-- 푸터 영역------------------------------------------------ -->
		<c:import url="/WEB-INF/views/include/footer.jsp" />
        <!-- /푸터 영역------------------------------------------------ -->
    </div>
    
    <!-- 결제 완료 모달창 HTML -->
    <div id="paymentSuccessModal" class="modal-overlay" style="display: none;">
	    <div class="modal-content">
	        <h3>결제 완료</h3>
	        <p>예약 및 결제가 정상적으로 완료되었습니다.</p>
	        <button id="modalCloseBtn" class="btn-action">확인</button>
	    </div>
	</div>
    
    <script>
	$(document).ready(function() {
	    // 폼 제출(submit) 이벤트를 가로챔쓰
	    $("#paymentForm").on("submit", function(event) {
	        // 1. 폼의 기본 동작(페이지 이동) 막기
	        event.preventDefault(); 
	
	        // 2. 폼 데이터를 직렬화하여(serialize) Ajax로 보낼 준비
	        var formData = $(this).serialize();
	        var formAction = $(this).attr("action"); // 폼의 action URL
	
	        // 3. Ajax를 사용하여 서버에 비동기적으로 데이터를 전송
	        $.ajax({
	            type: "POST",
	            url: formAction,
	            data: formData,
	            success: function(response) {
	                // 4. 서버로부터 성공 응답을 받으면 모달
	                // Controller에서 반환된 redirect URL을 data-url 속성에 저장
	                $("#paymentSuccessModal").data("redirectUrl", response).show();
	            },
	            error: function() {
	                // 통신 실패 시 에러 메시지
	                alert("결제 처리 중 오류가 발생했습니다. 다시 시도해 주세요.");
	            }
	        });
	    });
	
	    // 모달의 '확인' 버튼 클릭 이벤트
	    $("#modalCloseBtn").on("click", function() {
	        var redirectUrl = $("#paymentSuccessModal").data("redirectUrl");
	        
	        if (redirectUrl) {
	            //CONTEXT_PATH와 Controller가 보내준 경로를 합쳐서 완전한 URL 생성
	            window.location.href = CONTEXT_PATH + redirectUrl;
	        }
	    });
	});
	</script>
    
    
</body>
</html>
