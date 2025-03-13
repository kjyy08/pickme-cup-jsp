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
                <%-- 메뉴 항목 생략 --%>
            </ul>
            <div class="d-flex ms-3">
                <button class="btn btn-outline-danger" type="button">로그인</button>
            </div>
        </div>
    </div>
</nav>

<!-- 로딩 스피너 -->
<div id="spinner">
    <div class="spinner-border text-dark" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
    <span>Loading...</span>
</div>

<!-- 게임 컨테이너: 초기에는 display:none; 상태 -->
<div class="container game-container" style="display: none;">
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
                                src="https://www.youtube.com/embed/?enablejsapi=1"
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
    <!-- 진행바 영역 -->
    <div class="progress-container">
        <div class="progress">
            <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0"
                 aria-valuemax="100"></div>
        </div>
        <p class="progress-text">0/8 진행 중 (총 16강)</p>
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
<!-- YouTube API 스크립트 -->
<script src="https://www.youtube.com/iframe_api"></script>
<script>
    document.addEventListener('DOMContentLoaded', async function () {
        let items = [];
        let players = [];
        let playersReadyCount = 0;
        let currentPair = [];
        let currentRound = 0;
        let currentItemCount = 1;
        let itemsLoaded = false;
        let playersReady = false;

        // 진행바 업데이트를 위한 변수
        let roundMatchesCompleted = 0;
        let roundTotalMatches = 0;

        function adjustToLowerPowerOfTwo(array) {
            let length = array.length;
            let lowerPowerOfTwo = Math.pow(2, Math.floor(Math.log2(length)));
            return (length === lowerPowerOfTwo) ? array : array.slice(0, lowerPowerOfTwo);
        }

        function setFirstRound(array) {
            items = adjustToLowerPowerOfTwo(array);
            currentRound = items.length;
            currentItemCount = 1;
            roundMatchesCompleted = 0;
            roundTotalMatches = currentRound / 2;
        }

        function shuffleArray(array) {
            return array.sort(() => Math.random() - 0.5);
        }

        function updateRoundInfo() {
            let text = currentRound === 1
                ? "우승!"
                : currentRound === 2
                    ? "결승"
                    : `\${currentRound}강(\${currentItemCount++}/\${currentRound * 0.5})`;
            document.querySelector(".round-info").textContent = text;
        }

        function updateProgressContainer() {
            const progressBar = document.querySelector('.progress-bar');
            const progressText = document.querySelector('.progress-text');
            let progressPercent = (roundMatchesCompleted / roundTotalMatches) * 100;
            progressBar.style.width = progressPercent + '%';
            progressBar.setAttribute('aria-valuenow', progressPercent.toString());
            progressText.textContent = (currentRound > 2)
                ? (roundMatchesCompleted + 1) + '/' + roundTotalMatches + ' 진행 중 (' + currentRound + '강)'
                : "결승 진행 중";
        }

        async function updateTotalWins(id) {
            console.log("유튜브 아이템 업데이트 요청 시작");
            try {
                await fetch(`/api/youtube/title`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({id: id}),
                });
                console.log("유튜브 아이템 업데이트 요청 완료");
            } catch (error) {
                console.error("요청 중 오류 발생:", error);
            }
        }

        function winner(item) {
            alert(`🏆 우승! \${item.title} 🎉`);
            updateTotalWins(item.id)
            location.href = `/winner`;
        }

        function displayNextPair() {
            if (items.length < 2) {
                if (currentRound === 1) {
                    winner(items[0]);
                    return;
                } else {
                    items = shuffleArray(items);
                    currentRound >>= 1;
                    roundMatchesCompleted = 0;
                    if (currentRound > 1) {
                        roundTotalMatches = currentRound / 2;
                        updateProgressContainer();
                    }
                }
            }
            currentPair = items.splice(0, 2);
            for (let i = 0; i < 2; i++) {
                const videoId = extractVideoId(currentPair[i].youtube_link);
                if (players[i]) {
                    players[i].cueVideoById(videoId);
                } else {
                    console.error(`플레이어 \${i}가 아직 준비되지 않았습니다.`);
                }
                document.getElementById(`video-title-\${i}`).textContent = currentPair[i].title;
            }
            updateRoundInfo();
        }

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
                roundMatchesCompleted++;
                updateProgressContainer();
                items.push(currentPair[index]);
                if (items.length === currentRound / 2) {
                    currentRound >>= 1;
                    currentItemCount = 1;
                    items = shuffleArray(items);
                    if (currentRound > 1) {
                        roundMatchesCompleted = 0;
                        roundTotalMatches = currentRound / 2;
                        updateProgressContainer();
                    }
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

        function startWorldCup() {
            setFirstRound(items);
            updateProgressContainer();
            displayNextPair();
        }

        function tryStartWorldCup() {
            console.log("월드컵 시작 시도");
            if (itemsLoaded && playersReady) {
                console.log("월드컵 시작 성공");
                document.getElementById("spinner").style.display = "none";
                const gameContainer = document.querySelector(".game-container");
                gameContainer.style.display = "block";
                // 커스텀 페이드 인 업 애니메이션 적용
                gameContainer.classList.add("fade-in-up");
                startWorldCup();
            } else {
                console.log("월드컵 시작 실패");
            }
        }

        function extractVideoId(youtubeLink) {
            const url = new URL(youtubeLink);
            return url.pathname.startsWith("/embed/")
                ? url.pathname.split("/embed/")[1]
                : url.searchParams.get("v");
        }

        function onYouTubeIframeAPIReady() {
            console.log("유튜브 API 준비 완료");
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

        function onPlayerStateChange(event) {
            if (event.data === YT.PlayerState.PLAYING) {
                players.forEach((player) => {
                    if (player !== event.target) player.pauseVideo();
                });
            }
        }

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
</body>
</html>