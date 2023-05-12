<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 1:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        #section p{

            float: right;
        }
    </style>
</head>
<body>

<%@include file="./conponent/header.jsp"%>
<%@include file="./conponent/nav.jsp"%>
<div id="section">
    <p><strong>로그인을 하시면 글쓰기가 보입니다 ↑</strong></p>

</div>
<%@include file="./conponent/footer.jsp"%>
</body>
</html>
