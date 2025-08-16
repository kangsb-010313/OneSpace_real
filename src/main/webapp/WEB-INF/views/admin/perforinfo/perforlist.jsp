<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 공연 및 대회 정보</title>
        <link rel="stylesheet" href="../../../assets/css/reset.css">
        <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../../assets/css/perforlist.css">
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

    <h2 class="perforlist-title">공연 및 대회 정보</h2>

    <!-- 리스트 -->
    <div class="perforlist-list">
      <table class="perforlist-table">
        <colgroup>
          <col style="width:100px" />
          <col style="width:950px" />
          <col style="width:150px" />
          <col />
        </colgroup>

        <thead>
          <tr>
            <th>카테고리</th>
            <th>제목</th>
            <th>날짜</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td class="cate">[공연]</td>
            <td class="tit"><a href="#">강남구 하반기 공연 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[공연]</td>
            <td class="tit"><a href="#">한림예고 실용무용과 정기공연 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[대회]</td>
            <td class="tit"><a href="#">서울시 하반기 예술제 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[공연]</td>
            <td class="tit"><a href="#">서울예술고등학교 축제 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[공연]</td>
            <td class="tit"><a href="#">서울공연예술고 실용무용과 축제 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[대회]</td>
            <td class="tit"><a href="#">광진구 예술제 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[공연]</td>
            <td class="tit"><a href="#">9/13 홍대 버스킹 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[대회]</td>
            <td class="tit"><a href="#">2025 전국 청소년 예술제 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
          <tr>
            <td class="cate">[공연]</td>
            <td class="tit"><a href="#">2025 선화무용제 안내</a></td>
            <td class="date">2025-08-11</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 글쓰기 버튼: 오른쪽 아래 -->
    <div class="btn-area">
      <a href="#" class="btn-write">글쓰기</a>
    </div>

    <!-- 페이징: 숫자, 이모지만 -->
    <nav class="pagination" aria-label="페이지네이션">
      <button class="page-plain">◀</button>
      <button class="page-plain is-active">1</button>
      <button class="page-plain">2</button>
      <button class="page-plain">3</button>
      <button class="page-plain">4</button>
      <button class="page-plain">5</button>
      <button class="page-plain">▶</button>
    </nav>
  

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