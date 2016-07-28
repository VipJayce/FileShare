<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.datainterface.datainterface_resource" prefix="rayoo.salary.datainterface.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
</script>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid" action="/FAERP/DatainterfaceAction.do?cmd=updateByID">
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
            <td class="td_2"><input name="inf_name"  type="text" class="sText" id="inf_name" value="${bean.inf_name}"/></td>
            <td class="td_1"><span>*</span><fmt:message key='emp_name_col'/></td>
            <td class="td_2"><input name="emp_name_col" type="text" class="sText" id="emp_name_col" value="${bean.emp_name_col}"</td>
            <td class="td_1"><span>*</span><fmt:message key='excel_col_bd'/></td>
            <td class="td_2">
            <d:select id="excel_col_bd" name="excel_col_bd" dictTypeId="EXCEL_COL_BD" value="${bean.excel_col_bd}"/>
            </td>
          </tr>
          <tr>
            <td class="td_1"><span>*</span><fmt:message key='emp_indentify_col'/></td>
            <td class="td_2"><input name="emp_indentify_col" type="text" class="sText" id="emp_indentify_col" value="${bean.emp_indentify_col}"/></td>
            <td class="td_1"><span>*</span><fmt:message key='row_begin'/></td>
            <td class="td_2"><input name="row_begin" type="text" class="sText" id="row_begin" value="${bean.row_begin}"/></td>
            <td class="td_1"><fmt:message key='row_end'/></td>
            <td class="td_2"><input name="row_end" type="text" class="sText" id="row_end" value="${bean.row_end}"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='remarks'/></td>
            <td colspan="5" class="td_2"><textarea name="remarks" rows="3" class="xText_d" id="remarks">${bean.remarks}</textarea></td>
          </tr>
        </table>
    </div>
    <input type="hidden" name="sa_inf_id" id="sa_inf_id" value="${bean.id}"/>
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
     <r:datacell  id="celllist1" isCount="false" paramFormId="datacell_formid"
        queryAction="/FAERP/SalaryinterfaceitemAction.do?cmd=seachDatainterfaceData"
        submitAction="/FAERP/SalaryinterfaceitemAction.do?cmd=updateDatainterfaceData"
        pageSize="100"
        width="99%" xpath="SalaryinterfaceitemVo" submitXpath="SalaryinterfaceitemVo"  >

        <r:field fieldName="excel_col_name" messagekey="excel_col_name" width="150px">
            <h:text/>
        </r:field>
         <r:field fieldName="salary_item_id" messagekey="sal_item_name" width="300px">
                <r:comboSelect id="sa_item_nameid" name="salary_item_id"
                       queryAction="SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${bean.salary_class_id}"
                       textField="sa_item_name"
                       valueField="id"
                       xpath="SaleryitemVo"
                       width="150px"
                       messagekey="please_select" />
        </r:field>
    </r:datacell>
	</div>
    </div>
    <div class="foot_button">
          <input type="button" class="foot_icon_1" onclick="javascript:toSave_onclick() ;" value="<fmt:message key='button_save'/>"/>
           <input type="button" class="foot_icon_1" value="<fmt:message key='button_back'/>" onClick="location.href='javascript:history.go(-1);'"/>
    </div>
  </div>
</div>       


</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
//新增一条接口明细
function addItem(){
    $id("celllist1").addRow();
}
//删除接口明细
function delItem(){
    if(confirm("<fmt:message key='alert_is_del'/>")){
        $id("celllist1").deleteRow();
        $id("celllist1").submit();
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
    
    //$id("celllist1").isModefied = true;
    //$id("celllist1").submit();
    if(!toSaveCelllist1_onClick()){
       return;
    }
    //datacell_formid
    datacell_formid.submit();
    alert("<fmt:message key='alert_save_success'/>");
}



        //保存信息并校验信息
        function toSaveCelllist1_onClick() {
            var v_salary_item_id="";
            var v_excel_col_name="";
            var dataset1 = $id("celllist1").dataset;
            var len1=dataset1.getLength();
            for(var i =0 ; i < len1 ; i++){
                v_salary_item_id = v_salary_item_id+dataset1.get(i).getProperty("salary_item_id")+",";
                v_excel_col_name = v_excel_col_name+dataset1.get(i).getProperty("excel_col_name")+",";
            }
            
            
            var v_arr = v_excel_col_name.split(","); 
            var v_obj = {};
            for(var i=0;i<v_arr.length;i++)
            {
                var v_item = v_arr[i];
                if(v_obj[v_item]==null)v_obj[v_item] = 1;
                else v_obj[v_item] = v_obj[v_item]+1;
            }
            
            for(v_a in v_obj)
            {
            var pc_item = v_obj[v_a];
            if(pc_item>1){
                 alert("<fmt:message key='alert_exl_repeat_1'/>"+v_a+"<fmt:message key='alert_exl_repeat_2'/>");
                 $id("celllist1").reload();
                 return;
                 }
            } 
            
            /////////////////////////////////////////////////////////////
            var arr = v_salary_item_id.split(","); 
            var obj = {};
            for(var i=0;i<arr.length;i++)
            {
                var item = arr[i];
                if(obj[item]==null)obj[item] = 1;
                else obj[item] = obj[item]+1;
            }
            
            for(a in obj)
            {
            var item = obj[a];
            if(item>1){
                 alert("<fmt:message key='alert_salaryitem_repeat_1'/>"+$id("sa_item_nameid").getDisplayValue(a)+"<fmt:message key='alert_salaryitem_repeat_2'/>");
                 $id("celllist1").reload();
                 return;
                 }
            } 

            
            $id("celllist1").isModefied = true;
            if($id("celllist1").submit()){
                return true;
            }
        }  
</script>
