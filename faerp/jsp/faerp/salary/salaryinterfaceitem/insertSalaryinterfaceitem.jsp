<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.datainterface.datainterface_resource" prefix="rayoo.salary.datainterface.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>
<form method="post" id="datacell_formid" action="SalaryinterfaceitemAction.do?cmd=queryAll&backFlag=true">
<input  type="hidden" value="<%=request.getParameter("sa_class_id") %>" id="sa_class_id" name="sa_class_id"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='dateinterface'/></div></div>
    <div class="ringht_s">
    <!--表格2-->
    <div class="box_3">
        <div class="xz_title"><fmt:message key='dateinterface_info'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><span>*</span><fmt:message key='inf_name'/></td>
            <td class="td_2"><input name="inf_name" type="text" class="sText" id="inf_name" value=""/></td>
            <td class="td_1"><span>*</span><fmt:message key='emp_name_col'/></td>
            <td class="td_2"><input name="emp_name_col" type="text" class="sText" id="emp_name_col" value=""/></td>
            <td class="td_1"><span>*</span><fmt:message key='excel_col_bd'/></td>
            <td class="td_2">
            <d:select id="excel_col_bd" name="excel_col_bd" dictTypeId="EXCEL_COL_BD"/>
            </td>
          </tr>
          <tr>
            <td class="td_1"><span>*</span><fmt:message key='emp_indentify_col'/></td>
            <td class="td_2"><input name="emp_indentify_col" type="text" class="sText" id="emp_indentify_col" value=""/></td>
            <td class="td_1"><span>*</span><fmt:message key='row_begin'/></td>
            <td class="td_2"><input name="row_begin" type="text"  class="sText" id="row_begin" value="2"/></td>
            <td class="td_1"><fmt:message key='row_end'/></td>
            <td class="td_2"><input name="row_end" type="text" class="sText" id="row_end" value=""/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='remarks'/></td>
            <td colspan="5" class="td_2"><textarea name="remarks" rows="3" class="xText_d" id="remarks"></textarea></td>
          </tr>
        </table>
    </div>
    <input  type="hidden" value="" id="sa_inf_id" name="sa_inf_id"/>
    <!--表格2 end-->
    <!--社保公积金-->
   <div class="xz_title"><fmt:message key='dateinterface_info_1'/></div>
   			<div id="div_mod" class="button">
		        <div class="button_right">
		            <ul>
		              <li class="c"><a onclick="addItem()" href="javascript:void(0);"><fmt:message key='button_add'/></a></li>
		              <li class="d"><a onclick="delItem()" href="javascript:void(0);"><fmt:message key='button_del'/></a></li>
		            </ul>
		        </div>
		        <div class="clear"></div>
	        </div>
			<div style="display;padding: 8 10 8 8;">
			     <r:datacell  id="cellinterfaceid" isCount="false" paramFormId="datacell_formid"
			        queryAction="/FAERP/SalaryinterfaceitemAction.do?cmd=seachDatainterfaceData"
			        submitAction="/FAERP/SalaryinterfaceitemAction.do?cmd=insertDatainterfaceData"
			        pageSize="100"
			        width="99%" xpath="SalaryinterfaceitemVo" submitXpath="SalaryinterfaceitemVo"  >
			
			        <r:field fieldName="excel_col_name" messagekey="excel_col_name" width="150px">
			            <h:text/>
			        </r:field>
			        <!--<r:field fieldName="sal_item_name" label="薪资项目名称" width="150px">
			           <h:text/>
			        </r:field>
			         --><r:field fieldName="salary_item_id" messagekey="sal_item_name" width="300px">
			                <r:comboSelect id="sa_item_name" name="sal_item_name"
			                       queryAction="SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${requestScope.sa_class_id}"
			                       textField="sa_item_name"
			                       valueField="id"
			                       xpath="SaleryitemVo"
			                       width="150px"
			                       messagekey="please_select" />
			              </r:field>
			    </r:datacell>
			</div>
    <!--表格 end-->
    </div>
		<div class="foot_button">
          <input type="button" class="foot_icon_1" onclick="javascript:toSave_onclick() ;" value="<fmt:message key='button_save'/>"/>
           <input type="button" class="foot_icon_1" value="<fmt:message key='button_back'/>" onClick="location.href='javascript:history.go(-1);'"/>
        </div>
</div>
</div>       
</form>
</body>
<script type="text/javascript">
$id("cellinterfaceid").afterSubmit = function(ajax){
    rst = ajax.getProperty("returnValue");
    var sa_inf_id = document.getElementById("sa_inf_id").value=rst;
}
//新增一条接口明细
function addItem(){
    $id("cellinterfaceid").addRow();
}
//删除接口明细
function delItem(){
    if(confirm("<fmt:message key='alert_is_del'/>")){
        $id("cellinterfaceid").deleteRow();
    }
    
}
//保存
function toSave_onclick(){
    var inf_name = $id("inf_name").value ;
    if(inf_name==null||inf_name==''){
        alert("<fmt:message key='alert_inf_name_notnull'/>") ;
        return false ;
    }
    var emp_name_col = $id("emp_name_col").value ;
    if(emp_name_col==null||emp_name_col==''){
        alert("<fmt:message key='alert_emp_name_col_notnull'/>") ;
        return false ;
    }
    var excel_col_bd = $id("excel_col_bd").value ;
    if(excel_col_bd==null||excel_col_bd==''){
        alert("<fmt:message key='alert_excel_col_bd_notnull'/>") ;
        return false ;
    }
    var emp_indentify_col = $id("emp_indentify_col").value ;
    if(emp_indentify_col==null||emp_indentify_col==''){
        alert("<fmt:message key='alert_emp_indentify_col_notnull'/>") ;
        return false ;
    }
    var row_begin = $id("row_begin").value ;
    if(row_begin==null||row_begin==''){
        alert("<fmt:message key='alert_row_begin_notnull'/>") ;
        return false ;
    }
    if(isNaN(row_begin)){
     	alert("<fmt:message key='alert_row_begin_notnum'/>") ;
        return false ;
    }
    if(row_begin <2){
        alert("<fmt:message key='alert_row_begin_gt2'/>") ;
        return false ;
    }
    
    var row_end = $id("row_end").value ;
    if(row_end & isNaN(row_end)){
     	alert("<fmt:message key='alert_row_end_notnum'/>") ;
        return false ;
    }
    if(row_end){
        if(Number(row_end) < Number(row_begin)){
	        alert("<fmt:message key='alert_row_end_gl_begin'/>") ;
	        return false ;
        }
    }
    
    $id("cellinterfaceid").isModefied = true;
    $id("cellinterfaceid").submit();
}
</script>
</fmt:bundle>
</html>

