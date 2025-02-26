(() => {
  const pageSize = 8; // 한 페이지에 보여줄 와인 카드의 수
  let currentWinePage = 1; // 현재 와인 페이지
  let currentBoardPage = 1; // 현재 게시판 페이지
  let wineData = []; // 와인 데이터
  let boardData = []; // 게시판 데이터

  const getBoardList = function () {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const query = urlParams.get("query");

    if (!query) {
      console.error("Query parameter is missing");
      return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("GET", "/board/searchData?query=" + query, true);
    xhr.setRequestHeader("Content-type", "application/json");

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          try {
            boardData = JSON.parse(xhr.responseText);

            if (boardData.length === 0) {
              return;
            }

            const $tbody = document.querySelector("#tblBoardResults tbody");
            $tbody.innerHTML = "";

            boardData.forEach(function (item) {
              const imgTag = item.imgpath
                ? '<img src="' +
                  item.imgpath +
                  '" alt="이미지" width="80" height="90">'
                : "";

              const $tr = document.createElement("tr");
              $tr.innerHTML =
                '<td class="w-10 align-middle">' +
                item.no +
                "</td>" +
                '<td class="w-20 align-middle" style="padding-left: 15px;">' +
                imgTag +
                "</td>" +
                '<td class="w-45 align-middle"><a href="/board/content?no=' +
                item.no +
                '">' +
                item.title +
                "</a></td>" +
                '<td class="w-10 align-middle">' +
                item.id +
                "</td>" +
                '<td class="w-5 align-middle" style="width: 150px;">' +
                item.regdate +
                "</td>" +
                '<td class="w-10 align-middle">' +
                item.vcount +
                "</td>";
              $tbody.appendChild($tr);
            });

            updatePagination();
          } catch (e) {
            console.error("Failed to parse response as JSON", e);
          }
        } else {
          console.error("Request failed", xhr.status, xhr.statusText);
        }
      }
    };

    xhr.send();
  };

  const getWineList = function () {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const query = urlParams.get("query");

    if (!query) {
      console.error("Query parameter is missing");
      return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("GET", "/board/searchWineData?query=" + query, true);
    xhr.setRequestHeader("Content-type", "application/json");

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          try {
            wineData = JSON.parse(xhr.responseText);

            if (wineData.length === 0) {
              return;
            }

            const $tbody = document.querySelector("#tblWineResults");
            $tbody.innerHTML = "";

            // 페이징 처리
            const startIdx = (currentWinePage - 1) * pageSize;
            const endIdx = startIdx + pageSize;
            const winePageData = wineData.slice(startIdx, endIdx);

            winePageData.forEach(function (item) {
              const imgTag = item.url
                ? '<img src="' +
                  item.url +
                  '" class="card-img-top wine-img" alt="이미지">'
                : '<img src="/path/to/default-image.jpg" class="card-img-top wine-img" alt="이미지">';

              const $div = document.createElement("div");
              $div.classList.add("col-md-3", "mb-4");
              $div.innerHTML =
                '<div class="card">' +
                '<a href="/board/recommend-detail?wineNo=' +
                item.no +
                '">' +
                imgTag +
                "</a>" +
                '<div class="card-body text-center">' +
                '<p class="card-text">' +
                item.name +
                "</p>" +
                '<p class="card-text">원산지: ' +
                item.origin +
                "</p>" +
                '<p class="card-text">도수: ' +
                item.proof +
                "</p>" +
                "</div>" +
                "</div>";

              $tbody.appendChild($div);
            });

            updatePagination();
          } catch (e) {
            console.error("Failed to parse response as JSON", e);
          }
        } else {
          console.error("Request failed", xhr.status, xhr.statusText);
        }
      }
    };

    xhr.send();
  };

  const updatePagination = function () {
    // 와인 페이지 업데이트
    const $winePagination = document.querySelector("#winePagination");
    if ($winePagination) {
      const totalWinePage = Math.ceil(wineData.length / pageSize);
      const currentPage = currentWinePage;

      $winePagination.innerHTML = ""; // 이전 페이지 버튼 삭제

      // 이전 페이지 버튼
      const $prevButton = document.createElement("button");
      $prevButton.textContent = "이전";
      $prevButton.classList.add("btn", "btn-outline-dark", "btn-sm");
      $prevButton.addEventListener("click", function () {
        if (currentPage > 1) {
          currentWinePage = Math.max(currentPage - 5, 1);
          getWineList();
        }
      });
      $winePagination.appendChild($prevButton);

      // 페이지 버튼 추가
      const startPage = Math.floor((currentPage - 1) / 5) * 5 + 1;
      const endPage = Math.min(startPage + 4, totalWinePage);
      for (let i = startPage; i <= endPage; i++) {
        const $button = document.createElement("button");
        $button.textContent = i;
        $button.classList.add("btn", "btn-outline-dark", "btn-sm");
        $button.addEventListener("click", function () {
          currentWinePage = i;
          getWineList();
        });
        $winePagination.appendChild($button);
      }

      // 다음 페이지 버튼
      const $nextButton = document.createElement("button");
      $nextButton.textContent = "다음";
      $nextButton.classList.add("btn", "btn-outline-dark", "btn-sm");
      $nextButton.addEventListener("click", function () {
        const nextPage = Math.min(currentPage + 5, totalWinePage);
        if (nextPage !== currentPage) {
          currentWinePage = nextPage;
          getWineList();
        }
      });
      $winePagination.appendChild($nextButton);
    }

    // 게시판 페이지 업데이트
    const $boardPagination = document.querySelector("#boardPagination");
    if ($boardPagination) {
      const totalBoardPage = Math.ceil(boardData.length / pageSize);
      const currentPage = currentBoardPage;

      $boardPagination.innerHTML = ""; // 이전 페이지 버튼 삭제

      // 이전 페이지 버튼
      const $prevButton = document.createElement("button");
      $prevButton.textContent = "이전";
      $prevButton.classList.add("btn", "btn-outline-dark", "btn-sm");
      $prevButton.addEventListener("click", function () {
        if (currentPage > 1) {
          currentBoardPage = Math.max(currentPage - 5, 1);
          getBoardList();
        }
      });
      $boardPagination.appendChild($prevButton);

      // 페이지 버튼 추가
      const startPage = Math.floor((currentPage - 1) / 5) * 5 + 1;
      const endPage = Math.min(startPage + 4, totalBoardPage);
      for (let i = startPage; i <= endPage; i++) {
        const $button = document.createElement("button");
        $button.textContent = i;
        $button.classList.add("btn", "btn-outline-dark", "btn-sm");
        $button.addEventListener("click", function () {
          currentBoardPage = i;
          getBoardList();
        });
        $boardPagination.appendChild($button);
      }

      // 다음 페이지 버튼
      const $nextButton = document.createElement("button");
      $nextButton.textContent = "다음";
      $nextButton.classList.add("btn", "btn-outline-dark", "btn-sm");
      $nextButton.addEventListener("click", function () {
        const nextPage = Math.min(currentPage + 5, totalBoardPage);
        if (nextPage !== currentPage) {
          currentBoardPage = nextPage;
          getBoardList();
        }
      });
      $boardPagination.appendChild($nextButton);
    }
  };

  document.addEventListener("DOMContentLoaded", () => {
    getWineList();
    getBoardList();
  });
})();
