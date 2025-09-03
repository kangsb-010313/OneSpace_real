<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="CTX" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팀페이지-메인</title>
    <%-- CSS 스타일 불러오기 (reset, 기본스타일, aside, 커스텀) --%>
    <link rel="stylesheet" href="${CTX}/assets/css/reset.css">
    <link rel="stylesheet" href="${CTX}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${CTX}/assets/css/asidedefault.css">
    <link rel="stylesheet" href="${CTX}/assets/css/practice4_list.css">
	
	<%-- jQuery 불러오기 --%>
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
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
					
					<!-- 메인 컨텐츠: 찜 리스트 -->
					<div id="main-content" class="zzim">
						
						<div class="two-col">
							<!-- 좌측: 찜한 공간 카드 리스트 -->
							<div class="practice-card-list">
								 <h2 class="zzim-title">찜 리스트</h2>
								 <c:forEach var="favoriteVO" items="${favoritesList}">
									<div class="practice-card card-bordered">
										
										<%-- 대표 이미지 --%>
										<img src="${CTX}/uploads/${favoriteVO.thumbImg}"
									     alt="${favoriteVO.roomName}"
									     class="practice-card-img"
									     style="width:100%; height:200px; object-fit:cover;"/>
										
										<!-- 카드 내용 -->
										<div class="practice-card-body">
											<div class="practice-card-title">${favoriteVO.roomName}</div>
											<div class="practice-card-meta">${favoriteVO.address}</div>
											<div class="practice-card-price">
												<span class="price-highlight">${favoriteVO.minPrice}~${favoriteVO.maxPrice}</span> 원/시간 
												<span class="price-sub">&nbsp; 
													<c:forEach items="${favoriteVO.selectedFacilityInfoList}" var="facilityVO">
														${facilityVO.facilityName}
													</c:forEach>
													최대${favoriteVO.capacity}인
												</span>
											</div>
										</div>
										
										<!-- 카드 액션 버튼 -->
										<div class="card-actions">
											<button class="btn-outline btn-pill-sm open-schedule" data-spaces-no="${favoriteVO.spacesNo}" data-room-no="${favoriteVO.roomNo}">날짜 시간 추가</button>
											<button class="btn-like btn-pill-sm" type="button" data-spaces-no="${favoriteVO.spacesNo}" data-room-no="${favoriteVO.roomNo}">찜해제</button>
										</div>
									</div>
								</c:forEach>
							</div>
							
							
							<!-- //practice-card-list -->
							<section class="fav-panel">
								<div class="fav-title">#내가 찜한 연습실 후보</div>
								<ol class="fav-list">
									<c:forEach var="c" items="${favoriteCandidates}" varStatus="loop">
										<li class="fav-item">
											<div>
												<div class="fav-item-title">${loop.count}.${c.roomName}</div>
												<div class="fav-item-meta">
													<%-- 후보 날짜 --%>
													<fmt:formatDate value="${c.voteDate}" pattern="yyyy/MM/dd" />
													<%-- 시작시간 ~ 종료시간 --%>
													<span class="fav-time">${c.minTime}:00~${c.maxTime}:00</span>
													<span class="fav-duration">${c.count}시간</span>
												</div>
											</div>
											<div class="fav-right">
												<%-- 현재 후보 찜 인원 수 --%>
												<div class="fav-hot"><%-- 🔥<b>${c.hotCount}</b> --%></div>
												<%-- 총 가격 --%>
												<div class="fav-price">
													가격:
													<fmt:formatNumber value="${c.totalPrice}" type="number" />
													<button class="btn-remove-fav" data-voteno="${c.voteNo}">
													    삭제
													</button>
												</div>
											</div>
										</li>
									</c:forEach>
									<c:if test="${empty favoriteCandidates}">
										<li class="fav-item" style="color: #888;">선택한 후보가 없습니다.</li>
									</c:if>
								</ol>
							</section>
							<!-- //fav-panel -->
							
						</div>
						<!-- //two-col -->
						<br> <br>
						<!-- 하단 CTA 버튼 -->
						<div class="cta-row">
							<button class="btn-outline btn-primary" onclick="location.href='${pageContext.request.contextPath}/team/teams/${teamNo}/posts/writeform?teamPostType=투표'">투표 만들기</button>
							<button class="btn-outline btn-pill" onclick="location.href='${pageContext.request.contextPath}/practice/practice1_main'">취소</button>
						</div>
						<!-- //cta-row -->

					</div>
					<!-- //main-content  zzim -->
				</div>
				<!-- //content -->
			</div>
			<!-- //container -->
		</main>

		<!-- 푸터 영역------------------------------------------------ -->
		<c:import url="/WEB-INF/views/include/footer.jsp" />
		<!-- /푸터 영역------------------------------------------------ -->


		<!-- 모달 영역------------------------------------------------ -->
		<div id="scheduleModal" class="sched-overlay" role="dialog" aria-modal="true" aria-hidden="true">
			<div class="sched-modal" onclick="event.stopPropagation()">
				<!-- 상단: 월 네비게이션 -->
				<div class="sched-month">
					<button class="sched-nav" data-dir="prev" aria-label="이전 달">‹</button>
					<div class="sched-title" id="schedTitle">2025.08</div>
					<button class="sched-nav" data-dir="next" aria-label="다음 달">›</button>
				</div>
				<!-- 요일 헤더 -->
				<div class="sched-week">
					<span>일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span>
				</div>
				<!-- 날짜 출력 -->
				<div class="sched-days" id="schedDays"></div>
				<br>
				<!-- 시간대 슬롯 리스트 -->
				<ul class="sched-slots" id="schedSlots">
					<!--        
					<li id="" class="slot" data-start="0"  data-end="1"  data-price="4000">00~01<span>(4,000)</span></li>
					<li id="" class="slot" data-start="1"  data-end="2"  data-price="4000">01~02<span>(4,000)</span></li>
					<li id=""  class="slot" data-start="2"  data-end="3"  data-price="4000">02~03<span>(4,000)</span></li>
					<li id=""  class="slot" data-start="3"  data-end="4"  data-price="4000">03~04<span>(4,000)</span></li>
					
					<li id=""  class="slot" data-start="4"  data-end="5"  data-price="4000">04~05<span>(4,000)</span></li>
					<li id=""  class="slot" data-start="5"  data-end="6"  data-price="4000">05~06<span>(4,000)</span></li>
					<li id=""  class="slot" data-start="6"  data-end="7"  data-price="4000">06~07<span>(4,000)</span></li>
					<li id=""  class="slot" data-start="7"  data-end="8"  data-price="4000">07~08<span>(4,000)</span></li>
					
					<li id=""  class="slot" data-start="8"  data-end="9"  data-price="6000">08~09<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="9"  data-end="10" data-price="6000">09~10<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="10" data-end="11" data-price="6000">10~11<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="11" data-end="12" data-price="6000">11~12<span>(6,000)</span></li>
					
					<li id=""  class="slot" data-start="12" data-end="13" data-price="6000">12~13<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="13" data-end="14" data-price="6000">13~14<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="14" data-end="15" data-price="6000">14~15<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="15" data-end="16" data-price="6000">15~16<span>(6,000)</span></li>
					
					<li id=""  class="slot" data-start="16" data-end="17" data-price="6000">16~17<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="17" data-end="18" data-price="6000">17~18<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="18" data-end="19" data-price="6000">18~19<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="19" data-end="20" data-price="6000">19~20<span>(6,000)</span></li>
					
					<li id=""  class="slot" data-start="20" data-end="21" data-price="6000">20~21<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="21" data-end="22" data-price="6000">21~22<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="22" data-end="23" data-price="6000">22~23<span>(6,000)</span></li>
					<li id=""  class="slot" data-start="23" data-end="24" data-price="6000">23~24<span>(6,000)</span></li>
					-->
				</ul>
				<!-- 선택 요약 -->
				<div class="sched-summary">
					<div class="label">#선택 일정</div>
					<div class="rows">
						<div id="schedDate">2025/08/20(수)</div>
						<div id="schedTime">14시~16시</div>
						<div id="schedPrice">12,000 원</div>
					</div>
				</div>
				<!-- 모달 버튼 -->
				<div class="sched-actions">
					<button class="btn primary" id="schedSubmit">선택</button>
					<button class="btn" id="schedClose">닫기</button>
				</div>
			</div>
		</div>


		<!-- //모달 영역------------------------------------------------ -->
	</div>

	<script>
	const ctx = '${pageContext.request.contextPath}';
	
	$(document).ready(function(){
	  	
	  	const $overlay = $('#scheduleModal');   // 모달
	    const $schedDays = $('#schedDays');     // 날짜 출력 영역
	    const $schedTitle = $('#schedTitle');   // 타이틀(월)
	    const $schedSlots = $('#schedSlots');   // 시간 슬롯
	    const $schedDate = $('#schedDate');     // 선택된 날짜 표시
	    const $schedTime = $('#schedTime');     // 선택된 시간대 표시
	    const $schedPrice = $('#schedPrice');   // 선택된 가격 표시
	    const $schedSubmit = $('#schedSubmit'); // 선택 버튼
	    const $schedClose = $('#schedClose');   // 닫기 버튼
	
		// 날짜 변수
	  	let selectedDate = new Date();
	  	let calendarCursor = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);
		
	  	/* ================= 달력 관련 함수 ================= */
	  	function pad2(n){ return String(n).padStart(2,'0'); }
	  	function formatTitle(d){ return d.getFullYear() + '.' + pad2(d.getMonth()+1); }
	  	function formatSummaryDate(d){
	    	const WEEKDAY = ['일','월','화','수','목','금','토'];
	    	return d.getFullYear() + '/' + pad2(d.getMonth()+1) + '/' + pad2(d.getDate()) + '(' + WEEKDAY[d.getDay()] + ')';
	  	}
	  	function toYYYYMMDD(d){ return d.getFullYear() + '-' + pad2(d.getMonth()+1) + '-' + pad2(d.getDate()); }
		
	  	/* ------------------ 캘린더 렌더 ------------------ */
	  	function renderCalendar(){
		    $schedTitle.text(formatTitle(calendarCursor));
	    	$schedDays.empty();
			
	    	const year = calendarCursor.getFullYear();
	    	const month = calendarCursor.getMonth();
	    	const first = new Date(year, month, 1);
	    	const last  = new Date(year, month + 1, 0);
	    	const leading = first.getDay();
	    	const prevLast = new Date(year, month, 0).getDate();
	    	const totalCells = 42;
	    	const thisCount = last.getDate();
	
	    	// 이전달 마지막 며칠
	    	for(let i = leading - 1; i >= 0; i--){
	      		$('<span>').addClass('muted').text(prevLast - i).appendTo($schedDays);
	    	}
			
	    	// 이번달 날짜 출력
	    	for(let d = 1; d <= thisCount; d++){
	      		const $day = $('<span>').text(d).css('cursor','pointer');
	      		const today = new Date();
	      		if(year === today.getFullYear() && month === today.getMonth() && d === today.getDate()) $day.addClass('today');
	      		if(year === selectedDate.getFullYear() && month === selectedDate.getMonth() && d === selectedDate.getDate()) $day.addClass('picked');
					
	      		$day.on('click', function(){
	        		selectedDate = new Date(year, month, d);
	        		$schedDate.text(formatSummaryDate(selectedDate));
	        		// 선택한 날짜로 슬롯 재조회 (roomNo 저장 필요)
	        		const roomNo = $overlay.data('room-no');
	        		if (roomNo) loadSlots(roomNo, toYYYYMMDD(selectedDate));
	        			renderCalendar();
	      		});
				
	      		$schedDays.append($day);
	    	}
			
	    	// 다음달 앞부분
	    	const used = $schedDays.children().length;
	    	for(let k = 1; k <= totalCells - used; k++){
	      		$('<span>').addClass('muted').text(k).appendTo($schedDays);
	    	}
	  	}
		
	  	/* 모달 열릴 때 초기화 */
	  	function initCalendarOnOpen(){
	    	selectedDate = new Date();
	    	calendarCursor = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);
	    	$schedDate.text(formatSummaryDate(selectedDate));
	    	renderCalendar();
	  	}
		
	 	/* ------------------ 슬롯 로드 & 렌더 ------------------ */
	  	function loadSlots(roomNo, targetDate) {
		    console.log('[sched] loadSlots', roomNo, targetDate);
	    	$schedSlots.empty();
	    	$.ajax({
		        url: ctx + '/practice/api/room-slots',
	        	type: 'POST',
	        	data: { roomNo: roomNo, targetDate: targetDate },
	        	dataType: 'json'
	    	}).done(function(slotList) {
		        console.log('[sched] slotList', slotList);
	        	if (!slotList || slotList.length === 0) {
	            	$schedSlots.append('<li style="color:#888;padding:8px;">예약 가능한 시간대가 없습니다.</li>');
	            	updateSummaryAndState();
	            	return;
	        	}
	        	
	        	slotList.forEach(slot => {
		            if (slot.price > 0) renderSlot(slot);
	        	});
	        	
	        	if ($schedSlots.children().length === 0) {
	            	$schedSlots.append('<li style="color:#888;padding:8px;">예약 가능한 시간대가 없습니다.</li>');
	        	}
	        	
	        	bindSlotClick();
	        	updateSummaryAndState();
	    	}).fail(function(xhr, status, err) {
	        	console.error('[sched] loadSlots fail', status, err);
	        	$schedSlots.append('<li style="color:#c00;padding:8px;">슬롯 조회 실패</li>');
	    	});
	  	}
		
	  	function renderSlot(slotVO) {
	    	const start = slotVO.slotNo !== undefined ? +slotVO.slotNo : 0;
	    	const price = slotVO.price !== undefined ? +slotVO.price : 0;
	    	if (price === 0) return; // 가격이 0인 슬롯은 표시하지 않음
	    	const end = (start + 1) % 24; // 23 다음은 24로 설정
			
	    	if(slotVO.state == 1){
	    		const $li = $('<li>')
	        	.addClass('slot reserv')
	        	.attr('data-start', start)
	        	.attr('data-end', end)
	        	.attr('data-price', price)
	        	.html(pad2(start) + '~' + pad2(end) + '<span>(' + price.toLocaleString() + ')</span>' + slotVO.state);
			
	    		$schedSlots.append($li);
	    	}else{
	    		const $li = $('<li>')
	        	.addClass('slot active')
	        	.attr('data-start', start)
	        	.attr('data-end', end)
	        	.attr('data-price', price)
	        	.html(pad2(start) + '~' + pad2(end) + '<span>(' + price.toLocaleString() + ')</span>' + slotVO.state);
			
	    		$schedSlots.append($li);
	    	}
	    	
	  	}
		
	  	/* ------------------ 슬롯 클릭/선택 로직 ------------------ */
	  	function bindSlotClick(){
		    $schedSlots.off('click', '.slot.active');
	    	$schedSlots.on('click', '.slot.active', function(){
	      		$(this).toggleClass('selected');
				
	      		const starts = $schedSlots.find('.slot.selected').map(function(){ return +this.dataset.start; }).get().sort((a,b)=>a-b);
	      		if (starts.length > 3 || !isContiguous(starts)) {
			        $(this).toggleClass('selected'); // revert
	        		if (starts.length > 3) alert('최대 3시간까지 선택할 수 있습니다.');
	        		else alert('선택은 연속된 시간만 가능합니다.');
	      		}
	      		updateSummaryAndState();
	    	});
	  	}
		
	  	function isContiguous(arr){
	    	if (arr.length === 0) return true;
	    	return (arr[arr.length-1] - arr[0] + 1) === arr.length;
	  	}
		
	  	function updateSummaryAndState(){
	    	const $selected = $schedSlots.find('.slot.selected');
	    	if ($selected.length === 0) {
	      		$schedTime.text('-');
	      		$schedPrice.text('0 원');
	      		$schedSubmit.prop('disabled', true);
	      		return;
	    	}
	    	const starts = $selected.map(function(){ return +this.dataset.start; }).get().sort((a,b)=>a-b);
	    	const start = starts[0];
	    	const end = +$selected.last().attr('data-end') || (starts[starts.length-1] + 1);
	    	const total = $selected.toArray().reduce((sum, el) => sum + (+el.dataset.price || 0), 0);
			
	    	$schedTime.text(start + '시~' + end + '시');
	    	$schedPrice.text(total.toLocaleString() + ' 원');
			
	    	$schedSubmit.prop('disabled', !($selected.length >=1 && $selected.length <=3 && isContiguous(starts)));
	  	}
		
	  	/* ------------------ 핸들러 바인딩 ------------------ */
	  	// open 버튼: delegated binding (동적 요소에도 동작)
	  	$(document).off('click', '.open-schedule').on('click', '.open-schedule', function(e){
			e.preventDefault();
			const roomNo = $(this).data('room-no');
			if (!roomNo) { alert('roomNo 정보를 찾을 수 없습니다'); return; }
	    	
			// 카드에서 공간명 추출 후 오버레이에 저장
			const spaceName = $(this).closest('.practice-card').find('.practice-card-title').text().trim();
			$overlay.data('space-name', spaceName);
	    	
			// 모달 열기
			$overlay.css('display','flex');
			
			// 캘린더 초기화 + 슬롯 로드
			initCalendarOnOpen();
			const tdate = toYYYYMMDD(selectedDate);
			$overlay.data('room-no', roomNo);
			loadSlots(roomNo, tdate);
      	});
		
	  	// 달 이동 버튼
	  	$(document).off('click', '.sched-nav').on('click', '.sched-nav', function(){
		    const dir = $(this).data('dir') === 'prev' ? -1 : 1;
	    	calendarCursor = new Date(calendarCursor.getFullYear(), calendarCursor.getMonth() + dir, 1);
	    	renderCalendar();
	  	});
		
	  	// 닫기/선택
	  	$schedClose.on('click', function(){ $overlay.hide(); });
	  	$schedSubmit.on('click', function(){
		  	const $selected = $schedSlots.find('.slot.selected');
		  	if ($selected.length === 0) {
			    alert('시간대를 선택해 주세요.');
		    	return;
		  	}
			
		  	const starts = $selected.map(function(){ return +this.dataset.start; }).get().sort((a,b)=>a-b);
		  	const startHour = starts[0];
		  	const endHour = +$selected.last().attr('data-end') || (starts[starts.length-1] + 1);
		  	const totalPrice = $selected.toArray().reduce((sum, el) => sum + (+el.dataset.price || 0), 0);
		  	const spaceName = $('.open-schedule[data-room-no="' + $overlay.data('room-no') + '"]').closest('.practice-card').find('.practice-card-title').text();
		  	const voteDate = $schedDate.text();
			
		  	$.ajax({
			    url: ctx + '/practice/api/vote-option',
		    	method: 'POST',
		    	data: {
		      		userNo: 1, // 세션에서 동적으로 가져오도록 수정
		      		roomNo: $overlay.data('room-no'),
		      		voteDate: voteDate,
		      		voteTime: startHour + ':00~' + endHour + ':00',
		      		voteNo: 0 // 기본값 0 설정, 또는 votes에서 유효한 값 조회
		    	},
		    	dataType: 'json'
		  	}).done(function(res){
		  		console.log("=================================");
		  		
		    	if (res.success) {
		      		const $newItem = $('<li class="fav-item">').append(
		        	$('<div>').append(
		          		$('<div class="fav-item-title">').text($favList.children('.fav-item').length + 1 + '. ' + spaceName)
		        		).append(
		          			$('<div class="fav-item-meta">').append(
		            		$('<span>').text(voteDate)
		          			).append(
					            $('<span class="fav-time">').text(startHour + ':00~' + endHour + ':00')
		          			).append(
			            	$('<span class="fav-duration">').text((endHour - startHour) + '시간')
		          			)
		        		)
		      		).append(
		        	$('<div class="fav-right">').append(
		          		$('<div class="fav-hot">').text('🔥 <b>0</b>')
		        		).append(
		          			$('<div class="fav-price">').text('가격: ' + totalPrice.toLocaleString() + ' 원')
		        		)
		      		).data('reservationNo', res.reservationNo);
					
		      		$favList.append($newItem);
		      		if ($favList.find('.fav-item[style="color:#888;"]').length) {
		        		$favList.find('.fav-item[style="color:#888;"]').remove();
		     	 	}
		      		alert(res.message || '투표 옵션 추가 완료');
		    	} else {
		      		alert(res.message || '투표 옵션 추가 실패');
		    	} 
		 	}).fail(function(xhr, status, err){
		    	console.error('투표 옵션 추가 실패', status, err);
		    	alert('서버 오류가 발생했습니다.');
		  	});
			
		  	$overlay.hide();
		});
	  	
	  	//schedSubmit 클릭 핸들러: 서버로 저장하고, 성공하면 우측 리스트에 추가
	  	$schedSubmit.off('click').on('click', function(){
		  	const $selectedSlots = $schedSlots.find('.slot.selected');
		  	if ($selectedSlots.length === 0) {
		    	alert('시간대를 선택하세요.');
		    	return;
		  	}
			
		  	const starts = $selectedSlots.map(function(){ return +this.dataset.start; }).get().sort((a,b)=>a-b);
		  	const startHour = starts[0];
		  	const endHour = (+$selectedSlots.last().attr('data-end')) || (starts[starts.length-1] + 1);
		  	const voteTime = pad2(startHour)+':00~'+pad2(endHour)+':00';
		  	const voteDate = toYYYYMMDD(selectedDate);
			
		  	const roomNo = $overlay.data('room-no');
		  	const spaceName = $('.open-schedule[data-room-no="' + roomNo + '"]').closest('.practice-card').find('.practice-card-title').text();
			
		  	$.ajax({
			    url: ctx + '/practice/api/vote-option',
		    	method: 'POST',
		    	data: { roomNo: roomNo, voteDate: voteDate, voteTime: voteTime },
		    	dataType: 'json'
		  	})
			.done(function(voteNo){
		    	console.log(voteNo);
		    	
				if (voteNo > 0) {
		      		// 오른쪽 후보 리스트에 추가
		      		/*
		      		const $favList = $('.fav-list');
		      		const count = $favList.children('li').length + 1;
		      		const $li = $('<li class="fav-item">').append(
			        	$('<div>').append(
			          		$('<div class="fav-item-title">').text(count+'. '+spaceName),
			          		$('<div class="fav-item-meta">').append(
				            	$('<span>').text(voteDate),
				            	$('<span class="fav-time">').text(voteTime),
				            	$('<span class="fav-duration">').text((endHour - startHour)+'시간')
			          		)
			        	),
			        	$('<div class="fav-right">').append(
			          		$('<div class="fav-hot">').html('🔥 <b>0</b>'),
			          		$('<div class="fav-price">').text('가격: -')
			        	)
		      		);
		      		$favList.append($li);
		      		$overlay.hide();
		      		alert(res.message);
		      		*/
		      		location.reload();
		    	} else {
		      		alert(res.message || '저장 실패');
		    	}
		  	})
		  	.fail(()=> alert('서버 오류 발생'));
		});
	  	
	  	// 초기 캘린더 렌더
	  	renderCalendar();
		
	  	$(document).off('click', '.btn-like[data-room-no]').on('click', '.btn-like[data-room-no]', function(e){
		    e.preventDefault();
	    	var $btn = $(this);
	    	var roomNo = $btn.data('room-no');
			
	    	if (!roomNo) {
	      		alert('roomNo 정보가 없습니다.');
	      		return;
	    	}
			
	    	if (!confirm('정말 이 연습실의 찜을 해제하시겠습니까?')) return;
			
	    	// UI 표시
	    	var origText = $btn.text();
	    	$btn.prop('disabled', true).text('처리중...');
			
	    	$.ajax({
	      		url: ctx + '/practice/api/favorite/remove',
	      		method: 'POST',
	      		data: { roomNo: roomNo },
	      		dataType: 'json'
	    	})
	    	.done(function(res){
	      		if (res && res.success) {
		        	// 해당 카드(연습실 항목)를 DOM에서 제거
		        	var $card = $btn.closest('.practice-card');
		        	if ($card.length) {
		          		$card.slideUp(200, function(){ $(this).remove(); });
		        	} else {
		          		location.reload(); // 안전 장치
		        	}
		        	location.reload();
	      		} else {
	        		alert(res && res.message ? res.message : '찜 해제 실패');
	        		$btn.prop('disabled', false).text(origText);
	      		}
	    	})
	    	.fail(function(xhr, status, err){
	      		console.error('찜 해제 실패', status, err);
	      		alert('서버 오류가 발생했습니다.');
	      		$btn.prop('disabled', false).text(origText);
	    	});
		});
	}); // document.ready
	
	// 후보 삭제
	$(document).off('click', '.btn-remove-fav').on('click', '.btn-remove-fav', function(e){
	    e.preventDefault();
	    if (!confirm("정말 이 후보를 삭제하시겠습니까?")) return;

	    const $btn = $(this);
	    const voteNo = $btn.data('voteno');
		
	    console.log("삭제 요청 voteNo=", voteNo);
	    
	    $.ajax({
	        url: ctx + '/practice/api/vote-option/remove',
	        method: 'POST',
	        data: { voteNo: voteNo },
	        dataType: 'json'
	    }).done(function(res){
	    	console.log("삭제 응답:", res);
	        if (res.success) {
	            $btn.closest('.fav-item').slideUp(200, function(){ $(this).remove(); });
	            alert(res.message);
	        } else {
	            alert(res.message);
	        }
	    }).fail(function(xhr, status, err){
	        console.error('삭제 실패', status, err);
	        alert('서버 오류가 발생했습니다.');
	    });
	});
	</script>

</body>
</html>
