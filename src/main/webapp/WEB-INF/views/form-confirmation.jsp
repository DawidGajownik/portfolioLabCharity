<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title><fmt:message key="title.thankYou" /></title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
</head>
<body>
<header class="header--form-page">
    <%@ include file="elements/nav.jsp" %>

    <div class="slogan container container--90">
        <h2>
            <fmt:message key="message.thankYou" />
            <c:if test="${loggedUserId!=null}">
                <fmt:message key="message.thankYou.logged"/>
            </c:if>
        </h2>
    </div>
</header>

<%@ include file="elements/footer.jsp" %>
</body>
</html>
