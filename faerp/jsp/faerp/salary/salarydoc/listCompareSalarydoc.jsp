<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salarydoc.salarydoc_resource" prefix="rayoo.salary.salarydoc.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="salarydoc"/></title>
</head>
<script type="text/javascript">
//选择薪资类别
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#h_salary_class_id").val(arg[0]);        
    return false;
}

//查询薪资的档案
function qrySalaryDoc(flag){
    jQuery("#flag").val(flag);
    $id("dc_salary_doc").reload();
    
}

//导出老员工，新员工报税属性不同的数据 吴敬磊 20130911 
//--------------------start--------------------
function expOldEmpdoc(){
    $id("salarydocform").action = "<%=request.getContextPath()%>/SalarydocAction.do";
    $id("h_cmd").value = "expOldEmpdoc";
    $id("salarydocform").submit();
}

function expNewEmpdoc(){
    $id("salarydocform").action = "<%=request.getContextPath()%>/SalarydocAction.do";
    $id("h_cmd").value = "expNewEmpdoc";
    $id("salarydocform").submit();
}
//--------------------end--------------------

//选择员工
function chooseEmp(clzId){
	var url = dir_base + '/jsp/faerp/salary/salarydoc/listemps.jsp?clzId=' + clzId + "&date=" + new Date();
    var entity = window.showModalDialog(url,'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    //alert(ids);
    return entity;
}
</script>
<body>
<form id="salarydocform" method="post"> 
<input type="hidden" name="cmd" id="h_cmd"/>
<input type="hidden" name="flag" id="flag"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='comparetaxflag'/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
	  <div class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="135" rowspan="2" style="padding-top:0;"><div class="search_title"><fmt:message key='salarydoc_search'/></div></td>
	        <td width="80"><fmt:message key='salary_type'/></td>
	        <td width="220">
	            <w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_clz" lookupUrl="/SalaryclassAction.do?cmd=toSalartClzLookup" style="width:170px" messagekey="select_salary_type" height="500" width="810"/>
	            <input type="hidden" name="salary_class_id" id="h_salary_class_id"/>
	        </td>
	        <td width="80"><fmt:message key='emp_code'/></td>
	        <td width="220"><input name="emp_code" class="sText" id="t_emp_code"/></td>
	        <td width="60"><fmt:message key='emp_name'/></td>
	        <td  width="220"><input name="emp_name" class="sText" id="t_emp_name"/></td>
	      </tr>
	      <tr>
	        <td><fmt:message key='emp_id_card'/></td>
	        <td><input name="id_card" class="sText" id="t_id_card"/></td>
	        <td><fmt:message key='send_name'/></td>
	        <td><input name="send_name" class="sText" id="t_send_name"/></td>
	        <td>&nbsp;</td>
	        <td>
	           <input onclick="qrySalaryDoc('old')" type="button" class="icon_3" value="<fmt:message key='button_search_old'/>" />
	           <input onclick="qrySalaryDoc('new')" type="button" class="icon_3" value="<fmt:message key='button_search_new'/>" />
	        </td>
	      </tr>
	    </table>
	  </div>
        <!--查询 end-->
        <!--按钮-->
        <div class="button">
            <div class="button_right">
		        <!-- 导出老员工，新员工报税属性不同的数据 吴敬磊 20130911 -->
		        <input class="e_2" type="button"   value="<fmt:message key='button_output_old'/>"  <au:authorityBtn code="xzda_exp" type="1"/>  onClick="expOldEmpdoc();">
		        <input class="e_2" type="button"   value="<fmt:message key='button_output_new'/>"  <au:authorityBtn code="xzda_exp" type="1"/>  onClick="expNewEmpdoc();">
            </div>
            <div class="clear"></div> 
        </div>
        <!--按钮 end-->
	    <!--表格 -->
	    <div style="padding: 8 0 8 8;">
	       <r:datacell 
              id="dc_salary_doc"
              queryAction="/FAERP/SalarydocAction.do?cmd=simpleQueryCompare"
              submitAction="/FAERP/SalarydocAction.do?cmd=update"
              width="99%"
              height="314px"
              xpath="SalarydocVo"
              submitXpath="SalarydocVo"
              paramFormId="salarydocform"
              pageSize="100"
            >
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field sortAt="none" fieldName="emp_code" messagekey="emp_code" >
              </r:field>
               <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name" >
              </r:field>
              <r:field sortAt="none" fieldName="tax_flag" messagekey="now_tax_flag" >
              </r:field>
              <r:field sortAt="none" fieldName="before_tax_flag" messagekey="before_tax_flag" >
              </r:field>
            </r:datacell>
        </div>
        <!--表格 end-->
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
