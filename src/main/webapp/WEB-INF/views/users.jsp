<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Lista użytkowników</title>
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
<h2>Lista użytkowników</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Login</th>
        <th>Email</th>
        <th>Akcje</th>
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
                    <button type="submit" class="btn2">Zresetuj hasło</button>
                </form>
                <form action="toggleAdmin" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2">
                        <c:choose>
                            <c:when test="${user.level == 0}">
                                Przyznaj admina
                            </c:when>
                            <c:otherwise>
                                Odbierz admina
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>
                <form action="blockuser" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2">
                        <c:choose>
                            <c:when test="${user.active == true}">
                                Zablokuj
                            </c:when>
                            <c:otherwise>
                                Odblokuj
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>
                <form action="deleteuser" method="post" style="display: inline;">
                    <input type="hidden" name="userId" value="${user.id}" />
                    <button type="submit" class="btn2">Usuń konto</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>