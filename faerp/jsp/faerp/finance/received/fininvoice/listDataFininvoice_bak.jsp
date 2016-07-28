<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.finance.received.fininvoice.fininvoice_resource" prefix="rayoo.finance.received.fininvoice.">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><fmt:message key='title_datefininvoice'/></title>

<script type="text/javascript">

		function rtnFuncCustomer(arg){
		    var lookup = $id("cust_id");
		    lookup.value = arg[2];
		    lookup.displayValue = arg[2];
		    var datacell = $id("cellcust");
            var row = datacell.getActiveRow();
            var entity = datacell.getEntity(row);
            entity.setProperty("cust_id",arg[0]);
            entity.setProperty("cust_name",arg[2]);
            datacell.refreshRow(row);
		    return false;
		}
/*
	//选择一条记录
    function setCheckboxStatus(value,entity,rowNo,cellNo){
		      return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";//city_idList
	 }

     function ClickRow(value){
          alert("id="+value);
     }
*/
    function simpleQuery_onClick(){  
	    jQuery("#invoice_amount1").val("");
	    jQuery("#invoice_amount2").val("");
	    $id("celllist1").paramList = [];
	    $id("celllist2").paramList = [];
	    $id("celllist3").paramList = [];
        //$id("cellcust").loadData();
        //$id("cellcust").refresh();
        //查询
        var dataset1 = $id("cellcust").dataset;
        var len1 = dataset1.getLength();
        for(var i =0 ; i < len1 ; i++){
            var cust_id = dataset1.get(i).getProperty("cust_id");
            var cost_center_id=dataset1.get(i).getProperty("cost_center_id");
             $id("celllist1").addParam("cust_id",cust_id);
             $id("celllist1").addParam("cost_center_id",cost_center_id);
             $id("celllist3").addParam("cust_id",cust_id);
             $id("celllist3").addParam("cost_center_id",cost_center_id);
        }
        $id("celllist1").addParam("cust_name",$id("cust_name").value);
        $id("celllist1").addParam("cust_detp",$id("cust_dept").getValue());
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        $id("celllist2").loadData();
        $id("celllist2").refresh();
        
        $id("celllist3").addParam("cust_name",$id("cust_name").value);
        $id("celllist3").addParam("cust_detp",$id("cust_dept").getValue());
        $id("celllist3").loadData();
        $id("celllist3").refresh();
    }
    
    
     function setCheckboxStatus1(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input cost_center_id='" + entity.getProperty("cost_center_id")  + "'  bill_amount='" + entity.getProperty("bill_amount")  + "'  type='checkbox' onclick='changeCheck1(" + rowNo + ",this);'  name='checkbox_template1'  id=id" + entity.getProperty("id") + " cust_code=" + entity.getProperty("cust_code") + "   value=" + entity.getProperty("id") + ">";
       return returnStr;
    }
    
      function setCheckboxStatus2(value,entity,rowNo,cellNo){
       return "<input type='checkbox' cost_center_id='" + entity.getProperty("cost_center_id")  + "' bill_amount='" + entity.getProperty("bill_amount")  + "' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox_template2' cust_code=" + entity.getProperty("cust_code") + "  value=" + entity.getProperty("id") + ">";
    }
    
    function changeCheck(rowNo,checkB){
        //alert(checkB.value + "" + rowNo);
           var bill_amount=0.0;
           var element = document.getElementsByTagName("input");
           for(var i=0;i<element.length;i++){
               if(element[i].type=="checkbox" && element[i].name=="checkbox_template2") {
                   if(element[i].checked){
                        if(element[i].getAttribute("cust_code")!="合计"){
                            bill_amount+=parseFloat(element[i].getAttribute("bill_amount"));
                        }
                   }
               }   
           }
           jQuery("#invoice_amount2").val(bill_amount.toFixed(2));
    }
    
        function changeCheck1(rowNo,checkB){
            var temp="";
            var bill_amount=0.0;
	         if($id("id"+checkB.value).checked){
	                //alert($id("id"+checkB.value).getAttribute("bill_amount"));
	                $id("celllist2").paramList = [];
	                $id("isClickQuery").value="true";
			        $id("celllist2").addParam("BILL_ID",checkB.value);
			        $id("celllist2").addParam("inc_date_from",$id("inc_date_from").value);
			        $id("celllist2").addParam("inc_date_to",$id("inc_date_to").value);
			        $id("celllist2").addParam("inc_amout_from",$id("inc_amout_from").value);
			        $id("celllist2").addParam("inc_amout_to",$id("inc_amout_to").value);
			        //查询
			        var dataset1 = $id("cellcust").dataset;
			        var len1 = dataset1.getLength();
			        for(var i =0 ; i < len1 ; i++){
			            var cust_id = dataset1.get(i).getProperty("cust_id");
			            var cost_center_id=dataset1.get(i).getProperty("cost_center_id");
			             $id("celllist2").addParam("cust_id",cust_id);
			             $id("celllist2").addParam("cost_center_id",cost_center_id);
			        }
			        $id("celllist2").addParam("cust_name",$id("cust_name").value);
			        $id("celllist2").addParam("cust_detp",$id("cust_dept").getValue());
			        $id("celllist2").loadData();
			        $id("celllist2").refresh();
	         }else{
	                 var element = document.getElementsByTagName("input");
			        for(var i=0;i<element.length;i++){
			            if(element[i].type=="checkbox" && element[i].name=="checkbox_template1") {
			                if(element[i].checked){
					                if(element[i].getAttribute("cust_code")!="合计"){
		                            temp=element[i].value+"";
                                    break;
		                            }
			                }
			            }
			        } 
			        //$id("isClickQuery").value="true";
                    //$id("celllist2").addParam("BILL_ID",temp);
                    //$id("celllist2").loadData();
                    //$id("celllist2").refresh();
                    $id("celllist2").paramList = [];
                    $id("isClickQuery").value="true";
                    $id("celllist2").addParam("BILL_ID",temp);
                    $id("celllist2").addParam("inc_date_from",$id("inc_date_from").value);
                    $id("celllist2").addParam("inc_date_to",$id("inc_date_to").value);
                    $id("celllist2").addParam("inc_amout_from",$id("inc_amout_from").value);
                    $id("celllist2").addParam("inc_amout_to",$id("inc_amout_to").value);
                    //查询
                    var dataset1 = $id("cellcust").dataset;
                    var len1 = dataset1.getLength();
                    for(var i =0 ; i < len1 ; i++){
                        var cust_id = dataset1.get(i).getProperty("cust_id");
                        var cost_center_id=dataset1.get(i).getProperty("cost_center_id");
                         $id("celllist2").addParam("cust_id",cust_id);
                         $id("celllist2").addParam("cost_center_id",cost_center_id);
                    }
                    $id("celllist2").addParam("cust_name",$id("cust_name").value);
                    $id("celllist2").addParam("cust_detp",$id("cust_dept").getValue());
                    $id("celllist2").loadData();
                    $id("celllist2").refresh();                  
	         }
	         
			       var element = document.getElementsByTagName("input");
		            for(var i=0;i<element.length;i++){
		                if(element[i].type=="checkbox" && element[i].name=="checkbox_template1") {
		                    if(element[i].checked){
		                            if(element[i].getAttribute("cust_code")!="合计"){
                                    bill_amount+=parseFloat(element[i].getAttribute("bill_amount"));
                                    }
		                    }
		                }   
		            }
		             jQuery("#invoice_amount1").val(bill_amount.toFixed(2));
        }
    
    function checkAllList1(){
    var bill_amount=0.0;
    var temp="";
        var element = document.getElementsByTagName("input");
        for(var i=0;i<element.length;i++){
            if(element[i].type=="checkbox" && element[i].name=="checkbox_template1") {
                element[i].checked= !element[i].checked ? true : false;
		                if(element[i].checked){
		                            if(element[i].getAttribute("cust_code")!="合计"){
                                            bill_amount+=parseFloat(element[i].getAttribute("bill_amount"));
                                    }
		                }
            }
        } 
        
        jQuery("#invoice_amount1").val(bill_amount.toFixed(2));
        
         var element = document.getElementsByTagName("input");
                    for(var i=0;i<element.length;i++){
                        if(element[i].type=="checkbox" && element[i].name=="checkbox_template1") {
                            if(element[i].checked){
                                    if(element[i].getAttribute("cust_code")!="合计"){
                                    temp=element[i].value+"";
                                    break;
                                    }
                            }

                        }
                    } 
                    $id("celllist2").paramList = [];
                    $id("isClickQuery").value="true";
                    $id("celllist2").addParam("BILL_ID",temp);
                    $id("celllist2").addParam("inc_date_from",$id("inc_date_from").value);
                    $id("celllist2").addParam("inc_date_to",$id("inc_date_to").value);
                    $id("celllist2").addParam("inc_amout_from",$id("inc_amout_from").value);
                    $id("celllist2").addParam("inc_amout_to",$id("inc_amout_to").value);
                    //查询
                    var dataset1 = $id("cellcust").dataset;
                    var len1 = dataset1.getLength();
                    for(var i =0 ; i < len1 ; i++){
                        var cust_id = dataset1.get(i).getProperty("cust_id");
                        var cost_center_id=dataset1.get(i).getProperty("cost_center_id");
                         $id("celllist2").addParam("cust_id",cust_id);
                         $id("celllist2").addParam("cost_center_id",cost_center_id);
                    }
                    $id("celllist2").addParam("cust_name",$id("cust_name").value);
                    $id("celllist2").addParam("cust_detp",$id("cust_dept").getValue());
                    $id("celllist2").loadData();
                    $id("celllist2").refresh();          
    }
    
        function checkAllList2(){
        var bill_amount=0.0;
        var element = document.getElementsByTagName("input");
        for(var i=0;i<element.length;i++){
            if(element[i].type=="checkbox" && element[i].name=="checkbox_template2") {
                element[i].checked= !element[i].checked ? true : false;
                        if(element[i].checked){
                                    if(element[i].getAttribute("cust_code")!="合计"){
                                            bill_amount+=parseFloat(element[i].getAttribute("bill_amount"));
                                    }
                        }
            }
        } 
        jQuery("#invoice_amount2").val(bill_amount.toFixed(2));
    }
    
		 //选择客服
		function rtnFuncCS(arg){
		    var lookup = $id("lk_cs");
		    lookup.value = arg[0];
		    lookup.displayValue = arg[1];
		    jQuery("#cust_name").val(arg[0]);        
		    return false;
		}
		
		function validateInvoiceCode11(vrt){
	      // alert(vrt.value);
	       //vrt.focus(); 
	       var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=checkInvoiceCode&invoice_code="+vrt.value;
	       jQuery.post(url,function(data){
		       if(data){
		       		
				   if(data == '1'){
						alert("<fmt:message key='alert_invoiceCode_repeat'/>");
						vrt.focus();   
				   }
				}
			});
       }
       
       
           function validateInvoiceCode(vrt){
           var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=checkInvoiceCode&invoice_code="+vrt.value;
                                jQuery.ajax({
                                url: url,
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
                                           if(text == '1'){
						                        alert("<fmt:message key='alert_invoiceCode_repeat'/>");
						                        vrt.focus();   
						                   }
                                    }
                                }
                                });
}
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" id="cust_name" name="cust_name" />
<div id="right" style="height:440px;">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key='title_datefininvoice'/></div>
	</div>
    <div class="ringht_s">
	<div  style="height:210px; overflow-y:hidden;">
        
        <table width="100%" border="0">
		  <tr>
			<td width="703"><div style="font-weight:bold;padding:5 10 5 10px;"><fmt:message key='datefininvoice_search'/></div></td>
			<td width="380"></td>
		  </tr>
			<tr>
			<td>
			<div id="ccChild1" class="box_2"> 
		    <table width="99%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="float:left;width:96%;">
		        <tr>
		          <td width="21%" class="td_1"><fmt:message key='bill_year_month_from'/></td>
		          <td width="30%" class="td_2"><input name="bill_year_month_from" type="text" class="sText"/></td>
		          <td width="18%" class="td_1"><fmt:message key='bill_year_month_to'/></td>
		          <td width="31%" class="td_2"><input name="bill_year_month_to" type="text" class="sText"/></td>
		        </tr>
		        <tr>
		          <td class="td_1"><fmt:message key='inc_date_from'/></td>
		          <td class="td_2"><w:date format="yyyy-MM-dd" id="inc_date_from" name="inc_date_from" width="170px"/> </td>
		          <td class="td_1"><fmt:message key='inc_date_to'/></td>
		          <td class="td_2"><w:date format="yyyy-MM-dd" id="inc_date_to" name="inc_date_to" width="170px"/></td>
		        </tr>
		        <tr>
		          <td class="td_1"><fmt:message key='inc_amout_from'/></td>
		          <td class="td_2"><input id="inc_amout_from" name="inc_amout_from" type="text" class="sText"/></td>
		          <td class="td_1"><fmt:message key='inc_amout_to'/></td>
		          <td class="td_2"><input id="inc_amout_to" name="inc_amout_to" type="text" class="sText"/></td>
	          </tr>
		        <tr>
		          <td class="td_1"><fmt:message key='lk_cs'/></td>
		          <td class="td_2">
		          <!-- 
		          <select id="cust_name" name="cust_name" class="sSelect">
		            <option value="">请选择</option>
		            <option value="1099111500000000570">徐晶婧</option>
		            <option value="1099111500000000125">周承昊</option>
		            <option value="1099111500000000118">蔡璐</option>
		            </select>
		             -->
		            <w:lookup onReturnFunc="rtnFuncCS" style="width:170px" readonly="true" id="lk_cs" lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="select_cust_service" height="450" width="500"/>
		            </td>
		          <td class="td_1"><fmt:message key='cust_dept'/></td>
		          <td class="td_2">
		          <r:comboSelect id="cust_dept" name="cust_dept" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData"
                       textField="name" valueField="id" xpath="AupartyVO" width="180px" messagekey="please_select" />
		          </td>
	          </tr>
	        </table>
		    </div>
	      </td>
		    <td>
		            <r:datacell 
		                id="cellcust"
		                paramFormId="datacell_formid" 
		                queryAction=""
		                width="100%" height="130px" 
		                xpath="CustomersimpleVo">
		              <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
		              <r:field fieldName="cust_name" messagekey="select_cust" width="220px">
		              <w:lookup onReturnFunc="rtnFuncCustomer" readonly="false"
			                id="cust_id" name="cust_id"
			                lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
			                messagekey="select_cust" height="440" width="600"  style="width:170px"/>
		              </r:field>
		              <r:field fieldName="costcentername" messagekey="cost_center" width="230px">
                            <h:text />
		              </r:field>
		            </r:datacell>
		    
		    </td>
		  </tr>
	  </table>

	  <div class="foot_button">
	    <input type="button" class="foot_icon_2" value="<fmt:message key='query'/>" onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()"/>
	     <input name="button_reset2" class="foot_icon_2" type="button" value="<fmt:message key='reset'/>" onClick="javascript:this.form.reset();">
      </div>
	 </div>
	<div class="social_tab">
		    	<div id="bg" class="social_xixi1">
				  <div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'"><fmt:message key='xixi1'/></div>
				  <div id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'"><fmt:message key='xixi2'/></div>
			  </div>
   	  <div id="TabCon1">
        	<!--表格1-->
        <div style="width:60%; float:left; margin-left:10px; font-weight:bold; margin-top:10px;"><fmt:message key='xixi3'/></div>
        <div style="width:38%; float:right; margin-left:10px; font-weight:bold; margin-top:10px;"><fmt:message key='xixi4'/></div>
   	   <div id="values_div3" style="float:left; width:60%;height:200px; margin-top:5px;">
                        <r:datacell 
		                    id="celllist1"
		                    queryAction="/FAERP/FinbillAction.do?cmd=searchBillData&billstatus=shishou"
		                    paramFormId="datacell_formid" 
		                    width="100%" height="250px" 
		                    xpath="FinbillVo"
		                    readonly="true"
		                    pageSize="100"
		                    >
		            
		                  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList1(this);' />" width="40px" onRefreshFunc="setCheckboxStatus1">
						  </r:field> 
		                  <r:field fieldName="cust_code" messagekey="cust_code" width="80px">
		                    <h:text />
		                  </r:field>
		                  <r:field fieldName="cust_name" messagekey="cust_name" width="135px">
		                    <h:text />
		                  </r:field>
		                  <r:field fieldName="cost_center_name" messagekey="cost_center" width="135px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="60px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_amount" messagekey="bill_amount" width="73px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="90px">
                            <d:select dictTypeId="BILL_TYPE_BD" />
                          </r:field>
                          <r:field fieldName="user_name" messagekey="user_name" width="70px">
                          </r:field>
		                </r:datacell>
        </div>
            <!--表格1 end-->
        <div id="values_div4" style="float:right; width:38%;height:200px;margin-top:5px;">
		              <r:datacell 
		                    queryAction="/FAERP/FinverificationAction.do?cmd=searchIncomingFinverificationData"
                            id="celllist2"
                            paramFormId="datacell_formid" 
                            width="100%" height="250px" 
                            xpath="FinverificationVoAdd"
                            readonly="true"
                            pageSize="100"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="inc_code" messagekey="inc_code"  width="90px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="inc_date" messagekey="inc_date"  width="70px">
                            <w:date format="yyyy-MM-dd"/>
                          </r:field>
                          <r:field fieldName="inc_amout" messagekey="inc_amout"  width="70px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="create_date" messagekey="create_date" width="70px">
                             <w:date format="yyyy-MM-dd"/>
                          </r:field>
                          <r:field fieldName="ver_amount" messagekey="ver_amount" width="70px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="rate_odds" messagekey="rate_odds" width="70px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="rate_amount" messagekey="rate_amount" width="70px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="claim_desc" messagekey="claim_desc" width="1000px">
                          <h:text />
                          </r:field>
                        </r:datacell>
        </div>
        <div class="box_xinzeng" style="height:270px; overflow-y:hidden;">
	  <!--党员基本信息-->
	  <div class="xz_title" style=" margin-top:10px;"><fmt:message key='make_out_an_invoice'/></div>
	  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
	    <tr>
	      <td class="td_1"><fmt:message key='invoice_code1'/></td>
	      <td class="td_2"><input name="invoice_code1" type="text" class="sText" id="invoice_code1" onblur="validateInvoiceCode(this);"/></td>
        </tr>
	    <tr>
	      <td class="td_1"><span class="style_required_red">*</span><fmt:message key='create_date1'/></td>
	      <td class="td_2"><w:date format="yyyy-MM-dd" id="create_date1" name="create_date1" value="${requestScope.CurrentTimestamp}" width="170px"/></td>
        </tr>
	    <tr>
	      <td class="td_1"><span class="style_required_red">*</span><fmt:message key='invoice_amount'/></td>
	      <td class="td_2"><input name="invoice_amount1" type="text" class="sText" id="invoice_amount1" readonly="readonly"/></td>
        </tr>
	    <tr>
	      <td class="td_1"><span class="style_required_red">*</span><fmt:message key='type_bd'/></td>
	      <td class="td_2">
           <!--  <d:radio dictTypeId="INVOICE_TYPE_BD"  property="type_bd1" id="type_bd1" value="1"/>-->

	        <input name="type_bd1" type="radio" id="type_bd1" value="3" checked="checked">
	        <fmt:message key='type_bd_3'/>
	        <label for="radio">
	          <input type="radio" name="type_bd1"  value="2">
	        </label>
	        <fmt:message key='type_bd_2'/>
	        </td>
        </tr>
	    <tr>
	      <td class="td_1"><fmt:message key='inv_desc1'/></td>
	      <td class="td_2"><textarea name="inv_desc1" rows="3" class="xText_d" id="inv_desc1"></textarea></td>
        </tr>
      </table>
	  <div class="foot_button"><!-- viewbillingdetails    onClick="location.href='<%=request.getContextPath()%>/jsp/faerp/finance/received/fininvoice/viewbillingdetails.jsp'"  -->
	    <input type="button" class="foot_icon_2" value="<fmt:message key='ykpmx'/>" <au:authorityBtn code="kjfp_ykpmx" type="1"/> onClick="viewbillingdetails('checkbox_template1');"/>
	    <input type="button" class="foot_icon_2" value="<fmt:message key='savekp'/>" <au:authorityBtn code="kjfp_savekp" type="1"/> onClick="BillingAudit('checkbox_template1');"/>
      </div>
	  <!--党员基本信息 end-->
	  <!--党内信息-->
	  <!--党内信息 end--></div>
   	  </div>
<div id="TabCon2" style="display:none;">
        	<!--表格1-->
        	<div style="width:50%; margin-left:10px; font-weight:bold; margin-top:10px;margin-bottom:5px;"><fmt:message key='xixi2'/></div>
        	<div id="values_div" style="height:200px;">
        	          <r:datacell 
                            id="celllist3"
                            queryAction="/FAERP/FinbillAction.do?cmd=searchBillData&billstatus=weishishou"
                            paramFormId="datacell_formid" 
                            width="100%" height="250px" 
                            xpath="FinbillVo"
                            readonly="true"
                            pageSize="100"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList2(this);' />" width="40px" onRefreshFunc="setCheckboxStatus2">
                          </r:field>
                          <r:field fieldName="cust_code" messagekey="cust_code" width="100px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" messagekey="cust_code" width="250px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cost_center_name" messagekey="cost_center" width="250px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_amount" messagekey="bill_amount" width="100px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="130px">
                            <d:select dictTypeId="BILL_TYPE_BD" />
                          </r:field>
                        </r:datacell>
            </div>
        	<!--表格1 end-->
      <div class="box_xinzeng" style="height:270px; overflow-y:hidden;">
	  <div class="xz_title" style=" margin-top:10px;"><fmt:message key='make_out_an_invoice1'/></div>
	  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
	    <tr>
	      <td class="td_1"><fmt:message key='invoice_code1'/></td>
	      <td class="td_2"><input name="invoice_code2" type="text" class="sText" id="invoice_code2"  onblur="validateInvoiceCode(this);"/></td>
        </tr>
	    <tr>
	      <td class="td_1"><span class="style_required_red">*</span><fmt:message key='create_date1'/></td>
	      <td class="td_2"><w:date format="yyyy-MM-dd" id="create_date2" name="create_date2"  value="${requestScope.CurrentTimestamp}"  width="170px"/></td>
        </tr>
	    <tr>
	      <td class="td_1"><span class="style_required_red">*</span><fmt:message key='invoice_amount'/></td>
	      <td class="td_2"><input name="invoice_amount2" type="text" class="sText" id="invoice_amount2" readonly="readonly"/></td>
        </tr>
	    <tr>
	      <td class="td_1"><span class="style_required_red">*</span><fmt:message key='type_bd'/></td>
	      <td class="td_2">
                     <input name="type_bd2" type="radio"  value="3" >
            <fmt:message key='type_bd_3'/>
            <label for="radio">
              <input type="radio" name="type_bd2" id="type_bd2" value="2" checked="checked">
            </label>
            <fmt:message key='type_bd_2'/>
	        </td>
        </tr>
	    <tr>
	      <td class="td_1"><fmt:message key='inv_desc1'/></td>
	      <td class="td_2"><textarea name="inv_desc2" rows="3" class="xText_d" id="inv_desc2"></textarea></td>
        </tr>
      </table>
	  <div class="foot_button">
	    <input type="button" class="foot_icon_3" value="<fmt:message key='ckykpmx'/>" <au:authorityBtn code="kjfp_ckykpmx" type="1"/> onClick="viewbillingdetails('checkbox_template2');"/>
	    <input type="button" class="foot_icon_3" value="<fmt:message key='savekp'/>" <au:authorityBtn code="kjfp_tjkpsh" type="1"/> onClick="BillingAudit('checkbox_template2');"/>
      </div>
	  </div>
        </div>
        
    
    </div>
	
  </div></div>
  </form>
</body>
</html>
<script>

 var field = {
    entityField:"cost_center_id",
    fieldId:"cost_center_id_9999",
    fieldName:"cost_center_id",
    sort:"no",
    allowResize:true,
    label:"名称"
  };    
  var eos_orgEditor = null;
    //实现beforeEdit接口
    $id("cellcust").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var cust_id = entity.getProperty("cust_id");
        var orgEditor = null
        //alert(city_id);
        if (colIndex == 1){
            if (!$id("new_costcenter_List" + colIndex) || eos_orgEditor == null){
                //div container
                var divA = $createElement("div");
                divA.id = "cellcust"+"_"+"cost_center_id"+"_9999"+"_field_editor_container";
                //alert(divA.style);
                divA.style.width = "0px";
                divA.style.height = "0px";
                //divA.style.z-index = "999";
                divA.style.display = "none";
                var htmlString ="" ;
                htmlString += "<div id=\"new_costcenter_List1_container\"  class=\"eos-ic-container\" >";
                htmlString += "<input class=\"eos-combo-select-editor-text\" type=\"text\" id=\"new_costcenter_List1_input\" /><img id='new_costcenter_List1_button' class='eos-ic-button'  /><input type=\"hidden\" id=\"new_costcenter_List1_hidden\" name=\"new_costcenter_List1\" />";
                htmlString += "</div>";
                
                divA.innerHTML = htmlString;
                document.body.appendChild(divA);        
                eos_orgEditor =new ComboSelect('new_costcenter_List' + colIndex); 
                eos_orgEditor.queryAction = "FininvoiceAction.do?cmd=getCostCenterList"; 
                eos_orgEditor.xpath = "CostcenterVo"; 
                eos_orgEditor.valueField = "id"; 
                eos_orgEditor.textField = "cost_center_name"; 
                eos_orgEditor.isIeMode = false; 
                eos_orgEditor.readOnly = false; 
                eos_orgEditor.allowInput = false; 
                eos_orgEditor.allowFilter = true; 
                eos_orgEditor.disabled = false; 
                eos_orgEditor.nullText = "<fmt:message key='please_select'/>";
                eos_orgEditor.onPageLoad();
            }
            orgEditor = eos_orgEditor;
            var dc1 = $id("cellcust");
            this.activeField = field ? field : null;
            this.activeField.editor = orgEditor;
            this.activeEditor = this.activeField ? this.activeField.editor : null;
            orgEditor.paramList = null;
            orgEditor.addParam("custid",""+cust_id);
            orgEditor.init();
            orgEditor.loadData();
            orgEditor.refresh(); 
        }
       
        return true;
    }
    
    
    jQuery(function(){
	    $id("celllist1").isQueryFirst = false;
	    $id("celllist2").isQueryFirst = false;
	    $id("celllist3").isQueryFirst = false;
	});
    
 
   //实现on updateCell
    $id("cellcust").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("costcentername") >= 0){
            var orgEditor = eos_orgEditor;
            activeEntity.setProperty("costcentername", orgEditor.getDisplayValue(newValue));
        }
        return true;
    } 
   
       //预览开票明细
       function viewbillingdetails(checkboxname) {
           var billid="";
           var bill_amount=0.0;
           var cost_center_ids="";
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name==checkboxname) {
	                if(element[i].checked){
		                if(element[i].getAttribute("cust_code")!="合计"){
	                            cost_center_ids+=element[i].getAttribute("cost_center_id")+",";
		                        billid+=element[i].value+",";
		                        bill_amount+=parseFloat(element[i].getAttribute("bill_amount"));
	                    }

	                }
	            }   
	        }
	        
	       if(billid==""){
	           if(checkboxname=="checkbox_template1"){
	                    alert("<fmt:message key='checkbox_template1'/>");
                        return;
	           }else if(checkboxname=="checkbox_template2"){
                        alert("<fmt:message key='checkbox_template2'/>");
                        return;
               }
	       }
	       
          if(checkboxname=="checkbox_template1"){
                     $id('invoice_amount1').value=(bill_amount).toFixed(2);
           }else if(checkboxname=="checkbox_template2"){
                     $id('invoice_amount2').value=(bill_amount).toFixed(2);
           }
	       //alert("cost_center_ids="+cost_center_ids);
	       var url="<%=request.getContextPath()%>/FinverificationAction.do?cmd=getCustomer&billid="+billid+"&cost_center_ids="+cost_center_ids;
	       ///var url="<%=request.getContextPath()%>/jsp/faerp/finance/received/fininvoice/viewbillingdetails.jsp"; 
	       url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
	       var titlename=checkboxname=="checkbox_template1" ? "<fmt:message key='ykpmx'/>" : "<fmt:message key='ckykpmx'/>"
	       //showModalCenter(url, window, "", 800, 460, titlename);  //增加子岗位
           var w=screen.width-600;
           var h = screen.height-200;
           var l = (screen.width - w) / 2;
           var t = (screen.height - h) / 2;
           var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
           s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
           window.open(url, 'newwindow', s);
       }
       
       //提交开票审核
       function BillingAudit(checkboxname) {
           var billid="";
           var bill_amount=0.0;
           var cost_center_ids="";
            var element = document.getElementsByTagName("input");
            for(var i=0;i<element.length;i++){
                if(element[i].type=="checkbox" && element[i].name==checkboxname) {
                    if(element[i].checked){
	                      if(element[i].getAttribute("cust_code")!="合计"){
	                                cost_center_ids+=element[i].getAttribute("cost_center_id")+",";
	                                billid+=element[i].value+",";
	                                bill_amount+=parseFloat(element[i].getAttribute("bill_amount"));
	                        }
                    }
                }   
            }
            if(billid==""){
               if(checkboxname=="checkbox_template1"){
                       alert("<fmt:message key='alert_checkbox_template1'/>");
                       return;
               }else if(checkboxname=="checkbox_template2"){
                        alert("<fmt:message key='alert_checkbox_template2'/>");
                        return;
               }
           }
		          if(checkboxname=="checkbox_template1"){
		                    $id('invoice_amount1').value=(bill_amount).toFixed(2);
		                    var create_date1 = jQuery("#create_date1_input").val();
				            var invoice_amount1 = jQuery("#invoice_amount1").val();
				            var type_bd1=jQuery('input:radio[name="type_bd1"]:checked').val(); 
				            
				             if(create_date1==""){
				                    alert("<fmt:message key='alert_create_date1_input'/>");
				                     jQuery("#create_date1_input").focus();
				                    return;
				             }
				             if(invoice_amount1==""){
				                    alert("<fmt:message key='alert_invoice_amount1'/>");
				                     jQuery("#invoice_amount1").focus();
				                     return;
				             }
				            if(type_bd1==""){
				                    alert("<fmt:message key='alert_type_bd1'/>");
				                    jQuery("#type_bd1").attr("checked", "checked");
				                    return;
				             }else if(type_bd1=="2"){
                                    alert("<fmt:message key='alert_type_bd1_2'/>");
                                    jQuery("#type_bd1").attr("checked", "checked");
                                    return;        
                             }
		           }else if(checkboxname=="checkbox_template2"){
		                     $id('invoice_amount2').value=(bill_amount).toFixed(2);
		                    var create_date2 = jQuery("#create_date2_input").val();
		                    var invoice_amount2 = jQuery("#invoice_amount2").val();
		                    var type_bd2=jQuery('input:radio[name="type_bd2"]:checked').val(); 
		                     if(create_date2==""){
		                            alert("<fmt:message key='alert_create_date1_input'/>");
		                             jQuery("#create_date2_input").focus();
		                            return;
		                     }
		                     if(invoice_amount2==""){
		                            alert("<fmt:message key='alert_invoice_amount1'/>");
		                             jQuery("#invoice_amount2").focus();
		                             return;
		                     }
		                    if(type_bd2==""){
                                    alert("<fmt:message key='alert_type_bd1'/>");
                                    jQuery("#type_bd2").attr("checked", "checked");
                                    return;
                             }else if(type_bd2=="3"){
                                    alert("<fmt:message key='alert_type_bd1_3'/>");
                                     jQuery("#type_bd2").attr("checked", "checked");
                                    return;        
                             }
		           }
		         var param = jQuery("#datacell_formid").serialize();
		         var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=insert&checkboxname="+checkboxname+"&billid="+billid+"&cost_center_ids="+cost_center_ids+"&"+param;
                 jQuery.post(url,function(data){
			       if(data){
					   if(checkboxname=="checkbox_template1"){
		                    $id("celllist1").loadData();
                            $id("celllist1").refresh();
                            $id("celllist2").paramList = [];
                            $id("celllist2").loadData();
                            $id("celllist2").refresh();
                            jQuery("#create_date1_input").val("");
                            jQuery("#invoice_amount1").val("");
                            //jQuery("#type_bd1").val("");
                            jQuery("#invoice_code1").val("");
                            jQuery("#inv_desc1").val("");
		               }else if(checkboxname=="checkbox_template2"){
		                    $id("celllist3").loadData();
                            $id("celllist3").refresh();
                             jQuery("#create_date2_input").val("");
                            jQuery("#invoice_amount2").val("");
                            //jQuery("#type_bd2").val("");
                            jQuery("#invoice_code2").val("");
                            jQuery("#inv_desc2").val("");
		               }
			          
			       }
			       alert(data);
			    });
       }
       
       //从dataset中删除
       $id("cellcust").afterDel= function(row){
           var dc1 =  $id("cellcust");
           dc1.dataset.removeEntity(dc1.getEntity(row), true);
           return true;
       }
       
       

</script>
</fmt:bundle>