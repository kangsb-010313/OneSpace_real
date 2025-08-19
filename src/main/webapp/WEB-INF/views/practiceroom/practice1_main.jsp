<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>원스페이스 | 연습실찜하기</title>
  <!-- 주석 단축키 Ctrl+K, Ctrl+U 두 키 연속으로 눌러야 주석 처리되고 주석 제거 됨 -->
  <c:set var="ctx" value="${pageContext.request.contextPath}" />
  <link rel="stylesheet" href="${ctx}/assets/css/reset.css">
  <link rel="stylesheet" href="${ctx}/assets/css/basicdefault.css">
  <link rel="stylesheet" href="${ctx}/assets/css/main.css">
  <link rel="stylesheet" href="${ctx}/assets/css/practice.css">
  <link rel="stylesheet" href="${ctx}/assets/css/asidedefault.css">
</head>
<body>
  <div id="wrap" class="wrap page-practice">
    
    <!-- 헤더 영역------------------------------------------------ -->
    <header>
      <c:import url="/WEB-INF/views/include/header.jsp" />
    </header>
    <!-- /헤더 영역----------------------------------------------- -->

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
              <c:forEach var="r" items="${rooms}">
                <div class="card">
                  <a href="#">
                    <div class="card-img-wrap">
                      <c:set var="raw" value="${r.spaceLink}" />
                      <c:choose>
                        <%-- 1) http/https로 시작하면 그대로 --%>
                        <c:when test="${fn:startsWith(raw, 'http')}">
                          <img class="card-img" src="${raw}" alt="${r.spaceName}">
                        </c:when>
                        <%-- 2) /로 시작하는 웹 절대경로면 그대로 --%>
                        <c:when test="${fn:startsWith(raw, '/')}">
                          <img class="card-img" src="${raw}" alt="${r.spaceName}">
                        </c:when>
                        <%-- 3) 그 외(파일명 등)는 /assets/images/ 밑으로 가정 --%>
                        <c:otherwise>
                          <img class="card-img" src="${ctx}/assets/images/${raw}" alt="${r.spaceName}">
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="card-content">
                      <div class="card-title">${r.spaceName}</div>
                      <div class="card-meta">${r.spaceSummary}</div>
                      <div class="card-meta">${r.spaceInfo}</div>
                    </div>
                  </a>
                </div>
              </c:forEach>

              <!-- rooms가 비었을 때 안내 -->
              <c:if test="${empty rooms}">
			    <div style="padding:24px;color:#777;">등록된 연습실이 없습니다.</div>
			  </c:if>
			</div>
			<div id="sentinel" style="height:1px;"></div>
          </div>
        </div>
      </div>
    </main>
    <!-- /컨텐츠 영역---------------------------------------------- -->

  <script>
  const ctx = '${pageContext.request.contextPath}';
  const size = 4; // ★ 스크롤마다 4장
  let page = Math.ceil(document.querySelectorAll('#cardList .card').length / size);
  let loading = false, done = false;

  function resolveImg(raw) {
    if (!raw) return ctx + '/assets/images/placeholder.jpg';
    if (raw.startsWith('http://') || raw.startsWith('https://') || raw.startsWith('/')) return raw;
    return ctx + '/assets/images/' + encodeURIComponent(raw);
  }

  function appendCards(arr) {
    const list = document.getElementById('cardList');
    const placeholder = ctx + '/assets/images/placeholder.jpg';
    arr.forEach(function(r) {
      const src = resolveImg(r.spaceLink || '');
      const card = document.createElement('div');
      card.className = 'card';
      card.innerHTML =
        '<a href="#">' +
          '<div class="card-img-wrap">' +
            '<img class="card-img" src="' + src + '" alt="' + (r.spaceName || '') + '"' +
                 ' onerror="this.src=\'' + placeholder + '\'">' +
          '</div>' +
          '<div class="card-content">' +
            '<div class="card-title">' + (r.spaceName || '') + '</div>' +
            '<div class="card-meta">' + (r.spaceSummary || '') + '</div>' +
            '<div class="card-meta">' + (r.spaceInfo || '') + '</div>' +
          '</div>' +
        '</a>';
      list.appendChild(card);
    });
  }

  async function loadMore() {
    if (loading || done) return;
    loading = true;

    const url = ctx + '/onespace/api/practicerooms?page=' + page + '&size=' + size;
    console.log('[loadMore] page=', page, 'GET', url);

    try {
      const res = await fetch(url, { headers: { 'Accept':'application/json' } });
      console.log('[loadMore] status=', res.status);
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const data = await res.json();
      console.log('[loadMore] data.length=', Array.isArray(data) ? data.length : 'N/A');

      if (!Array.isArray(data) || data.length === 0) {
        done = true;
        return;
      }

      appendCards(data);

      if (data.length < size) {
        // 마지막 페이지
        done = true;
      } else {
        page++;
      }
    } catch (e) {
      console.error('[loadMore] error', e);
      done = true;
    } finally {
      loading = false;
    }
  }

  // 초기 1회 로드(원하면 주석 처리 가능)
  document.addEventListener('DOMContentLoaded', loadMore);

  // 스크롤 바닥 근접 시 추가 로드
  window.addEventListener('scroll', function () {
    if (loading || done) return;
    const nearBottom = window.innerHeight + window.scrollY >= document.body.offsetHeight - 120;
    if (nearBottom) loadMore();
  });
  </script>
  
  </div>
  
  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
  </footer>
  <!-- /푸터 영역----------------------------------------------- -->
    
</body>
</html>
