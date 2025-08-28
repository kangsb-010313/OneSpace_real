<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

  <head>
  
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  
  
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

          <h2 class="perforlist-title">공연 및 대회 정보</h2>
          
          <!-- 글쓰기 버튼: 로그인 사용자에게만 보이게 -->
          <div class="btn-area">
            <c:if test="${not empty sessionScope.authUser or not empty sessionScope.authUserNo}">
              <c:url var="writeFormUrl" value="/onespace/perforinfo/writeForm"/>
				<a href="${writeFormUrl}" class="btn-write">글쓰기</a>
            </c:if>
          </div>

          <div class="perforlist-list">
            <table class="perforlist-table"
            		data-total="${total}"
            		data-size="${size}"
            		data-loaded="${loaded}">
              <colgroup>
                <col style="width:120px" />
                <col />
                <col style="width:160px" />
              </colgroup>
              <thead>
                <tr>
                  <th>카테고리</th>
                  <th>제목</th>
                  <th>마감일</th>
                </tr>
              </thead>

              <c:choose>
                <c:when test="${not empty list}">
                  <tbody>
                    <c:forEach var="item" items="${list}">
                      <tr>
                        <td class="cate">[<c:out value="${item.infoPostType}" />]</td>

                        <c:url var="viewUrl" value="/onespace/perforinfo/view">
                          <c:param name="no" value="${item.infoPostNo}" />
                        </c:url>
                        <td class="tit">
                          <a href="${viewUrl}">
                            <c:out value="${item.infoPostTitle}" />
                          </a>
                        </td>

                        <td class="date"><c:out value="${item.deadlineDate}" /></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </c:when>
                <c:otherwise>
                  <tbody>
                    <tr><td colspan="3" class="empty">등록된 정보가 없습니다.</td></tr>
                  </tbody>
                </c:otherwise>
              </c:choose>
            </table>
          </div>

          

          <!-- 페이징 (더보기) -->
	      <div class="loadmoreWrap">
		    <button id="btnLoadMore" class="btnloadmore"
		     <c:if test="${loaded >= total}">style="display:none"</c:if>>
		     더보기
		    </button>
	   	 </div>

        </div>
      </main>

      <!-- 푸터 -->
      <jsp:include page="/WEB-INF/views/include/footer.jsp" />
    </div>
    
    <script>
$(function () {
  var $table  = $('.perforlist-table');
  var $tbody  = $table.find('tbody');
  var $btn    = $('#btnLoadMore');

  var total  = parseInt($table.data('total')  || 0, 10);
  var size   = parseInt($table.data('size')   || 10, 10);
  var loaded = parseInt($table.data('loaded') || 0, 10);

  // 초기에도 다 찼으면 버튼 숨김
  if (loaded >= total) $btn.hide();

  $btn.on('click', function () {
    // 남은 수 계산 (프런트만으로도 가능)
    var remain = total - loaded;
    if (remain <= 0) { $btn.hide(); return; }

    // 서버는 limit=size로 고정 요청해도 됨(컨트롤러 수정 없이)
    var limit = Math.min(size, remain);

    $btn.prop('disabled', true);

    $.getJSON('/onespace/perforinfo/more', { offset: loaded, limit: limit })
      .done(function (rows) {
        var got = ($.isArray(rows) ? rows.length : 0);

        if (got > 0) {
          var html = '';
          for (var i=0; i<got; i++) {
            var r = rows[i] || {};
            var href = '/onespace/perforinfo/view?no=' + encodeURIComponent(r.infoPostNo);
            html += '<tr>'
                 +    '<td class="cate">[' + (r.infoPostType || '') + ']</td>'
                 +    '<td class="tit"><a href="' + href + '">' + (r.infoPostTitle || '') + '</a></td>'
                 +    '<td class="date">' + (r.deadlineDate || '') + '</td>'
                 +  '</tr>';
          }
          $tbody.append(html);
          loaded += got;  // ★ 로드된 개수 갱신
        }

        // ★ 서버가 덜 주거나(마지막 페이지) 0개면 버튼 숨김
        if (loaded >= total || got < limit) {
          $btn.hide();
        }
      })
      .always(function () {
        if ($btn.is(':visible')) $btn.prop('disabled', false);
      });
  });
});
</script>

    
  </body>
</html>