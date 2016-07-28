<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
var jq = jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.finance.bill.salarybatch.salarybatch_resource" prefix="rayoo.finance.bill.salarybatch.">
<html>

<head>

<title><fmt:message key='title_salarybatch'/></title>

<script language="javascript">

function findChecks(dcObject, checkBoxId, retProperty){
    var retStr = '';
    var dataset1 = dcObject.dataset;
    for(var i=0; i < dataset1.getLength(); i++){
        var checked = dataset1.get(i).getProperty(checkBoxId);
        if (checked){
            if(retStr == ''){
                retStr = retStr + dataset1.get(i).getProperty(retProperty);
             }else{
                retStr = retStr + "," + dataset1.get(i).getProperty(retProperty);
             }
         }
    }
    return retStr;
}

function generateBill(is_welfare){
    var frm = $id("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          
          return;
      }    
      
     var currentbillym_pvalue=${requestScope.currentbillym_pvalue};
     var bill_year_month=_$("#bill_year_month").val();
     
     /*
     if(bill_year_month<currentbillym_pvalue){
            alert("账单生成年月:"+bill_year_month+"不能小于当前账单年月:"+currentbillym_pvalue);
            return;
     }
     */
     
      var bill_type_bd=_$("#bill_type_bd").val();
      if(bill_type_bd==""){
            alert("<fmt:message key='alert_select_billType'/>");
            return;
      }
      if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
            alert("<fmt:message key='alert_select_costCenter'/>");
            return false ;
      }
      // Express 接口 验证
      /**if( getExpress() == false ) {
          return;
      }**/
      
      if(bill_type_bd=="5"){//finout
         if(!jq("#contract_id").val()){
             alert("<fmt:message key='alert_select_contract'/>");
             return;
         }
         
         var front_service_user_id = $id("front_service_user_id").getValue();
         var cost_center_id = $id("cost_center_id").getValue();
         
         jq("#front_service_user_id_hidden").val(front_service_user_id);
         jq("#cost_center_id_hidden").val(cost_center_id);
         if(!front_service_user_id){
             alert("请选择前台服务人员！");
             return;
         }
         if(jq("#is_forecast").val()=='0'){
             alert("<fmt:message key='alert_select_is_forecast'/>");
             return;
         }
         //vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/bill/salarybatch/finout_generate_bill_selectproduct.jsp?type=1","", "dialogWidth=1000px; dialogHeight=650px");
          
         window.open("<%=request.getContextPath()%>/jsp/faerp/finance/bill/salarybatch/finout_generate_bill_selectproduct.jsp?contract_id="+ jq("#contract_id").val());
         return;
      }
            
      if(bill_type_bd=="7"){//IBD合同
         if (bill_year_month.indexOf("00") == 4 ){
            alert("<fmt:message key='alert_paymonth_err'/>");
            return false;
         }
         var contract_id = jq("#contract_id").val();
         if(!contract_id){
             alert("<fmt:message key='alert_select_contract'/>");
             return;
         }
         
         var cost_center_id = $id("cost_center_id").getValue();
         jq("#cost_center_id_hidden").val(cost_center_id);

         window.open("<%=request.getContextPath()%>/jsp/faerp/finance/bill/salarybatch/ibd_generate_bill_selectproduct.jsp?contract_id="+ jq("#contract_id").val());
         
         return;
      }
      
   var ids = ''; 
   //ids=findChecks($id("datacell1") , "sa_check", "id");  //取得复选框的选择项
   ids = findSelections("checkbox_template","id");  //取得多选框的选择项
   //alert("bill_type_bd="+bill_type_bd+"ids="+ids);
   if(bill_type_bd=="1"&&(ids==""||ids==null)){
        alert("<fmt:message key='alert_select_batchRecord'/>");
        return;
   }
   $id("s_cost_center_id").value = $id("cost_center_id").getValue()  ;  //保存成本中心id
   var cost_center_id_new  = $id("cost_center_id").getValue()  ;
   //设置button不能点击
   $id("button_ok").disabled="disabled" ;
   //判断是直接生成还是后台生成账单
   $id("generatetype").value = "generateBill" ;
   //仅生成福利账单
   $id("is_welfare").value = is_welfare;
   //判断是否有随时收费，如果有弹框填写
   _$.ajax({
        type : "post",
       //由于随时收费暂时没用，现注释掉 tanyanjun  20140717
        url : "/FAERP/FinbillserviceyearmonthAction.do?cmd=isOpenPop&cost_center_id=" + cost_center_id_new+"&bill_year_month="+bill_year_month+"",
       // url : "/FAERP/EmpwelfarerecordAction.do?cmd=isHaveUnconfirmedData&cost_center_id=" + cost_center_id_new+"&bill_year_month="+bill_year_month+"",
        dataType : "html",
        success : function(data) {
            if (data!=""&&data=="0") {
                var ajax = new Ajax($id("datacell1").submitAction);
                ajax.addParam("ids", ids);
                ajax.submitForm(frm);
                showProgressBar();
                 var returnNode = ajax.getResponseXMLDom();
                 var retstr=ajax.getValue("root/data/returnValue");
                 //alert(retstr);
                 var retsinfo=retstr.split(",");
                 if(returnNode) {
                     if(retsinfo[0]=="1") {
                         hideProgressBar();
                         //alert( '调用成功!');
                         alert(retsinfo[1]);
                         $id("datacell1").reload();
                         $id("datacell1").refresh();
                         setTab03Syn(2);
                         document.getElementById('bg').className='xixi2';
                         //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
                     } else if (retsinfo[0]=="0"){
                         hideProgressBar();
                         alert("<fmt:message key='alert_invoke_fail'/>");
                         alert(retsinfo[1]);
                     }else{
                         hideProgressBar();
                         alert(retsinfo[1]);
                     }
                 } else {
                      hideProgressBar();
                      alert("<fmt:message key='alert_save_fail'/>");
                 }
                
            } else {
            
            //由于随时收费暂时没用，现注释掉 tanyanjun  20140717
           // var url = "/FAERP/jsp/faerp/finance/bill/finbillserviceyearmonth/listFinbillserviceyearmonth.jsp?cost_center_id="+cost_center_id_new+"&bill_year_month="+bill_year_month;
           // showModalCenter(url, "newid", "callBack", 700, 330, "账单随时付收费");  //增加子岗位
                 //随时付
                 //w为窗口宽度，h为高度
                //    var w = 650;
                  // var h = 400;
                 //   var l = 70;//(screen.width - w) / 2;
                  //  var t = 70;//(screen.height - h) / 2;
                  //  var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                  //  s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                  //  var url = "/FAERP/jsp/faerp/finance/bill/finbillserviceyearmonth/listFinbillserviceyearmonth.jsp?cost_center_id="+cost_center_id_new+"&bill_year_month="+bill_year_month;
                  //  window.open(url, 'name', s);
                if(confirm('当前客户有福利办理记录未处理，是否继续生成账单?')){
                    var ajax = new Ajax($id("datacell1").submitAction);
	                ajax.addParam("ids", ids);
	                ajax.submitForm(frm);
	                showProgressBar();
	                 var returnNode = ajax.getResponseXMLDom();
	                 var retstr=ajax.getValue("root/data/returnValue");
	                 //alert(retstr);
	                 var retsinfo=retstr.split(",");
	                 if(returnNode) {
	                     if(retsinfo[0]=="1") {
	                         hideProgressBar();
	                         //alert( '调用成功!');
	                         alert(retsinfo[1]);
	                         $id("datacell1").reload();
	                         $id("datacell1").refresh();
	                         setTab03Syn(2);
	                         document.getElementById('bg').className='xixi2';
	                         //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
	                     } else if (retsinfo[0]=="0"){
	                         hideProgressBar();
	                         alert("<fmt:message key='alert_invoke_fail'/>");
	                         alert(retsinfo[1]);
	                     }else{
	                         hideProgressBar();
	                         alert(retsinfo[1]);
	                     }
	                 } else {
	                      hideProgressBar();
	                      alert("<fmt:message key='alert_save_fail'/>");
	                 }
                }
            }
        }
    });
    
     //设置button能点击
   $id("button_ok").disabled="" ;
      return;
}

//随时付费弹框回调函数
function callBack(){
var generatetype = $id("generatetype").value  ;
var frm = $id("datacell_formid");
var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
if(generatetype=='generateBill'){
	var ajax = new Ajax($id("datacell1").submitAction);
			    ajax.addParam("ids", ids);
			    ajax.submitForm(frm);
			    showProgressBar();
			     var returnNode = ajax.getResponseXMLDom();
			     var retstr=ajax.getValue("root/data/returnValue");
			     //alert(retstr);
			     var retsinfo=retstr.split(",");
			     if(returnNode) {
			         if(retsinfo[0]=="1") {
			             hideProgressBar();
			             //alert( '调用成功!');
			             alert(retsinfo[1]);
			             $id("datacell1").reload();
			             $id("datacell1").refresh();
			             setTab03Syn(2);
			             document.getElementById('bg').className='xixi2';
			             //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
			         } else if (retsinfo[0]=="0"){
			             hideProgressBar();
			             alert("<fmt:message key='alert_invoke_fail'/>");
			             alert(retsinfo[1]);
			         }else{
			             hideProgressBar();
			             alert(retsinfo[1]);
			         }
			     } else {
			          hideProgressBar();
			          alert("<fmt:message key='alert_save_fail'/>");
			     }
		}else{
		var ajax = new Ajax('/FAERP/BillCreateAction.do?cmd=generateBillThread');
					    ajax.addParam("ids", ids);
					    ajax.submitForm(frm);
					    showProgressBar();
					     var returnNode = ajax.getResponseXMLDom();
					     var retstr=ajax.getValue("root/data/returnValue");
					     //alert(retstr);
					     var retsinfo=retstr.split(",");
					     if(returnNode) {
					         if(retsinfo[0]=="1") {
					             hideProgressBar();
					             //alert( '调用成功!');
					             alert(retsinfo[1]);
					             $id("datacell1").reload();
					             $id("datacell1").refresh();
					             setTab03Syn(2);
					             document.getElementById('bg').className='xixi2';
					             //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
					         } else if (retsinfo[0]=="0"){
					             hideProgressBar();
					             alert("<fmt:message key='alert_invoke_fail'/>");
					             alert(retsinfo[1]);
					         }else{
					             hideProgressBar();
					             alert(retsinfo[1]);
					         }
					     } else {
					          hideProgressBar();
					          alert("<fmt:message key='alert_save_fail'/>");
					     }
		
		}

}


function generateThreadBill(){
    var frm = $id("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          
          return;
      }    
      
     var currentbillym_pvalue=${requestScope.currentbillym_pvalue};
     var bill_year_month=_$("#bill_year_month").val();
     var bill_type_bd=_$("#bill_type_bd").val();
      if(bill_type_bd==""){
            alert("<fmt:message key='alert_select_billType'/>");
            return;
      }
       //当账单类型是仅社保福利时可以不选择成本中心
      if(bill_type_bd=="2"){
          
         $id("s_cost_center_id").value = $id("cost_center_id").getValue()  ;  //保存成本中心id
         if($id("cost_center_id").getValue() != null && $id("cost_center_id").getValue() != "" ){//&& getExpress() == false
               //如果选择成本中心
              // Express 接口 验证
	              return;
         }
         //设置button不能点击
          $id("button_ok").disabled="disabled" ;
          $id("generatetype").value = "generateThreadBill" ;
                var ajax = new Ajax('/FAERP/BillCreateAction.do?cmd=generateBillThread');
                ajax.addParam("ids", ids);
                ajax.submitForm(frm);
                showProgressBar();
                 var returnNode = ajax.getResponseXMLDom();
                 var retstr=ajax.getValue("root/data/returnValue");
                 //alert(retstr);
                 var retsinfo=retstr.split(",");
                 if(returnNode) {
                     if(retsinfo[0]=="1") {
                         hideProgressBar();
                         alert(retsinfo[1]);
                         $id("datacell1").reload();
                         $id("datacell1").refresh();
                         setTab03Syn(2);
                         document.getElementById('bg').className='xixi2';
                     } else if (retsinfo[0]=="0"){
                         hideProgressBar();
                         alert("<fmt:message key='alert_invoke_fail'/>");
                         alert(retsinfo[1]);
                     }else{
                         hideProgressBar();
                         alert(retsinfo[1]);
                     }
                 } else {
                      hideProgressBar();
                      alert("<fmt:message key='alert_save_fail'/>");
                 }
           //设置button能点击
         $id("button_ok").disabled="" ;
          return;
      }else{
      
      if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
	        alert("<fmt:message key='alert_select_costCenter'/>");
	        return false ;
      }
    // Express 接口 验证
      /**if( getExpress() == false ) {
          return;
      }**/
   var ids = ''; 
   //ids=findChecks($id("datacell1") , "sa_check", "id");  //取得复选框的选择项
   ids = findSelections("checkbox_template","id");  //取得多选框的选择项
   //alert("bill_type_bd="+bill_type_bd+"ids="+ids);
   if(bill_type_bd=="1"&&(ids==""||ids==null)){
        alert("<fmt:message key='alert_select_batchRecord'/>");
        return;
   }
   $id("s_cost_center_id").value = $id("cost_center_id").getValue()  ;  //保存成本中心id
   //设置button不能点击
   $id("button_ok").disabled="disabled" ;
   //判断是直接生成还是后台生成账单
   $id("generatetype").value = "generateThreadBill" ;
   var cost_center_id_new  = $id("cost_center_id").getValue()  ;
   //判断是否有随时收费，如果有弹框填写
   _$.ajax({
        type : "post",
        //由于随时收费暂时没用，现注释掉 tanyanjun  20140717
         url : "/FAERP/FinbillserviceyearmonthAction.do?cmd=isOpenPop&cost_center_id=" + cost_center_id_new+"&bill_year_month="+bill_year_month+"",
        //url : "/FAERP/EmpwelfarerecordAction.do?cmd=isHaveUnconfirmedData&cost_center_id=" + cost_center_id_new+"&bill_year_month="+bill_year_month+"",
        dataType : "html",
        success : function(data) {
            if (data!=""&&data=="0") {
                var ajax = new Ajax('/FAERP/BillCreateAction.do?cmd=generateBillThread');
			    ajax.addParam("ids", ids);
			    ajax.submitForm(frm);
			    showProgressBar();
			     var returnNode = ajax.getResponseXMLDom();
			     var retstr=ajax.getValue("root/data/returnValue");
			     //alert(retstr);
			     var retsinfo=retstr.split(",");
			     if(returnNode) {
			         if(retsinfo[0]=="1") {
			             hideProgressBar();
			             //alert( '调用成功!');
			             alert(retsinfo[1]);
			             $id("datacell1").reload();
			             $id("datacell1").refresh();
			             setTab03Syn(2);
			             document.getElementById('bg').className='xixi2';
			             //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
			         } else if (retsinfo[0]=="0"){
			             hideProgressBar();
			             alert("<fmt:message key='alert_invoke_fail'/>");
			             alert(retsinfo[1]);
			         }else{
			             hideProgressBar();
			             alert(retsinfo[1]);
			         }
			     } else {
			          hideProgressBar();
			          alert("<fmt:message key='alert_save_fail'/>");
			     }
            } else {
            //由于随时收费暂时没用，现注释掉 tanyanjun  20140717
           // var url = "/FAERP/jsp/faerp/finance/bill/finbillserviceyearmonth/listFinbillserviceyearmonth.jsp?cost_center_id="+cost_center_id_new+"&bill_year_month="+bill_year_month;
           // showModalCenter(url, "newid", "callBack", 700, 330, "账单随时付收费");  //增加子岗位
                 //随时付
                 //w为窗口宽度，h为高度
                //    var w = 650;
                 //  var h = 400;
                 //   var l = 70;//(screen.width - w) / 2;
                 //   var t = 70;//(screen.height - h) / 2;
                 //   var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                 //   s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                  //  var url = "/FAERP/jsp/faerp/finance/bill/finbillserviceyearmonth/listFinbillserviceyearmonth.jsp?cost_center_id="+cost_center_id_new+"&bill_year_month="+bill_year_month;
                 //   window.open(url, 'name', s);
                if(confirm('当前客户有福利办理记录未处理，是否继续生成账单?')) {
                    var ajax = new Ajax('/FAERP/BillCreateAction.do?cmd=generateBillThread');
				    ajax.addParam("ids", ids);
				    ajax.submitForm(frm);
				    showProgressBar();
				     var returnNode = ajax.getResponseXMLDom();
				     var retstr=ajax.getValue("root/data/returnValue");
				     //alert(retstr);
				     var retsinfo=retstr.split(",");
				     if(returnNode) {
				         if(retsinfo[0]=="1") {
				             hideProgressBar();
				             //alert( '调用成功!');
				             alert(retsinfo[1]);
				             $id("datacell1").reload();
				             $id("datacell1").refresh();
				             setTab03Syn(2);
				             document.getElementById('bg').className='xixi2';
				             //location.href="/FAERP/jsp/faerp/finance/receivable/finbill/queryBill.jsp";
				         } else if (retsinfo[0]=="0"){
				             hideProgressBar();
				             alert("<fmt:message key='alert_invoke_fail'/>");
				             alert(retsinfo[1]);
				         }else{
				             hideProgressBar();
				             alert(retsinfo[1]);
				         }
				     } else {
				          hideProgressBar();
				          alert("<fmt:message key='alert_save_fail'/>");
				     }
                }
                 
            }
        }
    });
     //设置button能点击
   $id("button_ok").disabled="" ;
      return;
}
}


//tab切换
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="";
            document.getElementById("tab1inner").style.display="";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("tab2inner").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("tab1inner").style.display="none";
            document.getElementById("TabCon2").style.display="";
            document.getElementById("tab2inner").style.display="";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }


    function openNewWin(){
              var cust_id=$id("cust_id").value;
              if(cust_id==""){
                    alert("<fmt:message key='alert_select_customer'/>");
                    return;
              }
	          if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
		        alert("<fmt:message key='alert_select_costCenter'/>");
		        return;
		      }
		
            var url="/FAERP/BillPrecisionAction.do?cmd=toListPageBillPrecision&cust_id="+cust_id+"&cost_center_id="+$id("cost_center_id").getValue();
            url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, "", 780, 450, "<fmt:message key='title_precision'/>");  //增加子岗位
       }
	//    
	function onchange_billtypedb(){
	       var  bill_type_bd = $id("bill_type_bd").value ;
	       if(bill_type_bd =='1'){
	           document.getElementById("scopetypetr").style.display=''
	       }
	       else {
	           document.getElementById("scopetypetr").style.display='none'
	       }
	       
	       jq("[name=scopetype_finout]").hide();
           jq("[name=scopetype_ibd]").hide();
           if(bill_type_bd =='5'){//财务外包 账单	yangxu
           		// 清空之前有可能选择的 合同 客户的信息
           		
           		jq("#contract_id").val('');
			    jq("#contract_type_bd").val('');
			    var lookup = $id("contract_name");
			    lookup.setValue('');
			    lookup.setDisplayValue('');
			    var lk_cust = $id("lk_cust");
			    lk_cust.setValue('');
			    lk_cust.setDisplayValue('');
			    ///////
			    
               jq("[name=scopetype_finout]").show();
               jq("[notFinout=true]").hide();
               var lk_cust = $id("lk_cust");
               lk_cust.setReadOnly(true);
               
               //只能查出财务外包的合同
               function beforeOpen(lookup){
			        lookup.params = [];
			        lookup.addParam("contract_type_bd",10);
			        return true;
			    }
			    $id("contract_name").beforeOpenDialog = beforeOpen;
           }else if(bill_type_bd =='7'){  //IBD证件账单
               jq("[name=scopetype_ibd]").show();
               jq("[notFinout=true]").hide();
               var lk_cust = $id("lk_cust");
               lk_cust.setReadOnly(true);
               
               var ibdlookup = $id("ibd_contract_name");
               function ibdbeforeOpen(ibdlookup){
                    ibdlookup.params = [];
                    ibdlookup.addParam("contract_type_bd",8);
                    return true;
                }
                
                $id("ibd_contract_name").beforeOpenDialog = ibdbeforeOpen;
           }else {
               jq("[notFinout=true]").show();
               var lk_cust = $id("lk_cust");
               lk_cust.setReadOnly(false);
           }
           
	}


function toFindContract(obj) {
    
    //IBD合同判断合同是否在服务期内
    if (obj[6] == "8"){
        var bill_year_month=_$("#bill_year_month").val();
        var startTime = obj[7].replace(/-/g,"").substring(0,6);
        var stopTime = obj[8].replace(/-/g,"").substring(0,6);
        if (startTime > bill_year_month || stopTime < bill_year_month){
            alert("<fmt:message key='alert_contract_time_err'/>");
            return false;
        }
    }
    // 财务外包合同 判断当前用户是否 是 合同的账单开具人员  yangxu
    var loginid="<%=LoginHelper.getPartyId(request)%>";
    //alert('loginid:' + loginid);
    //alert('obj[9]:' + obj[9]);
	if(obj[6] == "10"){
		if(obj[9]!=loginid){
			alert('只能合同的账单开具人员才能生成账单！');
			return false;
		}
	}
    jq("#contract_id").val(obj[0]);
    jq("#contract_type_bd").val(obj[6]);
    var lookup = $id("contract_name");
    lookup.setValue(obj[1]);
    lookup.setDisplayValue(obj[1]);
    
    
    var lk_cust = $id("lk_cust");
    lk_cust.setValue(obj[2]);
    lk_cust.setDisplayValue(obj[3]);
    
    jq("#cust_id").val(obj[2]);
    $id("cost_center_id").addParam("cust_id", obj[2]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    var dc1 =   $id("datacell1");
    dc1.loadData();
    dc1.refresh();
    
    /*
    document.form.contract_name.value = obj[1];
    document.form.customer_name.value = obj[3];
    document.form.company_id.value = obj[5];
    document.form.customer_id.value = obj[2];
    document.form.customer_code.value = obj[4];
    */
    // cc
    //var contract_type_bd = obj[6];
    //document.form.contract_type_bd.value = contract_type_bd;// 合同类型 1:劳务派遣协议
                                                            // 2:人事委托服务合同
                                                            // 3:服务外包合同 4:体检服务协议
                                                            // 4:补充福利 5:其他
}

/*
$id("front_1service_user_id").addParam("type", type);
$id("front_1service_user_id").loadData();
$id("front_1service_user_id").refresh();
*/
//与EXPress的数据交互接口
function getExpress(){
      var flag = false;
      var url = "<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=getExpressBill";
       //发送获取账单明细请求
       jQuery.ajax({
          url: url,
          type: 'post',
          dataType: 'html',
          data:{
                      "bill_year_month":_$("#bill_year_month").val(),
                      "cost_center_id":$id("cost_center_id").getValue(),
                      "flag":"getData",
                      "in_genernate_page":"in_genernate_page"
                    },
          async: false,
          timeout: 10000,
          success: function(text){
                     if(text== "get_success"){
                        //获取成功则通过
                        flag = true;
                     }else if(text == "no_data"){
	                       if(confirm("该成本中心需要的EXPress系统内当前年月的账单明细还未生成，是否生成？")){
	                           jQuery.ajax({
	                                  url: url,
	                                  type: 'post',
	                                  dataType: 'html',
	                                  data:{
	                                              "bill_year_month":_$("#bill_year_month").val(),
	                                              "cost_center_id":$id("cost_center_id").getValue(),
	                                              "flag":"createData",
                                                  "in_genernate_page":"in_genernate_page"
	                                            },
	                                  async: false,
	                                  timeout: 10000,
	                                  success: function(text){
	                                           if(text== "get_success"){
	                                               alert("请求XPress系统生成账单明细成功，可在账单生成日志界面查询生成状态,并在账单生成完成后再生成ERP账单。");
	                                           }else if(text == "get_error"){
	                                               alert("调用数据生成接口异常！");
	                                           }else{
	                                               alert(text);
	                                           }
	                                  }
	                          }); 
	                       }
                   }else if(text == "get_error"){
                       alert("该成本中心需要获取XPress系统数据，调用数据获取接口异常!");
                   }else{
                       alert(text);
                   }
          }
      });
      return flag;
}
</script>
</head>
<body>



        <div id="bg" class="xixi1">
            <div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key='tab_xixi1'/></div>
            
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'"><fmt:message key='tab_xixi2'/></div>
        </div>
        

<div id="TabCon1" >        
        
<div id="right" style="height: 120px; overflow-y: hidden;" >
                <h:form  checkType="blur" name="form" method="post"  id="datacell_formid">
               <input type="hidden" id="generatetype"  name="generatetype" />
<table width="100%" border="0">
	<tr>
		<td width="174" />
		<td width="360" />
		<td width="169"></td>
		<td width="381" />
	</tr>
	<tr>
		<td align="right"><span class="style_required_red">* </span><fmt:message key='bill_year_month'/></td>
		<td align="left"><h:text id="bill_year_month" property="currentbillym/pValue" name="bill_year_month"  style="width=180px" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/><fmt:message key='bill_year_month_tip_1'/><span  style="color:red;font-size:1.1em"><fmt:message key='bill_year_month_tip_2'/><b:write property="currentbillym/pValue" /></span></td>
        <td align="right"><span class="style_required_red">* </span><fmt:message key='bill_type_bd'/></td>
        <td align="left"><d:select dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd"
                name="bill_type_bd" style="width:183px" nullLabel="--请选择--"
                filterOp="in" filterStr="1,2,5,7"  onchange="onchange_billtypedb() ;"/></td>
                
	</tr>
	
	
<!--财务外包-->

    <tr style="display: none;" name="scopetype_finout">
        <td align="right"><fmt:message key='bill_contract'/></td>
        <td align="left">
            <input type="hidden" id="contract_id"  name="contract_id" />
            <input type="hidden" id="contract_code" name="contract_code"/>
            <input type="hidden" id="contract_type_bd" name="contract_type_bd" />
            <input type="hidden" id="front_service_user_id_hidden" name="front_service_user_id_hidden" />
            <input type="hidden" id="cost_center_id_hidden" name="cost_center_id_hidden" />
           
            <w:lookup onReturnFunc="toFindContract" readonly="true" id="contract_name"   name="contract_name" 
            lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"  messagekey="bill_contract" height="444" width="764" style="width:188px"/> 
        </td>
        <td align="right"><fmt:message key='bill_front_service_user'/></td>
        <td align="left">
        
            <r:comboSelect id="front_service_user_id" name="front_service_user_id"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=10"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" nullText="--请选择--">
            </r:comboSelect>
            预估账单
            <select name="is_forecast" id="is_forecast" style="width: 60px;">
            <option value="0" selected="selected">请选择</option>
            <option value="1">是</option>
            <option value="2" >否</option>
          </select>
        </td>
    </tr> 
    <tr style="display: none;" name="scopetype_finout">
        <td align="right"></td>
        <td align="left">
            
        </td>
        <td align="right"></td>
        <td align="left">
        </td>
    </tr> 

<!--财务外包-->

<!--IBD证件服务-->

    <tr style="display: none;" name="scopetype_ibd">
        <td align="right"><span class="style_required_red">* </span><fmt:message key='bill_contract'/></td>
        <td align="left">
            <input type="hidden" id="contract_id"  name="contract_id" />
            <input type="hidden" id="contract_code" name="contract_code"/>
            <input type="hidden" id="contract_type_bd" name="contract_type_bd" />
            <input type="hidden" id="front_service_user_id_hidden" name="front_service_user_id_hidden" />
            <input type="hidden" id="cost_center_id_hidden" name="cost_center_id_hidden" />
           
            <w:lookup onReturnFunc="toFindContract" readonly="true" id="ibd_contract_name"   name="contract_name" 
            lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"  messagekey="bill_contract" height="444" width="764" style="width:188px"/> 
        </td>
        <td align="right"></td>
        <td align="left"></td>
    </tr> 

<!--IBD证件服务-->
	
	<tr>
		<td align="right"><span class="style_required_red">* </span><fmt:message key='select_customer'/></td>
		<td align="left"><w:lookup readonly="true" id="lk_cust" validateAttr="allowNull=false;" name="lk_cust"
			lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition" style="width:165px"
			messagekey="select_customer" height="450" width="610" /> <input id="cust_id"
			name="cust_id" type="hidden" /></td>
        <td align="right"><span class="style_required_red">* </span><fmt:message key='cost_center'/></td>
        <td align="left"><r:comboSelect id="cost_center_id"
            name="cost_center_id"  
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
            width="180" >
        </r:comboSelect><input type="hidden" name="s_cost_center_id" id="s_cost_center_id"  /></td>
	</tr>
	
	  <tr style="display: none;" id="scopetypetr">
        <td align="right"><fmt:message key='billscopetype'/></td>
        <td align="left">
            <select name="billscopetype" id="billscopetype" style="width: 183px">
                <option value="1"><fmt:message key='billscopetype_1'/></option>
                <option value="2"><fmt:message key='billscopetype_2'/></option>
            </select>
        </td>
        <td align="right">&nbsp;</td>
        <td align="left">&nbsp;</td>
       </tr> 







    <!-- 
    <tr>
        <td align="right"></td>
        <td align="left">
          
        </td>
        
        <td align="right">&nbsp;<!-- 薪资人员范围  --></td>

        <!-- 
        <td align="left">&nbsp;
        <select id="salary_scope_bd" name="salary_scope_bd" style="width:183px">
            <option value="1">只获取当前成本中心的员工</option>
            <option value="2">获取客户全部员工</option>
        </select>
        </td>
    </tr>
        -->



	<tr>

	<!-- <input id="cust_id" name="cust_id" type="hidden" /> 
		<td align="right">是否计算残保金</td>
		<td align="left"><input type="radio" name="is_deformity"
			id="is_deformity" checked="checked" value="1">是<input
			type="radio" name="is_deformity" id="is_deformity" value="0">否</td>
			 -->
			 <input id="is_deformity" name="is_deformity" type="hidden" value="1"/>
			 <input type="hidden" name="is_welfare" id="is_welfare" value="0" /> 
		<td colspan="4" align="right">
		<div align="center" >
        <input name="button_ok2" class="icon_1" notFinout="true" <au:authorityBtn code="sczd_cxxz" type="1"/>    type="button" value="<fmt:message key='button_search'/>" onClick="javascript:searchSalary()">
		<input name="button_ok" id="button_ok" class="icon_1"	<au:authorityBtn code="sczd_sczd" type="1"/>	type="button" value="<fmt:message key='button_generateBill'/>" onClick="javascript:generateBill('0')">
		<input name="button_ok" id="button_ok" notFinout="true" class="icon_3"	<au:authorityBtn code="sczd_thread_sczd" type="1"/>	type="button" value="<fmt:message key='button_generateThreadBill'/>" onClick="javascript:generateThreadBill()">
		<input name="button_ok" id="button_ok"  class="icon_3"		type="button" value='仅生成福利账单' onClick="javascript:generateBill('1')">
		<input name="button_reset" class="icon_1" notFinout="true"  <au:authorityBtn code="sczd_jdsz" type="1"/>  type="button" value="<fmt:message key='title_precision'/>" onClick="javascript:openNewWin();"></div>
		</td>
		<td align="right"></td>
	</tr>


	<tr>
		<td />
		<td />
		<td />
		<td>&nbsp;</td>
		<td />
	</tr>
</table>

    </h:form>
</div>
</div>
<div id="tab1inner" style="padding: 8 10 8 8;" >
<r:datacell id="datacell1"  
    queryAction="/FAERP/BillCreateAction.do?cmd=searchSalary"
	 width="98%" height="304px" 
	 xpath="SalarybatchVo" 
	 submitAction="/FAERP/BillCreateAction.do?cmd=generateBill"
	submitXpath="SalarybatchVo" 
	paramFormId="datacell_formid"
	>

    <r:field allowModify="false"  fieldName="sa_check" sortAt="none" label="<input type='checkbox' name='sa_check2' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
     </r:field>
	<r:field fieldName="pay_name" messagekey="pay_name" width="250px" allowModify="false">
	</r:field>
	<r:field fieldName="pay_year_month" messagekey="pay_year_month" allowModify="false" width="150px">
		<h:text />
	</r:field>
	<r:field fieldName="tax_month" messagekey="tax_month" width="190px" allowModify="false">
		<h:text />
	</r:field>
	<r:field fieldName="bill_year_month" messagekey="dc_bill_year_month" width="205px" allowModify="false">
		<h:text />
	</r:field>
	<!--<r:field fieldName="cost_center_name" label="成本中心" width="205px" allowModify="false">
	</r:field>

--></r:datacell>
</div>





<div id="TabCon2" >        
        
<div id="right" style="height: 90px; overflow-y: hidden;">
        
<h:form  checkType="blur" name="form2" method="post"  id="datacell_formid2">

<table width="100%" border="0">
    <tr>
        <td width="174" />
        <td width="360" />
        <td width="169"></td>
        <td width="381" />
    </tr>
    <tr>
        <td align="right"><fmt:message key='create_type'/></td>
        <td align="left"><d:select dictTypeId="BILL_CREATE_TYPE_BD" value="1" nullLabel="--请选择--" id="create_type" name="create_type"></d:select></td>
        <td align="right"><fmt:message key='create_desc'/></td>
        <td align="left"><input type="text"  name="create_desc" id="create_desc" inputName="账单生成描述" maxLength="1000" style="width: 190px"/></td>
        <td align="right"></td>
    </tr>
    <tr>
        <td align="right"><fmt:message key='create_date'/></td>
         <td align="left">
                <w:date allowInput="false" id="w_from"
                    name="date_from" format="yyyy-MM-dd" style="width:75px;"  /><fmt:message key='create_date_to'/>
                <w:date allowInput="false" id="w_to" name="date_to"
                    format="yyyy-MM-dd" style="width:75px;" />
            </td>
        <td colspan="2" align="right">
        <div align="center">
        <input name="button_ok2" class="icon_1"  <au:authorityBtn code="sczd_cxrz" type="1"/>    type="button" value="<fmt:message key='button_searchCreateLog'/>" onClick="javascript:searchCreateLog()">
        <input name="button_ok2" class="icon_1"  <au:authorityBtn code="sczd_zdxx" type="1"/>    type="button" value="<fmt:message key='button_viewBillDetail'/>" onClick="javascript:viewBillDetail()">
        </div>
        </td>
        <td align="right"></td>
    </tr>


    <tr>
        <td />
        <td />
        <td />
        <td>&nbsp;</td>
        <td />
    </tr>
</table>


<!-- 
<table width="100%" border="0">
    <tr>
        <td width="274" />
        <td width="360" />
        <td width="169"></td>
        <td width="181" />
    </tr>
        </tr>
                <tr>
            <td align="right">账单生成方式</td>
            <td align="left">
               <d:select dictTypeId="BILL_CREATE_TYPE_BD" value="2" nullLabel="请选择..." id="create_type" name="create_type"></d:select>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
        </tr>
        <tr>
            <td align="right">账单生成描述</td>
            <td align="left">
                <input type="text" class="text_field" name="create_desc" id="create_desc" inputName="账单生成描述" maxLength="1000"/>
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
        </tr>
        <tr>
            <td align="right">创建日期</td>
            <td align="left">
                <w:date allowInput="false" id="w_from"
                    name="date_from" format="yyyy-MM-dd" style="width:90px;"  />到
                <w:date allowInput="false" id="w_to" name="date_to"
                    format="yyyy-MM-dd" style="width:90px;" />
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
        </tr>


    <tr>
        <td />
        <td> <input name="button_ok2" class="icon_1"      type="button" value='查询日志' onClick="javascript:searchCreateLog()">
        <input name="button_ok2" class="icon_1"      type="button" value='账单详细' onClick="javascript:viewBillDetail()"></td>
        <td />
        <td></td>
        <td />
    </tr>
</table>
-->
    </h:form>
</div>


<div id="tab2inner" style="padding: 8 10 8 8;" >
<r:datacell id="datacell2"  queryAction="/FAERP/BillCreateLogAction.do?cmd=queryLog" readonly="true"
     width="98%" height="304px" xpath="BillCreateLogVo" submitAction="/FAERP/BillCreateAction.do?cmd=generateBill"
    submitXpath="BillCreateLogVo" paramFormId="datacell_formid2">

    <r:field fieldName="bill_create_type_bd" messagekey="create_type" width="250px" >
        <d:select dictTypeId="BILL_CREATE_TYPE_BD"></d:select>
    </r:field>
    <r:field fieldName="bill_create_desc" messagekey="create_desc" allowModify="false"
        width="350px">
        <h:text />
    </r:field>
    <r:field fieldName="last_update_date" messagekey="create_date" width="190px"
        allowModify="false">
        <w:date format="yyyy-MM-dd hh:mm:ss"/>
    </r:field>

</r:datacell>

</div>
</div>



</body>
</html>

<script language="javascript">
//$id("datacell1").headTextAlign="center";

$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    _$("#cust_id").val(returnValue[0]);
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    var dc1 =   $id("datacell1");
    dc1.loadData();
    dc1.refresh();
    return false;
}


function searchSalary(){
    //alert("aa");
    var frm = $id("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          return;
      }
   
       var dc1 =   $id("datacell1");
       dc1.loadData();
       dc1.refresh();
      return;
}



    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
        $id("datacell2").isQueryFirst = false;
    });

function searchCreateLog( ){
      if (!$id("cost_center_id").getValue() || $id("cost_center_id").getValue().length <= 0){
        alert("<fmt:message key='alert_select_costCenter'/>");
        
        return;
      }   
       var dc1 =   $id("datacell2");
       dc1.addParam("cost_center_id", $id("cost_center_id").getValue());
       dc1.loadData();
       dc1.refresh();
      return false;
}

function viewBillDetail() {
    var dc = $id("datacell2");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var bill_id = entity.getValue("bill_id");
    _$.ajax({
        type : "post",
        url : "/FAERP/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data!=""&&data=="此账单无明细，数据可能异常。") {
                alert("<fmt:message key='alert_detail_error'/>");
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
                    window.open(url, 'newwindow', s);
                    //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                }
            }
        }
    });
}

function checkall(){
    if (jQuery("#checkall").checked){
        jQuery("#sa_check").checked = true;;
    }else{
         jQuery("#sa_check").checked = false;
    }
}


jQuery(document).ready(function() {
    var isFirstLoad = true;
    $id("datacell2").afterRefresh = function(){
        if (isFirstLoad) {
            setTab03Syn(1);
            isFirstLoad = false;
        }       
    }
        
});

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id")+ ">";
    }
</script>
</fmt:bundle>