<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <title>원스페이스-메인화면</title>
        <link rel="stylesheet" href="../../assets/css/reset.css">
        <link rel="stylesheet" href="../../assets/css/basicdefault.css">
        <link rel="stylesheet" href="../../assets/css/main.css">
    </head>

    <body>
        <div id="wrap">

            <!-- 헤더 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/header.jsp" />
            <!-- /헤더 영역------------------------------------------------ -->





            <!-- 컨텐츠 영역---------------------------------------------- -->
            <main>
                <div class="container">
                    <!-- 검색창 START -->
                    <div class="search-bar">
                        <input type="text" placeholder="#찾는 공간이 있나요?">
                    </div>

                    <div class="space-list">
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진01.jpg" alt="퍼스트연습실">
                            <div class="card-content">
                                <div class="card-title">퍼스트 연습실</div>
                                <div class="card-price">7,000원 ~ 12,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        강동구 | 실외화 가능/ 주차/ 최대15인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진02.jpg" alt="넥스트연습실">
                            <div class="card-content">
                                <div class="card-title">네스트 연습실</div>
                                <div class="card-price">10,000원 ~ 17,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        광진구 | 최대 7인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진03.jpg" alt="퍼스트스튜디오">
                            <div class="card-content">
                                <div class="card-title">드림 스튜디오</div>
                                <div class="card-price">3,000원 ~ 7,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">   
                                        동대문구 | 실외화 가능/ 주차/ 최대 15인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진04.jpg" alt="퍼스트연습실2">
                            <div class="card-content">
                                <div class="card-title">픽스튜디오</div>
                                <div class="card-price">7,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        강동구 | 최대 7인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진05.jpg" alt="넥스트연습실2">
                            <div class="card-content">
                                <div class="card-title">넥스트 연습실</div>
                                <div class="card-price">10,000원 ~ 17,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        강동구 | 최대 5인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진06.jpg" alt="퍼스트스튜디오2">
                            <div class="card-content">
                                <div class="card-title">퍼스트스튜디오</div>
                                <div class="card-price">3,000원 ~ 7,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        동대문구 | 실외화 가능/ 주차/ 최대 20인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진07.jpg" alt="퍼스트연습실3">
                            <div class="card-content">
                                <div class="card-title">건대 네스트</div>
                                <div class="card-price">6,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        동대문구 | 실외화 가능/ 최대 7인
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="space-card">
                            <img src="../../assets/images/연습실사진08.jpg" alt="빅스튜디오">
                            <div class="card-content">
                                <div class="card-title">우리스튜디오</div>
                                <div class="card-price">8,000원
                                    <span class="card-time">/시간</span>
                                    <span class="special-tag"><br>
                                        <img src="../../assets/images/위치아이콘.jpg" class="mapimg">
                                        광진구 | 주차/ 최대 15인
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- sapce-list -->

                    <h2 class="section-title">#우리팀 좀 보세요!</h2>
                    <div class="team-list">
                        
                            <a class="team-card" href="<c:url value='/pride/detail/1'/>">
                                <img src="../../assets/images/팀자랑사진01.jpg" alt="팀1" />
                            </a>
                            <a class="team-card" href="<c:url value='/pride/detail/2'/>">
                                <img src="../../assets/images/팀자랑사진02.jpg" alt="팀2" />
                            </a>
                            <a class="team-card" href="<c:url value='/pride/detail/3'/>">
                                <img src="../../assets/images/팀자랑사진03.jpg" alt="팀3" />
                            </a>
                            <a class="team-card" href="<c:url value='/pride/detail/4'/>">
                                <img src="../../assets/images/팀자랑사진04.jpg" alt="팀4" />
                            </a>
                            <a class="team-card" href="<c:url value='/pride/detail/1'/>">
                                <img src="../../assets/images/팀자랑사진01.jpg" alt="팀1" />
                            </a>
                            <a class="team-card" href="<c:url value='/pride/detail/2'/>">
                                <img src="../../assets/images/팀자랑사진02.jpg" alt="팀2" />
                            </a>
                            
                        <!-- 필요 개수만큼 추가 -->
                    </div>

                </div>
                <!-- container -->

            </main>




            <!-- 푸터 영역------------------------------------------------ -->
            <c:import url="/WEB-INF/views/include/footer.jsp" />
            <!-- /푸터 영역------------------------------------------------ -->


        </div>
        <!-- wrap -->
    </body>

</html>