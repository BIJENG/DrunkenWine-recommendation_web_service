<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page trimDirectiveWhitespaces="true"%> <%@ page
import="java.util.List" %> <%@ page import="com.example.myboard.vo.WineVO" %>
<%@ page import="com.example.myboard.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/css-sk/style_board_sotong.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
      rel="stylesheet"
    />
    <style>
      .wine-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
        max-width: 100%;
        max-height: 100%;
        width: auto;
        height: auto;
      }

      .card {
        height: 100%;
        display: flex;
        flex-direction: column;
      }

      .card-body {
        flex: 1;
      }

      .card-text {
        margin-bottom: 0.5rem; /* 적당한 여백 */
      }

      .card p {
        margin: 0;
      }

      .pagination-container {
        display: flex;
        justify-content: center;
      }

      .pagination-buttons {
        display: flex;
        gap: 0.5rem; /* 버튼 사이의 간격 */
      }
    </style>

    <title>통합 검색 결과</title>
  </head>
  <body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %> <%@ include
    file="/WEB-INF/views/chat.jsp" %>

    <div class="container">
      <h1 class="text-center my-4">통합 검색 결과</h1>

      <!-- 검색 창 추가 시작 -->
      <div class="row justify-content-center my-4">
        <div class="col-md-8">
          <form
            class="d-flex"
            id="searchForm"
            action="/board/searchResult"
            method="get"
          >
            <input
              class="form-control me-2"
              id="queryInput"
              type="search"
              name="query"
              placeholder="통합검색"
              aria-label="Search"
            />
            <button class="btn btn-outline-primary" type="submit">
              Search
            </button>
          </form>
        </div>
      </div>
      <!-- 검색 창 추가 끝 -->

      <div class="board-section my-5">
        <h2 class="text-center">게시판 검색 결과</h2>
        <div class="row justify-content-center">
          <div class="col">
            <table id="tblBoardResults" class="table table-bordered table-sm">
              <thead>
                <tr>
                  <th scope="col" class="w-10 th-border align-middle">NO</th>
                  <th
                    scope="col"
                    class="w-20 align-middle"
                    style="padding-left: 15px"
                  >
                    이미지
                  </th>
                  <th scope="col" class="w-45 align-middle">제목</th>
                  <th scope="col" class="w-10 align-middle">아이디</th>
                  <th scope="col" class="w-5 align-middle" style="width: 150px">
                    등록일
                  </th>
                  <th scope="col" class="w-10 align-middle">조회수</th>
                </tr>
              </thead>
              <tbody>
                <!-- 게시판 검색 결과가 여기에 추가됩니다. -->
              </tbody>
            </table>
            <div class="row justify-content-center mt-3">
              <div class="col">
                <div
                  class="d-flex justify-content-center"
                  style="background-color: white"
                >
                  <div
                    class="btn-group btn-group-lg"
                    role="group"
                    aria-label="Page navigation"
                    id="boardPagination"
                  ></div>
                  <!-- 게시판 페이지 버튼이 추가될 위치 -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="board-section my-5">
        <h2 class="text-center">와인 검색 결과</h2>
        <div class="row" id="tblWineResults"></div>
        <div class="row justify-content-center mt-3">
          <div class="col">
            <div
              class="d-flex justify-content-center"
              style="background-color: white"
            >
              <div
                class="btn-group btn-group-lg"
                role="group"
                aria-label="Page navigation"
                id="winePagination"
              ></div>
              <!-- 와인 페이지 버튼이 추가될 위치 -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="/js-bj/login.js"></script>
    <script src="/js-bj/searchResult.js"></script>
  </body>
</html>
