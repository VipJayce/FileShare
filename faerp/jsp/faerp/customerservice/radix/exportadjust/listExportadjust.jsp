<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
String year =  request.getAttribute("year").toString();

%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.exportadjust.exportadjust_resource" prefix="rayoo.customerservice.radix.exportadjust.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    //已作废
    function findadjusttask(){
        var data = window.showModalDialog('<venus:base/>/AdjustTaskAction.do?cmd=findAdjustTask&task_status_bd=0&backFlag=true&date='+new Date(),'','dialogHeight:500px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        document.getElementById('adjust_task_id').value = data[0];
        document.getElementById('adjust_task_name').value = data[1]
    }
    //已作废
    function findcustomer(){
        var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:500px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        document.getElementById('customer_id').value = data[0];
        document.getElementById('customer_name').value = data[2]
    }
    
    //调整任务选择回调函数
    function rtnFuncTask(arg){
        var lookup = $id("adjust_task_id");
        lookup.value = arg[3];
        lookup.displayValue = arg[1];
        document.getElementById('group_ids').value = arg[0];
        document.getElementById('year').value = arg[2];
        document.getElementById('order_year').value = arg[2];
        return false;
    }
    
    //客户选择回调函数
    function rtnFuncCust(arg){
        var lookup = $id("customer_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        document.getElementById('customer_code').value = arg[1];
        return false;
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        document.getElementById('customer_code').value = arg[1];
        //jQuery("#customer_id").val(arg[0]);        
        return false;
    }
    
    function simpleQuery_onClick(){
        var adjust_task_id = document.getElementById('adjust_task_id').value;
        if(adjust_task_id == null || adjust_task_id == ''){
            alert('<fmt:message key="please_choose_adjust_task"/>');
            return;
        }
        var mouth = document.getElementById('mouth').value;
        if(mouth == null || mouth == ''){
            alert('<fmt:message key="please_choose_month"/>');
            return;
        }
        var customer_code = document.getElementById('customer_code').value;
        var customer_name = document.getElementById('customer_name').value;
        if(customer_code == null || customer_code == ''){
            if(customer_name == null || customer_name== ''){
                 if(confirm('<fmt:message key="are_you_sure"/>')) { 
                     $id("datacell1").loadData();
                     $id("datacell1").refresh();
                 }
            }else{
                $id("datacell1").loadData();
                $id("datacell1").refresh();
            }
        }else{
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
    function export_onClick(){
        form.action="<%=request.getContextPath()%>/ExportadjustAction.do?cmd=exportExecl2&backFlag=true";
        form.submit();
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="export_adjust_task_info"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="10" rowspan="5" style="padding-top:0;"></td>
    </tr>
	<tr>
		<td align="left"><span class="style_required_red">* </span><fmt:message key="adjust_task"/></td>
		<td align="left">
		    <w:lookup onReturnFunc="rtnFuncTask" readonly="true" id="adjust_task_id" displayValue=""   name="adjust_task_id" lookupUrl="faerp/customerservice/radix/adjusttask/findAdjustTask.jsp" messagekey="choose_adjust_task" height="440" width="600" style="width:170px">
            </w:lookup>
			<input type="hidden" name="group_ids" id="group_ids"/>
		</td>
		<td align="left"><fmt:message key="order_query_years"/></td>
        <td align="left">
            <input type="hidden" name="year" value="">
            <input type="text" class="text_field" disabled="disabled" id="order_year" name="order_year" inputName="订单查询年度" maxLength="50"/>
        </td>
        <td align="left"><span class="style_required_red">* </span><fmt:message key="order_query_month"/></td>
        <td align="left">
            <div  class='select'> <div>
            <select name="mouth" id="mouth">
            <option value=""><fmt:message key="please_choose"/></option>
                <%
                for(int i=1;i<=12;i++){
                    %>
                    <option value="<%=i <10?"0"+i:i%>"><%=i<10?"0"+i:i %><fmt:message key="month"/></option>
                    <%
                }
                %>
            </select>
        </td>
	</tr>
	<tr>
        <td align="left"><fmt:message key="cust_code"/></td>
        <td align="left">
            <input type="text" class="text_field" name="customer_code" id="customer_code"  inputName="客户编号" maxLength="50"/>
        </td>
        <td align="left"><fmt:message key="cust_name"/></td>
        <td align="left">
            <!--<w:lookup onReturnFunc="rtnFuncCust" readonly="false" id="customer_id" displayValue=""   name="customer_id" lookupUrl="faerp/common/customer/listCustomerByCondition.jsp" dialogTitle="选择客户" height="440" width="600" style="width:170px"></w:lookup>-->
            <w:lookup name="customer_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_cust" height="440" width="600"  style="width:195px"/>
            
        </td>
        <td align="left"><fmt:message key="security_unit_id"/></td>
        <td align="left">
            <faerp:SoialunitSelectTag  tagname="security_unit_id" beanname="security_unit_id"/>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="user_name"/></td>
        <td align="left">
            <input type="text" class="text_field" name="name" inputName="客服" maxLength="50"/>
        </td>
        <td align="left"><fmt:message key="is_prochange"/></td>
        <td align="left">
            <input type="radio" name="prochange" value="1"/><fmt:message key="yes"/>
            <input type="radio" name="prochange" value="0" checked="checked"/><fmt:message key="no"/>
        </td>
        <td align="left">是否导出原基数</td>
        <td align="left">
            <input type="radio" name="isoldbase" value="1"/><fmt:message key="yes"/>
            <input type="radio" name="isoldbase" value="0" checked="checked"/><fmt:message key="no"/>
        </td>
   </tr>
   <tr>
        <td align="center" colspan="6">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
        </td>
    </tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
					<li class="e"><a  onClick="javascript:export_onClick();">导出 </a> </li>
				</ul>
		 -->
		  <input class="e" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="dctzmd_exp" type="1"/>  onClick="export_onClick();">
		 </div>
           <div class="clear"></div>			
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/ExportadjustAction.do?cmd=searchExportadjust"
        width="98%"
        height="318px"
        xpath="ExportadjustVo"
        submitXpath="ExportadjustVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>           
      <r:field fieldName="emp_code"  messagekey="emp_code" sortAt="server">
      </r:field>
      <r:field fieldName="emp_name" messagekey="emp_name" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="id_card" messagekey="id_card" allowModify="false" sortAt="server">
      </r:field>
      <r:field fieldName="customer_code" messagekey="cust_code" sortAt="server">
      </r:field>
      <r:field width="250" fieldName="customer_name" messagekey="cust_name" sortAt="server">
      </r:field>
      <r:field fieldName="newbase" messagekey="new_base" sortAt="server">
      </r:field>
      <r:field fieldName="security_unit_id" messagekey="security_unit_id" sortAt="server" allowModify="false">
                            <r:comboSelect id="com2" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                nullText="">
                            </r:comboSelect> 
      </r:field>
      <r:field fieldName="name" messagekey="user_name" sortAt="server">
      </r:field>
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

