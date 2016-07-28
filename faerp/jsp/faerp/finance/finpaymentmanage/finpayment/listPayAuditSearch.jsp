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
<fmt:bundle basename="rayoo.finance.finpaymentmanage.finpayment.finpayment_resource" prefix="rayoo.finance.finpaymentmanage.finpayment.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='page_listpayauditsearch'/></title>
<script language="javascript">
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

	function rtnFuncCustomer(arg){
	    var lookup = $id("cust_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    return false;
	}
	
	function rtnFuncUser(arg){
	    var lookup = $id("emp_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    return false;
	}

    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key='alert_select_one'/>");
           return;
        }
     return obj;
    }
    
    function toPayAudit_onClick(){
    entity=choose_row("datacell1");
    var tid=entity.getProperty("id");
    //alert("tid="+tid);
     form.action="<%=request.getContextPath()%>/FinpaymentAction.do?id=" + tid;
     form.cmd.value = "find";
     form.submit();
    }
    

    
    
    
    function toDetailPage_onClick(){
            dc = $id("datacell1");
		    clz = dc.getActiveEntity();
		    if(!clz){
		        alert("<fmt:message key='alert_select_one'/>");
		        return ;
		    }
		    var is_have_item = clz.getValue("is_have_item");
		    if(is_have_item==null||is_have_item=="0"){
		          alert("<fmt:message key='alert_is_have_item'/>");
		          return;
		    }else if(is_have_item=="1"){
		           //alert("有明细id="+clz.getValue("id"));
		           var url="<%=request.getContextPath()%>/jsp/faerp/finance/finpaymentmanage/finpayment/payDetail.jsp?id="+clz.getValue("id")+"&payment_type_bd="+clz.getValue("payment_type_bd"); 
		           url=url+'&_ts='+(new Date()).getTime(); 
		           showModalCenter(url, window, "", screen.width-300, screen.height-260, "<fmt:message key='page_viewdetail'/>");  //增加子岗位
		    }
    }
    
           //导出数据
       function exportToExcel() {  
           if(confirm("<fmt:message key='alert_is_export'/>")) {
            form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=exportToExcel";
            form.submit();
            }
        }  
        
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    /******************************2014年6月13日 添加 财务审核和驳回*****************************************/
    //能审批的数据要满足以下条件：1.社保或公积金  2.财务审批中
    function toSubmitApproval_onClick(){
    var ids=selectIds();
    var status_flag= isTheSameStatus();//当返回值是true时通过
    var type_flag=  isAllSAndG();//当返回值是true时通过
    if(ids==null||ids==""){
             alert('<fmt:message key="alert_select_one"/>');
             return;
        }
    if(type_flag=="false"){
             alert('<fmt:message key="select_same_type_info"/>');
             return;
    }
    if(status_flag=="false"){
             alert('<fmt:message key="select_same_status_info"/>');
             return;
    }
    var action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=approveData";
    var myAjax = new Ajax(action);
    myAjax.addParam("ids",ids);
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode){
        alert(""+myAjax.getProperty("returnValue"));
        showListData();
    }
    
    }
   //驳回 条件同审批
 function rejectAudit(){
    var ids=selectIds();
    var status_flag= isTheSameStatus();//当返回值是true时通过
    var type_flag=  isAllSAndG();//当返回值是true时通过
    if(ids==null||ids==""){
             alert('<fmt:message key="alert_select_one"/>');
             return;
        }
    if(type_flag=="false"){
             alert('<fmt:message key="select_same_type_info"/>');
             return;
    }
    if(status_flag=="false"){
             alert('<fmt:message key="select_same_status_rejectinfo"/>');
             return;
    }
    var action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=rejecData";
    var myAjax = new Ajax(action);
    myAjax.addParam("ids",ids);
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode){
        alert(""+myAjax.getProperty("returnValue"));
        showListData();
    }
    }
    
    
    //校验是允许审批的数据
      function  isTheSameStatus() {                   
       var dc = $id("datacell1");
       var flag="true";
       jQuery("input[type='checkbox']").each(function (i){
         if (i != 0 && _$(this).attr("checked")) {
             var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
             var entity = dc.getEntity(row);
             var status=entity.getValue("audit_status");
             if(status!=2){
                flag="false";
             }
            }
        });
       return flag;                
    } 
    //校验是否全是社保或公积金
    function  isAllSAndG() {                   
       var dc = $id("datacell1");
       var flag="true";
       var type_bd_strs = "";
       jQuery("input[type='checkbox']").each(function (i){
         if (i != 0 && _$(this).attr("checked")) {
             var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
             var entity = dc.getEntity(row);
             var type_bd=entity.getValue("payment_type_bd");
             if(type_bd_strs == "" || type_bd_strs.indexOf(type_bd)<0){
                if(type_bd==2 || type_bd==1){
                   type_bd_strs += "sbgjj_"+type_bd+","; 
                }else{
                   type_bd_strs += "cbqx_"+type_bd+",";
                }
             }
             /*
             if(!(type_bd==2 || type_bd==1)){
                flag="false";
             }
             
             if(!(type_bd==12 || type_bd==13)){
                flag="false";
             }*/
            }
        });
        if((type_bd_strs.indexOf("sbgjj_1")>=0 || type_bd_strs.indexOf("sbgjj_2")>=0) && (type_bd_strs.indexOf("cbqx_12")>=0 || type_bd_strs.indexOf("cbqx_13")>=0)){
            flag="false";
        }
       return flag;                
    }
    
    //选择供应商的返回方法
    function rtnFuncAgent(arg){
        var lookup = $id("lk_agent");
        lookup.displayValue = arg[2];
        _$("#agent_id").val(arg[0]);
        return false;
    }
    
//生成网银  只针对于工行
function createEbank(){
    var dc = $id("datacell1");
    var ids = new Array();
    var is_agent = true ;
    var is_allow = true ;
    
    jQuery("input[type='checkbox']").each(function(i){
        if(jQuery(this).attr("checked") && i != 0){
           var row = dc.table.tBodies[0].rows[i-1];
           var entity = dc.getEntity(row);
           ids.push(entity.getValue("id"));
           var agent_code  =  entity.getValue("agent_code"); 
           var audit_status  =  entity.getValue("audit_status"); 
           var receiver_type_bd = entity.getValue("receiver_type_bd");//add by dongying 20151113
           
           if(receiver_type_bd == "" ||  receiver_type_bd== null){//modify by dongying 20151113
             is_agent = false;
           }
           if(audit_status != "4"){
             is_allow = false;
           }
        }
    });
    if(ids == "" || ids == null){
      alert("请选择一条记录");
      return false;
    }
    if (is_agent == false){
      alert("只有针对供应商的支付才能生成网银!") ;
      return false ;
    }
    if (is_allow == false){
      alert("只有审批状态为出纳完成的支付才能生成网银!") ;
      return false ;
    }
    var payment_ids = ids.join() ;
    //查询是否有空账号的供应商
    var check_url = "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=checkAccount&payment_ids="+payment_ids;
    jQuery.ajax({
       url: check_url,
       type: 'GET',
       dataType: 'html',
       async: false,
       timeout: 10000,
       success: function(text){
                if(text == "1"){
					     jQuery.ajax({
						       url: "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=createEbankfile&payment_ids="+payment_ids,
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
                }else{
                        alert(text);
                }
       }
   });  
   
}

//下载网银
function downloadEbank(){
    var dc = $id("datacell1");
    var ids = new Array();
    
    jQuery("input[type='checkbox']").each(function(i){
        if(jQuery(this).attr("checked") && i != 0){
           var row = dc.table.tBodies[0].rows[i-1];
           var entity = dc.getEntity(row);
           ids.push(entity.getValue("id"));
        }
    });
    if(ids == "" || ids == null){
      alert("请选择一条记录");
      return false;
    }
    
    if(ids.length>1){
      alert("只能选择一条记录");
      return false;
    }
    
    var payment_id = ids.join() ;
    jQuery.ajax({
           url : "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=queryEbankFile&payment_id="+payment_id,
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
                    form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=downloadEbankFile&payment_id="+payment_id;
                    form.submit();
                    form.action="";
               }else{
                    alert(text);
               }
           }
     });  
}

//支付完成
function agentPayFinish(){
    var dc = $id("datacell1");
    var ids = new Array();
    var is_agent = true ;
    var is_allow = true ;
    
    jQuery("input[type='checkbox']").each(function(i){
        if(jQuery(this).attr("checked") && i != 0){
           var row = dc.table.tBodies[0].rows[i-1];
           var entity = dc.getEntity(row);
           ids.push(entity.getValue("id"));
           var agent_code  =  entity.getValue("agent_code"); 
           var audit_status  =  entity.getValue("audit_status"); 
           
           if(agent_code == "" ||  agent_code== null){
             is_agent = false;
           }
           if(audit_status != "4" && audit_status != "5"){
             is_allow = false;
           }
        }
    });
    if(ids == "" || ids == null){
      alert("请选择一条记录");
      return false;
    }
    if (is_agent == false){
      alert("只有针对供应商的支付才需要设置为支付完成!") ;
      return false ;
    }
    if (is_allow == false){
      alert("只有审批状态为出纳完成或已生成网银的支付才能设置为支付完成!") ;
      return false ;
    }
    var payment_ids = ids.join() ;
    //查询是否有空账号的供应商
    var check_url = "<%=request.getContextPath()%>/FinpaymentAction.do?cmd=setAgentPayFinish&payment_ids="+payment_ids;
    jQuery.ajax({
       url: check_url,
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
     
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">

<input type="hidden" name="payment_ids" id="payment_ids"/>
<input type="hidden" name="cmd" id="cmd"/>
<div id="right">
	<script language="javascript">
		writeTableTopFesco("<fmt:message key='page_listpayauditsearch'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="128" rowspan="5" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
          
            <td width="114"/>
            <td width="148"/>
              <td width="107">    </td>
                <td width="247"/>
        </tr>
                <tr>
                  <td align="right"><fmt:message key='payment_type_bd'/></td>
                  <td align="left"><d:select dictTypeId="PAYMENT_TYPE_BD"  property="payment_type_bd" id="payment_type_bd" nullLabel="--请选择--" style="width:190px"/>                  </td>
                  <td align="right"><fmt:message key='receiver_type_bd'/></td>
                  <td align="left"><d:select dictTypeId="RECEIVER_TYPE_BD"  property="receiver_type_bd" id="receiver_type_bd" nullLabel="--请选择--" style="width:190px"/>                  </td>
                  <td width="112" align="right"><fmt:message key='cust_name'/></td>
                  <td width="237" align="left"><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_id" name="cust_id" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="440" width="600"  style="width:170px"/>                  </td>
            </tr>
        <tr>
        
          <!-- 
          <td align="right">受款员工</td>
          <td align="left"><w:lookup onReturnFunc="rtnFuncUser" readonly="true" id="emp_id" name="emp_id" lookupUrl="/FinpaymentAction.do?cmd=getAllEmployeeByCondition" dialogTitle="选择员工" height="440" width="600" style="width:170px"/>          </td>
          -->
            
            <td align="right"><fmt:message key='receiver_name'/></td>
            <td align="left">
			<input type="text" class="text_field" name="receiver_name" inputName="受款方名称" maxLength="50" value="" style="width:190px"/>
            </td>
            <td align="right"><fmt:message key='apply_date'/></td>
            <td align="left"><w:date format="yyyy-MM-dd" id="apply_date_from" name="apply_date_from" width="70px"/>至<w:date format="yyyy-MM-dd" id="apply_date_to" name="apply_date_to" width="70px"/></td>
            
            <td align="right"><fmt:message key='cashier_operate_date'/></td>
            <td align="left"><w:date format="yyyy-MM-dd" id="cashier_operate_date_from" name="cashier_operate_date_from" width="70px"/>至<w:date format="yyyy-MM-dd" id="cashier_operate_date_to" name="cashier_operate_date_to" width="70px"/></td>
       
       
        </tr>
        
        <tr>
          <td align="right"><fmt:message key='apply_amount'/></td>
          <td align="left"><input type="text" class="text_field" name="apply_amount_from" inputName="申请付款金额" maxLength="50" value="" style="width:80px"/>&nbsp;至&nbsp;<input type="text" class="text_field" name="apply_amount_to" inputName="申请付款金额" maxLength="50" value="" style="width:80px"/></td>
            <td align="right"><fmt:message key='audit_status'/></td>
              <td align="left"><d:select dictTypeId="FIN_PAY_AUDIT_STATUS"  property="audit_status" id="audit_status" nullLabel="--请选择--" style="width:190px"/></td>
			  <td align="right"><fmt:message key='reimburse_status_bd'/></td>
			  <td align="left"><d:select dictTypeId="REIMBURSE_STATUS_BD"  property="reimburse_status_bd" id="reimburse_status_bd" nullLabel="--请选择--" style="width:190px"/></td>
        </tr>
        <tr>
          <td align="right"><fmt:message key='voucher_status'/></td>
        <td align="left">
        	<d:select name="voucher_status" id="voucher_status" dictTypeId="VOUCHER_STATUS" nullLabel="--请选择--" style="width:190px"/>
        </td>
        <!--  <td  align="right">供应商</td>
         <td  align="left">
           <w:lookup readonly="true"
                    id="lk_agent"
                    lookupUrl="/FAERP/AgentAction.do?cmd=getAllAgentByConditionnew"
                    dialogTitle="选择供应商"  height="450" width="610" style="width:173px" onReturnFunc="rtnFuncAgent"/>
                <input id="agent_id" name="agent_id" type="hidden"/>                
         </td>-->
         <td  align="right">供应商编号</td>
         <td  align="left">
            <input type="text" class="text_field" name="agent_code" inputName="供应商编号" maxLength="50" value="" style="width:190px"/>
         </td>
          <td align="right">&nbsp;</td>
          <td align="left"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset()"></td>
        </tr>
</table>
</div>


<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="h_1">      <a  onClick="javascript:toDetailPage_onClick();">查看明细</a> </li>
                    <li class="e">      <a  onClick="javascript:exportToExcel();">导出</a> </li>
                </ul>
         -->
         <input type="button" class="h_1" value="<fmt:message key='button_viewdetail'/>" <au:authorityBtn code="zfcx_ckmx" type="1"/> onClick="toDetailPage_onClick();" />
         <input type="button" class="e" value="<fmt:message key='button_export'/>" <au:authorityBtn code="ydfyzf_exp" type="1"/> onClick="exportToExcel();" />
         <input type="button" class="h_1" value="<fmt:message key='button_dcmx'/>" <au:authorityBtn code="ydfyzf_dcmx" type="1"/> onClick="javascript:exportEXCEL_onClick();"/>
         <input type="button" class="e_2" value="导出客户明细" <au:authorityBtn code="ydfyzf_dcmx" type="1"/> onClick="javascript:exportCustInfo_onClick();"/>
         <input class="b_1" type="button"   value="<fmt:message key='button_fkpz'/>"  <au:authorityBtn code="zfcx_ckmx" type="1"/>  onClick="showVoucher();">
         <input class="b_1" type="button"   value="<fmt:message key='button_zzpz'/>"  <au:authorityBtn code="zfcx_ckmx" type="1"/>  onClick="showVoucher2();">
         <input class="p_1" type="button"   value="<fmt:message key='button_plscpz'/>"  <au:authorityBtn code="dkrl_batch_vouecher" type="1"/>  onClick="batchCreateVoucher();">
          <input class="h_1" type="button"   value="<fmt:message key='button_sh'/>"  <au:authorityBtn code="zfcx_sp" type="1"/>  onClick="toSubmitApproval_onClick();">    
          <input class="tb_1"  type="button"   value="<fmt:message key='button_bh'/>"  <au:authorityBtn code="zfcx_bh" type="1"/>  onClick="rejectAudit();">
          <input class="b_1" type="button"   value="生成网银"  <au:authorityBtn code="zfcx_scwy" type="1"/>  onClick="createEbank();">
          <input class="b_1" type="button"   value="下载网银"  <au:authorityBtn code="zfcx_xzwy" type="1"/>  onClick="downloadEbank();">
          <input class="b_1" type="button"   value="支付完成"  <au:authorityBtn code="zfcx_zfwc" type="1"/>  onClick="agentPayFinish();">
    </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinpaymentAction.do?cmd=searchFinpaymentData"
        width="98%"
        height="318px"
        xpath="FinpaymentVo"
        readonly="true"
        pageSize="200"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field allowModify="false" fieldName="chk"
           label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
           sortAt="none" width="30px">
           <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
       </r:field>
      <r:field fieldName="receiver_type_bd" messagekey="receiver_type_bd" width="90px">
      <d:select dictTypeId="RECEIVER_TYPE_BD"></d:select>
      </r:field>
      <r:field fieldName="receiver_name" messagekey="receiver_name" width="150px">
        <h:text/>
      </r:field>
      <r:field fieldName="customer_code" messagekey="customer_code" width="100px">
        <h:text/>
      </r:field>
      <r:field fieldName="agent_code" label="供应商编号" width="100px">
      </r:field>
      <r:field fieldName="agent_name" label="供应商名称" width="150px">
      </r:field>
      <r:field fieldName="user_name" messagekey="user_name" width="100px">
        <h:text/>
      </r:field>
      <r:field fieldName="payment_type_bd" messagekey="payment_type_bd" width="90px">
        <d:select dictTypeId="PAYMENT_TYPE_BD"></d:select>
      </r:field>
       <r:field fieldName="invoice_num" messagekey="invoice_num" width="70px">
        <h:text/>
      </r:field>    
      <r:field fieldName="audit_amount" messagekey="audit_amount" >
        <h:text/>
      </r:field> 
      <r:field fieldName="apply_amount" messagekey="apply_amount" >
        <h:text/>
      </r:field>
      <r:field fieldName="applyusername" messagekey="apply_user_name"  width="90px">
       <h:text/>
      </r:field>
      <r:field fieldName="create_date" messagekey="apply_date" width="90px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="apply_amount" messagekey="apply_amount_" >
        <h:text/>
      </r:field>
      <r:field fieldName="audit_status" messagekey="audit_status_" >
        <d:select dictTypeId="FIN_PAY_AUDIT_STATUS"></d:select>
      </r:field>
      <r:field fieldName="reimburse_status_bd" messagekey="reimburse_status_bd" width="90px">
        <d:select dictTypeId="REIMBURSE_STATUS_BD"></d:select>
      </r:field>
      <!--  
      <r:field fieldName="is_have_item" label="下个审批人" >
        <h:text/>
      </r:field>
      -->
      <r:field fieldName="cashier_operate_date" messagekey="cashier_operate_date" width="130px">
         <w:date format="yyyy-MM-dd HH:mm:ss"/>
      </r:field>
      <r:field fieldName="payment_purpose" messagekey="payment_purpose" width="250px">
        <h:text/>
      </r:field> 
      <r:field fieldName="voucher_status" messagekey="voucher_status" width="90px">
				<d:select dictTypeId="VOUCHER_STATUS"></d:select>
			</r:field>
		<r:field fieldName="voucher_ym" messagekey="voucher_ym" width="90px">
		</r:field>
		<r:field fieldName="should_pay_date" label="应到款日" allowModify="false">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="expected_advanced_date" label="垫付后预计到款日" allowModify="false">
                <w:date format="yyyy-MM-dd" />
            </r:field>
		<r:field fieldName="payment_desc" messagekey="payment_desc" width="550px">
        <h:text/>
      </r:field> 
    </r:datacell>
    </div>
</div>
</div>
</form>

</body>
</html>
<script type="text/javascript">
    /*
    $id("emp_id").beforeOpenDialog = function(lookup1){
    lookup1.params = [];
    lookup1.addParam("cust_id", $id("cust_id").getValue());
    return true;
    }
    */
    
    
      function exportEXCEL_onClick(){
            dc = $id("datacell1");
            clz = dc.getActiveEntity();
            if(!clz){
                alert("<fmt:message key='alert_select_one'/>");
                return ;
            }
            var is_have_item = clz.getValue("is_have_item");
            if(is_have_item==null||is_have_item=="0"){
                  alert("<fmt:message key='alert_is_have_item'/>");
                  return;
            }else if(is_have_item=="1"){
                var payment_id=clz.getValue("id");
			      if(payment_id != null && payment_id !=""){
			           var url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showReportFin_Payment.jsp?raq=fin_payment_item.raq&payment_id="+payment_id+"&arg2";
			           showModalCenter(url, window, "", screen.width-300, screen.height-350, "<fmt:message key='page_exportdata'/>");  
			      }else{
			         alert("<fmt:message key='alert_data_err'/>");
			         return;
			      }
			}
  }
  
  function exportCustInfo_onClick(){
  	dc = $id("datacell1");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var is_have_item = clz.getValue("is_have_item");
            if(is_have_item==null||is_have_item=="0"){
                  alert("<fmt:message key='alert_is_have_item'/>");
                  return;
            }else if(is_have_item=="1"){
                var payment_id=clz.getValue("id");
			      if(payment_id != null && payment_id !=""){
			           var url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showReportFin_Payment.jsp?raq=fin_cust_payment_item.raq&payment_id="+payment_id+"&arg2";
			           showModalCenter(url, window, "", screen.width-300, screen.height-350, "<fmt:message key='page_exportdata'/>");  
			      }else{
			         alert("<fmt:message key='alert_data_err'/>");
			         return;
			      }
			}
  }
  
/**
 * 预览凭证
 */
function showVoucher(){

    var datacell = $id("datacell1");
    var dataset1 = datacell.dataset;
    //var entity = datacell.getActiveEntity();
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
    var payment_id =ids[0] ;//entity.getValue("id");
    var datasettr1 = dataset1.findEntity("id",ids[0]); 
    var payment_type_bd = datasettr1.getValue("payment_type_bd");
    var audit_status = datasettr1.getValue("audit_status");
    //审核状态非"出纳完成"
    if(audit_status!=4){
    	alert("<fmt:message key='alert_audit_status'/>");
    	return;
    }
     
    var bus_id = datasettr1.getValue("bus_id");
    var isPay = "";
    if(payment_type_bd == 4 && bus_id != null && bus_id != ""){
        jQuery.ajax({
	       url: "<%=request.getContextPath()%>/SalarybatchAction.do?cmd=checkIsPay&bus_id="+bus_id,
	       type: 'GET',
	       dataType: 'html',
	       async: false,
	       timeout: 10000,
	       success: function(text){
	                           if(text != "" && text != null){
	                               isPay = text;
	                           }
	                       }
        });  
        
        if(isPay != "" ){
            alert(isPay);
            return false;
        }
    }
   	if (payment_id) {
        //w为窗口宽度，h为高度
        var w = 815;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showVoucherFin&payment_id=" + payment_id +"&payment_type_bd="+payment_type_bd;
        //url = encodeURI(url);
        window.open(url, 'newwindow', s);
   }
}
/**
 * 预览凭证-转账凭证
 */
function showVoucher2(){
    var datacell = $id("datacell1");
    var dataset1 = datacell.dataset;
    //var entity = datacell.getActiveEntity();
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("请选择一条记录！");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
    var payment_id =ids[0] ;//entity.getValue("id");
    var datasettr1 = dataset1.findEntity("id",ids[0]); 
    var payment_type_bd = datasettr1.getValue("payment_type_bd");
    var audit_status = datasettr1.getValue("audit_status");
    var bus_id = datasettr1.getValue("bus_id");
    
/*
	var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("请先选择一条记录");
        return ;
    }
    var payment_id = entity.getValue("id");
    var payment_type_bd = entity.getValue("payment_type_bd");
    var audit_status = entity.getValue("audit_status");
    //审核状态非"出纳完成"

*/
    if(audit_status!=4){
    	alert("<fmt:message key='alert_audit_status'/>");
    	return;
    }
    
    //add by whj 2015-08-14 验证工资是否已发放
    var isPay = "";
    if(payment_type_bd == 4 && bus_id != null && bus_id != ""){
        jQuery.ajax({
	       url: "<%=request.getContextPath()%>/SalarybatchAction.do?cmd=checkIsPay&bus_id="+bus_id,
	       type: 'GET',
	       dataType: 'html',
	       async: false,
	       timeout: 10000,
	       success: function(text){
	                           if(text != "" && text != null){
	                               isPay = text;
	                           }
	                       }
        });  
        
        if(isPay != "" ){
            alert(isPay);
            return false;
        }
    }
    
   	if (payment_id) {
        //w为窗口宽度，h为高度
        var w = 815;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showVoucherFin&payment_id=" + payment_id +"&payment_type_bd="+payment_type_bd+"&p_v_type=转&p_v_title=转账凭证";
        url = encodeURI(url);
        window.open(url, 'newwindow', s);
   }
}









function batchCreateVoucher(){
    var datacell = $id("datacell1");
    var dataset1 = datacell.dataset;
    var ids = selectIds();
    var bus_ids = new Array(0);//薪资批次id
        if(ids == null || ids == '') {
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
        
       var str="";
       for(var i=0;i<ids.length;i++){
	            var datasettr1 = dataset1.findEntity("id",ids[i]);
	            var audit_status = datasettr1.getValue("audit_status");
                var receiver_name = datasettr1.getValue("receiver_name");
                var payment_type_bd = datasettr1.getValue("payment_type_bd");
                var bus_id = datasettr1.getValue("bus_id");
                
                if(payment_type_bd == 4 && bus_id != null && bus_id != ""){
                    bus_ids.push(bus_id);
                }
                
	            if(audit_status!=4){
			        str+=receiver_name+"<fmt:message key='alert_audit_status_tip'/>\n\n";
			    }
        }
        
		if(str!=""){
		  alert(str);
		  return;
		}
		
		//add by whj 2015-08-14 验证工资是否已发放
	    var isPay = "";
	    if(bus_ids.join(",") != ""){
	        jQuery.ajax({
	           url: "<%=request.getContextPath()%>/SalarybatchAction.do?cmd=checkIsPay&bus_id="+bus_ids.join(","),
	           type: 'GET',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	           success: function(text){
	                               if(text != "" && text != null){
	                                   isPay = text;
	                               }
	                           }
	        });  
	        
	        if(isPay != "" ){
	            alert(isPay);
	            return false;
	        }
	    }
    
    window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateVoucherFin&payment_ids='+ids+'&buztype=0','','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
    /*jQuery.getJSON("/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateVoucherFin&payment_ids=" + ids +"&buztype=0",{},   function(json){
    	if(json.lists!=null&&json.lists!="")
        {        
        	showListData();
           	window.open(encodeURI('<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finbill/infoPage.jsp?info='+json.lists),'', 'height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
        }
	});*/
    /*
    var payment_ids =ids;
            var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateVoucherFin&payment_ids=" + payment_ids +"&buztype=0";
        turl = encodeURI(turl);
   jQuery.ajax({
               url: turl,
               type: 'GET',
               dataType: 'html',
               timeout: 10000,
               error: function(){ 
                   alert( text);
                       return  null;
                   },
               success: function(text){
                       alert(text);
                       $id("datacell1").reload();
               }
           });
           */  
}


    function selectIds() {
        var myids = new Array(0);
        var dc = $id("datacell1");
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
        var dc1 = $id("datacell1").dataset;
        var values = dc1.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }
    
    
</script>

</fmt:bundle>