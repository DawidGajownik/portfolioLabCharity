<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<nav class="container container--70">
    <ul class="nav--actions">
    <c:if test="${loggedUserId==null}">
        <li><a href="/login" class="btn btn--small btn--without-border">Zaloguj</a></li>
        <li><a href="/register" class="btn btn--small btn--highlighted">Załóż konto</a></li>
    </c:if>
    <c:if test="${loggedUserId!=null}">
        <li class="logged-user">
            Witaj ${loggedUserLogin}
            <ul class="dropdown">
                <li><a href="/myProfile">Profil</a></li>
                <li><a href="/myDonations">Moje zbiórki</a></li>
                <c:if test="${admin==1}">
                    <li><a href="/admin">Panel administratora</a></li>
                </c:if>
                <li><a href="/logout">Wyloguj</a></li>
            </ul>
        </li>
    </c:if>
    </ul>
    <ul>
        <li><a href="/" class="btn btn--without-border active">Start</a></li>
        <li><a href="/donation" class="btn btn--without-border">Oddaj rzeczy</a></li>
        <li><a href="/#steps" class="btn btn--without-border">O co chodzi?</a></li>
        <li><a href="/#about-us" class="btn btn--without-border">O nas</a></li>
        <li><a href="/#help" class="btn btn--without-border">Fundacje i organizacje</a></li>
        <li><a href="#contact" class="btn btn--without-border">Kontakt</a></li>
    </ul>
</nav>