<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

            <!-- 헤더 영역------------------------------------------------ -->
 			<c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->





            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

                    <div id="content">
                    
	                	<!-- 팀페이지 aside ---------------------------------------------->
						<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
						<!-- 팀페이지 aside ---------------------------------------------->

                        <div id="main-content">
                            <h2>팀 ${teamName}</h2>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   main container 안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                            <div class="team-wrote-wrap">
                                <div class="post-container">
                                    <div class="post-header">
                                        <h4 class="post-title">팀 원밀리언 연습일정 예약</h4>
                                    </div>
                                    <span class="post-date">2025-07-30</span>
                                    
                                    <div class="post-content">
                                        <!-- ▼▼▼▼▼ 예약 페이지 전체 컨테이너 ▼▼▼▼▼ -->
                                        <div class="reservation-page-wrap">
                                            
                                            <!-- 좌측: 선택된 연습실 정보 -->
                                            <div class="left-column">
                                                <h3 class="section-title">#예약 연습실 보러가기</h3>
                                                <!-- ▼▼▼▼▼ 이 부분을 투표 페이지의 카드와 동일한 구조로 변경 ▼▼▼▼▼ -->
                                                <div class="vote-option">
                                                    <a href="#" class="vote-item-card">
                                                        <img src="../../assets/images/연습실사진01.jpg" alt="네스트 연습실">
                                                        <div class="card-content-wrapper">
                                                            <div class="card-main-info">
                                                                <div class="info-left">
                                                                    <p class="item-title">네스트 연습실 101호</p>
                                                                    <p class="item-datetime">8/4(월) 15:00-17:00</p>
                                                                </div>
                                                                <div class="info-right">
                                                                    <p class="item-price">16,000 원</p>
                                                                </div>
                                                            </div>
                                                            <div class="card-sub-info">
                                                                <p class="item-info">실외화 가능/주차/최대7인</p>
                                                                <p class="item-location">
                                                                    <img src="../../assets/images/위치아이콘.jpg" class="map-icon"> 강동구
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </a>
                                                </div>
                                                <!-- ▲▲▲▲▲ 카드 구조 변경 끝 ▲▲▲▲▲ -->
                                                
                                                <h3 class="section-title">#이 연습일정에 투표한 멤버들</h3>
                                                <div class="voted-members">
                                                    <span>강수빈</span>
                                                    <span>이현진</span>
                                                    <span>신현석</span>
                                                    <span>정영민</span>
                                                </div>
                                            </div>

                                            <!-- 우측: 예약 및 결제 정보 -->
                                            <div class="right-column">
                                                <div class="reservation-details">
                                                    <h3>예약정보</h3>
                                                    <ul class="reservation-info-list">
                                                        <li>
                                                            <span class="label">예약자명</span>
                                                            <span class="value">강수빈</span>
                                                        </li>
                                                        <li>
                                                            <span class="label">예약인원</span>
                                                            <span class="value">4명</span>
                                                        </li>
                                                        <li>
                                                            <span class="label">예약날짜</span>
                                                            <span class="value">8/4(월) 15:00~17:00</span>
                                                        </li>
                                                        <li>
                                                            <span class="label">연락처</span>
                                                            <span class="value">
                                                                <input type="text" placeholder="연락처를 입력해주세요.(ex. 01056781234)">
                                                            </span>
                                                        </li>
                                                    </ul>
                                                </div>

                                                <div class="refund-policy">
                                                    <h3>환불규정안내</h3>
                                                    <p>이용 2일전: 총 금액의 100% 환불</p>
                                                    <p>이용 전날~당일: 환불 불가</p>
                                                </div>

                                                <div class="payment-method">
                                                    <h3>결제수단 선택</h3>
                                                    <div class="options">
                                                        <label><input type="radio" name="payment" checked> 신용카드</label>
                                                        <label><input type="radio" name="payment"> 카카오페이</label>
                                                        <label><input type="radio" name="payment"> 무통장입금</label>
                                                    </div>
                                                </div>
                                                
                                                <div class="final-amount">
                                                    <span>총 금액</span>
                                                    <span class="amount-value">20,000 원</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ▲▲▲▲▲ 예약 페이지 전체 컨테이너 끝 ▲▲▲▲▲ -->
                                    </div>


                                    <div class="payment-action">
                                        <button type="submit" class="btn-payment">결제하기</button>
                                    </div>
                                </div>
                            </div>



                        </div>

                    </div>
<!-- ------------------------------------------------------------------------------------------------------ -->
                </div>
                <!-- container -->

            </main>
            <!-- /컨텐츠 영역---------------------------------------------- -->



            <!-- 푸터 영역------------------------------------------------ -->
			<c:import url="/WEB-INF/views/include/footer.jsp" />
            <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->


        <!-- ▼▼▼▼▼ 결제 완료 모달창 HTML ▼▼▼▼▼ -->
        <div id="payment-modal" class="modal-overlay hidden">
            <div class="modal-content">
                <p>결제 및 예약이 완료되었습니다.</p>
                <button id="btn-close-modal" class="btn-action">예약확인</button>
            </div>
        </div>
        <!-- ▲▲▲▲▲ 모달창 HTML 끝 ▲▲▲▲▲ -->


        <!-- ▼▼▼▼▼ 모달 제어 스크립트 ▼▼▼▼▼ -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // 필요한 요소들을 선택합니다.
                const paymentButton = document.querySelector('.btn-payment');
                const modalOverlay = document.getElementById('payment-modal');
                const closeModalButton = document.getElementById('btn-close-modal');

                // '결제하기' 버튼을 클릭하면 모달을 보여줍니다.
                paymentButton.addEventListener('click', function(event) {
                    event.preventDefault(); // 폼 제출 등 기본 동작 방지
                    modalOverlay.classList.remove('hidden');
                });

                // '닫기' 버튼을 클릭하면 모달을 숨깁니다.
                closeModalButton.addEventListener('click', function() {
                    modalOverlay.classList.add('hidden');
                });

                // 모달 배경을 클릭하면 모달을 숨깁니다.
                modalOverlay.addEventListener('click', function(event) {
                    // 클릭된 요소가 모달 배경 자체일 때만 닫히도록 함
                    if (event.target === modalOverlay) {
                        modalOverlay.classList.add('hidden');
                    }
                });
            });
        </script>
        <!-- ▲▲▲▲▲ 스크립트 끝 ▲▲▲▲▲ -->

    </body>

</html>