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
        <c:if test="${institution.id==null}">
            <fmt:message key="title.addInstitution" />
        </c:if>
        <c:if test="${institution.id!=null}">
            <fmt:message key="title.editInstitution" />
        </c:if>
    </title>
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>"/>
    <style>
        .large-input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
        }
        .large-textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="elements/adminnav.jsp" %>
</header>

<section class="login-page">
    <h2>
        <c:if test="${institution.id==null}">
            <fmt:message key="title.addInstitution" />
        </c:if>
        <c:if test="${institution.id!=null}">
            <fmt:message key="title.editInstitution" />
        </c:if>
    </h2>
    <form:form method="post" modelAttribute="institution" action="/admin/manage/institution/add">
        <form:hidden path="id" id="id"/>
        <fmt:message key="placeholder.name" var="placeholderName"/>
        <div class="form-group">
            <form:textarea path="name" placeholder="${placeholderName}" cssClass="large-input" /><br><br>
            <c:if test="${wrongName != null}">
                <p style="color: red"><fmt:message key="error.wrongName" /></p>
            </c:if>
        </div>
        <fmt:message key="placeholder.description" var="placeholderDescription"/>
        <div class="form-group">
            <form:textarea path="description" placeholder="${placeholderDescription}" cssClass="large-textarea" /><br><br>
            <c:if test="${wrongDescription != null}">
                <p style="color: red"><fmt:message key="error.wrongDescription" /></p>
            </c:if>
        </div>
        <div class="form-group form-group--buttons">
            <button class="btn" type="submit"><fmt:message key="button.save" /></button>
        </div>
    </form:form>
</section>
</body>
</html>
