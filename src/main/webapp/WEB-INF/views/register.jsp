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
    <title><c:if test="${loggedUserId!=null}">
            Mój profil
    </c:if>
        <c:if test="${loggedUserId==null}">
            Rejestracja
        </c:if> </title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
</head>
<body>
<header>
    <%@ include file="elements/nav.jsp" %>
</header>

<section class="login-page">
    <h2><c:if test="${loggedUserId!=null}">
        Edytuj dane
    </c:if>
        <c:if test="${loggedUserId==null}">
            Załóż konto
        </c:if></h2>
    <form:form method="post" modelAttribute="user" action="/register">
        <form:hidden path="id" id="id"/>
        <div class="form-group">
            <form:input path="login" placeholder="Nazwa użytkownika" />
            <c:if test="${loginError!=null}">
                <p style="color: red">${loginError}</p>
            </c:if>
        </div>
        <div class="form-group">
            <form:input path="email" placeholder="Email" />
            <c:if test="${emailError!=null}">
                <p style="color: red">${emailError}</p>
            </c:if>
        </div>
        <c:if test="${loggedUserId!=null}">
            <div class="form-group">
                <input type="password" placeholder="Stare hasło" name="oldPassword">
                <c:if test="${oldPasswordError!=null}">
                    <p style="color: red">${oldPasswordError}</p>
                </c:if>
            </div>
            <div class="form-group">
                <input type="password" placeholder="Nowe hasło" name="newPassword">
                <c:if test="${passwordError!=null}">
                    <p style="color: red">${passwordError}</p>
                </c:if>
            </div>

        </c:if>
        <c:if test="${loggedUserId==null}">
            <div class="form-group">
                <form:password path="password" placeholder="Hasło" />
                <c:if test="${passwordError!=null}">
                    <p style="color: red">${passwordError}</p>
                </c:if>
            </div>
        </c:if>

        <div class="form-group">
            <input type="password" name="confirmPassword" placeholder="Powtórz hasło" />
            <c:if test="${passwordsAreDifferent!=null}">
                <p style="color: red">${passwordsAreDifferent}</p>
            </c:if>
        </div>


        <div class="form-group form-group--buttons">
            <c:if test="${loggedUserId!=null}">
                <button class="btn" type="submit">Zmień dane</button>
            </c:if>
            <c:if test="${loggedUserId==null}">
                <a href="/login" class="btn btn--without-border">Zaloguj się</a>
                <button class="btn" type="submit">Załóż konto</button>
                <a href="/remind" class="btn btn--without-border">Nie pamiętam hasła</a>
            </c:if>

        </div>
    </form:form>
</section>

<%@ include file="elements/footer.jsp" %>