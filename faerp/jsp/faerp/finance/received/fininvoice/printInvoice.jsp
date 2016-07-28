<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.received.fininvoice.fininvoice_resource" prefix="rayoo.finance.received.fininvoice.">
<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_invoiceQuery'/></title>
<script language="javascript">

    _$(document).ready(function() {
            if ($id("lk_cust")) {
                $id("lk_cust").onReturnFunc = function (returnValue){
                    var lookup = $id("lk_cust");
                    lookup.value = returnValue[0];
                    _$("#cust_name").val(returnValue[2]);
                    lookup.displayValue = returnValue[2];
                    $id("cost_center_id").addParam("cust_id", returnValue[0]);
                    $id("cost_center_id").loadData();
                    $id("cost_center_id").refresh();
                    return false;
                }
            }
    });
    
    //第一次不加载数据
    jQuery(function(){
        //$id("datacell1").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'  value='" + entity.getProperty("id") + "'    onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("billid") + "\",\"" + entity.getProperty("cost_center_id") + "\",\"" + entity.getProperty("type_bd") + "\");>";
    }

   function ClickRow(tid,billid,cost_center_id,type_bd){
          $id("billid").value = billid;
          $id("costcenterid").value = cost_center_id;
          $id("tid").value = tid+"";
          $id("type_bd_temp").value = type_bd+"";
    }

    //查询数据
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        $id("billid").value = "";
        $id("costcenterid").value = "";
        $id("custname").value="";
        $id("billid").value = "";
        $id("costcenterid").value = "";
    }
    //lookup  选择客户名称
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        $id("custname").value=arg[2];
        $id("cust_id").value=arg[0];
        $id("cost_center_id").addParam("cust_id", arg[0]+"");
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    
    function resetQuery(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        
        $id("custname").value="";
        $id("billid").value = "";
        $id("costcenterid").value = "";
    }
    

    
    //导出数据
     function exportToExcel() {  
         if(confirm("是否确定要导出数据？")) {
                form.action="/FAERP/FininvoiceAction.do?cmd=exportToExcel";
                form.submit();
          }
      }
      
      //发票导出
      function exportInvoiceToExcel(){
         if(confirm("是否确定要导出数据？")) {
                var param = jQuery("#datacell_formid").serialize();
                form.action="/FAERP/FininvoiceAction.do?cmd=exportInvoiceToExcelInPrintPage";
                form.submit();
          }
      }  
      
     //查看明细
     function viewbillingdetails() {
     
             var id_check = document.getElementsByName("temp");
            var ids = null;  //定义id值的数组
            if(ids == null) {
                ids = new Array(0);
            }
            var checkIndex;
            for(var i=0;i<id_check.length;i++){  //循环checkbox组
                if(id_check[i].checked && id_check[i].value != ""){
                    ids.push(id_check[i].value);  //加入选中的checkbox
                    checkIndex = i;
                }
            }
            if(ids==null||ids==""){
                alert('请选择一条记录！');
                return;
            }
            if(ids.length > 1) {  //如果ids有2条以上的纪录
                alert('只能选择一条记录！');
                return;
            }
            
           if($id("billid").value==""){
                alert("请选择一条发票记录！");
                return;
           }
           //alert("ids="+ids)
           var cost_center_ids=$id("costcenterid").value;
           var fin_invoice_id=ids;
           //alert(cost_center_ids);
           /**if(cost_center_ids==""||cost_center_ids=="null,"||cost_center_ids=="null"){
            alert("无账单的发票无明细数据！");
            return;
           }**/
           var entity  = $id("datacell1").getEntity(checkIndex-1);
           var bill_id = entity.getValue("billid");
           cost_center_ids =  entity.getValue("cost_center_id");
           var url="/FAERP/FinverificationAction.do?cmd=getCustomer&fin_invoice_id="+fin_invoice_id+"&bill_id="+bill_id+"&cost_center_ids="+cost_center_ids+"&view=true&print=0";
           url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
           //var w=screen.width-600;
           //var h = screen.height-180;
           //var l = (screen.width - w) / 2;
           //var t = (screen.height - h) / 2;
           var w=screen.width;
           var h = screen.height;
           var l = 0;
           var t = 0;
           var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
           s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
           window.open(url, 'newwindow', s);
      }
      
    
      //打印发票
     function  printer_onclick(){
      if(confirm("是否确定打印发票？")) {
            var ds = $id("datacell1").dataset;
            var ids = new Array();
            var isprinter_type_bd = 0 ;
            var is_invalid = 0;//发票是否有效
            var invoice_type=0;
            var is_kp = 0;//是否有发票号
	        jQuery("input[name='temp']").each(function(){
	            if(jQuery(this).attr("checked") && this.value !=""){
	                ids.push(this.value);
	               var entity = ds.findEntity("id",this.value);
	               var printer_type_bd  =  entity.getValue("printer_type_bd"); 
	               var is_valid = entity.getValue("is_valid"); 
	               var is_del = entity.getValue("is_del"); 
	               var invoice_code = entity.getValue("invoice_code"); 
	               invoice_type=entity.getValue("invoice_type");
	                if(printer_type_bd !="2"){
	                   isprinter_type_bd ++ ;
	                }
	                if(is_valid != "1" || is_del != "0"){
	                    is_invalid ++;
	                }
	                if(invoice_code != null && invoice_code != ""){
	                    is_kp ++;
	                }
	            }
	        });
           
            if (invoice_type=="3"){
	    		  alert("收据发票请在线下打印！");
	    		  return false ;
	    	}
	      
	        if (isprinter_type_bd >0){
	                alert("只有未打印的发票才能进行打印操作!") ;
	                return false ;
	        }
	        if (is_invalid >0){
	                alert("无效的发票不能打印!") ;
	                return false ;
	        }
	         if (is_kp >0){
                    alert("已有发票编号的发票不允许再打印");
                    return false;
            }
            var invoiceids = ids.join() ;
               $id("printerbutton").disabled="disabled" ;
             var url="/FAERP/FininvoiceAction.do?cmd=printerInvoice&invoiceid="+invoiceids;
                  jQuery.post(url,function(data){
                        var reData=data.split("|");
                        if(reData[0]=="1"){
                            alert("打印调用成功") ;
                            
                             var voucher_bill_id=reData[1];//要生成红冲凭证的账单ID
                              //生成红冲凭证
                              //alert("生成红冲凭证:"+voucher_bill_id);
                             if(voucher_bill_id!=null && voucher_bill_id!=""){
                                       alert(createBillVoucher(voucher_bill_id));
                             }
                                 
                            $id("datacell1").loadData();
                            $id("datacell1").refresh();
                            $id("printerbutton").disabled="" ;
                          return  ;
                        }
                        else if(reData[0]=="2"){
                        	alert("发票信息不全,请联系管理员") ;
                            
                        }
                        else{
                                 alert("调用出错！");
                                   $id("printerbutton").disabled="" ;
                                 return;
                        }
                       
                  });
          }
      }
      
      
      
           //生成红冲凭证
     function createBillVoucher(bill_ids) {
               var _now ="2014-4-01";
               //var _now =CurentDate();
               //var v_date=arg[0];//制单日期
               var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_type=hongchong";
               turl=turl+"&date="+_now;  
               //alert("turl======"+turl);
               turl = encodeURI(turl);
               jQuery.ajax({
               url: turl,
               type: 'GET',
               dataType: 'html',
               async: false,
               timeout: 10000,
               error: function(text){
                       //alert(text);
                       return  text;
                   },
               success: function(text){
                        return  text;
                       //alert(text);
                       //$id("celllist1").reload();
               }
           });  
 
     }
      
      
     //作废
     function viewinvalid() {
     
            var id_check = document.getElementsByName("temp");
            var ids = null;  //定义id值的数组
            if(ids == null) {
                ids = new Array(0);
            }
            for(var i=0;i<id_check.length;i++){  //循环checkbox组
                if(id_check[i].checked && id_check[i].value != ""){
                    var entity = $id("datacell1").dataset.findEntity("id",id_check[i].value);
                    var is_valid = entity.getValue("is_valid"); 
                    var is_del = entity.getValue("is_del"); 
                    if(is_valid != "1" || is_del != "0"){
                        alert("作废的发票不需要再次作废！");
                        return;
                    }
                    ids.push(id_check[i].value);  //加入选中的checkbox
                }
            }
            if(ids==null||ids==""){
                alert('请选择一条记录！');
                return;
            }
            if(ids.length > 1) {  //如果ids有2条以上的纪录
                alert('只能选择一条记录！');
                return;
            }
            
           if($id("billid").value==""){
                alert("请选择一条发票记录！");
                return;
           }
           /**if($id("type_bd_temp").value=="4"||$id("type_bd_temp").value=="5"){    update by whj 2014-03-21
                alert("此记录已经作废不须再次作废！");
                return;
           }**/
           
           //costcenterid
           var cost_center_ids=$id("costcenterid").value;
           var invoice_type_select=$id("invoice_type_select").value;
           var url="/FAERP/jsp/faerp/finance/received/fininvoice/invalid.jsp?id="+ids+"&invoice_type_select="+invoice_type_select;
           if(cost_center_ids==null ||cost_center_ids=="null" || cost_center_ids==""){
           url=url+"&nobill=true";
            //alert("无账单的发票作废！");
           // return;
           }
            
            url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window,returnfun, 600, 260, "作废发票");  //增加子岗位
                     
      }
      
     //回调方法
     function returnfun(ret){
     if(ret!=null&&ret!=""){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
            alert("操作成功！");
            }    
     }
     
      
       //杜辉阳添加
    //审批详细操作
    function spinto_onClick(){
        var id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<id_check.length;i++){  //循环checkbox组
            if(id_check[i].checked){
                ids.push(id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('请选择一条记录！');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('只能选择一条记录！');
            return;
        }
        var fin_invoice_id=ids+"";//单据主键
        //alert(fin_invoice_id);
        var wfname="KaiPiaolWorkFlow";//此业务对应合同审批名称    
        //var billid = $id("billid").value; 
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf_Info(wfname,wfname,fin_invoice_id,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("没有发起过审批流程!");
                    return;
                }   
                else{
                    //跳转到流程详细信息页面
                    //to_monitor(contract_id);
                    var url="/FAERP/FininvoiceAction.do?cmd=getApprovalDetailsPage&wfname=" + wfname +"&mid=" +fin_invoice_id;
                        url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
                    showModalCenter(url, window, "",740, 360, "审批详细"); 
                }   
            }
         );        
    
    }
    
   //add by sqp 2013年12月6日 
   
         //选择客服
        function rtnFuncCS(arg){
            var lookup = $id("lk_cs");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            jQuery("#custservice_name").val(arg[0]);        
            return false;
        }
        
   function checkAll(item) {
        if (_$(item).attr("checked")) {
            _$(":checkbox").attr("checked", true);
        } else {
            _$(":checkbox").attr("checked", false);
        }
    }
    
    function rtnFuncDept(arg){
	    var lookup = $id("cust_dept");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    return false;
	 }
	 
	//账单申请的发票附件下载
    function downloadAttachment(){
       var dc = $id("datacell1");
       var ds = dc.dataset;
       var id_check = document.getElementsByName("temp");
       var id = null;  //定义id值的数组
       var row_index;
       if(id == null) {
           id = new Array(0);
       }
       for(var i=0;i<id_check.length;i++){  //循环checkbox组
           if(id_check[i].checked){
               id.push(id_check[i].value);  //加入选中的checkbox
               row_index = i;
           }
       }
       if(id==null||id==""){
           alert('请选择一条记录！');
           return;
       }
       if(id.length > 1) {  //如果ids有2条以上的纪录
           alert('只能选择一条记录！');
           return;
       }
       
       var allowDownFlag = true;
       var entity = dc.getEntity(dc.getRow(row_index-1));
       var open_invoice = entity.getProperty("open_invoice");
       if(open_invoice != "2"){
           allowDownFlag = false;
       }
       if(allowDownFlag == false){
          alert("只有无账单开票才可以下载附件，请重新选择！");
          return;  
       }else{
          var fin_invoice_id = id;
	      form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=downloadAttachment&fin_invoice_id="+fin_invoice_id;
	      form.submit();
	      form.action="";
       }
    }
//设置未打印    
function setNoPrintType(){
	if(confirm("是否将选择的发票设置为未打印")) {
	            var ds = $id("datacell1").dataset;
	            var ids = new Array();
	            var isprinter_type_bd = 0 ;
		        jQuery("input[name='temp']").each(function(){
		            if(jQuery(this).attr("checked") && this.value !=""){
		                ids.push(this.value);
		               var entity = ds.findEntity("id",this.value);
		               var printer_type_bd  =  entity.getValue("printer_type_bd"); 
		                if(printer_type_bd !="3"){
		                  isprinter_type_bd ++ ;
		                }
		            }
		        });
		        if (isprinter_type_bd >0){
		                alert("只有打印中的发票才能设置为未打印!") ;
		                return false ;
		        }
		        if(ids == "" || ids == null){
		          alert("请选择一张发票");
		          return false;
		        }
		        var invoiceIds = ids.join() ;
		        var turl = "<%=request.getContextPath()%>/FininvoiceAction.do?cmd=setNoPrintType&invoiceIds="+invoiceIds;
		        jQuery.ajax({
	               url: turl,
	               type: 'GET',
	               dataType: 'html',
	               async: false,
	               timeout: 10000,
	               success: function(text){
	                        alert(text);
                            $id("datacell1").loadData();
                            $id("datacell1").refresh();
	               }
	           });  
	}
}
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input id="custname" name="custname" type="hidden"  value="" />
<!--<input id="cust_id" name="cust_id" type="hidden"  value="" />-->
<input id="billid" name="billid" type="hidden"  value="" />
<input id="tid" name="tid" type="hidden"  value="" />
<input id="type_bd_temp" name="type_bd_temp" type="hidden"  value="" /> 
<input id="costcenterid" name="costcenterid" type="hidden"  value="" />
<!--add by sqp  -->
<input type="hidden" id="custservice_name" name="custservice_name" />

<div id="right">
    <script language="javascript">
        writeTableTopFesco("发票打印",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="7" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right"><fmt:message key='cust_name'/></td>
            <td align="left">    
            <!--<w:lookup onReturnFunc="rtnFunc"  style="width: 170px;" readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=queryAllGetByID" dialogTitle="选择客户" height="500" width="810"/>-->
            <w:lookup readonly="true" id="lk_cust" name="cust_id"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                messagekey="select_cust" height="500" width="600" style="width:165px;" />
            </td>
            <td align="right"><fmt:message key='cost_center'/></td>
            <td align="left">   
                    <r:comboSelect id="cost_center_id" name="cost_center_id"
                        queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                        textField="cost_center_name"
                        valueField="id"
                        xpath="CostcenterVo"
                        width="180px"
                        messagekey="please_select"
                        >
                    </r:comboSelect>
             </td>
            <td  align="right"><fmt:message key='invoice_code'/></td>
            <td  align="left">
            <input type="text" class="text_field" name="invoice_code" id="invoice_code_input" inputName="票据号" maxLength="15" value="" style="width: 180px;"/>
            </td>
        </tr>
        
        
        <tr>
            <td align="right"><fmt:message key='bill_year_month'/></td>
            <td align="left">
                <input type="text" class="text_field" name="bill_year_month" id="bill_year_month_input" inputName="应收年月" maxLength="10" value=""  style="width: 180px;"/>
            </td>
            <!--  <td align="right">发票申请类型</td>
                        <td align="left">
                        <d:select dictTypeId="INVOICE_TYPE_BD" name="type_bd" nullLabel="--请选择--" style="width: 180px;" id="type_bd_select"/>
                        </td>-->
            <td align="right">开票类型</td>
            <td align="left">
                <d:select dictTypeId="OPEN_INVOICE" name="open_invoice" nullLabel="--请选择--" id="open_invoice" style="width:180px;"/>
            </td>
            <td align="right">发票申请日期</td>
	       <td align="left">
	       <w:date format="yyyy-MM-dd" name="create_date_from" width="67px" id="create_date_from"/><fmt:message key='inc_date_from_to'/><w:date format="yyyy-MM-dd" name="create_date_to" width="67px" id="create_date_to"/></td>
	       </td>
        </tr>
        
        <tr>
            <td align="right"><fmt:message key='invoice_amount_from'/></td>
            <td align="left">
                <input type="text" class="text_field"  style="width:80px" name="invoice_amount_from" value="" maxLength="15" onkeyup="if(isNaN(value))execCommand('undo')"  id="transact_day_from"/>到<input type="text" class="text_field" style="width:80px" maxLength="15" onkeyup="if(isNaN(value))execCommand('undo')"  name="invoice_amount_to" value=""  id="transact_day_to" />
            </td>
            <!-- add by sqp  2013年12月6日  -->
                  <td align="right"><fmt:message key='lk_cs'/></td>
                  <td align="left">
                    <w:lookup onReturnFunc="rtnFuncCS" style="width:165px" readonly="true" id="lk_cs" lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="select_cust_service" height="450" width="500"/>
                    </td>
                  <td align="right"><fmt:message key='cust_dept'/></td>
                  <td align="left">
                       <w:lookup onReturnFunc="rtnFuncDept"
						readonly="true" id="cust_dept" name="cust_dept"
						lookupUrl="/FinbillAction.do?cmd=getAllDeptByCondition"
						messagekey="选择客服部门" height="450" width="610" style="width:172px" />
                  </td>
           <!--end  -->
        </tr>
        
        <tr>
            <td align="right">是否需要快递</td>
            <td align="left">
                <d:select dictTypeId="TrueOrFalse" name="is_express_select" nullLabel="--请选择--" style="width: 180px;" id="is_express_select"/>
            </td>
            <td align="right">发票类型</td>
            <td align="left">
                <d:select dictTypeId="BILL_INVOICE_TYPE" name="invoice_type_select" nullLabel="--请选择--" style="width: 180px;" id="invoice_type_select"/>
            </td>
            <td align="right">打印状态</td>
            <td align="left">
                <select id="printer_type_select" name="printer_type_select" style="width:180px;">
                    <option value="">--请选择--</option>
                    <option value="1">已打印</option>
                    <option value="2">未打印</option>
                    <option value="3">打印中</option>
                </select>
            </td>
        </tr>
        
         <tr>
            <td align="right">开票人</td>
            <td align="left">
                <input type="text" class="text_field" name="make_out_user" id="make_out_user" inputName="开票人" maxLength="10" value=""  style="width: 180px;"/>
            </td>
            <td align="right">开票状态</td>
            <td align="left">    
	            <select id="kp_state" name="kp_state" style="width:180px;">
	                <option value="0">未开票</option>
	                <option value="1">已开票</option>
	                <option>--请选择--</option>
	            </select>
            </td>
            <td align="right">开票日期</td>
            <td align="left">
            <w:date format="yyyy-MM-dd" name="make_out_date_from" width="67px" id="make_out_date_from"/>到<w:date format="yyyy-MM-dd" name="make_out_date_to" width="67px" id="make_out_date_to"/></td>
            </td>
        </tr>
        
        <tr>
            <td align="right">发票是否有效</td>
            <td align="left">
                <select id="is_valid_select" name="is_valid_select" style="width:180px;">
                    <option value="1">有效发票</option>
                    <option value="0">无效发票</option>
                    <option>--请选择--</option>
                </select>
            </td>
            <td align="right">操作日期</td>
            <td align="left">
            <w:date format="yyyy-MM-dd" name="last_update_date_from" width="67px" id="last_update_date_from"/>到<w:date format="yyyy-MM-dd" name="last_update_date_to" width="67px" id="last_update_date_to"/></td>
            </td>
		    <td align="right" >
			    <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
			    <input name="button_reset2" class="icon_1" type="reset" value='<fmt:message key="reset"/>' >
		    </td>
        </tr>
        
</table>
</div>
</form>

<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="f">       <a  onClick="javascript:viewinvalid();">作废</a> </li>
                     <li class="g">      <a  onClick="javascript:effect_fun();">生效</a> </li> 
                    <li class="e">      <a  onClick="javascript:exportToExcel();">导出</a> </li>
                    <li class="a">      <a  onClick="javascript:viewbillingdetails();">明细</a> </li>
                </ul>
                -->
                <input class="j_1" type="button"  id="printerbutton"  value="<fmt:message key='print'/>"  <au:authorityBtn code="fpdy_dy" type="1"/>  onclick="printer_onclick() ;"   >
                <input class="f" type="button"   value="<fmt:message key='zf'/>"  <au:authorityBtn code="fpdy_zf" type="1"/>  onClick="viewinvalid();">
                 <!--<input class="g" type="button"   value="生效"  <au:authorityBtn code="fpcx_sx" type="1"/>  onClick="effect_fun();">
                 -->
                 <!--  <input class="e" type="button"   value="<fmt:message key='export'/>"  <au:authorityBtn code="fpcx_exp" type="1"/>  onClick="exportToExcel();"> -->
                 <input class="a" type="button"   value="<fmt:message key='mx'/>"  <au:authorityBtn code="fpdy_mx" type="1"/>  onClick="viewbillingdetails();">
                 <input name="button_download" class="approdetial" type="button" value="附件下载" <au:authorityBtn code="fpdy_downAtt" type="1"/> onclick="javascript:downloadAttachment();" >
                 <input class="approdetial" type="button"   value="发票导出"  <au:authorityBtn code="fpdy_invoice_exp" type="1"/>  onClick="exportInvoiceToExcel();">
                 <input class="approdetial" type="button"   value="设置未打印"  <au:authorityBtn code="fpdy_szwdy" type="1"/>  onClick="setNoPrintType();">
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FininvoiceAction.do?cmd=searchInvoiceQueryData"
        width="98%"
        height="304px"
        xpath="FininvoiceVo"
        readonly="true"
        pageSize="50"
        >
	      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
     <r:field fieldName="emp" label="<input type='checkbox' name='temp' onclick='checkAll(this);'  value=''/>" width="40px" 
     onRefreshFunc="setCheckboxStatus" align="center"  sortAt="none" >
     </r:field>
    <r:field fieldName="cust_code" messagekey="cust_code"  width="80px">
      <h:text/>
    </r:field>
    <r:field fieldName="cust_name" messagekey="cust_name" width="200px" >
      <h:text/>
    </r:field>
    <r:field fieldName="cost_center_name" messagekey="cost_center" width="200px" >
      <h:text/>
    </r:field>
    <r:field fieldName="invoice_code" messagekey="invoice_code"  width="90px">
      <h:text/>
    </r:field>
    <r:field fieldName="create_date" label="开票申请时间"  width="150px">
      <w:date format="yyyy-MM-dd HH:mm:ss"/>
    </r:field>     
    <r:field fieldName="invoice_amount" messagekey="invoice_amount_from" width="75px" 
    onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
      <h:text/>
    </r:field>
   <!--   <r:field fieldName="type_bd" label="发票申请类型" width="100px">
      <d:select dictTypeId="INVOICE_TYPE_BD" />
    </r:field>-->
    <r:field fieldName="invoice_type" label="发票类型" width="75px">
      <d:select dictTypeId="BILL_INVOICE_TYPE" />
    </r:field>
    <r:field fieldName="open_invoice" label="开票分类" width="75px">
      <d:select dictTypeId="OPEN_INVOICE" />
    </r:field>
    <r:field fieldName="printer_type_bd" messagekey="printer_type_bd" width="75px">
      <h:select property="printer_type_bd" disabled="true">
            <h:option value="1" label="已打印"/>
            <h:option value="2" label="未打印"/>
            <h:option value="3" label="打印中"/>
       </h:select>
    </r:field>
    <r:field fieldName="user_name" messagekey="user_name" width="70px">
    </r:field>
    <r:field fieldName="dept_name" label="客服部门" width="70px">
    </r:field>
    <r:field fieldName="is_express" label="是否需要快递" width="100px">
        <d:select dictTypeId="TrueOrFalse" />
    </r:field>
    <r:field fieldName="contact_address" label="快递地址" width="70px">
    </r:field>
    <r:field fieldName="contact_person" label="联系人" width="70px">
    </r:field>
    <r:field fieldName="contact_tel" label="联系电话" width="150px">
    </r:field>
    <r:field fieldName="make_out_user" label="开票人" width="70px">
    </r:field>
    <r:field fieldName="make_out_date" label="开票时间" width="150px">
        <w:date format="yyyy-MM-dd HH:mm:ss"/>
    </r:field>
    <r:field fieldName="apply_user" label="申请人" width="70px">
    </r:field>
    <r:field fieldName="apply_user_dept" label="申请人部门" width="150px">
    </r:field>
    <r:field fieldName="apply_reason" label="申请原因" width="210px">
    </r:field>
    <r:field fieldName="inv_desc" label="备注" width="210px">
        <h:text/>
	</r:field>
	<r:field fieldName="invoice_desc" label="发票备注" width="210px">
    </r:field>
    <r:field fieldName="invalid_invoice_code" label="作废发票号" width="90px">
    </r:field>
    <r:field fieldName="cancel_reason" label="取消原因" width="150px">
    </r:field>
    </r:datacell>
    </div>
    
</div>
</div>

</fmt:bundle>
</body>
</html>

