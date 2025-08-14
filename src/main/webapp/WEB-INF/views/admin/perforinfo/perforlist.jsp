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
            <header>
                <div class="container">
                    <div class="header-inner">
                        <h1 class="logo"><a href="#">원 스페이스</a></h1>
                        <div class="header-right">
                            <nav class="nav">
                                <ul>
                                    <li>
                                        <a href="#">팀페이지</a>
                                    </li>
                                    <li>
                                        <a href="#">연습실찜하기</a>
                                    </li>
                                    <li>
                                        <a class="click" href="#">공연 및 대회 정보</a>
                                    </li>
                                    <li>
                                        <a href="#">팀자랑</a>
                                    </li>
                                </ul>
                            </nav>

                            <div class="header-buttons">
                                <span class="username">강수빈 님</span>
                                <div class="host-signup-group">
                                    <a href="#" class="btn-outline host-btn">호스트센터</a>
                                    <a href="#" class="btn-outline signup-btn">로그아웃</a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </header>
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
            <footer>
                <div class="container">
                    <div class="footer-top">
                        <span class="footer-logo">원 스페이스</span>
                        <span class="footer-links">
                        배너광고 문의 | 이용약관 | 개인정보처리방침 | 운영정책 | 콘텐츠산업진흥법에 의한 표시 | 고객 문의
                        </span>
                    </div>
                    <div class="footer-info">
                        상호명: 주식회사 춤사위 | 대표: 홍길동 | 사업자등록번호: 230-81-10313 | 통신판매업신고번호: 2025-서울영등포-1093<br>
                        영업소재지: 서울특별시 강동구 천호대로 1027 5층 501호 | 이메일: cheonho@onespace.kr | 제휴문의: marketing@onespace.kr<br>
                        대표전화: 1599-1234(평일 오후 2시 ~ 오후 6시) | 온라인 1:1 문의 바로가기(평일 오전 10시 ~ 오후 6시)<br>
                    </div>
                    <div class="footer-warning">
                        원스페이스는 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 원스페이스는 공간 거래정보 및 거래에 대해 책임지지 않습니다.
                    </div>
                    <div class="footer-copy">
                        Copyright 춤사위 Corp.All Rights Reserved.
                    </div>
                </div>
            </footer>
            <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->
    </body>

</html>