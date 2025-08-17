<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스 | 내 공간 관리</title>
        <link rel="stylesheet" href="../../../assets/css/reset.css">
        <link rel="stylesheet" href="../../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../../assets/css/host_manage_added.css">
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
					  <button class="tab active" type="button"
					          onclick="location.href='${pageContext.request.contextPath}/onespace/hostcenter/info'">기본 정보 관리</button>
					  <button class="tab" type="button"
					          onclick="location.href='${pageContext.request.contextPath}/onespace/hostcenter/spaces'">내 공간 관리</button>
					</div>

                    <!-- 공간 카드 전체 -->
                    <div class="space-manage-container">
                        <h2 class="main-title">내 공간 관리</h2>

                        <!-- 공간 카드 1 -->
                        <div class="space-item">
                            <!-- 이미지 -->
                            <img
                              class="space-thumb"
                              src="../../../assets/images/room1.jpg"
                              alt="공간 사진"
                            />
                          
                            <!-- 정보 + 버튼 -->
                            <div class="space-contents">
                              <!-- 정보 -->
                              <div class="space-info">
                                <div class="row">
                                  <div class="label">공간명</div>
                                  <div class="value">연습실 1</div>
                                </div>
                                <div class="row">
                                  <div class="label">주소</div>
                                  <div class="value">서울특별시 강남구 87번길 6 B1 102호</div>
                                </div>
                                <div class="row">
                                  <div class="label">공간 면적</div>
                                  <div class="value">165㎡</div>
                                </div>
                                <div class="row">
                                  <div class="label">시설 안내</div>
                                  <div class="value">주차, 실외화, 실내 화장실, 스피커</div>
                                </div>
                              </div>
                          
                              <!-- 수정 버튼 -->
                              <div class="space-edit">
                                <button class="btn-edit">수정하기</button>
                              </div>
                            </div>
                          </div>

                        <!-- 공간 카드 2 -->
                        <div class="space-item">
                            <!-- 이미지 -->
                            <img
                              class="space-thumb"
                              src="../../../assets/images/room1.jpg"
                              alt="공간 사진"
                            />

                            <!-- 정보 + 버튼 -->
                            <div class="space-contents">
                              <!-- 정보 -->
                              <div class="space-info">
                                <div class="row">
                                  <div class="label">공간명</div>
                                  <div class="value">연습실 2</div>
                                </div>
                                <div class="row">
                                  <div class="label">주소</div>
                                  <div class="value">서울특별시 강남구 87번길 6 B1 102호</div>
                                </div>
                                <div class="row">
                                  <div class="label">공간 면적</div>
                                  <div class="value">165㎡</div>
                                </div>
                                <div class="row">
                                  <div class="label">시설 안내</div>
                                  <div class="value">주차, 실외화, 실내 화장실, 스피커</div>
                                </div>
                              </div>
                          
                              <!-- 수정 버튼 -->
                              <div class="space-edit">
                                <button class="btn-edit">수정하기</button>
                              </div>
                            </div>
                          </div>

                        <!-- 공간 카드 3 -->
                        <div class="space-item">
                          <!-- 이미지 -->
                          <img
                            class="space-thumb"
                            src="../../../assets/images/room1.jpg"
                            alt="공간 사진"
                          />
                        
                          <!-- 정보 + 버튼 -->
                          <div class="space-contents">
                            <!-- 정보 -->
                            <div class="space-info">
                              <div class="row">
                                <div class="label">공간명</div>
                                <div class="value">연습실 3</div>
                              </div>
                              <div class="row">
                                <div class="label">주소</div>
                                <div class="value">서울특별시 강남구 87번길 6 B1 102호</div>
                              </div>
                              <div class="row">
                                <div class="label">공간 면적</div>
                                <div class="value">165㎡</div>
                              </div>
                              <div class="row">
                                <div class="label">시설 안내</div>
                                <div class="value">주차, 실외화, 실내 화장실, 스피커</div>
                              </div>
                            </div>
                        
                            <!-- 수정 버튼 -->
                            <div class="space-edit">
                              <button class="btn-edit">수정하기</button>
                            </div>
                          </div>
                        </div>
                        

                        <!-- 버튼 -->
                        <div class="btn-wrapper">
                        <a href="#" class="btn-host-manage">새 공간 등록하기</a>
                        </div>
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