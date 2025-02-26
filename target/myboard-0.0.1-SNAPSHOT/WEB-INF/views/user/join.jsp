<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="com.example.myboard.vo.UserVO" %>
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
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %>

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
                    location.href="/user/login";
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
