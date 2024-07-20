<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Instytucje</title>
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
<h2>Instytucje</h2>
<li><a href="institution/add" class="btn2 btn--without-border">Dodaj</a></li><br>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Nazwa</th>
        <th>Opis</th>
        <th>Akcje        ${log}
            ${exception}</th>

    </tr>
    </thead>
    <tbody>
    <c:forEach var="institution" items="${institutions}">
        <tr>
            <td>${institution.id}</td>
            <td>${institution.name}</td>
            <td>${institution.description}</td>
            <td>
                <form action="blockinstitution" method="post" style="display: inline;">
                    <input type="hidden" name="institutionId" value="${institution.id}" />
                    <button type="submit" class="btn2">
                        <c:choose>
                            <c:when test="${institution.active == true}">
                                Dezaktywuj
                            </c:when>
                            <c:otherwise>
                                Aktywuj
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>
                <form action="deleteinstitution" method="post" style="display: inline;">
                    <input type="hidden" name="institutionId" value="${institution.id}" />
                    <button type="submit" class="btn2">Usuń</button>
                </form>
                <a class="btn2" href="/admin/manage/institution/edit/${institution.id}">Edytuj</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>