<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PickMe Cup - 이상형 월드컵</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="./">PickMe Cup</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="./">홈</a>--%>
                <%--                </li>--%>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#">카테고리</a>--%>
                <%--                </li>--%>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#">인기 순위</a>--%>
                <%--                </li>--%>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#">커뮤니티</a>--%>
                <%--                </li>--%>
            </ul>
            <div class="d-flex ms-3">
                <button class="btn btn-outline-danger" type="button">로그인</button>
            </div>
        </div>
    </div>
</nav>

<div class="container game-container">
    <div class="game-header">
        <h1 class="game-title">아이돌 이상형 월드컵</h1>
        <div class="round-info">16강 1/8</div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="vs-container">
                <div class="video-card">
                    <div class="video-container">
                        <iframe class="youtube-player"
                                src="https://www.youtube.com/embed/?enablejsapi=1" title="YouTube video player"
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                    </div>
                    <div class="video-info">
                        <h3 id="video-title-0" class="video-title"></h3>
                    </div>
                    <button class="select-button">이 영상 선택하기</button>
                </div>

                <div class="d-none d-lg-block">
                    <div class="vs-badge">VS</div>
                </div>
                <div class="d-block d-lg-none">
                    <div class="vs-badge">VS</div>
                </div>

                <div class="video-card">
                    <div class="video-container">
                        <iframe class="youtube-player"
                                src="https://www.youtube.com/embed/?enablejsapi=1" title="YouTube video player"
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                    </div>
                    <div class="video-info">
                        <h3 id="video-title-1" class="video-title"></h3>
                    </div>
                    <button class="select-button">이 영상 선택하기</button>
                </div>
            </div>
        </div>
    </div>

    <div class="progress-container">
        <div class="progress">
            <div class="progress-bar" role="progressbar" style="width: 12.5%;" aria-valuenow="12.5" aria-valuemin="0"
                 aria-valuemax="100"></div>
        </div>
        <p class="progress-text">1/8 진행 중 (총 16강)</p>
    </div>
</div>

<!-- 결과 모달 (게임 완료 후 표시) -->
<div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resultModalLabel">우승자 발표!</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <h3 class="mb-3">당신의 이상형은</h3>
                <div class="winner-container mb-3">
                    <div class="video-container mb-3" style="padding-bottom: 56.25%;">
                        <iframe src="https://www.youtube.com/embed/2S24-y0Ij3Y" title="YouTube video player"
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                    </div>
                    <h4>IVE(아이브) - 'I AM'</h4>
                </div>
                <p>결과를 공유하고 친구들과 비교해보세요!</p>
                <div class="share-buttons mt-3">
                    <button class="btn btn-primary me-2"><i class="bi bi-facebook"></i> 페이스북</button>
                    <button class="btn btn-info me-2"><i class="bi bi-twitter"></i> 트위터</button>
                    <button class="btn btn-success"><i class="bi bi-link-45deg"></i> 링크 복사</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-danger">다시 플레이</button>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <p>© 2025 이상형 월드컵. All rights reserved.</p>
</div>

<!-- Bootstrap & 필요한 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // 게임 진행 로직
    document.addEventListener('DOMContentLoaded', async function () {
        let items = [];
        let players = [];
        let playersReadyCount = 0;
        let currentPair = [];
        let currentRound = 0;
        let currentItemCount = 1;
        let itemsLoaded = false;
        let playersReady = false;

        /**
         * 첫 라운드를 설정합니다.
         * 현재 라운드를 설정하고, 현재 아이템 카운트를 1로 초기화합니다.
         * @param {array} array - 라운드 배열.
         */
        function setFirstRound(array) {
            currentRound = array.length;
            currentItemCount = 1;
        }

        /**
         * 배열을 무작위로 섞습니다.
         * @param {array} array - 섞을 배열.
         * @returns {array} - 섞인 배열.
         */
        function shuffleArray(array) {
            return array.sort(() => Math.random() - 0.5);
        }

        /**
         * 현재 라운드 정보를 화면에 표시합니다.
         * 현재 라운드가 1이면 "우승!", 2이면 "결승", 그 외에는 "[라운드]강([현재 아이템 번호]/[전체 아이템 수])" 형식으로 표시합니다.
         */
        function updateRoundInfo() {
            let text =
                currentRound === 1
                    ? "우승!"
                    : currentRound === 2
                        ? "결승"
                        : `\${currentRound}강(\${currentItemCount++}/\${currentRound * 0.5})`;
            document.querySelector(".round-info").textContent = text;
        }

        /**
         * 다음 대결 쌍을 화면에 표시합니다.
         * 대결할 두 아이템을 선택하고, 각 아이템에 해당하는 YouTube 비디오를 로드합니다.
         * 라운드가 끝났는지 확인하고, 끝났으면 다음 라운드를 설정하거나 최종 우승자를 표시합니다.
         */
        function displayNextPair() {
            if (items.length < 2) {
                if (currentRound === 1) {
                    alert(`🏆 우승! \${items[0].title} 🎉`);
                    location.href = `/`;
                    return;
                } else {
                    items = shuffleArray(items);
                    currentRound >>= 1;
                }
            }

            currentPair = items.splice(0, 2);
            for (let i = 0; i < 2; i++) {
                console.log(currentPair[i]);
                const videoId = extractVideoId(currentPair[i].youtube_link);
                if (players[i]) {
                    players[i].cueVideoById(videoId);
                } else {
                    console.error(`플레이어 \${i}가 아직 준비되지 않았습니다.`);
                }
                // const videoTitle = document.getElementById(`video-title-\${i}`);
                // console.log(videoTitle);
                // videoTitle.textContent = currentPair[i].title;
                document.getElementById(`video-title-\${i}`).textContent = currentPair[i].title;
            }
            updateRoundInfo();
        }

        /**
         * 아이템을 선택했을 때의 동작을 처리합니다.
         * 선택되지 않은 다른 아이템의 비디오를 정지시키고, 선택된 아이템과 선택되지 않은 아이템에 CSS 클래스를 추가하여 시각적 효과를 줍니다.
         * 2초 후에 선택된 아이템을 다음 라운드에 진출시키고, 다음 대결 쌍을 표시합니다.
         * @param {number} index - 선택된 아이템의 인덱스 (0 또는 1).
         */
        function selectItem(index) {
            players.forEach((player, i) => {
                if (i !== index) player.stopVideo();
            });

            const cardContainer = document.querySelector(".vs-container");
            cardContainer.style.pointerEvents = "none";

            const cards = document.querySelectorAll(".video-card");
            cards[index].classList.add("selected");
            cards[1 - index].classList.add("unselected");

            setTimeout(() => {
                items.push(currentPair[index]);
                if (items.length === currentRound / 2) {
                    currentRound >>= 1;
                    currentItemCount = 1;
                    items = shuffleArray(items);
                }

                cards[index].classList.remove("selected");
                cards[1 - index].classList.remove("unselected");
                cardContainer.style.pointerEvents = "auto";
                displayNextPair();
            }, 2000);
        }

        async function readItems(theme) {
            console.log("유튜브 아이템 요청 시작");
            try {
                const response = await fetch(`/api/youtube/theme/\${theme}`);
                const data = await response.json();
                items = shuffleArray(data);
                itemsLoaded = true;
                console.log("유튜브 아이템 요청 완료");
                tryStartWorldCup();
            } catch (error) {
                console.error("요청 중 오류 발생:", error);
            }
        }

        /**
         * 월드컵 게임을 시작합니다.
         * 첫 라운드를 설정하고, 다음 대결 쌍을 표시합니다.
         */
        function startWorldCup() {
            setFirstRound(items);
            displayNextPair();
        }

        /**
         * 월드컵 게임 시작을 시도합니다.
         * 아이템 로드와 플레이어 준비가 모두 완료되면 게임을 시작합니다.
         */
        function tryStartWorldCup() {
            console.log("월드컵 시작 시도");
            if (itemsLoaded && playersReady) {
                console.log("월드컵 시작 성공");
                startWorldCup();
            } else {
                console.log("월드컵 시작 실패");
            }
        }

        /**
         * YouTube 링크에서 비디오 ID를 추출합니다.
         * '/embed/' 경로 또는 'v' 쿼리 파라미터를 사용하여 비디오 ID를 찾습니다.
         * @param {string} youtubeLink - YouTube 링크.
         * @returns {string} - 비디오 ID.
         */
        function extractVideoId(youtubeLink) {
            const url = new URL(youtubeLink);
            return url.pathname.startsWith("/embed/")
                ? url.pathname.split("/embed/")[1]
                : url.searchParams.get("v");
        }

        /**
         * YouTube Iframe API가 준비되면 호출됩니다.
         * 각 YouTube 플레이어 iframe에 대해 YT.Player 객체를 생성하고, 이벤트 핸들러를 설정합니다.
         */
        function onYouTubeIframeAPIReady() {
            console.log("유튜브 API 준비 완료")
            const iframeElements = document.querySelectorAll(".youtube-player");
            iframeElements.forEach((iframe, index) => {
                players.push(
                    new YT.Player(iframe, {
                        events: {
                            onReady: onPlayerReady,
                            onStateChange: onPlayerStateChange,
                        },
                    })
                );
            });
        }

        /**
         * 플레이어가 준비될 때마다 호출됩니다.
         * 플레이어 준비 카운트를 증가시키고, 모든 플레이어가 준비되면 게임 시작을 시도합니다.
         * @param {object} event - 플레이어 이벤트 객체.
         */
        function onPlayerReady(event) {
            event.target.pauseVideo();
            playersReadyCount += 1;
            console.log("준비 완료된 플레이어 수: ", playersReadyCount);
            if (playersReadyCount === 2) {
                console.log("모든 플레이어 준비 완료");
                playersReady = true;
                const urlParams = new URLSearchParams(window.location.search);
                const theme = urlParams.get("theme");
                readItems(theme);
            }
        }

        /**
         * 플레이어 상태가 변경될 때마다 호출됩니다.
         * 한 플레이어가 재생 중이면 다른 플레이어는 일시 중지시킵니다.
         * @param {object} event - 플레이어 이벤트 객체.
         */
        function onPlayerStateChange(event) {
            if (event.data === YT.PlayerState.PLAYING) {
                players.forEach((player) => {
                    if (player !== event.target) player.pauseVideo();
                });
            }
        }

        /**
         * 웹 페이지가 로드되면 호출됩니다.
         * 각 카드에 클릭 이벤트 리스너를 추가하고, YouTube Iframe API를 초기화합니다.
         */
        window.onload = () => {
            console.log("웹 페이지 로드 완료");

            for (let i = 0; i < 2; i++) {
                const cards = document.querySelectorAll(".video-card");
                cards[i].addEventListener("click", () => {
                    selectItem(i);
                });
            }

            onYouTubeIframeAPIReady();
        };
    });
</script>
<script src="https://www.youtube.com/iframe_api"></script>
</body>
</html>