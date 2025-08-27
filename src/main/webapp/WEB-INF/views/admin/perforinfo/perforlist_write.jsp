<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 공연 및 대회 정보</title>
  <link rel="stylesheet" href="../../../assets/css/reset.css">
  <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
  <link rel="stylesheet" href="../../../assets/css/perforlist_write.css">
</head>
<body>
<div id="wrap">
  <c:import url="/WEB-INF/views/include/header.jsp" />

  <main>
    <div class="container">
      <section class="write-container">
        <div class="write-inner">

          <form id="perforinfo-write-form"
                method="post"
                action="<c:url value='/onespace/perforinfo/write'/>"
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
                <input type="file" name="infoImgFile" id="infoImgFile" hidden>
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

  // 파일첨부 → 파일명 미리보기
  document.addEventListener("DOMContentLoaded", function () {
    const fileInput = document.querySelector("input[name='infoImgFile']");
    const preview = document.getElementById("filename-preview");
    if (fileInput && preview) {
      fileInput.addEventListener("change", function (e) {
        const fileName = e.target.files && e.target.files[0] ? e.target.files[0].name : "";
        preview.innerText = fileName ? ("첨부된 파일: " + fileName) : "";
        console.log("selected file:", fileName);
      });
    }
  });
</script>
</body>
</html>
