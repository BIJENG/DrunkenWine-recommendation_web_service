<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="/user/index2">술주정</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink1" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        소통하酒
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink1">
                        <li><a class="dropdown-item" href="/board/recommend">추천하酒</a></li>
                        <li><a class="dropdown-item" href="/board/list">자랑하酒</a></li>
                        <li><a class="dropdown-item" href="/board/trade">거래하酒</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink2" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        순위보酒
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink2">
                        <li><a class="dropdown-item" href="/board/rank">순위보酒</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink3" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        찾酒
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink3">
                        <li><a class="dropdown-item" href="/chatPage">Chat酒PT</a></li>
                        <li><a class="dropdown-item" href="/board/searchResult">검색하酒</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex mx-auto my-2 my-lg-0" id="searchForm" action="/board/searchResult" method="get">
              <input class="form-control me-2" id="queryInput" type="search" name="query" placeholder="통합검색" aria-label="Search">
              <button class="btn btn-outline-primary" type="submit">Search</button>
          </form>
            <ul class="navbar-nav">
              <% 
                UserVO user = (UserVO) session.getAttribute("USER");
                String userId = (user != null) ? user.getId() : null;
              %>
              
              <ul class="navbar-nav">
                <% if(userId != null) { %>
                  <!-- 사용자가 로그인한 경우 -->
                  <li class="nav-item">
                    <span class="nav-link"> <%= userId %> 님 안녕하세요 </span>
                  </li>
                  <!-- 로그아웃 링크 -->
                  <li class="nav-item">
                    <a class="nav-link" href="/user/logout">로그아웃</a>
                  </li>
                <% } else { %>
                  <!-- 사용자가 로그인하지 않은 경우 -->
                  <li class="nav-item">
                    <a class="nav-link" href="/user/login">로그인</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="/user/join">회원가입</a>
                  </li>
                <% } %>
          </ul>
        </div>
    </div>
  </nav>
  