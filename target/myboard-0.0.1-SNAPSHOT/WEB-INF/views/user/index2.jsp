<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="com.example.myboard.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="/css-bj/style.css">
  <link rel="stylesheet" type="text/css" href="/css-sk/style_index.css">
  <link rel="stylesheet" type="text/css" href="/css-hc/style.css">
  <style>
      section {
      opacity: 0;
      transition: opacity 1.5s ease-in-out;
      }
      
      #section0 {
        opacity: 1 !important; /* section0의 불투명도를 1로 고정 */
      }

      #section2 {
        background-color: #F0F0F2;
      }

      .fade-in {
        opacity: 1 !important; /* 스크롤에 따라 밝아진 후 더 이상 사라지지 않음 */
      }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/user/navbar.jsp" %>
  <%@ include file="/WEB-INF/views/chat.jsp" %>

  <section id="section0">
    <div class="section0-video">
        <video src="/video/video.mp4" autoplay muted playsinline>대체텍스트</video>
        <div class="video-message a">
          <p>고급스러운 와인</p>
          <a href="/board/recommend">추천하酒</a>
        </div>
        <div class="video-message b">
          <p>많은 와인 데이터</p>
          <a href="/board/rank">순위보酒</a>
        </div>
        <div class="video-message c">
          <p>특별한날의 와인 찾기</p>
          <a href="/chatPage">Chat酒PT</a>
        </div>

        <div class="video-message d">
            <img src="/img/술주정.PNG" alt="당신을 위한 와인 이미지">
            <a href="">술주정에서 한잔의 즐거움을 만끽하세요</a>
        </div>
    </div>
  </section>

  <br><br><br><br><br><br>

  <section>
    <div class="container text-center">
      <p class="section-name">소통하酒</p> <br>
      <p class="section-content">사용자의 개성과 취향을 반영해 주류를 추천하고<br>
        현재 위치기반으로 판매점을 알려드립니다
      </p>
    </div>

    <div class="wrap">
        <div class="rolling-list">
            <ul>
                <li>
                    <div class="image-wrap a">
                        <img src="/images/slide1.PNG" alt="picture1">
                        <div class="hidden-text">추천하酒</div>
                    </div>
                </li>

                <li>
                    <div class="image-wrap b">
                        <img src="/images/slide2.PNG" alt="picture2">
                        <div class="hidden-text">검색하酒</div>
                    </div>
                </li>
                <li>
                    <div class="image-wrap c">
                        <img src="/images/slide3.PNG" alt="picture3">
                        <div class="hidden-text">소통하酒</div>
                    </div>
                </li>

                <li>
                    <div class="image-wrap d">
                        <img src="/images/slide4.PNG" alt="picture4">
                        <div class="hidden-text">순위보酒</div>
                    </div>
                </li>

                <li>
                  <div class="image-wrap e">
                      <img src="/images/slide5.PNG" alt="picture4">
                      <div class="hidden-text">酒PT</div>
                  </div>
              </li>
            </ul>
        </div>
    </div>

    <div class="row">
      <div class="col text-center">
        <button class="btn btn-dark" type="button">소통하酒 접속</button>
      </div>
    </div>
  </section>

  <br><br><br><br><br><br>

  <section id="section2">
    <div class="container text-left">
      <p class="section-name">순위보酒</p> <br>
      <p class="section-text1">여러가지 기준의 와인랭킹을 제공해드리며,<br>
                                 해당 와인의 정보와 구매처를 제공해드립니다.
      </p>
      <video autoplay src="/video/intro.mp4" autoplay muted playsinline loop class="container text-center">
        <source src="" type="video/mp4">
      </video> <br>
      <br>
      <p class="container text-left section-text2">자체 데이터를 가지고 있으며, AI 분석을 통해 사용자에게 필요한 와인을 알려드립니다. </p><br>
      <p class="section-text3"> AI 분석기능</p><br>
      <p class="section-text3">당신이 원하는 와인을 酒PT를 통해 소개 받아 보세요! </p> <br>
      <div class="img1">
        <picture>
            <img src="/images/gpt.PNG" alt="랭킹 사진">
        </picture>
      </div><br>
      <p class="container text-right section-text4">와인을 잘 알지 못해도</p><br>
      <p class="section-text5">사용자가 원하는 특성을 입력해</p><br>
      <p class="section-text5">원하는 와인에 쉽게 접근 할 수 있어요</p> <br>
      
      
  
  
    </div>
  </section>

  <br><br><br><br><br><br>
  <section id="section3">
    <div class="container section1-element">
      <div class="row">
        <div class="col-6 sticky-element text-center">
          <!-- 이 요소는 스크롤 시 상단에 고정됩니다. -->
          <div class="sticky-top sticky-message">
            <div class="black-message">
              <p>찾酒</p>
            </div>
            <div class="grey-message">
              <p>당신이 찾는 모든 술, 이곳에 있습니다</p>
            </div>
            <div class="button-font">
              <button type="button" class="btn btn-dark">찾酒 확인하기</button>
            </div>
          </div>
        </div>
        <div class="col-6 right-section" >
          <div class="row ">
              <img src="/img/Section3_Chat주피티.gif " class="img-fluid" alt="">
              <div class="img-message">
                <p>Chat 酒PT <br>
                  당신이 원하는 술을 찾아드립니다
                </p>
              </div>
         
          <div class="row">
            <img src="/img/1번그림.JPG" class="img-fluid" alt="">
              <div class="img-message">
                <p>찾아보酒<br>
                  궁금한 술을 찾아드립니다
                </p>
              </div>
          <div class="row">
            <img src="/img/2.JPG" class="img-fluid"  alt="">
            <div class="img-message">
              <p>술 판매점 찾기<br>
                내 주변 술 판매점을 검색해드립니다
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <footer style="background-color: #888; color: #fff; text-align: center; padding: 20px;">
    <p>의정부 EZEN 아카데미 안병준</p>
    <p>의정부 EZEN 아카데미 김상권</p>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="/js-bj/main.js"></script>
  <script src="/js-sk/main.js"></script>
  <script src="/js-bj/login.js"></script>

  <script>
    document.addEventListener('scroll', function () {
    const sections = document.querySelectorAll('section');
    const windowHeight = window.innerHeight;

    sections.forEach(section => {
        const sectionTop = section.getBoundingClientRect().top;
        const sectionHeight = section.offsetHeight;
        
        // 섹션 상단이 윈도우 하단의 20% 지점에 도달했을 때 투명도 변경 시작
        const triggerPoint = windowHeight * 0.8;

        if (sectionTop <= triggerPoint && sectionTop + sectionHeight >= 0) {
            // Calculate opacity based on the scroll position
            const opacity = 1 - ((sectionTop - triggerPoint) / (windowHeight / 2));
            section.style.opacity = Math.max(0, Math.min(1, opacity));
            
            // Add fade-in class to prevent further fading
            section.classList.add('fade-in');
        }
    });
});
  </script>
</body>
</html>
