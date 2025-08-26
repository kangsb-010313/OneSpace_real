<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 연습실찜하기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/practice4_list.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
  <c:set var="CTX" value="${pageContext.request.contextPath}" />
  
  <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
  
  
</head>
<body class="page-practice4">
  <div class="wrap">
    <header>
    <c:import url="/WEB-INF/views/include/header.jsp" />
    </header>
    
    <main>
      <div class="container">
        <div class="main-section">
          <div class="content-area">
            <div class="filter-bar">
              <button class="btn-list" disabled>찜리스트<span style="color:#ff3333;">❤</span></button>
            </div>
            <div class="container">
              <div id="content">
                <div id="team-aside">
                  <h2>팀페이지</h2>
                  <div class="team-list-section">
                    <a href="#" class="btn-outline3 teamlist-btn">팀 원밀리언</a>
                    <a href="#" class="btn-outline3 teamlist-btn">팀 저스트절크</a>
                  </div>
                  <a href="#" class="btn-outline2 teamadd-btn">팀 등록하기</a>
                </div>
                <div id="main-content">
                  <div class="page-title">찜리스트</div>
                  <div style="width: 90%; border-bottom: 1px solid #e4e2ef; margin-left: 30px;"></div>
                  <br>
                  <div class="two-col">
                    <div class="practice-card-list">
                      
                      <c:forEach var="space" items="${favoriteSpaces}">
	                      <div class="practice-card card-bordered">
						
						
						    <c:set var="imgUrlRaw" value="${space.imageUrl}" />
							<c:set var="spaceLink" value="${space.spaceLink}" />
							
							<c:choose>
							  
							  <c:when test="${not empty spaceLink}">
							    <img src="${CTX}/assets/images/${spaceLink}" alt="${space.spaceName}" class="practice-card-img"
							         style="width:100%; height:120px; object-fit:cover; border-radius:6px;"
							         onerror="this.onerror=null;this.src='${CTX}/assets/images/placeholder.jpg'"/>
							  </c:when>
							
							  <c:otherwise>
							    <img src="${CTX}/assets/images/placeholder.jpg" alt="placeholder" class="practice-card-img"
							         style="width:100%; height:120px; object-fit:cover; border-radius:6px;"/>
							  </c:otherwise>
							</c:choose>
							
						    <div class="practice-card-body">
						      <div class="practice-card-title">${space.spaceName}</div>
						      <div class="practice-card-meta">${space.address}</div>
						      <div class="practice-card-price">
						        <span class="price-highlight">7,000~12,000</span> 원/시간
						        <span class="price-sub">&nbsp; 실외화 가능/주차/최대7인</span>
						      </div>
						    </div>
						
						    <div class="card-actions">
						      <button class="btn-outline btn-pill-sm open-schedule" data-spaces-no="${space.spacesNo}" data-room-no="${space.roomNo}">날짜 시간 추가</button>
						      <!-- <button class="btn-like btn-pill-sm" data-spaces-no="${space.spacesNo}">찜해제</button>  -->
						      <button class="btn-like btn-pill-sm" type="button" data-spaces-no="${space.spacesNo}" data-room-no="${space.roomNo}">찜해제</button>
						    </div>
						  </div>
						</c:forEach>
						
						<c:if test="${empty favoriteSpaces}">
						  <div style="padding:16px;color:#888;">찜한 연습실이 없습니다.</div>
						</c:if>
					
                    </div>
                    <section class="fav-panel">
                      <div class="fav-title">#내가 찜한 연습실 후보</div>
                      <ol class="fav-list">
                        <c:forEach var="c" items="${favoriteCandidates}" varStatus="loop">
						  <li class="fav-item">
						    <div>
						      <div class="fav-item-title">${loop.count}. ${c.spaceName}</div>
						      <div class="fav-item-meta">
						        <fmt:formatDate value="${c.voteDate}" pattern="yyyy/MM/dd"/>
						        <span class="fav-time">${c.startHour}:00~${c.endHour}:00</span>
						        <span class="fav-duration">${c.durationHours}시간</span>
						      </div>
						    </div>
						    <div class="fav-right">
						      <div class="fav-hot">🔥 <b>${c.hotCount}</b></div>
						      <div class="fav-price">가격:
						        <fmt:formatNumber value="${c.totalPrice}" type="number"/>
						      </div>
						    </div>
						  </li>
						</c:forEach>
						<c:if test="${empty favoriteCandidates}">
						  <li class="fav-item" style="color:#888;">선택한 후보가 없습니다.</li>
						</c:if>
                      </ol>
                    </section>
                  </div>
                  <br><br>
                  <div class="cta-row">
                    <button class="btn-outline btn-primary" onclick="location.href='${pageContext.request.contextPath}/onespace/teams/1/posts/5'">투표 만들기</button>
                    <button class="btn-outline btn-pill" onclick="location.href='${pageContext.request.contextPath}/onespace/practice1_main'">취소</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    <div id="scheduleModal" class="sched-overlay" role="dialog" aria-modal="true" aria-hidden="true">
      <div class="sched-modal" onclick="event.stopPropagation()">
        <div class="sched-month">
          <button class="sched-nav" data-dir="prev" aria-label="이전 달">‹</button>
          <div class="sched-title" id="schedTitle">2025.08</div>
          <button class="sched-nav" data-dir="next" aria-label="다음 달">›</button>
        </div>
        <div class="sched-week"><span>일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span></div>
        <div class="sched-days" id="schedDays"></div>
        <br>
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
        <div class="sched-summary">
          <div class="label">#선택 일정</div>
          <div class="rows">
            <div id="schedDate">2025/08/20(수)</div>
            <div id="schedTime">14시~16시</div>
            <div id="schedPrice">12,000 원</div>
          </div>
        </div>
        <div class="sched-actions">
          <button class="btn primary" id="schedSubmit">선택</button>
          <button class="btn" id="schedClose">닫기</button>
        </div>
      </div>
    </div>
    
    <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
    </footer>
  </div>
  
  <script>
$(document).ready(function(){

  const ctx = '${pageContext.request.contextPath}';
  const $overlay = $('#scheduleModal');
  const $schedDays = $('#schedDays');
  const $schedTitle = $('#schedTitle');
  const $schedSlots = $('#schedSlots');
  const $schedDate = $('#schedDate');
  const $schedTime = $('#schedTime');
  const $schedPrice = $('#schedPrice');
  const $schedSubmit = $('#schedSubmit');
  const $schedClose = $('#schedClose');

  // 날짜 변수
  let selectedDate = new Date();
  let calendarCursor = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);

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

    // 이전달 꼬리
    for(let i = leading - 1; i >= 0; i--){
      $('<span>').addClass('muted').text(prevLast - i).appendTo($schedDays);
    }

    // 이번달
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

    // 다음달 머리
    const used = $schedDays.children().length;
    for(let k = 1; k <= totalCells - used; k++){
      $('<span>').addClass('muted').text(k).appendTo($schedDays);
    }
  }

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
        url: ctx + '/onespace/api/room-slots',
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

    const $li = $('<li>')
        .addClass('slot')
        .attr('data-start', start)
        .attr('data-end', end)
        .attr('data-price', price)
        .html(pad2(start) + '~' + pad2(end) + '<span>(' + price.toLocaleString() + ')</span>');

    $schedSlots.append($li);
  }

  /* ------------------ 슬롯 클릭/선택 로직 ------------------ */
  function bindSlotClick(){
    $schedSlots.off('click', '.slot');
    $schedSlots.on('click', '.slot', function(){
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

    // 모달 열기
    $overlay.css('display','flex');

    // 캘린더 초기화
    initCalendarOnOpen();

    // 서버로 슬롯 요청 (기본적으로 오늘 선택)
    const tdate = toYYYYMMDD(selectedDate); // YYYY-MM-DD
    $overlay.data('room-no', roomNo); // store for later
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
	    url: ctx + '/onespace/api/vote-option',
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
    // 읽을 값
    const displayDate = toYYYYMMDD(selectedDate); // "YYYY-MM-DD" (서버와 DB에 저장될 포맷)
    const $selectedSlots = $schedSlots.find('.slot.selected');
    if ($selectedSlots.length === 0) {
      alert('시간을 선택하세요.');
      return;
    }

    // 연속 선택 가정: 시작시간 = min(selected.start), 끝시간 = max(start)+1
    const starts = $selectedSlots.map(function(){ return +this.dataset.start; }).get().sort((a,b)=>a-b);
    const startHour = starts[0];
    const endHour = (+$selectedSlots.last().attr('data-end')) || (starts[starts.length-1] + 1);

    // voteTime 포맷: "HH:MM~HH:MM"
    function pad2(n){ return String(n).padStart(2,'0'); }
    const voteTime = pad2(startHour) + ':00~' + pad2(endHour) + ':00';

    // roomNo는 overlay에 저장해 두었음
    const roomNo = $overlay.data('room-no');
    if (!roomNo) {
      alert('방 정보가 없습니다.');
      return;
    }

    // UI 잠금
    $schedSubmit.prop('disabled', true).text('저장중...');

    $.ajax({
      url: ctx + '/onespace/api/favorite-candidate',
      method: 'POST',
      data: {
        roomNo: roomNo,
        voteDate: displayDate,
        voteTime: voteTime
      },
      dataType: 'json'
    })
    .done(function(resp){
      if (resp && resp.success) {
        // 서버에 저장 성공 -> 우측 리스트에 항목 추가
        // 서버가 반환한 voteDate, voteTime, id 사용
        const rDate = resp.voteDate || displayDate;
        const rTime = resp.voteTime || voteTime;
        const newId = resp.id || null;

        // 표시 포맷(화면용)
        const displayDateStr = (function(d){
           // "YYYY-MM-DD" -> "YYYY/MM/DD(요일)"
           const parts = d.split('-');
           if (parts.length === 3) {
             const dd = new Date(+parts[0], (+parts[1]-1), +parts[2]);
             const week = ['일','월','화','수','목','금','토'][dd.getDay()];
             return parts[0] + '/' + parts[1].padStart(2,'0') + '/' + parts[2].padStart(2,'0') + '(' + week + ')';
           }
           return d;
        })(rDate);

        // 가격/시간/길이 등은 이미 화면에서 계산해 쓰면 됨.
        // 우측 .fav-list에 새 li 생성 (서버에 저장된 항목과 유사하게)
        const $li = $('<li class="fav-item">').html(
          '<div>' +
            '<div class="fav-item-title">__NUM__ ' + $('<div>').text($overlay.data('space-name') || '연습실').html() + '</div>' +
            '<div class="fav-item-meta">' +
              '<span class="fav-date">' + $('<div>').text(displayDateStr).html() + '</span> ' +
              '<span class="fav-time">' + $('<div>').text(rTime).html() + '</span>' +
            '</div>' +
          '</div>' +
          '<div class="fav-right">' +
            '<div class="fav-hot">🔥 <b>0</b></div>' +
            '<div class="fav-price">가격: -</div>' +
          '</div>'
        );

        const $favList = $('.fav-list');
        $favList.find('li').filter(function(){ return $(this).text().trim().indexOf('선택한 후보가 없습니다.') !== -1; }).remove();
        $favList.prepend($li);
        // 번호 재정렬
        $favList.find('li').each(function(index){
          const $t = $(this).find('.fav-item-title');
          const plain = $t.text().replace(/^\d+\.\s*/, '').trim();
          $t.text((index + 1) + '. ' + plain);
        });

        // 닫기 및 알림
        $overlay.hide();
        alert('후보가 저장되었습니다.');
      } else {
        alert(resp && resp.message ? resp.message : '저장 실패');
      }
    })
    .fail(function(xhr, status, err){
      console.error('favorite-candidate save fail', status, err);
      alert('서버 오류가 발생했습니다.');
    })
    .always(function(){
      $schedSubmit.prop('disabled', false).text('선택');
    });
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
      url: ctx + '/onespace/api/favorite/remove',
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
        alert(res.message || '찜 해제 완료');
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
</script>
  
</body>
</html>