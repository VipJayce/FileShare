<%@ taglib uri="http://taglib.gapext.com/tags/html" prefix="h"%>
<%@ taglib uri="http://taglib.gapext.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://taglib.gapext.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://taglib.gapext.com/tags/richweb" prefix="r"%>
<%@ taglib uri="http://taglib.gapext.com/tags/dict" prefix="d"%>
<%@ taglib uri="http://taglib.gapext.com/tags/webcomp" prefix="w"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<h:css href="/common/theme/style-sys.css"></h:css>
<script type="text/javascript">
	var contextPath = "<%=request.getContextPath()%>"; // you should define the contextPath of web application
	var EOSDEBUG = false;
</script>
    <logic:notEmpty  name="local_in_sesson_key" scope="session">
        <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
    </logic:notEmpty>
<h:script src="/common/javascripts/message.js" i18n="true" ></h:script>
<h:css href="/common/skins/skin0/theme/style-component.css"></h:css>
<h:script src="/common/skins/skin0/scripts/resource.js"></h:script>

<h:script src="/common/javascripts/ge-web.js"></h:script>
<h:script src="/common/lib/mootools.js"></h:script>
<h:script src="/js/common/backspace_forbid.js"/>
<h:script src="/js/common/taxGenerate.js"/>
<h:script src="/js/common/big.min.js"/>
