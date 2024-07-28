<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<nav class="container container--70">
    <ul class="nav--actions">
        <li class="logged-user">
            <fmt:message key="nav.welcome" /> ${loggedUserLogin}
            <ul class="dropdown">
                <li><a href="/myProfile"><fmt:message key="nav.profile" /></a></li>
                <li><a href="/myDonations"><fmt:message key="nav.myDonations" /></a></li>
                <li><a href="/"><fmt:message key="nav.home" /></a></li>
                <li><a href="/logout"><fmt:message key="nav.logout" /></a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <c:if test="${log!=null}">
            <li>${log}</li>
        </c:if>
        ${log}
        ${exception}
        <li><a href="/admin/manage/users" class="btn btn--without-border"><fmt:message key="nav.users" /></a></li>
        <li><a href="/admin/manage/institutions" class="btn btn--without-border"><fmt:message key="nav.institutions" /></a></li>
        <li><a href="/admin/manage/categories" class="btn btn--without-border"><fmt:message key="nav.categories" /></a></li>
        <li><a href="/admin/logs" class="btn btn--without-border"><fmt:message key="nav.logs" /></a></li>
    </ul>
    <ul class="nav--language">
        <ul class="nav--language">
            <form method="get" action="/language" id="languageForm">
                <input type="hidden" name="redirectUrl" id="redirectUrl"/>
                <select name="lang" onchange="submitLanguageForm()">
                    <option value=""><fmt:message key="choose.language" /></option>
                    <option value="pl">Polski</option>
                    <option value="en">English</option>
                    <option value="nl">Nederlands</option>
                    <option value="de">Deutsch</option>
                    <option value="cs">Čeština</option>

                </select>
            </form>
        </ul>
    </ul>
</nav>
<script>
    function submitLanguageForm() {
        document.getElementById('redirectUrl').value = document.children[0].ownerDocument.location.pathname;
        document.getElementById('languageForm').submit();
    }
</script>