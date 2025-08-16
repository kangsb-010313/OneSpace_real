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

            <!-- 헤더 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->





            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   여기(main container)안에 본인꺼 짜시면 됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->


<!-- 글쓰기 본문 -->
<section class="write-container">
    <div class="write-inner">
  
      <!-- 제목 -->
      <input type="text" class="title" placeholder="제목">
  
      <!-- URL -->
      <input type="url" class="url-box" placeholder="첨부 url을 입력해 주세요.">
  
      <!-- 옵션 -->
      <div class="filter-row">
  
        <!-- 카테고리 -->
        <div class="select-wrap">
          <select class="select">
            <option value="">카테고리</option>
            <option>공연</option>
            <option>대회</option>
          </select>
        </div>
  
        <!-- 마감 날짜: '마감 날짜' 텍스트 보이다가 클릭 시 달력 -->
        <label class="date-wrap">
          <input
            type="date"
            class="date-input"
            required
            onclick="this.showPicker()"
          >
          <span class="date-ph">마감 날짜 ▾</span>
        </label>
  
        <!-- 공연 지역 -->
        <input type="text" class="inp-region-pill" placeholder="공연 지역">
      </div>
  
      <div class="textarea-wrap">
        <textarea class="inp-textarea-line" 
          placeholder="전하고 싶은 내용을 입력해 주세요!"></textarea>
      
        <label class="btn-solid attach-btn">
          파일첨부
          <input type="file" hidden>
        </label>
      </div>
  
      <div class="actions">
        <button type="button" class="btn btn-solid submit-btn">등록하기</button>
      </div>
  
    </div>
  </section>
  
  
  

  

<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

                </div>
                <!-- container -->

            </main>
            <!-- /컨텐츠 영역---------------------------------------------- -->



 			 <!-- 푸터 영역------------------------------------------------ -->
              <c:import url="/WEB-INF/views/include/footer.jsp" />
             <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->
    </body>

</html>