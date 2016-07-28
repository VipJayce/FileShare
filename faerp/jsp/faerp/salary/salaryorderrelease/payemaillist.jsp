<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.salaryorderrelease.salaryorderrelease_resource" prefix="rayoo.salary.salaryorderrelease.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
function toselect_onclick() {
    $id("dc_emaillistid").reload() ;
}

function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
    if(!obj){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    return obj;
}
 //显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id' value='" + entity.getProperty("emp_id") + "' />";
}

//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
    } else {
        jQuery(":checkbox").attr("checked", false);
    }
}
//发送选中的
function sendEmail_chked(num){
	var ids = getChkedRecord();
	var batchId = $id("batchId").value;
	var clzId = $id("clzId").value;
	var ChineseOrEnglish = "Chinese";
	if(num=="2"){
		ChineseOrEnglish = "English"
	}
	if(ids){
		showProgressBar();
		jQuery.post("<%=request.getContextPath()%>/SalaryorderreleaseAction.do?cmd=sendEmailPayroll&emp_ids="+ids+"&batchId="+batchId+"&clzId="+clzId+"&ChineseOrEnglish="+ChineseOrEnglish,
		function(data){
           if(data>0){
           	hideProgressBar();
            alert("<fmt:message key='alert_email_success'/>");
            $id("dc_emaillistid").reload();
           }else{
           	hideProgressBar();
           	alert("<fmt:message key='alert_email_fail'/>,请检查邮箱是否正确");
           }
       });
	}
}
//发送所有
function sendEmail_all(num){
	jQuery(":checkbox").attr("checked", true);
	if(num=="1"){
		sendEmail_chked(1);
	}else{
		sendEmail_chked(2);
	}
}
//获得选中的记录
function getChkedRecord(){
	var ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });

    var len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return "";
    }
    return len;
}
</script>
</head>
<body>
<form name="emailformid" id="emailformid" action="" method="post">
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_email'/></div></div>
  <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="135" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div></td>
        <td width="80"><fmt:message key='emp_name'/></td>
        <td width="220"><input type="text" value="" class="sText" name="emp_name_s" id="emp_name_s"/></td>
        <td width="80"><fmt:message key='emp_code'/></td>
        <td width="220">
        <input type="text" value="" class="sText" name="emp_code_s" id="emp_code_s"/>
        <input type="hidden" value="${param.batchId }" name="batchId" id="batchId"/>
        <input type="hidden" value="${param.batchId }" name="batchid" id="batchid"/>
        <input type="hidden" value="${param.clzId }" name="clzId" id="clzId"/>
        </td>
        <td width="80"><fmt:message key='is_email'/></td>
        <td width="220">
        <select name="is_email_s" class="sSelect" id="is_email_s" >
                      <option value=""><fmt:message key='please_select'/></option>
                      <option value="1"><fmt:message key='is_email_1'/></option>
                      <option value="0" selected><fmt:message key='is_email_0'/></option>
                    </select>
                    </td>
        <td width="80">&nbsp;</td>
        <td  width="220"><input type="button" onclick="toselect_onclick()" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
      </tr>
      </table>
  </div>
    <!--查询 end-->
  <!--按钮-->
    <!--表格 -->
    <div class="" id="values_div">
      <r:datacell id="dc_emaillistid"
            queryAction="/FAERP/SalaryorderreleaseAction.do?cmd=seachSalaryOrderReleaseEmail"
            submitAction="/FAERP/SalaryorderreleaseAction.do?cmd=update"
            width="100%" xpath="SalaryorderreleaseEmailVo" submitXpath="SalaryorderreleaseEmailVo"
            pageSize="100"
            paramFormId="emailformid" height="340px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="emp_id"
              label="<input type='checkbox' name='checkall' onclick='chk_all(this)' />"
              sortAt="none" width ="30px" onRefreshFunc="showchkbox">
            </r:field>
            <r:field fieldName="emp_name" messagekey="emp_name" width="100px">
            </r:field>
            <r:field fieldName="emp_code" messagekey="emp_code" width="100px">
            </r:field>
            <r:field fieldName="customer_code" messagekey="customer_code" width="100px">
            </r:field>
            <r:field fieldName="customer_name" messagekey="customer_name" width="180px">
            </r:field>
            <r:field fieldName="email" label="email" width="180px">
            </r:field>
            <r:field fieldName="pay_year" messagekey="pay_year" width="100px">
            </r:field>
            <r:field fieldName="pay_month" messagekey="pay_month" width="100px">
            </r:field>
            <r:field fieldName="def3" messagekey="def3" width="100px">
            </r:field>
            <r:field fieldName="is_email" messagekey="is_email" width="100px">
            </r:field>
            <r:field fieldName="emial_time" messagekey="emial_time" width="100px">
            </r:field>
            <r:field fieldName="remarks" messagekey="remarks" width="150px">
            </r:field>
        </r:datacell>
	<div class="foot_button">
	  <input type="button" class="foot_icon_2" onclick="sendEmail_chked(1)" value="<fmt:message key='sendEmail_chked'/>"/>
	  <input type="button" class="foot_icon_2" onclick="sendEmail_all(1)" value="<fmt:message key='sendEmail_all'/>"/>
	  <input type="button" class="foot_icon_2" onclick="sendEmail_chked(2)" value="<fmt:message key='sendEmail_chked'/>(英文)"/>
	  <input type="button" class="foot_icon_2" onclick="sendEmail_all(2)" value="<fmt:message key='sendEmail_all'/>(英文)"/>
	</div>
    <!--翻页 end-->
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>

