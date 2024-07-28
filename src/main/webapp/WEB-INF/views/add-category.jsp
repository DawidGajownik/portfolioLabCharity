<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>
        <c:if test="${category.id==null}">
            <fmt:message key="title.addCategory" />
        </c:if>
        <c:if test="${category.id!=null}">
            <fmt:message key="title.editCategory" />
        </c:if>
    </title>
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>"/>
</head>
<body>
<header>
    <%@ include file="elements/adminnav.jsp" %>
</header>

<section class="login-page">
    <h2>
        <c:if test="${category.id==null}">
            <fmt:message key="title.addCategory" />
        </c:if>
        <c:if test="${category.id!=null}">
            <fmt:message key="title.editCategory" />
        </c:if>
    </h2>
    <form:form method="post" modelAttribute="category" action="/admin/manage/category/add">
        <form:hidden path="id" id="id"/>
        <fmt:message key="placeholder.name" var="placeholderName"/>
        <div class="form-group">
            <form:input path="name" placeholder="${placeholderName}" /><br><br>
            <c:if test="${wrongName!=null}">
                <p style="color: red"><fmt:message key="error.wrongName" /></p>
            </c:if>
        </div>
        <div class="form-group form-group--buttons">
            <button class="btn" type="submit"><fmt:message key="button.save" /></button>
        </div>
    </form:form>
</section>
</body>
</html>
