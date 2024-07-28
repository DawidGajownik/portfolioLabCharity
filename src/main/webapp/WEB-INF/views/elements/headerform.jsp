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
    <title><fmt:message key="title.giveAway" /></title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
</head>
<body>
<header class="header--form-page">

    <%@ include file="nav.jsp" %>

    <div class="slogan container container--90" id="slogan">
        <div class="slogan--item">
            <h1>
                <fmt:message key="header.giveAway" /><br />
                <span class="uppercase"><fmt:message key="header.needy" /></span>
            </h1>

            <div class="slogan--steps">
                <div class="slogan--steps-title"><fmt:message key="header.fourSteps" /></div>
                <ul class="slogan--steps-boxes">
                    <li>
                        <div><em>1</em><span><fmt:message key="header.step1" /></span></div>
                    </li>
                    <li>
                        <div><em>2</em><span><fmt:message key="header.step2" /></span></div>
                    </li>
                    <li>
                        <div><em>3</em><span><fmt:message key="header.step3" /></span></div>
                    </li>
                    <li>
                        <div><em>4</em><span><fmt:message key="header.step4" /></span></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>
