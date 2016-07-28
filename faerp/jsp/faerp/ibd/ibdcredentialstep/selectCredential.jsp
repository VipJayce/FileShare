<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.ibd.ibdcredentialstep.ibdcredentialstep_resource" prefix="rayoo.ibd.ibdcredentialstep.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
    function showListData(){
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function toOK_onClick() {
        var dc = $id("datacell2");
        var itemCount =  dc.getCurrentRowCount();
        var str = "";
        dc.selectFirstRow(); 
        var datacellValue = "";
        
        var returnAry = new Array();
        for(var i=0;i<itemCount;i++){
            var activeTr = dc.getActiveRow();
            var activeEntity = dc.getActiveEntity();
            
            if(jQuery(activeTr).find('input').is(":checked")){
                returnAry[0] = activeEntity.getProperty("id");
                returnAry[1] = activeEntity.getProperty("credentials_name");
                break;
            } 
            dc.selectNextRow();
        }
        if (returnAry.length == 0){
            alert("<fmt:message key='select_one_record' />");
            return;
        }
        window.returnValue = returnAry;
        window.close();
    }
    
    function setRadioboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' name='radiobox_template' value='"+value+"'>";
    }
    
</script>
	</head>
	<body>

	<form name="form" method="post" id="credentiual_formid">

	<div id="right">
	<div class="ringht_s">


	<div id="ccChild0" class="search">
	<table width="90%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="175" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key='Query_conditions' /></div>
			</td>
		</tr>
		<tr>
			<td align="right">
			    <fmt:message key='credentiual_name' />
			</td>
			<td align="left"><input type="text" class="text_field" name="credentiual_name" inputName="证件名称" /></td>
	    </tr>
        <tr>
			<td align="center" colspan="2">
				<input name="button_ok2" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()"> 
				<input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
			</td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="g"><a onClick="javascript:toOK_onClick();"><fmt:message key='confirm' /></a></li>
	</ul>
	</div>
	<div class="clear"></div>
	</div>

	<div style="padding: 8 10 8 8;"><r:datacell id="datacell2"
		queryAction="/FAERP/IbdCredentialStepAction.do?cmd=getAllCredential"
		width="95%" xpath="CredentialsTypeVo"
		paramFormId="credentiual_formid" readonly="true"
		pageSize="999">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="id" messagekey="Operation" width="50px" sortAt="none" onRefreshFunc="setRadioboxStatus" align="center">
		</r:field>
		<r:field fieldName="credentials_name" messagekey="credentiual_name" width="300px">
		</r:field>
	</r:datacell></div>

	</div>
	</div>
	</form>
</fmt:bundle>
<script type="text/javascript">
</script>
</body>
</html>
