<%@ taglib uri="http://taglib.gapext.com/tags/html" prefix="h"%>
<%@ taglib uri="http://taglib.gapext.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://taglib.gapext.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://taglib.gapext.com/tags/richweb" prefix="r"%>
<%@ taglib uri="http://taglib.gapext.com/tags/dict" prefix="d"%>
<%@ taglib uri="http://taglib.gapext.com/tags/webcomp" prefix="w"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <logic:notEmpty  name="local_in_sesson_key" scope="session">
        <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
    </logic:notEmpty>