<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

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
                        
                        <form id="paymentForm" action="${pageContext.request.contextPath}/onespace/teams/${teamNo}/payment/execute" method="post">
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
                                            <li><span class="label">예약날짜</span><span class="value">${confirmedOption.voteDate} ${confirmedOption.startTime}~${confirmedOption.endTime}</span></li>
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
                                <button type="submit" class="btn-action">총 ${confirmedOption.totalPrice}원 결제하기</button>
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
</body>
</html>
