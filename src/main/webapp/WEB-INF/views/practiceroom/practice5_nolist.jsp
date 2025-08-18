<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 연습실찜하기</title>
  <!-- 주석 단축키 Ctrl+K, Ctrl+U 두 키 연속으로 눌러야 주석 처리되고 주석 제거 됨 -->
  <link rel="stylesheet" href="../../assets/css/reset.css">
  <link rel="stylesheet" href="../../assets/css/practice.css">
  <link rel="stylesheet" href="../../assets/css/asidedefault.css">
  <link rel="stylesheet" href="../../assets/css/basicdefault.css">
</head>
<body>
  <div class="wrap">
    <!-- 헤더 영역------------------------------------------------ -->
    <header>
      <c:import url="/WEB-INF/views/include/header.jsp" />
    </header>
    <!-- /헤더 영역------------------------------------------------ -->

    <!-- 본문 -->
    <!-- 컨텐츠 영역---------------------------------------------- -->
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
                <!-- 좌측: 새 팀 aside -->
                <div id="team-aside">
                  <h2>팀페이지</h2>
                  <div class="team-list-section">
                    <!-- <h3>우리팀 목록</h3> -->
                    <a href="#" class="btn-outline3 teamlist-btn">팀 원밀리언</a>
                    <a href="#" class="btn-outline3 teamlist-btn">팀 저스트절크</a>
                  </div>
                  <a href="#" class="btn-outline2 teamadd-btn">팀 등록하기</a>
                </div>

                <!-- 우측: 본문 -->
                <div id="space">
                  <div style="font-size:20px; font-weight:700;">
                    찜한 연습실이 없습니다. 마음에 드는 연습실을 찾아 찜해보세요.
                  </div>
                </div>
              </div>
              <!-- /#content -->
            </div>
            <!-- /container -->
          </div>
          <!-- /content-area -->
        </div>
        <!-- /main-section -->
      </div>
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->
  </div>
  
  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
  </footer>
  <!-- /푸터 영역------------------------------------------------ -->

</body>
</html>
