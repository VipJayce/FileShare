<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>招聘账单</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>

<script type="text/javascript">

//获得选中的账单明细数据
function getCheckedRows(){
    var datacell1 = $id("datacell1");
    var len = datacell1.dataset.getLength();
    var rows = null;
    if(rows == null){
        rows = new Array(0);
    }
    for(var i=0;i<len;i++){
        var currentEntity = datacell1.getEntity(i);
        if(currentEntity.getProperty("ischecked") == "1"){
            rows.push(currentEntity);
        }
    }
    return rows;
}

//确定按钮
function save_onClick(){

        var frm = $id("datacell_formid");
        var dc = window["dialogArguments"];
        var datacell1 = $id("datacell1");
        var action = "<%=request.getContextPath()%>/BillOthersAction.do?cmd=insertJobBill";
        var dataset1 = datacell1.dataset;//取得页面的dataset
        var len1 = dataset1.getLength();
        
        if(!checkForm(frm)){
            return;
        }
        
        if(len1 == 0){
            alert("没有账单明细数据！");
            return ;
        }
        
      var selectedRows = getCheckedRows();
      if(selectedRows.length == 0){
        alert("请选择需要生成账单的明细数据！");
        return ;
      }
      
        for(var i=0; i<selectedRows.length; i++){
             var datarow =  selectedRows[i];
             var position_status =datarow.getProperty("position_status");
             var is_invoiced=datarow.getProperty("is_invoiced");
           
             if(position_status!="5"&&is_invoiced!="1"){
                alert("职位状态未成功，不能生成账单！");
                return ;
             }
             var amount = datarow.getProperty("amount");
             if(amount == null || amount == ""){
                alert("账单明细金额不能为空！");
                return ;
             }
        }
        
        var xmlSubmit = datacell1.dataset.toString();
        var myAjax = new Ajax(action);
        if (form) {
            for (var i = 0; i < form.elements.length; i++) {
                var elem = form.elements[i];
                if (elem.name) {
                   myAjax.addParam(elem.name, getElementValue(elem));
                }
            }
            myAjax.addParam("cost_center_name",$id("cost_center_id").getText());
        }
        myAjax.submitXML(xmlSubmit, 'UTF-8');
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
            if( myAjax.getValue("root/data/returnValue") == "ok" ) {
                alert("账单生成成功！");
                 window.close();
                 //window.opener.insertcallBack("0");
                 dc.reload();
                 dc.refresh();
             } 
             else {
                 alert( '账单生成失败！' ); 
             }
      }
}


//增行
    function toAddSub_onClick(){
        var dc1 = $id("datacell1");
        var url="<%=request.getContextPath()%>/Job_positionAction.do?cmd=toInsert";
        //window.open(url,'','height=300px,width=650px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘职位新增');
        showModalCenter("<%=request.getContextPath()%>/Job_positionAction.do?cmd=toInsert",dc1,null,750,400,"新增职位信息");
    }
    
    //修改行
    function toModifySub_onClick(){
        var dc1 = $id("datacell1");
        showModalCenter("<%=request.getContextPath()%>/Job_positionAction.do?cmd=toUpdate",dc1,null,750,400,"修改职位信息");
    }

//删除行
    function deleteMulti_onClick(){
        var dc1 = $id("datacell1");
        dc1.deleteRow(); 
    }

//每行数据第一列生成复选框
function setCheckboxStatus(value,entity,rowNo,cellNo){
       // if(entity.getProperty("isgenerated") == "1"){
       //     return "<input type='checkbox' name='temp' disabled='true' value="+entity.getProperty("ischecked")+">";
        //}
        return "<input type='checkbox' name='temp' />";
}
    
</script>
</head>
<body onload="initdata();">
<script type="text/javascript">
function initdata(){
    var dc = window["dialogArguments"];
    var entity = dc.getActiveEntity();
    $id("cust_id").value = entity.getProperty("cust_id");
    $id("customer_code").value = entity.getProperty("customer_code");
    $id("customer_name").value = entity.getProperty("customer_name");
    $id("contract_id").value = entity.getProperty("contract_id");
    $id("contract_code").value = entity.getProperty("contract_code");
    $id("contract_name").value = entity.getProperty("contract_name");
    $id("order_id").value = entity.getProperty("id");
    
    $id("lk_cust").value = entity.getProperty("cust_id");
    $id("lk_cust").setDisplayValue(entity.getProperty("customer_name"));
    $id("cost_center_id").addParam("cust_id", entity.getProperty("cust_id"));
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    
    $id("datacell1").addParam("order_id",entity.getProperty("id"));
}
</script>
<h:form checkType="blur" name="form" method="post" id="datacell_formid">
<input type="hidden" id="order_id" name="order_id"/>
<input type="hidden" id="contract_id" name="contract_id"/>
<input type="hidden" id="contract_code" name="contract_code"/>
<input type="hidden" id="contract_name" name="contract_name"/>
<input type="hidden" id="customer_code" name="customer_code"/>
<input type="hidden" id="customer_name" name="customer_name"/>
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
             <td  class="td_1"  width="23%" ><span class="style_required_red">* </span>客户</td>
            <td  class="td_2 " width="28%" >
             <w:lookup lookupWidth="189px" onReturnFunc="rtnFunc" readonly="true" readOnly="true" id="lk_cust" name="lk_cust"
             lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=zp" dialogTitle="选择客户" height="460" width="600"/>
                <input type="hidden" name="cust_id" id="cust_id"">
            </td>
             <td  class="td_1"  width="23%" ><span class="style_required_red">* </span>成本中心</td>
            <td  class="td_2 " width="28%" >
               <r:comboSelect id="cost_center_id"
	            name="cost_center_id"  
	            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
	            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
	            width="180" validateAttr="allowNull=false;"></r:comboSelect>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>账单年月</td>
            <td class="td_2 " width="28%">
                <h:text id="bill_year_month" name="bill_year_month"  style="width=200px" 
                validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"  />
            </td>
            <td class="td_1" width="23%"><span class="style_required_red">* </span>付款日期</td>
            <td class="td_2"  width="28%">
                 <w:date format="yyyy-MM-dd" id="paymentdate" name="paymentdate" allowInput="false" allowNull="false" />
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" ><span class="style_required_red">* </span>公式</td>
            <td  class="td_2" width="28%" rowspan="3">
                <!-- <textarea rows="4" cols="25" id="formula" name="formula"></textarea> -->
                <h:textarea rows="4" cols="25" id="formula" name="formula" validateAttr="allowNull=false;"/>
            </td>
             <td  class="td_1" width="23%" >备注</td>
            <td  class="td_2" width="28%" rowspan="3">
                 <!-- <textarea rows="4" cols="25" id="remark" name="remark"></textarea> -->
                 <h:textarea rows="4" cols="25" id="remark" name="remark" />
            </td>
        </tr>
    </table>
</div>
    <div class="clear"></div>
    
    <div class="xz_title">账单明细</div>
    <!-- 
    <div class="button">
            <div class="button_right">
                <ul>
                  <li class="a"><a onClick="javascript:toView_onClick();"><fmt:message key="view" /> </a></li>
                  <li class="c"><a onClick="javascript:toAddSub_onClick();"><fmt:message key="insert" /> </a></li>
                  <li class="b"><a onClick="javascript:toModifySub_onClick();"><fmt:message key="modify" /> </a></li>
                  <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li>                     
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        -->
        <div style="padding: 0 8 8 8;">
               <r:datacell 
                id="datacell1"
                paramFormId="datacell_formid"
                queryAction="/FAERP/Job_adviserAction.do?cmd=simpleQuery&source=jobbill"
                xpath="JobPositionVo"
                submitAction="/FAERP/BillOthersAction.do?cmd=insertJobBill"
                submitXpath="JobPositionVo"
                width="99%"
                height="210px" >
                 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                    <r:field fieldName="ischecked" label="操作" align="center" width="50px" allowModify="false" >
                        <h:switchCheckbox name="temp" checkedValue="1" uncheckedValue="0" property="ischecked"/>
                    </r:field>
                     <r:field fieldName="is_invoiced" label="" width="0px" allowModify="false">
                    </r:field>
                    <r:field fieldName="position" label="招聘职位" width="120px" allowModify="false">
                    </r:field>
                    <r:field fieldName="job_number" label="招聘数量" width="60px">
                    </r:field>  
                    <r:field fieldName="salary_range" label="薪资范围" width="120px">
                        <d:select dictTypeId="SALARY_RANGE_BD" disabled="true"/>
                    </r:field>
                    <r:field fieldName="position_status" label="职位状态" width="100px" >
                        <d:select dictTypeId="ORDER_STATUS_BD" disabled="true"/>
                    </r:field>
                    <r:field fieldName="amount" label="金额" width="100px" >
                        <h:text name="hamount" validateAttr="type=number;" />
                    </r:field>
                    <r:field fieldName="charge_desc" label="收费摘要" width="250px">
                         <h:textarea name="hremark" rows="3" cols="30" />
                    </r:field>
            </r:datacell>
        </div>
        <p></p>
        <div class="foot_button" style="text-align: center; margin-left: 0px;">
                <input type="button" class="icon_2" value='确定' onClick="javascript:save_onClick();"/>
                <input type="button" class="icon_2" value='返回' onClick="javascript:window.close();"/>
        </div>
</h:form>   
</body>
</fmt:bundle>
</html>
<script type="text/javascript" language="javascript">
$id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
    return true;
}
</script>   
