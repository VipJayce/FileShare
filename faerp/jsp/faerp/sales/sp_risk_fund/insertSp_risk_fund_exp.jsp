<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.sp_risk_fund_exp.vo.Sp_risk_fund_expVo" %>
<%@ page import="rayoo.sales.sp_risk_fund_exp.util.ISp_risk_fund_expConstants" %>
<%  //判断是否为修改页面
    Sp_risk_fund_expVo resultVo = null;  //定义一个临时的vo变量
    AttachmentfileVo avo=null;//附件VO
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        
    }
    if(request.getAttribute(ISp_risk_fund_expConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (Sp_risk_fund_expVo)request.getAttribute(ISp_risk_fund_expConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
    if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
        avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
    }
    EmployeeVo employeeVo = new EmployeeVo();
    if(request.getAttribute("employeeVo") != null) {  //如果request中取出的bean不为空
        employeeVo = (EmployeeVo)request.getAttribute("employeeVo");  //从request中取出vo, 赋值给resultVo
    }
    String attachName = avo==null?"":avo.getAttachment_file_name().toString();
    String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
    
    
    boolean wfShow = false;
    if(request.getParameter("wfShow") != null){
        wfShow = true;
    }
%>
<%@page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo"%>
<html>
<fmt:bundle basename="rayoo.salse.sp_risk_fund.sp_risk_fund_resource" prefix="rayoo.salse.sp_risk_fund.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">


//打印支出凭证
function printRepot_onClick(){
    
    window.location = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showRiskExpReport.jsp?reportFileName=reportRiskExp.raq" + 
    "&employeeName=<%=employeeVo.getEmp_name()%>" +
    "&employeeCode=<%=employeeVo.getEmp_code()%>" +
    "&payMessage=" + encodeURIComponent(jq("#customer_name").val() + " <fmt:message key="expenditure_risk_gold"/> ") +
    "&expMony=${bean.exp_mony}" +
    "&payee=<%=employeeVo.getEmp_name()%>";
}



    function insert_onClick(){  //插入单条数据
        
        if(checkAllForms()){
	        form.action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?cmd=insert";
	        form.submit();
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        if(checkAllForms()){
	        form.action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?cmd=update";
	        form.submit();
        }
    }

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
var form;
function checkAllForms(){
    if(form.exp_type.value=="5"){
    
        if(form.old_empoyee_id.value==""){
            alert("<fmt:message key="employee_not_null"/>");
            return false;
        }
    }
    return true;
}

jq(function(){
    form = document.getElementById("update_form");
    $id("lk_cust").onReturnFunc = function (returnValue){
        var lookup = $id("lk_cust");
        lookup.value = returnValue[0];
        lookup.displayValue = returnValue[2];
        
        jq("#customer_id").val(returnValue[0]);
        jq("#customer_code").val(returnValue[1]);
        jq("#customer_name").val(returnValue[2]);
        
        var lookup = $id("empoyee_name");
	    lookup.setValue("");
	    lookup.setDisplayValue("");
    
    
        return false;
    }
    
    change_exp_type(form.exp_type);
});
function rtnFuncEmployee(arg){
    var lookup = $id("empoyee_name");
    
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    
    jq("#empoyee_id").val(arg[0]);//emp_id
    /*
    if(arg[2] !=null &&arg[2]!=''){
        $id("emp_code").value = arg[2] ;
    }
    
    $id("emp_id_card").value = arg[3] ;
    */
    return false;
}
function rtnFuncOldEmployee(arg){
    if(arg[0] == jq("#empoyee_id").val()){
        alert("<fmt:message key="employee_same_person"/>");
    }
    var lookup = $id("old_empoyee_name");
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    
    jq("#old_empoyee_id").val(arg[0]);//emp_id
    
    return false;
}

function change_exp_type(th){
    if(th.value == "5"){
        jQuery("#old_emp").show();
    }else{
        jQuery("#old_emp").hide();
    }
    
}



//打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
    
    
</script>
</head>
<body>
<h:form checkType="keypress" name="update_form" id="update_form" method="post">
<!--blur, keypress-->
<input id="oid" name="oid" type="hidden" value="${bean.id}"/>
<input id="cmd" name="cmd" type="hidden" value=""/>
<div id="right">
    <div class="right_title_bg"><div class=" right_title"><fmt:message key="risk_capital_expenditure"/><%=wfShow ? "审批" : "" %></div></div>
    <div class="ringht_x">
    <!--表格 -->
        <div class="box_xinzeng"  style="height:210px">
        <div class="xz_title"><fmt:message key="basic_info"/></div>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
<!--          <tr>-->
<!--            <td class="td_1"><span>*</span>客户编号</td>-->
<!--            <td class="td_2"><input type="text" value="" class="xText" id="user"/></td>-->
            
<!--          </tr>-->
          <tr>
            <td class="td_1"><span>*</span><fmt:message key="customer_name"/></td>
            <td class="td_2">
                <w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust" 
                value="${bean.customer_name}" displayValue="${bean.customer_name}"
                lookupUrl="/FAERP/Sp_risk_fund_expAction.do?cmd=getAllCustomerByCondition" 
                messagekey="choose_customer" height="450" width="610" /> 
                
                
                
                <input id="customer_id" name="customer_id" type="hidden"  value="${bean.customer_id }"/>
                <input id="customer_code" name="customer_code" type="hidden"  value="${bean.customer_code }"/>
                <input id="customer_name" name="customer_name" type="hidden" value="${bean.customer_name}"/>
                
            </td>
            <td class="td_1"><span>*</span><fmt:message key="employee_name"/></td>
            <td class="td_2">
                <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="empoyee_name" name= "empoyee_name"  validateAttr="allowNull=false;"
                value="${bean.empoyee_name }" displayValue="${bean.empoyee_name}" 
                lookupUrl="/Sp_risk_fund_expAction.do?cmd=searchEmployeeToList"  messagekey="choose_employee" height="450" width="800"  style="width:170px">
                    
                </w:lookup>
                <input type="hidden" id="empoyee_id" name="empoyee_id" value="${bean.empoyee_id }">
<script type="text/javascript">

jq(function(){

	function beforeOpenEmp(lookup){
	    if(!jq("#customer_code").val()){
	       alert("<fmt:message key="please_choose_customer"/>");
		   return false;
	    }
	    lookup.params = [];
	    var customer_id=jq("#customer_id").val();
	    lookup.addParam("customer_id",customer_id);
	    
	    var customer_code=jq("#customer_code").val();
	    lookup.addParam("customer_code",customer_code);
	    return true;
	}
	
	$id("empoyee_name").beforeOpenDialog= beforeOpenEmp;
	$id("old_empoyee_name").beforeOpenDialog= beforeOpenEmp;
	

});
</script>
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="exp_type"/></td>
            <td class="td_2">
                
                <d:select name="exp_type" value="${bean.exp_type }" dictTypeId="SP_EXP_TYPE" onchange="change_exp_type(this);"
                extAttr="validateAttr='allowNull=false'"
              nullLabel="请选择" style="width:170px"/>
                
            </td>
            <td class="td_1"><fmt:message key="exp_money"/></td>
            <td class="td_2">
                <h:text name="exp_mony" value="${bean.exp_mony }" validateAttr="allowNull=false;type=double;fracDigit=2" styleClass="xText"/>
            
            </td>
          </tr>
          <tr id="old_emp" style="display: none;">
            <td class="td_1"><fmt:message key="for_the_gang"/></td>
            <td colspan="3" class="td_2">
                <w:lookup onReturnFunc="rtnFuncOldEmployee" readonly="true" id="old_empoyee_name" name= "old_empoyee_name"  validateAttr="allowNull=true;"
                value="${bean.old_empoyee_name }" displayValue="${bean.old_empoyee_name}" 
                lookupUrl="/Sp_risk_fund_expAction.do?cmd=searchEmployeeToList"  messagekey="choose_employee" height="450" width="800"  style="width:170px"/>
                
                <input type="hidden" id="old_empoyee_id" name="old_empoyee_id" value="${bean.old_empoyee_id }">
                
            </td>
          </tr>
<!---->
        <%
        
        if(wfShow){
        %>
          <tr>
            <td class="td_1"><fmt:message key="individual_risk_ratio"/></td>
            <td class="td_2">
                ${thisExpInScale }
            </td>
            <td class="td_1"><fmt:message key="expbyinscale"/></td>
            <td class="td_2">
                
                ${expByInScale }
            </td>
          </tr>
        <%} %>
<!---->
          <tr>
            <td class="td_1"><fmt:message key="remarks"/></td>
            <td class="td_2">
                <h:textarea name="remark" value="${bean.remark }"  validateAttr="maxLength=100" cols="41" rows="3"/>
            </td>
            <td class="td_1"> <fmt:message key="attachments"/></td>
            <td class="td_2">
            <%
	        
	        if(!wfShow){
	        %>
                <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" 
                value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachName)%>" hiddenInputId="attach_name"/>
                
                <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
                
                <input type="hidden" id="attackAddressInput" name="attach_address" value="<%//=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>">
<!--                <input type="hidden" id="attackAddressInput" name="attach_address" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>">-->
                <input type="hidden" id="attachment_id" name="attachment_id" value="${bean.attachment_id }">

	        <%} %>
	        
             <%if(StringUtils.isNotBlank(attachAddress)) {%>
                <a target="_blank" href="<%=request.getContextPath()%>/upload/dialog/<%=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>">查看</a>
            <%} else { %>
	        <%} %>
            </td>
            
            
          </tr>
          </table>

        </div>
    <!--表格 end-->
    <div style = "text-align: center;">
        <%
        
        if(wfShow){
        %>
            <input id="taskuid" name="taskuid" type="hidden"  value="${taskuid }"/>
            <input type="button" class="icon_2" value="<fmt:message key="approved"/>" onclick="javascript:appOperate_onClick();"/>
            <input type="button" class="icon_2" value="<fmt:message key="not_approved"/>" onclick="javascript:update_onClick();"/>
            
            <input type="button" class="icon_2" value="<fmt:message key="print_receipts"/>" onclick="javascript:printRepot_onClick();"/>
            
        <%} else {%>
            <input type="button" class="icon_2" value="<fmt:message key="save"/>" onclick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>"/>
        <%} %>
        
        
        <input type="button" class="icon_2" value="<fmt:message key="go_back"/>" onclick="location.href='javascript:history.go(-1);'"/>
        </div>
    </div>
 
        

</div>





</h:form>

</fmt:bundle>
<script type="text/javascript">


// 审批操作
var wfShow = <%=wfShow%>;
jq(function(){
    if(wfShow == true){
        jq("[name=exp_type]").attr("disabled",true);
        jq("[name=exp_mony]").attr("readonly",true);
        jq("[name=remark]").attr("readonly",true);
    }else{
    }
});

function appOperate_onClick() {
    var message = addAppReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
        
    form.action = "<venus:base/>/Sp_risk_fund_expAction.do?message=" + message[0]
            + "&_ts=" + (new Date()).getTime();
    document.getElementById("cmd").value = "appOperate";

    form.submit();

}

// 驳回操作
function backOperate_onClick() {
    // 驳回原因
    var message = addBackReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
    var url = "<%=request.getContextPath()%>/Sp_risk_fund_expAction.do?date=" + new Date();
    form.action = url;
    document.getElementById("info_msg").value = message[0];
    document.getElementById("cmd").value = "backOperate";
    form.submit();

}

// 撤销操作
function cancelOperate_onClick() {
    // 驳回原因
    var message = addBackReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
    form.action = "<venus:base/>/SalcontractAction.do?message=" + message[0];
    document.getElementById("cmd").value = "cancelOperate";
    form.submit();
}
</script>
</body>
</html>

