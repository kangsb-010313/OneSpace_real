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
      <div class="container">
        <div class="header-inner">
          <h1 class="logo">
            <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice1_main.html">원 스페이스</a>
          </h1>
          <div class="header-right">
            <nav class="nav">
              <ul>
                <li><a class="click" href="#">팀페이지</a></li>
                <li><a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice1_main.html">연습실찜하기</a></li>
                <li><a href="#">공연 및 대회 정보</a></li>
                <li><a href="#">팀자랑</a></li>
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

    <!-- 본문 -->
    <!-- 컨텐츠 영역---------------------------------------------- -->
    <main>
      <div class="container">
        <div class="main-section">
          <!-- 컨텐츠 -->
          <div class="content-area">
            <div class="filter-bar">
              <button class="btn-list" onclick="location.href='file:///C:/javaStudy/onespace_front/views/practiceroom/practice4_list.html'">
                찜리스트<span style="color:#ff3333;">❤</span>
              </button>
              <div class="search-row">
                <input class="search-hash" type="text" placeholder="#찾는 공간이 있나요?" />
                <div class="filter-select-group">
                  <select class="custom-select">
                    <option>지역</option>
                    <option>서울</option>
                    <option>경기</option>
                    <option>부산</option>
                  </select>
                  <select class="custom-select">
                    <option>인원</option>
                    <option>1~5명</option>
                    <option>6~10명</option>
                  </select>
                </div>
              </div>
            </div>

            <!-- 카드 그리드 -->
            <div class="card-list" id="cardList">
              <!-- 카드 1 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진01.jpg" alt="네스트 연습실">
                  </div>
                  <div class="card-content">
                    <div class="card-title">네스트 연습실</div>
                    <div class="card-price">10,000 원 ~ 17,000원/시간</div>
                    <div class="card-meta">최대15인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 2 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진02.jpg" alt="드론스튜디오">
                  </div>
                  <div class="card-content">
                    <div class="card-title">드론스튜디오</div>
                    <div class="card-price"><span style="color:#222;">3,000 원 ~</span> <span style="color:#7a4eff;">7,000원/시간</span></div>
                    <div class="card-meta">선택불가/최대7인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 3 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진03.jpg" alt="픽스튜디오">
                  </div>
                  <div class="card-content">
                    <div class="card-title">픽스튜디오</div>
                    <div class="card-price">7,000 원/시간</div>
                    <div class="card-meta">최대7인/추가인원7인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 4 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진04.jpeg" alt="네스트 연습실">
                  </div>
                  <div class="card-content">
                    <div class="card-title">네스트 연습실</div>
                    <div class="card-price">10,000 원 ~ 17,000원/시간</div>
                    <div class="card-meta">최대15인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 5 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진05.jpg" alt="드론스튜디오">
                  </div>
                  <div class="card-content">
                    <div class="card-title">드론스튜디오</div>
                    <div class="card-price"><span style="color:#222;">3,000 원 ~</span> <span style="color:#7a4eff;">7,000원/시간</span></div>
                    <div class="card-meta">선택불가/최대7인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 6 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진06.jpg" alt="픽스튜디오">
                  </div>
                  <div class="card-content">
                    <div class="card-title">픽스튜디오</div>
                    <div class="card-price">7,000 원/시간</div>
                    <div class="card-meta">최대7인/추가인원7인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 7 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진06.jpg" alt="픽스튜디오">
                  </div>
                  <div class="card-content">
                    <div class="card-title">픽스튜디오</div>
                    <div class="card-price">7,000 원/시간</div>
                    <div class="card-meta">최대7인/추가인원7인</div>
                  </div>
                </a>
              </div>

              <!-- 카드 8 -->
              <div class="card">
                <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html">
                  <div class="card-img-wrap">
                    <img class="card-img" src="../../assets/images/연습실찜하기사진06.jpg" alt="픽스튜디오">
                  </div>
                  <div class="card-content">
                    <div class="card-title">픽스튜디오</div>
                    <div class="card-price">7,000 원/시간</div>
                    <div class="card-meta">최대7인/추가인원7인</div>
                  </div>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->

    <script>
      // 더미 데이터(카드 4개씩 추가용)
      const cardData = [
        {
          title: "네스트 연습실",
          price: "10,000 원 ~ 17,000원/시간",
          meta: "최대15인",
          img: "../../assets/images/연습실찜하기사진06.jpg"
        },
        {
          title: "드론스튜디오",
          price: "<span style='color:#222;'>3,000 원 ~</span> <span style='color:#7a4eff;'>7,000원/시간</span>",
          meta: "선택불가/최대7인",
          img: "../../assets/images/연습실찜하기사진06.jpg"
        },
        {
          title: "픽스튜디오",
          price: "7,000 원/시간",
          meta: "최대7인/추가인원7인",
          img: "../../assets/images/연습실찜하기사진06.jpg"
        },
        {
          title: "픽스튜디오",
          price: "7,000 원/시간",
          meta: "최대7인/추가인원7인",
          img: "../../assets/images/연습실찜하기사진06.jpg"
        }
      ];

      // 한 번에 4개 카드 추가
      function addCards() {
        const cardList = document.getElementById('cardList');
        for (let i = 0; i < 4; i++) {
          const d = cardData[i % 4];
          const card = document.createElement('div');
          card.className = "card";
          card.innerHTML = `
            <a href="file:///C:/javaStudy/onespace_front/views/practiceroom/practice2_zone.html"
              style="display:block; width:100%; height:100%; text-decoration:none; color:inherit;">
              <div class="card-img-wrap">
                <img class="card-img" src="${d.img}" alt="${d.title}">
              </div>
              <div class="card-content">
                <div class="card-title">${d.title}</div>
                <div class="card-price">${d.price}</div>
                <div class="card-meta">${d.meta}</div>
              </div>
            </a>
          `;
          cardList.appendChild(card);
        }
      }

      addCards();

      // 무한 스크롤 이벤트
      let loading = false;
      window.addEventListener('scroll', function () {
        if (loading) return;
        if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 100) {
          loading = true;
          setTimeout(() => {
            addCards();
            loading = false;
          }, 350);
        }
      });
    </script>
  </div>
  
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
    
</body>
</html>
