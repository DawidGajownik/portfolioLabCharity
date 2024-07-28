<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title><fmt:message key="title.userList" /></title>
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>"/>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .btn2 {
            padding: 5px 10px;
            text-decoration: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f8f8f8;
        }
        .btn2:hover {
            background-color: #e8e8e8;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="elements/adminnav.jsp" %>
</header>
<h2><fmt:message key="title.userList" /></h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th><fmt:message key="table.header.login" /></th>
        <th><fmt:message key="table.header.email" /></th>
        <th><fmt:message key="table.header.actions" /></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td>
            <td>${user.login}</td>
            <td>${user.email}</td>
            <td>
                <form action="changePassword" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2"><fmt:message key="button.resetPassword" /></button>
                </form>
                <form action="toggleAdmin" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2">
                        <c:choose>
                            <c:when test="${user.level == 0}">
                                <fmt:message key="button.grantAdmin" />
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="button.revokeAdmin" />
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>
                <form action="blockuser" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2">
                        <c:choose>
                            <c:when test="${user.active == true}">
                                <fmt:message key="button.blockUser" />
                            </c:when>
                            <c:otherwise>
                                <fmt:message key="button.unblockUser" />
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>
                <form action="deleteuser" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2"><fmt:message key="button.deleteAccount" /></button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
