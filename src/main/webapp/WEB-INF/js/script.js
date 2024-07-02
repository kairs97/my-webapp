// 메시지 박스에 텍스트 변경
const messageBox = document.querySelector('.message-box .message');
messageBox.textContent = '변경된 메시지입니다!';

// 버튼 클릭 시 메시지 박스 숨기기
const hideButton = document.createElement('button');
hideButton.textContent = '숨기기';
messageBox.parentNode.appendChild(hideButton);

hideButton.addEventListener('click', () => {
  messageBox.parentNode.style.display = 'none';
});