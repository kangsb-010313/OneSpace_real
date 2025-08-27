<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 기본정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/host_info2.css">
</head>
<body>
<div id="wrap">

  <!-- 헤더 -->
  <c:import url="/WEB-INF/views/include/header.jsp" />

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

<!-- 안내 -->
<div class="maininfo-row"><div class="maininfo-guide">연습실 정보를 입력해주세요.</div></div>

<form action="${urlRoomSave}" method="post" enctype="multipart/form-data" id="roomForm">
  <input type="hidden" name="spacesNo" value="${spacesNo}"/>

  <!-- 기본 정보 -->
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

      <input id="space-image" type="text" placeholder="이미지 파일을 선택해주세요." readonly>

      <div class="attach-btn-wrap">
        <label class="btn-solid attach-btn">
          파일첨부
          <input type="file" id="spaceImages" name="photos" multiple accept=".jpg,.jpeg,.png" hidden>
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
        <!-- 기본 1행 -->
        <div class="price-row">
          <select class="select-day"  name="dayType">
            <option value="평일">평일</option>
            <option value="주말">주말</option>
          </select>

          <!-- 시간 셀렉트: 비워두고 JS로 채움 -->
          <select class="select-time" name="startTime" required></select>
          <span class="text-label">부터</span>
          <select class="select-time" name="endTime" required></select>
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

  <!-- 푸터 -->
  <c:import url="/WEB-INF/views/include/footer.jsp" />
</div>

<script>
/* 1) 파일명 표시(멀티) — 기초버전 */
(function () {
  const section   = document.querySelector('section.img-section');
  if (!section) return;
  const fileInput = section.querySelector('#spaceImages');
  const textInput = section.querySelector('#space-image');
  if (!fileInput || !textInput) return;

  fileInput.addEventListener('change', function () {
    const files = Array.from(fileInput.files || []);
    if (!files.length) { textInput.value = ''; return; }
    textInput.value = files.length === 1 ? files[0].name : (files[0].name + ' 외 ' + (files.length - 1) + '개');
  });
})();

/* 2) 시간 옵션 — 전부 JS로 생성(00~23시, 종료 24시는 23:59) */
function pad2(n){ return (n < 10 ? '0' : '') + n; }

function fill_time_select(select_el, is_end){
  if (!select_el) return;
  select_el.innerHTML = '';
  const max = is_end ? 24 : 23;
  for (let h = 0; h <= max; h++){
    const opt = document.createElement('option');
    if (is_end && h === 24){
      opt.value = '23:59';
      opt.textContent = '24시';
    } else {
      const hh = pad2(h);
      opt.value = hh + ':00';
      opt.textContent = hh + '시';
    }
    select_el.appendChild(opt);
  }
}

function fill_all_time_selects(scope){
  const root = scope || document;
  root.querySelectorAll('select[name="startTime"]').forEach(el => fill_time_select(el, false));
  root.querySelectorAll('select[name="endTime"]').forEach(el => fill_time_select(el, true));
}

/* 3) 추가하기 — 새 행에도 즉시 옵션 주입 */
document.addEventListener('DOMContentLoaded', function(){
  // 최초 1행 채우기
  fill_all_time_selects();

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

    // 방금 추가된 행에 시간 옵션 채우기
    fill_all_time_selects(row);
  });
});
</script>
</body>
</html>
