<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
    FinbillVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute("billVo") != null) {  //如果request中取出的bean不为空
            resultVo = (FinbillVo)request.getAttribute("billVo");  //从request中取出vo, 赋值给resultVo
        }
    }
    boolean isView = request.getAttribute("isView") == null ? false : true;
    
    String id = "";
    if(resultVo != null) {
        id = resultVo.getId();
    }
    boolean wfShow = false;
    if(request.getParameter("wfShow") != null){
        wfShow = true;
    }
%>
<%@page import="rayoo.finance.receivable.finbill.vo.FinbillVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
var isView = "${isView}";
jQuery(function(){
/*
    if(isView=="true"){//查看页面
        jQuery(".button_right ul li").hide();
        jQuery("#update_button").hide();
        jQuery("#checkButton").hide();
    }else{
        
    }
    jQuery("#button_content").show();

    $id("datacell_sc").isQueryFirst = false;// 
    $id("datacell_tpl_para").isQueryFirst = false;// 
    $id("datacell_sc_item").isQueryFirst = false;// 
    var id= jQuery("#tpl_id").val();
    if(id){
        simpleQuery_onClick();
        var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
        tpl_sc_list_div.show();
    }
    */
});
function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell_sc").loadData();
    $id("datacell_sc").refresh();
    
    $id("datacell_tpl_para").loadData();
    $id("datacell_tpl_para").refresh();
}
function checkAllForms(){
    return true;

}
function generatebill_onClick(){  //
    if(checkAllForms()){
    
        var update_button = jQuery("#update_button");
        update_button.attr({"disabled":"disabled"});
            
            
        var datacell_cp = $id("datacell_cp");
        
        var dataset1 = datacell_cp.dataset;//取得页面的datacell
        datacell_cp.isModefied = true;
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            datasettr.status = Entity.STATUS_NEW;
        }
        
        if(datacell_cp.submit()){
            jq("#bill_id").val("");
            datacell_cp.loadData();
            datacell_cp.refresh();
            alert("修改账单并提交审批成功！");
            afterClose();
            window.close();
        }else{
            alert("修改账单失败！");
        }
        
    }
}

function afterClose() {
    var dc = window.opener.$id("datacell");
    dc.reload();
}
function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
    var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
    var number = 0;  //定义游标
    var ids = null;  //定义id值的数组
    for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
        
        if(elementCheckbox[i].checked) {  //如果被选中
            number += 1;  //游标加1
            if(ids == null) {
                ids = new Array(0);
            }
            ids.push(elementCheckbox[i].value);  //加入选中的checkbox
        }
    }
    return ids;
}
        
function cancel_onClick(){  //取消后返回列表页面
    location.href='javascript:history.go(-1);';
}
    


//导出
function exportRepot_onClick(show_type){
    var reportFileName = '';
    if(show_type == 1){
        reportFileName = "finout_bill_report_zh.raq";
    }
    else if(show_type == 2){
        reportFileName = "finout_bill_report_en.raq";
    }
    window.location = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showFinoutBillReport.jsp?reportFileName=" +
    reportFileName + 
    "&bill_id=${billVo.id}" + 
    "&show_type=" + show_type;
}

        
</script>
</head>
<body>
<form action="" id="form4datacell_cp" name="form">
    <input type="hidden" id="bill_id" name="bill_id" value="${billVo.id}">
<!--    <input type="hidden" id="contract_id" name="contract_id" value="${param.contract_id }">-->
<!--    <input type="hidden" id="bill_year_month" name="bill_year_month">-->
<!--    <input type="hidden" id="cust_id" name="cust_id">-->
<!--    <input type="hidden" id="cost_center_id" name="cost_center_id">-->
<!--    <input type="hidden" id="bill_type_bd" name="bill_type_bd">-->
<!--    <input type="hidden" id="front_service_user_id" name="front_service_user_id">-->
    <input type="hidden" id="cmd" name="cmd">
    

<div id="right">
<script language="javascript">
</script>



 
<div class="ringht">

   

<!--    <div class="right_title_bg">-->
<!--      <div class=" right_title"></div>-->
<!--    </div>-->



<div id="s_p_list_div"  style="">

    <div style="padding: 8 10 8 8;">
        
            
            <div class="xz_title" style="padding-top: 10px" align="center">${billVo.cust_name} ${billVo.bill_year_month} 应付明细</div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
                                <li class="p_1">      <a onClick="javascript:exportRepot_onClick(1);">导出中文版WORD </a></li>
                                <li class="p_1">      <a  onClick="javascript:exportRepot_onClick(2);">导出英文版WORD </a> </li>
                            </ul>
                            
                            
                        </div>
                        <div align="right">
                            账单号：${billVo.bill_code}
                        </div>
            </div>
            
              <r:datacell id="datacell_cp" 
                queryAction="/FAERP/BillOthersAction.do?cmd=searchXltype" width="99%" height="200px"
                submitAction="/FAERP/Finout_contract_productAction.do?cmd=updateBill"
                xpath="BillOthersVo" paramFormId="form4datacell_cp"
                submitXpath="BillOthersVo"
                    >
              
              
              <r:field fieldName="charge_item_name" label="收费项" width="300px">
                       
              </r:field>
              
              <r:field fieldName="charge_desc" label="收费描述" width="300px" >
<!--                <h:text validateAttr="maxLength=100;"/>-->
              </r:field>
              
              <r:field fieldName="amount" label="价格" width="100px" ></r:field>    
              <r:field fieldName="p_count" label="数量" width="100px" ></r:field>
              
              </r:datacell>
        </div>
        
<!--            <div align="left">-->
<!--                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;审核意见-->
<!--    -->
<!--     -->
<!--                -->
<!--                <textarea rows="5" cols="80" ></textarea>-->
<!--            -->
<!--            </div> -->
           
           
           
      </div>
   </div>
   
   
   
   
   <div id="ccChild1"     class="box_xinzeng" style="height: 30px;" align="center">
    
    
            <input id="taskuid" name="taskuid" type="hidden"  value="${taskuid }"/>
            <input id="info_msg" name="info_msg" type="hidden"  value=""/>
            <input type="button" class="icon_2" value="审批通过" onclick="javascript:appOperate_onClick();"/>
            <input type="button" class="icon_3" value="审批不通过" onclick="javascript:backOperate_onClick();"/>
            
        
        
        <input id="return_button" type="button" class="icon_2" value="返回" onclick="javascript:cancel_onClick()"/>
        
        
        
    </div>





</div>
    








</fmt:bundle>

</form>
</body>
</html>


<script type="text/javascript">


var his_p_count;
var p_count;
 $id("datacell_cp").afterRefresh = function(){
 
    var datacell = $id("datacell_cp");
 
    var rows = datacell.allTR;
    
    for (var i=0;i<rows.length;i++ ){
        var entity1 = datacell.dataset.get(i);
        var cells = rows[i].cells;
        
        his_p_count = entity1.getProperty("his_p_count");
        his_p_count = parseInt(his_p_count);
        var item_type = entity1.getProperty("item_type");
        
        if(item_type == 1){ // 产品的才能修改 变色
	        for (var j=0;j<cells.length;j++ ){
	            var cell = cells[j];
	            var field = datacell.getField(cell);
	            
	            if(field.fieldName=="p_count"){
	                p_count =entity1.getProperty(field.fieldName);
	                p_count = parseInt(p_count);
	                
	                if(his_p_count != p_count){
	                    cell.style.backgroundColor = "red";
	                }
	            }
	        }
            
        }
    }
}

    
    
    

function appOperate_onClick() {
    var message = addAppReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
        
    form.action = "<venus:base/>/FinbillAction.do?message=" + message[0]
            + "&_ts=" + (new Date()).getTime();
    document.getElementById("cmd").value = "appOperate";

    form.submit();

}

// 驳回操作 不同意
function backOperate_onClick() {
    
    // 驳回原因
    var message = addBackReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
    var url = "<%=request.getContextPath()%>/FinbillAction.do?date=" + new Date();
    form.action = url;
    document.getElementById("info_msg").value = message[0];
    document.getElementById("cmd").value = "backOperate";
    form.submit();

}

// 撤销操作
function cancelOperate_onClick() {
    // 驳回原因
    var message = addBackReason("<%=request.getContextPath()%>");
    if (message == null)
        return;
    form.action = "<venus:base/>/FinbillAction.do?message=" + message[0];
    document.getElementById("cmd").value = "cancelOperate";
    form.submit();
}



jq(function(){


});
function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
var datacellDatas = {};
function simpleQuery_onClick_exp(){  //简单的模糊查询
    $id("datacell_cp_exp").loadData();
    $id("datacell_cp_exp").refresh();
}
function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell_cp").loadData();
    $id("datacell_cp").refresh();
}



function toAdd_onClick() {
    var contract_id = jq('#contract_id').val();
    if(!contract_id){
        alert("请先选择合同！");
        return;
    }
    $id("datacell_cp").addRow();
}

function deleteMulti_onClick(){
    $id("datacell_cp").deleteRow();
}



</script>

<script language="javascript">

function f_check_tpl_para(obj) {
    var str = obj.value;
    var datacell = $id("datacell_tpl_para");
    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);// 得到当前操作的行dataset
    
    if (datasettr.getProperty("data_type") == '0') {
        if (isNaN(str)) {
            f_alert(obj, "数据类型为数字，不能输入字符！");
            return false;
        }
    }
    return true;
}

function process_is_in_bill_exp(value,entity,rowNo,cellNo){
    var result = "否";
    if(value=="1"){
        result = "是";
    }else if(value=="2"){
        result = "否";
    }
    return result;
}
//报销状态1，未审批2，审批中，3审批通过
function showStatus4onRefreshFunc(value,entity,rowNo,cellNo){
    var result = "未审批";
    if(value=="1"){
        result = "未审批";
    }else if(value=="2"){
        result = "审批中";
    }else if(value=="3"){
        result = "审批通过";
    }
    return result;
}
</script>
