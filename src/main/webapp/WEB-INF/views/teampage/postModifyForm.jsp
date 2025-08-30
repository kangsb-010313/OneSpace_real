<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/basicdefault.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/asidedefault.css">
    
    <%-- ▼▼▼▼▼ 글 종류에 따라 다른 CSS 파일 로드 ▼▼▼▼▼ --%>
    <c:choose>
        <c:when test="${post.teamPostType == '일반공지'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teamwriteform.css">
        </c:when>
        <c:when test="${post.teamPostType == '투표'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/makevote.css">
        </c:when>
        <c:when test="${post.teamPostType == '팀자랑'}">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/teampriwriteform.css">
        </c:when>
        <c:otherwise>
             <%-- 기본 CSS 또는 에러 처리 (필요하다면) --%>
        </c:otherwise>
    </c:choose>
    
    <style>
        /* 수정 페이지 전용 스타일 */
        #unified-preview-zone { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px; padding: 10px;  min-height: 140px; }
        .file-item { position: relative; width: 150px; height: 150px; }
        .file-item img { width: 100%; height: 100%; object-fit: cover; }
        .delete-btn { position: absolute; top: 5px; right: 5px; cursor: pointer; background: rgba(255, 0, 0, 0.7); color: white; border: none; border-radius: 50%; width: 20px; height: 20px; font-weight: bold; display: flex; align-items: center; justify-content: center; line-height: 20px; }
        .file-item.deleted-existing img { opacity: 0.3; }
        .file-item.deleted-existing .delete-btn { background: rgba(0, 0, 0, 0.5); }
    </style>
</head>

<body>
    <div id="wrap">
        <!-- 헤더 영역 -->
        <c:import url="/WEB-INF/views/include/header.jsp" />

        <!-- 컨텐츠 영역 -->
        <main>
            <div class="container">
                <div id="content">
                
                	<!-- 팀페이지 aside ---------------------------------------------->
					<c:import url="/WEB-INF/views/include/asideteampage.jsp"></c:import>
					<!-- 팀페이지 aside ---------------------------------------------->

                    <div id="main-content">
                        <h2 class="post-type-title">
                            <c:choose>
                                <c:when test="${post.teamPostType == '일반공지'}">일반공지 수정</c:when>
                                <c:when test="${post.teamPostType == '팀자랑'}">팀자랑 수정</c:when>
                                <c:when test="${post.teamPostType == '투표'}">투표 수정</c:when>
                                <c:otherwise>게시글 수정</c:otherwise>
                            </c:choose>
                        </h2>
                        
                        <div class="post-register-wrap">
                            <form action="${pageContext.request.contextPath}/team/teams/${teamNo}/posts/modify" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="teamPostNo" value="${post.teamPostNo}">
                                <input type="hidden" name="teamPostType" value="${post.teamPostType}">
                                <input type="hidden" name="teamNo" value="${teamNo}">
                                <input type="file" id="files-input" name="files" multiple style="display: none;">

                                <!-- 제목 입력 영역 -->
                                <div class="form-group title-group">
                                    <label for="post-title">제목</label>
                                    <input type="text" id="post-title" name="teamPostTitle" value="${post.teamPostTitle}">
                                </div>

                                <!-- 글 종류에 따라 다른 내용 추가 (팀자랑) -->
                                <c:if test="${post.teamPostType == '팀자랑'}">
                                    <div class="form-group instagram-group">
                                        <label>인스타계정</label>
										<span>${post.instaAccount}</span> 
                                    </div>
                                </c:if>

                                <!-- 투표 글은 modifyForm으로 넘어오지 않지만, 혹시 모를 경우를 대비하여 투표 항목은 수정할 수 없음을 명시 -->
                                <c:if test="${post.teamPostType == '투표'}">
                                    <div class="form-group vote-list-group">
                                        <label>투표목록</label>
                                        <ol class="vote-items-container">
                                            <li>투표 게시글은 수정할 수 없습니다.</li>
                                            <li>(관리자에게 문의하세요)</li>
                                        </ol>
                                    </div>
                                </c:if>

                                <!-- 글 내용 및 파일 첨부 영역 -->
                                <div class="form-group content-group">
                                    <div class="content-header">
                                        <label for="post-content">글내용</label>
                                        <div class="file-attach-section">
                                            <label for="files-input" class="btn-file-attach">파일추가</label>
                                            <input type="file" id="files-input" name="files" multiple style="display: none;">

                                        </div>
                                    </div>
                                    <div class="content-box">
                                        <textarea id="post-content" name="teamContent">${post.teamContent}</textarea>
                                        
 										<div id="unified-preview-zone">
                                            <c:forEach items="${post.attachments}" var="file">
                                                <div class="file-item existing-file" id="file-item-${file.teamfileNo}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${file.teamStoredFileName}" alt="기존 첨부파일">
                                                    <button type="button" class="delete-btn" data-fileno="${file.teamfileNo}">X</button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <!-- === 3. 삭제할 파일 번호를 담을 숨겨진 div === -->
                                <div id="deleted-files-container" style="display: none;"></div>
                                

                                <!-- 하단 버튼 영역 -->
                                <div class="form-actions">
                                    <a href="${pageContext.request.contextPath}/team/teams/${teamNo}/posts/${post.teamPostNo}" class="btn-cancel">취소</a>
                                    <button type="submit" class="btn-submit">수정</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- 푸터 영역 -->
        <c:import url="/WEB-INF/views/include/footer.jsp" />
    </div>
    
<script>
document.addEventListener('DOMContentLoaded', function() {
    const filesInput = document.getElementById('files-input');
    const previewZone = document.getElementById('unified-preview-zone');
    const deletedFilesContainer = document.getElementById('deleted-files-container');
    
    // ★★★★★ 수정 3: 버튼 클릭 이벤트 리스너는 더 이상 필요 없으므로 삭제합니다.

    // 파일이 선택/변경될 때마다 실행
    filesInput.addEventListener('change', function(event) {
        renderPreviews();
    });

    // 미리보기 영역에서 삭제 버튼 클릭 처리
    previewZone.addEventListener('click', function(event) {
        if (event.target.classList.contains('delete-btn')) {
            const button = event.target;
            const fileItem = button.closest('.file-item');

            // Case 1: 기존 파일 삭제/복구 처리
            if (fileItem.classList.contains('existing-file')) {
                const fileNo = button.dataset.fileno;
                const existingHiddenInput = document.querySelector(`input[name='deletedFileNos'][value='${fileNo}']`);

                if (existingHiddenInput) { // 복구
                    existingHiddenInput.remove();
                    fileItem.classList.remove('deleted-existing');
                    button.textContent = 'X';
                } else { // 삭제
                    const hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = 'deletedFileNos';
                    hiddenInput.value = fileNo;
                    deletedFilesContainer.appendChild(hiddenInput);
                    fileItem.classList.add('deleted-existing');
                    button.textContent = '✔';
                }
            }
            // Case 2: 새로 추가한 파일 제거 처리
            else if (fileItem.classList.contains('new-file')) {
                const fileNameToRemove = button.dataset.filename;
                const dt = new DataTransfer();
                const { files } = filesInput;

                for (let i = 0; i < files.length; i++) {
                    if (files[i].name !== fileNameToRemove) {
                        dt.items.add(files[i]);
                    }
                }
                
                filesInput.files = dt.files; // input의 파일 목록을 업데이트
                renderPreviews(); // 변경된 목록으로 미리보기 다시 렌더링
            }
        }
    });

    // 파일 목록을 기반으로 미리보기를 렌더링하는 함수
    function renderPreviews() {
        // 새로 추가된 파일 미리보기만 지웠다가 다시 그림
        document.querySelectorAll('.new-file').forEach(el => el.remove());
        
        const { files } = filesInput;
        Array.from(files).forEach(file => {
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const newFileItem = document.createElement('div');
                    newFileItem.className = 'file-item new-file';
                    
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    
                    const deleteBtn = document.createElement('button');
                    deleteBtn.type = 'button';
                    deleteBtn.className = 'delete-btn';
                    deleteBtn.textContent = 'X';
                    deleteBtn.dataset.filename = file.name;

                    newFileItem.appendChild(img);
                    newFileItem.appendChild(deleteBtn);
                    previewZone.appendChild(newFileItem);
                };
                reader.readAsDataURL(file);
            }
        });
    }
});
</script>
    
</body>
</html>
