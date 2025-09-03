<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>원스페이스 | 연습실찜하기</title>
    <link rel="stylesheet" href="${ctx}/assets/css/reset.css">
    <link rel="stylesheet" href="${ctx}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${ctx}/assets/css/practice1_main.css">
    
    <%-- JSP 변수: contextPath를 ctx로 세팅 --%>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
</head>
<body>
    <div id="wrap">

        <!-- 헤더 영역------------------------------------------------ -->
        <c:import url="/WEB-INF/views/include/header.jsp" />
        <!-- /헤더 영역----------------------------------------------- -->

        <!-- 본문 -->
        <!-- 컨텐츠 영역---------------------------------------------- -->
        <main>
            <div class="container">
            	
            	<!-- 페이지 상단 타이틀 영역 -->
                <div class="title-box">
                    <div class="spacer"></div>
                    <h2 class="page-title">연습실찜하기</h2>
                    
                    <%-- 찜리스트 버튼 --%>
                    <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/practice/practice4_wish'">
                        찜리스트<span style="color: #ff3333;">❤</span>
                    </button>
                </div>
                
                <!-- 메인 콘텐츠 -->
                <div class="main-section">
                    <div class="content-area">
						
						<!-- 검색창 영역 -->
                        <div class="search-row">
                            <input id="searchInput" class="search-hash" type="text" placeholder="#찾는 공간이 있나요?" />
                            <!-- 
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
                            -->
                        </div>

                        <!-- 카드 그리드: DB에서 rooms 리스트 출력 -->
                        <div class="card-list" id="cardList">
                            <c:forEach var="r" items="${rooms}">
                                <div class="card">
                                	<%-- 상세 페이지 링크 (practice2_zone.jsp) --%>
                                    <a href="${pageContext.request.contextPath}/practice/practice2_zone?spacesNo=${r.spacesNo}">
                                        <div class="card-img-wrap">
                                        	<%-- 업로드된 대표 이미지 출력 --%>
                                            <img class="card-img" src="${pageContext.request.contextPath}/uploads/${r.repImg}" alt="${r.spaceName}">
                                        </div>
                                        <div class="card-content">
                                            <a href="${pageContext.request.contextPath}/practice/practice2_zone?spacesNo=${r.spacesNo}">
                                                <div class="card-title">${r.spaceName}</div>
                                            </a>
                                            <div class="card-meta">${r.spaceSummary}</div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>

                            <!-- rooms가 비었을 때 안내 -->
                            <c:if test="${empty rooms}">
                                <div style="padding: 24px; color: #777;">등록된 연습실이 없습니다.</div>
                            </c:if>
                        </div>
                        <%-- 무한 스크롤을 위한 sentinel --%>
                        <div id="sentinel" style="height: 1px;"></div>
                    </div>
                </div>
            </div>
        </main>
        <!-- /컨텐츠 영역---------------------------------------------- -->
		
		<!-- JavaScript: 무한 스크롤 & 검색 기능 -->
        <script>
            const ctx = '${pageContext.request.contextPath}';
            
         	// 무한 스크롤 페이지네이션 설정
            const size = 4; // 스크롤마다 4장
            let page = 2;	// 첫 페이지(1)는 서버에서 이미 렌더링, 이후는 2부터
            let loading = false, done = false; // 상태 플래그

            // 안전하게 속성값을 찾아주는 헬퍼 (여러 후보 키명을 시도)
            // 객체에서 후보 키 중 첫 번째로 존재하는 값을 반환
            function findField(obj, candidates) {
                for (let i = 0; i < candidates.length; i++) {
                    const k = candidates[i];
                    if (obj[k] !== undefined && obj[k] !== null) return obj[k];
                }
                return '';
            }

            // 간단한 HTML 이스케이프 (XSS 방지용, 출력용)
            function escapeHtml(s) {
                if (!s && s !== 0) return '';
                return String(s)
                    .replace(/&/g, '&amp;')
                    .replace(/</g, '&lt;')
                    .replace(/>/g, '&gt;')
                    .replace(/"/g, '&quot;')
                    .replace(/'/g, '&#39;');
            }

            // 이미지 경로 판단: http(s) / 웹절대경로(/...) / 파일명 -> assets/images/
            function resolveImg(raw) {
                const placeholder = ctx + '/assets/images/placeholder.jpg';
                if (!raw) return placeholder;
                try {
                    raw = String(raw);
                    if (raw.startsWith('http://') || raw.startsWith('https://') || raw.startsWith('/')) {
                        return raw;
                    }
                    return ctx + '/assets/images/' + raw;
                } catch (e) {
                    return placeholder;
                }
            }

            // 무한스크롤로 받아온 데이터(배열)를 카드로 추가
            function appendCards(arr) {
                console.log('[appendCards] received array:', arr);
                if (!Array.isArray(arr)) return;

                const list = document.getElementById('cardList');
                const placeholder = ctx + '/assets/images/placeholder.jpg';

                arr.forEach(function (r) {
                    const spacesNo = findField(r, ['spacesNo', 'spaces_no', 'spacesno', 'id', 'spaceId', 'spaceNo']);
                    const rawLink = findField(r, ['spaceLink', 'space_link', 'link', 'spaceImage', 'spaceImg', 'image']);
                    const repImg = findField(r, ['repImg', 'rep_img', 'repimage', 'thumbnail']);
                    const spaceName = findField(r, ['spaceName', 'space_name', 'name', 'title']) || '';
                    const spaceSummary = findField(r, ['spaceSummary', 'space_summary', 'summary']) || '';

                    let src = placeholder;
                    if (repImg) {
                        src = ctx + '/uploads/' + repImg;
                    } else if (rawLink) {
                        src = resolveImg(rawLink);
                    }

                    const href = ctx + '/practice/practice2_zone?spacesNo=' + encodeURIComponent(spacesNo);

                    const card = document.createElement('div');
                    card.className = 'card';

                    card.innerHTML = ''
                        + '<a href="' + href + '">'
                        + '<div class="card-img-wrap">'
                        + '<img class="card-img" src="' + src + '" alt="' + escapeHtml(spaceName) + '"'
                        + ' onerror="this.onerror=null;this.src=\'' + placeholder + '\';">'
                        + '</div>'
                        + '<div class="card-content">'
                        + '<div class="card-title">' + escapeHtml(spaceName) + '</div>'
                        + '<div class="card-meta">' + escapeHtml(spaceSummary) + '</div>'
                        + '</div>'
                        + '</a>';

                    list.appendChild(card);
                });
            }

            // 추가 데이터 로드 (무한 스크롤)
            async function loadMore() {
                if (loading || done) return;
                loading = true;

                const url = ctx + '/practice/api/practicerooms?page=' + page + '&size=' + size;
                console.log('[loadMore] page=', page, 'GET', url);

                try {
                    const res = await fetch(url, { headers: { 'Accept': 'application/json' } });
                    if (!res.ok) throw new Error('HTTP ' + res.status);
                    const data = await res.json();

                    console.log('[loadMore] data:', data);

                    if (!Array.isArray(data) || data.length === 0) {
                        done = true; // 더 이상 데이터 없음
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
			
         	// 첫 로딩 시 1회 호출
            document.addEventListener('DOMContentLoaded', loadMore);
			
         	// IntersectionObserver로 sentinel 감지 -> 무한 스크롤
            const sentinel = document.getElementById('sentinel');
            const observer = new IntersectionObserver(entries => {
                if (entries[0].isIntersecting && !loading && !done) {
                    loadMore();
                }
            });
            if (sentinel) observer.observe(sentinel);
        	
            
            // 검색
            document.getElementById('searchInput').addEventListener('keypress', function(e) {
		    if (e.key === 'Enter') {
		        const keyword = this.value.trim();
		        if (keyword) {
		            fetch(`${ctx}/practice/api/search?keyword=` + encodeURIComponent(keyword), {
		                headers: { 'Accept': 'application/json' }
		            })
		            .then(res => res.json())
		            .then(data => {
		                console.log('[search result]', data);
		                document.getElementById('cardList').innerHTML = ''; 
		                appendCards(data);
		
		                // 검색 모드에서는 무한 스크롤 종료
		                done = true;
		            })
		            .catch(err => console.error(err));
		        }
		    }
		});
            
        </script>

    </div>

    <!-- 푸터 영역------------------------------------------------ -->
    <c:import url="/WEB-INF/views/include/footer.jsp" />
    <!-- /푸터 영역----------------------------------------------- -->

</body>
</html>
