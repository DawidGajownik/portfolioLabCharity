<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<nav class="container container--70">
    <ul class="nav--actions">
        <li class="logged-user">
            Witaj ${loggedUserLogin}
            <ul class="dropdown">
                <li><a href="/myProfile">Profil</a></li>
                <li><a href="/myDonations">Moje zbiórki</a></li>
                <li><a href="/">Strona główna</a></li>
                <li><a href="/logout">Wyloguj</a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <c:if test="${log!=null}">
            <li>${log}</li>
        </c:if>
        ${log}
        ${exception}
        <li><a href="/admin/manage/users" class="btn btn--without-border">Uzytkownicy</a></li>
        <li><a href="/admin/manage/institutions" class="btn btn--without-border">Instytucje</a></li>
        <li><a href="/admin/manage/categories" class="btn btn--without-border">Kategorie</a></li>
        <li><a href="/admin/logs" class="btn btn--without-border">Logi</a></li>
    </ul>
</nav>