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
    <title>Logowanie</title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
</head>
<body>
<header>
    <%@ include file="elements/nav.jsp" %>
</header>

<section class="login-page">
    <h2>Zaloguj się</h2>
    <form:form method="post" modelAttribute="user" action="/login">
        <div class="form-group">
            <form:input path="login" placeholder="Login lub e-mail" /><br><br>
            <c:if test="${wrongUser!=null}">
                <p style="color: red">${wrongUser}</p>
            </c:if>
            <c:if test="${block!=null}">
                <p style="color: red">${block}</p>
            </c:if>
        </div>
        <div class="form-group">
            <form:password path="password" placeholder="Hasło" /><br><br>
            <c:if test="${wrongPassword!=null}">
                <p style="color: red">${wrongPassword}</p>
            </c:if>
        </div>
        <div class="form-group form-group--buttons">
            <a href="/register" class="btn btn--without-border">Zarejestruj się</a>
            <button class="btn" type="submit">Zaloguj się</button>
            <a href="/remind" class="btn btn--without-border">Nie pamiętam hasła</a>
        </div>
    </form:form>
</section>

<%@ include file="elements/footer.jsp" %>