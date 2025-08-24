<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%-- 투표자 수 계산(fn:length)을 위해 추가 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 날짜 포맷팅을 위해 추가 --%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀페이지-예약화면</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reservation.css">
</head>
<body>
    <div id="wrap">
        <%-- 헤더와 사이드바는 c:import로 공통 처리 --%>
        <c:import url="/WEB-INF/views/include/header.jsp" />

        <main>
            <div class="container">
                <div id="content">
                    <c:import url="/WEB-INF/views/include/asideteampage.jsp" />

                    <div id="main-content">
                        <h2>팀 원밀리언</h2> <%-- 이 부분은 필요 시 동적으로 변경 가능 --%>
                        <div class="team-wrote-wrap">
                            <form id="reservationForm">
                                <div class="post-container">
                                
                                    <div class="post-header">
                                        <h4 class="post-title">팀 원밀리언 연습일정 예약</h4>
                                    </div>
                                    
                                    <%-- 오늘 날짜를 표시하도록 수정 --%>
                                    <span class="post-date"><c:set var="now" value="<%= new java.util.Date() %>" /><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></span>
                                    
                                    
                                    <div class="post-content">
                                        <div class="reservation-page-wrap">
                                            <!-- 좌측: 선택된 연습실 정보 (Controller에서 받은 데이터로 표시) -->
                                            <div class="left-column">
                                                <h3 class="section-title">#예약 연습실 정보</h3>
                                                <div class="vote-option">
                                                    <a href="#" class="vote-item-card">
                                                        <img src="${pageContext.request.contextPath}/onespace/display/${topOption.picturesNo}" alt="연습실 이미지">
                                                        <div class="card-content-wrapper">
                                                            <div class="card-main-info">
                                                                <div class="info-left">
                                                                    <p class="item-title">${topOption.roomName}</p>
                                                                    <p class="item-datetime">${topOption.voteDate} ${topOption.startTime} ~ ${topOption.endTime}</p>
                                                                </div>
                                                                <div class="info-right">
                                                                    <p class="item-price">${topOption.totalPrice} 원</p>
                                                                </div>
                                                            </div>
                                                            <div class="card-sub-info">
                                                                <c:if test="${not empty topOption.spacesGuideNo}"><p class="item-info">${topOption.spacesGuideNo}</p></c:if>
                                                                <p class="item-location">
                                                                    <img src="${pageContext.request.contextPath}/assets/images/위치아이콘.jpg" class="map-icon"> ${topOption.address}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                                <h3 class="section-title">#이 연습일정에 투표한 멤버들</h3>
                                                <div class="voted-members">
                                                    <c:forEach items="${voters}" var="voter">
                                                        <span>${voter.userName}</span>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <!-- 우측: 예약 및 결제 정보 (Controller에서 받은 데이터로 표시) -->
                                            <div class="right-column">
                                                <div class="reservation-details">
                                                    <h3>예약정보</h3>
                                                    <ul class="reservation-info-list">
                                                        <li><span class="label">예약자명</span><span class="value">${sessionScope.authUser.userName}</span></li>
                                                        <li><span class="label">예약인원</span><span class="value">${fn:length(voters)}명</span></li>
                                                        <li><span class="label">예약날짜</span><span class="value">${topOption.voteDate} ${topOption.startTime}~${topOption.endTime}</span></li>
                                                        <li><span class="label">연락처</span><span class="value"><input type="text" id="contact" placeholder="연락처를 입력해주세요.(ex. 01012345678)"></span></li>
                                                    </ul>
                                                </div>
                                                <div class="refund-policy"><h3>환불규정안내</h3><p>이용 2일전: 총 금액의 100% 환불</p><p>이용 전날~당일: 환불 불가</p></div>
                                                <div class="payment-method">
                                                    <h3>결제수단 선택</h3>
                                                    <div class="options">
                                                        <label><input type="radio" name="payment" value="card" checked> 신용카드</label>
                                                        <label><input type="radio" name="payment" value="kakao"> 카카오페이</label>
                                                        <label><input type="radio" name="payment" value="transfer"> 무통장입금</label>
                                                    </div>
                                                </div>
                                                <div class="final-amount"><span>총 금액</span><span class="amount-value">${topOption.totalPrice} 원</span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="payment-action">
                                        <button type="button" class="btn-payment">결제하기</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        
        <c:import url="/WEB-INF/views/include/footer.jsp" />
    </div>

    <!-- 결제 완료 모달창 HTML -->
    <div id="payment-modal" class="modal-overlay hidden">
        <div class="modal-content">
            <p>결제 및 예약이 완료되었습니다.</p>
            <button id="btn-confirm-reservation" class="btn-action">연습일정 확인</button>
        </div>
    </div>

    <!-- jQuery와 Ajax 스크립트 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        var newPostNo = -1; // 새로 생성된 '연습일정 확인' 게시글 번호를 저장할 변수

        // '결제하기' 버튼 클릭 이벤트
        $('.btn-payment').on('click', function() {
            // 연락처 유효성 검사 등 추가 가능
            
            // Ajax로 서버에 최종 확정 요청
            $.ajax({
                url: "${pageContext.request.contextPath}/onespace/api/finalize",
                type: "POST",
                data: { 
                    postNo: "${postNo}" // Controller의 reservationForm에서 모델에 담아준 postNo
                },
                success: function(result_newPostNo) {
                    if (result_newPostNo > 0) {
                        newPostNo = result_newPostNo; // 성공 시, 새로 만들어진 postNo 저장
                        $('#payment-modal').removeClass('hidden'); // 모달창 표시
                    } else {
                        alert("예약 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                    }
                },
                error: function() { 
                    alert("서버와 통신 중 오류가 발생했습니다.");
                }
            });
        });

        // 모달의 '연습일정 확인' 버튼 클릭 이벤트
        $('#btn-confirm-reservation').on('click', function() {
            if (newPostNo > 0) {
                // 저장해둔 newPostNo를 이용해 새로 생성된 게시글 상세 페이지로 이동
                window.location.href = "${pageContext.request.contextPath}/onespace/teams/${teamNo}/posts/" + newPostNo;
            }
        });
    });
    </script>
</body>
</html>
