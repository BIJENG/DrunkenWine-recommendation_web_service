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
    <div class="container mt-4">
        <div class="card">
            <div class="card-header">
                <h2>NEW COMMENT</h2>
            </div>
            <div class="card-body">
                <!-- 댓글 입력 폼 -->
                <form action="/board/commentInsertProcess" method="post" id="frmComment" class="mb-4 needs-validation" novalidate>
                    <input type="hidden" name="no" value="${vo.no}">
                    <div class="mb-3">
                        <label for="txtComment" class="form-label">새 댓글 작성</label>
                        <textarea class="form-control" name="comment_content" id="txtComment" rows="3" required></textarea>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">댓글 작성</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="container mt-5">
        <h1>COMMENTS</h1>
        <ul id="comment-list" class="list-group"></ul>
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(()=>{
    
    
    const $txtMainTitle = document.querySelector('#txtMainTitle');
    const $frmContent   = document.querySelector('#frmContent');
    const $txtTitle     = document.querySelector('#txtTitle');
    const $txtContent   = document.querySelector('#txtContent'); 
    const $contentImg = document.querySelector('#contentImg');

    
    const $btnEdit      = document.querySelector('#btnEdit');
    const $btnSave      = document.querySelector('#btnSave');
    const $btnBoard     = document.querySelector('#btnBoard');
    const $btnDelete      = document.querySelector('#btnDelete');
    const $btnprevcontent = document.querySelector('.btn-prevcontent');
    const $btnnextcontent = document.querySelector('.btn-nextcontent');
    
    const imgPath = "${vo.imgpath}";
    $contentImg.setAttribute("src", imgPath);

    if (${readOnly}) {
        $btnSave.style.display = "none";
        $btnDelete.style.display = "none";
        $btnEdit.style.display = "none";
    } 
    else{
        $btnEdit.style.display = "inline";
        $btnEdit.addEventListener('click',()=>{

            $btnSave.style.display = "inline";
            $btnDelete.style.display = "inline";
            $btnEdit.style.display = "none";
            $txtContent.setAttribute("contenteditable", "true");
            $contentImg.style.display = 'none';
            $txtContent.removeAttribute("disabled");
            
        });

    }

    

    function getCurrentPageNo() {
        const currentPageUrl = window.location.href;
        const queryString = currentPageUrl.split('?')[1];
        if (!queryString || queryString.indexOf('no=') === -1) {
            return null;
        }
        const pageNo = queryString.split('no=')[1].split('&')[0];
        return parseInt(pageNo);
    }

    $btnprevcontent.addEventListener('click',()=>{

        if(getCurrentPageNo() <= 1)
        {   
            event.preventDefault();
            alert('이전글이 없습니다.');
            return;
        }

    });

    $btnSave.addEventListener('click', ()=>{
        const formData = new FormData($frmContent);
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/saveProcess', true);

        xhr.onreadystatechange = function() {
            if ((xhr.readyState === XMLHttpRequest.DONE) && (xhr.status === 200)) { 
                if (xhr.responseText === 'true'){
                    location.href="/board/list";
                    alert('저장되었습니다.'); 
                }             
                else
                    alert('저장에 실패하였습니다.');
                    location.href="/board/list";
            }
        }

        xhr.send(formData);

    });

    $btnBoard.addEventListener('click', ()=>{
        location.href='/board/list';
        
    });

    $btnDelete.addEventListener('click', ()=>{
        if (confirm('게시글이 영구히 삭제 됩니다. 삭제 할까요?')) {

            const formData = new FormData($frmContent);
        
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '/board/deleteProcess', true);

            xhr.onreadystatechange = function() {
                if ((xhr.readyState === XMLHttpRequest.DONE) && (xhr.status === 200)) { 
                    if (xhr.responseText === "true")
                    {
                        alert('삭제 되었습니다.');
                        location.href="/board/list";
                    }
                    else {
                        alert('삭제에 실패하였습니다.');
                        location.href="/board/list";
                    }
                    
                    
                }
            }

            xhr.send(formData);
        }
    
    });


    function loadCommentsWithAjax() {
    // 현재 URL에서 'no' 매개변수를 추출
    const params = new URLSearchParams(window.location.search);
    const contentNo = params.get('no');

    // 게시글 번호가 있는 경우
    if (contentNo) {
        const encodedNo = encodeURIComponent(contentNo);
        
        // AJAX 요청을 통해 댓글 데이터를 가져옴
        fetch(`/board/CommentlistProcess`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ no: encodedNo }) // POST 요청 본문에 데이터를 JSON으로 전달
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('네트워크 응답에 문제가 있습니다.');
            }
            return response.json(); // JSON 형태로 응답을 파싱
        })
        .then(comments => {
            displayComments(comments); // 댓글 표시 함수 호출
        })
        .catch(error => {
            console.error('댓글을 가져오지 못했습니다.', error);
        });
    } else {
        console.error('게시글 번호가 없습니다.');
    }
}

document.addEventListener("DOMContentLoaded", function () {
    loadCommentsWithAjax();
});

function displayComments(comments) {
    // 댓글을 표시할 컨테이너 요소 가져오기
    const commentList = document.getElementById('comment-list');
    if (!commentList) {
        console.error("Cannot find comment list container.");
        return;
    }
    commentList.innerHTML = ''; // 기존 내용을 초기화

    // 각 댓글 객체를 순회하며 HTML로 변환
    comments.forEach(comment => {
        // 각 필드에서 데이터가 제대로 전달되었는지 확인
        const userId = comment.userid || "알 수 없는 사용자";
        const content = comment.commentcontent || "내용 없음";
        const regDate = comment.regdate || "날짜 없음";

        // 댓글을 나타내는 li 요소 생성
        const listItem = document.createElement('li');
        listItem.className = 'list-group-item d-flex justify-content-between align-items-start';

        // 댓글 내용을 HTML로 구성
        listItem.innerHTML = 
        '<div>' +
            '<strong> 작성자 : ' + userId + '</strong>' +
            '<p>' + content + '</p>' +
        '</div>' +
        '<small class="text-muted">' + regDate + '</small>';

        // 댓글을 컨테이너에 추가
        commentList.appendChild(listItem);
    });
}


})();
</script>
<script src="/js-bj/login.js"></script>        
</body>
</html>
