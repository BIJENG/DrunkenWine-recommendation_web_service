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
    <title>Board List</title>
</head>
<body>

    <%@ include file="/WEB-INF/views/user/navbar.jsp" %>
    <%@ include file="/WEB-INF/views/chat.jsp" %>
      
    <div class="container text-center">
        <h1>자랑하주</h1>    
        <div class="text-end">
            <button type="button" class="btnNewContent btn btn-outline-dark">글쓰기</button>
        </div>
        <div class="row justify-content-center">
            <div class="col">
                <table id="tblBoard" class="table table-bordered table-sm">
                    <thead>
                        <tr>
                            <th scope="col" class="w-10 th-border align-middle">NO</th>
                            <th scope="col" class="w-20 align-middle" style="padding-left: 15px;">이미지</th>
                            <th scope="col" class="w-45 align-middle">제목</th>
                            <th scope="col" class="w-10 align-middle">아이디</th>
                            <th scope="col" class="w-5 align-middle"  style="width: 150px;">등록일</th>
                            <th scope="col" class="w-10 align-middle">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="text-end">
            <button type="button" class="btnNewContent btn btn-outline-dark">글쓰기</button>
        </div>
        <div class="row justify-content-center mt-3">
            <div class="col">
                <div class="btn-group btn-group-lg" role="group" aria-label="Page navigation" style="background-color: white;">
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnPrevSection"><<</button>
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnPage1">1</button>
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnPage2">2</button>
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnPage3">3</button>
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnPage4">4</button>
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnPage5">5</button>
                    <button type="button" class="btn btn-outline-dark btn-sm" id="btnNextSection">>></button>
                </div>
            </div>
        </div>
        
        <br>
    </div>
    <script>
        (()=>{    
            const $btnNewContent = document.querySelector('#btnNewContent');
            const $btnPrevSection = document.querySelector("#btnPrevSection");
            const $btnNextSection = document.querySelector("#btnNextSection");
            const $btnPage1 = document.querySelector("#btnPage1");
            const $btnPage2 = document.querySelector("#btnPage2");
            const $btnPage3 = document.querySelector("#btnPage3");
            const $btnPage4 = document.querySelector("#btnPage4");
            const $btnPage5 = document.querySelector("#btnPage5");

            let rowsPerPage = 10;        // 한 페이지에 보여줄 행의 수
            let curPage = 1;            // 현재 페이지
            let curSection = 1;         // 현재 섹션
            let pagesPerSection = 5;    // 섹션당 페이지의 개수

            const getBoardList = function(page) {
                const boardReq = {
                    page,
                    rowsPerPage
                };

                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/board/listProcess', true);
                xhr.setRequestHeader('Content-type', 'application/json');

                xhr.onreadystatechange = function() {
                    if ((xhr.readyState === XMLHttpRequest.DONE) && (xhr.status === 200)) {
                        const data = JSON.parse(xhr.responseText);
                        
                        if (data.length === 0) {
                            alert('더 이상 데이터가 없습니다.');
                            return;
                        }

                        const $tbody = document.querySelector('#tblBoard tbody');
                        $tbody.innerHTML = '';

                        data.forEach(function(item) {
                            const imgTag = item.imgpath ? '<img src="' + item.imgpath + '" alt="이미지" width="80" height="90">' : '';

                            const $tr = document.createElement('tr');
                            $tr.innerHTML = '<td class="w-10 align-middle">' + item.no + '</td>' +
                                            '<td class="w-20 align-middle" style="padding-left: 15px;">' + imgTag + '</td>' +
                                            '<td class="w-45 align-middle"><a href="/board/content?no=' + item.no + '">' + item.title + '</a></td>' +
                                            '<td class="w-10 align-middle">' + item.id + '</td>' +
                                            '<td class="w-5 align-middle" style="width: 150px;">' + item.regdate + '</td>' +
                                            '<td class="w-10 align-middle">' + item.vcount + '</td>';
                            $tbody.appendChild($tr);
                        });
                    }
                }

                const jsonData = JSON.stringify(boardReq);
                xhr.send(jsonData);
            }

            const getBoardRowCount = function(callbackProc) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/board/totalrows', true);
                xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

                xhr.onreadystatechange = function() {
                    if ((xhr.readyState === XMLHttpRequest.DONE) && (xhr.status === 200)) {
                        let totalRows = xhr.responseText;
                        callbackProc(Number(totalRows));
                    }
                }

                xhr.send();
            }

            const MoveSection = function(section) {
                $btnPage1.textContent = String((section - 1) * pagesPerSection + 1);
                $btnPage2.textContent = String((section - 1) * pagesPerSection + 2);
                $btnPage3.textContent = String((section - 1) * pagesPerSection + 3);
                $btnPage4.textContent = String((section - 1) * pagesPerSection + 4);
                $btnPage5.textContent = String((section - 1) * pagesPerSection + 5);
            }

            document.querySelectorAll('.btnNewContent').forEach(btn => {
                btn.addEventListener('click', () => {
                    location.href = '/board/newContent';
                });
            });

            $btnNextSection.addEventListener('click', () => {
                getBoardRowCount(function(totalRows) {
                    let maxRows = (pagesPerSection * rowsPerPage) * curSection;

                    if (totalRows > maxRows) {
                        curSection++;
                        MoveSection(curSection);
                        getBoardList(((curSection - 1) * pagesPerSection) + 1);
                    } else {
                        alert('마지막 페이지입니다.');
                    }
                });
            });

            $btnPrevSection.addEventListener('click', () => {
                if (curSection === 1) {
                    alert('첫 페이지입니다.');
                    return;
                }

                curSection--;
                MoveSection(curSection);
                getBoardList(((curSection - 1) * pagesPerSection) + 1);
            });

            $btnPage1.addEventListener('click', () => {
                const page = ((curSection - 1) * pagesPerSection) + 1;
                getBoardList(page);
            });

            $btnPage2.addEventListener('click', () => {
                const page = ((curSection - 1) * pagesPerSection) + 2;
                getBoardList(page);
            });

            $btnPage3.addEventListener('click', () => {
                const page = ((curSection - 1) * pagesPerSection) + 3;
                getBoardList(page);
            });

            $btnPage4.addEventListener('click', () => {
                const page = ((curSection - 1) * pagesPerSection) + 4;
                getBoardList(page);
            });

            $btnPage5.addEventListener('click', () => {
                const page = ((curSection - 1) * pagesPerSection) + 5;
                getBoardList(page);
            });

            getBoardList(1);
        })();
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="/js-bj/login.js"></script>
</body>
</html>
