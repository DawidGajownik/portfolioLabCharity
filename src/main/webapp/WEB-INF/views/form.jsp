<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="elements/headerform.jsp" %>

<script type="text/javascript">
    var currentLocale = "${currentLocale}";
</script>

<section class="form--steps">
    <div class="form--steps-instructions">
        <div class="form--steps-container">
            <h3><fmt:message key="steps.important" /></h3>
            <p data-step="1" class="active">
                <fmt:message key="steps.detail1" />
            </p>
            <p data-step="2">
                <fmt:message key="steps.detail2" />
            </p>
            <p data-step="3">
                <fmt:message key="steps.detail3" />
            </p>
            <p data-step="4">
                <fmt:message key="steps.detail4" />
            </p>
        </div>
    </div>

    <div class="form--steps-container">
        <c:if test="${loggedUserId==null}">
            <a href="/login" class="btn btn--without-border"><fmt:message key="button.login" /></a>
            <a href="#continue" class="btn btn--without-border"><fmt:message key="button.continueWithoutLogin" /></a>
        </c:if>
        <div class="form--steps-counter" id="continue"><fmt:message key="steps.step" /> <span>1</span>/4</div>
        <form:form method="post" modelAttribute="donation" action="/donation">
            <div data-step="1" class="active">
                <h3><fmt:message key="steps.selectItems" /></h3>
                <c:forEach var="category" items="${categories}">
                    <div class="form-group form-group--checkbox">
                        <label>
                            <form:checkbox path="categories" value="${category.id}" />
                            <span class="checkbox"></span>
                            <span class="description">${category.name}</span>
                        </label>
                    </div>
                </c:forEach>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn next-step"><fmt:message key="button.next" /></button>
                </div>
            </div>

            <div data-step="2">
                <h3><fmt:message key="steps.numberOfBags" /></h3>
                <div class="form-group form-group--inline">
                    <label>
                        <fmt:message key="steps.numberOfBagsLabel" />
                        <form:input path="quantity" step="1" min="1"/>
                    </label>
                </div>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step"><fmt:message key="button.back" /></button>
                    <button type="button" class="btn next-step"><fmt:message key="button.next" /></button>
                </div>
            </div>

            <div data-step="3">
                <h3><fmt:message key="steps.selectOrganization" /></h3>
                <c:forEach var="institution" items="${institutions}">
                    <div class="form-group form-group--checkbox">
                        <label>
                            <form:radiobutton path="institution" value="${institution.id}" />
                            <span class="checkbox radio"></span>
                            <span class="description">
                                <div class="title">${institution.name}</div>
                                <div class="subtitle">${institution.description}</div>
                            </span>
                        </label>
                    </div>
                </c:forEach>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step"><fmt:message key="button.back" /></button>
                    <button type="button" class="btn next-step"><fmt:message key="button.next" /></button>
                </div>
            </div>

            <div data-step="4">
                <h3><fmt:message key="steps.addressAndDate" /></h3>
                <div class="form-section form-section--columns">
                    <div class="form-section--column">
                        <h4><fmt:message key="steps.pickupAddress" /></h4>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.street" /> <form:input path="street" /> </label>
                        </div>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.city" /> <form:input path="city"/> </label>
                        </div>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.zipCode" /> <form:input path="zipCode" /> </label>
                        </div>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.phone" /> <form:input path="phone" /> </label>
                        </div>
                    </div>
                    <div class="form-section--column">
                        <h4><fmt:message key="steps.pickupDate" /></h4>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.date" /> <form:input type="date" path="pickUpDate" min="${now}"/> </label>
                        </div>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.time" /> <form:input type="time" path="pickUpTime"/> </label>
                        </div>
                        <div class="form-group form-group--inline">
                            <label> <fmt:message key="steps.comment" /> <form:textarea rows="5" path="pickUpComment"/> </label>
                        </div>
                    </div>
                </div>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step"><fmt:message key="button.back" /></button>
                    <button type="button" class="btn next-step"><fmt:message key="button.next" /></button>
                </div>
            </div>

            <div data-step="5">
                <h3><fmt:message key="steps.summary" /></h3>
                <div class="summary">
                    <div class="form-section">
                        <h4><fmt:message key="steps.youGive" /></h4>
                        <ul>
                            <li>
                                <span class="icon icon-bag"></span>
                                <span class="summary--quantity"></span>&nbsp;<fmt:message key="steps.bagsFromCategory" />
                            </li>
                            <li>
                                <span class="icon"></span>
                                <span class="summary--categories"></span>
                            </li>
                            <li>
                                <span class="icon icon-hand"></span>
                                <span class="summary--text"><fmt:message key="steps.forFoundation" /></span>
                                <span class="summary--institution"></span>
                            </li>
                        </ul>
                    </div>

                    <div class="form-section form-section--columns">
                        <div class="form-section--column">
                            <h4><fmt:message key="steps.pickupAddress" /></h4>
                            <ul>
                                <li class="summary--street"></li>
                                <li class="summary--city"></li>
                                <li class="summary--zipcode"></li>
                                <li class="summary--phone"></li>
                            </ul>
                        </div>
                        <div class="form-section--column">
                            <h4><fmt:message key="steps.pickupDate" /></h4>
                            <ul>
                                <li class="summary--pickUpDate"></li>
                                <li class="summary--pickUpTime"></li>
                                <li class="summary--pickUpComment"></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step"><fmt:message key="button.back" /></button>
                    <button type="submit" class="btn"><fmt:message key="button.confirm" /></button>
                </div>
            </div>
        </form:form>
    </div>
</section>


<%@ include file="elements/footer.jsp" %>
