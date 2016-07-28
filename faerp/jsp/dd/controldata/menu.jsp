<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.springframework.jdbc.core.RowMapper"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="venus.frames.base.dao.BaseTemplateDao"%>
<%@ page import="venus.frames.i18n.util.LocaleHolder"%>
<%
	try {
		BaseTemplateDao dao = (BaseTemplateDao) Helper.getBean("controlDataDao");
		RowMapper rowMapper = new RowMapper() {
			public Object mapRow(ResultSet rs, int i) throws SQLException {
				Map fmap = new HashMap();
				fmap.put("id",rs.getString("id"));
				fmap.put("name",rs.getString("name"));
				fmap.put("url",rs.getString("url"));
				return fmap;
			}
		};
		List lTree = dao.query(" select a.id,a.name,b.url from dd_module a inner join dd_module_master b on a.id=b.moduleid where a.issystem='0' union select a.id,a.name,b.url from dd_module a inner join dd_module_common b on a.id=b.moduleid where a.issystem='0' union select a.id,a.name,b.url from dd_module a inner join dd_module_query b on a.id=b.moduleid where a.issystem='0' ", rowMapper);
%>
<%@ include file="../../include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="controldata.module_menu"></fmt:message></title>
<style type="text/css">
<!--
a:link {
	color: #000000;
}
a:visited {
	color: #000000;
}
a:Hover {
	text-decoration: underline;
	position: relative;
	color:#000099;
}-->
</style>
</head>
<body>
<table width="190" height="100%" border="0" cellpadding="0"	cellspacing="0" style="margin-left:5px;">
	<tr>
		<td valign="top" nowrap>
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#AFAFAF">
				<tr>
					<td valign="top" bgcolor="#F1F8FB" nowrap>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top">&nbsp;</td>
							</tr> 
							<tr>
								<td valign="top">
								<script language="javascript">
									var USETEXTLINKS = 1;
									var STARTALLOPEN = 0;
									classPath = "<%=request.getContextPath()%>/js/newtree/icon/";
									ftv2blank = "ftv2blank.gif";
									ftv2doc = "ftv2doc.gif";
									ftv2folderclosed = "ftv2folderclosed.gif";
									ftv2folderopen = "ftv2folderopen.gif";
									ftv2lastnode = "ftv2lastnode.gif";
									ftv2link = "ftv2link.gif";
									ftv2mlastnode = "ftv2mlastnode.gif";
									ftv2mnode = "ftv2mnode.gif";
									ftv2node = "ftv2node.gif";
									ftv2plastnode = "ftv2plastnode.gif";
									ftv2pnode = "ftv2pnode.gif";
									ftv2vertline = "tv2vertline.gif";
									basefrm="bodyFrame";
									//basefrm = "_blank";
								</script>
								<script src="<%=request.getContextPath() %>/js/newtree/ua.js" type=text/javascript></script>
								<script src="<%=request.getContextPath() %>/js/newtree/ftiens6.js" type=text/javascript></script>
								<script language="javascript">								
									<%
									String webConextPath = Helper.WEB_CONTEXT_PATH;
									String htmlCode = "folderTree0= gFld('&nbsp;"+LocaleHolder.getMessage("gap.dd.controldata.module_menu")+"','','diffFolder.gif','diffFolder-0.gif');\n foldersTree = folderTree0\n";
								    for(Iterator it = lTree.iterator(); it.hasNext(); ) {
								        Map fmap = (Map) it.next();
								        htmlCode += "folderTree" + (String)fmap.get("id") + " = insDoc(folderTree0, gLnk('0','&nbsp;" +  (String)fmap.get("name")+ "', encodeURI('" +  webConextPath+(String)fmap.get("url") + "'), 'ftv2link.gif'));\n";
								    }
									out.print(htmlCode);
									%>
									try {
										initializeDocument();
									} catch(e) {
									
									}
								</script>
		      					</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</fmt:bundle>
</html>
<%							
	}catch(Exception e) {
		e.printStackTrace();
	}
%>