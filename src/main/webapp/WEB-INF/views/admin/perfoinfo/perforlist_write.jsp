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

          <c:set var="isEdit" value="${mode eq 'edit'}"/>
          <c:choose>
            <c:when test="${isEdit}">
              <c:url var="formAction" value="/perfoinfo/modify"/>
            </c:when>
            <c:otherwise>
              <c:url var="formAction" value="/perfoinfo/write"/>
            </c:otherwise>
          </c:choose>

          <form id="perfoinfo-write-form"
                method="post"
                action="${formAction}"
                enctype="multipart/form-data">

            <c:if test="${not empty _csrf}">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </c:if>

            <c:if test="${isEdit}">
              <input type="hidden" name="infoPostNo" value="${vo.infoPostNo}"/>
            </c:if>

            <input type="text" class="title" name="infoPostTitle" placeholder="제목" maxlength="500" required
                   value="${isEdit ? vo.infoPostTitle : ''}">
            <input type="url" class="url-box" name="infoOutUrl" placeholder="첨부 URL을 입력해 주세요."
                   value="${isEdit ? vo.infoOutUrl : ''}">

            <div class="filter-row">
              <div class="select-wrap">
                <select class="select" name="infoPostType" required>
                  <option value="">카테고리</option>
                  <option value="공연" ${isEdit && vo.infoPostType=='공연' ? 'selected' : ''}>공연</option>
                  <option value="대회" ${isEdit && vo.infoPostType=='대회' ? 'selected' : ''}>대회</option>
                </select>
              </div>

              <label class="date-wrap">
                <input type="date" class="date-input" name="deadlineDate" required onclick="this.showPicker()"
                       value="${isEdit ? vo.deadlineDate : ''}">
                <span class="date-ph" style="${isEdit && vo.deadlineDate ne null ? 'display:none' : ''}">마감 날짜 ▾</span>
              </label>

              <input type="text" class="inp-region-pill" name="infoArea" placeholder="공연 지역" maxlength="100"
                     value="${isEdit ? vo.infoArea : ''}">
            </div>

            <!-- ===== 본문/사진 레이아웃 ===== -->
            <div class="textarea-wrap">
              <!-- 왼쪽: 미리보기(이미지 있으면만 보이는 효과) -->
              <div class="editor-side">
                <div id="filename-preview" class="file-preview">
                  <c:if test="${isEdit and not empty vo.infoImg}">
                    <img src="${pageContext.request.contextPath}/perfoinfo/upload/${vo.infoImg}" alt="첨부 이미지">
                  </c:if>
                </div>
              </div>

              <!-- 오른쪽: 본문 + 첨부버튼 -->
              <div class="editor-body">
                <textarea class="inp-textarea-line" name="infoContent" placeholder="전하고 싶은 내용을 입력해 주세요!" rows="12" required>${isEdit ? vo.infoContent : ''}</textarea>

                <label class="btn-solid attach-btn">
                  파일첨부
                  <input type="file" name="infoImgFile" id="infoImgFile" accept="image/*" hidden>
                </label>
              </div>
            </div>
            <!-- ===== /본문/사진 레이아웃 ===== -->

            <div class="actions">
              <button type="submit" class="btn btn-solid submit-btn">
                ${isEdit ? '수정 완료' : '등록하기'}
              </button>
            </div>
          </form>

        </div>
      </section>
    </div>
  </main>

  <c:import url="/WEB-INF/views/include/footer.jsp" />
</div>

<script>
  // url 유효성
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
    urlInput.addEventListener('blur', function () {
      urlInput.value = normalizeUrl(urlInput.value);
    });
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

  // 파일첨부 → 이미지 미리보기 (동적 레이아웃)
  document.addEventListener("DOMContentLoaded", function () {
    var form      = document.getElementById('perfoinfo-write-form');
    var fileInput = document.querySelector("input[name='infoImgFile']");
    var preview   = document.getElementById("filename-preview");
    var wrap      = document.querySelector(".textarea-wrap");
    var objectUrl = null;

    if (!wrap || !preview) return;

    function setHasPreview(on){
      // 왼쪽 컬럼을 grid에 남겨둔 상태에서 폭만 바꾼다 (CSS가 처리)
      if (on) wrap.classList.add("has-preview");
      else    wrap.classList.remove("has-preview");
    }

    function clearPreview(){
      if (objectUrl){
        URL.revokeObjectURL(objectUrl);
        objectUrl = null;
      }
      preview.innerHTML = "";
      setHasPreview(false); // 왼쪽 폭 0으로
    }

    // 수정모드에서 서버 이미지가 이미 있으면 활성화
    if (preview.querySelector("img")) {
      setHasPreview(true);
    }

    if (fileInput){
      fileInput.addEventListener("change", function (e) {
        clearPreview();
        var file = e.target.files && e.target.files[0];
        if (!file) return;

        if (file.type && file.type.indexOf("image/") === 0){
          objectUrl = URL.createObjectURL(file);
          preview.innerHTML = '<img src="'+ objectUrl +'" alt="첨부 이미지 미리보기">';
          setHasPreview(true); // 이미지가 들어오면 왼쪽 컬럼 폭 자동
        } else {
          clearPreview(); // 이미지 외 파일은 프리뷰 사용 안 함
        }
      });
    }

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
