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
  <title>와인 상세 정보</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Black+Han+Sans&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Black+Han+Sans&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle&family=Gaegu&family=Gasoek+One&family=Gugi&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Single+Day&display=swap" rel="stylesheet">
  

  <link rel="stylesheet" type="text/css" href="/css-bj/recom_content.css">
  <style>
    /* 채팅 컨테이너 애니메이션 */
    .chat-container {
        max-width: 700px;
        margin: auto; /* 가로 가운데 정렬을 위해 auto로 변경 */
        position: absolute; /* 절대 위치로 설정 */
        top: 50%; /* 상단을 화면의 중앙으로 */
        left: 50%; /* 좌측을 화면의 중앙으로 */
        transform: translate(-50%, -50%); /* 중앙 정렬 */
        opacity: 0; /* 초기에는 투명하게 설정하여 화면에 보이지 않도록 함 */
        transition: opacity 0.5s ease; /* opacity 변화에 따라 0.5초 동안 천천히 나타나게 함 */
    }

    /* 채팅 컨테이너가 화면에 나타날 때 opacity를 1로 변경하여 표시함 */
    .chat-container.show {
        opacity: 1;
    }

    /* 나머지 스타일은 그대로 유지 */
    .chat-header {
        font-size: 20px;
        font-weight: bold;
    }

    .chat-body {
        height: 600px;
        overflow-y: auto;
        background-color: #f9f9f9;
    }

    .chat-footer {
        background-color: #ffffff;
    }

    .message-input {
        border-radius: 5px;
        padding: 10px;
        resize: none;
        min-height: 50px;
    }

    .send-button {
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
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
        align-self: flex-end; /* 채팅 메시지를 오른쪽에 정렬 */
    }

    .message.bot {
        background-color: #007bff;
        color: #ffffff;
        align-self: flex-end; /* 채팅 메시지를 왼쪽에 정렬 */
    }

    .card-header.text-white.bg-info {
        font-family: 'Noto Sans KR', sans-serif; /* 채팅 박스와 동일한 글꼴 설정 */
    }

    .card-body {
        font-family: 'Noto Sans KR', sans-serif; /* 채팅 박스와 동일한 글꼴 설정 */
    }

    /* 애니메이션 */
    .chatbox {
            border: 1px solid #f9f9f9;
            width: 300px;
            height: 400px;
            overflow-y: scroll;
            padding: 10px;
        }

        .message {
            margin: 5px 0;
            padding: 10px;
            border-radius: 5px;
            display: flex;
            align-items: center;
        }

        .user {
            background-color: #f9f9f9;
            text-align: left;
        }

        .bot {
            background-color: #f9f9f9;
            text-align: left;
            margin-left: auto;
        }

        .bot img {
            width: 100px;
            height: 100px;
            animation: heartbeat 1.5s infinite;
            margin-left: auto;
            margin-right: 10px;
        }

        .bot .text {
            flex: 1;
        }

        @keyframes heartbeat {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.2);
            }
        }
        .center-image {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        opacity: 1;
    }

    .tooltip {
    position: absolute;
    background-color: rgba(0, 0, 0, 0.8);
    color: #fff;
    padding: 5px 10px;
    border-radius: 5px;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    font-size: 14px;
}

.not-logged-in {
    filter: grayscale(100%); /* 회색 필터 적용 */
    opacity: 0.5; /* 투명도 조절 */
}

</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/user/navbar.jsp" %>


    <div class="container mt-4">
        <div class="row">
            <!-- 설명 상자 -->
            <div class="col-md-4">
                <div class="card shadow-lg">
                    <div class="card-header text-white bg-info">
                        Chat酒PT란?
                    </div>
                    <div class="card-body">
                       <p>1. Open AI에서 개발한 Chat GPT 기반으로 만들어진 Chat Bot 입니다.</p> <br>
                       <p>2. Chat bot이 추천해주는 와인은 우리 홈페이지에 저장되어 있는 와인만 추천 해주도록 설계 되어있습니다.</p><br>
                       <p>3. 사용방법은 일상 대화하듯이 물어보는것도 좋고, 특정 키워드 를 넣어 질문하면 더욱 좋습니다.<br> 
                                    예를 들면 "어머니 생신에 어울리는 와인 추천해줘" 와 같이 입력하게 되면 Chat Bot이 검색하는데에 있어서 큰 도움이 됩니다. </p>
                    </div>
                </div>
            </div>
            <!-- 채팅 컨테이너 -->
            <div class="col-md-8">
                <div class="card shadow-lg">
                    <div class="card-header chat-header text-white bg-primary">Chat酒PT</div>
                    <div class="card-body chat-body" id="chatbox-body">
                        <img src="/img/Chat주피티사진chatpage.jpg" alt="Chat주피티" class="center-image" id="centerImage">
                        <!-- 메시지가 여기에 나타날 것입니다 -->
                    </div>
                    <form id="chatForm" class="card-footer chat-footer">
                        <div class="input-group">
                            <textarea class="form-control message-input" id="prompt" placeholder="와인에 대하여 무엇이든 물어보세요!"></textarea>
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-primary send-button">전송</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<!-- 부트스트랩 JS 및 종속성 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- 사용자 정의 JS -->

<!-- JavaScript -->
<script>

const loggedInUser = '<%= session.getAttribute("USER") %>';
const promptInput = document.getElementById('prompt');
const sendButton = document.querySelector('.send-button');


window.onload = function() {
    // 로그인 여부 확인
    // 로그인 여부에 따라 클래스를 추가하거나 제거합니다.
    const centerImage = document.getElementById('centerImage');
    if (loggedInUser === 'null') {
        promptInput.placeholder = '로그인이 필요합니다!';
        promptInput.disabled = true; // 입력란 비활성화
        sendButton.disabled = true; // 버튼 비활성화
        centerImage.classList.add('not-logged-in'); // 로그인이 안 되어있을 경우 클래스 추가
    }
}


    document.getElementById('chatForm').addEventListener('submit', function (event) {
          
        const centerImage = document.getElementById('centerImage');
        centerImage.style.opacity = '0';
        event.preventDefault(); // 폼의 기본 동작 방지
           
            // 모든 입력 요소 비활성화
            document.getElementById('prompt').disabled = true;
            document.querySelector('.send-button').disabled = true;
            
            let prompt = document.getElementById('prompt').value.trim();
            if (!prompt) return;
            
            // 사용자의 메시지 표시
            addMessage(prompt, 'user');
            // "잠시만 기다려주세요" 이미지 표시
            let waitingMessage = addMessage("/img/Chat주피티사진chatpage.jpg", 'bot'); // 이미지 경로로 대체
            document.getElementById('prompt').value = '';

            fetch('/checkLimit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ prompt: prompt })
            })
            .then(response => response.json())
            .then(data => {
                // 여기서 응답 데이터를 사용할 수 있습니다.
                console.log(data);
                if(data === 'false' || data == false)
                {
                    waitingMessage.style.display = 'none';
                    addMessage("하루 답변 제한이오니 운영진에게 문의 바랍니다.", 'bot');
                    return;
                }
                else{
                    sendMessageChatbot(waitingMessage,prompt);
                }
            });

            
            
        });

        const sendMessageChatbot = function(waitingMessage,prompt){

        fetch('/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ prompt: prompt })
        })
        .then(response => {
            const contentType = response.headers.get('Content-Type') || '';
            if (contentType.includes('application/json')) {
                return response.json();
            } else {
                return response.text().then(text => { throw new Error(`Unexpected response: ${text}`); });
            }
        })
        .then(data => {
            waitingMessage.style.display = 'none';

            const choicesData = JSON.parse(data.choices);
            assistantMessage = choicesData.data[0].content[0].text.value;
            addMessage(assistantMessage, 'bot');
            
            // 입력 필드 비우고 모든 입력 요소 활성화
            
            document.getElementById('prompt').disabled = false;
            document.querySelector('.send-button').disabled = false;
        })
        .catch(error => console.error('Error:', error));
        } 

        function addMessage(text, sender) {
            var messageElement = document.createElement('div');
            messageElement.className = 'message ' + sender;
            if (text.includes("img/")) { // 이미지 경로를 확인하여 이미지인 경우
              
                var imageElement = document.createElement('img');
                imageElement.src = text;
                messageElement.appendChild(imageElement);
                // 파란색 박스를 없애기 위해 스타일 조정
                messageElement.style.backgroundColor = 'transparent'; // 배경색 투명
                messageElement.style.boxShadow = 'none'; // 그림자 제거
                messageElement.style.marginLeft = '0'; // 기본 여백 설정
                messageElement.style.padding = '0'; // 패딩 제거
            } else {
                messageElement.textContent = text; // 텍스트인 경우
            }
            document.getElementById('chatbox-body').appendChild(messageElement);
            document.getElementById('chatbox-body').scrollTop = document.getElementById('chatbox-body').scrollHeight;
            
            // sender가 'bot'인 경우 파란색 박스를 오른쪽으로 옮기기
            if (sender === 'bot') {
                messageElement.style.marginLeft = 'auto';
            }
            
            return messageElement; // 생성된 메시지 엘리먼트 반환
        }

    // Enter 키를 눌렀을 때 메시지 전송
    document.getElementById('prompt').addEventListener('keydown', function(event) {
        if (event.key === 'Enter' && !event.shiftKey) { // 엔터 키이면서 쉬프트 키를 누르지 않은 경우
            event.preventDefault(); // 기본 동작(새 줄 추가) 방지
            document.getElementById('chatForm').dispatchEvent(new Event('submit')); // 폼 전송 이벤트 디스패치
        }
    });
    </script>
</body>
</html>
