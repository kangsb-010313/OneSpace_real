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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/practice.css">	
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
  <c:set var="CTX" value="${pageContext.request.contextPath}" />
  
  <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-3.7.1.js"></script>
  
  
</head>
<body class="page-practice4">
  <div class="wrap">
    <header><c:import url="/WEB-INF/views/include/header.jsp" /></header>
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
						      <button class="btn-like btn-pill-sm" data-spaces-no="${space.spacesNo}">찜해제</button>
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
    <footer><c:import url="/WEB-INF/views/include/footer.jsp" /></footer>
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
  function loadSlots(roomNo, targetDate){
    console.log('[sched] loadSlots', roomNo, targetDate);
    $schedSlots.empty();
    // AJAX: POST form-encoded (현재 컨트롤러와 맞춤)
    $.ajax({
      url: ctx + '/onespace/api/room-slots',
      type: 'POST',
      data: { roomNo: roomNo, targetDate: targetDate },
      dataType: 'json'
    }).done(function(slotList){
      console.log('[sched] slotList', slotList);
      if (!Array.isArray(slotList) || slotList.length === 0) {
        $schedSlots.append('<li style="color:#888;padding:8px;">해당 날짜에 등록된 요금 정보가 없습니다.</li>');
        updateSummaryAndState();
        return;
      }
      // 렌더
      slotList.forEach(function(slot){
        renderSlot(slot);
      });
      bindSlotClick();
      updateSummaryAndState();
    }).fail(function(xhr, status, err){
      console.error('[sched] loadSlots fail', status, err);
      $schedSlots.append('<li style="color:#c00;padding:8px;">슬롯 조회 실패</li>');
    });
  }

  function renderSlot(slotVO){
    // slotVO의 필드명이 다양할 수 있으니 여러 가능성 체크
    const start = (slotVO.startHour!==undefined)? +slotVO.startHour :
                  (slotVO.start!==undefined)? +slotVO.start :
                  (slotVO.hour!==undefined)? +slotVO.hour :
                  (slotVO.startNo!==undefined)? +slotVO.startNo : 0;
    const price = (slotVO.price!==undefined)? +slotVO.price :
                  (slotVO.hourlyPrice!==undefined)? +slotVO.hourlyPrice : 0;
    const end = start + 1;

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
    alert($schedDate.text() + ' ' + $schedTime.text() + ' / ' + $schedPrice.text() + ' 선택되었습니다.');
    $overlay.hide();
  });

  // 초기 캘린더 렌더
  renderCalendar();

}); // document.ready
</script>
  
</body>
</html>