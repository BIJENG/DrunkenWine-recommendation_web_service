<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  
    <link href='https://fonts.googleapis.com/css?family=Ubuntu:500' rel='stylesheet' type='text/css'>
     
    <link rel="stylesheet" type="text/css" href="/css-bj/join.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="/user/index2">SpiritSage</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink1" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            소통하酒
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink1">
                            <li><a class="dropdown-item" href="/board/recommend">추천하酒</a></li>
                            <li><a class="dropdown-item" href="/board/list">소통하酒</a></li>
                            <li><a class="dropdown-item" href="#">거래하酒</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink2" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            순위보酒
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink2">
                            <li><a class="dropdown-item" href="/board/rank">순위보酒</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink3" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            찾酒
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink3">
                            <li><a class="dropdown-item" href="#">Chat酒PT</a></li>
                            <li><a class="dropdown-item" href="#">검색하酒</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex mx-auto my-2 my-lg-0">
                    <input class="form-control me-2" type="search" placeholder="통합검색" aria-label="Search">
                    <button class="btn btn-outline-primary" type="submit">Search</button>
                </form>
                <ul class="navbar-nav">
                    <li class="nav-item">
                      <a class="nav-link" href="/user/login">로그인</a>
                  </li>
                  <li class="nav-item">
                      <a class="nav-link" href="/user/join">회원가입</a>
                  </li>
                </ul>
            </div>
        </div>
      </nav>

<div class="login">
  <div class="login-header">
    <h1>SpiritSage</h1>
  </div>
  <form action="/user/joinProcess" method="post" id="frmJoin">
    <div class="login-form">
        <h3>아이디:</h3>
        <input type="text" placeholder="Id" name="id" id="txtId"/><br> 
        <h3>비밀번호:</h3>
        <input type="password" placeholder="Password" name="passwd"id="txtPasswd"/><br>
        <h3>성명:</h3>
        <input type="text" placeholder="Name" name="name" id="txtName"/><br> 
        <h3>이메일:</h3>
        <input type="text" placeholder="Email" name="email" id="txtEmail"/><br> 
        <h3>전화번호:</h3>
        <input type="text" placeholder="Phone" name="phone" id="txtPhone"/><br>

        <input type="button" value="가입하기" class="login-button" id="btnJoin"/> 
        <br>
        <a class="sign-up" href="/user/index2">Home</a> 
        <br>
        <h6 class="no-access">Can't access your account?</h6>
    </div>
  </form>
</div>


<script>
(()=>{
    const $frmJoin = document.querySelector('#frmJoin');
    const $btnJoin = document.querySelector('#btnJoin');
    const $btnHome = document.querySelector('#btnHome');

    const $txtId      = document.querySelector('#txtId');
    const $txtPasswd  = document.querySelector('#txtPasswd');
    const $txtName    = document.querySelector('#txtName');
    const $txtEmail   = document.querySelector('#txtEmail');
    const $txtPhone   = document.querySelector('#txtPhone');


    $btnJoin.addEventListener('click', ()=>{
        const id      = $txtId.value;
        const passwd  = $txtPasswd.value;
        const name    = $txtName.value;
        const email   = $txtEmail.value;
        const phone   = $txtPhone.value;

        if ((id.trim()     == '') || 
            (passwd.trim() == '') || 
            (name.trim()   == '') || 
            (email.trim()  == '') ||
            (phone.trim()  == '')) {
                alert("회원가입 정보를 모두 넣어 주세요.")
                return;
        }

        const formData = new FormData($frmJoin);

        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/user/joinProcess', true);
        xhr.onreadystatechange = function() {
            if ((xhr.readyState === XMLHttpRequest.DONE) && (xhr.status === 200)) {
                if (xhr.responseText === 'true') {
                    alert('회원가입이 완료 되었습니다.');
                    location.href="/index";
                }
                else {
                    alert('회원가입이 실패하였습니다.');
                    $txtId.value = '';
                    $txtPasswd.value = '';
                    $txtName.value = '';
                    $txtEmail.value = '';
                    $txtPhone.value = '';
                }
            }
        }

        xhr.send(formData);

    });


    $btnHome.addEventListener('click', ()=>{
        location.href = "/index";
    });



})();
</script>
<script src="/js-bj/login.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
