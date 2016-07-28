﻿<%@ page contentType="text/html; charset=UTF-8" %>
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

    //选择一条记录
    function setCheckboxStatus(value,entity,rowNo,cellNo){
              return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("invoice_amount") + "\",\"" + entity.getProperty("billid") + "\",\"" + entity.getProperty("cost_center_id") + "\");>";
     }
     
     function setCheckboxStatus1(value,entity,rowNo,cellNo){
              return "<input type='radio'  name='temp'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("invoice_amount") + "\",\"" + entity.getProperty("billid") + "\",\"" + entity.getProperty("cost_center_id") + "\");>";
     }

     function ClickRow(fin_invoice_id,invoice_amount,billid,cost_center_id){
          $id("billid").value = billid;
          $id("cost_center_id").value = cost_center_id;
          $id("fin_invoice_id").value = fin_invoice_id;
          //$id("invoice_amount").value = invoice_amount;
          jQuery("#invoice_amount1").val(invoice_amount);
          $id("celllist2").addParam("fin_invoice_id",fin_invoice_id);
          $id("celllist2").loadData();
          $id("celllist2").refresh();
     }
     
     function ClickRow1(fin_invoice_id,invoice_amount,billid,cost_center_id){
          $id("billid1").value = billid;
          $id("cost_center_id1").value = cost_center_id;
          $id("fin_invoice_id1").value = fin_invoice_id;
          //$id("invoice_amount1").value = invoice_amount;
          jQuery("#invoice_amount2").val(invoice_amount);
          $id("celllist4").addParam("fin_invoice_id",fin_invoice_id);
          $id("celllist4").loadData();
          $id("celllist4").refresh();
     }
     
     function reset_onClick(){
            $id("billid").value = "";
            $id("cost_center_id").value = "";
            $id("fin_invoice_id").value = "";
            $id("invoice_amount").value = "";
            
            $id("billid1").value = "";
            $id("cost_center_id1").value = "";
            $id("fin_invoice_id1").value = "";

            //alert("aa"+$id("fin_invoice_id").value );
            $id("celllist2").addParam("fin_invoice_id","");
            $id("celllist2").loadData();
            $id("celllist2").refresh();
            
            $id("celllist4").addParam("fin_invoice_id","");
            $id("celllist4").loadData();
            $id("celllist4").refresh();

     }

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
        //alert("len1"+len1);
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
<input id="fin_invoice_id" name="fin_invoice_id" type="hidden"  value="" />
<input id="billid" name="billid" type="hidden"  value="" />
<input id="cost_center_id" name="cost_center_id" type="hidden"  value="" />

<input id="fin_invoice_id1" name="fin_invoice_id1" type="hidden"  value="" />
<input id="billid1" name="billid1" type="hidden"  value="" />
<input id="cost_center_id1" name="cost_center_id1" type="hidden"  value="" />

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
                  <td class="td_1"><fmt:message key='bill_amount'/></td>
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
         <input name="button_reset2" class="foot_icon_2" type="button" value="<fmt:message key='reset'/>" onClick="javascript:this.form.reset();reset_onClick()">
      </div>
     </div>
    <div class="social_tab">
                <div id="bg" class="social_xixi1">
                  <div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'"><fmt:message key='xixi1'/></div>
                  <div id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'"><fmt:message key='xixi2'/></div>
              </div>
      <div id="TabCon1">
            <!--表格1-->
        <div style="width:50%; float:left; margin-left:10px; font-weight:bold; margin-top:10px;"><fmt:message key='xixi3'/></div>
        <div style="width:48%; float:right; margin-left:10px; font-weight:bold; margin-top:10px;"><fmt:message key='xixi4'/></div>
       <div id="values_div3" style="float:left; width:50%;height:200px; margin-top:5px;">
                        <r:datacell 
                            id="celllist1"
                            queryAction="/FAERP/FinbillAction.do?cmd=searchInvoiceData&billstatus=shishou"
                            paramFormId="datacell_formid" 
                            width="99%" height="250px" 
                            xpath="FininvoiceVo"
                            readonly="true"
                            pageSize="10"
                            >
                    
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="emp" label="选择" width="35px" onRefreshFunc="setCheckboxStatus" align="center">
                          </r:field>       
                          <r:field fieldName="cust_code" messagekey="cust_code" width="65px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" messagekey="cust_name" width="170px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="cost_center_name" messagekey="cost_center" width="170px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="invoice_amount" label="发票金额" width="100px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="user_name" label="申请人" width="80px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="create_date" label="申请时间" width="130px">
                                <w:date format="yyyy-MM-dd HH:mm:ss" />
                          </r:field>
                          <r:field fieldName="invoice_desc"  label="开票备注"  width="350px">
                            <h:text />
                          </r:field>
                        </r:datacell>
        </div>
            <!--表格1 end-->
        <div id="values_div4" style="float:right; width:48%;height:200px;margin-top:5px;">
                      <r:datacell 
                            id="celllist2"
                            queryAction="/FAERP/FinbillAction.do?cmd=searchBillDataByFinInvoiceID"
                            paramFormId="datacell_formid" 
                            width="100%" height="250px" 
                            xpath="FinbillVo"
                            readonly="true"
                            pageSize="100"
                            >
                    
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="cust_code" messagekey="cust_code" width="60px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" messagekey="cust_name" width="130px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cost_center_name" messagekey="cost_center" width="130px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="60px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_amount" messagekey="bill_amount" width="73px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="rate_odds" messagekey="rate_odds" width="70px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="rate_amount" messagekey="rate_amount" width="70px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="verification_amount" messagekey="ver_amount" width="100px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="90px">
                            <d:select dictTypeId="BILL_TYPE_BD" />
                          </r:field>
                        </r:datacell>
        </div>
        <div class="box_xinzeng" style="height:270px; overflow-y:hidden;">
      <div class="xz_title" style=" margin-top:10px;"><fmt:message key='make_out_an_invoice'/></div>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"><span class="style_required_red">*</span><fmt:message key='invoice_code1'/></td>
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
                    <div style="width:50%; float:left; margin-left:10px; font-weight:bold; margin-top:10px;"><fmt:message key='xixi3'/></div>
        <div style="width:48%; float:right; margin-left:10px; font-weight:bold; margin-top:10px;"><fmt:message key='xixi4'/></div>
       <div id="values_div3" style="float:left; width:50%;height:200px; margin-top:5px;">
                        <r:datacell 
                            id="celllist3"
                            queryAction="/FAERP/FinbillAction.do?cmd=searchInvoiceData"
                            paramFormId="datacell_formid" 
                            width="99%" height="250px" 
                            xpath="FininvoiceVo"
                            readonly="true"
                            pageSize="10"
                            >
                    
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="emp" label="选择" width="35px" onRefreshFunc="setCheckboxStatus1" align="center">
                          </r:field>       
                          <r:field fieldName="cust_code" messagekey="cust_code" width="65px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" messagekey="cust_name" width="170px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="cost_center_name" messagekey="cost_center" width="170px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="invoice_amount" label="发票金额" width="100px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="user_name" label="申请人" width="80px" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="create_date" label="申请时间" width="130px">
                                <w:date format="yyyy-MM-dd HH:mm:ss" />
                          </r:field>
                          <r:field fieldName="invoice_desc"  label="开票备注"  width="350px">
                            <h:text />
                          </r:field>
                        </r:datacell>
        </div>
            <!--表格1 end-->
        <div id="values_div4" style="float:right; width:48%;height:200px;margin-top:5px;">
                      <r:datacell 
                            id="celllist4"
                            queryAction="/FAERP/FinbillAction.do?cmd=searchBillDataByFinInvoiceID"
                            paramFormId="datacell_formid" 
                            width="100%" height="250px" 
                            xpath="FinbillVo"
                            readonly="true"
                            pageSize="100"
                            >
                    
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="cust_code" messagekey="cust_code" width="60px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" messagekey="cust_name" width="130px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cost_center_name" messagekey="cost_center" width="130px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="60px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_amount" messagekey="bill_amount" width="73px">
                            <h:text />
                          </r:field>
                          <r:field fieldName="rate_odds" messagekey="rate_odds" width="70px">
                          <h:text />
                          </r:field>
                          <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="90px">
                            <d:select dictTypeId="BILL_TYPE_BD" />
                          </r:field>
                        </r:datacell>
        </div>
            <!--表格1 end-->
      <div class="box_xinzeng" style="height:270px; overflow-y:hidden;">
      <div class="xz_title" style=" margin-top:10px;"><fmt:message key='make_out_an_invoice1'/></div>
      <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"><span class="style_required_red">*</span><fmt:message key='invoice_code1'/></td>
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
       var fin_invoice_id="";
       var billid="";
       var cost_center_ids="";
       if(checkboxname=="checkbox_template1"){
               fin_invoice_id=$id("fin_invoice_id").value;
               if(fin_invoice_id==""){
                    alert("请选择一条发票记录。");
                    return;
               }
               
               billid=$id("billid").value;
               cost_center_ids=$id("cost_center_id").value;
        }else if(checkboxname=="checkbox_template2"){
               fin_invoice_id=$id("fin_invoice_id1").value;
               if(fin_invoice_id==""){
                    alert("请选择一条发票记录。");
                    return;
               }
               billid=$id("billid1").value;
               cost_center_ids=$id("cost_center_id1").value;
        }
       
       
           //alert("cost_center_ids="+cost_center_ids);
           var url="<%=request.getContextPath()%>/FinverificationAction.do?cmd=getCustomer&fin_invoice_id="+fin_invoice_id+"&bill_id="+billid+"&cost_center_ids="+cost_center_ids+"&view=true";
           ///var url="<%=request.getContextPath()%>/jsp/faerp/finance/received/fininvoice/viewbillingdetails.jsp"; 
           url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
           var titlename=checkboxname=="checkbox_template1" ? "<fmt:message key='ykpmx'/>" : "<fmt:message key='ckykpmx'/>"
           //showModalCenter(url, window, "", 800, 460, titlename);  //增加子岗位
           var w=screen.width;
           var h = screen.height;
           var l = 0;
           var t = 0;
            
           var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
           s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
           window.open(url, 'newwindow1', s);
       }
       
       //提交开票审核
       function BillingAudit(checkboxname) {
       
       
       var fin_invoice_id="";
       var billid="";
       var cost_center_ids="";
       if(checkboxname=="checkbox_template1"){
               fin_invoice_id=$id("fin_invoice_id").value;
               billid=$id("billid").value;
               cost_center_ids=$id("cost_center_id").value;
        }else if(checkboxname=="checkbox_template2"){
               fin_invoice_id=$id("fin_invoice_id1").value;
               billid=$id("billid1").value;
               cost_center_ids=$id("cost_center_id1").value;
        }
        
        if(fin_invoice_id==""){
                    alert("请选择一条发票记录。");
                    return;
         }
       

                  if(checkboxname=="checkbox_template1"){
                            var invoice_code1 = jQuery("#invoice_code1").val();
                            var create_date1 = jQuery("#create_date1_input").val();
                            var invoice_amount1 = jQuery("#invoice_amount1").val();
                            var type_bd1=jQuery('input:radio[name="type_bd1"]:checked').val(); 
                            
                            if(invoice_code1==""){
                                    alert("发票号不能为空！");
                                     jQuery("#invoice_code1").focus();
                                    return;
                             }
                             
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
                             //$id('invoice_amount2').value=(bill_amount).toFixed(2);
                             var invoice_code2 = jQuery("#invoice_code2").val();
                            var create_date2 = jQuery("#create_date2_input").val();
                            var invoice_amount2 = jQuery("#invoice_amount2").val();
                            var type_bd2=jQuery('input:radio[name="type_bd2"]:checked').val(); 
                            
                            if(invoice_code2==""){
                                    alert("发票号不能为空！");
                                     jQuery("#invoice_code2").focus();
                                    return;
                             }
                             
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
                 var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=editDate&checkboxname="+checkboxname+"&"+param;
                 jQuery.post(url,function(data){
                   if(data){
                       if(checkboxname=="checkbox_template1"){
                            $id("celllist1").loadData();
                            $id("celllist1").refresh();
                            $id("celllist2").paramList = [];
                            $id("celllist2").loadData();
                            $id("celllist2").refresh();
                            //jQuery("#create_date1_input").val("");
                            jQuery("#invoice_amount1").val("");
                            //jQuery("#type_bd1").val("");
                            jQuery("#invoice_code1").val("");
                            jQuery("#inv_desc1").val("");
                       }else if(checkboxname=="checkbox_template2"){
                            $id("celllist3").loadData();
                            $id("celllist3").refresh();
                            $id("celllist4").paramList = [];
                            $id("celllist4").loadData();
                            $id("celllist4").refresh();
                            //jQuery("#create_date2_input").val("");
                            jQuery("#invoice_amount2").val("");
                            //jQuery("#type_bd2").val("");
                            jQuery("#invoice_code2").val("");
                            jQuery("#inv_desc2").val("");
                       }
                      
                   }
                   alert(data);
                   
                   $id("celllist2").loadData();
                   $id("celllist2").refresh();
                   $id("celllist4").loadData();
                   $id("celllist4").refresh();
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