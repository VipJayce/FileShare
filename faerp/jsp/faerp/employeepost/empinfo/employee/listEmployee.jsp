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
<title><fmt:message key="emp_info_protect"/></title>
<%
String kefuid = (String)request.getAttribute("kefuid");
if(kefuid==null || "".equals(kefuid)){
    kefuid = "1099100700000000105";
}
request.setAttribute("kefuid",kefuid);
%>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id_card") + "\",\"" + entity.getProperty("id_card_type_bd")+ "\",\"" + entity.getProperty("phoenix_emp_id") + "\",\"" + entity.getProperty("emp_code") + "\");>";
    }
    
    function ClickRow(value,value1,value2,value3,value4){
        $id("emp_id").value = value;
        $id("id_Card").value = value1;
        $id("id_Card_Type_BD").value = value2;
        $id("phoenix_emp_id").value = value3;//yangyuting 2014-7-23
        $id("emp_Code").value = value4;
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
	//雇员查询
	function searchEmp(){
	   var emp_id = $id("emp_id").value;
	   var id_card = $id("id_Card").value; 
	   if(emp_id!=null&&emp_id!=""){
	       var VIEWSTATE = "/wEPDwUJLTMwMDg5NTU4D2QWAgIDD2QWAgINDzwrAA0AZBgBBQlHcmlkVmlldzEPZ2TPBDSj1a/CN1A6AexjchlGuAj6+w==";
	       var ddlType = "全部";
	       var url="http://k2.fescoadecco.com/employee/_layouts/FescoAdecco/Info/EmployeeSelect.aspx?txtCitizenID="+id_card+"&__VIEWSTATE="+VIEWSTATE+"&ddlType="+ddlType;
	       encodeURI(url);
	       window.open(encodeURI(url));
	   }else{
	       alert("<fmt:message key="select_records"/>");
           return;
	   }
	}
	
	//修改证件号
	function modifyIdCard(){
	    var emp_id = $id("emp_id").value;
	    var id_card = $id("id_Card").value; 
	    var id_card_type_bd = $id("id_Card_Type_BD").value; 
	    var phoenix_emp_id = $id("phoenix_emp_id").value; //yangyuting 2014-7-23 E化传值
	    var emp_code = $id("emp_Code").value;
        if(emp_id!=null&&emp_id!=""){
            showModalCenter('<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/employee/updateEmpIdCard.jsp?id='+emp_id+'&id_card='+id_card+'&id_card_type_bd='+id_card_type_bd+'&phoenix_emp_id='+phoenix_emp_id+'&emp_code='+emp_code,window,simpleQuery_onClick,500,200,"修改证件号");
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
	}
	
	//跳转导入错误信息
	function detailError_onClick(){
	   $id("datacell_formid").action="<%=request.getContextPath()%>/EpempimperrAction.do?cmd=queryAll";
       $id("datacell_formid").submit();
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
    //模板下载
    function toDownLoad_onclick(){
      window.location="<%=request.getContextPath()%>/EpempimperrAction.do?cmd=downLoad" ;
    }
</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<input type="hidden" id="emp_id" name="emp_id" value=""/>
<input type="hidden" id="id_Card" name="id_Card" value="" />
<input type="hidden" id="id_Card_Type_BD" name="id_Card_Type_BD" value="" />
<input type="hidden" id="phoenix_emp_id" name="phoenix_emp_id" value="" />
<input type="hidden" id="emp_Code" name="emp_Code" value="" />
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key="emp_info_protect"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
	      <td align="right"><fmt:message key="internal_code"/></td>
	      <td align="left"><input type="text" class="text_field" name="internal_code1" inputName="客户方编号" maxLength="64"/></td>
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
			<td align="right"><fmt:message key="combo_cs"/></td>
			<td align="left">
			     <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
			     <!--<w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs"
                    lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" 
                    height="500" width="400" style="width:195px"/>
                    <input type="hidden" name="user_id" id="h_user_id"/>
                    <input type="hidden" name="user_name" id="h_user_name"/>-->
			</td>
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
				<!--<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="p_1">  	<a id="importEmployee" href="###">导入</a> </li>
					<li class="p_1">  	<a onClick="javascript:detailError_onClick();">查看导入错误信息</a> </li>
				</ul>
		 -->
		  <input type="button" class="a" value="<fmt:message key="look"/>" <au:authorityBtn code="ygxxwh_view" type="1"/> onClick="detail_onClick();" />
		   <input type="button" class="b" value="<fmt:message key="update"/>" <au:authorityBtn code="ygxxwh_modify" type="1"/> onClick="findCheckbox_onClick();" />
		   <input type="button"  class="p_1" value="<fmt:message key="templete_downloud"/>" onClick="toDownLoad_onclick();"  />
		    <input type="button" id="importEmployee"  class="e_1" value="<fmt:message key="import"/>"  <au:authorityBtn code="ygxxwh_exp" type="1"/>  />
		     <input type="button" class="p_1" value="<fmt:message key="look_imp_error_info"/>" onClick="detailError_onClick();" />
		 <input type="button" class="p_1" value="<fmt:message key="guyuan_query"/>" <au:authorityBtn code="k2_yggycx_view" type="1"/>  onClick="searchEmp();" />
		 <input type="button" class="p_1" value="<fmt:message key="update_credentials"/>" <au:authorityBtn code="ygzjhwh_modify" type="1"/>  onClick="modifyIdCard();" />
		 </div>
           <div class="clear"></div>			
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FaerpEmployeeAction.do?cmd=searchEmployeeData"
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
          <r:field fieldName="user_name" messagekey="user_name">
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

jQuery(document).ready(function(){
    jQuery("#importEmployee").bind("click", function(){
       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/employee/importEmpExcel.jsp", "", "dialogWidth=600px; dialogHeight=250px");
       if (vReturnValue == '1') {
            jQuery("#button_ok22").click();
       }
      }
    );
});


//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>	
