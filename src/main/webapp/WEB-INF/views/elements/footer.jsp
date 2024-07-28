<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<footer>
    <div class="contact" id="contact">
        <h2><fmt:message key="footer.contactUs" /></h2>
        <h3><fmt:message key="footer.contactForm" /></h3>
        <form method="post" action="/contact" class="form--contact">
            <div class="form-group form-group--50">
                <fmt:message key="footer.firstName" var="placeholderFirstName"/>
                <input type="text" name="name" placeholder="${placeholderFirstName}"/>
            </div>
            <div class="form-group form-group--50">
                <fmt:message key="footer.lastName" var="placeholderLastName"/>
                <input type="text" name="surname" placeholder="${placeholderLastName}"/>
            </div>
            <div class="form-group">
                <fmt:message key="footer.message" var="placeholderMessage"/>
                <textarea name="message" placeholder="${placeholderMessage}" rows="1"></textarea>
            </div>
            <button class="btn" type="submit"><fmt:message key="footer.send" /></button>
        </form>
    </div>
    <div class="bottom-line">
        <span class="bottom-line--copy">Copyright &copy; 2018</span>
        <div class="bottom-line--icons">
            <a href="#" class="btn btn--small"><img src="<c:url value="resources/images/icon-facebook.svg"/>"/></a>
            <a href="#" class="btn btn--small"><img src="<c:url value="resources/images/icon-instagram.svg"/>"/></a>
        </div>
    </div>
</footer>

<script src="<c:url value="resources/js/app.js"/>"></script>
</body>
</html>
