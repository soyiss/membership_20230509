<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오후 1:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /*#section form{*/
        /*    text-align: center;*/
        /*}*/

        textarea.contents1{
            width: 800px;
            resize: none;
        }

        textarea.contents2{
            width: 800px;
            height: 500px;
            resize: none;
        }
    </style>
</head>
<body>

<%@include file="../conponent/header.jsp"%>
<%@include file="../conponent/nav.jsp"%><br>
<div id="section">
<%--  ${sessionScope.loginEmail}를 그냥써도 로그인된 상태에서 뜨는 글쓰기니깐 값이 뜬다  --%>
    <form action="/board/write" method="post" enctype="multipart/form-data"><br>
        작성자<br><input type="text" name="boardWriter" value="${sessionScope.loginEmail}" readonly><br>
        <p></p>
        <textarea type="text" name="boardTitle" class="contents1" maxlength=50 placeholder="글 제목"></textarea><br>
<%--        <input type="text" name="boardTitle" placeholder="글 제목"><br>--%>
        <p></p>
        <textarea type="text" name="boardContents" class="contents2" maxlength=500 placeholder="내용을 작성하세요"></textarea><br>
        <p></p>
        <input type="file" name="boardFile" multiple> <br>
        <p></p>
        <input type="submit" value="글 작성">
    </form>
</div>
<%@include file="../conponent/footer.jsp"%>
</body>
</html>

