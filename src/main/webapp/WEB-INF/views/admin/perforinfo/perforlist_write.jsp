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

      <!-- 헤더 -->
      <c:import url="/WEB-INF/views/include/header.jsp" />

      <!-- 컨텐츠 -->
      <main>
        <div class="container">
          <section class="write-container">
            <div class="write-inner">

              <form id="perforinfo-write-form"
                    method="post"
                    action="<c:url value='/onespace/perforinfo/write'/>"
                    enctype="multipart/form-data">

                <!-- CSRF -->
                <c:if test="${not empty _csrf}">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </c:if>

                <!-- 제목 -->
                <input type="text" class="title" name="infoPostTitle" placeholder="제목" maxlength="500" required>

                <!-- URL -->
                <input type="url" class="url-box" name="infoOutUrl" placeholder="첨부 URL을 입력해 주세요.">

                <div class="filter-row">
                  <!-- 카테고리 -->
                  <div class="select-wrap">
                    <select class="select" name="infoPostType" required>
                      <option value="">카테고리</option>
                      <option value="공연">공연</option>
                      <option value="대회">대회</option>
                    </select>
                  </div>

                  <!-- 마감 날짜 -->
                  <label class="date-wrap">
                    <input type="date" class="date-input" name="deadlineDate" required onclick="this.showPicker()">
                    <span class="date-ph">마감 날짜 ▾</span>
                  </label>

                  <!-- 지역 -->
                  <input type="text" class="inp-region-pill" name="infoArea" placeholder="공연 지역" maxlength="100">
                </div>

                <!-- 내용 + 이미지 -->
                <div class="textarea-wrap">
                  <textarea class="inp-textarea-line" name="infoContent" placeholder="전하고 싶은 내용을 입력해 주세요!" rows="12" required></textarea>

                  <label class="btn-solid attach-btn">
                    파일첨부
                    <input type="file" name="perforImg" hidden>
                  </label>
                </div>

                <div class="actions">
                  <button type="submit" class="btn btn-solid submit-btn">등록하기</button>
                </div>
              </form>

            </div>
          </section>
        </div>
      </main>

      <!-- 푸터 -->
      <c:import url="/WEB-INF/views/include/footer.jsp" />
    </div>

    <script>
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
    </script>
  </body>
</html>
