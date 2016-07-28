<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<fmt:bundle basename="rayoo.ibd.ibdcontractproductemp.ibdcontractproductemp_resource" prefix="rayoo.ibd.ibdcontractproductemp.">
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>
  <fmt:message key='empService'/>
  </title>
  <script language="javascript">
  
    function setProductRadioStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' id='productdc_"+value+"' name='radio_template' value='"+value+"' onclick='dcEmpRefresh(\""+value+"\");'>";
    }
    
    function setEmpCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox' name='checkbox_template' value='"+value+"'>";
    }
    
    //EMP列表刷新
    function dcEmpRefresh(productId){
        if($id("dc_emp").isModefied == true){
            alert("<fmt:message key='please_save_emplist'/>");
            jQuery("#productdc_" + jQuery("#productId").val()).attr("checked","checked");
            return false;
        }else{
	        jQuery("#productId").val(productId);
	        $id("dc_emp").loadData();
	        $id("dc_emp").refresh();
	    }
    }
    
    //选择员工
    function selectEmp(){
        if (jQuery("#productId").val()){
	        var cust_id = jQuery('#cust_a_id').val();
	        var url="<%=request.getContextPath()%>/IbdContractProductEmpAction.do?cmd=queryEmp&cust_a_id=" + cust_id;
	        window.open(url,'','height=470px,width=680px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=选择员工');
        }else{
            alert("<fmt:message key='select_one_product'/>");
            return false;
        }
    }
    
    //选择员工回调函数
    function selectEmpCallBack(reg){
        var jsObject = eval('('+reg+')');  
        
        //将所有已经有的员工ID放入一个数组中
        var empIdAry = new Array();
        if(jsObject.length > 0){
            var dc = $id("dc_emp");
	        var itemCount =  dc.getCurrentRowCount();
	        dc.selectFirstRow(); 
	        for(var i=0;i<itemCount;i++){
	            var activeEntity = dc.getActiveEntity();
	            empIdAry[i] = activeEntity.getProperty("emp_id");
	            dc.selectNextRow();
	        }
        }
        
        var msg ="";
        for(var i=0;i<jsObject.length;i++){
            if (isInArray(empIdAry,jsObject[i].id)){
                msg += jsObject[i].emp_name + ",";
                continue;
            }
        
            $id("dc_emp").addRow(); 
            var datacell = $id("dc_emp");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);
            
            datasettr.setProperty("contract_product_id",jQuery("#productId").val());
            datasettr.setProperty("emp_id",jsObject[i].id);
            datasettr.setProperty("emp_name",jsObject[i].emp_name);
            datasettr.setProperty("emp_code",jsObject[i].emp_code);
            datasettr.setProperty("id_card_type_bd",jsObject[i].id_card_type_bd);
            datasettr.setProperty("id_card",jsObject[i].id_card);
            datasettr.setProperty("address",jsObject[i].address);
            datasettr.setProperty("mobile",jsObject[i].mobile);
        }  
        if (msg.length > 0){
            alert(msg + "<fmt:message key='emp_exist'/>");
        }
    }
    
    //删除员工
    function delete_emp(){
        var dc_emp = $id("dc_emp");
        var itemCount =  dc_emp.getCurrentRowCount();
        dc_emp.addRow(); 
        dc_emp.selectLastRow(); 
        for(var i=itemCount;i>=0;i--){
            var activeTr = dc_emp.getActiveRow();
            var activeEntity = dc_emp.getActiveEntity();
            if(jQuery(activeTr).find('input').is(":checked")){
		        dc_emp.deleteRow();
            }
	        dc_emp.selectPreRow();
        }
        dc_emp.selectLastRow(); 
        dc_emp.deleteRow();
    }
    
    //提交员工
    function submit_emp(){
        $id("dc_emp").getSubmitResult();
    }
    
    function isInArray(array,obj){
        for(var i = 0; i < array.length;i++){
            if (array[i] == obj){
                return true;
            }
        }
        return false;
    }
    
    //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    function save_onClick(){
        if($id("dc_emp").isModefied == true){
            $id("dc_emp").submit();
        }
        returnValue = ["0"];
	    window.close();
	    window.opener.insertcallBack(returnValue);
    }
</script>
  </head>
  <body>
  <form name="form" method="post" id="ibdContractProductEmpForm">
    <div id="right">
      <script language="javascript">
            writeTableTopFesco("<fmt:message key='empService'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
      </script>
      <div class="ringht_s">
        <div class="box_3">
          <div class="xz_title">
            <fmt:message key='contractInfo'/>
          </div>
          <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1" ><fmt:message key='contract_type_bd'/></td>
              <td class="td_2 ">
              <%
              SalcontractVo contractVo = (SalcontractVo)request.getAttribute("contractBean");
              %>
              <%=BaseDataHelper.getNameByCode("CONTRACT_TYPE_BD",contractVo.getContract_type_bd()) %> </td>
              <td class="td_1" ><fmt:message key='contract_name'/></td>
              <td class="td_2" >${contractBean.contract_name }</td>
            </tr>
            <tr>
              <td class="td_1" >
                <input type="hidden" id="cust_a_id" value="${contractBean.cust_a_id }">
                <fmt:message key='cust_a'/>
              </td>
              <td class="td_2 ">${contractBean.cust_a_name }</td>
              <td class="td_1" ><fmt:message key='agent_b'/></td>
              <td class="td_2" >${contractBean.agent_b_name }</td>
            </tr>
            <tr>
              <td class="td_1" ><fmt:message key='contract_start_date'/></td>
              <td class="td_2 "><fmt:formatDate value="${contractBean.contract_start_date }" pattern="yyyy-MM-dd"/>
              </td>
              <td class="td_1" ><fmt:message key='contract_stop_date'/></td>
              <td class="td_2" ><fmt:formatDate value="${contractBean.contract_stop_date }" pattern="yyyy-MM-dd"/></td>
            </tr>
            <tr>
              <td class="td_1" ><fmt:message key='contract_code'/></td>
              <td class="td_2" colspan="3">${contractBean.contract_code }</td>
            </tr>
          </table>
        </div>
        <table width="99%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="28%" style="height: 100%;"><div class="zbox" style="height: 100%;">
                <div class="xz_title">
                  <fmt:message key="productItem"/>
                </div>
                <!--按钮 end-->
                <!--服务表格 -->
                <r:datacell 
                      id="dc_productItem"
                      queryAction="/FAERP/IbdContractProductEmpAction.do?cmd=queryProductItem&contractId=${contractBean.id}"
                      width="100%"
                      xpath="Finout_contract_productVo"
                      paramFormId="ibdContractProductEmpForm"
                      pageSize="100"
                      >
                  <r:field fieldName="id" messagekey="Operation" width="50px" sortAt="none" onRefreshFunc="setProductRadioStatus"  align="center"></r:field>
                  <r:field width="170px" fieldName="product_name" messagekey="productName" > </r:field>
                </r:datacell>
                <!--服务表格 end-->
              </div></td>
            <td>&nbsp;</td>
            <td  style="height: 100%;"><div class="zbox" style="height: 100%;">
                <div class="xz_title">
                  <fmt:message key="productEmp"/>
                  <input type="hidden" id="productId" name="contract_product_id">
                </div>
                <!--按钮-->
                <div class="button">
                  <div class="button_right">
                    <ul>
                      <li class="a">
                        <a id="a_emp_select" onClick="javascript:selectEmp();">
                            <fmt:message key="select"/>
                        </a>
                      </li>
                      <li class="bc">
                        <a id="a_emp_save" onClick="javascript:submit_emp();">
                            <fmt:message key="save"/>
                        </a>
                      </li>
                      <li class="d">
                        <a id="a_emp_del" onClick="javascript:delete_emp();">
                            <fmt:message key="delete"/>
                        </a>
                      </li>
                    </ul>
                    <div class="clear"></div>
                  </div>
                </div>
                <!--按钮 end-->
                <!--员工表格 -->
                <r:datacell 
                      id="dc_emp"
                      queryAction="/FAERP/IbdContractProductEmpAction.do?cmd=queryProductEmp"
                      submitAction="/FAERP/IbdContractProductEmpAction.do?cmd=saveProductEmp"
                      width="100%"
                      xpath="IbdContractProductEmpVo"
                      paramFormId="ibdContractProductEmpForm"
                      pageSize="1000"
                      >
                  <r:field fieldName="id" messagekey="Operation" width="50px" sortAt="none" onRefreshFunc="setEmpCheckboxStatus"  align="center"></r:field>
                  <r:field width="0" fieldName="emp_id"></r:field>
                  <r:field width="0" fieldName="contract_product_id"></r:field>
                  <r:field width="70px" fieldName="emp_name" messagekey="empName" allowModify="false">
                  </r:field>
                  <r:field width="60px" fieldName="emp_code" messagekey="empCode" allowModify="false">
                  </r:field>
                  <r:field width="60px" fieldName="id_card_type_bd" messagekey="id_card_type"  allowModify="false">
                    <d:select dictTypeId="ID_CARD_TYPE_BD" disabled="true"/>
                  </r:field>
                  <r:field width="130px" fieldName="id_card" messagekey="id_card" allowModify="false">
                  </r:field>
                  <r:field width="180px" fieldName="address" messagekey="address" allowModify="false">
                  </r:field>
                  <r:field width="90px" fieldName="mobile" messagekey="mobile" allowModify="false">
                  </r:field>
                </r:datacell>
                <!--员工表格 end-->
              </div>
            </td>
          </tr>
        </table>
      </div>
      <div class="mx_button" style="text-align: center; margin-left: 0px; padding-top: 20px;">
        <input type="button" id="save_2_btn" class="icon_2" value="<fmt:message key='save'/>" onClick="javascript:save_onClick()"/>
        <input type="button" class="icon_2" value="<fmt:message key='go_back'/>" onClick="javascript:cancel_onClick()"/>
      </div>  
    </div>
    </div>
  </form>
</body>
<script language="javascript">
    //datacell提交函数。返回String
	Datacell.prototype.getSubmitResult = function(){
	    if( this.beforeSubmit()===false || !this.submitAction  ){
	        return;
	    }
	
	    this.locked();
	    this.endEdit();
	    if(!this.isModefied){
	        alert(DATACELL_MODIFY_NO);
	    }else{
	        if (!this.validateAll()){
	            return false;
	        }
	        var debug= false;
	        if (!debug){
	            var ajax = new HideSubmit(this.submitAction);
	            if(this.paramFormId){
	                var form = $id(this.paramFormId);
	                if(form){
	                    for(var i=0;i<form.elements.length;i++){
	                        var elem = form.elements[i];
	                        if(elem.name){
	                            ajax.addParam(elem.name, xmlConversion(getElementValue(elem)) );
	                        }
	                    }
	                }
	            }
		        if(this.paramList){
		            for(var i=0;i< this.paramList.length;i++){
		                var elem = this.paramList[i];
		                if(elem){
		                    ajax.addParam(elem.key,elem.value);
		                }
		            }
		        }
	
		        if(this.submitReturnValue){
		            ajax.setOutParam(this.submitReturnValue );
		        }
		
		        if(this.submitParamsInfo){
		            ajax.setParamsInfo(this.submitParamsInfo );
		        }
		
		        if(this.submitInoutParams){
		            ajax.setInoutParam(this.submitInoutParams );
		        }
		
	            var returnXML = ajax.loadData(this.dataset.getSubmitXML());
	            if (ajax.retDom){
	                var excep=ajax.retDom.selectNodes('\root\exception');
	                if (excep &&excep.length>0) {
	                    var t= getNodeValue(excep[0]);
	                    if (t && (''+t).indexOf('e')>=0){
	                        alert(DATACELL_SAVE_ERR);
	                    }
	                }else{
    		            if (ajax.getText() != "done"){
    		                alert(ajax.getText() + "<fmt:message key='cant_deleteEmp'/>") ;
    		            }
    		        }
	            }
	            this.afterSubmit(ajax);
	            this.dataXML=null;
	            this.loadData();
	            this.refresh();
	        }
	    }
	    this.unlocked();
	    return true;
	}
</script>
</html>
</fmt:bundle>
