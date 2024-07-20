<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>
        <c:if test="${category.id==null}">
            Dodaj kategorię
        </c:if>
        <c:if test="${category.id!=null}">
            Edytuj kategorię
        </c:if></title>
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>"/>
</head>
<body>
<header>
    <%@ include file="elements/adminnav.jsp" %>
</header>

<section class="login-page">
    <h2><c:if test="${category.id==null}">
        Dodaj kategorię
    </c:if>
        <c:if test="${category.id!=null}">
            Edytuj kategorię
        </c:if></h2>
    <form:form method="post" modelAttribute="category" action="/admin/manage/category/add">
        <form:hidden path="id" id="id"/>
        <div class="form-group">
            <form:input path="name" placeholder="Nazwa" /><br><br>
            <c:if test="${wrongName!=null}">
                <p style="color: red">${wrongName}</p>
            </c:if>
        </div>
        <div class="form-group form-group--buttons">
            <button class="btn" type="submit">Zapisz</button>
        </div>
    </form:form>
</section>