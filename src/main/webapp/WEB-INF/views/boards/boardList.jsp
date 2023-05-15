<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오전 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>

    #section table{
      margin: 0 auto;
      margin-top: 50px;
    }
    #section table tr,th,td{
      text-align: center;
      border: solid 1px black;
      padding: 10px 20px;
    }
  </style>
</head>
<body>

<%@include file="../conponent/header.jsp"%>
<%@include file="../conponent/nav.jsp"%>
<div id="section">
  <table>
    <tr>
      <th>글번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>내용</th>
      <th>조회수</th>
      <th>작성시간</th>
      <th>파일여부</th>
    </tr>
    <c:forEach items="${boardList}" var="board">
      <tr>
        <td>${board.id}</td>
        <td>${board.boardTitle}</td>
        <td>${board.boardWriter}</td>
        <td>${board.boardContents}</td>
        <td>${board.boardHits}</td>
        <td>
          <fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
        </td>
        <td>${board.fileAttached}</td>
      </tr>
    </c:forEach>
  </table>
</div>

<%@include file="../conponent/footer.jsp"%>
</body>
</html>
