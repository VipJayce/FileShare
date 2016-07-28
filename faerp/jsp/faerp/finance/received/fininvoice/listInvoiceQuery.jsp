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
        $id("datacell1").isQueryFirst = false;
        $id("celllist1").isQueryFirst = false;
        $id("celllist2").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'  value='" + entity.getProperty("id") + "'    onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("billid") + "\",\"" + entity.getProperty("cost_center_id") + "\",\"" + entity.getProperty("type_bd") + "\");>";
    }

   function ClickRow(tid,billid,cost_center_id,type_bd){
          $id("billid").value = billid;
          $id("costcenterid").value = cost_center_id;
          $id("tid").value = tid+"";
          $id("type_bd_temp").value = type_bd+"";
          $id("celllist1").addParam("invoice_id",tid);
          $id("celllist1").loadData();
          $id("celllist1").refresh();
          
          $id("celllist2").addParam("billid",billid);
          $id("celllist2").loadData();
          $id("celllist2").refresh();
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
        $id("celllist1").addParam("invoice_id","");
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        $id("celllist2").addParam("billid","");
        $id("celllist2").loadData();
        $id("celllist2").refresh();
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
        $id("celllist1").addParam("invoice_id","");
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        $id("celllist2").addParam("billid","");
        $id("celllist2").loadData();
        $id("celllist2").refresh();
    }
    

	
	//导出数据
     function exportToExcel() {  
         if(confirm("<fmt:message key='exporttoexl'/>")) {
	            form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=exportToExcel";
	            form.submit();
          }
      }
      
      //发票导出
      function exportInvoiceToExcel(flag){
         if(confirm("<fmt:message key='exporttoexl'/>")) {
                var cust_id =  jQuery("#lk_cust_hidden").val(); 
				var cost_center_id =  jQuery("#cost_center_id_hidden").val();
				var invoice_code =  jQuery("#invoice_code_input").val();
				var bill_year_month =  jQuery("#bill_year_month_input").val();
				var type_bd =  jQuery("#type_bd_select").val();
				var create_date_from =  jQuery("#create_date_from_hidden").val();
				var create_date_to =  jQuery("#create_date_to_hidden").val();
				var invoice_amount_from =  jQuery("#transact_day_from").val();
				var invoice_amount_to =  jQuery("#transact_day_to").val();
				var custservice_name =  jQuery("#lk_cs_hidden").val();
				var cust_dept =  jQuery("#cust_dept_hidden").val();
				var kp_state =  jQuery("#kp_state").val();
				if(flag == 'new'){
				    form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=exportInvoiceToExcelNew&cust_id="+cust_id+"&cost_center_id="+
                                    cost_center_id+"&invoice_code="+invoice_code+"&bill_year_month="+bill_year_month+"&type_bd="+
                                    type_bd+"&create_date_from="+create_date_from+"&create_date_to="+create_date_to+"&invoice_amount_from="+
                                    invoice_amount_from+"&invoice_amount_to="+invoice_amount_to+"&custservice_name="+custservice_name+"&cust_dept="+cust_dept+"&kp_state="+kp_state;
				}else{
				    form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=exportInvoiceToExcel&cust_id="+cust_id+"&cost_center_id="+
                                    cost_center_id+"&invoice_code="+invoice_code+"&bill_year_month="+bill_year_month+"&type_bd="+
                                    type_bd+"&create_date_from="+create_date_from+"&create_date_to="+create_date_to+"&invoice_amount_from="+
                                    invoice_amount_from+"&invoice_amount_to="+invoice_amount_to+"&custservice_name="+custservice_name+"&cust_dept="+cust_dept+"&kp_state="+kp_state;
				}
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
	            if(id_check[i].checked){
	                ids.push(id_check[i].value);  //加入选中的checkbox
	                checkIndex = i;
	            }
	        }
	        if(ids==null||ids==""){
	            alert('<fmt:message key="select_one_record"/>');
	            return;
	        }
	        if(ids.length > 1) {  //如果ids有2条以上的纪录
	            alert('<fmt:message key="only_can_a_record"/>');
	            return;
	        }
	        
           if($id("billid").value==""){
                alert("<fmt:message key='alert_select_one_invoice'/>");
                return;
           }
           //alert("ids="+ids)
           var cost_center_ids=$id("costcenterid").value;
           var fin_invoice_id=ids;
           //alert(cost_center_ids);
           if(cost_center_ids==""||cost_center_ids=="null,"||cost_center_ids=="null"){
            alert("<fmt:message key='alert_not_cost_center'/>");
            return;
           }
           var entity  = $id("datacell1").getEntity(checkIndex);
           var bill_id = entity.getValue("billid");
           cost_center_ids =  entity.getValue("cost_center_id");
           var url="<%=request.getContextPath()%>/FinverificationAction.do?cmd=getCustomer&fin_invoice_id="+fin_invoice_id+"&bill_id="+bill_id+"&cost_center_ids="+cost_center_ids+"&view=true&print=0";
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
      if(confirm("<fmt:message key='alert_is_print'/>")) {
            var ds = $id("datacell1").dataset;
            var ids = new Array();
            var isprinter_type_bd = 0 ;
	    jQuery("input[name='temp']").each(function(){
	        if(jQuery(this).attr("checked")){
	            ids.push(this.value);
	           var entity = ds.findEntity("id",this.value);
	           var printer_type_bd  =  entity.getValue("printer_type_bd"); 
	            if(printer_type_bd !="2"){
                  isprinter_type_bd ++ ;
                }
	        }
	    });
	    if (isprinter_type_bd >0){
	            alert("<fmt:message key='alert_unprint'/>") ;
                return false ;
	    }
		    var invoiceids = ids.join() ;
		       $id("printerbutton").disabled="disabled" ;
		     var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=printerInvoice&invoiceid="+invoiceids;
		          jQuery.post(url,function(data){
		                var reData=data.split("|");
                        if(reData[0]=="1"){
		                    alert("<fmt:message key='alert_print_success'/>") ;
		                    
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
		                }else{
		                         alert("<fmt:message key='alert_error'/>");
		                           $id("printerbutton").disabled="" ;
		                         return;
		                }
		               
		          });
          }
      }
      
      
      
           //生成红冲凭证
     function createBillVoucher(bill_ids) {
               var _now ="${requestScope.currentDate}";
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
                if(id_check[i].checked){
                    ids.push(id_check[i].value);  //加入选中的checkbox
                }
            }
            if(ids==null||ids==""){
                alert('<fmt:message key="select_one_record"/>');
                return;
            }
            if(ids.length > 1) {  //如果ids有2条以上的纪录
                alert('<fmt:message key="only_can_a_record"/>');
                return;
            }
            
           if($id("billid").value==""){
                alert("<fmt:message key='alert_select_one_invoice'/>");
                return;
           }
           /**if($id("type_bd_temp").value=="4"||$id("type_bd_temp").value=="5"){    update by whj 2014-03-21
                alert("<fmt:message key='alert_type_bd_4'/>");
                return;
           }**/
           
           //costcenterid
           var cost_center_ids=$id("costcenterid").value;
           var url="<%=request.getContextPath()%>/jsp/faerp/finance/received/fininvoice/invalid.jsp?id="+ids
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
            $id("celllist1").paramList = [];
            $id("celllist2").paramList = [];
            $id("celllist1").loadData();
            $id("celllist1").refresh();      
            $id("celllist2").loadData();
            $id("celllist2").refresh();
            alert("<fmt:message key='alert_success'/>");
            }    
     }
     
     
     //生效
     function effect_fun() {
           if($id("billid").value==""){
                alert("<fmt:message key='alert_select_one_invoice'/>");
                return;
           }
           if($id("type_bd_temp").value=="2"||$id("type_bd_temp").value=="3"){
                alert("<fmt:message key='alert_type_bd_2'/>");
                return;
           }
          var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=effectInvoice&id="+$id("tid").value+"&billid="+$id("billid").value;
          maskWindow();//遮罩
          jQuery.post(url,function(data){
                if(data){
                    if(data!="1"){
                         alert("<fmt:message key='alert_error'/>");
                         unMaskWindow();//取消遮罩
                         return;
                    }
                }
          });
          unMaskWindow();//取消遮罩
            //alert("操作成功！");
            $id("datacell1").loadData();
            $id("datacell1").refresh();
            $id("celllist1").paramList = [];
            $id("celllist2").paramList = [];
            $id("celllist1").loadData();
            $id("celllist1").refresh();      
            $id("celllist2").loadData();
            $id("celllist2").refresh();    
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
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
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
                    alert("<fmt:message key='alert_redata_0'/>");
                    return;
                }   
                else{
                    //跳转到流程详细信息页面
                	//to_monitor(contract_id);
                	var url="/FAERP/FininvoiceAction.do?cmd=getApprovalDetailsPage&wfname=" + wfname +"&mid=" +fin_invoice_id;
       					url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
					showModalCenter(url, window, "",740, 360, "<fmt:message key='approvaldetal'/>"); 
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
		writeTableTopFesco("<fmt:message key='title_invoiceQuery'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
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
                messagekey="select_cust" height="500" width="600" style="width:162px" />
            </td>
            <td align="right"><fmt:message key='cost_center'/></td>
            <td align="left">   
                    <r:comboSelect id="cost_center_id" name="cost_center_id"
                        queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                        textField="cost_center_name"
                        valueField="id"
                        xpath="CostcenterVo"
                        width="180"
                        messagekey="please_select"
                        >
                    </r:comboSelect>
             </td>
            <td width="100" align="right"><fmt:message key='invoice_code'/></td>
            <td width="213" align="left">
            <input type="text" class="text_field" name="invoice_code" id="invoice_code_input" inputName="票据号" maxLength="15" value="" style="width: 180px;"/>
            </td>
        </tr>
        
        
        <tr>
            <td align="right"><fmt:message key='bill_year_month'/></td>
            <td align="left">
                <input type="text" class="text_field" name="bill_year_month" id="bill_year_month_input" inputName="应收年月" maxLength="10" value=""  style="width: 185px;"/>
            </td>
            <td align="right"><fmt:message key='invoice_type_bd'/></td>
                        <td align="left">
                        <d:select dictTypeId="INVOICE_TYPE_BD" name="type_bd" nullLabel="--请选择--" style="width: 180px;" id="type_bd_select"/>
                        </td>
            <td align="right"><fmt:message key='create_date1'/></td>
                        <td align="left">
                        <w:date format="yyyy-MM-dd" name="create_date_from" width="70px" id="create_date_from"/><fmt:message key='inc_date_from_to'/><w:date format="yyyy-MM-dd" name="create_date_to" width="70px" id="create_date_to"/></td>
                        </td>
        </tr>
        
        <tr>
            <td align="right"><fmt:message key='invoice_amount_from'/></td>
            <td align="left">
                <input type="text" class="text_field"  style="width:86px" name="invoice_amount_from" value="" maxLength="15" onkeyup="if(isNaN(value))execCommand('undo')"  id="transact_day_from"/>到<input type="text" class="text_field" style="width:86px" maxLength="15" onkeyup="if(isNaN(value))execCommand('undo')"  name="invoice_amount_to" value=""  id="transact_day_to" />
            </td>
            <!-- add by sqp  2013年12月6日  -->
                  <td align="right"><fmt:message key='lk_cs'/></td>
                  <td align="left">
                    <w:lookup onReturnFunc="rtnFuncCS" style="width:170px" readonly="true" id="lk_cs" lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="select_cust_service" height="450" width="500"/>
                    </td>
                  <td align="right"><fmt:message key='cust_dept'/></td>
                  <td align="left">
                  <r:comboSelect id="cust_dept" name="cust_dept" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData"
                       textField="name" valueField="id" xpath="AupartyVO" width="180px" messagekey="please_select" />
                  </td>
           <!--end  -->
        </tr>
        <tr>
        <td>&nbsp;</td>
        <td align="right">开票状态</td>
            <td align="left">    
            <select id="kp_state" name="kp_state" style="width:170px;">
                <option>--请选择--</option>
                <option value="0">未开票</option>
                <option value="1">已开票</option>
            </select>
        </td>
        <td align="right">发票是否有效</td>
            <td align="left">
                <select id="is_valid_select" name="is_valid_select" style="width:180px;">
                    <option value="1">有效发票</option>
                    <option value="0">无效发票</option>
                    <option>--请选择--</option>
                </select>
         </td>
            <td align="right">&nbsp;</td>
                        <td align="left">
                        <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                        <input name="button_reset2" class="icon_1" type="reset" value='<fmt:message key="reset"/>' >&nbsp;</td>
            <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
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
                <input class="f" type="button"   value="<fmt:message key='zf'/>"  <au:authorityBtn code="fpcx_zf" type="1"/>  onClick="viewinvalid();">
		         <!--<input class="g" type="button"   value="生效"  <au:authorityBtn code="fpcx_sx" type="1"/>  onClick="effect_fun();">
		         -->
		         <input class="e" type="button"   value="<fmt:message key='export'/>"  <au:authorityBtn code="fpcx_exp" type="1"/>  onClick="exportToExcel();">
		         <input class="a" type="button"   value="<fmt:message key='mx'/>"  <au:authorityBtn code="fpcx_mx" type="1"/>  onClick="viewbillingdetails();">
		         <input class="approdetial" type="button"   value="<fmt:message key='approvaldetal'/>"  <au:authorityBtn code="fpcx_spxx" type="1"/>  onClick="spinto_onClick();">
		         <input class="j_1" type="button"  id="printerbutton"  value="<fmt:message key='print'/>"  <au:authorityBtn code="fpcx_spxx" type="1"/>  onclick="printer_onclick() ;"   >
		         <input class="approdetial" type="button"   value="发票导出"  <au:authorityBtn code="fpcx_invoice_exp" type="1"/>  onClick="exportInvoiceToExcel('old');">
		         <input class="e_2" type="button"   value="发票账单导出"  <au:authorityBtn code="fpcx_invoice_exp_new" type="1"/>  onClick="exportInvoiceToExcel('new');">
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
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operation" width="40px" onRefreshFunc="setCheckboxStatus" align="center" >
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
      <r:field fieldName="create_date" label="发票申请日期"  width="100px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>     
      <r:field fieldName="invoice_amount" messagekey="invoice_amount_from" width="75px">
        <h:text/>
      </r:field>
      <r:field fieldName="make_out_date" label="发票打印日期" width="100px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="type_bd" messagekey="invoice_type_bd" width="75px">
        <d:select dictTypeId="INVOICE_TYPE_BD" />
      </r:field>
      <r:field fieldName="printer_type_bd" messagekey="printer_type_bd" width="75px">
        <h:select property="printer_type_bd" disabled="true">
                         <h:option value="1" label="已打印"/>
                         <h:option value="2" label="未打印"/>
                         <h:option value="3" label="打印中"/>
                  </h:select>
      </r:field>
      <r:field fieldName="is_valid" label="是否有效" width="75px">
        <h:select property="is_valid" disabled="true">
                         <h:option value="0" label="无效"/>
                         <h:option value="1" label="有效"/>
                  </h:select>
      </r:field>
      <r:field fieldName="user_name" messagekey="user_name" width="70px">
      </r:field>
      <r:field fieldName="inv_desc" messagekey="inv_desc1" width="210px">
       <h:text/>
</r:field>
    </r:datacell>
    </div>
    
    
    <table cellpadding="0" style="padding: 8 0 8 8;" border="0" width="99%">
    <tr>
        <td valign="top" width="30%"><fmt:message key='bill_list'/><br>
                <r:datacell 
                        id="celllist1"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/FinbillAction.do?cmd=searchBillByInvoiceID"
                        width="97%" height="200px"
                        xpath="FinbillVo"
                        readonly="true"
                        >
                
                      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                      <r:field fieldName="bill_year_month" messagekey="bill_year_month">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="bill_amount" messagekey="bill_amount">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="bill_type_bd" messagekey="bill_type_bd">
                        <d:select dictTypeId="BILL_TYPE_BD"/>
                      </r:field>
                    </r:datacell>
        </td>
        <td valign="top" width="70%">
            <fmt:message key='finverification_list'/><br>
                    <r:datacell 
                        id="celllist2"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/FinverificationAction.do?cmd=getFinverificationByInvoiceID"
                        width="100%" height="200px"
                        xpath="FinverificationVo"
                        readonly="true"
                        >
                
                      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                      <r:field fieldName="ver_amount" messagekey="ver_amount_">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="rate_odds" messagekey="rate_odds">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="create_date" messagekey="ver_create_date" width="150px">
                        <w:date format="yyyy-MM-dd HH:mm:ss" />
                      </r:field>
                      <r:field fieldName="inc_code" messagekey="inc_code">
                        <h:text/>
                      </r:field>       
                      <r:field fieldName="inc_date" messagekey="inc_date">
                        <w:date format="yyyy-MM-dd"/>
                      </r:field>
                      <r:field fieldName="inc_amout" messagekey="inc_amout_from_">
                        <h:text/>
                      </r:field>           
                    </r:datacell>
        </td>
     </tr>
   </table>
    
</div>
</div>

</fmt:bundle>
</body>
</html>

