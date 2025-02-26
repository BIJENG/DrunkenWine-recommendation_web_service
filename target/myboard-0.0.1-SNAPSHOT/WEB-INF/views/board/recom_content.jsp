<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page trimDirectiveWhitespaces="true"%> <%@ page
import="java.util.List" %> <%@ page import="com.example.myboard.vo.WineVO" %>
<%@ page import="com.example.myboard.vo.UserVO" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>와인 상세 정보</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      crossorigin="anonymous"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" type="text/css" href="/css-bj/recom_content.css" />
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ab3471774620655a66deb82dddd44631&libraries=services,clusterer,drawing"></script>

  </head>
  <body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %> <%@ include
    file="/WEB-INF/views/chat.jsp" %>
    <br />

    <div class="container wine_explain">
      <section class="recom_section0">
        <div class="section0_image">
          <img src="${wine.url}" alt="와인 이미지" />
        </div>
        <div class="section0_text">
          와인명
          <p class="text_font">${wine.name}</p>
          <br />
          원산지
          <p class="text_font">${wine.origin}</p>
          <br />
          알콜 도수
          <p class="text_font">${wine.proof}</p>
          <br />
          특성 <% WineVO wine = (WineVO) request.getAttribute("wine"); %>
          <div class="wine_char">
            <% if (wine.acidity == 1) { %>
            <div class="wine_property" style="background-color: #ff6666">
              신선한 뒷맛
            </div>
            <% } %> <% if (wine.balanced == 1) { %>
            <div class="wine_property" style="background-color: #66cc99">
              균형 잡힌 맛
            </div>
            <% } %> <% if (wine.body == 1) { %>
            <div class="wine_property" style="background-color: #3399ff">
              몸잡힌 맛
            </div>
            <% } %> <% if (wine.bouquet == 1) { %>
            <div class="wine_property" style="background-color: #ffcc66">
              풍미
            </div>
            <% } %> <% if (wine.buttery == 1) { %>
            <div class="wine_property" style="background-color: #ff9966">
              버터풍미
            </div>
            <% } %> <% if (wine.citrus == 1) { %>
            <div class="wine_property" style="background-color: #ff99ff">
              과일향
            </div>
            <% } %> <% if (wine.dry == 1) { %>
            <div class="wine_property" style="background-color: #ffcc99">
              드라이한 맛
            </div>
            <% } %> <% if (wine.earthy == 1) { %>
            <div class="wine_property" style="background-color: #996633">
              대지의 향
            </div>
            <% } %> <% if (wine.easy == 1) { %>
            <div class="wine_property" style="background-color: #ff9999">
              부드러운 입안 느낌
            </div>
            <% } %> <% if (wine.finish == 1) { %>
            <div class="wine_property" style="background-color: #ff6666">
              끝맛
            </div>
            <% } %> <% if (wine.flat == 1) { %>
            <div class="wine_property" style="background-color: #cccccc">
              단조한 맛
            </div>
            <% } %> <% if (wine.fruity == 1) { %>
            <div class="wine_property" style="background-color: #ffccff">
              과일의 향
            </div>
            <% } %> <% if (wine.green == 1) { %>
            <div class="wine_property" style="background-color: #66cc99">
              신선한 느낌
            </div>
            <% } %> <% if (wine.mouthfeel == 1) { %>
            <div class="wine_property" style="background-color: #ff99cc">
              입안의 감촉
            </div>
            <% } %> <% if (wine.spicy == 1) { %>
            <div class="wine_property" style="background-color: #ff9966">
              향이 나는 향신료
            </div>
            <% } %> <% if (wine.structure == 1) { %>
            <div class="wine_property" style="background-color: #6699ff">
              맛의 조화
            </div>
            <% } %> <% if (wine.tannins == 1) { %>
            <div class="wine_property" style="background-color: #996633">
              거친 맛
            </div>
            <% } %> <% if (wine.tobacco == 1) { %>
            <div class="wine_property" style="background-color: #996633">
              담배 향
            </div>
            <% } %> <% if (wine.vanilla == 1) { %>
            <div class="wine_property" style="background-color: #ffcc99">
              바닐라 향
            </div>
            <% } %>
          </div>
        </div>
      </section>

      <section class="recom_section1">
        <p class="section1-font">
          <span class="wineName">${wine.name}</span> 의 판매처 알아보기
        </p>
        <div id="map" style="width: 80%; height: 400px"></div>
        <ul id="wineShopList" class="wineShopListStyle"></ul>
        <!-- 와인샵 목록을 표시할 요소 -->
      </section>

      <section class="recom_section2">
        <div class="commentBox">
          <div class="comment-count">
            댓글 <span id="commentCount" class="comment-count-style"></span>
          </div>
        </div>
        <div>
          <form id="frmNewComment" class="mb-3">
            <input type="hidden" id="wineNo" name="wineNo" value="${wine.no}" />
            <div class="section2_comment">
              <textarea
                id="txtComment"
                name="commentContent"
                class="comment_css"
                placeholder="${wine.name}에 대한 솔직한 의견을 달아주세요"
                cols="120"
                rows="1"
                required
              ></textarea>
              <% UserVO userObject = (UserVO) session.getAttribute("USER");
              String userIdentifier = (userObject != null) ? userObject.getId()
              : null; %> <% if (userObject != null) { %>
              <button type="button" class="btn btn-secondary" id="btnComment">
                댓글달기
              </button>
              <% } else { %>
              <button type="button" class="btn btn-secondary" id="btnComment">
                로그인이 필요합니다.
              </button>
              <% } %>
            </div>
          </form>

          <!-- 댓글 목록 표시할 곳 -->
          <div class="section2_board">
            <ul id="comment-list" class="list-group"></ul>
          </div>
        </div>
      </section>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
    loadKakaoMap(); // Kakao 지도 스크립트 로드
});

function loadKakaoMap() {
    const script = document.createElement("script");
    script.src =
        "https://dapi.kakao.com/v2/maps/sdk.js?appkey=ab3471774620655a66deb82dddd44631&libraries=services,clusterer,drawing";
    script.async = true;
    script.onload = function () {
        kakao.maps.load(initializeMap);
    };
    document.head.appendChild(script);
}
    </script>
    <script>
      function initializeMap() {
        const mapContainer = document.getElementById("map"); // 지도를 표시할 div
        const mapOption = {
          center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
          level: 6, // 지도의 확대 레벨
        };
    
        const map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성
        let infowindow = null; // 현재 열려 있는 인포윈도우를 저장할 변수
        let prevClickedMarker = null; // 이전에 클릭한 마커를 저장할 변수
        let ps = new kakao.maps.services.Places();
    
        const shopMarkerImage = new kakao.maps.MarkerImage(
          "https://cdn-icons-png.flaticon.com/512/4698/4698562.png", // 와인샵 마커 이미지 경로
          new kakao.maps.Size(40, 40) // 마커 이미지의 크기
        );
    
        const myMarkerImageSrc =
          "https://cdn-icons-png.flaticon.com/512/6986/6986345.png"; // 새 마커 이미지 경로
        const myMarkerImageSize = new kakao.maps.Size(65, 65); // 새 마커 이미지 크기
        const myMarkerImage = new kakao.maps.MarkerImage(
          myMarkerImageSrc,
          myMarkerImageSize
        );
    
        // HTML5의 geolocation으로 사용할 수 있는지 확인
        if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        (position) => {
            console.log("위치 정보 가져오기 성공:", position.coords);
            alert(`위도: ${position.coords.latitude}, 경도: ${position.coords.longitude}`);
        },
        (error) => {
            switch (error.code) {
                case error.PERMISSION_DENIED:
                    alert("위치 정보 사용이 거부되었습니다. 브라우저 설정에서 권한을 허용해주세요.");
                    break;
                case error.POSITION_UNAVAILABLE:
                    alert("위치 정보를 사용할 수 없습니다. 네트워크 상태를 확인해주세요.");
                    break;
                case error.TIMEOUT:
                    alert("위치 정보 요청 시간이 초과되었습니다. 다시 시도해주세요.");
                    break;
                default:
                    alert("알 수 없는 오류가 발생했습니다.");
            }
        }
    );
} else {
    alert("사용 중인 브라우저가 위치 정보를 지원하지 않습니다.");
}

    
        // 지도에 마커와 인포윈도우를 표시하는 함수
        function displayMarker(locPosition, message, markerImage) {
          const markerOptions = {
            map: map,
            position: locPosition,
            image: myMarkerImage,
          };
          if (markerImage) {
            markerOptions.image = markerImage; // 마커 이미지 설정
          }
          const marker = new kakao.maps.Marker(markerOptions);
    
          const iwContent = message; // 인포윈도우 내용
          const iwRemoveable = true;
    
          infowindow = new kakao.maps.InfoWindow({
            content: iwContent,
            removable: iwRemoveable,
          });
    
          infowindow.open(map, marker); // 인포윈도우 열기
          map.setCenter(locPosition); // 지도 중심좌표 변경
        }
    
        // 주변 와인샵 검색 함수
        function searchNearbyWineShops(locPosition) {
          ps.keywordSearch(
            "와인샵",
            function (data, status, pagination) {
              if (status === kakao.maps.services.Status.OK) {
                for (let i = 0; i < data.length; i++) {
                  displayPlaceMarker(data[i], shopMarkerImage, i);
                }
              }
            },
            {
              location: locPosition,
              radius: 5000, // 검색 반경 5km
            }
          );
        }
    
        // 장소에 마커를 표시하는 함수
        function displayPlaceMarker(place, markerImage, index) {
          const marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x),
            image: markerImage,
          });
    
          kakao.maps.event.addListener(marker, "click", function () {
            if (prevClickedMarker && prevClickedMarker === marker) {
              infowindow.close();
              prevClickedMarker = null;
              return;
            }
            if (prevClickedMarker) {
              infowindow.close();
            }
    
            const content =
              '<div style="padding:5px;font-size:12px;">' +
              place.place_name +
              "</div>";
            infowindow.setContent(content);
            infowindow.open(map, marker);
            prevClickedMarker = marker;
          });
    
          // 마커 호버 및 리스트 관련 추가 코드...
        }
      }
    </script>
    
    

    <script>
      (() => {
          const $frmNewComment = document.querySelector("#frmNewComment");
          const $btnComment = document.querySelector("#btnComment");
          const $txtComment = document.querySelector("#txtComment");
          const $commentBoard = document.querySelector(".section1_board");
          const $commentCount = document.getElementById("commentCount");

          function redirectToLogin() {
              window.location.href = "/user/login"; // 로그인 페이지로 이동
          }

          function loadCommentsWithAjax() {
              const wineNo = document.querySelector("#wineNo").value;

              fetch("/board/CommentlistProcess2", {
                  method: "POST",
                  headers: {
                      "Content-Type": "application/json",
                  },
                  body: JSON.stringify({ no: wineNo }),
              })
                  .then((response) => {
                      if (!response.ok) {
                          throw new Error("네트워크 응답에 문제가 있습니다.");
                      }
                      return response.json();
                  })
                  .then((comments) => {
                      displayComments(comments);
                      updateCommentCount(comments.length);
                  })
                  .catch((error) => {
                      console.error("댓글을 가져오지 못했습니다.", error);
                  });
          }

          function updateCommentCount(count) {
              // 댓글 개수 업데이트
              $commentCount.textContent = count; // 댓글 개수를 받아온 값으로 업데이트
          }

          document.addEventListener("DOMContentLoaded", function () {
              loadCommentsWithAjax();
          });

          function displayComments(comments) {
              const commentList = document.getElementById("comment-list");
              if (!commentList) {
                  console.error("Cannot find comment list container.");
                  return;
              }
              commentList.innerHTML = "";

              comments.forEach((comment) => {
                  const userId = comment.userid || "알 수 없는 사용자";
                  const content = comment.commentcontent || "내용 없음";
                  const regDate = comment.regdate || "날짜 없음";

                  const listItem = document.createElement("li");
                  listItem.className =
                      "list-group-item d-flex justify-content-between align-items-start";

                  listItem.innerHTML =
                      "<div>" +
                      "<strong>" + userId + "</strong>" +
                      "<p>" + content + "</p>" +
                      "</div>" +
                      '<small class="text-muted">' + regDate + "</small>";

                  commentList.appendChild(listItem);
              });
          }

          if ($btnComment) {
              $btnComment.addEventListener("click", () => {
                  const comment = $txtComment.value.trim();

                  if (comment === "") {
                      alert("댓글을 입력해주세요.");
                      return;
                  }

                  // 로그인 상태 확인
                  const userLoggedIn = <%= session.getAttribute("USER") != null %>;

                  if (userLoggedIn) {
                      // 로그인 상태인 경우
                      const formData = new FormData($frmNewComment);

                      fetch("/board/commentInsertProcess2", {
                          method: "POST",
                          body: formData,
                      })
                          .then((response) => {
                              if (response.ok) {
                                  loadCommentsWithAjax();
                                  $txtComment.value = "";
                              } else {
                                  alert("댓글 저장에 실패하였습니다.");
                              }
                          })
                          .catch((error) => {
                              console.error("댓글 저장 중 오류 발생:", error);
                              alert("댓글 저장 중 오류가 발생하였습니다.");
                          });
                  } else {
                      // 로그인 상태가 아닌 경우
                      const confirmed = confirm("댓글을 작성하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
                      if (confirmed) {
                          redirectToLogin(); // 로그인 페이지로 이동
                      }
                  }
              });
          }
      })();
    </script>
  </body>
</html>
