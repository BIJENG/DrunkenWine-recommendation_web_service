<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="com.example.myboard.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css-sk/style_board_sotong.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <title>글쓰기</title>
</head>
<body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %>

    <div class="container text-center mt-5">
        <h1 class="mb-4">글쓰기</h1>
        <form action="/board/insertProcess" method="post" enctype="multipart/form-data" id="frmNewContent" class="mb-3">
            <div class="mb-3 text-start">
                <label for="txtTitle" class="form-label">제목</label>
                <input type="text" class="form-control" name="title" id="txtTitle" required>
            </div>
            <div class="mb-3 text-start">
                <label for="txtContent" class="form-label">내용</label>
                <textarea name="content" id="txtContent" class="form-control" cols="50" rows="10" required></textarea>
            </div>
            <div class="mb-3 text-start">
                <label for="fileImage" class="form-label">사진 업로드</label>
                <input type="file" name="image" id="fileImage" class="form-control" accept="image/*">
            </div>
            <button id= "btnInsert" type="submit" class="btn btn-outline-primary">저장</button>
            <button type="button" class="btn btn-outline-secondary" onclick="location.href='/board/list'">목록으로</button>
        </form>
    </div>
    
<script>
(()=>{
    const $frmNewContent= document.querySelector('#frmNewContent')
    const $txtTitle     = document.querySelector('#txtTitle');
    const $txtContent   = document.querySelector('#txtContent');
    
    const $btnInsert    = document.querySelector('#btnInsert');
    const $btnBoard     = document.querySelector('#btnBoard');
    

    $btnInsert.addEventListener('click', ()=>{

        const title = $txtTitle.value;
        const content = $txtContent.value;

        //제목이나 내용이 있다면 경고메시지를 뿌려준다. 
        if ((title.trim() === '') || (content.trim() === '')) {
            alert('제목 또는 내용이 잘못되었습니다.');
            return;        
        }

        const formData = new FormData($frmNewContent);

        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/insertProcess', true);
        xhr.onreadystatechange = function() {
            if ((xhr.readyState === XMLHttpRequest.DONE) && (xhr.status === 200)) { 
                console.log(xhr.responseText);
                if (xhr.responseText === 'true') {
                    alert('저장되었습니다.');
                    location.href='/board/list';
                } else {
                    alert('저장에 실패하였습니다.');
                }
                    
            }
        }

        xhr.send(formData);

    });

    $btnBoard.addEventListener('click', ()=>{
        const title = $txtTitle.value;
        const content = $txtContent.value;

        //제목이나 내용이 있다면 경고메시지를 뿌려준다. 
        if ((title.trim() !== '') || (content.trim() !== '')) {
            if (confirm('작성중인 글을 취소하고 목록으로 갈까요?')) {
                location.href = '/board/list';
            }            
        }
        else {
            location.href = '/board/list';
        }

    });




})();
    
</script>
<script src="/js-bj/login.js"></script>
</body>
</html>

