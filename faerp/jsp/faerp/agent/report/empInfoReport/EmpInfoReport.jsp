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
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息表</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id_card") + "\",\"" + entity.getProperty("id_card_type_bd") + "\");>";
    }
    
    function ClickRow(value,value1,value2){
        $id("emp_id").value = value;
        $id("id_Card").value = value1;
        $id("id_Card_Type_BD").value = value2;
    }
    
	function findCheckbox_onClick() {  //从多选框到修改页面
		var emp_id = $id("emp_id").value;
		if(emp_id!=null&&emp_id!=""){
            $id("datacell_formid").action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=find&id="+emp_id;
            $id("datacell_formid").submit();
        }else{
            alert("请选择记录！");
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
            alert("请选择记录！");
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
	       alert("请选择记录！");
           return;
	   }
	}
	
	//修改证件号
	function modifyIdCard(){
	    var emp_id = $id("emp_id").value;
	    var id_card = $id("id_Card").value; 
	    var id_card_type_bd = $id("id_Card_Type_BD").value; 
        if(emp_id!=null&&emp_id!=""){
            showModalCenter('<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/employee/updateEmpIdCard.jsp?id='+emp_id+'&id_card='+id_card+'&id_card_type_bd='+id_card_type_bd,window,simpleQuery_onClick,500,200,"修改证件号");
        }else{
            alert("请选择记录！");
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
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('员工信息表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td width="187" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		</tr>
		<tr>
		  <td align="right">唯一号</td>
		  <td align="left"><input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="19"/></td>
	      <td align="right">姓名</td>
	      <td align="left"><input type="text" class="text_field" name="emp_name1" inputName="姓名" maxLength="50"/></td>
	      <td align="right">公司</td>
	      <td align="left"><input type="text" class="text_field" name="cust_name1" inputName="公司" maxLength="64"/></td>
		</tr>
		<tr>
			<td align="right">客户编号</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="25"/></td>
			<td align="right">供应商</td>
			<td align="left">
			     <input type="text" class="text_field" name="agent_name1" inputName="供应商" maxLength="64"/>
			</td>
			<td align="right">供应商唯一号</td>
			<td align="left">
			     <input type="text" class="text_field" name="agent_code1" inputName="供应商唯一号" maxLength="64"/>
			</td>
		</tr>
		<tr>
		  <td align="right">&nbsp;</td>
		  <td align="left">&nbsp;</td>
			<td align="right">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="right">&nbsp;</td>
			<td><input name="button_search" class="icon_1" type="button" value='查询' onClick="simpleQuery_onClick()"></td>
			</tr>
    </table>
</div>
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
		   <input type="button"  class="bb" value='导出' onClick="toDownLoad_onclick();"  />
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
        freezeNumber="1"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="emp_code" label="唯一号">
           </r:field>  
        <r:field fieldName="emp_name" label="姓名">
          </r:field>
          <r:field fieldName="cust_name" label="公司">
           </r:field>
          <r:field fieldName="cust_code" label="客户编号">
          </r:field>
          <r:field fieldName="agent_name" label="供应商">
          </r:field>
          <r:field fieldName="agent_code" label="供应商唯一号">
          </r:field>
          <r:field fieldName="transact_date"  label="手续发布日期" allowModify="false">
            <w:date format="yyyy-MM-dd" />  
          </r:field>
          <r:field fieldName="cust_name" label="客户名称">
            <h:text/>
          </r:field>
          <r:field fieldName="user_name" label="客服">
            <h:text/>
          </r:field>
          <r:field fieldName="post_status_bd" label="状态">
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
