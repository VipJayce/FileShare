<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page
	import="rayoo.certificate.certificateTransaction.util.ICertificateTransactionConstants"%>
<html>
<fmt:bundle
	basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
	prefix="rayoo.certificate.credentialsTranImportErrorMsg.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key="view" /></title>
	<script language="javascript">
	var _jQuery = window.jQuery, _$ = window.$;
    jQuery.noConflict();
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}

    //导出查询数据
    function exp_onClick() {
        form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do";
        form.cmd.value = "exportCredentialsTranImportErrorMsg";
        form.submit();
    }

    //返回
    function goback_onClick() {
        form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do";
        form.cmd.value = "queryAllCredentialsTran";
        form.submit();
    }
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid"
		action="<%=request.getContextPath()%>/CredentialsTypeAction.do">
	<input type="hidden" name="cmd" value="queryAll"> <input
		type="hidden" name="backFlag" id="backFlag" value="true"> <input
		type="hidden" name="company_id" id="company_id"
		value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">

	<div id="right"><script language="javascript">
	writeTableTopFesco("<fmt:message key='view'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">


	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">

        <!--  
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key='Query_conditions' /></div>
			</td>
			<td />
			<td />
			<td></td>
			<td />
		</tr>
		<tr>
			<td align="right"><fmt:message key='identity' /></td>
			<td align="left">
			     <input type="text" class="text_field" name="employeeNumber" inputName="唯一号" maxLength="50"/>
			</td>
			</td>
			<td align="right"><fmt:message key='employeeName' /></td>
			<td align="left">
			     <input type="text" class="text_field" name="employeeName" inputName="员工姓名" maxLength="50"/>
			</td>
			 <td align="right"><fmt:message key='employeeCardNumber' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="employeeCardNumber" inputName="证件号码" maxLength="50"/>
            </td>
		</tr>
		<tr>
            <td align="right"><fmt:message key='customerNumber' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="companyNumber" inputName="客户编号" maxLength="50"/>
            </td>
            </td>
            <td align="right"><fmt:message key='customerName' /></td>
            <td align="left">
                 <input type="text" class="text_field" name="companyName" inputName="客户名称" maxLength="50"/>
            </td>
             <td align="right"><fmt:message key='certificateSpecialist' /></td>
            <td align="left">
                 <w:lookup name="certificateTranSpecialist"  onReturnFunc="rtnFunc" id="certificateSpecialistID"  lookupUrl="/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage"  messagekey="choose_certificateSpecialist" height="440"  width="550" style="width:187px" />
            </td>
        </tr>
        <tr>
             <td align="right"><fmt:message key='cardTranTypeBD'/></td>
            <td align="left">
                <=gap.rm.tools.helper.RmJspHelper.getSelectField("credentialsTypeBdID", -1, "CREDENTIALS_TYPE", "", " id='credentialsTypeBdID' onchange=\"findType()\"'", false)%> 
            </td>
             <td align="right"><fmt:message key='credentials_name'/></td>
            <td align="left">
               <select name="cardTranType" id="cardTranType">
                        <option value=""><fmt:message key="please_choose" /></option>
                    </select>
            </td>
            <td align="right"><fmt:message key='tranState'/></td>
            <td align="left">
                <=gap.rm.tools.helper.RmJspHelper.getSelectField("tranState", -1, "BILLS_STATUS", "", " id='tranState' ", false)%>    
            </td>
        </tr>
        <tr>
            </td>
        </tr>
		<tr>
		<td align="right"><fmt:message key='customerService' /></td>
            <td align="left">
                 <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" name="commitPersonId" lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="choose_customerService" width="450" height="440"  style="width:187px" />
            </td>
			<td colspan="4" style="text-align: center;">
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"> 
				<input	name="button_reset" class="icon_1" type="button" 	value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
			</td>
		</tr>-->
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
		<input class="p_1" type="button" id="export_Data" onclick="exp_onClick();" value="导出查询数据"<au:authorityBtn code="modify_CredentTran" type="1"/>>
        <input  class="e" type="button" value='返回'  onClick="javascript:goback_onClick()"/>	</div>
	<div class="clear"></div>
	</div>

	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/CertificateTransactionAction.do?cmd=simpleQueryCredentialsTranImportErrorMsg"
		width="98%" height="303px" xpath="CredentialsTranImportErrorMsgVo" submitXpath="CredentialsTranImportErrorMsgVo"
		paramFormId="datacell_formid" readonly="true">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<!--  
		<r:field allowModify="false" fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center"></r:field>-->
        <r:field fieldName="lineNo" messagekey="lineNo" width="100px"></r:field>
        <r:field fieldName="credentialsTranId" messagekey="credentialsTranId" width="200px"></r:field>
        <r:field fieldName="msg" messagekey="msg" width="500px"></r:field>
        <r:field fieldName="create_user_name"  messagekey="create_user_name" width="150px"></r:field>
        <r:field fieldName="create_date"  messagekey="create_date" width="150px">
            <w:date format="yyyy-MM-dd" value=""/>
        </r:field>
	</r:datacell></div>
	   <!--翻页 end--> 
   
    <br>
    <div class="mx_button"></div>
    </div>
	</div>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ICertificateTransactionConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ICertificateTransactionConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>

$id("datacell1").beforeRefreshCell = function(cell,field){
        //if(field && field.fieldId && field.fieldId.indexOf("id") >= 0)
        if(field && field.fieldName && field.fieldName.indexOf("id") >= 0 && field.fieldName.indexOf("validDate") < 0) {
            return false;
        }
        return true;
    } 
</script>
