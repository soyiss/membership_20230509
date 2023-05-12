<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-12
  Time: 오전 9:06
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
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <%--  시간 형식을 맞출때 사용하는 라이브러리  --%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>

<%@include file="../conponent/header.jsp" %>
<%@include file="../conponent/nav.jsp" %>
<br>
<div id="section">
    <table>
        <tr>
            <th>id</th>
            <td>${board.id}</td>
        </tr>
        <tr>
            <th>title</th>
            <td>${board.boardTitle}</td>
        </tr>
        <tr>
            <th>writer</th>
            <td>${board.boardWriter}</td>
        </tr>
        <tr>
            <th>contents</th>
            <td>${board.boardContents}</td>
        </tr>
        <tr>
            <th>hits</th>
            <td>${board.boardHits}</td>
        </tr>
        <tr>
            <th>date</th>
            <td>
                <fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
            </td>
        </tr>
        <%--    첨부된 파일이있으면 목록에 이미지가 뜨게하공 없으면 아에 이미지 칸 자체가 안보이게 하기    --%>
        <c:if test="${board.fileAttached == 1}">
            <tr>
                <th>image</th>
                <td>
                    <c:forEach items="${boardFileList}" var="boardFile">
                        <%--    ${pageContext.request.contextPath}는 현재 프로젝트의 경로에 접근한다(그냥 기본적으로 써야되는 식이다)            --%>
                        <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt=""
                             width="100" height="100">
                    </c:forEach>
                </td>
            </tr>
        </c:if>
    </table>
    <button onclick="board_list()">목록</button>
    <c:choose>
        <%--    작성자와 로그인한 이메일이 같을때 그리고 로그인한 이메일이 admin이 아닐때 수정 삭제 버튼을 띄우게 해라    --%>
        <c:when test="${board.boardWriter == sessionScope.loginEmail && sessionScope.loginEmail != 'admin'}">
            <button onclick="board_update()">수정</button>
            <button onclick="board_delete()">삭제</button>
        </c:when>
        <%--    로그인한 이메일이 admin일때 삭제 버튼을 띄우게 해라     --%>
        <c:when test="${sessionScope.loginEmail  == 'admin'}">
            <button onclick="board_delete()">삭제</button>
        </c:when>
    </c:choose>
    <div id="comment-write-area">
        댓글 작성자<input type="text" name="commentWriter" id="comment-writer" value="${sessionScope.loginEmail}"
                     readonly><br>
        <input type="text" name="commentContents" id="comment-contents" placeholder="댓글 내용"><br>
        <button onclick="comment_write()">댓글작성</button>
    </div>

    <div id="comment-list">
        <%-- 가져온 commentDTOList를 뿌려준다--%>
        <c:choose>
            <c:when test="${commentList == null}">
                <h5>현재 작성된 댓글이 없습니다.</h5>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>id</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                    </tr>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.id}</td>
                            <td>${comment.commentWriter}</td>
                            <td>${comment.commentContents}</td>
                            <td>
                                <fmt:formatDate value="${comment.commentCreatedDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>


</div>
<%@include file="../conponent/footer.jsp" %>
</body>
<script>
    const board_list = () => {
        const page = '${page}';

        location.href = "/board/paging?page=" + page;
    }
    const board_update = () => {
        const id = '${board.id}';
        location.href = "/board/update?id=" + id;
    }
    const board_delete = () => {
        const id = '${board.id}';
        location.href = "/board/board_delete?id=" + id;
    }

    const comment_write = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.getElementById("comment-contents").value;
        const boardId = '${board.id}';
        const result = document.getElementById("comment-list");

        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                "commentWriter": commentWriter,
                "commentContents": commentContents,
                "boardId": boardId,
                "memberId": memberId
            },
            success: function (res) {
                let output = "<table>";
                output += "<tr>";
                output += "<th>id</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th>";
                output += "</tr>";
                for (let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].id + "</td>";
                    output += "<td>" + res[i].commentWriter + "</td>";
                    output += "<td>" + res[i].commentContents + "</td>";
                    output += "<td>" + moment(res[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                result.innerHTML = output;
                //인풋태그를 비우는 역할
                document.getElementById("comment-contents").value = "";
            },
            error: function () {
                console.log("실패");
            }

        });

    }
</script>
</html>
