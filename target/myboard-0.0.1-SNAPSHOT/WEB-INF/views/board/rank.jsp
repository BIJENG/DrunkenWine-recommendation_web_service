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
  <title>SpritSage</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Black+Han+Sans&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  
  
  <link rel="stylesheet" type="text/css" href="/css-bj/rank.css">
</head>
<body>
  <%@ include file="/WEB-INF/views/user/navbar.jsp" %>
  <%@ include file="/WEB-INF/views/chat.jsp" %>
  <br>
  
  <div class="container rank">
    <section>
      <div class="leaderboard">
        <header>
          <h1>Ranking</h1>
          <img src="https://images.vivino.com/thumbs/0667TG7qS2KsRLsShMTjAw_pb_x300.png" alt="">
          <nav>
            <a href="#" onclick="updateRank('famous')" class="rank-option">인기순</a>
            <a href="#" onclick="updateRank('price')" class="rank-option">가격순</a>
            <a href="#" onclick="updateRank('rating')" class="rank-option">평점순</a>
            <a href="#" onclick="updateRank('sell')" class="rank-option">판매순</a>
          </nav>
        </header>
        <table>
          <thead>
            <tr>
              <th class="rank"></th>
              <th class="nick">와인이름</th>
              <th class="sp">원산지</th>
              <th class="kd">도수</th>
            </tr>
          </thead>
          <tbody>
            <!-- 와인 리더보드 -->
            <% 
              List<WineVO> wines = (List<WineVO>) request.getAttribute("wines");
              int rank = 1;
              for (WineVO wine : wines) {
            %>
              <tr>
                <td><%= rank++ %></td>
                <td><%= wine.getName() %></td>
                <td><%= wine.getOrigin() %></td>
                <td><%= wine.getVolume() %></td>
              </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </section>

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
  </div>

  <script>
    // 순위 옵션에 따라 와인 리스트 업데이트하는 함수
    function updateRank(rankOption) {
      let xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          // 받아온 HTML에서 와인 리스트 부분만 추출하여 업데이트
          let parser = new DOMParser();
          let htmlDoc = parser.parseFromString(this.responseText, 'text/html');
          let wineTable = htmlDoc.querySelector('.leaderboard table tbody');
          let cardGrid = htmlDoc.querySelector('.card-grid');

          // 와인 리스트 업데이트
          let leaderboardTable = document.querySelector('.leaderboard table tbody');
          leaderboardTable.innerHTML = wineTable.innerHTML;

          // 카드 그리드 업데이트
          let currentCardGrid = document.querySelector('.card-grid');
          currentCardGrid.innerHTML = cardGrid.innerHTML;
        }
      };
      xhttp.open("GET", "/board/rank?selection=" + rankOption, true);
      xhttp.send();
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="/js-bj/login.js"></script>
</body>
</html>
