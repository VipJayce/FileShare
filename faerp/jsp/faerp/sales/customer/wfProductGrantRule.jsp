<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/CommonCheck.js"/>
<h:script src="/js/caculateMoney.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="java.util.*"%>
<%@page import="rayoo.sales.customer.util.ICustomerConstants"%>
<%  //取出本条记录
	CustomerVo customerVo = null;
    if(request.getAttribute(ICustomerConstants.REQUEST_BEAN) != null) {  
        customerVo = (CustomerVo)request.getAttribute(ICustomerConstants.REQUEST_BEAN); 
    }    
    List productGrantRuleVoList = (List)request.getAttribute("list"); 
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type="text/javascript"
    src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript"
    src="<%=request.getContextPath()%>/js/rm-tools.js"></script>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>

<script language="javascript">    
//入职时间1     一年3     自然季度2     半年6
    function back_onClick(){  //返回列表页面
         window.close();
        //form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=queryCustomerInitAll&backFlag=true";
        //form.submit();
    }
    
    //设置规则保存
    function appOperate_onClick(){
        var id_check = document.getElementsByName("temp");
        var ids =  new Array(0); //定义id值的数组
       
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null || ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
/*	    var enCurEntity = $id("datacell1").activeEntity;
	    var grant_condition = enCurEntity.getProperty('grant_condition');
    alert(grant_condition);
  */  
        //form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=updateRulesForCustomer&product_grant_rule_id=" + ids + "&grant_condition=" + gCondition;  + "&grant_condition=" + grant_condition
        //form.submit();
        var action="<%=request.getContextPath()%>/CustomerAction.do?cmd=updateRulesForCustomer&product_grant_rule_id=" + ids ;
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
         myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
               window.opener.callBack(myAjax.getProperty("returnValue"));
         }
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
      var cvalue= document.getElementById("product_grant_rule_id").value;          
      
    if( cvalue == entity.getProperty("id")){
         return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + "  checked='checked'  >";
    }
     return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + ">";

    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right"> <div class="ringht_x">
<div id="ccChild0" class="box_3"> 
<div class="xz_title"><fmt:message key="customer_information"/></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor="#c5dbe2">
        <tr>
             <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_code"/></td>
            <td class="td_2 ">
            <input  type="hidden" name="product_grant_rule_id" id="product_grant_rule_id" value="<%=customerVo.getProduct_grant_rule_id()%>" />
                 <input type="text" class="text_field"  name="customer_code" inputName="客户编号" value="<%=customerVo.getCustomer_code()%>"  readonly="true" maxLength="50"  validate="notNull;notNullWithoutTrim " />
            </td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  name="customer_name" inputName="客户名称" value="<%=customerVo.getCustomer_name()%>"  readonly="true" maxLength="50"  validate="notNull;notNullWithoutTrim" />
            </td>
        </tr>
    </table>
    </div>
    <script>
        function showValue(value,entity,rowNo,cellNo){
	        if (value == '' || value == null){
	            return '';
	        }else {
	            return "<fmt:message key="every_other"/>" + value + "<fmt:message key="months"/>";
	        }
	    }
	       function showValue3(value,entity,rowNo,cellNo){
            if (value == '' || value == null){
                return '';
            }else {
                return "" + value +  "<fmt:message key="months"/>";
            }
        }
          function showValue4(value,entity,rowNo,cellNo){
            if (value == '' || value == null){
                return '';
            }else {
                return "" + value +  "<fmt:message key="month"/>";
            }
        }
        
       
        
        function showValue2(value,entity,rowNo,cellNo){
	        var a = entity.getProperty("grant_condition");	        
	        if (a == '6' || a == 6){
	            return "<fmt:message key="first_of_year_issued"/>" + entity.getProperty("grant_counts") + "<fmt:message key="second_half_of_year_issued"/>" + entity.getProperty("grant_counts1") + "<fmt:message key="spread"/>";
	        }else {
	            return "<fmt:message key="put_out"/>" + value + "<fmt:message key="spread"/>";
	        }
	    }    


	    
    </script>
    <div class="xz_title"><fmt:message key="selection_rules"/></div>
     <div>
     
        <r:datacell   id="datacell1"   queryAction="/FAERP/CustomerAction.do?cmd=productGrantRuleData"
         width="98%" height="318px"   xpath="ProductGrantRuleVo"  paramFormId="datacell_formid" >
         
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operation" width="100px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
       <r:field fieldName="grant_condition" messagekey="grant_condition" width="150px" allowModify="false">
           <d:select dictTypeId="GRANT_CONDITION" name="grant_condition" id="grant_condition" property="grant_condition"  />
      </r:field>
      <r:field fieldName="ff_month" messagekey="ff_month" width="100px" onRefreshFunc="showValue4">
      </r:field>
        <r:field fieldName="grant_month" messagekey="grant_month" width="150px" onRefreshFunc="showValue3">
      </r:field>
       <r:field fieldName="grant_frequency" messagekey="grant_frequency" width="100px" onRefreshFunc="showValue">
      </r:field>
      <r:field fieldName="grant_counts" messagekey="grant_counts" width="300px" onRefreshFunc="showValue2">
      </r:field>
      
        </r:datacell>
    </div>
<div class="foot_button">
    <input name="button_back" class="button_ellipse" type="button" value="<fmt:message key="go_back"/>"  onclick="javascript:back_onClick();" >
    <input name="button_app" class="button_ellipse" type="button" value="<fmt:message key="save"/>"  onclick="javascript:appOperate_onClick();" >
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>

	  </html>
