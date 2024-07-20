<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Przypomnij hasło</title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
</head>
<body>
<header>
    <%@ include file="elements/nav.jsp" %>
</header>

<section class="login-page">
    <h2>Przypomnij hasło</h2>
    <form:form method="post" modelAttribute="user" action="/setNewPassword">
        <form:hidden path="email" id="email"/>
        <form:hidden path="login" id="login"/>
        <form:hidden path="id" id="id"/>
        <form:hidden path="active" id="active"/>
        <form:hidden path="confirmed" id="confirmed"/>
        <div class="form-group">
            <form:password path="password" placeholder="Hasło" />
            <c:if test="${passwordError!=null}">
                <p style="color: red">${passwordError}</p>
            </c:if>
        </div>

        <div class="form-group">
            <input type="password" name="confirmPassword" placeholder="Powtórz hasło" />
            <c:if test="${passwordsAreDifferent!=null}">
                <p style="color: red">${passwordsAreDifferent}</p>
            </c:if>
        </div>
        <div class="form-group form-group--buttons">
            <button class="btn" type="submit">Zmień hasło</button>
        </div>
    </form:form>
</section>

<%@ include file="elements/footer.jsp" %>