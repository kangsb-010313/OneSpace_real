<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 기본정보</title>
        <link rel="stylesheet" href="../../../assets/css/reset.css">
        <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../../assets/css/host_info2.css">
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
<!-- 탭 -->
    <div class="tab-btns">
      <button class="tab active">기본 정보 관리</button>
      <button class="tab">내 공간 관리</button>
    </div>

    <!-- 타이틀 & 밑줄 -->
    <div class="main-title-box">
      <h2 class="main-title">기본정보</h2>
    </div>
    
    <!-- 안내문구 -->
    <div class="maininfo-row">
      <div class="maininfo-guide">공간 정보를 입력해주세요.</div>
    </div>
    

    <!-- 입력 폼 -->
    <form>
      <!-- 공간정보 -->
      <section class="form-section">
        <div class="input-group">
          <label for="space-name">공간명</label>
          <span class="char-count">1자/18자</span>
          <input id="space-name" type="text" maxlength="18" placeholder="고유 업체명을 입력해주세요. (예: 인디워커스 하이브 회의실)">
        </div>
        <div class="input-group">
          <label for="space-detail">공간소개</label>
          <span class="char-count">0자/500자(최소 20자)</span>
          <textarea id="space-detail" rows="4" maxlength="500" placeholder="게스트들에게 필요한 공간 정보를 상세하게 소개해주세요."></textarea>
        </div>
        <!--공간면적-->
        <div class="input-group">
          <label for="space-desc">공간 면적</label>
          <span class="char-count">0자/20자</span>
          <input id="space-desc" type="text" maxlength="500" placeholder="시설 평수를 입력해주세요.">
        </div>
      </section>

      <!--이미지 -->
        <section class="form-section img-section">
          <div class="input-group">
            <div class="input-label-row">
              <label for="space-image">이미지</label>
              <span class="char-count img-guide">
                2048 * 1158 권장, 최대 3MB (최대 5장)<br>
                이미지 파일(JPG, PNG, JPEG)
              </span>
            </div>
            <input id="space-image" type="text" placeholder="이미지 파일을 선택해주세요.">
            
            <div class="attach-btn-wrap">
              <label class="btn-solid attach-btn">
                파일첨부
                <input type="file" hidden>
              </label>
            </div>
          </div>
        </section>

        <!-- 안내문구 -->
            <div class="maininfo-row">
                <h3 class="maininfo-guide">이용 정보를 입력해주세요.</h3>
            </div>


            <div class="useinfo-wrap">

                <!-- 최대인원 -->
                <div class="row-block center-align">
                    <div class="row-label-wrap">
                      <label class="row-label">최대인원</label>
                    </div>
                    <select class="select-box">
                      <option disabled selected>인원 선택 (5, 7, 15, 20명 중 골라주세요.)</option>
                      <option value="5">5명</option>
                      <option value="7">7명</option>
                      <option value="15">15명</option>
                      <option value="20">20명</option>
                    </select>
                  </div>
              
                <!-- 요일별 금액 -->
                <div class="row-block center-align">
                    <div class="row-label-wrap">
                        <label class="row-label">요일 별 금액</label>
                        <button class="btn-add">추가하기</button>
                    </div>
              
                  <div class="price-row-wrap">
                    <div class="price-row">
                      <select class="select-day">
                        <option>평일</option>
                        <option>주말</option>
                      </select>
              
                      <select class="select-time">
                        <option>00시</option>
                        <option>01시</option>
                        <option>02시</option>
                        <option>03시</option>
                        <option>04시</option>
                        <option>05시</option>
                        <option>06시</option>
                        <option>07시</option>
                        <option>08시</option>
                        <option>09시</option>
                        <option>10시</option>
                        <option>11시</option>
                        <option>12시</option>
                        <option>13시</option>
                        <option>14시</option>
                        <option>15시</option>
                        <option>16시</option>
                        <option>17시</option>
                        <option>18시</option>
                        <option>19시</option>
                        <option>20시</option>
                        <option>21시</option>
                        <option>22시</option>
                        <option>23시</option>
                        <option>24시</option>
                      </select>
              
                      <span class="text-label">부터</span>
              
                      <select class="select-time">
                        <option>00시</option>
                        <option>01시</option>
                        <option>02시</option>
                        <option>03시</option>
                        <option>04시</option>
                        <option>05시</option>
                        <option>06시</option>
                        <option>07시</option>
                        <option>08시</option>
                        <option>09시</option>
                        <option>10시</option>
                        <option>11시</option>
                        <option>12시</option>
                        <option>13시</option>
                        <option>14시</option>
                        <option>15시</option>
                        <option>16시</option>
                        <option>17시</option>
                        <option>18시</option>
                        <option>19시</option>
                        <option>20시</option>
                        <option>21시</option>
                        <option>22시</option>
                        <option>23시</option>
                        <option>24시</option>
                      </select>
              
                      <span class="text-label">까지</span>
              
                      <input type="text" class="input-price" placeholder="금액을 설정해주세요.">
                    </div>
              
                    
                  </div>
                </div>
              
              </div>





      <!-- 버튼 -->
      <div class="btn-row">
        <button class="btn prev-btn">이전</button>
        <button class="btn save-btn">저장</button>
      </div>
    </form>
  </div>


                










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