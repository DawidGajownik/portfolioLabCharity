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
    <title><fmt:message key="title.myDonations" /></title>
    <link rel="stylesheet" href="<c:url value="resources/css/style.css"/>"/>
    <style>
        .donations--table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 1em;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        }

        .donations--table thead tr {
            background-color: #009879;
            color: #ffffff;
            text-align: left;
            font-weight: bold;
        }

        .donations--table th,
        .donations--table td {
            padding: 12px 15px;
        }

        .donations--table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .donations--table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .donations--table tbody tr:last-of-type {
            border-bottom: 2px solid #009879;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="elements/nav.jsp" %>
</header>

<section class="donations" id="donations">
    <div class="container container--85">
        <h2><fmt:message key="title.donationList" /></h2>
        <table class="donations--table">
            <thead>
            <tr>
                <th>ID</th>
                <th><fmt:message key="table.header.foundation" /></th>
                <th><fmt:message key="table.header.bagQuantity" /></th>
                <th><fmt:message key="table.header.categories" /></th>
                <th><fmt:message key="table.header.address" /></th>
                <th><fmt:message key="table.header.phone" /></th>
                <th><fmt:message key="table.header.pickUpDate" /></th>
                <th><fmt:message key="table.header.pickUpTime" /></th>
                <th><fmt:message key="table.header.creationDate" /></th>
                <th><fmt:message key="table.header.pickUpConfirmation" /></th>
                <th><fmt:message key="table.header.courierComment" /></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="donation" items="${donations}">
                <tr>
                    <td>${donation.id}</td>
                    <td>${donation.institution.name}</td>
                    <td>${donation.quantity}</td>
                    <td>
                        <c:forEach var="category" items="${donation.categories}">
                            ${category.name}<br>
                        </c:forEach>
                    </td>
                    <td>${donation.street}, ${donation.city}, ${donation.zipCode}</td>
                    <td>${donation.phone}</td>
                    <td>${donation.pickUpDate}</td>
                    <td>${donation.pickUpTime}</td>
                    <td>${donation.creationDateTime}</td>
                    <td><c:if test="${donation.pickedUp==true}">
                        ${donation.pickUpClickDateTime}
                    </c:if>
                        <c:if test="${donation.pickedUp==false}">
                            <form action="donation/confirm" method="post" style="display: inline;">
                                <input type="hidden" name="donationId" value="${donation.id}" />
                                <button type="submit" class="btn2"><fmt:message key="button.confirmPickUp" /></button>
                            </form>
                        </c:if></td>
                    <td>${donation.pickUpComment}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<%@ include file="elements/footer.jsp" %>
</body>
</html>
