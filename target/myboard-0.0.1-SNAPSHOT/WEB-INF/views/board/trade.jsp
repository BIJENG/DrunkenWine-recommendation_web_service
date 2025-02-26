<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page trimDirectiveWhitespaces="true"%> <%@ page
import="com.example.myboard.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
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
    <title>거래하주 List</title>
    <!-- 변경 -->

    <style>
      td {
        font-weight: bold;
        position: relative;
      }
      table#tblBoard tbody tr.completed td {
        background-color: #91daa3;
        position: relative;
      }
      table#tblBoard tbody tr.completed td img {
        opacity: 0.2;
      }
      table#tblBoard tbody tr.completed td::before {
        content: "거래완료";
        font-size: 2rem;
        color: red;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1;
        white-space: nowrap;
      }
    </style>
  </head>
  <body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %> <%@ include
    file="/WEB-INF/views/chat.jsp" %>

    <div class="container text-center">
      <h1>거래하주</h1>
      <!-- 변경 -->
      <div class="text-end">
        <button type="button" class="btnNewContent btn btn-outline-dark">
          글쓰기
        </button>
      </div>
      <div class="row justify-content-center">
        <div class="col">
          <table id="tblBoard" class="table table-bordered table-sm">
            <thead>
              <tr>
                <th scope="col" class="w-10 th-border align-middle">
                  거래상태
                </th>
                <th
                  scope="col"
                  class="w-20 align-middle"
                  style="padding-left: 15px"
                >
                  이미지
                </th>
                <th scope="col" class="w-45 align-middle">제목</th>
                <th scope="col" class="w-5 align-middle" style="width: 200px">
                  등록일
                </th>
                <th scope="col" class="w-10 align-middle">조회수</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
      <div class="text-end">
        <button type="button" class="btnNewContent btn btn-outline-dark">
          글쓰기
        </button>
      </div>
      <div class="row justify-content-center mt-3">
        <div class="col">
          <div
            class="btn-group btn-group-lg"
            role="group"
            aria-label="Page navigation"
            style="background-color: white"
          >
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnPrevSection"
            >
              <<
            </button>
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnPage1"
            >
              1
            </button>
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnPage2"
            >
              2
            </button>
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnPage3"
            >
              3
            </button>
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnPage4"
            >
              4
            </button>
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnPage5"
            >
              5
            </button>
            <button
              type="button"
              class="btn btn-outline-dark btn-sm"
              id="btnNextSection"
            >
              >>
            </button>
          </div>
        </div>
      </div>

      <br />
    </div>
    <script>
      (() => {
        const getBoardList = function () {
          const xhr = new XMLHttpRequest();
          xhr.open("GET", "/board/tradeListProcess", true);
          xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
              const data = JSON.parse(xhr.responseText);
              const $tbody = document.querySelector("#tblBoard tbody");

              data.forEach(function (item) {
                const imgTag = item.imgpath
                  ? '<img src="' +
                    item.imgpath +
                    '" alt="이미지" width="80" height="90">'
                  : "";
                const $tr = document.createElement("tr");
                let tradeStatus_Eng = "";

                if (item.tradeStatus === "판매중") {
                  tradeStatus_Eng = "selling";
                } else if (item.tradeStatus === "거래중") {
                  tradeStatus_Eng = "trading";
                } else {
                  tradeStatus_Eng = "completed";
                }

                $tr.classList.add(tradeStatus_Eng);
                $tr.innerHTML =
                  '<td class="w-10 align-middle">' +
                  item.tradeStatus +
                  "</td>" +
                  '<td class="w-20 align-middle" style="padding-left: 15px;">' +
                  imgTag +
                  "</td>" +
                  '<td class="w-45 align-middle"><a href="/board/tradeContent?no=' +
                  item.no +
                  '">' +
                  item.title +
                  "</a></td>" +
                  '<td class="w-5 align-middle" style="width: 150px;">' +
                  item.regdate +
                  "</td>" +
                  '<td class="w-10 align-middle">' +
                  item.vcount +
                  "</td>";
                $tbody.appendChild($tr);
              });
            }
          };
          xhr.send();
        };

        getBoardList();
      })();
    </script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="/js-bj/login.js"></script> -->
  </body>
</html>
