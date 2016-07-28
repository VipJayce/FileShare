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
<fmt:bundle basename="rayoo.salary.salaryitem.salaryitem_resource" prefix="rayoo.salary.salaryitem.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='button_custom_mould'/></title>
</head>
<script type="text/javascript">
//提交保存
function do_save(){
	var param = "&" + jQuery("#specialForm").serialize();
	//alert(param);
	jQuery.post("<%=request.getContextPath()%>/SalaryorderreleaseAction.do?cmd=insertSpecPayroll"+param,function(data){
           if(data){
            alert("<fmt:message key='alert_mould_success'/>");
            window.close();
           }
    });
}
//检查选择的薪资项目是否已经设置
function checkRepeat(selectEntity,obj){
	if(!obj.getValue()){
		return ;
	}
	for(var i=1;i<10;i++){
		var combo_a = $id(i+"A");
		var combo_b = $id(i+"B");
		var combo_c = $id(i+"C");
		
		var item_id_a = combo_a.selectEntity?combo_a.selectEntity.getValue("id"):"";
		var item_id_b = combo_b.selectEntity?combo_b.selectEntity.getValue("id"):"";
		var item_id_c = combo_c.selectEntity?combo_c.selectEntity.getValue("id"):"";
		
		if(selectEntity){
			var cur_item_id = selectEntity.getValue("id");
			if(cur_item_id){
				if((cur_item_id==item_id_a && obj.id!=combo_a.id) || 
					(cur_item_id==item_id_b && obj.id!=combo_b.id) || 
						(cur_item_id==item_id_c && obj.id!=combo_c.id)){
					obj.selectOptionByIndex(0);
					alert("<fmt:message key='alert_item_repeat'/>");
					return false;
				}
			}
		} 
	}
}
</script>
<body>
<form id="specialForm" action="" method="post"> 
<input type="hidden" name="sa_class_id" value="${sa_class_id}"/>
<input type="hidden" name="cust_id" value="${cust_id}"/>
<div class="box_xinzeng">
	<table>
		<tr>
			<td><fmt:message key='salary_type'/> <input readonly name="class_name" value="${class_name}"/></td>
			<td><fmt:message key='customer_code'/> <input readonly name="cust_code" value="${cust_code}"/></td>
			<td><fmt:message key='customer_name'/> <input readonly name="cust_name" value="${cust_name}"/></td>
		</tr>
	<tr>
		<td align="right">1A <r:comboSelect
			id="1A" name="P_1A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_1A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat"/></td>
		<td align="right">1B <r:comboSelect
			id="1B" name="P_1B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_1B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">1C <r:comboSelect
			id="1C" name="P_1C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_1C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">2A <r:comboSelect
			id="2A" name="P_2A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_2A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">2B <r:comboSelect
			id="2B" name="P_2B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_2B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">2C <r:comboSelect
			id="2C" name="P_2C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_2C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">3A <r:comboSelect
			id="3A" name="P_3A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_3A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">3B <r:comboSelect
			id="3B" name="P_3B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_3B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">3C <r:comboSelect
			id="3C" name="P_3C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_3C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">4A <r:comboSelect
			id="4A" name="P_4A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_4A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">4B <r:comboSelect
			id="4B" name="P_4B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_4B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">4C <r:comboSelect
			id="4C" name="P_4C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_4C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">5A <r:comboSelect
			id="5A" name="P_5A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_5A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">5B <r:comboSelect
			id="5B" name="P_5B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_5B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">5C <r:comboSelect
			id="5C" name="P_5C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_5C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">6A <r:comboSelect
			id="6A" name="P_6A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_6A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">6B <r:comboSelect
			id="6B" name="P_6B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_6B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">6C <r:comboSelect
			id="6C" name="P_6C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_6C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">7A <r:comboSelect
			id="7A" name="P_7A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_7A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">7B <r:comboSelect
			id="7B" name="P_7B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_7B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">7C <r:comboSelect
			id="7C" name="P_7C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_7C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>
	<tr>
		<td align="right">8A <r:comboSelect
			id="8A" name="P_8A"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" value="${payrollVo.p_8A}"
			xpath="SaleryitemVo" width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">8B <r:comboSelect
			id="8B" name="P_8B"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_8B}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
		<td align="right">8C <r:comboSelect
			id="8C" name="P_8C"
			queryAction="/FAERP/SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${sa_class_id}"
			textField="sa_item_name" valueField="id" xpath="SaleryitemVo" value="${payrollVo.p_8C}"
			width="150px" nullText="" onChangeFunc="checkRepeat" /></td>
	</tr>

	<tr>
			<td></td>
			<td align="center">
			<input type="button" id="btn_save" class="foot_icon_1" onclick="do_save()" value="<fmt:message key='button_save'/>"/>
			<input type="button" id="btn_back" class="foot_icon_1" onclick="location.href='javascript:history.go(-1);'" value="<fmt:message key='button_back'/>"/>
			</td>
			<td></td>
		</tr>
		
	</table>
</div>
</form>
</body>
</fmt:bundle>
</html>
