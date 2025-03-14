<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 카테고리 생성 | PickMe Cup</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/category-create.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="./">PickMe Cup</a>
    </div>
</nav>

<div class="container game-container" style="padding-top:80px;">
    <div class="col-lg-12">
        <div class="card p-4 shadow">
            <h3 class="text-center mb-4">새 카테고리 생성</h3>
            <form action="" method="post" enctype="multipart/form-data" id="categoryForm">
                <div class="mb-3">
                    <label for="theme" class="form-label">카테고리 테마</label>
                    <input type="text" class="form-control" id="theme" name="theme" required>
                </div>
                <div class="mb-3">
                    <label for="itemType" class="form-label">아이템 타입</label>
                    <select class="form-select" id="itemType" name="itemType" required>
                        <option value="YOUTUBE">유튜브</option>
                        <option value="IMAGE">이미지</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">대표 이미지 업로드</label>
                    <div class="theme-image-container">
                        <div id="themeImagePreview">
                            <img src="" alt="대표 이미지 미리보기">
                            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#adb5bd"
                                 viewBox="0 0 16 16">
                                <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                                <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z"/>
                            </svg>
                        </div>
                        <div id="themeImageUploadZone">
                            <div class="drop-zone-prompt">
                                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#adb5bd"
                                     viewBox="0 0 16 16">
                                    <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                                    <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z"/>
                                </svg>
                                <span>여기에 드래그하거나 클릭하세요</span>
                            </div>
                            <input type="file" class="drop-zone-input" id="themeImgFile" name="themeImgUrl"
                                   accept="image/*">
                        </div>
                    </div>
                </div>
                <div id="imageUploadContainer" class="mb-2 d-none">
                    <h5 class="mb-3 form-label">이미지 아이템 업로드</h5>
                    <div id="imageDropZone" class="drop-zone">
                        <div class="drop-zone-prompt">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#adb5bd"
                                 viewBox="0 0 16 16">
                                <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                                <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z"/>
                            </svg>
                            <span>여기에 드래그하거나 클릭하세요</span>
                        </div>
                        <input type="file" class="drop-zone-input" id="imageUploadInput" multiple accept="image/*">
                    </div>
                </div>
                <div id="videoUploadContainer" class="mb-4">
                    <h5 class="mb-3 form-label">유튜브 아이템 추가</h5>
                    <div class="input-group mb-3 video-input-group" style="gap: 3px">
                        <input type="url" class="form-control input-border-round" id="videoLinkInput"
                               placeholder="YouTube 링크를 입력하세요">
                        <button type="button" class="btn btn-sm btn-outline-danger input-border-round"
                                id="addVideoLink">링크 추가
                        </button>
                    </div>
                </div>
                <div class="card mt-4 p-3 bg-light">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0 form-label">추가된 게임 아이템 <span id="itemCount" class="badge bg-secondary">0</span>
                        </h5>
                        <button type="button" class="btn btn-sm btn-outline-danger" id="clearAllItems">모두 삭제</button>
                    </div>
                    <ul class="list-group" id="gameItemsContainer">
                        <li class="list-group-item text-center text-muted" id="emptyItemsMessage">추가된 아이템이 없습니다. 아이템을
                            추가해주세요.
                        </li>
                    </ul>
                </div>
                <div class="mt-4 d-flex justify-content-end">
                    <button type="submit" class="btn btn-style" id="submitButton">카테고리 생성</button>
                </div>
            </form>
            <!-- 카테고리 중복 경고 모달 -->
            <div class="modal fade" id="categoryConflictModal" tabindex="-1"
                 aria-labelledby="categoryConflictModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="categoryConflictModalLabel">카테고리 중복</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            이미 존재하는 카테고리입니다. 다른 이름을 입력하세요.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="categorySubmitModal" tabindex="-1"
                 aria-labelledby="categorySubmitModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="categorySubmitModalLabel">카테고리 생성</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                                    onclick="window.location.href='/'"></button>
                        </div>
                        <div class="modal-body">
                            새로운 카테고리 생성을 성공했습니다.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                    onclick="window.location.href='/'">닫기
                            </button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // 요소 참조
        const itemTypeSelect = document.getElementById('itemType');
        const imageUploadContainer = document.getElementById('imageUploadContainer');
        const videoUploadContainer = document.getElementById('videoUploadContainer');
        const gameItemsContainer = document.getElementById('gameItemsContainer');
        const clearAllItemsBtn = document.getElementById('clearAllItems');
        const addVideoLinkBtn = document.getElementById('addVideoLink');
        const videoLinkInput = document.getElementById('videoLinkInput');
        const themeImageUploadZone = document.getElementById('themeImageUploadZone');
        const themeImgFileInput = document.getElementById('themeImgFile');
        const themeImagePreview = document.getElementById('themeImagePreview');
        const themeImagePreviewImg = themeImagePreview.querySelector('img'); // 테마 이미지 미리보기 img 태그
        const imageDropZone = document.getElementById('imageDropZone');
        const imageUploadInput = document.getElementById('imageUploadInput');
        const submitButton = document.getElementById('submitButton');
        const themeInput = document.getElementById('theme'); // 카테고리 테마 입력 필드

        // 전역 변수로 테마 이미지 파일 저장
        let themeImageFile = null;

        // 기본 UI 업데이트
        function updateItemCount() {
            document.getElementById('itemCount').innerText = gameItemsContainer.querySelectorAll('li.list-group-item[data-type]').length;
        }

        function updateItemTypeUI() {
            const type = itemTypeSelect.value;
            if (type === 'IMAGE') {
                imageUploadContainer.classList.remove('d-none');
                videoUploadContainer.classList.add('d-none');
            } else {
                videoUploadContainer.classList.remove('d-none');
                imageUploadContainer.classList.add('d-none');
            }
            gameItemsContainer.innerHTML = '<li class="list-group-item text-center text-muted" id="emptyItemsMessage">추가된 아이템이 없습니다. 아이템을 추가해주세요.</li>';
            themeImagePreviewImg.style.display = "none";
            updateItemCount();
        }

        // createElement 헬퍼 (없다면 아래와 같이 구현)
        function createElement(tag, options = {}) {
            const elem = document.createElement(tag);
            if (options.className) elem.className = options.className;
            if (options.innerText) elem.innerText = options.innerText;
            if (options.type) elem.type = options.type;
            if (options.src) elem.src = options.src;
            if (options.alt) elem.alt = options.alt;
            if (options.value) elem.value = options.value;
            if (options.attributes) {
                for (const key in options.attributes) {
                    elem.setAttribute(key, options.attributes[key]);
                }
            }
            if (options.style) {
                for (const key in options.style) {
                    elem.style[key] = options.style[key];
                }
            }
            return elem;
        }

        // 이미지 아이템 추가 함수 (파일 객체를 요소에 저장)
        function addImageItem(file) {
            const emptyMessage = document.getElementById('emptyItemsMessage');
            if (emptyMessage) emptyMessage.remove();

            const listItem = createElement('li', {
                className: 'list-group-item d-flex align-items-center',
                attributes: {'data-type': 'IMAGE'},
                style: {gap: '15px'}
            });
            // 파일 객체 저장 (업로드 시 사용)
            listItem.file = file;

            const imgPreview = createElement('img', {
                className: 'img-thumbnail me-2',
                src: URL.createObjectURL(file),
                alt: file.name
            });

            const textContainer = createElement('div', {className: 'item-info flex-grow-1 d-flex align-items-center justify-content-between'});
            const infoGroup = createElement('div', {style: {display: 'flex', gap: '15px', flexGrow: '1'}});

            const titleDiv = createElement('div', {
                style: {
                    width: '100%',
                    maxWidth: '400px',
                    display: 'flex',
                    alignItems: 'center'
                }
            });
            const titleLabel = createElement('label', {innerText: '제목:', style: {marginRight: '5px', width: '40px'}});
            const titleInput = createElement('input', {
                type: 'text',
                className: 'form-control form-control-sm',
                value: file.name
            });
            titleDiv.appendChild(titleLabel);
            titleDiv.appendChild(titleInput);
            infoGroup.appendChild(titleDiv);

            const fileDiv = createElement('div', {style: {display: 'flex', alignItems: 'center'}});
            const fileLabel = createElement('label', {innerText: '파일명:', style: {marginRight: '5px', width: '70px'}});
            const fileNameSpan = createElement('span', {innerText: file.name});
            fileDiv.appendChild(fileLabel);
            fileDiv.appendChild(fileNameSpan);
            infoGroup.appendChild(fileDiv);

            textContainer.appendChild(infoGroup);

            const deleteBtn = createElement('button', {
                type: 'button',
                className: 'btn btn-danger btn-sm ms-2',
                innerText: '삭제'
            });
            deleteBtn.addEventListener('click', function () {
                listItem.remove();
                updateItemCount();
            });

            listItem.appendChild(imgPreview);
            listItem.appendChild(textContainer);
            listItem.appendChild(deleteBtn);
            gameItemsContainer.appendChild(listItem);
            updateItemCount();
        }

        // 비디오 아이템 추가 함수
        function addVideoItem(link) {
            if (!link) return;
            const emptyMessage = document.getElementById('emptyItemsMessage');
            if (emptyMessage) emptyMessage.remove();

            const listItem = createElement('li', {
                className: 'list-group-item d-flex align-items-center',
                attributes: {'data-type': 'YOUTUBE'}
            });

            const textContainer = createElement('div', {className: 'item-info flex-grow-1 d-flex align-items-center justify-content-between'});
            const infoGroup = createElement('div', {style: {display: 'flex', gap: '15px', flexGrow: '1'}});

            const titleDiv = createElement('div', {style: {display: 'flex', alignItems: 'center'}});
            const titleLabel = createElement('label', {innerText: '제목:', style: {marginRight: '5px', width: '40px'}});
            const titleInput = createElement('input', {
                type: 'text',
                className: 'form-control form-control-sm',
                value: link,
                style: {width: '400px'}
            });
            titleDiv.appendChild(titleLabel);
            titleDiv.appendChild(titleInput);
            infoGroup.appendChild(titleDiv);

            const linkDiv = createElement('div', {style: {display: 'flex', alignItems: 'center', width: '100%'}});
            const linkLabel = createElement('label', {
                innerText: '유튜브 링크:',
                style: {marginRight: '5px', width: '100px'}
            });
            const linkInput = createElement('input', {
                type: 'url',
                className: 'form-control form-control-sm',
                value: link,
                style: {width: '100%'}
            });
            linkDiv.appendChild(linkLabel);
            linkDiv.appendChild(linkInput);
            infoGroup.appendChild(linkDiv);

            textContainer.appendChild(infoGroup);

            const deleteBtn = createElement('button', {
                type: 'button',
                className: 'btn btn-danger btn-sm ms-2',
                innerText: '삭제'
            });
            deleteBtn.addEventListener('click', function () {
                listItem.remove();
                updateItemCount();
            });

            listItem.appendChild(textContainer);
            listItem.appendChild(deleteBtn);
            gameItemsContainer.appendChild(listItem);
            updateItemCount();
        }

        // 범용 드래그앤드랍 함수
        function setupDropZone(dropZone, fileInput, callback, allowMultiple) {
            dropZone.addEventListener('click', function () {
                fileInput.click();
            });
            fileInput.addEventListener('change', function (e) {
                const files = e.target.files;
                if (files.length) {
                    for (let i = 0; i < files.length; i++) {
                        callback(files[i]);
                    }
                    fileInput.value = '';
                }
            });
            dropZone.addEventListener('dragover', function (e) {
                e.preventDefault();
                dropZone.classList.add('drop-zone-over');
            });
            dropZone.addEventListener('dragleave', function (e) {
                dropZone.classList.remove('drop-zone-over');
            });
            dropZone.addEventListener('drop', function (e) {
                e.preventDefault();
                dropZone.classList.remove('drop-zone-over');
                const files = e.dataTransfer.files;
                if (files.length) {
                    if (!allowMultiple && files.length > 1) {
                        callback(files[0]);
                    } else {
                        for (let i = 0; i < files.length; i++) {
                            callback(files[i]);
                        }
                    }
                }
            });
        }

        // 테마 이미지 드롭존 설정 (파일 객체 저장)
        setupDropZone(themeImageUploadZone, themeImgFileInput, function (file) {
            const previewSVG = themeImagePreview.querySelector("svg");
            previewSVG.style.display = `none`;
            themeImagePreviewImg.style.display = "block";
            themeImagePreviewImg.src = URL.createObjectURL(file);
            themeImagePreviewImg.alt = file.name;

            // 테마 이미지 파일 저장
            themeImageFile = file;
            updateItemCount();
        }, false);

        // 아이템 이미지 드롭존 (이미지 타입)
        setupDropZone(imageDropZone, imageUploadInput, function (file) {
            if (itemTypeSelect.value === 'IMAGE') {
                addImageItem(file);
            }
        }, true);

        // 비디오 링크 추가 버튼 이벤트 (팝오버로 유효하지 않은 링크 알림)
        let videoLinkPopover = null;
        addVideoLinkBtn.addEventListener('click', function () {
            const link = videoLinkInput.value.trim();
            const youtubeRegex = /^(https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)[\w-]+/;
            if (!youtubeRegex.test(link)) {
                if (videoLinkPopover) {
                    videoLinkPopover.dispose();
                }
                videoLinkPopover = new bootstrap.Popover(addVideoLinkBtn, {
                    trigger: 'manual',
                    placement: 'right',
                    content: '유효한 유튜브 링크를 입력해주세요.'
                });
                videoLinkPopover.show();
                setTimeout(() => {
                    videoLinkPopover.hide();
                }, 3000);
                return;
            }
            if (link && itemTypeSelect.value === 'YOUTUBE') {
                addVideoItem(link);
                videoLinkInput.value = '';
            }
        });

        // "모두 삭제" 버튼 이벤트
        clearAllItemsBtn.addEventListener('click', function () {
            gameItemsContainer.innerHTML = '<li class="list-group-item text-center text-muted" id="emptyItemsMessage">추가된 아이템이 없습니다. 아이템을 추가해주세요.</li>';
            updateItemCount();
        });

        // 아이템 타입 변경 시 UI 업데이트
        itemTypeSelect.addEventListener('change', function () {
            themeImageFile = null;
            const previewSVG = themeImagePreview.querySelector("svg");
            previewSVG.style.display = `block`;
            updateItemTypeUI();
        });

        // 제출 버튼 클릭 시: 테마 이미지가 없으면 팝오버 표시 후 제출 중단, 그 외 정상 요청 진행
        let themePopover = null;
        submitButton.addEventListener('click', async function (e) {
                e.preventDefault();
                // 테마 이미지가 없으면 팝오버 표시
                if (!themeImageFile) {
                    if (themePopover) {
                        themePopover.dispose();
                    }
                    themePopover = new bootstrap.Popover(themeImageUploadZone, {
                        trigger: 'manual',
                        placement: 'right',
                        content: '테마 이미지를 추가해주세요.'
                    });
                    themePopover.show();
                    setTimeout(() => {
                        themePopover.hide();
                    }, 3000);
                    return;
                }

                try {
                    let themeImgUrl = null;
                    // 1. 테마 이미지 업로드 요청
                    if (themeImageFile) {
                        const themeFormData = new FormData();
                        themeFormData.append('file', themeImageFile);
                        const themeUploadResponse = await fetch('/s3/images', {
                            method: 'POST',
                            body: themeFormData
                        });
                        if (!themeUploadResponse.ok) {
                            throw new Error('테마 이미지 업로드 실패');
                        }
                        const themeUploadResult = await themeUploadResponse.json();
                        themeImgUrl = themeUploadResult.imgUrl;
                    }

                    // 2. 카테고리 생성 요청 (테마 이미지 URL 포함)
                    const categoryRequestData = {
                        theme: themeInput.value,
                        item_type: itemTypeSelect.value === 'IMAGE' ? 'IMAGE' : 'YOUTUBE',
                        theme_img_url: themeImgUrl
                    };
                    const categoryResponse = await fetch('/api/category', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify(categoryRequestData)
                    });

                    // 카테고리 중복 처리
                    if (categoryResponse.status === 409) {
                        const categoryConflictModal = new bootstrap.Modal(document.getElementById('categoryConflictModal'));
                        categoryConflictModal.show();
                        return;
                    }

                    if (!categoryResponse.ok) {
                        throw new Error('카테고리 생성 실패');
                    }

                    const categoryResult = await categoryResponse.json();

                    // 3. 아이템 이미지 업로드 및 아이템 데이터 구성
                    const gameItemsData = [];
                    if (itemTypeSelect.value === "IMAGE") {
                        const imageItems = Array.from(gameItemsContainer.querySelectorAll('li.list-group-item[data-type="IMAGE"]'));
                        for (let listItem of imageItems) {
                            const file = listItem.file;
                            const titleInput = listItem.querySelector('input[type="text"]');
                            const title = titleInput ? titleInput.value : '';
                            let imageUrl = null;
                            if (file) {
                                const itemFormData = new FormData();
                                itemFormData.append('file', file);
                                const itemUploadResponse = await fetch('/s3/images', {
                                    method: 'POST',
                                    body: itemFormData
                                });
                                if (!itemUploadResponse.ok) {
                                    throw new Error('아이템 이미지 업로드 실패');
                                }
                                const itemUploadResult = await itemUploadResponse.json();
                                imageUrl = itemUploadResult.imgUrl;
                            }
                            gameItemsData.push({
                                title: title,
                                category_theme: themeInput.value,
                                resource_url: imageUrl
                            });
                        }
                    } else {
                        const items = Array.from(gameItemsContainer.querySelectorAll('.list-group-item'));
                        for (let item of items) {
                            const title = item.querySelector(`input[type = "text"]`).value;
                            const resourceUrl = item.querySelector('input[type="url"]') ? item.querySelector('input[type="url"]').value : null;

                            gameItemsData.push({
                                title: title,
                                category_theme: themeInput.value,
                                resource_url: resourceUrl
                            });
                        }
                    }

                    // 4. 아이템 생성 요청
                    const itemsResponse = await fetch('/api/items', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify(gameItemsData)
                    });
                    if (!itemsResponse.ok) {
                        throw new Error('아이템 생성 실패');
                    }
                    const itemsResult = await itemsResponse.json();

                    console.log('카테고리 생성 결과:', categoryResult);
                    console.log('아이템 생성 결과:', itemsResult);
                    const categorySubmitModal = new bootstrap.Modal(document.getElementById('categorySubmitModal'));
                    categorySubmitModal.show();
                } catch
                    (error) {
                    console.error("전체 요청 중 오류 발생:", error);
                    // 오류 처리 로직 (예: 팝업, 알림 등) 추가 가능
                }
            }
        );

        // 제출 전에 아이템 개수가 없는 경우에도 팝오버로 안내
        let isSubmitPopoverShown = false;
        submitButton.addEventListener('click', function (e) {
            const count = gameItemsContainer.querySelectorAll('li.list-group-item[data-type]').length;
            if (count <= 0) {
                e.preventDefault();
                let popover = bootstrap.Popover.getInstance(submitButton);
                if (!popover) {
                    popover = new bootstrap.Popover(submitButton, {
                        content: "아이템을 추가해주세요.",
                        trigger: "manual",
                        placement: "right"
                    });
                }
                if (!isSubmitPopoverShown) {
                    popover.show();
                    isSubmitPopoverShown = true;
                    setTimeout(function () {
                        popover.hide();
                        isSubmitPopoverShown = false;
                    }, 3000);
                }
            }
        });

        // 초기 UI 설정
        updateItemTypeUI();
    });
</script>
</body>
</html>