<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
%>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css" rel="stylesheet" charset='UTF-8'>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<title>列表模板</title>
<script>
	jQuery().ready(function($){
		$("#idclient").change(function(){
		     alert(this.value);
			 window.location="<venus:base/>/jsp/dd/template/masterdetail/list.jsp?moduleName=员工信息维护(多表)&tableView=EMPLIST&detailView=EMPEDIT&queryView=EMPQUERY&toolView=EMPTOOL&multiTenant=true&client="+this.value;		     
		})
	});	
</script>
</head>
<body>
<dd:refControl type="8"  refSource="CLIENT" printLabel="false" keySource="0"   dispValue="hehe"  label="复杂参照"   name='client' id='client' />
</body>
</html>
