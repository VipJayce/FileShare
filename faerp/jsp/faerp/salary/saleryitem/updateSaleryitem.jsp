<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.salaryitem.salaryitem_resource" prefix="rayoo.salary.salaryitem.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input name="order_product_id" type="hidden" id="order_product_id" value="${bean.order_product_id}"/>
<input type="hidden" name="issys" id="issys" value="${requestScope.issys}"/>
        <input name="order_product_data_bd" type="hidden" id="order_product_data_bd" value="${bean.order_product_data_bd}"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='update_salaryitem'/></div></div>
    <div class="ringht_s">
    <div class="box_3">
        <div class="xz_title"><fmt:message key='base_info'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='sa_class_name'/></td>
            <td class="td_2">
            <input type="hidden" name="id" id="id" value="${bean.id}"/>
            <input name="salary_class_id" type="hidden" class="sText" id="salary_class_id" value="${bean.salary_class_id}"/>
            <input name="salary_class_name" type="text"  class="sText" id="salary_class_name" value="${requestScope.sc_name}"/>
            <input name="salary_class_name_s" type="hidden"  class="sText" id="salary_class_name_s" value="${requestScope.sc_name}"/>
            </td>
            <td class="td_1"><fmt:message key='sa_item_name'/></td>
            <td class="td_2"><input name="sa_item_name" type="text" class="sText" onchange="form_sa_item_name();" id="sa_item_name" value="${bean.sa_item_name}"/></td>
            <td class="td_1"><fmt:message key='sa_item_ename'/></td>
            <td class="td_2"><input name="sa_item_ename" type="text" class="sText" id="sa_item_ename" value="${bean.sa_item_ename}"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='is_tax'/></td>
            <td class="td_2">
            <h:select property="bean/is_tax" id="is_tax" name="is_tax" style="width:150px">
                         <h:option value="1" label="税前"/>
                         <h:option value="0" label="税后"/>
                  </h:select>
            </td>
            <td class="td_1"><fmt:message key='property'/></td>
            <td class="td_2">
             <h:select property="bean/property" id="property" name="property" style="width:150px">
                         <h:option value="0" label="增项"/>
                         <h:option value="1" label="减项"/>
                         <h:option value="2" label="其他"/>
                  </h:select>
           </td>
            <td class="td_1"><fmt:message key='decimal_num'/></td>
            <td class="td_2">
             <h:select property="bean/decimal_num" id="decimal_num" name="decimal_num" style="width:150px">
                         <h:option value="1" label="1"/>
                         <h:option value="2" label="2"/>
                         <h:option value="3" label="3"/>
                         <h:option value="4" label="4"/>
                         <h:option value="5" label="5"/>
                  </h:select>
           </td>
          </tr>
          <tr>
          <td class="td_1"><fmt:message key='payroll_name'/></td>
          <td class="td_2"><input name="payroll_name" type="text"
                class="sText" id="payroll_name" value="${bean.payroll_name}" /></td>
         <td class="td_1"></td>
          <td class="td_2"></td>
          <td class="td_1"></td>
          <td class="td_2"></td>
        </tr>
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key='data_source'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='select_data_source'/></td>
            <td width="20%" class="td_2">
            <d:select dictTypeId="DATA_SOURCE" name="data_source"  property="bean/data_source" id="data_source"  style="width:190px" onchange="changeData_Source()"/>
    
            </td>
            <td class="td_1"><fmt:message key='define_formula'/></td>
            <td colspan="3" class="td_2"><input type="text" name="formula_display" class="sText" readonly="true" id="formula_display" value="${bean.formula_display}"/>
            &nbsp;&nbsp;&nbsp;<input type="button" name="buttondata1" id="buttondata1"
                value="<fmt:message key='button_define_formula'/>" onclick="tosetFormula()"/>
            &nbsp;&nbsp;&nbsp;<input type="button" name="buttondata" id="buttondata"
                value="<fmt:message key='button_define_contract'/>" disabled="disabled" onclick="product_pop()"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='source_item'/></td>
            <td class="td_2"><input name="source_item" type="text" class="sText" id="source_item" value="${bean.source_item}" disabled="disabled"/></td>
            <td class="td_1"><fmt:message key='before_month_data'/></td>
            <td class="td_2">
            <r:comboSelect id="source_item_updata" 
                       queryAction="SaleryitemAction.do?cmd=findAllSaleryItem&sa_class_id=${bean.salary_class_id}"
                       textField="sa_item_name"
                       valueField="id"
                       xpath="SaleryitemVo"
                       width="150px"
                       messagekey="please_select" disabled="true" value="${bean.source_item_updata}"/>
            </td>
            <td class="td_2">&nbsp;</td>
            <td width="25%" class="td_2">&nbsp;</td>
          </tr>
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key='other_options'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
            <td class="td_1"><fmt:message key='is_bonus'/></td>
            <td class="td_2"><span >
            <c:choose>
	             <c:when test="${bean.is_bonus=='1'}">
	                 <input type="checkbox" name="is_bonus" id="is_bonus" checked="checked" disabled="true" onclick="is_checkLabor()" value="1">
	            </c:when>
	             <c:otherwise><input type="checkbox" name="is_bonus" id="is_bonus" disabled="true" onclick="is_checkLabor()" value="1"></c:otherwise>
            </c:choose>
            </span></td>
            <td class="td_1"><fmt:message key='bonus_months_bd'/></td>
            <td class="td_2">
             <c:choose>
                 <c:when test="${bean.is_bonus=='1'}">
                     <d:select dictTypeId="BONUS_MONTHS_BD" name="bonus_months_bd" disabled="false"  nullLabel="--请选择--" property="bean/bonus_months_bd" id="bonus_months_bd"  style="width:190px" />
                </c:when>
                 <c:otherwise>
                        <d:select dictTypeId="BONUS_MONTHS_BD" name="bonus_months_bd" disabled="true" nullLabel="--请选择--"  property="bean/bonus_months_bd" id="bonus_months_bd"  style="width:190px" />
                </c:otherwise>
            </c:choose>
            </td>
            <td class="td_1"><fmt:message key='is_labor'/></td>
            <td class="td_2"><span >
                <c:choose>
                    <c:when test="${bean.is_labor == '1'}"> <input type="checkbox" name="is_labor" id="is_labor" disabled="true" checked="checked" value="1"></c:when>
                    <c:otherwise> <input type="checkbox" name="is_labor"  id="is_labor" value="1" disabled="true"></c:otherwise>
                </c:choose>
            </span></td>
          </tr>
                <tr>
            <td class="td_1"><fmt:message key='is_display'/></td>
            <td width="10%" class="td_2"><span >
                <c:choose>
                    <c:when test="${bean.is_display == '1'}"><input name="is_display" id="is_display" type="checkbox"  value="1" checked="checked"></c:when>
                    <c:otherwise><input name="is_display" id="is_display" type="checkbox" value="1" ></c:otherwise>
                </c:choose>
            </span></td>

            <td class="td_1"><fmt:message key='is_valid'/></td>
            <td width="10%" class="td_2"><span >
            <c:choose>
                <c:when test="${bean.is_valid == '1'}"><input type="checkbox" name="is_valid" id="is_valid" checked="checked" value="1"></c:when>
                <c:otherwise><input type="checkbox" name="is_valid" id="is_valid" value="1"></c:otherwise>
            </c:choose>
            </span></td>
            <td class="td_1"><fmt:message key='item_cost_group'/></td>
            <td class="td_2">
                <d:select dictTypeId="ITEM_COST_GROUP" name="item_cost_group"  property="bean/item_cost_group" id="item_cost_group" nullLabel="-请选择-" />
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='compute_level'/></td>
            <td class="td_2"><span >
                <h:select property="bean/compute_level" id="compute_level" disabled="true" name="compute_level" style="width:150px">
                         <h:option value="" label="-请选择-"/>
                         <h:option value="1" label="一级"/>
                         <h:option value="2" label="二级"/>
                         <h:option value="3" label="三级"/>
                         <h:option value="4" label="四级"/>
                         <h:option value="5" label="五级"/>
                         <h:option value="99" label="系统级"/>
                  </h:select>
            </span></td>
           
            <td class="td_1">&nbsp;</td>
            <td class="td_2" colspan="3">&nbsp;</td>
          </tr>
        </table>
        <p></p>
        <div class="button">
<div class="foot_button">
           <input type="button" name="button_reset1" class="foot_icon_1" value="<fmt:message key='button_save'/>" onclick="submitAll()"/> 
           <input type="button" class="foot_icon_1" value="<fmt:message key='button_back'/>" onclick="location.href='javascript:history.go(-1);'"/>
        </div>
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
        }else{
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
     //
    function form_sa_item_name(){
       var sa_item_name = encodeURIComponent($id("sa_item_name").value) ;
       var salary_class_id = $id("salary_class_id").value ;
       var sa_item_id = $id("id").value ;
        if(sa_item_name==''){
            alert("<fmt:message key='alert_sa_item_name_1'/>") ;
            return false ;
        }
        if(sa_item_name!=''){
             jQuery.post("<%=request.getContextPath()%>/SaleryitemAction.do?cmd=isSalaryName&sa_item_name="+sa_item_name+"&salary_class_id="+salary_class_id+"&updatetype=update&id="+sa_item_id,function(data){
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
            
            var action = "<%=request.getContextPath()%>/SaleryitemAction.do?cmd=update";
            var myAjax = new Ajax(action);
            //var form = $id("datacell_formid");
            var form = document.forms[0];
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
                        }else if(text=='5'){
                            alert("<fmt:message key='alert_submit_14'/>");
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
                        }else if(text=='4.9'){
                            alert("<fmt:message key='alert_submit_15'/>");
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
        var data_source = $id("data_source").value ;
        var formula = $id("formula_display").value ;
        var source_item = $id("source_item").value ;
        var source_item_updata = $id("source_item_updata").getValue() ;
        var order_product_id = $id("order_product_id").value ;
        var order_product_data_bd = $id("order_product_data_bd").value ;
        if(salarytype != 'true'){
	        //公式
	        if(data_source == '1'&&formula==''){
	            alert("<fmt:message key='alert_define_formula'/>") ;
	            return false ;
	        }
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
        }
        
        
        return true ;
    }
    
</script>
<script type="text/javascript">
     var salarytype = "${requestScope.salarytype}" ;
     var issys = "${requestScope.issys}" ;
      //如果是系统项只有工资单名称可以修改 tanyanjun 2013-10-29
      //英文工资单名称可以修改 2014年7月14日 by sqp
	 if(issys =='1'){
	     var salary_class_name = $id("salary_class_name") ;
		  var sa_item_ename = $id("sa_item_ename") ;
	      var is_tax = $id("is_tax") ;
		  var data_source = $id("data_source") ;
		  var formula = $id("formula_display") ;
		  var source_item = $id("source_item") ;
		  var buttondata = $id("buttondata") ;
		  var is_bonus = $id("is_bonus") ;
	      var bonus_months_bd = $id("bonus_months_bd") ;
	      var is_labor = $id("is_labor") ;
	      var is_display = $id("is_display") ;
	      var is_valid = $id("is_valid") ;
	      var item_cost_group = $id("item_cost_group") ;
	      item_cost_group.disabled="true" ;
	      var buttondata1 =$id("buttondata1") ;
		  salary_class_name.disabled = "disabled" ;
	      var sa_item_name = $id("sa_item_name") ;   
		  var property = $id("property") ;
		  var decimal_num  = $id("decimal_num") ;
		  sa_item_name.disabled = "disabled" ;
		  //sa_item_ename.disabled = "disabled" ;
		  buttondata1.disabled = "disabled" ;
		  property.disabled = "disabled" ;
		  decimal_num.disabled = "disabled" ;
	      is_tax.disabled = "disabled" ;
	      data_source.disabled = "disabled" ;
	      formula.disabled = "disabled" ;
	      source_item.disabled = "disabled" ;
	      buttondata.disabled = "disabled" ;
	      is_bonus.disabled = "disabled" ;
	      bonus_months_bd.disabled = "disabled" ;
	      is_labor.disabled = "disabled" ;
	      is_display.disabled = "disabled" ;
	      is_valid.disabled = "disabled" ;
	 }else{
	    //判断是否是公共薪资项目
	    if(salarytype == 'true'){
		  var salary_class_name = $id("salary_class_name") ;
		  var sa_item_ename = $id("sa_item_ename") ;
	      var is_tax = $id("is_tax") ;
		  var data_source = $id("data_source") ;
		  var formula = $id("formula_display") ;
		  var source_item = $id("source_item") ;
		  var buttondata = $id("buttondata") ;
		  var is_bonus = $id("is_bonus") ;
	      var bonus_months_bd = $id("bonus_months_bd") ;
	      var is_labor = $id("is_labor") ;
	      var is_display = $id("is_display") ;
	      var is_valid = $id("is_valid") ;
		  salary_class_name.disabled = "disabled" ;
	      
	      is_tax.disabled = "disabled" ;
	      data_source.disabled = "disabled" ;
	      formula.disabled = "disabled" ;
	      source_item.disabled = "disabled" ;
	      buttondata.disabled = "disabled" ;
	      is_bonus.disabled = "disabled" ;
	      bonus_months_bd.disabled = "disabled" ;
	      is_labor.disabled = "disabled" ;
	      is_display.disabled = "disabled" ;
	      is_valid.disabled = "disabled" ;
	     
		}else{
		   var data_source = $id("data_source").value ;
		   var formula = $id("formula_display") ;
		   var source_item = $id("source_item") ;
		   var buttondata = $id("buttondata") ;
		   if(data_source =='1' ){
		        formula.disabled = "" ;
		   }
		   if(data_source =='2' ){
		        source_item.disabled="" ;
		   }
		   if(data_source =='4' ){
		        $id("source_item_updata").setDisabled(false) ;
		   }
		   if(data_source =='5' ){
		        buttondata.disabled="" ;
		   }
		}
	 }
	
 

</script>
</fmt:bundle>
</html>
