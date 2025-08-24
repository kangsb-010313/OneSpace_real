<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 기본정보</title>

  <!-- css 상대경로 유지 -->
  <link rel="stylesheet" href="../../../assets/css/reset.css">
  <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
  <link rel="stylesheet" href="../../../assets/css/host_info.css">
</head>
<body>
<div id="wrap">

  <!-- 헤더 -->
  <c:import url="/WEB-INF/views/include/header.jsp" />

  <main>
    <div class="container">

      <!-- url -->
      <c:url var="urlSpacesNew"  value="/onespace/hostcenter/spaces/new"/>
      <c:url var="urlSpacesList" value="/onespace/hostcenter/spaces"/>
      <c:choose>
        <c:when test="${not empty space.spacesno}">
          <c:url var="urlSaveSpace" value="/onespace/hostcenter/spaces/update"/>
        </c:when>
        <c:otherwise>
          <c:url var="urlSaveSpace" value="/onespace/hostcenter/spaces/insert"/>
        </c:otherwise>
      </c:choose>

      <!-- 탭 -->
      <div class="tab-btns">
        <button class="tab active" type="button" onclick="location.href='${urlSpacesNew}'">기본 정보 관리</button>
        <button class="tab"        type="button" onclick="location.href='${urlSpacesList}'">내 공간 관리</button>
      </div>

      <!-- 타이틀 -->
      <div class="main-title-box"><h2 class="main-title">기본정보</h2></div>

      <!-- 안내 -->
      <div class="maininfo-row">
        <div class="maininfo-guide">공간 정보를 입력해주세요.</div>
        <label class="maininfo-hide-label">
          검색창에 가려지기
          <input type="checkbox" class="maininfo-hide-chk">
        </label>
      </div>
      <div class="main-bottomline"></div>

      <!-- 폼 -->
      <form id="spaceForm" action="${urlSaveSpace}" method="post" enctype="multipart/form-data">
        <c:if test="${not empty space.spacesno}">
          <input type="hidden" name="spacesno" value="${space.spacesno}">
        </c:if>
        <input type="hidden" name="facilities" id="facilitiesHidden"/>

        <c:if test="${_csrf != null}">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>

        <!-- 공간정보 -->
        <section class="form-section">
          <div class="input-group">
            <label for="space-name">공간명</label>
            <span class="char-count">1자/18자</span>
            <input id="space-name" name="spacename" type="text" maxlength="18"
                   value="${space.spacename}" placeholder="예: 인디워커스 하이브 회의실" required>
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

        <!-- 시설 안내 (원본 구조 유지) -->
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

        <!-- 환불 규정 (원본 구조 유지) -->
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

        <!-- 대표 이미지 (DB repImg 직접 사용) -->
        <section class="form-section img-section">
          <div class="img-header">
            <div class="section-title">대표 이미지</div>
            <span class="img-guide">2048 × 1158 권장, 최대 3MB<br>이미지 파일(JPG, PNG, JPEG)</span>
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
              <!-- 컨트롤러: MultipartFile repImage 받고 저장 후 vo.repimg에 파일명 세팅 -->
              <input type="file" id="repImage" name="repImage" hidden>
            </label>
          </div>

          <!-- 기존 repImg 값 유지 -->
          <input type="hidden" name="repimg" id="repimgHidden" value="${space.repimg}">
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
            <button class="addr-btn" type="button" id="btnFindAddr">주소 등록</button>
          </div>
          <input type="text" class="addr-detail" name="addressdetail"
                 value="${space.addressdetail}" placeholder="상세 주소">

          <input type="hidden" name="postcode"  value="${space.postcode}">
          <input type="hidden" name="spacelink" value="${space.spacelink}">
        </section>

        <!-- 연락처 (이메일 구조/클래스 원본 유지) -->
        <section class="contact-section">
          <div class="section-title">연락처 정보를 입력해 주세요.</div>

          <!-- 이메일 (원래 클래스명/구조 유지) -->
          <div class="contact-flex">
            <div class="email-row">
              <label>이메일</label>
              <div class="email-inputs">
                <input type="text" class="email-id" id="emailId" placeholder="이메일">
                <span class="at">@</span>
                <input type="text" class="email-domain" id="emailDomain" placeholder="직접 입력">
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

          <!-- 휴대폰/대표전화 -->
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

    </div>
  </main>

  <!-- 푸터 -->
  <c:import url="/WEB-INF/views/include/footer.jsp" />

</div>

<script>
  // ========== 대표 이미지 파일명 표시 ==========
  (function() {
    const input = document.getElementById('repImage');
    const nameSpan = document.getElementById('repImageName');
    const guideText = document.getElementById('imgGuideText');
    const hiddenKeep = document.getElementById('repimgHidden');

    const existing = (hiddenKeep && hiddenKeep.value || '').trim();
    if (existing) {
      if (nameSpan) nameSpan.textContent = existing;
      if (guideText) guideText.style.display = 'none';
    }

    if (!input) return;
    input.addEventListener('change', function () {
      if (this.files && this.files.length > 0) {
        nameSpan.textContent = this.files[0].name;
        if (guideText) guideText.style.display = 'none';
      } else {
        nameSpan.textContent = existing || '';
        if (!existing && guideText) guideText.style.display = 'block';
      }
    });
  })();

  // ========== 이메일 입력 동기화 (원본 구조 유지) ==========
  (function () {
    const emailId      = document.getElementById('emailId');
    const emailDomain  = document.getElementById('emailDomain');
    const emailSelect  = document.getElementById('emailSelect');
    const emailFull    = document.getElementById('emailFull'); // hidden

    if (!emailSelect || !emailDomain || !emailFull) return;

    // 기존 값 분해해서 표시
    (function hydrateFromFull() {
      const full = (emailFull.value || '').trim();
      if (!full || !full.includes('@')) return;
      const parts = full.split('@');
      const id = parts[0] || '';
      const domain = parts[1] || '';
      if (emailId) emailId.value = id;
      emailDomain.value = domain;
      const match = Array.from(emailSelect.options).find(o => o.value === domain);
      if (match) {
        emailSelect.value = domain;
        emailDomain.readOnly = true;
      } else {
        emailSelect.value = '';
        emailDomain.readOnly = false;
      }
    })();

    const updateHidden = () => {
      const id  = (emailId ? emailId.value : '').trim();
      const dom = (emailDomain.value || '').trim();
      emailFull.value = (id && dom) ? (id + '@' + dom) : '';
    };

    emailSelect.addEventListener('change', function () {
      const sel = (this.value || '').trim();
      if (sel) {
        emailDomain.value = sel;
        emailDomain.readOnly = true;
      } else {
        emailDomain.readOnly = false;
      }
      updateHidden();
    });

    if (emailId)     emailId.addEventListener('input',   updateHidden);
    emailDomain.addEventListener('input', updateHidden);
  })();

  // ========== 대표전화(=휴대폰 동일) 동기화 ==========
  (function () {
    const sameChk   = document.getElementById('same-phone');
    const phoneInp  = document.querySelector('input[name="phone"]');
    const telInp    = document.getElementById('telInput');

    if (!sameChk || !phoneInp || !telInp) return;

    const syncTel = () => {
      if (sameChk.checked) {
        telInp.value = phoneInp.value;
        telInp.readOnly = true;
      } else {
        telInp.readOnly = false;
      }
    };

    sameChk.addEventListener('change', syncTel);
    phoneInp.addEventListener('input', syncTel);
    syncTel();
  })();

  // ========== 제출 직전 최종 합치기 ==========
  (function() {
    const form = document.getElementById('spaceForm');
    if (!form) return;

    form.addEventListener('submit', function() {
      // 시설 체크값 → hidden
      const arr = Array.from(document.querySelectorAll('input[name="facility"]:checked'))
                       .map(el => el.value.trim());
      const facHidden = document.getElementById('facilitiesHidden');
      if (facHidden) facHidden.value = arr.join(',');

      // same-phone이면 대표전화 = 휴대폰
      const same = document.getElementById('same-phone');
      const phoneVal = (document.querySelector('input[name="phone"]') || {}).value || '';
      const tel = document.getElementById('telInput');
      if (same && same.checked && tel) tel.value = phoneVal;

      // 이메일 hidden 완성(보수)
      const emailId     = document.getElementById('emailId');
      const emailDomain = document.getElementById('emailDomain');
      const emailFull   = document.getElementById('emailFull');
      if (emailFull) {
        const id  = (emailId ? emailId.value : '').trim();
        const dom = (emailDomain ? emailDomain.value : '').trim();
        emailFull.value = (id && dom) ? (id + '@' + dom) : (emailFull.value || '');
      }
    });
  })();

  // 주소 등록 버튼(다음 우편번호 API 연결 지점 - 필요 시 실제 스크립트 추가)
  document.getElementById('btnFindAddr')?.addEventListener('click', function() {
    // TODO: 다음 주소 API 팝업 연결
    alert('주소 검색 팝업을 연결하세요.');
  });
</script>

</body>
</html>
