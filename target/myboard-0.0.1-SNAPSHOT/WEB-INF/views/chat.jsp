<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title></title>
    <style>
      .chat-icon {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background-color: #007bff;
        background-image: url("/img/Chat주피티사진.JPG");
        background-size: cover;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        position: fixed;
        bottom: 50px;
        right: 50px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        z-index: 1000;
        transition: transform 0.3s, box-shadow 0.3s;
      }
      .chat-icon.gray {
        filter: grayscale(100%);
      }

      .chat-icon.gray:hover::after {
        content: "로그인이 필요합니다"; /* 툴팁 내용 */
        position: absolute;
        bottom: 120%;
        left: 50%;
        transform: translateX(-50%);
        padding: 5px;
        background-color: #333;
        color: white;
        font-size: 12px;
        border-radius: 3px;
        opacity: 0;
        transition: opacity 0.3s;
        white-space: nowrap; /* 텍스트가 넘칠 경우 줄 바꿈 방지 */
        word-wrap: break-word; /* 텍스트가 넘칠 경우 자동으로 줄 바꿈 */
      }

      .chat-icon.gray:hover::after {
        opacity: 1;
      }

      .chat-icon:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
      }

      .chatbox {
        width: 500px; /* 너비를 더 크게 조정합니다. */
        height: 600px; /* 높이도 조정해보죠. */
        font-size: 14px;
        border-radius: 15px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        background-color: #ffffff;
        overflow: hidden;
        display: none;
        flex-direction: column;
        position: fixed;
        bottom: 150px;
        right: 30px;
        z-index: 999;
        animation: slideUp 0.3s ease-out;
      }

      @keyframes slideUp {
        from {
          transform: translateY(20%);
          opacity: 0;
        }
        to {
          transform: translateY(0);
          opacity: 1;
        }
      }

      .chatbox-header {
        background-color: #007bff;
        color: #fff;
        padding: 15px;
        text-align: center;
        font-size: 20px;
        font-weight: bold;
        border-bottom: 2px solid #0069d9;
      }

      .chatbox-body {
        flex: 1;
        padding: 15px;
        overflow-y: auto;
        background-color: #f9f9f9;
      }

      .chatbox-footer {
        padding: 15px;
        background-color: #ffffff;
        display: flex;
        flex-direction: column;
      }

      .message-input {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 10px;
        resize: none;
        min-height: 50px;
        margin-bottom: 10px;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .send-button {
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 10px 15px;
        border-radius: 8px;
        cursor: pointer;
        align-self: flex-end;
        transition: background-color 0.3s;
      }

      .send-button:hover {
        background-color: #0056b3;
      }

      .message {
        padding: 10px 15px;
        border-radius: 15px;
        margin: 5px 0;
        max-width: 70%;
        word-wrap: break-word;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }

      .message.user {
        background-color: #e0e0e0;
        color: #000;
        align-self: flex-end;
      }

      .message.bot {
        background-color: #007bff;
        color: #ffffff;
        align-self: flex-end; /* 답변 박스를 오른쪽으로 정렬합니다. */
        margin-left: auto; /* 추가적으로 왼쪽 여백을 줍니다. */
      }
    </style>
  </head>
  <body>
    <div class="chat-icon" id="chat-icon"></div>

    <div class="chatbox" id="chatbox">
      <div class="chatbox-header">Chat酒PT</div>
      <div class="chatbox-body" id="chatbox-body"></div>
      <form id="chatForm" class="chatbox-footer">
        <textarea
          class="message-input"
          id="prompt"
          placeholder="와인에 대해 무엇이든 물어보세요!"
        ></textarea>
        <button type="submit" class="send-button">전송</button>
      </form>
    </div>

    <!-- JavaScript -->
    <script>
      const chaticon = document.querySelector("#chat-icon");
      const chatbox = document.querySelector("#chatbox");
      const loggedInUser = '<%= session.getAttribute("USER") %>';

      window.onload = function () {
        // 만약 로그인이 필요한 경우라면 아이콘 배경색을 회색으로 변경
        if (loggedInUser == null || loggedInUser === "null") {
          chaticon.classList.add("gray");
        }
      };

      // 챗봇 열기/닫기 로직
      chaticon.addEventListener("click", function () {
        // 만약 로그인이 필요한 경우라면 클릭해도 아무 동작도 하지 않음
        if (loggedInUser == null || loggedInUser === "null") {
          return;
        }
        chatbox.style.display =
          chatbox.style.display === "none" || chatbox.style.display === ""
            ? "flex"
            : "none";
      });

      // 폼 제출 이벤트 핸들러
      document
        .getElementById("chatForm")
        .addEventListener("submit", function (event) {
          event.preventDefault();
          var prompt = document.getElementById("prompt").value.trim();
          if (!prompt) return;

          // 사용자의 메시지 표시
          addMessage(prompt, "user");

          fetch("/checkLimit", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({ prompt: prompt }),
          })
            .then((response) => response.json())
            .then((data) => {
              // 여기서 응답 데이터를 사용할 수 있습니다.
              console.log(data);
              if (data === "false" || data == false) {
                addMessage(
                  "하루 답변 제한이오니 운영진에게 문의 바랍니다.",
                  "bot"
                );
                return;
              } else {
                // 챗봇 서버로 메시지 전송
                fetch("/chat", {
                  method: "POST",
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: JSON.stringify({ prompt: prompt }),
                })
                  .then((response) => {
                    const contentType =
                      response.headers.get("Content-Type") || "";
                    if (contentType.includes("application/json")) {
                      return response.json();
                    } else {
                      return response.text().then((text) => {
                        throw new Error(`Unexpected response: ${text}`);
                      });
                    }
                  })
                  .then((data) => {
                    console.log(data);
                    const choicesData = JSON.parse(data.choices);
                    assistantMessage =
                      choicesData.data[0].content[0].text.value;
                    addMessage(assistantMessage, "bot");
                  });
                // 입력 필드 비우기
                document.getElementById("prompt").value = "";
              }
            });
        });

      // 메시지 입력 시 Shift+Enter로 줄바꿈 가능
      document
        .getElementById("prompt")
        .addEventListener("keydown", function (event) {
          if (event.key === "Enter" && !event.shiftKey) {
            event.preventDefault();
            document.getElementById("chatForm").requestSubmit();
          }
        });

      // 메시지 추가 함수
      function addMessage(text, sender) {
        var messageElement = document.createElement("div");
        messageElement.className = "message " + sender;
        messageElement.textContent = text;
        document.getElementById("chatbox-body").appendChild(messageElement);
        document.getElementById("chatbox-body").scrollTop =
          document.getElementById("chatbox-body").scrollHeight;
      }
    </script>
  </body>
</html>
