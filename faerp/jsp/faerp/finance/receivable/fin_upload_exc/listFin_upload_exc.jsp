<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.finance.receivable.finincoming.finincoming_resource" prefix="rayoo.finance.receivable.finincoming.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_upload_err'/></title>
<script language="javascript">
    function clickSearch() {
        $id("dc_exception").reload();
    }
</script>
</head>
<body>

<form name="form" id="datacell_formid" method="post" action="<%=request.getContextPath()%>/Fin_upload_excAction.do">
<input type="hidden" name="cmd" value="queryAll">
<div id="right" style="height: 390px;">
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
	    <td/>
		<td/>
		<td></td>
	    <td/>
	</tr>
	<tr>
	   <td align="right"><fmt:message key='inc_code'/></td>
	   <td align="left">
	    <input type="text" class="text_field" name="inc_code" value="${inc_code }" />
	   </td>
	   <td align="right"><fmt:message key='upload_date'/></td>
        <td align="left">
            <w:date name="upload_date_from" style="width:70px" format="yyyy-MM-dd"/> <fmt:message key='inc_date_to'/> <w:date name="upload_date_to" style="width:70px"  format="yyyy-MM-dd"/>
        </td>
        <td align="right"></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='upload_user'/></td>
		<td align="left">
			<input type="text" class="text_field" name="upload_user" value="<%=LoginHelper.getLoginName(request)%>"/>
		</td>
		<td align="right"></td>
        <td align="left">
            <input name="button_ok" class="icon_1" type="button" value="<fmt:message key='button_query'/>" onclick="clickSearch();">
        </td>
		<td align="right"></td>
	</tr>
</table>
</div>		
<div id="ccParent1" class="button"> 
<div class="button_right">
	<ul></ul>
</div>
<div class="clear"></div>			
</div>
 
    <div style="padding: 0 0 8 8;">
        <r:datacell
            id="dc_exception"
            paramFormId="datacell_formid"
            queryAction="/FAERP/Fin_upload_excAction.do?cmd=queryAll"
            submitAction="#"
            width="98%"
            height="318px"
            xpath="Fin_upload_excVo"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="inc_code" messagekey="inc_code" width="90px;"/>
            <r:field fieldName="inc_cust_name" messagekey="inc_cust_name" width="200px;"></r:field>
            <r:field fieldName="inc_date" messagekey="inc_date"  allowModify="false"  width="140px;">
                <w:date format="yyyy-MM-dd HH:mm:ss"/>
            </r:field>
            <r:field fieldName="inc_amout" messagekey="inc_amout"></r:field>
            <r:field fieldName="exc_message" messagekey="exc_message" width="280px;"  allowModify="false">
            </r:field>
            <r:field fieldName="upload_user" messagekey="upload_user"></r:field>
            <r:field fieldName="upload_date" messagekey="upload_date" width="140px;" allowModify="false">
                <w:date format="yyyy-MM-dd HH:mm:ss"/>
            </r:field>
        </r:datacell>
    </div>
 
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
