<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>✨ 멋진 웹사이트 ✨</title>
    <link rel="stylesheet" href="/css/style.css"> </head>
<body>
    <header>
        <h1> 웹 개발 탐험 </h1>
    </header>
    <main>
        <section class="message-box">
            <h2>오늘은 <fmt:formatDate value="${today}" pattern="yyyy년 MM월 dd일"/>입니다!</h2>
            <p class="message">
                ${msg} </p>
        </section>
        <section class="version-info">
            <h3>현재 버전: 1.0</h3>
        </section>
    </main>
    <script src="/js/script.js"></script> </body>
</html>