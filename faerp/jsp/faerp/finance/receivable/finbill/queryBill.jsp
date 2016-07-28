﻿<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
%>
<%@page import="gap.authority.helper.LoginHelper"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
.fex_row_top
 {
  top:expression(document.getElementById('div_top').scrollTop-2); 
     position:relative; 
     z-index:1;
     background-color: #DEE7FE;
 }
</style>
<script language="JavaScript" src="../../scripts/common.js"></script>
<script type="text/javascript">
    var _jQuery = window.jQuery, _$ = window.$;
    jQuery.noConflict();
    function rtnFuncCustomer(arg){
        
        var lookup = $id("customer_id");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        _$("#select_cust_id").val(arg[0]);
        $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
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
    
    //datacell checkbox begin
    function setCheckboxStatus(value,entity,rowNo,cellNo){
         var returnStr = "";
        returnStr =  "<input   type='checkbox' name='checkbox1' id='checkboxId' value=" + entity.getProperty("id") + ">";
        return returnStr;
    }
    function checkAllList(all){
        alert(all);
        if(all.checked){
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
                    element[i].checked= true;
                }
            } 
        }else{
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
                    element[i].checked= false;
                }
            } 
        }
    }
    
   
    //end
    function queryall(){
        $id("celllist1").addParam("customer_id",_$("#select_cust_id").val());
        $id("celllist1").addParam("customer_name",$id("customer_id").value);
        $id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
        $id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
        $id("celllist1").addParam("bill_gather_status_bd",$id("bill_gather_status_bd").options[$id("bill_gather_status_bd").selectedIndex].value);
        $id("celllist1").addParam("bill_type_bd",$id("bill_type_bd").options[$id("bill_type_bd").selectedIndex].value);
        $id("celllist1").addParam("max",$id("max").value);
        $id("celllist1").addParam("min",$id("min").value);
        $id("celllist1").addParam("approve_bd",$id("approve_bd").value);
        $id("celllist1").addParam("voucher_status",$id("voucher_status").value);
        $id("celllist1").addParam("bill_invoice_status_bd",$id("bill_invoice_status_bd").value);
        $id("celllist1").addParam("is_forecast",$id("is_forecast").value);
        //$id("celllist1").addParam("is_createvoucher",$id("is_createvoucher").value);
        $id("celllist1").addParam("create_date_from",$id("create_date_from").value);
        $id("celllist1").addParam("create_date_to",$id("create_date_to").value);
        $id("celllist1").addParam("bill_code",$id("bill_code").value);
        $id("celllist1").addParam("cust_code",$id("cust_code").value);
        $id("celllist1").addParam("user_name",$id("lk_cs").value);
        $id("celllist1").addParam("dept_name",document.getElementById("dept_name").value);
        $id("celllist1").addParam("voucher_class",document.getElementById("voucher_class").value);
        $id("celllist1").addParam("open_invoice",document.getElementById("open_invoice").value);
        $id("celllist1").addParam("is_bcfl",$id("is_bcfl").value);
        $id("celllist1").addParam("is_hongchong",$id("is_hongchong").value);     
        //2016-04-28  zhouxiaolong  删除账单时验证收据状态     begin
        //$id("celllist1").addParam("bill_receipt_status_bd",document.getElementById('bill_receipt_status_bd').value);
        //2016-04-28  zhouxiaolong  删除账单时验证收据状态     end
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
    
/**
 * 选择一条记录到明细审批页面
 */
function list2approvalItem() {
 /*
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
    var bill_id =ids[0] ;//entity.getValue("id");
    */

        var dc = $id("celllist1");
            var entity = dc.getActiveEntity();
            if(!entity){
                alert("请先选择一条记录");
                return ;
            }
        var bill_id = entity.getValue("id");
        
        var bill_type_bd = entity.getValue("bill_type_bd");
          if(bill_type_bd=="6"){
                      var w =800;
                        var h = 560;
                        var l =350;//(screen.width - w) / 2;
                        var t = 50;//(screen.height - h) / 2;
                        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                    var url=" <%=request.getContextPath()%>/RecruitrewardAction.do?cmd=detailFinbill&id=" + bill_id;
                        url=url+"&_ts="+(new Date()).getTime(); 
                        window.open(url, 'newwindow', s);
        }else if(bill_type_bd=="7"){//ibd账单
             //w为窗口宽度，h为高度
            var w = 1000;
            var h = 600;
            var l = 70;
            var t = 70;
            var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
            s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
            var url = "/FAERP/FinbillAction.do?cmd=list2item4approval4ibd&bill_id=" + bill_id;
            url=url+"&_ts="+(new Date()).getTime(); 
            window.open(url, 'newwindow', s);
        }else if(bill_type_bd=="5"){
        
	        //w为窗口宽度，h为高度
	        var w = 1250;
	        var h = 600;
	        var l = 70;//(screen.width - w) / 2;
	        var t = 70;//(screen.height - h) / 2;
	        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
	        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
	        var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
	        url=url+"&_ts="+(new Date()).getTime(); 
	        window.open(url, 'newwindow', s);
        } else{
      
      
	        //yangxu update start   
	        if (bill_id) {
	            //w为窗口宽度，h为高度
	            var w = 1250;
	            var h = 600;
	            var l = 70;//(screen.width - w) / 2;
	            var t = 70;//(screen.height - h) / 2;
	            var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
	            s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
	            var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
	            url=url+"&_ts="+(new Date()).getTime(); 
	            window.open(url, 'newwindow', s);
	            //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
	        }else{
	           alert('id is null');
	        }
        
        //yangxu update start end 
        
        /*
        _$.ajax({
            type : "post",
            url : "/FAERP/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
            dataType : "html",
            success : function(data) {
                if (data!=""&&data=="此账单无明细，数据可能异常。") {
                    alert("<fmt:message key='data_error'/>");
                } else {
                    if (bill_id) {
                        //w为窗口宽度，h为高度
                        var w = 1250;
                        var h = 600;
                        var l = 70;//(screen.width - w) / 2;
                        var t = 70;//(screen.height - h) / 2;
                        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                        var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
                        url=url+"&_ts="+(new Date()).getTime(); 
                        window.open(url, 'newwindow', s);
                        //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                    }else{
                       alert('id is null');
                    }
                }
            }
        });
        
        */
        
        
        }
}
/**
 * 预览凭证
 */
function showVoucher(){
    if(!checkOpenInvoice()){
        alert("<fmt:message key='alert_open_inovice'/>");
        return false;
    }
    var dc = $id("celllist1");
    var entity = dc.getActiveEntity();
    
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
    var bill_id =ids[0] ;//entity.getValue("id");
    if (bill_id) {
        //w为窗口宽度，h为高度
        var w = 815;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showVoucher&bill_id=" + bill_id +"&vtype=转"+"&vtitle=转账凭证";
        url = encodeURI(url);
        window.open(url, 'newwindow', s);
   }
}

//2014年9月10日 添加  预览红冲凭证
function showHongChongVoucher(){
    if(!checkOpenInvoice()){
        alert("<fmt:message key='alert_open_inovice'/>");
        return false;
    }
    var dc = $id("celllist1");
    var entity = dc.getActiveEntity();
    
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
    
    var bill_id =ids[0] ;//entity.getValue("id");
    if (bill_id) {
        //w为窗口宽度，h为高度
        var w = 900;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showHongChongVoucher&bill_id=" + bill_id +"&vtype=转"+"&vtitle=转账凭证";
        url = encodeURI(url);
        window.open(url, 'newwindow', s);
   }
}

   



function batchCreateVoucher(){
    if(!checkOpenInvoice()){
        alert("<fmt:message key='alert_open_inovice'/>");
        return false;
    }
    var ids = selectIds();
        if(ids == null || ids == '') {
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
        
        var bill_ids =ids;
        var url="<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finbill/setDate.jsp?bill_ids="+bill_ids+"&type=zhangdan";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, retCallback, 200, 120, "<fmt:message key='title_setDate'/>");  //增加子岗位
}
//账单合并导出
 function button_billmerge(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    var billYearMonth =null ;
    var datacell = $id("celllist1");
    var rows = datacell.getPageRowCount();
    var cust_code = null;
    var bill_id = "";//取哪个账单的前台服务人员的 联系方式
    for(var rowNo = 0 ;rowNo < rows; rowNo++ ){
        var row = datacell.getRow(rowNo);
        var entity = datacell.getEntity(row);
        var id = entity.getProperty("id");
        for(var i = 0 ;i < ids.length; i++ ){
               var selectid = ids[i];
               if(selectid == id){//选择的ID
               if(cust_code == null){
                   cust_code = entity.getProperty('cust_code');
               }else {
                   if(cust_code != entity.getProperty('cust_code')){
                       alert('您所以选择的账单 不属于同一个客户！不能合并导出账单！');
                       return;
                   }
               }
               if(billYearMonth ==null){
                  billYearMonth = entity.getProperty('bill_year_month');
               }
               else{
                 if(billYearMonth != entity.getProperty('bill_year_month')){
                       alert('您所以选择的账单 不属于同一个账单年月！不能合并导出账单！');
                       return;
                 }
               }
            }
        }
    }
    var login_name = document.form.login_name.value;
    var company_id = document.form.company_id.value;
    var year = billYearMonth.substring(0, 4)+"年"+billYearMonth.substring(4, 6)+"月";
    var bill_ids =ids;
    window.location = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showFinoutBillReport.jsp?reportFileName=bill_merge_print.raq"+"&arg1="+bill_ids+ "&arg2="+company_id+"&arg3="+login_name+"&arg4="+year;
   
 }


//合并导出
function merge_export(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    var datacell = $id("celllist1");
    var rows = datacell.getPageRowCount();
    var contract_id = null;
    var bill_id = "";//取哪个账单的前台服务人员的 联系方式
    for(var rowNo = 0 ;rowNo < rows; rowNo++ ){
        var row = datacell.getRow(rowNo);
        var entity = datacell.getEntity(row);
        var id = entity.getProperty("id");
        for(var i = 0 ;i < ids.length; i++ ){
            var selectid = ids[i];
            if(!bill_id){
                bill_id = selectid;
            }
            if(selectid == id){//选择的ID
            	
            	var approve_bd = entity.getProperty('approve_bd');
            	var cust_name = entity.getProperty('cust_name');
            	var bill_year_month = entity.getProperty('bill_year_month');
            	if(approve_bd != '3'){
            		alert('您所以选择的账单 '+cust_name + '-' + bill_year_month +'没有审核通过，不能导出！');
                    return;
            	}
               if(contract_id == null){
                   contract_id = entity.getProperty('contract_id');
               }else {
                   if(contract_id != entity.getProperty('contract_id')){
                       alert('您所以选择的账单 不属于同一个合同！不能合并导出！');
                       
                       return;
                   }
               }
               
            }
        }
    }
    
    
    
    var bill_ids =ids;
    window.location = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showFinoutBillReport.jsp?reportFileName=finout_bill_merge_report_zh.raq" + 
    "&bill_ids=" + bill_ids + "&bill_id=" + bill_id;
}



 function retCallback() {
 	queryall();
               /*var bill_ids = selectIds();
               var v_date=arg[0];//制单日期
               var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0";
               turl=turl+"&date="+v_date;  
               //alert("turl======"+turl);
               turl = encodeURI(turl);
               jQuery.ajax({
               url: turl,
               type: 'GET',
               dataType: 'html',
               timeout: 500000000,
               error: function(text){ 
                       alert(text);
                       return  null;
                   },
               success: function(text){
               //  alert(text);
                       alert(text);
                       //$id("celllist1").reload();
               }
           });  
 */
 }

    function checkOpenInvoice(){
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        var rs = true;
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                //只有凭证生成属性为 手工生成+实收状态为 未实收 才不允许 update by whj 20140825
                if (entity.getValue("voucher_class") == '1' && entity.getValue("bill_gather_status_bd")  =='3'){
                    rs = false;
                }
            }
        });
        return rs;
    }

    function selectIds() {
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                //此id为post_id
                //myids += entity.getValue("id") + ",";
                myids.push(entity.getValue("id"));
            }
        });
        return myids;
    }
    
      function checkAll(item) {
        if (_$(item).attr("checked")) {
            changeEntityChk(true);
            _$(":checkbox").attr("checked", true);
        } else {
            changeEntityChk(false);
            _$(":checkbox").attr("checked", false);
        }
    }
    
    function changeEntityChk(flag) {
        var dc1 = $id("celllist1").dataset;
        var values = dc1.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }


/**
 * 选择一条记录到明细修改页面
 */
function list2item() {
    
    var dc = $id("celllist1");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var bill_id = entity.getValue("id");
    _$.ajax({
        type : "post",
        url : "/FAERP/FinbillAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data) {
                alert(data);
            } else {
                if (bill_id) {
                    window.location.href = "/FAERP/FinbillAction.do?cmd=list2item&bill_id=" + bill_id;
                }
            }
        }
    });
}

function resetstr(){
    var lookup = $id("lk_cs");
    lookup.setValue("");
    lookup.setDisplayValue("");
}

_$(document).ready(function() {
        $id("celllist1").isQueryFirst = false;
});



function submit_appState_onClick() {  //从多选框到修改页面
    var dc = $id("celllist1");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var bill_id = entity.getValue("id");
    var bill_type_bd = entity.getValue("bill_type_bd");
    if(bill_type_bd!="5"){
        alert('非财务外包账单不能提交审批！');
        return;
    }
    var datasettr = entity;//得到当前操作的行dataset
    /*
    if(datasettr.getProperty("is_forecast")=='1'){
        alert('预估账单不能提交审批！');
        return;
    }
    */
    if(datasettr.getProperty("approve_bd")!='1' && datasettr.getProperty("approve_bd")!='4' ){
        alert('当前状态下不能提交审批！');
        return;
    }else{
        form.action="<%=request.getContextPath()%>/FinbillAction.do?id=" + bill_id;
        form.cmd.value = "createWF";
        form.submit();
   }
   
}
//回冲
function backwash(){
        var dc = $id("celllist1");
        var entity = dc.getActiveEntity();
        if(!entity){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var bill_id = entity.getValue("id");
        var bill_type_bd = entity.getValue("bill_type_bd");
        var is_forecast = entity.getValue("is_forecast");
        if(bill_type_bd=="5" && is_forecast == "1"){
            if (bill_id) {
                //w为窗口宽度，h为高度
                var w = 1250;
                var h = 600;
                var l = 70;//(screen.width - w) / 2;
                var t = 70;//(screen.height - h) / 2;
                var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                s += ', toolbar=no,scrollbars=yes,menubar=no,location=no,resizable=no,scrollbars=yes,resizable=yes,location=no,status=no'; 
                var url = "/FAERP/BillmodifyAction.do?cmd=list2itemPageByUpdate&bill_id=" + bill_id ;
                window.open(url, 'newwindow', s);
                //window.location.href = venusbase + "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
            }
        }else{
            alert("此账单不能回冲操作！");
        }
    
    }

//审批详细操作
    
    function spinto_onClick(){
        var dc = $id("celllist1");
        var entity = dc.getActiveEntity();
        if(!entity){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var bill_id = entity.getValue("id");
        var contract_id=bill_id;
        
        var wfname="finout_bill_work_flow";//此业务对应合同审批名称     
        var wfname1="finout_bill_work_flow";//此业务对应分配经办人
        //检查此单据是否正在走流程
         //alert('spinto_onClick审批详细');
        WfCommonAjax.checkCurrentWf_Info(wfname,wfname1,contract_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("没有发起过审批流程,不能进行此操作!");
                    return;
                }
                else{
                     //跳转到流程详细信息页面
                    var url = "/FAERP/jsp/faerp/sales/salcontract/processdetailpage.jsp?contract_id=" + contract_id+"&wfname="+wfname+"&wfname1="+wfname1+"&_ts='+(new Date()).getTime()";
                    showModalCenter(url, window, callBack,740, 360, "审批详细"); 
                }
            }
         );        
    
    }
    
    function callBack(reg){
       $id("celllist1").loadData();
       $id("celllist1").refresh();
    }
    
    //预览付款通知单
    function viewbillingnotice(){
        var dc = $id("celllist1");
            var entity = dc.getActiveEntity();
            if(!entity){
                alert("请先选择一条记录");
                return ;
            }
     
      var bill_type_bd = entity.getProperty("bill_type_bd");
      if(bill_type_bd != "6"){
        alert("该类型账单不支持付款通知单！");
        return ; 
      }
      var bill_id = entity.getProperty("id");
      var url = "/FAERP/jsp/faerp/job/job_bill/showBillingNotice.jsp?raq=Billing Notice.raq&bill_id="+bill_id+"&login_userid=<%=login_user_id%>";
      window.open(url,"","height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title='预览付款通知单' ");
    }







 //生成红冲凭证
 function createBillVoucher() {
 
            var dc = $id("celllist1");
            var entity = dc.getActiveEntity();
            if(!entity){
                alert("<fmt:message key='alert_select_one'/>");
                return ;
            }
            //alert(entity.getValue("is_createvoucher"));
            
            
            
            if(!(entity.getValue("voucher_status") == "1" &&  (entity.getValue("is_createvoucher") == "0" || entity.getValue("is_createvoucher") == "" ))){
                alert('此账单不可以红冲！');
                return;
            }
            var bill_ids = entity.getValue("id");
 
           //var _now ="${requestScope.currentDate}";
           //CurentDate();
           //alert("_now======"+_now);
           //var v_date=arg[0];//制单日期
           var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_type=hongchong";
           //turl=turl+"&date="+ new Date();  
           //alert("turl======"+turl);
           turl = encodeURI(turl);
           _$.ajax({
           url: turl,
           type: 'GET',
           dataType: 'html',
           async: false,
           timeout: 10000000,
           error: function(text){
                   alert(text);
                   hideProgressBar();
                   return  null;
               },
           success: function(text){
                   // if(text!=null &&text=="凭证已成功保存"){
                        alert(text);
                     //   updateBillCreatevoucher(bill_ids);
                    //    queryall();
                   // }else{
                    //  alert("生成红冲凭证失败！\n\n"+text);
                        //updateBillCreatevoucher(bill_ids);
                        //queryall();
                        //var url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
                        //window.location.href = url;
                   // }
           }
       });  
 
 }
 
 
 
  //修改是否已生成红冲凭证 1是0否
  function updateBillCreatevoucher(v_bill_id) {
    _$.ajax({
                    url : "/FAERP/FinbillAction.do?cmd=updateBillCreatevoucher&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){
                               alert(text);
                            }
                        }
       });
 }
 
 function rtnFuncCS(arg){
     var lookup = $id("lk_cs");
     lookup.value = arg[0];
     lookup.displayValue = arg[1];
     return false;
 }
 
 function rtnFuncDept(arg){
 	var lookup = $id("dept_name");
 	lookup.value = arg[0];
 	lookup.displayValue = arg[1];
 	return false;
 }
 
 //列表导出
  function exportBillToExcel(){
       var customer_id =  _$("#select_cust_id").val(); 
       var cust_name =  $id("customer_id").value;
       var cost_center_id =  _$("#cost_center_id_hidden").val(); 
       var bill_year_month =  _$("#bill_year_month").val(); 
       var min =  _$("#min").val(); 
       var max =  _$("#max").val(); 
       var bill_type_bd =  _$("#bill_type_bd").val(); 
       var bill_gather_status_bd =  _$("#bill_gather_status_bd").val(); 
       var approve_bd =  _$("#approve_bd").val(); 
       var voucher_status =  _$("#voucher_status").val(); 
       var bill_invoice_status_bd =  _$("#bill_invoice_status_bd").val(); 
       var is_forecast =  _$("#is_forecast").val(); 
       //var is_createvoucher =  _$("#is_createvoucher").val(); 
       var create_date_from =  _$("#create_date_from_hidden").val(); 
       var create_date_to =  _$("#create_date_to_hidden").val(); 
       var bill_code =  $id("bill_code").value;
       var cust_code =  $id("cust_code").value;
       var custservice_id =  $id("lk_cs").value;
       var cust_dept =  document.getElementById("dept_name").value;
       var is_bcfl =  _$("#is_bcfl").val(); 
       var is_hongchong = _$("#is_hongchong").val();
       //2016-04-28  zhouxiaolong  删除账单时验证收据状态     begin
       //var bill_receipt_status_bd=document.getElementById('bill_receipt_status_bd').value;
       //2016-04-28  zhouxiaolong  删除账单时验证收据状态     end
       if( (customer_id == "" || customer_id== null) && (cust_name == "" || cust_name== null) && (cost_center_id == "" || cost_center_id== null) &&(bill_year_month == "" || bill_year_month== null) &&(min == "" || min== null) &&(max == "" || max== null) && (bill_type_bd == "" || bill_type_bd== null) &&(bill_invoice_status_bd == "" || bill_invoice_status_bd== null) &&(is_forecast == "" || is_forecast== null)  && (create_date_from == "" || create_date_from== null) &&(create_date_to == "" || create_date_to== null) &&(custservice_id == "" || custservice_id== null) &&(cust_dept == "" || cust_dept== null) &&(bill_gather_status_bd == "" || bill_gather_status_bd== null) &&(approve_bd == "" || approve_bd== null) && (cust_code == "" || cust_code== null) && (voucher_status == "" || voucher_status== null)  &&(bill_code == "" || bill_code== null) ){
         alert("不输入任何条件会导致数据量过大，造成导出失败，请输入相应的查询条件！");
         return;
       }
       form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=exportBillToExcel&customer_id="+customer_id+"&cost_center_id="+
                           cost_center_id+"&bill_year_month="+bill_year_month+"&min="+min+"&max="+
                           max+"&bill_type_bd="+bill_type_bd+"&bill_gather_status_bd="+bill_gather_status_bd+"&approve_bd="+
                           approve_bd+"&cust_name="+encodeURI(cust_name)+"&voucher_status="+voucher_status+"&bill_invoice_status_bd="+bill_invoice_status_bd+"&is_forecast="+is_forecast
                           +"&create_date_from="+create_date_from+"&create_date_to="+create_date_to+"&bill_code="+bill_code+"&custservice_id="+custservice_id+"&cust_dept="+cust_dept+"&is_bcfl="+is_bcfl+"&is_hongchong="+is_hongchong;
       form.submit();
  }
 
//账单申请的发票附件下载
function downloadAttachment(){
   var dc = $id("celllist1");
   var entity = dc.getActiveEntity();
   if(!entity){
       alert("请先选择一条记录");
       return ;
   }
   var bill_id = entity.getValue("id");  
    _$.ajax({
           url : "/FAERP/FinbillAction.do?cmd=queryInvoiceAttachment&bill_id="+bill_id+"&_ts="+(new Date()).getTime(),
           type: 'GET',
           dataType: 'html',
           async: false,
           timeout: 10000,
           error: function(){
               alert('Error loading XML document');
               return  null;
           },
           success: function(text){
               if(text=="1"){
                    form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=downloadAttachment&bill_id="+bill_id;
                    form.submit();
                    form.action="";
               }else{
                    alert(text);
               }
           }
    });
} 
//账单下载
function downloadBillFile(){
   var dc = $id("celllist1");
   var entity = dc.getActiveEntity();
   if(!entity){
       alert("请先选择一条记录");
       return ;
   }
   var bill_id = entity.getValue("id");  
    _$.ajax({
           url : "/FAERP/FinbillAction.do?cmd=queryBillFileName&bill_id="+bill_id,
           type: 'GET',
           dataType: 'html',
           async: false,
           timeout: 10000,
           error: function(){
               alert('Error loading XML document');
               return  null;
           },
           success: function(text){
                var texts = text.split("&");
                if(texts.length>1)
                {
	               if(texts[0] == 1){
	            	   	form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=downLoadBill&excelName="+texts[1]+"&customer_name="+ texts[2] +"&bill_year_month="+ texts[3];
	                    form.submit();
	                    form.action="";
	               }else{
	                    alert(texts[1]);
	               }
                }
           }
    });
} 

//账单解锁和账单删除申请
function applyChangeBill(type){
   var dc = $id("celllist1");
   var entity = dc.getActiveEntity();
   var title;//申请页面显示名称
   if(!entity){
       alert("请先选择一条记录");
       return ;
   }
   
   var bill_type_bd = entity.getValue("bill_type_bd");//账单类型
   var is_closed = entity.getValue("is_closed");//关账状态
   var bill_lock_status_bd = entity.getValue("bill_lock_status_bd");//锁定状态
   var approve_bd = entity.getValue("approve_bd");//审批装填
   var bill_gather_status_bd = entity.getValue("bill_gather_status_bd");//实收状态
   var bill_invoice_status_bd = entity.getValue("bill_invoice_status_bd");//开票状态
   var voucher_status = entity.getValue("voucher_status");//凭证状态
   var is_createvoucher = entity.getValue("is_createvoucher");//红冲状态
   var bill_id = entity.getValue("id");  //账单id
   //2016-04-28  zhouxiaolong  删除账单时验证收据状态     begin
   //var bill_receipt_status_bd = entity.getValue("bill_receipt_status_bd");  //收据状态
   //2016-04-28  zhouxiaolong  删除账单时验证收据状态     end
   
   if(approve_bd == "2"){
        alert("当前账单正在审批中，请等待审批完成！");
        return;
   }
   
   if(type == 1){
       //解锁账单
       if(is_closed != "1"){
           alert("当前账单未关账，无需解除结账！");
           return;
       }
       title = "账单解锁申请";
   }else if (type == 2){
       //删除账单
       if(bill_type_bd != "2" && bill_type_bd != "5"){
           alert("只有社保账单与财务外包账单才允许删除账单！");
           return;
       }
       if(is_closed == "1"){
           alert("当前账单已关账，不允许删除账单！");
           return;
       }
       if(bill_lock_status_bd == "1"){
           alert("当前账单已锁定，不允许删除账单！");
           return;
       }
       if(bill_gather_status_bd != "3"){
           alert("当前账单已有核销记录，不允许删除账单！");
           return;
       }
       if(bill_invoice_status_bd != "1"){
           alert("当前账单已有开票记录，不允许删除账单！");
           return;
       }
       if(voucher_status == "1"  && is_createvoucher != "1"){
           alert("当前账单已生成凭证且未红冲，不允许删除账单！");
           return;
       }
  	 //2016-04-28  zhouxiaolong  删除账单时验证收据状态     begin
	 //  if(bill_receipt_status_bd!='1'){
	 //	   alert("当前账单已有收据记录，不允许删除账单！");
	 //	   return;
	 //  }
	   //2016-04-28  zhouxiaolong  删除账单时验证收据状态     end
       title = "账单删除申请";
   }
   var url="<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finbill/unLockOrDeleteBillApply.jsp?bill_id="+bill_id+"&type="+type+"&_ts="+(new Date()).getTime();
   showModalCenter(url, window, retCallback, "880", "250", title);  //填申请原因
}
  
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<input type="hidden" name="cmd" value="">
<input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
<input type="hidden" name="company_id" id="company_id" value="<%=LoginHelper.getLoginVo(request).getCompany_id()%>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_querybill'/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
            <td width="138" rowspan="8" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
          
            <td width="76"/>
            <td width="281"/>
              <td width="78">    </td>
                <td width="270"/>
        </tr>
  <tr>
   <td class="td_1"><fmt:message key='select_customer'/></td>
        <td class="td_2">
        <div><w:lookup onReturnFunc="rtnFuncCustomer" 
            id="customer_id" name="customer_id" property="customer_id"
            displayProperty="customer_name"
            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
            messagekey="select_customer" height="450" width="610" style="width:172px"  /></div>
        </td>
        <input type="hidden" id="select_cust_id" value="" />
        <td class="td_1"><fmt:message key='cost_center'/></td>
        <td align="left"><r:comboSelect id="cost_center_id"
            name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
         width="190" messagekey="please_select">
        </r:comboSelect></td>
        <td width="54"><fmt:message key='bill_year_month'/></td>
    <td width="212"><input type="text" value="" class="sText"
            id="bill_year_month" name="bill_year_month" /></td>
  </tr>
  <tr>
    <td><fmt:message key='bill_amount'/>(>)</td>
    <td><input type="text" value="" class="sText" id="min"/></td>
    <td><fmt:message key='bill_amount'/>(<)</td>
    <td><input type="text" value="" class="sText" id="max"/></td>
        <td width="54"><fmt:message key='bill_type_bd'/></td>
     <td align="left">
          <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_type_bd", -1,"FB_BILL_TYPE_BD",  request.getAttribute("bill_type_bd") == null ? "" : String.valueOf(request.getAttribute("bill_type_bd")),"inputName='应收类型'  style='width:190px' id='bill_type_bd'", false)%>
          
    </td>
  </tr>
  <tr>
    <td><fmt:message key='bill_gather_status_bd'/></td>
    <td align="left">
        <%=gap.rm.tools.helper.RmJspHelper.getSelectField( "bill_gather_status_bd", -1,"GATHER_STATUS_BD", request.getAttribute("bill_gather_status_bd") == null ? "" : String.valueOf(request.getAttribute("bill_gather_status_bd")), "inputName='实收状态'  style='width:190px' id='bill_gather_status_bd'", false)%>
   </td>
     <td align="left"><fmt:message key='approve_bd'/></td>
        <td align="left">
            <d:select  name="approve_bd" id="approve_bd" dictTypeId="BILL_APPR_STATUS" nullLabel="--请选择--" style="width:190px"/>
        </td>
    <td align="left"><fmt:message key='voucher_status'/></td>
        <td align="left">
            <d:select name="voucher_status" id="voucher_status" dictTypeId="VOUCHER_STATUS" nullLabel="--请选择--" style="width:190px"/>
        </td>
    
  </tr>
  <tr>
  <td align="left"><fmt:message key='bill_invoice_status_bd'/></td>
  <td align="left"><d:select name="bill_invoice_status_bd" id="bill_invoice_status_bd" dictTypeId="INVOICE_STATUS_BD" nullLabel="--请选择--" style="width:190px"/></td>
  <td align="left"><fmt:message key='is_forecast'/></td>
  <td align="left">
    <select name="is_forecast" id="is_forecast" style="width: 190px;">
      <option value="" selected="selected">--请选择--</option>
      <option value="1">是</option>
      <option value="2" >否</option>
    </select>
  </td>
  <td align="left">开票属性</td>
  <td align="left"><d:select name="open_invoice" id="open_invoice" dictTypeId="OPEN_INVOICE" nullLabel="--请选择--" style="width: 189px"/></td>
  <!--  <td align="left"><fmt:message key='is_createvoucher'/></td>
  <td align="left">
   <select name="is_createvoucher" id="is_createvoucher" style="width: 190px;">
     <option value="" selected="selected">--请选择--</option>
     <option value="1">是</option>
     <option value="0" >否</option>
  </select>
  </td>-->
  </tr>
 <tr>
    <td align="left">开票日期</td>
    <td align="left"><w:date format="yyyy-MM-dd" name="create_date_from" id="create_date_from" width="72px"/>至<w:date format="yyyy-MM-dd" name="create_date_to" id="create_date_to" width="72px"/></td>
    <td align="left">账单编号</td>
    <td>
        <input type="text" value="" class="sText" id="bill_code" name="bill_code"/>
    </td>
    <td align="left">客服名称</td>
    <td align="left">
      <w:lookup onReturnFunc="rtnFuncCS" style="width:175px" readonly="true" id="lk_cs" name="user_name" lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" height="450" width="500px"/>
    </td>
</tr>
  <tr>
    <td align="left">客服部门</td>
    <td align="left">
    <w:lookup onReturnFunc="rtnFuncDept" readonly="true"
            id="dept_name" name="dept_name"
            lookupUrl="/FinbillAction.do?cmd=getAllDeptByCondition"
            messagekey="选择客服部门" height="450" width="610" style="width:172px"  />
    
    </td>
    <td align="left">凭证属性</td>
    <td align="left"><d:select name="voucher_class" id="voucher_class" dictTypeId="VOUCHER_CLASS" nullLabel="--请选择--" style="width: 189px"/></td>
    <td align="left">否包含补充福利</td>
	<td align="left">
		 <select name="is_bcfl" id="is_bcfl" style="width: 190px;">
		   <option value="" selected="selected">--请选择--</option>
		   <option value="1">是</option>
		   <option value="0" >否</option>
		</select>
	</td>
  </tr>
  <tr>
    <td align="left">客户编号</td>
    <td>
        <input type="text" value="" class="sText" id="cust_code" name="cust_code"/>
    </td>
    <td align="left">是否红冲</td>
    <td>
        <select name="is_hongchong" id="is_hongchong" style="width: 190px;">
		   <option value="" selected="selected">--请选择--</option>
		   <option value="1">是</option>
		   <option value="0" >否</option>
		</select>
    </td>
    <!--   <td align="left">收据状态</td>
    <td>
         <select name="bill_receipt_status_bd" id="bill_receipt_status_bd" style="width: 190px;">
		   <option value="" selected="selected">--请选择--</option>
		   <option value="1">未开</option>
		   <option value="2">已开</option>
		   <option value="3">部分开</option>
		   <option value="4">待开</option>
		</select>
    </td>
    -->
  </tr>
  <tr>
  <td align="left"></td>
  <td align="left"><input type="button" class="icon_1" value="<fmt:message key='button_query'/>" onClick="queryall()" style="float:left;"/></td>
  <td align="left"><input name="button_reset2" class="icon_1" type="reset" value="<fmt:message key='button_reset'/>" onclick="resetstr()" /></td>
  </tr>
  
  
  
  
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right" style="width: 99%;">
        <!--<ul>
           <li class="b_1"><a href="javascript:void(0);" onClick="list2approvalItem()">查看明细</a></li>
        </ul>
        -->
        <input class="b_1" type="button"   value="<fmt:message key='button_ckmx'/>"  <au:authorityBtn code="cxzd_ckmx" type="1"/>  onClick="list2approvalItem();">
        <input class="b_1" type="button"   value="<fmt:message key='button_showVoucher'/>"  <au:authorityBtn code="cxzd_voucher_ckmx" type="1"/>  onClick="showVoucher();">
        <input class="p_1" type="button"   value="<fmt:message key='button_batchCreateVoucher'/>"  <au:authorityBtn code="batch_create_voucher" type="1"/>  onClick="batchCreateVoucher();">
        <input class="p_1" type="button"   value="账单合并导出"    onClick="button_billmerge();">
        
<!--    财务外包    -->
        <input class="b_1" type="button"   value="<fmt:message key='button_approve'/>"   onClick="submit_appState_onClick()">
        <input class="b_1" type="button"   value="<fmt:message key='button_approve_detail'/>"   onClick="spinto_onClick()">
        <input class="p_1" type="button"   value="<fmt:message key='button_merge_export'/>"   onClick="merge_export();">   
        <input class="b_1" type="button"   value="<fmt:message key='button_backwash'/>" <au:authorityBtn code="button_bill_backwash" type="1"/>     onClick="backwash();">
        
        <!-- 招聘管理 导出付款通知单 -->
        <!-- <input class="p_1" type="button"   value="付款通知单" <au:authorityBtn code="job_billingnotice" type="0"/>   onClick="viewbillingnotice();">-->
        <input class="p_1" type="button"   value="付款通知单"  onClick="viewbillingnotice();">
        <input class="b_1" type="button"   value="预览红冲"  <au:authorityBtn code="cxzd_ylhc" type="1"/>  onClick="showHongChongVoucher();">
        <!--  <input class="b_1" type="button"   value="红冲"  onClick="createBillVoucher();">  注释2014年9月11日 -->
        <input class="b_1" type="button"   value="列表导出" <au:authorityBtn code="cxzd_lbdc" type="1"/>   onClick="exportBillToExcel();">
        <input class="approdetial" type="button"   value="附件下载"  <au:authorityBtn code="cxzd_fjxz" type="1"/>  onClick="downloadAttachment();">
        <input class="f_1" type="button"   value="解锁账单"  <au:authorityBtn code="cxzd_jszd" type="1"/>  onClick = "applyChangeBill(1);">
        <input class="f_1" type="button"   value="删除账单"  <au:authorityBtn code="cxzd_sczd" type="1"/>  onClick= "applyChangeBill(2);">
        
        <input class="approdetial" type="button"   value="账单下载"  <au:authorityBtn code="cxzd_zdxz" type="1"/>  onClick="downloadBillFile();">
        
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/FinbillAction.do?cmd=queryForBillList"
            paramFormId="datacell_formid" width="99%" height="318px"
            xpath="FinbillVo" readonly="true" pageSize="90">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field allowModify="false" fieldName="chk"
                label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                sortAt="none" width="30px">
                <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
            </r:field>
            <r:field fieldName="cust_code" messagekey="customer_code" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="cust_name" messagekey="customer_name" width="170px">
                <h:text />
            </r:field>
            <r:field fieldName="cost_center_name" messagekey="cost_center" width="170px">
                <h:text />
            </r:field>
            <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="version" messagekey="version" width="50px">
                <h:text />
            </r:field>
            <r:field fieldName="bill_amount" messagekey="bill_amount" width="90px">
                <h:text />
            </r:field>
            <r:field fieldName="rate_odds" label="小额调整" width="90px">
            </r:field>
            <r:field fieldName="bill_gather_status_bd" messagekey="bill_gather_status_bd" width="100px">
                <d:select dictTypeId="GATHER_STATUS_BD" />
            </r:field>
            <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="100px">
                <d:select dictTypeId="BILL_TYPE_BD" />
            </r:field>
            <r:field fieldName="create_date" messagekey="create_date" width="140px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
            <r:field fieldName="create_user_name" messagekey="create_user_name" width="100px">
                <h:text />
            </r:field>
            <r:field fieldName="bill_invoice_status_bd" messagekey="bill_invoice_status_bd" width="70px">
                <d:select dictTypeId="INVOICE_STATUS_BD" />
            </r:field>
            <r:field fieldName="closed_date" messagekey="closed_date" width="90px">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="approve_bd" messagekey="approve_bd" width="90px">
                <d:select dictTypeId="BILL_APPR_STATUS"></d:select>
            </r:field>
            <r:field fieldName="voucher_status" messagekey="voucher_status" width="90px">
                <d:select dictTypeId="VOUCHER_STATUS"></d:select>
            </r:field>  
            <r:field fieldName="voucher_ym" messagekey="voucher_ym" width="90px">
            </r:field>
            <r:field fieldName="is_forecast"  width="90px" messagekey="is_forecast"  onRefreshFunc="process_is_forecast" >
            </r:field>
            <r:field fieldName="hongchongvoucher_ym" label="红冲凭证号" width="90px">
            </r:field>
            <r:field fieldName="is_createvoucher"  width="120px" messagekey="is_createvoucher"  onRefreshFunc="process_is_createvoucher" >
            </r:field>
            <r:field fieldName="bill_code" label="账单编号" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="invoice_code" label="发票编号" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="invalid_invoice_code" label="红冲发票号" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="invoice_make_date" label="开票时间" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="user_name" label="客服" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="dept_name" label="客服部门" width="100px" allowModify="false">
            </r:field>
            <r:field fieldName="open_invoice" label="开票属性">
        		<d:select dictTypeId="OPEN_INVOICE"/>
        	</r:field>
        	<r:field fieldName="voucher_class" label="凭证属性">
                <d:select dictTypeId="VOUCHER_CLASS"/>
            </r:field>
        </r:datacell>
        </div>
        </div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
    </div>
</form>
</body>
</fmt:bundle>
</html>
<script language="javascript">
function process_is_createvoucher(value,entity,rowNo,cellNo){
    var result = "";
    if(value=="1"){
        result = "是";
    }else if(value=="0"){
        result = "否";
    }
    return result;
}


function process_is_forecast(value,entity,rowNo,cellNo){
    var result = "否";
    if(value=="1"){
        result = "是";
    }else if(value=="2"){
        result = "否";
    }
    return result;
}

</script>