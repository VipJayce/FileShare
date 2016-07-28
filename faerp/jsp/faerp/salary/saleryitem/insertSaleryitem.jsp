<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.salary.salaryitem.salaryitem_resource" prefix="rayoo.salary.salaryitem.">
<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid">
		<input name="order_product_id" type="hidden" id="order_product_id" value=""/>
		<input name="order_product_data_bd" type="hidden" id="order_product_data_bd" value=""/>
		<!-- def序列编号通过提交后的系统后台查询获取 -->
		<input name="item_serial_new_id" type="hidden" id="h_item_serial_new_id"/>
		<!-- 模板ID：是初始化薪资类别时根据模板生成一些固定项目，新建时不需要 -->
		<input name="salary_temp_id" type="hidden" id="h_salary_temp_id"/>
	<div id="right">
	<div class="right_title_bg">
	<div class="right_title"><fmt:message key='add_salaryitem'/></div>
	</div>
	<div class="ringht_s">
	<div class="box_3">
	<div class="xz_title"><fmt:message key='base_info'/></div>
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><fmt:message key='sa_class_name'/></td>
			<td class="td_2"><input disabled name="salary_class_name" type="text"
				class="sText" id="salary_class_name"
				value="${requestScope.salaery_class_name}" /><input
				type="hidden" name="salary_class_id" id="salary_class_id"
				value="${requestScope.sc_id}" /></td>
			<td class="td_1"><font color="red">*</font><fmt:message key='sa_item_name'/></td>
			<td class="td_2">
				<input name="sa_item_name" type="text" class="sText" id="sa_item_name" value="" onchange="form_sa_item_name();"/>
				
			</td>
			<td class="td_1"><fmt:message key='sa_item_ename'/></td>
			<td class="td_2"><input name="sa_item_ename" type="text"
				class="sText" id="sa_item_ename" value="" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='is_tax'/></td>
			<td class="td_2">
			<select  id="is_tax" name="is_tax" class="sSelect">
				<option value="1" label="<fmt:message key='is_tax_before'/>" />
				<option value="0" label="<fmt:message key='is_tax_after'/>" />
			</select>
			</td>
			<td class="td_1"><font color="red">*</font><fmt:message key='property'/></td>
			<td class="td_2">
			<select name="property" class="sSelect"	id="property">
				<option value=""><fmt:message key='select_option'/></option>
				<option value="0"><fmt:message key='property_0'/></option>
				<option value="1"><fmt:message key='property_1'/></option>
				<option value="2"><fmt:message key='property_2'/></option>
			</select>
			</td>
			<td class="td_1"><fmt:message key='decimal_num'/></td>
			<td class="td_2"><select name="decimal_num" class="sSelect"
				id="decimal_num">
				<option value=""><fmt:message key='select_option'/></option>
				<option value="1">1</option>
				<option value="2" selected>2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select></td>
		</tr>
		<tr>
		  <td class="td_1"><fmt:message key='payroll_name'/></td>
          <td class="td_2"><input name="payroll_name" type="text"
                class="sText" id="payroll_name" value="" /></td>
         <td class="td_1"></td>
          <td class="td_2"></td>
          <td class="td_1"></td>
          <td class="td_2"></td>
		</tr>
	</table>
	<p></p>
	<div class="xz_title"><fmt:message key='data_source'/></div>
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><font color="red">*</font><fmt:message key='select_data_source'/></td>
			<td width="20%" class="td_2">
			<d:select dictTypeId="DATA_SOURCE" name="data_source" id="data_source"  style="width:190px" onchange="changeData_Source()" nullLabel="-请选择-"/>
			</td>
			<td class="td_1"><fmt:message key='define_formula'/></td>
			<td colspan="3" class="td_2">
			<input type="text" name="formula_display" class="sText"  id="formula_display" readonly="true"/>
            &nbsp;&nbsp;&nbsp;<input type="button" name="buttondata1" id="buttondata1"
                value="<fmt:message key='button_define_formula'/>" onclick="tosetFormula()"/>
			&nbsp;&nbsp;&nbsp;<input type="button" name="buttondata" id="buttondata"
				value="<fmt:message key='button_define_contract'/>" disabled="disabled" onclick="product_pop()"/></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='source_item'/></td>
			<td class="td_2"><input name="source_item" type="text" class="sText"
				id="source_item" value="" disabled="disabled"/></td>
			<td class="td_1"><fmt:message key='before_month_data'/></td>
			<td class="td_2">
			 <r:comboSelect id="source_item_updata" 
                       queryAction="SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${requestScope.sc_id}"
                       textField="sa_item_name"
                       valueField="id"
                       xpath="SaleryitemVo"
                       width="150px"
                       messagekey="please_select" disabled="true" />
			</td>
			<td class="td_2">&nbsp;</td>
			<td width="25%" class="td_2">&nbsp;</td>
		</tr>
	</table>
	<p></p>
	<div class="xz_title"><fmt:message key='other_options'/></div>
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><fmt:message key='is_bonus'/></td>
			<td class="td_2"><input type="checkbox" name="is_bonus" id="is_bonus" disabled="true"  onclick="is_checkLabor()" value="1">
			</td>
			<td class="td_1"><fmt:message key='bonus_months_bd'/></td>
			<td class="td_2">
			<d:select dictTypeId="BONUS_MONTHS_BD" name="bonus_months_bd" disabled="true"  property="bonus_months_bd" id="bonus_months_bd" nullLabel="--请选择--" style="width:190px" />
            </td>
			</td>
			<td class="td_1"><fmt:message key='is_labor'/></td>
			<td class="td_2"><input type="checkbox" name="is_labor" id="is_labor" value="1" disabled="true">
			
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='is_display'/></td>
			<td width="10%" class="td_2"><input name="is_display" id="is_display" type="checkbox" value="1" checked> </td>
			<td class="td_1"><fmt:message key='is_valid'/></td>
			<td width="10%" class="td_2"><input	type="checkbox" name="is_valid" id="is_valid" value="1" checked></td>
			<td class="td_1"><fmt:message key='item_cost_group'/></td>
            <td class="td_2">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("item_cost_group", -1, "ITEM_COST_GROUP", "a1", "inputName='薪资项成本分组' ", false) %>
            </td>
          </tr>
	</table>
	<p></p>
	<div class="button">
	<div class="foot_button"><input type="button" name="button_reset1" class="foot_icon_1" value="<fmt:message key='button_save'/>" onclick="submitAll()"/> 
	   <input type="button" class="foot_icon_1" value="<fmt:message key='button_back'/>" onclick="location.href='javascript:history.go(-1);'" /></div>
	</div>
	</div>
	</form>
</body>
<script type="text/javascript">
    //选择数据来源
    function changeData_Source(){
        var data_source = $id("data_source").value ;
        var formula = $id("formula_display") ;
        var source_item = $id("source_item") ;
        var buttondata = $id("buttondata") ;
        var buttondata1 = $id("buttondata1") ;
        //公式
        if(data_source == '1'){
            formula.disabled="" ;
            source_item.disabled="disabled" ;
            $id("source_item_updata").setDisabled(true) ;
            buttondata.disabled="disabled" ;
            buttondata1.disabled="";
        }
        //固定值
        if(data_source == '2'){
            formula.disabled="disabled" ;
            source_item.disabled="" ;
            $id("source_item_updata").setDisabled(true) ;
            buttondata.disabled="disabled" ;
            buttondata1.disabled="disabled" ;
        }
        //输入
        if(data_source == '3'){
            formula.disabled="disabled" ;
            source_item.disabled="disabled" ;
            $id("source_item_updata").setDisabled(true) ;
            buttondata.disabled="disabled" ;
            buttondata1.disabled="disabled" ;
        }
        //上月项目
        if(data_source == '4'){
            formula.disabled="disabled" ;
            source_item.disabled="disabled" ;
            $id("source_item_updata").setDisabled(false) ;
            buttondata.disabled="disabled" ;
            buttondata1.disabled="disabled" ;
        }
        //合同数据
        if(data_source == '5'){
           formula.disabled="disabled" ;
           source_item.disabled="disabled" ;
           $id("source_item_updata").setDisabled(true) ;
           buttondata.disabled="" ;
           buttondata1.disabled="disabled" ;
        }
    }
    
    //判断是不是薪资了增项
    function is_checkLabor(){
        var property = $id("property").value ;
        if(property != '0'){
            alert("<fmt:message key='alert_is_bonus_1'/>") ;
            var is_bonus = $id("is_bonus") ;
            is_bonus.checked="" ;
        }
        else{
            var bonus_months_bd = $id("bonus_months_bd") ;
            var is_bonus = $id("is_bonus").checked ;
            if(is_bonus){
             bonus_months_bd.disabled="" ;
            }else{
             bonus_months_bd.disabled="disabled" ;
            }
           
         }
    }
    
    function tosetFormula(){
        var salary_class_id = $id("salary_class_id").value ;
        if(salary_class_id == null||salary_class_id==''){
            alert("<fmt:message key='alert_select_class'/>") ;
            return false ;
        }
        url="<%=request.getContextPath()%>/jsp/faerp/salary/saleryitem/tosetformual.jsp?sa_class_id="+salary_class_id;
        window.open(url,"newwindow","width=900px,height=600px,location=no,scroll=yes");
    
    }
    
    function product_pop(){
        var salary_class_id = $id("salary_class_id").value ;
        if(salary_class_id == null||salary_class_id==''){
            alert("<fmt:message key='alert_select_class'/>") ;
            return false ;
        }
        url="<%=request.getContextPath()%>/jsp/faerp/system/product/allproductsalaryclass.jsp?sa_class_id="+salary_class_id;
        showModalCenter(url, "", callBack, 400, 500, "<fmt:message key='alert_select_product'/>");  //增加子岗位
    }
    
    function callBack(value){
            $id("order_product_id").value = value[0];
            $id("order_product_data_bd").value = value[2];
    }
    function form_sa_item_name(){
       var sa_item_name = encodeURIComponent($id("sa_item_name").value);
       var salary_class_id = $id("salary_class_id").value ;
        if(sa_item_name==''){
            alert("<fmt:message key='alert_sa_item_name_1'/>") ;
            return false ;
        }
        if(sa_item_name!=''){
             jQuery.post("<%=request.getContextPath()%>/SaleryitemAction.do?cmd=isSalaryName&salary_class_id="+salary_class_id+"&sa_item_name="+sa_item_name,function(data){
                 if(data == 'true'){
                    alert("<fmt:message key='alert_sa_item_name_repeat'/>") ;
                    return false ;
                 }
              });
	    }
    }
    
    function submitAll(){//表单提交
        //表单验证
        if(submit_onsubmit()){
        
            jQuery("input[name='button_reset1']").attr('disabled','disabled');
            
            var action = "<%=request.getContextPath()%>/SaleryitemAction.do?cmd=insert";
            var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }           
             myAjax.submitXML();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 0 ) {
                      alert( "<fmt:message key='alert_save_success'/>" );
                      window.location.href="<%=request.getContextPath()%>/SaleryitemAction.do?cmd=queryAll";
                  } else {
                        var text = myAjax.getValue("root/data/returnValue");
                        if(text=='1'){
                            alert("<fmt:message key='alert_submit_1'/>");
                        }else if(text=='2'){
                            alert("<fmt:message key='alert_submit_2'/>");
                        }else if(text=='3.1'){
                            alert("<fmt:message key='alert_submit_3'/>");
                        }else if(text=='3.2'){
                            alert("<fmt:message key='alert_submit_4'/>");
                        }else if(text=='4.1'){
                            alert("<fmt:message key='alert_submit_5'/>");
                        }else if(text=='4.2'){
                            alert("<fmt:message key='alert_submit_6'/>");
                        }else if(text=='4.3'){
                            alert("<fmt:message key='alert_submit_7'/>");
                        }else if(text=='4.4'){
                            alert("<fmt:message key='alert_submit_8'/>");
                        }else if(text=='4.5'){
                            alert("<fmt:message key='alert_submit_9'/>");
                        }else if(text=='4.6'){
                            alert("<fmt:message key='alert_submit_10'/>");
                        }else if(text=='4.7'){
                            alert("<fmt:message key='alert_submit_11'/>");
                        }else if(text=='4.8'){
                            alert("<fmt:message key='alert_submit_12'/>");
                        }else{
                            alert("<fmt:message key='alert_submit_13'/>");
                        }
                        
                        jQuery("input[name='button_reset1']").removeAttr("disabled");
                        
                        return false ;
                  }
                  
             }
            
        }

    }
    
    //提交验证
    function submit_onsubmit(){
        var sa_item_name = $id("sa_item_name").value ;
        if(sa_item_name == ''){
            alert("<fmt:message key='alert_sa_item_name_1'/>") ;
            return false ;
        }
        var property = $id("property").value ;
        if(property == ''){
            alert("<fmt:message key='alert_select_property'/>") ;
            return false ;
        }
        var data_source = $id("data_source").value ;
        if(data_source == ''){
            alert("<fmt:message key='alert_select_data_source'/>") ;
            return false ;
        }
        var icg = jQuery("select[name='item_cost_group']").val();
        if(icg == 'a0'){
            alert("<fmt:message key='alert_cant_select_group'/>") ;
            return false ;
        }
        
        var formula = $id("formula_display").value ;
        var source_item = $id("source_item").value ;
        var source_item_updata = $id("source_item_updata").getValue() ;
        var order_product_id = $id("order_product_id").value ;
        var order_product_data_bd = $id("order_product_data_bd").value ;
        var salary_class_id = $id("salary_class_id").value ;
        //固定值
        if(data_source == '2'&&source_item==''){
            alert("<fmt:message key='alert_select_source_item'/>") ;
            return false ;
        }
        //上月项目
        if(data_source == '4'&&source_item_updata==''){
            alert("<fmt:message key='alert_select_before_month_data'/>") ;
            return false ;
        }
        //合同数据
        if(data_source == '5'&&order_product_data_bd==''&&order_product_id==''){
            alert("<fmt:message key='alert_contract_data'/>") ;
            return false ;
        }
        //公式
        if(data_source == '1'){
            if(formula==''){
                alert("<fmt:message key='alert_define_formula'/>") ;
                return false ;
            }
        }
            
        return true ;
        
        
    }
    
    /**
    *	选择薪资项目时，填充其他字段值
    */
    function fillItem(){
    	var combo = $id("combo_st");
    	var item = combo.selectEntity;
    	if(item){
    		$id("h_item_serial_new_id").value = item.getProperty("data_field");
    		$id("h_salary_temp_id").value = item.getProperty("id");
    	}
    }
    
</script>
</html>
</fmt:bundle>
