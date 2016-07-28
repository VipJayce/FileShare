<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息查询</title>
<%
String kefuid = (String)request.getAttribute("kefuid");
if(kefuid==null || "".equals(kefuid)){
    kefuid = "1099100700000000105";
}
request.setAttribute("kefuid",kefuid);
%>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id_card") + "\",\"" + entity.getProperty("id_card_type_bd") + "\");>";
    }

    function findCheckbox_onClick() {  //从多选框到修改页面
        var emp_id = $id("emp_id").value;
        if(emp_id!=null&&emp_id!=""){
            $id("datacell_formid").action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=find&id="+emp_id;
            $id("datacell_formid").submit();
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function detail_onClick(){  //实现转到详细页面
        var emp_id = $id("emp_id").value;
        if(emp_id!=null&&emp_id!=""){
            $id("datacell_formid").action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=detail&id=" + emp_id;
            $id("datacell_formid").submit();
            //showModalCenter('<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=detail&id='+emp_id,window,'',950,450,"员工基本信息");
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
    }

    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //jQuery("#h_customer_name").val(arg[2]);
        return false;
    }
    //选择客服
    function rtnFuncCS(arg){
        var lookup = $id("lk_cs");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#h_user_id").val(arg[0]);
        jQuery("#h_user_name").val(arg[1]);
        return false;
    }

    function exp_onClick(){  //导出到excel
        form.action="<%=request.getContextPath()%>/FaerpEmployeeAction.do";
        form.cmd.value = "expForPPS";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/FaerpEmployeeAction.do">
 <input type="hidden" name="cmd" value="searchEmployeeForPPS">
<div id="right">
<script language="javascript">
    writeTableTopFesco("员工信息查询",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="187" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div> </td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="emp_unique_num"/></td>
          <td align="left"><input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="19"/></td>
          <td align="right"><fmt:message key="employee_name"/></td>
          <td align="left"><input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="50"/></td>
          <td></td>
          <td></td>
          </tr>
        <tr>
            <td align="right"><fmt:message key="customer_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="25"/></td>
            <td align="right"><fmt:message key="customer_name"/></td>
            <td align="left">
                 <w:lookup onReturnFunc="rtnFuncCustomer" name="cust_name1" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
                 <!-- <input type="hidden" name="cust_name1" id="h_customer_name" value=""/> -->
            </td>
            <td></td>
            <td></td>
        </tr>
        <tr>
          <td align="right"><fmt:message key="credentials_type"/></td>
          <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("id_card_type_bd1", -1,"ID_CARD_TYPE_BD", "", "", false) %></td>
            <td align="right"><fmt:message key="id_card"/></td>
            <td align="left"><input type="text" class="text_field" name="id_card1" inputName="证件号码" maxLength="64"/></td>
            <td align="right"><input name="button_ok22" id="button_ok22" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
            <td>&nbsp;&nbsp;&nbsp;<input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
            </tr>
    </table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
            <input type="button" id="exportEmployee"  class="e_1" value="导出" onClick="javascript:exp_onClick();" />
          </div>
           <div class="clear"></div>            
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FaerpEmployeeAction.do?cmd=searchEmployeeForPPS"
        width="98%"
        height="320px"
        xpath="EmployeeVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="emp_name" messagekey="employee_name">
            <h:text/>
          </r:field>
          <r:field fieldName="emp_code" messagekey="emp_unique_num">
               <h:text/>   
           </r:field>    
          <r:field fieldName="internal_code" messagekey="internal_code">
               <h:text/>
           </r:field>
          <r:field fieldName="id_card_type_bd" messagekey="credentials_type">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" messagekey="id_card" width="180px">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_code" messagekey="customer_code">
            <h:text/>
          </r:field>
          <r:field fieldName="cust_name" messagekey="customer_name" width="220px">
            <h:text/>
          </r:field>
          
          <r:field fieldName="post_status_bd" messagekey="status">
            <d:select dictTypeId="POST_STATUS_BD" />
          </r:field>
    </r:datacell>
    </div>
 
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">

//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>   
