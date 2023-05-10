<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="nav">
    <ul>
        <li>
            <a href="/">
                <i class="bi bi-house"></i>
            </a>
        </li>

        <li>
            <a href="/member/save">sign-up</a>
        </li>
        <li>
            <a href="/member/login">login</a>
        </li>
        <li>
            <a href="/">List</a>
        </li>
        <li class="login-name">
            <c:choose>
                <c:when test="${sessionScope.loginEmail != null}">
                    <a href="/member/myPage" style="color: white;">${sessionScope.loginEmail} 님 환영해요!</a>
                    <a href="/member/logout">logout</a>
                </c:when>
<%--                <c:otherwise>--%>
<%--                    <a href="/member/login">login</a>--%>
<%--                </c:otherwise>--%>
            </c:choose>
        </li>
    </ul>
</div>

<%--<script>--%>
<%--    const loginArea = document.getElementById("login-area");--%>
<%--    const loginEmail = '${sessionScope.loginEmail}';--%>
<%--    console.log(loginEmail.length);--%>
<%--    if (loginEmail.length != 0) {--%>
<%--        loginArea.innerHTML = "<a href='/mypage' style='color: white;'>"+loginEmail +"님 환영해요!</a>"+--%>
<%--            "<a href='/logout'>logout</a>";--%>
<%--    } else {--%>
<%--        loginArea.innerHTML = "<a href='/login'>login</a>";--%>
<%--    }--%>
<%--</script>--%>