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
     
    <link rel="stylesheet" type="text/css" href="/css-bj/login.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %>

<div class="login">
  <div class="login-header">
    <h1>술주정1</h1>
  </div>
  <form action="/user/loginProcess" method="post" id="frmLogin">
    <div class="login-form">
        <h3>Username:</h3>
        <input type="text" placeholder="Username" name="id" id="txtId"/><br> 
        <h3>Password:</h3>
        <input type="password" placeholder="Password" name="passwd"id="txtPasswd"/> 
        <br>
        <input type="button" value="Login" class="login-button" id="btnLogin"/> 
        <br>
        <a class="sign-up" href="/user/join">Sign Up!</a> 
        <br>
        <h6 class="no-access">Can't access your account?</h6>
    </div>
  </form>
</div>


<script>
(() => {
    const $btnLogin = document.querySelector('#btnLogin');
    const $btnJoin  = document.querySelector('#btnJoin');
    const $frmLogin = document.querySelector('#frmLogin');
    const $txtId = document.querySelector('#txtId'); 
    const $txtPasswd = document.querySelector('#txtPasswd'); 

    $btnLogin.addEventListener('click', () => {
        const id = $txtId.value.trim(); 
        const passwd = $txtPasswd.value.trim(); 

        //1. 아이디, 패스워드가 빈칸인지 확인.
        if (id === '' || passwd === '') {
            alert('아이디 또는 패스워드를 정확히 입력하세요');
            return;
        }

        //2. 로그인 처리
        $frmLogin.submit();
    });

    $btnJoin.addEventListener('click', ()=>{
        location.href = '/user/join';

    });

})();
</script>
<script src="/js-bj/login.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
