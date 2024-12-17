<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<nav class="container container--70">
    <ul class="nav--actions">
        <c:if test="${loggedUserId==null}">
            <li><a href="/login" class="btn btn--small btn--without-border"><fmt:message key="nav.login" /></a></li>
            <li><a href="/register" class="btn btn--small btn--highlighted"><fmt:message key="nav.register" /></a></li>
        </c:if>
        <c:if test="${loggedUserId!=null}">
            <li class="logged-user">
                <fmt:message key="nav.welcome" /> ${loggedUserLogin}
                <ul class="dropdown">
                    <li><a href="/myProfile"><fmt:message key="nav.profile" /></a></li>
                    <li><a href="/myDonations"><fmt:message key="nav.myDonations" /></a></li>
                    <c:if test="${admin==1}">
                        <li><a href="/admin"><fmt:message key="nav.adminPanel" /></a></li>
                    </c:if>
                    <li><a href="/logout"><fmt:message key="nav.logout" /></a></li>
                </ul>
            </li>
        </c:if>
    </ul>
    <ul>
        <li><a href="/" class="btn btn--without-border active"><fmt:message key="nav.start" /></a></li>
        <li><a href="/donation" class="btn btn--without-border"><fmt:message key="nav.giveAwayItems" /></a></li>
        <li><a href="/#steps" class="btn btn--without-border"><fmt:message key="nav.howItWorks" /></a></li>
        <li><a href="/#about-us" class="btn btn--without-border"><fmt:message key="nav.aboutUs" /></a></li>
        <li><a href="/#help" class="btn btn--without-border"><fmt:message key="nav.foundations" /></a></li>
        <li><a href="#contact" class="btn btn--without-border"><fmt:message key="nav.contact" /></a></li>
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
