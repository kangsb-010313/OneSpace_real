<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 기본정보</title>
  <link rel="stylesheet" href="../../../assets/css/reset.css">
  <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
  <link rel="stylesheet" href="../../../assets/css/host_info2.css">
</head>
<body>
<div id="wrap">

  <!-- 헤더 영역------------------------------------------------ -->
  <c:import url="/WEB-INF/views/include/header.jsp" />
  <!-- /헤더 영역------------------------------------------------ -->

  <!-- 컨텐츠 영역---------------------------------------------- -->
  <main>
    <div class="container">

<c:url var="urlSpacesNew"  value="/onespace/hostcenter/spaces/new"/>
<c:url var="urlSpacesList" value="/onespace/hostcenter/spaces"/>
<c:url var="urlRoomSave"   value="/onespace/hostcenter/rooms/save"/>

<!-- 탭 -->
<div class="tab-btns">
  <button class="tab"        type="button" onclick="location.href='${urlSpacesNew}'">기본 정보 관리</button>
  <button class="tab active" type="button" onclick="location.href='${urlSpacesList}'">내 공간 관리</button>
</div>

<!-- 타이틀 -->
<div class="main-title-box"><h2 class="main-title">연습실 등록</h2></div>

<!-- 안내문구 -->
<div class="maininfo-row"><div class="maininfo-guide">연습실 정보를 입력해주세요.</div></div>

<!-- 저장 폼 -->
<form action="${urlRoomSave}" method="post" enctype="multipart/form-data" id="roomForm">
  <input type="hidden" name="spacesNo" value="${spacesNo}"/>

  <!-- 공간정보 -->
  <section class="form-section">
    <div class="input-group">
      <label for="room-name">연습실명</label>
      <span class="char-count">1자/50자</span>
      <input id="room-name" name="roomName" type="text" maxlength="50"
             placeholder="연습실/룸 이름을 입력해주세요." required>
    </div>

    <div class="input-group">
      <label for="room-detail">연습실 소개</label>
      <span class="char-count">0자/500자(최소 20자)</span>
      <textarea id="room-detail" name="roomInfo" rows="4" maxlength="500"
                placeholder="게스트들에게 필요한 정보를 상세하게 소개해주세요."></textarea>
    </div>

    <div class="input-group">
      <label for="room-area">면적(평/㎡)</label>
      <span class="char-count">0자/20자</span>
      <input id="room-area" name="area" type="text" maxlength="20" placeholder="예) 20평">
    </div>
  </section>

	<!-- 이미지 -->
	<section class="form-section img-section">
	  <div class="input-group">
	    <div class="input-label-row">
	      <label>이미지</label>
	      <span class="char-count img-guide">
	        2048 * 1158 권장, 최대 3MB (최대 5장)<br>이미지 파일(JPG, PNG, JPEG)
	      </span>
	    </div>
	
	    <!-- 파일명 표시용 span 추가 -->
	    <input id="space-image" type="text" placeholder="이미지 파일을 선택해주세요." readonly>
	    
	
	    <div class="attach-btn-wrap">
	      <label class="btn-solid attach-btn">
	        파일첨부
	        <input type="file" id="spaceImages" name="files" multiple accept=".jpg,.jpeg,.png" hidden>
	      </label>
	    </div>
	  </div>
	</section>


  <!-- 이용 정보 -->
  <div class="maininfo-row"><h3 class="maininfo-guide">이용 정보를 입력해주세요.</h3></div>
  <div class="useinfo-wrap">
    <!-- 최대인원 -->
    <div class="row-block center-align">
      <div class="row-label-wrap"><label class="row-label">최대인원</label></div>
      <select class="select-box" name="capacity" required>
        <option disabled selected>인원 선택 (5, 7, 15, 20명 중 골라주세요.)</option>
        <option value="5">5명</option>
        <option value="7">7명</option>
        <option value="15">15명</option>
        <option value="20">20명</option>
      </select>
    </div>

    <!-- 요일별 금액 -->
	<div class="row-block center-align">
	  <div class="row-label-wrap">
	    <label class="row-label">요일 별 금액</label>
	    <button class="btn-add" type="button" id="btnAddPrice">추가하기</button>
	  </div>
	
	  <div class="price-row-wrap" id="priceWrap">
	    <div class="price-row">
	      <select class="select-day"  name="dayType">
	        <option>평일</option>
	        <option>주말</option>
	      </select>
	
	     <!-- 시작 시간: 00~23시 -->
		<select class="select-time" name="startTime" required>
		  <c:forEach var="h" begin="0" end="23">
		    <option value="${h lt 10 ? '0' : ''}${h}:00">
		      <c:out value="${h lt 10 ? '0' : ''}${h}"/>시
		    </option>
		  </c:forEach>
		</select>
		
		<span class="text-label">부터</span>
		
		<!-- 종료 시간: 00~23시는 HH:00, 24시는 23:59 -->
		<select class="select-time" name="endTime" required>
		  <c:forEach var="h" begin="0" end="24">
		    <c:choose>
		      <c:when test="${h == 24}">
		        <option value="23:59">24시</option>
		      </c:when>
		      <c:otherwise>
		        <option value="${h lt 10 ? '0' : ''}${h}:00">
		          <c:out value="${h lt 10 ? '0' : ''}${h}"/>시
		        </option>
		      </c:otherwise>
		    </c:choose>
		  </c:forEach>
		</select>


      <span class="text-label">까지</span>

      <input type="text" class="input-price" name="hourlyPrice" placeholder="금액을 설정해주세요.">
    </div>
  </div>
</div>

  </div>

  <!-- 버튼 -->
  <div class="btn-row">
    <button class="btn prev-btn" type="button" onclick="location.href='${urlSpacesList}'">이전</button>
    <button class="btn save-btn" type="submit">저장</button>
  </div>
</form>

    </div>
  </main>
  <!-- /컨텐츠 영역---------------------------------------------- -->

  <!-- 푸터 영역------------------------------------------------ -->
  <c:import url="/WEB-INF/views/include/footer.jsp" />
  <!-- /푸터 영역------------------------------------------------ -->

</div>

<script>
/* =========================================
   1) 공간 이미지 파일명 표시(멀티)
   - file input : <input type="file" id="spaceImages" name="files" multiple hidden>
   - 표시 input : <input id="space-image" ...>
   - (선택) span : <span id="spaceImageName">...</span>
   - (선택) 가이드 : <div id="imgGuideText">...</div>
   ========================================= */
(function () {
  const section   = document.querySelector('section.form-section.img-section');
  if (!section) return;

  const fileInput = section.querySelector('#spaceImages')
                 || section.querySelector('input[type="file"][name="files"]');
  const textInput = section.querySelector('#space-image');
  const nameSpan  = section.querySelector('#spaceImageName'); // 없으면 무시
  const guideText = section.querySelector('#imgGuideText');   // 없으면 무시

  const existing = (textInput && textInput.value || '').trim();
  if (existing && guideText) guideText.style.display = 'none';

  if (!fileInput || !textInput) return;

  fileInput.addEventListener('change', function () {
    const files = Array.from(fileInput.files || []);
    if (files.length === 0) {
      if (!existing) {
        textInput.value = '';
        if (nameSpan)  nameSpan.textContent = '';
        if (guideText) guideText.style.display = 'block';
      }
      return;
    }

    // 여러 개면 "첫파일명 외 N개"
    const label = (files.length === 1)
      ? files[0].name
      : (files[0].name + ' 외 ' + (files.length - 1) + '개');

    textInput.value = label;          // 값이 들어가면 placeholder는 자동으로 숨김
    if (nameSpan)  nameSpan.textContent = label;
    if (guideText) guideText.style.display = 'none';

    // 프레임워크 호환(선택)
    textInput.dispatchEvent(new Event('input',  { bubbles: true }));
    textInput.dispatchEvent(new Event('change', { bubbles: true }));
  });
})();

/* =========================================
   2) 시간 옵션 유틸 (00~23시, 종료는 24시 표시)
   - 서버 EL 안 쓰고, JS로 옵션을 채워서
     "시만 보이는" 문제를 원천 차단
   ========================================= */
(function(){
  // 옵션 HTML 캐시 (중복생성 방지)
  const HOUR_OPTIONS_START = (function(){
    if (window.__HOUR_OPTIONS_START) return window.__HOUR_OPTIONS_START;
    let s = '';
    for (let h = 0; h <= 23; h++) {
      const hh = String(h).padStart(2, '0');
      s += `<option value="${hh}:00">${hh}시</option>`;
    }
    return (window.__HOUR_OPTIONS_START = s);
  })();

  const HOUR_OPTIONS_END = (function(){
    if (window.__HOUR_OPTIONS_END) return window.__HOUR_OPTIONS_END;
    let s = '';
    for (let h = 0; h <= 24; h++) {
      if (h === 24) {
        s += `<option value="23:59">24시</option>`;
      } else {
        const hh = String(h).padStart(2, '0');
        s += `<option value="${hh}:00">${hh}시</option>`;
      }
    }
    return (window.__HOUR_OPTIONS_END = s);
  })();

  // 셀렉트가 비었거나 "시" 같은 잘못된 항목만 있을 때 채워 넣기
  function ensureTimeOptions(selectEl, isEnd) {
    if (!selectEl || selectEl.dataset.filled === '1') return;
    const needsFill =
      !selectEl.options.length ||
      Array.from(selectEl.options).every(o => (o.textContent || '').trim() === '시');

    if (needsFill) {
      selectEl.innerHTML = isEnd ? HOUR_OPTIONS_END : HOUR_OPTIONS_START;
      selectEl.dataset.filled = '1';
    }
  }

  // 페이지 최초에 이미 존재하는 모든 시간 셀렉트 보정
  function initExistingRows() {
    document.querySelectorAll('select[name="startTime"]').forEach(sel => ensureTimeOptions(sel, false));
    document.querySelectorAll('select[name="endTime"]').forEach(sel => ensureTimeOptions(sel, true));
  }

  // =========================================================
  // 3) 요일별 금액 '추가하기' 버튼: 새 행 생성 시에도 시간 옵션 주입
  //    - 컨테이너 : <div id="priceWrap">
  //    - 버튼     : <button type="button" id="btnAddPrice">추가하기</button>
  //    - 생성 값  : start HH:00, end HH:00(0~23) / 23:59(24시)
  // =========================================================
  function setupAddRow() {
    const priceWrap = document.getElementById('priceWrap');
    const addBtn    = document.getElementById('btnAddPrice');
    if (!priceWrap || !addBtn) return;

    addBtn.addEventListener('click', function(){
      const row = document.createElement('div');
      row.className = 'price-row';
      row.innerHTML =
          '<select class="select-day" name="dayType">'
        +   '<option value="평일">평일</option><option value="주말">주말</option>'
        + '</select>'
        + '<select class="select-time" name="startTime" required></select>'
        + '<span class="text-label">부터</span>'
        + '<select class="select-time" name="endTime" required></select>'
        + '<span class="text-label">까지</span>'
        + '<input type="text" class="input-price" name="hourlyPrice" placeholder="금액을 설정해주세요.">';

      priceWrap.appendChild(row);

      // 새로 추가된 행의 시간 셀렉트 채우기
      const startSel = row.querySelector('select[name="startTime"]');
      const endSel   = row.querySelector('select[name="endTime"]');
      ensureTimeOptions(startSel, false);
      ensureTimeOptions(endSel, true);
    });
  }

  // 초기화
  document.addEventListener('DOMContentLoaded', function(){
    initExistingRows();
    setupAddRow();
  });
})();
</script>





</body>
</html>
