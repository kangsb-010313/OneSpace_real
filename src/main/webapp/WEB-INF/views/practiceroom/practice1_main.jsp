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
              <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/onespace/practice4_list'">
			    찜리스트<span style="color:#ff3333;">❤</span>
			  </button>
            </div>
            <h2 class="page-title">연습실찜하기</h2>
            <div style="width: 90%; border-bottom: 1px solid #e4e2ef; margin-left: 50px;"></div>
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

            <!-- 카드 그리드 -->
            <div class="card-list" id="cardList">
              <c:forEach var="r" items="${rooms}">
                <div class="card">
                  <a href="${pageContext.request.contextPath}/onespace/practice2_zone?spacesNo=${r.spacesNo}">
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
                        <%-- 3) 그 외는 /assets/images/ --%>
                        <c:otherwise>
                          <img class="card-img" src="${ctx}/assets/images/${raw}" alt="${r.spaceName}">
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="card-content">
                      <a href="${pageContext.request.contextPath}/onespace/practice2_zone?spacesNo=${r.spacesNo}">
                      <div class="card-title">${r.spaceName}</div>
                      </a>
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
  let page = 2;
  //let page = Math.ceil(document.querySelectorAll('#cardList .card').length / size);
  let loading = false, done = false;
  
  //안전하게 속성값을 찾아주는 헬퍼 (여러 후보 키명을 시도)
  function findField(obj, candidates) {
    for (let i = 0; i < candidates.length; i++) {
      const k = candidates[i];
      if (obj[k] !== undefined && obj[k] !== null) return obj[k];
    }
    return '';
  }
  
  //간단한 HTML 이스케이프 (XSS 방지용, 출력용)
  function escapeHtml(s) {
    if (!s && s !== 0) return '';
    return String(s)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }
  
  //이미지 경로 판단: http(s) / 웹절대경로(/...) / 파일명 -> assets/images/
  function resolveImg(raw) {
    const placeholder = ctx + '/assets/images/placeholder.jpg';
    if (!raw) return placeholder;
    try {
      raw = String(raw);
      if (raw.startsWith('http://') || raw.startsWith('https://') || raw.startsWith('/')) {
        return raw;
      }
      // 파일명인 경우 (DB에 저장된 파일명): 그대로 /assets/images/ + 파일명
      // (브라우저가 적절히 인코딩 처리함; 한글파일명 문제가 있으면 서버에서 영문으로 바꾸는게 안전)
      return ctx + '/assets/images/' + raw;
    } catch (e) {
      return placeholder;
    }
  }

  //무한스크롤로 받아온 데이터(배열)를 카드로 추가
  function appendCards(arr) {
    console.log('[appendCards] received array:', arr);
    if (!Array.isArray(arr)) return;

    const list = document.getElementById('cardList');
    const placeholder = ctx + '/assets/images/placeholder.jpg';

    arr.forEach(function (r) {
      // 가능한 필드 이름 후보들 (서버 응답 구조가 조금 달라도 대응)
      const spacesNo = findField(r, ['spacesNo', 'spaces_no', 'spacesno', 'id', 'spaceId', 'spaceNo']);
      const rawLink = findField(r, ['spaceLink', 'space_link', 'spaceLink', 'link', 'spaceImage', 'spaceImg', 'image']);
      const spaceName = findField(r, ['spaceName', 'space_name', 'name', 'title']) || '';
      const spaceSummary = findField(r, ['spaceSummary', 'space_summary', 'summary']) || '';
      const spaceInfo = findField(r, ['spaceInfo', 'space_info', 'info', 'description']) || '';

      // build href to zone page (like static cards)
      const href = ctx + '/onespace/practice2_zone?spacesNo=' + encodeURIComponent(spacesNo);

      const src = resolveImg(rawLink || '');

      const card = document.createElement('div');
      card.className = 'card';

      // 전체 카드를 하나의 앵커로 감싸서 이미지+제목 모두 같은 링크로 동작
      card.innerHTML = ''
        + '<a href="' + href + '">'
          + '<div class="card-img-wrap">'
            + '<img class="card-img" src="' + src + '" alt="' + escapeHtml(spaceName) + '"'
              + ' onerror="this.onerror=null;this.src=\'' + placeholder + '\';">'
          + '</div>'
          + '<div class="card-content">'
            + '<div class="card-title">' + escapeHtml(spaceName) + '</div>'
            + '<div class="card-meta">' + escapeHtml(spaceSummary) + '</div>'
            + '<div class="card-meta">' + escapeHtml(spaceInfo) + '</div>'
          + '</div>'
        + '</a>';

      list.appendChild(card);
    });
  }

  //loadMore, observer 로직은 기존과 동일 (필요시 아래 코드를 원래 위치에 유지)
  async function loadMore() {
    if (loading || done) return;
    loading = true;

    const url = ctx + '/onespace/api/practicerooms?page=' + page + '&size=' + size;
    console.log('[loadMore] page=', page, 'GET', url);

    try {
      const res = await fetch(url, { headers: { 'Accept':'application/json' } });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const data = await res.json();

      console.log('[loadMore] data:', data);

      if (!Array.isArray(data) || data.length === 0) {
        done = true;
        return;
      }

      appendCards(data);

      if (data.length < size) {
        done = true; // 마지막 페이지
      } else {
        page++; // 다음 페이지 준비
      }
    } catch (e) {
      console.error('[loadMore] error', e);
      done = true;
    } finally {
      loading = false;
    }
  }

  document.addEventListener('DOMContentLoaded', loadMore);

  const sentinel = document.getElementById('sentinel');
  const observer = new IntersectionObserver(entries => {
    if (entries[0].isIntersecting && !loading && !done) {
      loadMore();
    }
  });
  if (sentinel) observer.observe(sentinel);
  </script>
  
  </div>
  
  <!-- 푸터 영역------------------------------------------------ -->
  <footer>
    <c:import url="/WEB-INF/views/include/footer.jsp" />
  </footer>
  <!-- /푸터 영역----------------------------------------------- -->
    
</body>
</html>
