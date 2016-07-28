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
jQuery(function(){
    $id("dc_salary_doc").isQueryFirst = false;
    
    //报税属性和所属税局关系验证
    $id("dc_salary_doc").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
    	
    	if(activeFieldName == "tax_flag"){
    		var tax_bureau = activeEntity.getValue("tax_bureau");
	    	//3FA外地报税、2FA客户报税, 时必需填写“所在税局”
			if(newValue ==2 || newValue ==3 ){
				if(!tax_bureau){
					alert("<fmt:message key="alert_tax_bureau_notnull"/>");
				}
			}
    	}
    	var rc = this.dataset.getLength();
    	var emps = this.dataset.values;
    	for(var i=0; i<rc; i++){
    	   var entity = emps[i];
    	   var chk = entity.getProperty("chk");
    	   if(chk == "1"){
    	   	var curCell = this.getCell(i,activeCell.cellIndex);
	       	this.setCellValue(curCell,newValue); 
    	   }
	       
	    }
    	/*
    	else if(activeFieldName == "tax_bureau"){
    		var tax_flag = activeEntity.getValue("tax_flag");
    		if(tax_flag ==2 || tax_flag ==3 ){
    			if(!newValue){
					alert("所在税局不能为空！");
				}
    		}
    	}*/
	  	
	};
	
	$id("dc_salary_doc").afterRefresh = function(){
		$id("chkbox_all").checked = false;
	};
});
//选择薪资类别
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#h_salary_class_id").val(arg[0]);        
    return false;
}
//查看异常数据
function viewSalaryDocRepeatData(){
    var clzId = jQuery("#h_salary_class_id").val();
    if(!clzId){
        alert("<fmt:message key="alert_select_class"/>");
        return;
    }
    showModalCenter("<%=request.getContextPath()%>/jsp/faerp/salary/salarydoc/viewRepeatData.jsp?clzId=" + clzId
                                                                    ,null,null,800,420,"<fmt:message key='view_repeat_data'/>");
                                                
}
//查询薪资的档案
function qrySalaryDoc(){
    if(checkClz()){
    	$id("dc_salary_doc").reload();
    	//update by whj 2015-04-08
    	//检查薪资类别下薪资档案  如果有多种报税区间则允许修改  只有一种则不允许修改
    	var clzId = jQuery("#h_salary_class_id").val();
    	jQuery.ajax({
             type: "POST",
             url: "<%=request.getContextPath()%>/SalarydocAction.do?cmd=checkSalaryDoc&classId="+ clzId,
             data:"",
             dataType: "html",
             success: function(msg){
                   if(msg != null && msg != ""){
                        var size = parseInt(msg);
	                    if(size==2){
	                       $id("dc_salary_doc").setAllowModify("tax_region_bd",true);
	                    }else{
	                       $id("dc_salary_doc").setAllowModify("tax_region_bd",false);
	                    }
                   }
             }
        });
    }
    
}
//检查是否选择了一个薪资类别
function checkClz(){
	var clzId = jQuery("#h_salary_class_id").val();
    if(!clzId){
        alert("<fmt:message key='alert_select_class'/>");
        return false;
    }
    return clzId;
}
//保存
function saveSalaryDoc(){
	if(checkClz()){
		var is_m = $id("dc_salary_doc").isModefied;
    	rst = $id("dc_salary_doc").submit();
	    if(rst && is_m){
	        alert("<fmt:message key='alert_save_success'/>");
	    }
    }
    
}
//导出
function expEmpdoc(){
	if(checkClz()){
    	$id("salarydocform").action = "<%=request.getContextPath()%>/SalarydocAction.do";
    	$id("h_cmd").value = "expEmpdoc";
    	$id("salarydocform").submit();
    }
    
}
//添加员工档案
function addEmpdoc(){
	var clzId = checkClz();
	if(clzId){
		var emp = chooseEmp(clzId);
		
		if(emp){
			if(emp.length > 0){
				var entity = $id("dc_salary_doc").getActiveEntity();
				if(entity){
					entity = entity.clone();
				}else{
					entity = new Entity();
				}
				entity.setProperty("salary_class_id",$id("h_salary_class_id").value);
				entity.setProperty("emp_post_id",emp[0]);
				entity.setProperty("emp_id",emp[1]);
				entity.setProperty("emp_code",emp[2]);
				entity.setProperty("emp_name",emp[3]);
				entity.setProperty("bank_name",emp[4]);
				entity.setProperty("account_num",emp[5]);
				entity.setProperty("account_name",emp[6]);
				entity.setProperty("post_status_bd",emp[7]);
				entity.setProperty("province_name",emp[8]);
				entity.setProperty("city_area_name",emp[9]);
				entity.setProperty("bank_type_bd",emp[10]);
				entity.setProperty("send_name",emp[11]);
		    	$id("dc_salary_doc").addRow(entity);
			}
		}	
    }
	
}
//选择员工
function chooseEmp(clzId){
	var url = dir_base + '/jsp/faerp/salary/salarydoc/listemps.jsp?clzId=' + clzId + "&date=" + new Date();
    var entity = window.showModalDialog(url,'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    //alert(ids);
    return entity;
}
//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
    	chkAllEntity(1);
        jQuery(":checkbox").attr("checked", true);
    } else {
    	chkAllEntity(0);
        jQuery(":checkbox").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
	//初始化checkbox时设置是否选中
	var flag = entity.getProperty("chk")=="1"? "checked" : "";
    return "<input "+flag+" onclick='chkEntity("+rowNo+");' type='checkbox' name='chk_id' value='" + entity.getProperty("id") + "' />";
}
//设置ENTITY的chk属性
function chkEntity(rowNo){
	var emps = $id("dc_salary_doc").dataset.values;
	var entity = emps[rowNo];
	var chk = entity.getProperty("chk");
	entity.setProperty("chk",1-chk);
}
//设置选中ENTITY的chk属性
function chkAllEntity(flag){
	var ds = $id("dc_salary_doc").dataset;
    var values = ds.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}
</script>
<body>
<form id="salarydocform" method="post"> 
<input type="hidden" name="cmd" id="h_cmd"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='salarydoc'/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
	  <div class="search">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="135" rowspan="2" style="padding-top:0;"><div class="search_title"><fmt:message key='salarydoc_search'/></div></td>
	        <td width="80"><span style="color:red;">*</span><fmt:message key='salary_type'/></td>
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
	        <td><input onclick="qrySalaryDoc()" type="button" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
	      </tr>
	    </table>
	  </div>
        <!--查询 end-->
        <!--按钮-->
        <div class="button">
            <div class="button_right">
                <!--<ul>
                    <li class="bc"><a onclick="saveSalaryDoc()" href="javascript:void(0);">保存</a></li>
                    <li class="c"><a onclick="addEmpdoc();" href="javascript:void(0);">新增</a></li>
                    <li class="a_2"><a onClick="viewSalaryDocRepeatData()" href="javascript:void(0);">查看异常数据</a></li>
                    <li class="e"><a onclick="expEmpdoc()" href="javascript:void(0);">导出</a></li>                  
                </ul>
                -->
                <input class="bc" type="button"   value="<fmt:message key='button_save'/>"  <au:authorityBtn code="xzda_save" type="1"/>  onClick="saveSalaryDoc();">
		        <input class="a_2" type="button"   value="<fmt:message key='view_repeat_data'/>"  <au:authorityBtn code="xzda_error" type="1"/>  onClick="viewSalaryDocRepeatData();">
		        <input class="e" type="button"   value="<fmt:message key='button_output'/>"  <au:authorityBtn code="xzda_exp" type="1"/>  onClick="expEmpdoc();">
            </div>
            <div class="clear"></div>
        </div>
        <!--按钮 end-->
	    <!--表格 -->
	    <div style="padding: 8 0 8 8;">
	    <r:datacell 
              id="dc_salary_doc"
              queryAction="/FAERP/SalarydocAction.do?cmd=simpleQuery"
              submitAction="/FAERP/SalarydocAction.do?cmd=update"
              width="99%"
              height="314px"
              xpath="SalarydocVo"
              submitXpath="SalarydocVo"
              paramFormId="salarydocform"
              pageSize="100"
              freezeNumber="3"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      		  <r:field fieldName="id" 
              label="<input type='checkbox' id='chkbox_all' onclick='chk_all(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox">
      		  </r:field>
              <r:field  fieldName="emp_code" messagekey="emp_code" >
              </r:field>
               <r:field  fieldName="emp_name" messagekey="emp_name" >
              </r:field>
               <r:field  fieldName="bank_name" messagekey="bank_name" width="200px">
              </r:field>
              <r:field   fieldName="account_num" messagekey="account_num" width="180px">
              </r:field>
             
              <r:field  fieldName="post_status_bd" messagekey="post_status_bd"  allowModify="false">
                   <d:select dictTypeId="POST_STATUS_BD"/>
              </r:field>
               <r:field  fieldName="account_name" messagekey="account_name" >
              </r:field>
              <r:field  fieldName="province_name" messagekey="province_name">
              </r:field>
              <r:field  fieldName="city_area_name" messagekey="city_area_name" >
              </r:field>
              <r:field  fieldName="bank_type_bd" messagekey="bank_type_bd" allowModify="false">
                <d:select dictTypeId="BANK_TYPE_BD"/>
              </r:field>
              <r:field  fieldName="tax_table_id" messagekey="tax_table" >
                <r:comboSelect id="c_tax_table" name="tax_table_id"
                       queryAction="TaxTableAction.do?cmd=findAllTaxTable"
                       textField="tax_table_name"
                       valueField="id"
                       xpath="TaxTableVo"
                       width="150px"
                       messagekey="please_select" />
              </r:field>
              <r:field  fieldName="is_local_pay" messagekey="is_local_pay" >
                   <h:select property="is_local_pay">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                   </h:select>
              </r:field>
              <r:field  fieldName="is_sip" messagekey="is_sip" >
                   <h:select property="is_sip">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                   </h:select>
              </r:field>
              <r:field  fieldName="is_hfp" messagekey="is_hfp" >
                   <h:select property="is_hfp">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                   </h:select>
              </r:field>
              <r:field  fieldName="tax_flag" messagekey="tax_flag" >
              		<d:select dictTypeId="TAX_FLAG"/>
                   
              </r:field>
              <r:field  fieldName="tax_bureau" messagekey="tax_bureau" >
              	<h:text property="tax_bureau" validateAttr="maxLength:50;"/>
              </r:field>
              <r:field  fieldName="salary_tax_bd" messagekey="salary_tax_bd" >
                   <d:select dictTypeId="SALARY_TAX_BD"/>
              </r:field>
              <r:field  fieldName="tax_region_bd" messagekey="tax_region_bd" >
                   <h:select property="tax_region_bd">
                         <h:option value="1" label="报当月"/>
                         <h:option value="0" label="报上月"/>
                   </h:select>
              </r:field>
              <r:field  fieldName="is_valid" messagekey="is_valid">
                   <h:select property="is_valid">
                         <h:option value="1" label="有效"/>
                         <h:option value="0" label="无效"/>
                   </h:select>
              </r:field>
              <r:field  fieldName="stop_flag" messagekey="stop_flag" >
                   <h:select property="stop_flag">
                         <h:option value="1" label="停发"/>
                         <h:option value="0" label="未停发"/>
                   </h:select>
              </r:field>
               <r:field  fieldName="payroll_type_bd" messagekey="payroll_type_bd" >
                   <d:select dictTypeId="PAYROLL_TYPE_BD"/>
              </r:field>
              <r:field  fieldName="send_name" messagekey="send_name_">
              </r:field>
                <r:field  fieldName="tax_type" label="计税方式" >
                   <h:select property="stop_flag">
                         <h:option value="1" label="劳务计税"/>
                         <h:option value="0" label="常规计税"/>
                   </h:select>
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
