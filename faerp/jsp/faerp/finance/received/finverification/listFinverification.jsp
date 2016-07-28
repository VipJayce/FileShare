<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.received.finverification.finverification_resource" prefix="rayoo.finance.received.finverification.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("claim_id") + "\",\"" + entity.getProperty("bill_id") + "\",\"" + entity.getProperty("invoice_id") + "\",\""+entity.getProperty("used_verid")+"\",\""+entity.getProperty("incoming_id")+"\",\""+entity.getProperty("bill_type_bd")+"\",\""+entity.getProperty("claim_status_bd")+"\",\""+entity.getProperty("inc_code")+"\",\""+entity.getProperty("approval_status")+"\");>";
    }

   function ClickRow(value,value1,value2,value3,value4,value5,value7,value6,value8,value9){
        //alert("claim_id="+value1);
        $id("verification_id").value = value;
        $id("claim_id").value = value1;
        $id("bill_id").value = value2;
        $id("invoice_id").value = value3;
        $id("used_verid").value = value4;
        $id("incoming_id").value = value5;
        $id("claim_status_bd").value = value6;
        $id("bill_type_bd1").value = value7;
        $id("inc_code").value = value8;
        $id("approval_status").value = value9;
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        $id("verification_id").value ="";
    }
    
     jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });

    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        $id("custname").value=$id("lk_cust").displayValue;
        $id("cost_center_id").addParam("cust_id", arg[0]+"");
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }

    function resetQuery(){
        $id("custname").value="";
    }
    
    //给form表单中的到款编号赋值    by zhouxiaolong   begin
    function setInc_code(){
    	$id("inc_code").value=$id("inc_code1").value;
    }
  //给form表单中的到款编号赋值    by zhouxiaolong   end
    //查看核销详情
    function toDetail_onClick(){
        var verification_id = jQuery("#verification_id").val();
        var claim_id = jQuery("#claim_id").val();
        var bill_id = jQuery("#bill_id").val()+"";
        var invoice_id = jQuery("#invoice_id").val();
        var used_verid = jQuery("#used_verid").val();
        if(verification_id==null ||  verification_id==""){
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
        var datacell_formid = $id("datacell_formid");
        //datacell_formid.action ="<%=request.getContextPath()%>/FinverificationAction.do?cmd=detailFinverification";
        //datacell_formid.submit();
        
        var url = "<%=request.getContextPath()%>/FinverificationAction.do?cmd=detailFinverification&verification_id=" + verification_id+"&bill_id="+bill_id+"&claim_id="+claim_id;
        url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数;
        //showModalCenter(url, "", "", "1024", "400", "实收明细");
        
        var w = 1024;
        var h = 800;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=yes,resizable=no,location=no,status=no'; 
        window.open(url, "<fmt:message key='title_detail'/>", s);
        
    }
    
    //作废
    function toInvalid_onClick(){
        var verification_id = jQuery("#verification_id").val();
        var claim_id = jQuery("#claim_id").val();
        var incoming_id = jQuery("#incoming_id").val();
        var claim_status_bd = jQuery("#claim_status_bd").val();
        var inc_code = jQuery("#inc_code").val();
        var bill_id = jQuery("#bill_id").val();
        var approval_status = jQuery("#approval_status").val();
        if(verification_id==null ||  verification_id==""){
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
        
        if(approval_status== "1"){
            //如果为审批中则不让取消
            alert("该笔核销正在进行取消审批，请耐心等待！");
            return;
        }
        
        if(incoming_id==null || incoming_id=="" || incoming_id=="null"){
            alert("<fmt:message key='alert_incoming_id'/>");
            return;
        }else{
            //if(claim_status_bd=="1"){
            //    alert('未认领的到款不能取消认领。');
            //    return false;
            //}
            if(!confirm("<fmt:message key='is_invalid'/>")){
                return false;
            }
            checkCancelclaim(incoming_id, claim_id,verification_id,inc_code,bill_id);
        }
    }
    
    function checkCancelclaim(incomingid,claim_id, ver_id,inc_code,bill_id) {
        //取消认领：
        _$.ajax({
	        type : "post",
	        url : venusbase + "/FinclaimAction.do?cmd=lockCancelClaim&inc_id=" + incomingid+"&bill_id="+bill_id,
	        dataType : "html",
	        async: false,
	        success : function(data) {
	            if(data != "") {
	                alert(data);
	            } else {
	                    showProgressBar();
	                    //取消认领：
	                    _$.ajax({
	                        type : "post",
	                        url : venusbase + "/FinclaimAction.do?cmd=cancelclaim&id=" + incomingid+"&claim_id="+claim_id+"&verification_id="+ver_id,
	                        dataType : "html",
	                        async: false,
	                        success : function(data) {
	                            if(data) {
	                                if (data == '1') {
	                                    //跳转填写原因界面 走审批流
	                                    showModalCenter(venusbase+"/FinclaimAction.do?cmd=toCancelRemarks&incomingid=" + incomingid+"&claim_id="+claim_id+"&verification_id="+ver_id,null,freshdc,500,300,"取消原因");
	                                }else{
	                                    alert(data);
	                                }
	                            } else {
	                               alert("取消认领失败。");
	                            }
	                        }
	                    });
	                    unlockBillAndClaim(bill_id,inc_code);
	                    hideProgressBar();
	            } 
	        }
        });
    }
    
    //填写原因后执行的方法
	function freshdc(retVal){
	    showListData();
	}
    
	function list2approvalItem() {
		var verification_id = jQuery("#verification_id").val();
        var bill_id = jQuery("#bill_id").val()+"";
        var bill_type_bd = jQuery("#bill_type_bd1").val();
        if(verification_id==null ||  verification_id==""){
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
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
        }else{
	        _$.ajax({
            type : "post",
            url : "/FAERP/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
            dataType : "html",
            success : function(data) {
            	//if (data!=""&&data=="此账单无明细，数据可能异常。") {
                    //alert("此账单无明细，数据可能异常。");
                //} else {
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
                    }else{
                       alert('id is null');
                    }
               // }
            }
        	});
        }
	}
	
   //导出
   function exportExcel(){
        if(!confirm('确认导出数据?')){
            return false;
         }
         var url = "<%=request.getContextPath()%>/FinverificationAction.do?cmd=export";
         _$("#datacell_formid").attr("action", url);
         _$("#datacell_formid").submit();
         _$("#datacell_formid").attr("action", "");
    }
    
    //解锁取消认领对 认领和账单的锁定
    function unlockBillAndClaim(bill_id,inc_code) {
	    _$.ajax({
	        type : "post",
	        url : venusbase + "/FinclaimAction.do?cmd=unLockAllFinClaimAndBillByPage&bill_id=" + bill_id + "&inc_codes=" + inc_code,
	        dataType : "text",
	        success : function(data) {
	        }
	    });
    }
    
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input id="custname" name="custname" type="hidden"  value="" />
<input id="verification_id" name="verification_id" type="hidden"  value="" />
<input id="claim_id" name="claim_id" type="hidden"  value="" />
<input id="bill_id" name="bill_id" type="hidden"  value="" />
<input id="bill_type_bd1" name="bill_type_bd1" type="hidden"  value="" />
<input id="invoice_id" name="invoice_id" type="hidden"  value="" />
<input id="used_verid" name="used_verid" type="hidden"  value="" />
<input id="incoming_id" name="incoming_id" type="hidden"  value="" />
<input id="claim_status_bd" name="claim_status_bd" type="hidden"  value="" />
<input id="inc_code" name="inc_code" type="hidden"  value="" />
<input id="approval_status" name="approval_status" type="hidden"  value="" />
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='title_finverification'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right"><fmt:message key='cust_name'/></td>
            <td align="left">    
            <w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_cust" style="width: 180" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="550"/>
            </td>
            <td align="right"><fmt:message key='cost_center'/></td>
            <td align="left">
                    <r:comboSelect id="cost_center_id" name="cost_center_id"
                        queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                        textField="cost_center_name"
                        valueField="cost_center_name"
                        xpath="CostcenterVo"
                        width="195" messagekey="please_select">
                    </r:comboSelect>
            <input type="hidden" id="hid_cost_center_id" value="">     
             </td>
            <td width="100" align="right"><fmt:message key='billyearmonth'/></td>
            <td width="213" align="left">
            <input type="text" class="text_field" name="billyearmonth" inputName="应收年月" maxLength="50" value=""/>
            </td>
        </tr>
        
        
        <tr>
            <td align="right"><fmt:message key='bill_type_bd'/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_type_bd", -1,"FB_BILL_TYPE_BD",  request.getAttribute("bill_type_bd") == null ? "" : String.valueOf(request.getAttribute("bill_type_bd")),"inputName='应收类型'   style='width:200px' ", false)%>
            </td>
            <td align="right"><fmt:message key='inc_date_from'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="inc_date_from" width="70px"/>&nbsp;<fmt:message key='to'/>&nbsp;<w:date format="yyyy-MM-dd" name="inc_date_to" width="70px"/>
            </td>
            <td align="right"><fmt:message key='inc_code'/></td>
            <!--2016-04-08 给form表单中的到款编号赋值   by zhouxiaolong  begin-->
            <td align="left"><input type="text" class="text_field" id="inc_code1" name="inc_code" inputName="到款编号" onblur="setInc_code()" maxLength="50" value=""/></td>
            <!--2016-04-08 给form表单中的到款编号赋值   by zhouxiaolong  end-->
        </tr>
        
        <tr>
            <td align="right"><fmt:message key='lk_cs'/></td>
            <td align="left">
              <r:comboSelect id="lk_cs" name="lk_cs"
                 queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                 textField="name"
                 valueField="name"
                 xpath="CustServiceVo"
                 width="200px"
                 messagekey="please_select" />

                </td>
            <td> <td/>
            <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();resetQuery()">
        </tr>
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="a_3">      <a  onClick="javascript:toDetail_onClick();">查看核销详情</a> </li>
                    <li class="f">      <a  onClick="javascript:toInvalid_onClick();">作废</a> </li>
                </ul>
                -->
                <input class="a_3" type="button"   value="<fmt:message key='ckhxxq'/>"  <au:authorityBtn code="sscx_ckhxxq" type="1"/>  onClick="toDetail_onClick();">
                <input class="f" type="button"   value="<fmt:message key='zf'/>"  <au:authorityBtn code="sscx_zf" type="1"/>  onClick="toInvalid_onClick();">
                <input class="b_1" type="button"   value="查看账单明细" onClick="list2approvalItem();">
                 <input class="e" type="button"   value="导出"  <au:authorityBtn code="sscx_dc" type="1"/>  onClick="exportExcel();">
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinverificationAction.do?cmd=searchFinverificationData"
        width="98%"
        height="320px"
        xpath="FinverificationVoAdd"
        allowDel="true" 
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operation" width="40px" onRefreshFunc="setCheckboxStatus" align="center" >
       </r:field> 
      <r:field fieldName="cust_code" messagekey="cust_code" allowModify="false" width="80px">
        <h:text/>
      </r:field>
      <r:field fieldName="cust_name" messagekey="cust_name" width="150px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="cost_center_name" messagekey="cost_center" width="150px" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="bill_year_month" messagekey="billyearmonth" allowModify="false" width="70px">
       <h:text/>
      </r:field>
      <r:field fieldName="bill_amount" messagekey="bill_amount" allowModify="false" width="90px">
       <h:text/>
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" allowModify="false" width="130px">
        <w:date format="yyyy-MM-dd HH:mm:ss" />
      </r:field>
      <r:field fieldName="ver_amount" messagekey="ver_amount" allowModify="false" width="90px">
        <h:text/>
      </r:field>
      <r:field fieldName="verification_amount" label="总核销金额" allowModify="false" width="90px">
        <h:text/>
      </r:field>
      <r:field fieldName="name" messagekey="name" allowModify="false" width="80px">
        <h:text/>
      </r:field>
      <r:field fieldName="rate_odds" messagekey="rate_odds" allowModify="false" width="70px">
        <h:text/>
      </r:field>
      <r:field fieldName="rate_amount" messagekey="rate_amount" allowModify="false" width="70px">
      </r:field>
      <r:field fieldName="inc_code" messagekey="inc_code" allowModify="false" width="90px">
       <h:text/>
      </r:field>
      <r:field fieldName="inc_date" messagekey="inc_date_from" allowModify="false" width="70px">
      <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="inc_bank" messagekey="inc_bank" allowModify="false" width="70px">
      <d:select dictTypeId="BANK"></d:select>
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

