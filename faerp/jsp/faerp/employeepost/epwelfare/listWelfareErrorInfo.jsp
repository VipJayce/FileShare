<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
            //导出
             function exportExcel_onClick()
             {
                var form= document.getElementById("datacell_formid");
                form.action="<%=request.getContextPath()%>/EpwelfareAction.do" ;
                form.cmd.value = "exportErrorWelfareInfoExcel";
                form.submit();
             }
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.employeepost.epwelfare.epwelfare_resource" prefix="rayoo.employeepost.epwelfare.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_upload_err'/></title>
</head>
<body>

<form name="form" id="datacell_formid" method="post" action="<%=request.getContextPath()%>/EpwelfareAction.do">
<input type="hidden" name="cmd" value="queryWelfareErrorInfo">
<div id="right" style="height: 390px;">
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="right"></td>
        <td align="left">
          <input type="button" class="icon_1" value="<fmt:message key="export"/>"    onclick="exportExcel_onClick();" >
        </td>
        <td align="right"></td>
    </tr>
</table>
</div>      
<div id="ccParent1" class="button"> 
<div class="button_right">
	<ul>
	</ul>
</div>
<div class="clear"></div>			
</div>
    <div style="padding: 0 0 8 8;">
        <r:datacell
            id="dc_exception"
            paramFormId="datacell_formid"
            queryAction="/FAERP/EpwelfareAction.do?cmd=queryWelfareErrorInfo"
            submitAction="#"
            width="98%"
            height="318px"
            xpath="ErrorEpwelfareVo"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="error_info" messagekey="error_info" width="180px;" allowModify="false">
            </r:field>
            <r:field fieldName="product_name" messagekey="fuli_product" width="120px;"  allowModify="false" />
            <r:field fieldName="emp_name" messagekey="emp_name" width="100px;"  allowModify="false" ></r:field>
            <r:field fieldName="emp_code" messagekey="emp_code"  allowModify="false"  width="100px;">
            </r:field>
            <r:field fieldName="remark" messagekey="remark" width="180px;"></r:field>
            <r:field fieldName="enjoy_month" messagekey="enjoy_month" width="100px;"  allowModify="false">
            </r:field>
            <r:field fieldName="enjoy_num" messagekey="enjoy_num" width="100px;"></r:field>
            <r:field fieldName="enjoy_money" messagekey="enjoy_money" width="100px;" allowModify="false">
            </r:field>
              <r:field fieldName="user_name" messagekey="user_name" width="100px;" allowModify="false">
            </r:field>
            <r:field fieldName="send_status" messagekey="send_status" width="100px;" allowModify="false">
            </r:field>
               <r:field fieldName="input_date" messagekey="input_date1" width="100px;" allowModify="false">
            </r:field>
        </r:datacell>
    </div>
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
