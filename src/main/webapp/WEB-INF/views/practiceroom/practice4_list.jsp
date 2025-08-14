<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 연습실찜하기</title>
  <link rel="stylesheet" href="../../assets/css/reset.css">
  <link rel="stylesheet" href="../../assets/css/practice.css">
  <link rel="stylesheet" href="../../assets/css/asidedefault.css">
  <link rel="stylesheet" href="../../assets/css/basicdefault.css">

</head>
<body class="page-practice4">
  <div class="wrap">
    <!-- 헤더 영역------------------------------------------------ -->
    <header>
      <div class="container">
        <div class="header-inner">
          <h1 class="logo">
            <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice1_main.html">원 스페이스</a>
          </h1>
          <div class="header-right">
            <nav class="nav">
              <ul>
                <li>
                  <a class="click" href="#">팀페이지</a>
                </li>
                <li>
                  <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice1_main.html">연습실찜하기</a>
                </li>
                <li>
                  <a href="#">공연 및 대회 정보</a>
                </li>
                <li>
                  <a href="#">팀자랑</a>
                </li>
              </ul>
            </nav>
            <div class="header-buttons">
              <span class="username">강수빈 님</span>
              <div class="host-signup-group">
                <a href="#" class="btn-outline host-btn">호스트센터</a>
                <a href="#" class="btn-outline signup-btn">로그아웃</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </header>
    <!-- /헤더 영역------------------------------------------------ -->

    <!-- 본문 -->
    <main>
      <div class="container">
        <div class="main-section">
          <div class="content-area">
            <div class="filter-bar">
              <button class="btn-list" onclick="location.href='file:///C:/javaStudy/onespace_front/views/practiceroom/practice4_list.html'">
                찜리스트<span style="color:#ff3333;">❤</span>
              </button>
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

                <!-- 우측: 본문 -->
                <div id="main-content">
                  <div class="page-title">찜리스트</div>
                  <div style="width: 90%; border-bottom: 1px solid #e4e2ef; margin-left: 30px;"></div>
                  <br>

                  <!-- 본문 2열 -->
                  <div class="two-col">
                    <!-- 왼쪽: 카드들 -->
                    <div class="practice-card-list">
                      <!-- 카드 1 -->
                      <div class="practice-card card-bordered">
                        <img src="../../assets/images/연습실찜하기사진03.jpg" alt="픽스튜디오" class="practice-card-img">
                        <div class="practice-card-body">
                          <div class="practice-card-title">네스트 연습실 101호</div>
                          <div class="practice-card-meta">강동구</div>
                          <div class="practice-card-price">
                            <span class="price-highlight">7,000~12,000</span> 원/시간
                            <span class="price-sub">&nbsp; 실외화 가능/주차/최대7인</span>
                          </div>
                        </div>
                        <div class="card-actions">
                          <button class="btn-outline btn-pill-sm open-schedule">날짜 시간 추가</button>
                          <button class="btn-like btn-pill-sm">찜해제</button>
                        </div>
                      </div>

                      <!-- 카드 2 -->
                      <div class="practice-card card-bordered">
                        <img src="../../assets/images/연습실찜하기사진03.jpg" alt="픽스튜디오" class="practice-card-img">
                        <div class="practice-card-body">
                          <div class="practice-card-title">네스트 연습실 102호</div>
                          <div class="practice-card-meta">강동구</div>
                          <div class="practice-card-price">
                            <span class="price-highlight">7,000~12,000</span> 원/시간
                            <span class="price-sub">&nbsp; 실외화 가능/주차/최대7인</span>
                          </div>
                        </div>
                        <div class="card-actions">
                          <button class="btn-outline btn-pill-sm open-schedule">날짜 시간 추가</button>
                          <button class="btn-like btn-pill-sm">찜해제</button>
                        </div>
                      </div>
                    </div>

                    <!-- 오른쪽: 찜 후보 리스트 -->
                    <section class="fav-panel">
                      <div class="fav-title">#내가 찜한 연습실 후보</div>
                      <ol class="fav-list">
                        <li class="fav-item">
                          <div>
                            <div class="fav-item-title">1. 네스트 연습실 101호</div>
                            <div class="fav-item-meta">
                              8/5(월)
                              <span class="fav-time">15:00~17:00</span>
                              <span class="fav-duration">2시간</span>
                            </div>
                          </div>
                          <div class="fav-right">
                            <div class="fav-hot">🔥 <b>5</b></div>
                            <div class="fav-price">가격: 16,000</div>
                          </div>
                        </li>
                        <li class="fav-item">
                          <div>
                            <div class="fav-item-title">2. 네스트 연습실 101호</div>
                            <div class="fav-item-meta">
                              8/5(월)
                              <span class="fav-time">18:00~20:00</span>
                              <span class="fav-duration">2시간</span>
                            </div>
                          </div>
                          <div class="fav-right">
                            <div class="fav-hot">🔥 <b>3</b></div>
                            <div class="fav-price">가격: 16,000</div>
                          </div>
                        </li>
                        <li class="fav-item">
                          <div>
                            <div class="fav-item-title">3. 네스트 연습실 102호</div>
                            <div class="fav-item-meta">
                              8/6(화)
                              <span class="fav-time">15:00~17:00</span>
                              <span class="fav-duration">2시간</span>
                            </div>
                          </div>
                          <div class="fav-right">
                            <div class="fav-hot">🔥 <b>3</b></div>
                            <div class="fav-price">가격: 16,000</div>
                          </div>
                        </li>
                      </ol>
                    </section>
                  </div>
                  <br><br>

                  <!-- 하단 액션 -->
                  <div class="cta-row">
                    <button class="btn-outline btn-primary">투표 만들기</button>
                    <button class="btn-outline btn-pill" onclick="location.href='../../views/practiceroom/practice1_main.html'">취소</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- /content-area -->
        </div>
        <!-- /main-section -->
      </div>
    </main>
  </div>

  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <div class="container">
      <div class="footer-top">
        <span class="footer-logo">원 스페이스</span>
        <span class="footer-links">
          배너광고 문의 | 이용약관 | 개인정보처리방침 | 운영정책 | 콘텐츠산업진흥법에 의한 표시 | 고객 문의
        </span>
      </div>
      <div class="footer-info">
        상호명: 주식회사 춤사위 | 대표: 홍길동 | 사업자등록번호: 230-81-10313 | 통신판매업신고번호: 2025-서울영등포-1093<br>
        영업소재지: 서울특별시 강동구 천호대로 1027 5층 501호 | 이메일: cheonho@onespace.kr | 제휴문의: marketing@onespace.kr<br>
        대표전화: 1599-1234(평일 오후 2시 ~ 오후 6시) | 온라인 1:1 문의 바로가기(평일 오전 10시 ~ 오후 6시)<br>
      </div>
      <div class="footer-warning">
        원스페이스는 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 원스페이스는 공간 거래정보 및 거래에 대해 책임지지 않습니다.
      </div>
      <div class="footer-copy">
        Copyright 춤사위 Corp.All Rights Reserved.
      </div>
    </div>
  </footer>
  <!-- /푸터 영역------------------------------------------------ -->


  <!-- 일정 선택 모달 -->
  <div id="scheduleModal" class="sched-overlay" role="dialog" aria-modal="true" aria-hidden="true">
    <div class="sched-modal" onclick="event.stopPropagation()">
      <div class="sched-month">
        <button class="sched-nav" data-dir="prev" aria-label="이전 달">‹</button>
        <div class="sched-title" id="schedTitle">2025.08</div>
        <button class="sched-nav" data-dir="next" aria-label="다음 달">›</button>
      </div>
      <div class="sched-week">
        <span>일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span>
      </div>
      <div class="sched-days" id="schedDays"></div>
      <br>
      <ul class="sched-slots" id="schedSlots">
        <li class="slot" data-start="0"  data-end="1"  data-price="4000">00~01<span>(4,000)</span></li>
        <li class="slot" data-start="1"  data-end="2"  data-price="4000">01~02<span>(4,000)</span></li>
        <li class="slot" data-start="2"  data-end="3"  data-price="4000">02~03<span>(4,000)</span></li>
        <li class="slot" data-start="3"  data-end="4"  data-price="4000">03~04<span>(4,000)</span></li>

        <li class="slot" data-start="4"  data-end="5"  data-price="4000">04~05<span>(4,000)</span></li>
        <li class="slot" data-start="5"  data-end="6"  data-price="4000">05~06<span>(4,000)</span></li>
        <li class="slot" data-start="6"  data-end="7"  data-price="4000">06~07<span>(4,000)</span></li>
        <li class="slot" data-start="7"  data-end="8"  data-price="4000">07~08<span>(4,000)</span></li>

        <li class="slot" data-start="8"  data-end="9"  data-price="6000">08~09<span>(6,000)</span></li>
        <li class="slot" data-start="9"  data-end="10" data-price="6000">09~10<span>(6,000)</span></li>
        <li class="slot" data-start="10" data-end="11" data-price="6000">10~11<span>(6,000)</span></li>
        <li class="slot" data-start="11" data-end="12" data-price="6000">11~12<span>(6,000)</span></li>

        <li class="slot" data-start="12" data-end="13" data-price="6000">12~13<span>(6,000)</span></li>
        <li class="slot" data-start="13" data-end="14" data-price="6000">13~14<span>(6,000)</span></li>
        <li class="slot" data-start="14" data-end="15" data-price="6000">14~15<span>(6,000)</span></li>
        <li class="slot" data-start="15" data-end="16" data-price="6000">15~16<span>(6,000)</span></li>

        <li class="slot" data-start="16" data-end="17" data-price="6000">16~17<span>(6,000)</span></li>
        <li class="slot" data-start="17" data-end="18" data-price="6000">17~18<span>(6,000)</span></li>
        <li class="slot" data-start="18" data-end="19" data-price="6000">18~19<span>(6,000)</span></li>
        <li class="slot" data-start="19" data-end="20" data-price="6000">19~20<span>(6,000)</span></li>

        <li class="slot" data-start="20" data-end="21" data-price="6000">20~21<span>(6,000)</span></li>
        <li class="slot" data-start="21" data-end="22" data-price="6000">21~22<span>(6,000)</span></li>
        <li class="slot" data-start="22" data-end="23" data-price="6000">22~23<span>(6,000)</span></li>
        <li class="slot" data-start="23" data-end="24" data-price="6000">23~24<span>(6,000)</span></li>
      </ul>

      <div class="sched-summary">
        <div class="label">#선택 일정</div>
        <div class="rows">
          <div id="schedDate">2025/08/05(화)</div>
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

  <script>
    // ----- 달력 상태 -----
    const schedTitle = document.getElementById('schedTitle');
    const schedDays  = document.getElementById('schedDays');
    const navBtns    = document.querySelectorAll('.sched-nav');

    let selectedDate = new Date();
    let currentDate  = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);

    const WEEKDAY_KR = ['일','월','화','수','목','금','토'];
    const pad = n => n.toString().padStart(2,'0');
    const formatTitle = d => `${d.getFullYear()}.${pad(d.getMonth()+1)}`;
    const formatSummaryDate = d => {
      const y = d.getFullYear(), m = pad(d.getMonth()+1), day = pad(d.getDate()), w = WEEKDAY_KR[d.getDay()];
      return `${y}/${m}/${day}(${w})`;
    };

    function renderCalendar(){
      schedTitle.textContent = formatTitle(currentDate);
      schedDays.innerHTML = '';

      const year  = currentDate.getFullYear();
      const month = currentDate.getMonth();

      const first = new Date(year, month, 1);
      const last  = new Date(year, month+1, 0);

      const leading  = first.getDay();
      const prevLast = new Date(year, month, 0).getDate();

      const totalCells = 42;
      const thisCount  = last.getDate();

      for(let i=leading-1; i>=0; i--){
        const day = document.createElement('span');
        day.className = 'muted';
        day.textContent = prevLast - i;
        schedDays.appendChild(day);
      }

      for(let d=1; d<=thisCount; d++){
        const day = document.createElement('span');
        day.textContent = d;

        const today = new Date();
        if (year===today.getFullYear() && month===today.getMonth() && d===today.getDate()){
          day.classList.add('today');
        }
        if (year===selectedDate.getFullYear() && month===selectedDate.getMonth() && d===selectedDate.getDate()){
          day.classList.add('picked');
        }

        day.style.cursor = 'pointer';
        day.addEventListener('click', ()=>{
          selectedDate = new Date(year, month, d);
          renderCalendar();
          document.getElementById('schedDate').textContent = formatSummaryDate(selectedDate);
        });

        schedDays.appendChild(day);
      }

      const used = schedDays.children.length;
      for(let k=1; k<=totalCells-used; k++){
        const day = document.createElement('span');
        day.className = 'muted';
        day.textContent = k;
        schedDays.appendChild(day);
      }
    }

    navBtns.forEach(btn=>{
      btn.addEventListener('click', ()=>{
        const dir = btn.dataset.dir === 'prev' ? -1 : 1;
        currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth()+dir, 1);
        renderCalendar();
      });
    });

    function initCalendarOnOpen(){
      document.getElementById('schedDate').textContent = formatSummaryDate(selectedDate);
      currentDate = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);
      renderCalendar();
    }

    const overlay   = document.getElementById('scheduleModal');
    const openBtns  = document.querySelectorAll('.open-schedule');
    const closeBtn  = document.getElementById('schedClose');
    const submitBtn = document.getElementById('schedSubmit');

    openBtns.forEach(b=>b.addEventListener('click',()=>{
      overlay.style.display='flex';
      initCalendarOnOpen();
      updateSubmitState();
    }));
    overlay.addEventListener('click',()=>{ overlay.style.display='none'; });
    closeBtn.addEventListener('click',()=>{ overlay.style.display='none'; });

    const slots  = Array.from(document.querySelectorAll('#schedSlots .slot:not(.disabled)'));
    const dateEl = document.getElementById('schedDate');
    const timeEl = document.getElementById('schedTime');
    const priceEl= document.getElementById('schedPrice');

    const getSelected = () => slots.filter(s=>s.classList.contains('selected'));
    const toStarts    = arr => arr.map(s=>+s.dataset.start).sort((a,b)=>a-b);
    const isContiguous= starts => {
      if(starts.length===0) return true;
      const min=starts[0], max=starts[starts.length-1];
      return (max-min+1)===starts.length;
    };

    function updateSummary(){
      const selected = getSelected();
      if(selected.length===0){
        timeEl.textContent = '-';
        priceEl.textContent = '0 원';
        return;
      }
      const sorted = selected.sort((a,b)=>+a.dataset.start - +b.dataset.start);
      const start  = +sorted[0].dataset.start;
      const end    = +sorted[sorted.length-1].dataset.end;
      const total  = sorted.reduce((sum,s)=>sum+(+s.dataset.price||0),0);

      timeEl.textContent = `${start}시~${end}시`;
      priceEl.textContent = total.toLocaleString()+' 원';
    }

    function updateSubmitState(){
      const selStarts = toStarts(getSelected());
      const ok = selStarts.length === 3 && isContiguous(selStarts);
      submitBtn.disabled = !ok;
    }

    slots.forEach(s=>{
      s.addEventListener('click',()=>{
        const was = s.classList.contains('selected');
        s.classList.toggle('selected');

        const sel = getSelected();
        const starts = toStarts(sel);

        const withinLimit = starts.length <= 3;
        const contiguous  = isContiguous(starts);

        if(!(withinLimit && contiguous)){
          // 되돌리기
          s.classList.toggle('selected');
          if(!withinLimit) alert('최대 3시간까지 선택할 수 있습니다.');
          else alert('선택은 연속된 시간만 가능합니다.');
        }

        updateSummary();
        updateSubmitState();
      });
    });

    updateSummary();
    updateSubmitState();

    submitBtn.addEventListener('click',()=>{
      alert(`${dateEl.textContent} ${timeEl.textContent} / ${priceEl.textContent} 선택되었습니다.`);
      overlay.style.display='none';
    });
  </script>

</body>
</html>
