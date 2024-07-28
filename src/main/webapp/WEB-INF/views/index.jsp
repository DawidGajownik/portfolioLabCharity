<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="elements/headerindex.jsp" %>

<section class="stats" id="stats">
    <div class="container container--85">
        <div class="stats--item">
            <em>${givenBags}</em>
            <h3><fmt:message key="stats.givenBags" /></h3>
            <p><fmt:message key="stats.givenBagsDesc" /></p>
        </div>

        <div class="stats--item">
            <em>${givenDonations}</em>
            <h3><fmt:message key="stats.givenDonations" /></h3>
            <p><fmt:message key="stats.givenDonationsDesc" /></p>
        </div>
    </div>
</section>

<section class="steps" id="steps">
    <h2><fmt:message key="steps.title" /></h2>

    <div class="steps--container">
        <div class="steps--item">
            <span class="icon icon--hands"></span>
            <h3><fmt:message key="steps.chooseItems" /></h3>
            <p><fmt:message key="steps.chooseItemsDesc" /></p>
        </div>
        <div class="steps--item">
            <span class="icon icon--arrow"></span>
            <h3><fmt:message key="steps.packItems" /></h3>
            <p><fmt:message key="steps.packItemsDesc" /></p>
        </div>
        <div class="steps--item">
            <span class="icon icon--glasses"></span>
            <h3><fmt:message key="steps.decideWhoToHelp" /></h3>
            <p><fmt:message key="steps.decideWhoToHelpDesc" /></p>
        </div>
        <div class="steps--item">
            <span class="icon icon--courier"></span>
            <h3><fmt:message key="steps.orderCourier" /></h3>
            <p><fmt:message key="steps.orderCourierDesc" /></p>
        </div>
    </div>
    <c:if test="${loggedUserId==null}">
        <a href="/register" class="btn btn--large"><fmt:message key="button.createAccount" /></a>
    </c:if>
    <c:if test="${loggedUserId!=null}">
        <a href="/donation" class="btn btn--large"><fmt:message key="button.giveItems" /></a>
    </c:if>
</section>

<section class="v" id="about-us">
    <div class="about-us--text">
        <h2><fmt:message key="aboutUs.title" /></h2>
        <p><fmt:message key="aboutUs.description" /></p>
        <img src="<c:url value="resources/images/signature.svg"/>" class="about-us--text-signature" alt="Signature"/>
    </div>
    <div class="about-us--image"><img src="<c:url value="resources/images/about-us.jpg"/>" alt="People in circle"/>
    </div>
</section>

<section class="help" id="help">
    <h2><fmt:message key="help.title" /></h2>

    <!-- SLIDE 1 -->
    <div class="help--slides active" data-id="1">
        <p><fmt:message key="help.description" /></p>

        <ul class="help--slides-items">
            <c:forEach var="institution" items="${institutions}">
                <li>
                    <div class="col">
                        <div class="title">"${institution.getKey().name}"</div>
                        <div class="subtitle">${institution.getKey().description}</div>
                    </div>
                    <c:if test="${institution.getValue().name!=null}">
                    </c:if>
                    <div class="col">
                        <div class="title">
                            <c:if test="${institution.getValue().name!=null}">
                                "${institution.getValue().name}"
                            </c:if>
                            <c:if test="${institution.getValue().name==null}">
                                <br>
                            </c:if>
                        </div>
                        <div class="subtitle">${institution.getValue().description}</div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</section>
<%@ include file="elements/footer.jsp" %>
</body>
</html>
