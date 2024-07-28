<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title><fmt:message key="title.logs" /></title>
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
    </style>
</head>
<body>
<header>
    <%@ include file="elements/adminnav.jsp" %>
</header>
<h2><fmt:message key="title.logs" /></h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th><fmt:message key="table.header.log" /></th>
        <th><fmt:message key="table.header.admin" /></th>
        <th><fmt:message key="table.header.object" /></th>
        <th><fmt:message key="table.header.dateTime" /></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="log" items="${logs}">
        <tr>
            <td>${log.id}</td>
            <td>${log.log}</td>
            <td>${log.admin}</td>
            <td>${log.object}</td>
            <td>${log.localDateTime}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
