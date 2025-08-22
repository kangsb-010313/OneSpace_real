<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 기본정보</title>
  <link rel="stylesheet" href="../../../assets/css/reset.css">
  <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
  <link rel="stylesheet" href="../../../assets/css/host_info.css">
</head>
<body>
<div id="wrap">

  <!-- 헤더 영역------------------------------------------------ -->
  <c:import url="/WEB-INF/views/include/header.jsp" />
  <!-- /헤더 영역------------------------------------------------ -->

  <!-- 컨텐츠 영역---------------------------------------------- -->
  <main>
    <div class="container">

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   여기(main container)안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

<c:url var="urlSpacesNew" value="/onespace/hostcenter/spaces/new"/>
<c:url var="urlSpacesList" value="/onespace/hostcenter/spaces"/>
<c:url var="urlSaveSpace"  value="/onespace/hostcenter/spaces"/>

<!-- 탭 -->
<div class="tab-btns">
  <button class="tab active" type="button" onclick="location.href='${urlSpacesNew}'">기본 정보 관리</button>
  <button class="tab"        type="button" onclick="location.href='${urlSpacesList}'">내 공간 관리</button>
</div>

<!-- 타이틀 & 밑줄 -->
<div class="main-title-box"><h2 class="main-title">기본정보</h2></div>

<!-- 안내문구 & 체크박스 -->
<div class="maininfo-row">
  <div class="maininfo-guide">공간 정보를 입력해주세요.</div>
  <label class="maininfo-hide-label">
    검색창에 가려지기
    <input type="checkbox" class="maininfo-hide-chk">
  </label>
</div>

<!-- 회색 밑줄 -->
<div class="main-bottomline"></div>

<!-- 저장 가능한 폼 -->
<form action="${urlSaveSpace}" method="post" enctype="multipart/form-data">
  <!-- 수정일 때 hidden -->
  <c:if test="${not empty space.spacesno}">
    <input type="hidden" name="spacesno" value="${space.spacesno}">
  </c:if>

  <!-- 시설 체크박스 값을 콤마로 합쳐 담을 hidden -->
  <input type="hidden" name="facilities" id="facilitiesHidden"/>

  <!-- 공간정보 -->
  <section class="form-section">
    <div class="input-group">
      <label for="space-name">공간명</label>
      <span class="char-count">1자/18자</span>
      <input id="space-name" name="spacename" type="text" maxlength="18"
             value="${space.spacename}" placeholder="고유 업체명을 입력해주세요. (예: 인디워커스 하이브 회의실)" required>
    </div>
    <div class="input-group">
      <label for="space-desc">공간 한 줄 소개</label>
      <span class="char-count">0자/200자</span>
      <input id="space-desc" name="spacesummary" type="text" maxlength="500"
             value="${space.spacesummary}" placeholder="공간의 특징점을 한 문장으로 작성해주세요.">
    </div>
    <div class="input-group">
      <label for="space-detail">공간소개</label>
      <span class="char-count">0자/500자(최소 20자)</span>
      <textarea id="space-detail" name="spaceinfo" rows="4" maxlength="500"
                placeholder="게스트들에게 필요한 공간 정보를 상세하게 소개해주세요.">${space.spaceinfo}</textarea>
    </div>
  </section>

  <!-- 시설 안내 -->
  <section class="form-section">
    <div class="section-title">시설 안내</div>
    <div class="facility-list">
      <label><input type="checkbox" name="facility" value="음향/마이크">음향/마이크</label>
      <label><input type="checkbox" name="facility" value="의자/테이블">의자/테이블</label>
      <label><input type="checkbox" name="facility" value="화이트 보드">화이트 보드</label>
      <label><input type="checkbox" name="facility" value="전신 거울">전신 거울</label>
      <label><input type="checkbox" name="facility" value="조명">조명</label>
      <label><input type="checkbox" name="facility" value="탈의실">탈의실</label>
      <label><input type="checkbox" name="facility" value="주차">주차</label>
      <label><input type="checkbox" name="facility" value="인터넷/WIFI">인터넷/WIFI</label>
      <label><input type="checkbox" name="facility" value="TV/프로젝터">TV/프로젝터</label>
      <label><input type="checkbox" name="facility" value="내부 화장실">내부 화장실</label>
      <label><input type="checkbox" name="facility" value="금연">금연</label>
      <label><input type="checkbox" name="facility" value="장비 대여">장비 대여</label>
      <label><input type="checkbox" name="facility" value="실외화 가능">실외화 가능</label>
      <label><input type="checkbox" name="facility" value="외부음식 반입 금지">외부음식 반입 금지</label>
    </div>
  </section>

  <!-- 환불 규정 -->
  <section class="form-section">
    <div class="refund-row">
      <div>
        <b class="refund-title">환불 규정</b>
        <ul class="refund-list">
          <li>- 이용 2일 전: 결제 금액 100% 환불 가능</li>
          <li>- 이용 전날~당일: 환불 불가</li>
        </ul>
      </div>

      <label class="refund-check">
        <input type="checkbox" required> 환불 규정을 확인하고 이해했습니다.
      </label>
    </div>
  </section>

  <!-- 대표 이미지(선택) -->
  <section class="form-section img-section">
    <div class="img-header">
      <div class="section-title">대표 이미지</div>
      <span class="img-guide">2048 * 1158 권장, 최대 3MB <br>이미지 파일(JPG, PNG, JPEG)</span>
    </div>

    <div class="img-box">
      <div id="imgGuideText">
        <b>대표 이미지 등록 불가 유형</b>
        <ul>
          <li>- 텍스트, 로고, 도형이 합성된 이미지</li>
          <li>- 여러 이미지를 합성한 콜라주 이미지</li>
          <li>- 홍보물, 포스터 이미지</li>
          <li>- 지도 이미지</li>
          <li>- 노출 등 제 3자에게 수치심을 주는 이미지</li>
        </ul>
      </div>
      <span id="repImageName" class="file-name-inbox"></span>
    </div>

    <div class="attach-btn-wrap">
      <label class="btn-solid attach-btn">
        파일첨부
        <input type="file" id="repImage" name="repImage" hidden>
      </label>
    </div>
  </section>

  <!-- 주소 -->
  <section class="form-section">
    <div class="section-title">주소(위치)</div>
    <div class="addr-alert">
      공간 주소는 최초 등록 이후 직접 변경할 수 없습니다.
      <a href="#" class="blue-link">고객센터</a>를 통해 주소 변경을 요청해주세요.
    </div>

    <div class="addr-row">
      <input type="text" class="addr-input-long" name="address"
             value="${space.address}" placeholder="실제 서비스되는 공간의 주소를 입력해주세요." required>
      <button class="addr-btn" type="button">주소 등록</button>
    </div>
    <input type="text" class="addr-detail" name="addressdetail"
           value="${space.addressdetail}" placeholder="상세 주소">

    <!-- 필요하면 hidden 값 -->
    <input type="hidden" name="postcode"  value="${space.postcode}">
    <input type="hidden" name="spacelink" value="${space.spacelink}">
  </section>

  <!-- 연락처 이메일 -->
  <section class="contact-section">
    <div class="section-title">연락처 정보를 입력해 주세요.</div>
    <div class="contact-flex">
      <div class="email-row">
        <label>이메일</label>
        <div class="email-inputs">
          <input type="text" class="email-id" id="emailId" placeholder="id">
          <span class="at">@</span>
          <input type="text" class="email-domain" id="emailDomain" placeholder="domain">
          <select class="email-select" id="emailSelect">
            <option value="">직접입력</option>
            <option>gmail.com</option>
            <option>naver.com</option>
            <option>hanmail.net</option>
            <option>daum.net</option>
            <option>hotmail.com</option>
            <option>nate.com</option>
            <option>icloud.com</option>
          </select>
          <input type="hidden" name="email" id="emailFull" value="${space.email}">
        </div>
      </div>
    </div>

    <div class="phone-flex-row">
      <div class="phone-col">
        <label>휴대폰</label>
        <input type="text" name="phone" value="${space.phone}" placeholder="하이픈 빼고 입력해주세요.">
      </div>
      <div class="phone-col">
        <label class="phone-label-bold">
          대표전화
          <span class="same-phone">
            <input type="checkbox" id="same-phone">
            <span class="chk-label">휴대폰과 동일</span>
          </span>
        </label>
        <input type="text" name="tel" id="telInput" value="${space.tel}" placeholder="하이픈 빼고 입력해주세요.">
      </div>
    </div>
    <div class="phone-desc">해당 휴대폰으로 예약 관련 알림톡을 받아 보실 수 있습니다.</div>
  </section>

  <!-- 버튼 -->
  <div class="btn-row">
    <button class="btn prev-btn" type="button" onclick="location.href='${urlSpacesList}'">이전</button>
    <button class="btn save-btn" type="submit">저장</button>
  </div>
</form>

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

    </div>
  </main>
  <!-- /컨텐츠 영역---------------------------------------------- -->

  <!-- 푸터 영역------------------------------------------------ -->
  <c:import url="/WEB-INF/views/include/footer.jsp" />
  <!-- /푸터 영역------------------------------------------------ -->

</div>

<script>
  // 대표 이미지 파일명 표시
  (function() {
    const input = document.getElementById('repImage');
    const nameSpan = document.getElementById('repImageName');
    const guideText = document.getElementById('imgGuideText');
    if (!input) return;
    input.addEventListener('change', function () {
      if (this.files && this.files.length > 0) {
        nameSpan.textContent = this.files[0].name;
        if (guideText) guideText.style.display = 'none';
      } else {
        nameSpan.textContent = '';
        if (guideText) guideText.style.display = 'block';
      }
    });
  })();

  // 시설 체크박스 -> hidden(facilities) 콤마 문자열
  (function() {
    const form = document.querySelector('form[action$="/onespace/hostcenter/spaces"]');
    if (!form) return;
    form.addEventListener('submit', function() {
      const arr = Array.from(document.querySelectorAll('input[name="facility"]:checked'))
                       .map(el => el.value.trim());
      document.getElementById('facilitiesHidden').value = arr.join(',');

      // 이메일 합치기
      const id = (document.getElementById('emailId').value || '').trim();
      let domain = (document.getElementById('emailDomain').value || '').trim();
      const sel = document.getElementById('emailSelect').value;
      if (sel) domain = sel;
      const full = (id && domain) ? (id + '@' + domain) : (document.getElementById('emailFull').value || '');
      document.getElementById('emailFull').value = full;

      // 대표전화 = 휴대폰 동일
      const same = document.getElementById('same-phone').checked;
      if (same) {
        const phoneVal = document.querySelector('input[name="phone"]').value;
        document.getElementById('telInput').value = phoneVal;
      }
    });
  })();
</script>
</body>
</html>
