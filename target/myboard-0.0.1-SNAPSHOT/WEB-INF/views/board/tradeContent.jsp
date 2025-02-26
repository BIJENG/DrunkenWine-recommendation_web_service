<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="com.example.myboard.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css-sk/style_board_content.css">
    <title>게시글 수정</title>
    <style>
        .content-container {
            height: 600px; /* 원하는 높이 값으로 설정하세요 */
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %>

    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h1 class="mb-0">${vo.title}</h1> <!-- 게시글 제목 -->
            </div>
            <div class="card-body">
                <form action="/board/saveProcess" method="post" id="frmContent" class="needs-validation" novalidate>
                    <input type="hidden" name="no" value="${vo.no}">
                    <div class="mb-3 row">
                        <label class="col-auto col-form-label">아이디:</label>
                        <div class="col">
                            <span class="form-control-plaintext">${vo.id}</span>
                        </div>
                        <label class="col-auto col-form-label">날짜:</label>
                        <div class="col">
                            <span class="form-control-plaintext">${vo.regdate}</span>
                        </div>
                        <label class="col-auto col-form-label">조회수:</label>
                        <div class="col">
                            <span class="form-control-plaintext">${vo.vcount}</span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="txtContent" class="form-label">내용</label>
                        <div class="content-container" id="txtContent" name="content" contenteditable="flase">
                            <img id="contentImg" src="${vo.imgpath}" alt="이미지 설명">
                            <p>${vo.content}</p>
                        </div>
                    </div>
                    <div class="text-end">
                        <button id=btnEdit type="button" class="btn btn-primary" style="display: none;">수정</button>  
                        <button id="btnSave" type="submit" class="btn btn-primary" style="display: none;">저장</button>         
                        <button id=btnDelete type="button" class="btn btn-danger" style="display: none;">삭제</button>
                        <button id=btnBoard type="button" class="btn btn-secondary" onclick="location.href='/board/list'">목록으로</button>
                    </div>
                </form>
               

                
            </div>
            <div class="card-footer">
                <div class="vertical-links">
                    <div class="link-item">
                        <a href="/board/content?no=${vo.no - 1}" class="btn btn-outline-secondary btn-prevcontent">이전글</a>
                        <span class="link-title">이전글 제목</span>
                    </div>
                    <div class="link-item">
                        <a href="/board/content?no=${vo.no + 1}" class="btn btn-outline-secondary">다음글</a>
                        <span class="link-title">다음글 제목</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(()=>{
  
})();
</script>
<script src="/js-bj/login.js"></script>        
</body>
</html>
