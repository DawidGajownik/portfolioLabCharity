<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title><fmt:message key="title.login" /></title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
</head>
<body>
<header>
    <%@ include file="elements/nav.jsp" %>
</header>

<section class="login-page">
    <h2><fmt:message key="title.login" /></h2>
    <form:form method="post" modelAttribute="user" action="/login">
        <div class="form-group">
            <fmt:message key="placeholder.loginOrEmail" var="placeholderLoginOrEmail"/>
            <form:input path="login" placeholder="${placeholderLoginOrEmail}" /><br><br>
            <c:if test="${wrongUser!=null}">
                <p style="color: red">${wrongUser}</p>
            </c:if>
            <c:if test="${block!=null}">
                <p style="color: red">${block}</p>
            </c:if>
        </div>
        <div class="form-group">
            <fmt:message key="placeholder.password" var="placeholderPassword"/>
            <form:password path="password" placeholder="${placeholderPassword}" /><br><br>
            <c:if test="${wrongPassword!=null}">
                <p style="color: red">${wrongPassword}</p>
            </c:if>
        </div>
        <div class="form-group form-group--buttons">
            <a href="/register" class="btn btn--without-border"><fmt:message key="button.register" /></a>
            <button class="btn" type="submit"><fmt:message key="button.login" /></button>
            <a href="/remind" class="btn btn--without-border"><fmt:message key="button.forgotPassword" /></a>
        </div>
    </form:form>
</section>

<%@ include file="elements/footer.jsp" %>
</body>
</html>
