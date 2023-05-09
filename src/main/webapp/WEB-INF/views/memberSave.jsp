<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 3:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<%@include file="./conponent/header.jsp"%>
<%@include file="./conponent/nav.jsp"%><br>
<div id="section">

  <form action="/member/save" method="post">
    <input type="text" name="memberEmail" placeholder="이메일"><br>
    <input type="text" name="memberPassword" placeholder="비밀번호"><br>
    <input type="text" name="memberName" placeholder="이름"><br>
    <input type="text" name="memberMobile" placeholder="전화번호"><br>
    <input type="submit" value="가입">
  </form>
</div>

<%@include file="./conponent/footer.jsp"%>
</body>
</html>
