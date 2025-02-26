<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.myboard.vo.WineVO" %>
<%@ page import="com.example.myboard.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>와인추천</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  
  <link rel="stylesheet" type="text/css" href="/css-bj/recom.css">
  <style>
     @keyframes heartbeat {
        from {
          transform: scale(1);
        }
        to {
          transform: scale(1.1);
        }
      } 
      .loginCheck {
        background-color: #ccc; /* 회색 배경색 설정 */
        cursor: not-allowed; /* 커서를 포인터 대신 not-allowed로 변경하여 클릭 방지 */
        position: relative; /* 부모 요소로 설정하여 자식의 절대 위치 설정 */
      }

      .loginCheck:hover::before {
        content: "로그인이 필요합니다"; /* hover 상태일 때 텍스트 추가 */
        position: absolute;
        bottom: calc(100% + 5px); /* 버튼 위에 위치 */
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.7); /* 투명한 검은 배경색 */
        color: #fff; /* 텍스트 색상 */
        padding: 5px 10px; /* 여백 설정 */
        border-radius: 5px; /* 모서리 둥글게 */
        font-size: 12px; /* 폰트 크기 */
        white-space: nowrap; /* 텍스트를 한 줄로 표시 */
        display: inline-block; /* 한 줄로 표시 */
        visibility: hidden; /* 초기에는 보이지 않음 */
        transition: visibility 0.3s ease; /* 애니메이션 효과 추가 */
      }

      .loginCheck:hover::before {
        visibility: visible; /* hover 상태일 때만 텍스트 표시 */
      }
   
  
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/user/navbar.jsp" %>
  <%@ include file="/WEB-INF/views/chat.jsp" %>
  <br>

  <div class="container choice_check">
    <p class="choice-title">원하는 특성을 선택해주세요</p>
    <div class="choice-item">
      <img src="https://cdn-icons-png.flaticon.com/512/1410/1410986.png" alt="산도" class="icon-gray" id="imageIcon1">
      <h2>산도</h2>
      <input type="checkbox" id="cbtest1" class="box" />
      <label for="cbtest1" class="check-box"></label> 
      <p>와인의 신선하고 활기찬 맛</p>
    </div>
  
    <div class="choice-item">
      <img src="https://cdn-icons-png.flaticon.com/512/7615/7615359.png" alt="타닌" class="icon-gray" id="imageIcon2">
      <h2>타닌</h2>
      <input type="checkbox" id="cbtest2" class="box" />
      <label for="cbtest2" class="check-box"></label> 
      <p>와인의 탄력 있고 구조화된 느낌</p>
    </div>
  
    <div class="choice-item">
      <img src="https://cdn-icons-png.flaticon.com/512/4698/4698562.png" alt="바디" class="icon-gray" id="imageIcon3">
      <h2>바디</h2>
      <input type="checkbox" id="cbtest3" class="box" />
      <label for="cbtest3" class="check-box"></label> 
      <p>와인의 무게와 입안에서 느껴지는 느낌</p>
    </div>
    <div class="choice-item">
      <img src="https://cdn-icons-png.flaticon.com/512/5571/5571223.png" alt="당도" class="icon-gray" id="imageIcon4">
      <h2>당도</h2>
      <input type="checkbox" id="cbtest4" class="box" />
      <label for="cbtest4" class="check-box"></label> 
      <p>와인의 단맛 정도와 과일 풍미</p>
    </div>
  </div>
  <br>
  <div class="container choice_section">
    <button type="button" class="btn btn-secondary button-design" >#키워드</button>
    <button type="button" class="btn btn-secondary button-design" onclick="submitForm('시원한')">#시원한</button>
    <button type="button" class="btn btn-secondary button-design" onclick="submitForm('여름에 마시기 좋은')">#여름에 마시기 좋은</button>
  </div>


  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
  <%
    List<WineVO> wines = (List<WineVO>) request.getAttribute("wines");
  %>

  <section class="hero-section">
    <div class="card-grid">
      <% for (WineVO wine : wines) { %>
        <a class="card" href="/board/recommend-detail?wineNo=<%= wine.getNo() %>">
          <div class="card__background" style="background-image: url(<%= wine.getUrl() %>)"></div>
          <div class="card__content">
            <p class="card__category">와인</p>
            <h3 class="card__heading"><%= wine.getName() %></h3>
          </div>
        </a>
      <% } %>
      
    </div>
  </section>



  <script>
    (() => {

      const loggedInUser = '<%= session.getAttribute("USER") %>';
      const tagButtons = document.querySelectorAll('.choice_section button');
      let loginCheckFlag = false;

      if (loggedInUser === 'null') {
          tagButtons.forEach(button => {
              button.classList.add('loginCheck');
              loginCheckFlag = button.classList.contains('loginCheck');
              button.addEventListener('click', function(event) {
                event.preventDefault();
              });
            })
      }

      const icon1 = document.getElementById('imageIcon1');
      const icon2 = document.getElementById('imageIcon2');
      const icon3 = document.getElementById('imageIcon3');
      const icon4 = document.getElementById('imageIcon4');

      const box1 = document.getElementById('cbtest1');
      const box2 = document.getElementById('cbtest2');
      const box3 = document.getElementById('cbtest3');
      const box4 = document.getElementById('cbtest4');

      box1.addEventListener('change', () => {
        if (box1.checked) {
          icon1.classList.remove('icon-gray');
          icon1.classList.add('icon-color');
        } else {
          icon1.classList.remove('icon-color');
          icon1.classList.add('icon-gray');
        }
      });

      box2.addEventListener('change', () => {
        if (box2.checked) {
          icon2.classList.remove('icon-gray');
          icon2.classList.add('icon-color');
        } else {
          icon2.classList.remove('icon-color');
          icon2.classList.add('icon-gray');
        }
      });

      box3.addEventListener('change', () => {
        if (box3.checked) {
          icon3.classList.remove('icon-gray');
          icon3.classList.add('icon-color');
        } else {
          icon3.classList.remove('icon-color');
          icon3.classList.add('icon-gray');
        }
      });

      box4.addEventListener('change', () => {
        if (box4.checked) {
          icon4.classList.remove('icon-gray');
          icon4.classList.add('icon-color');
        } else {
          icon4.classList.remove('icon-color');
          icon4.classList.add('icon-gray');
        }
      });

     
      
      // 체크박스 상태에 따라 와인 이미지와 이름을 업데이트하는 함수
      function updateWineList(cbtest1, cbtest2, cbtest3, cbtest4) {
        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            // 받아온 HTML에서 와인 이미지와 이름 부분만 추출하여 업데이트
            let parser = new DOMParser();
            let htmlDoc = parser.parseFromString(this.responseText, 'text/html');
            let wineCards = htmlDoc.querySelectorAll('.card');
    
            // 기존의 카드 그리드를 찾아서 비우고, 새로운 와인 카드 추가
            let cardGrid = document.querySelector('.card-grid');
            cardGrid.innerHTML = ''; // 기존 카드 비우기
            wineCards.forEach(function(card) {
              cardGrid.appendChild(card); // 새로운 와인 카드 추가
            });
          }
        };
        xhttp.open("GET", "/board/recommend?cbtest1=" + cbtest1 + "&cbtest2=" + cbtest2 + "&cbtest3=" + cbtest3 + "&cbtest4=" + cbtest4, true);
        xhttp.send();
      }
      //-------------------------------------AI추천----------------------------------------------------------//

      
      window.submitForm = function(value) {
  
      if(loginCheckFlag)
      {
        return;
      }
     
      window.submitForm = function(value) {
        // 페이지를 흐릿하게 만들기
        blurPageExceptNav();

        // "대기해주세요" 문구 표시
        showWaitMessage();

        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            let parser = new DOMParser();
            let htmlDoc = parser.parseFromString(this.responseText, 'text/html');
            let wineCards = htmlDoc.querySelectorAll('.card');
            let cardGrid = document.querySelector('.card-grid');
            cardGrid.innerHTML = '';
            wineCards.forEach(function(card) {
              cardGrid.appendChild(card);
            });
            // 서버 응답을 받은 후 페이지를 다시 원래대로 되돌리기
            unblurPageExceptNav();
            // "대기해주세요" 문구 숨기기
            hideWaitMessage();
          }
        };
        // URL에 키워드 파라미터를 포함시킵니다.
        console.log(value);
        xhttp.open("GET", "/board/recommend/keyword?keyword="+ value, true);
        xhttp.send();
      }
    }

      function blurPageExceptNav() {
        // 페이지를 흐릿하게 만들기 (네비게이션 제외)
        let sections = document.querySelectorAll('section');
        sections.forEach(function(section) {
          if (!section.classList.contains('navbar')) {
            section.style.filter = 'blur(5px)';
          }
        });

        // 버튼 비활성화
        let buttons = document.querySelectorAll('button');
        buttons.forEach(function(button) {
          button.disabled = true;
        });

        // 링크 비활성화
        let links = document.querySelectorAll('a');
        links.forEach(function(link) {
          link.style.pointerEvents = 'none';
        });

        // 클릭 이벤트 비활성화
        document.addEventListener('click', preventClick, true);

        // 호버 이벤트 비활성화
        document.addEventListener('mouseover', preventHover, true);
        document.addEventListener('mouseout', preventHover, true); // 이 부분을 추가하면 호버 이벤트가 비활성화됩니다.
      }

      function unblurPageExceptNav() {
        // 페이지 흐릿 효과 제거 (네비게이션 제외)
        let sections = document.querySelectorAll('section');
        sections.forEach(function(section) {
          if (!section.classList.contains('navbar')) {
            section.style.filter = 'none';
          }
        });

        // 버튼 활성화
        let buttons = document.querySelectorAll('button');
        buttons.forEach(function(button) {
          button.disabled = false;
        });

        // 링크 활성화
        let links = document.querySelectorAll('a');
        links.forEach(function(link) {
          link.style.pointerEvents = 'auto';
        });

        // 클릭 이벤트 활성화
        document.removeEventListener('click', preventClick, true);

        // 호버 이벤트 활성화
        document.removeEventListener('mouseover', preventHover, true);

        // 호버 이벤트 비활성화
        document.removeEventListener('mouseout', preventHover, true);

        // "대기해주세요" 문구 숨기기
        hideWaitMessage();
      }

      function showWaitMessage() {
          // "대기해주세요" 메시지를 포함하는 div 요소 생성
          let waitContainer = document.createElement('div');
          waitContainer.classList.add('wait-container'); // 대기 컨테이너를 식별하기 위해 클래스 추가

          // 이미지 요소 생성
          let waitImage = document.createElement('img');
          waitImage.src = '/img/Chat주피티사진.jpg'; // 이미지 경로 설정
          waitImage.style.width = '100px'; // 이미지 크기 조절
          waitImage.style.marginBottom = '10px'; // 이미지 아래 여백 설정
          waitContainer.appendChild(waitImage); // 이미지를 컨테이너에 추가

          // 텍스트 요소 생성
          let waitText = document.createElement('div');
          waitText.innerText = 'Chat 酒PT가 알맞은 와인을 찾고 있습니다! 잠시만 기다려주세요'; // 텍스트 설정
          waitContainer.appendChild(waitText); // 텍스트를 컨테이너에 추가

          // 스타일 직접 추가
          waitContainer.style.position = 'fixed';
          waitContainer.style.top = '40%';
          waitContainer.style.left = '40%';
          waitContainer.style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
          waitContainer.style.padding = '20px';
          waitContainer.style.borderRadius = '10px';
          waitContainer.style.textAlign = 'center';
          waitContainer.style.animation = 'heartbeat 1s infinite alternate';

          // 컨테이너를 문서에 추가
          document.body.appendChild(waitContainer);
      }

      function hideWaitMessage() {
        // 대기 메시지를 숨기기 위한 함수
        let waitContainer = document.querySelector('.wait-container');
        if (waitContainer) {
          waitContainer.remove(); // 대기 메시지 컨테이너 삭제
        }
      }

      // 클릭 이벤트 콜백 함수 정의
      function preventClick(event) {
        event.preventDefault();
        event.stopPropagation();
      }

      // 호버 이벤트 콜백 함수 정의
      function preventHover(event) {
        event.preventDefault();
        event.stopPropagation();
      }

      //-------------------------------------AI추천----------------------------------------------------------//

      function updateCardGrid(htmlData) {
        // 받은 HTML 데이터를 카드 그리드에 적용
        let cardGrid = document.querySelector('.card-grid');
        cardGrid.innerHTML = htmlData;
      }
        
      // 초기에는 기존의 8개 와인 리스트를 보여줌
      updateWineList(false, false, false, false);
    
      // 체크박스가 변경될 때마다 와인 리스트 업데이트
      document.querySelectorAll('input[type="checkbox"]').forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
          let cbtest1 = document.getElementById('cbtest1').checked;
          let cbtest2 = document.getElementById('cbtest2').checked;
          let cbtest3 = document.getElementById('cbtest3').checked;
          let cbtest4 = document.getElementById('cbtest4').checked;
    
          // 체크박스 상태에 따라 와인 리스트 업데이트
          updateWineList(cbtest1, cbtest2, cbtest3, cbtest4);
        });
      });
    


      // 카드 클릭 시 와인 상세 페이지로 이동
      document.querySelectorAll('.card').forEach(function(card) {
        card.addEventListener('click', function() {
          let wineUrl = card.getAttribute('href');
          window.location.href = wineUrl; // 해당 URL로 이동
        });
      });
      
      




    })();
  </script>
    
  
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.3.2/lazysizes.min.js"></script>
<script src="/js-bj/login.js"></script>
</body>
</html>
