<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 공연 및 대회 정보</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/perforlist_write.css">
</head>
<body>
<div id="wrap">
  <c:import url="/WEB-INF/views/include/header.jsp" />

  <main>
    <div class="container">
      <section class="write-container">
        <div class="write-inner">

          <form id="perfoinfo-write-form"
                method="post"
                action="<c:url value='/perfoinfo/write'/>"
                enctype="multipart/form-data">

            <c:if test="${not empty _csrf}">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </c:if>

            <input type="text" class="title" name="infoPostTitle" placeholder="제목" maxlength="500" required>
            <input type="url" class="url-box" name="infoOutUrl" placeholder="첨부 URL을 입력해 주세요.">

            <div class="filter-row">
              <div class="select-wrap">
                <select class="select" name="infoPostType" required>
                  <option value="">카테고리</option>
                  <option value="공연">공연</option>
                  <option value="대회">대회</option>
                </select>
              </div>

              <label class="date-wrap">
                <input type="date" class="date-input" name="deadlineDate" required onclick="this.showPicker()">
                <span class="date-ph">마감 날짜 ▾</span>
              </label>

              <input type="text" class="inp-region-pill" name="infoArea" placeholder="공연 지역" maxlength="100">
            </div>

            <div class="textarea-wrap">
              <textarea class="inp-textarea-line" name="infoContent" placeholder="전하고 싶은 내용을 입력해 주세요!" rows="12" required></textarea>

              <label class="btn-solid attach-btn">
			    파일첨부
			    <input type="file" name="infoImgFile" id="infoImgFile" accept="image/*" hidden>
			  </label>

              <div id="filename-preview" class="file-preview"></div>
            </div>

            <div class="actions">
              <button type="submit" class="btn btn-solid submit-btn">등록하기</button>
            </div>
          </form>

        </div>
      </section>
    </div>
  </main>

  <c:import url="/WEB-INF/views/include/footer.jsp" />
</div>

<script>

  //url 유효성
  (function () {
    var form = document.getElementById('perfoinfo-write-form');
    var urlInput = document.querySelector("input[name='infoOutUrl']");

    if (!urlInput || !form) return;

    function normalizeUrl(v) {
      if (!v) return v;
      var trimmed = v.trim();
      var hasScheme = /^[a-zA-Z][a-zA-Z0-9+.-]*:\/\//.test(trimmed);
      return hasScheme ? trimmed : "https://" + trimmed.replace(/^\/+/, "");
    }

    // blur 시 자동 보정
    urlInput.addEventListener('blur', function () {
      urlInput.value = normalizeUrl(urlInput.value);
    });

    // 제출 직전에 최종 보정
    form.addEventListener('submit', function () {
      urlInput.value = normalizeUrl(urlInput.value);
    });
  })();

  // 날짜 placeholder 처리
  (function () {
    var dateInput = document.querySelector('.date-input');
    var datePh = document.querySelector('.date-ph');
    function togglePh() {
      if (!dateInput || !datePh) return;
      datePh.style.display = dateInput.value ? 'none' : 'inline';
    }
    if (dateInput) {
      dateInput.addEventListener('change', togglePh);
      dateInput.addEventListener('input', togglePh);
      dateInput.addEventListener('blur', togglePh);
      togglePh();
    }
  })();

  // 파일첨부 → 이미지 미리보기 (ajax)
  document.addEventListener("DOMContentLoaded", function () {
    var form     = document.getElementById('perfoinfo-write-form');
    var fileInput= document.querySelector("input[name='infoImgFile']");
    var preview  = document.getElementById("filename-preview");
    var textarea = document.querySelector(".inp-textarea-line");
    var objectUrl= null;

    if (!fileInput || !preview || !textarea) return;

    function clearPreview(){
      if (objectUrl){
        URL.revokeObjectURL(objectUrl);
        objectUrl = null;
      }
      preview.innerHTML = "";
      // 겹치지 않게 하단 패딩을 원래대로
      textarea.style.paddingBottom = "8px";
    }

    fileInput.addEventListener("change", function (e) {
      clearPreview();

      var file = e.target.files && e.target.files[0];
      if (!file){
        return; // 선택 취소
      }

      // 이미지면 썸네일, 아니면 파일명 텍스트
      if (file.type && file.type.indexOf("image/") === 0){
        objectUrl = URL.createObjectURL(file);
        preview.innerHTML = '<img src="'+ objectUrl +'" alt="첨부 이미지 미리보기">';
        // 미리보기가 텍스트 영역을 가리지 않도록 하단 패딩만 "살짝" 확보
        textarea.style.paddingBottom = "120px";
      } else {
        preview.textContent = "첨부된 파일: " + file.name;
        textarea.style.paddingBottom = "36px"; // 텍스트 한 줄 정도 공간
      }
    });

    // 폼 제출/리셋 시 정리
    if (form){
      form.addEventListener("reset", clearPreview);
      form.addEventListener("submit", function(){
        if (objectUrl){
          URL.revokeObjectURL(objectUrl);
          objectUrl = null;
        }
      });
    }
  });
</script>
</body>
</html>
