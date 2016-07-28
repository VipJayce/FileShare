<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="java.util.List"%>
<%@ page import="rayoo.sales.pbcustomerservice.vo.PbcustomerserviceVo"%>
<%@ page
	import="rayoo.sales.pbcustomerservice.util.IPbcustomerserviceConstants"%>
<%@ page import="gap.authority.helper.OrgHelper"%>
<%String  servicecompany=request.getAttribute("servicecompany")==null?"":request.getAttribute("servicecompany").toString(); 
System.out.println("@@@@@@@@@@@@@@@@@"+servicecompany);
%>
<html>
<fmt:bundle basename="rayoo.salse.pbcustomerservice.pbcustomerservice_resource" prefix="rayoo.salse.pbcustomerservice.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
   
    function sendSubmit(){
        var ids = document . getElementById ("checkbox1").value;
        if(ids == null){
            alert("<fmt:message key="not_send_contract"/>");
            return;
        }
        if(!checkData()){
            return;
        }
        //alert(ids);
       // return;
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?uid=111&ids=" + ids 
            +"&flag="+"<%=request.getAttribute("flag")%>";
        form.cmd.value = "submit";
        form.submit();
    }
   
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleQuery";
        form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/sales/pbcustomerservice/insertPbcustomerservice.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }
    
    function pushSelectName(slt,sltObj){
    	var name = sltObj.id + "_name";
    	document.getElementById(name).value = sltObj.getText();
    }
    
    //datacell1 checkbox begin
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox1' id='checkbox1' value='" + entity.getProperty("id") + "$"+entity.getProperty("customer_id")+"$" + entity.getProperty("company_id") + "'>";
       return returnStr;
    }
    function checkAllList(all){
    	if(all.checked){
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= true;
	            }
	        } 
	    }else{
	    	var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= false;
	            }
	        } 
	    }
    }
    
    function changeCheck(rowNo,box){
    	
    }
    
  	// end
    
</script>
	</head>
	<body>

	<form name="form" method="post"
		action="<%=request.getContextPath()%>/PbcustomerserviceAction.do">
	<input type="hidden" name="cmd" value="queryAll">
	
   <%   String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();%>
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >


	<div id="right"><script language="javascript">
    writeTableTopFesco('<fmt:message key="allot_review"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">


	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">


	</table>
	</div>
    <div style="margin-left: 10px;">
	<r:datacell id="celllist1"
	queryAction="/FAERP/PbcustomerserviceAction.do?cmd=simpleQuery&queryCondition=${requestScope.queryCondition}"
	paramFormId="form" width="99%" height="280px"
	xpath="SalcontractVo" readonly="true">
	<r:toolbar location="bottom" tools="nav,pagesize,info"/>
	<r:field allowModify="false" fieldName="id" sortAt="none"
		label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
		width="45px" onRefreshFunc="setCheckboxStatus">
	</r:field>
	<r:field fieldName="customer_name" messagekey="customer_name" width="180px">
        <h:text />
    </r:field>
	<r:field fieldName="contract_code" messagekey="contract_code" width="120px">
		<h:text />
	</r:field>
	<r:field fieldName="contract_name" messagekey="contract_name" width="230px">
		<h:text />
	</r:field>
	<r:field fieldName="contract_start_date" messagekey="contract_start_date" width="90px">
		<w:date format="yyyy-MM-dd"/>
	</r:field>
	<r:field fieldName="str" messagekey="str_status" width="120px">
		<h:text />
	</r:field>
	<r:field fieldName="create_type_bd" messagekey="create_type" width="70px">
        <d:select dictTypeId="CREATE_TYPE_BD"></d:select>
	</r:field>
	<r:field fieldName="contract_type_bd" messagekey="contract_type" width="100px">
        <d:select dictTypeId="CONTRACT_TYPE_BD"></d:select>
	</r:field>
	<r:field fieldName="create_user_name" messagekey="create_user_name" width="100px">
		<h:text />
	</r:field>
	<r:field fieldName="create_date" messagekey="create_date" width="180px">
		<h:text />
	</r:field>
	</r:datacell>
	</div>
	</div>
	<div class="xz_title" style="margin: 10px;"><fmt:message key="allot_person"/> </div>
	
	<div style="display: none" id="tr00_id">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="employee_relations_person"/></td>
			<td width="220">
             <r:comboSelect id="cus00" name="cus00"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=3"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus00_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>
	
	<div style="display: none" id="tr001_id">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_service_dept_id"/></td>
			<td width="220">
             <r:comboSelect id="cus001" name="cus001"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmpForDept&jibangren=${servicecompany}"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus001_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>
	
	<div id="tr01_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_service_name"/></td>
			<td width="220">
             <r:comboSelect id="cus01" name="cus01"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmpForOpter&jibangren=1"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus01_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>

	<div id="tr02_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_service_name"/></td>
			<td width="220">
             <r:comboSelect id="cus02" name="cus02"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus02_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>

	<div id="tr08_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="retired_workers_person"/></td>
			<td width="220">
             <r:comboSelect id="cus08" name="cus08"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=4"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus08_name" value="">
			</td>
	</table>
	</div>
	</div>
	
	<div id="tr07_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">		
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="social_security_name"/></td>
			<td width="220">
             <r:comboSelect id="cus07" name="cus07"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=5"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus07_name" value="">
			</td>
	</table>
	</div>
	</div>
	
	<div id="tr06_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="public_security_name"/></td>
			<td width="220">
             <r:comboSelect id="cus06" name="cus06"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=6"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus06_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>

	<div id="tr03_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="pm_manage"/></td>
			<td width="220">
             <r:comboSelect id="cus03" name="cus03"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getPositionUser&postion_type=pmzg"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus03_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>


	<div id="tr04_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span>PM</td>
			<td width="220">
             <r:comboSelect id="cus04" name="cus04"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=7"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                >
            </r:comboSelect>
            <input type="hidden" name="cus04_name" value="">
			</td>
		</tr>
	</table>
	</div>
	</div>

	<div id="tr05_id" style="display: none">
	<div class="box_tab" style="margin: 10px;">
	<table width="98%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><span class="style_required_red">* </span>Share Center</td>
			<td width="220">
             <r:comboSelect id="cus05" name="cus05"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=8"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose"
                onChangeFunc="pushSelectName"
                
                >
            </r:comboSelect>
            <input type="hidden" name="cus05_name" value="">
			</td>

		</tr>
	</table>
	</div>
	</div>



	<div class="foot_button"><input type="button" class="foot_icon_1"
		value="<fmt:message key="save"/>" onclick="sendSubmit()" /></div>


	</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">

<%  //表单回写
    if(request.getAttribute(IPbcustomerserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPbcustomerserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>

	var flag = "${flag}";
	var apprstate = "${apprstate}";
	
	if(flag == '00'){
		//if(apprstate=='1'){
			//document.all.tr001_id.style.display="block";
		//}
		document.all.tr00_id.style.display="block";
	}
	if(flag == '01')document.all.tr01_id.style.display="block";
	if(flag == '02')document.all.tr02_id.style.display="block";
	if(flag == '03')document.all.tr03_id.style.display="block";
	if(flag == '04')document.all.tr04_id.style.display="block";
	if(flag == '05')document.all.tr05_id.style.display="block";    　
	if(flag == '06')document.all.tr06_id.style.display="block";    　
	if(flag == '07')document.all.tr07_id.style.display="block";    　
	if(flag == '08')document.all.tr08_id.style.display="block";    　
  
  function checkData(){
  			
  	if(flag == '00'){
		if(apprstate=='4'){
		   if($id("cus001").getValue()==""){
                alert("<fmt:message key="choose_customer_service_dept"/>");
                return false;
               }
		}
		if($id("cus00").getValue()==""){
		    alert("<fmt:message key="choose_employee_relations"/>");
			return false;
		}
	}
	if(flag == '01'){
		if($id("cus01").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '02'){
		if($id("cus02").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '03'){
		if($id("cus03").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '04'){
		if($id("cus04").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '05'){
		if($id("cus05").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '06'){
		if($id("cus06").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '07'){
		if($id("cus07").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
	if(flag == '08'){
		if($id("cus08").getValue()==""){
		    alert("<fmt:message key="xinghao_not_null"/>");
			return false;
		}
	}
         
         
         return true;
  }
</script>
