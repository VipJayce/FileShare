<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.finance.billimport.finbillimpdatacountry.finbillimpdatacountry_resource" prefix="rayoo.finance.billimport.finbillimpdatacountry.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("id") + "');\">";
     }
    
    function ClickRow(value){
        document.getElementById("cid").value=value;
    }

    function showListData(){
       var bill_year_month = document.getElementById("bill_year_month1").value;
       if(bill_year_month != null || bill_year_month != ""){
            if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_tip_4'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_tip_5'/>");
               return;
           }
        }
        $id("celllist1").addParam("cust_id",_$("#cust_id").val());
        $id("celllist1").addParam("cost_id",$id("cost_center_id").getValue());
         $id("celllist1").loadData();
         $id("celllist1").refresh();
     }

    //导出
    function exportExcelForHistoryUploadData_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpbatchnAction.do?cmd=exportExcelForHistoryUploadData";
        _$("#cost_id").val($id("cost_center_id").getValue());
        $id("datacell_formid").submit();
    }
    function showWindow(){
         var id=document.getElementById("cid").value;
          var url="<%=request.getContextPath()%>/jsp/faerp/finance/billimport/finbillimpbatchn/detailFinbillimpbatchn.jsp?cid="+id;
          showModalCenter(url, window,"",900,410,"<fmt:message key='page_detailFinbillimpbatchn'/>");
    }
    
    //删除
    function delete_onClick(){
        var batch_id=jQuery("#cid").val();
        if(batch_id == null || batch_id == ""){
            alert("<fmt:message key='alert_select_one_delete'/>");
            return;
        }
        
        jQuery.getJSON("<%=request.getContextPath()%>/FinbillimpbatchnAction.do?cmd=deleteData&date="+new Date()+"",{"batch_id":batch_id},function(json){
             if(json.saia!=""){
                alert(json.saia);
             }else{
                alert("<fmt:message key='alert_delete_confirm'/>");
                $id("celllist1").loadData();
                $id("celllist1").refresh();
             }
         });
    }
    
     jQuery(function(){
        $id("celllist1").isQueryFirst = false;
    });
    //导出详细信息
      function exportExcelForHistory(){
        var id=document.getElementById("cid").value;
        if(id!=null&&id!=""){
        $id("datacell_formid").action="<%=request.getContextPath()%>/FinbillimpbatchnAction.do?cmd=exportExcelForHistory&cid="+id;
        $id("datacell_formid").submit();
        }else{
        alert("<fmt:message key='alert_select_one_import'/>");
        }
    }
    
    //保存
    function toUpdate_onclick(){
        $id("celllist1").submit();//提交       
    }
    
    //选择客户的返回方法
    function rtnFuncCustomer(arg){
        var lookup = $id("customer_id");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        _$("#cust_id").val(arg[0]);
        $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    
    function detailItem(){
         var id=document.getElementById("cid").value;
         if(id == null || id == ""){
            alert("请勾选一条记录！")
            return false;;
         }
          var url="<%=request.getContextPath()%>/FinbillimpbatchnAction.do?cmd=toQueryExpressBillItemPage&cId="+id;
          showModalCenter(url, null,"",900,410,"全国导入明细");
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
 <div id="right">
<div class="ringht_s">
 <input type="hidden" id="cid" name="cid"/>
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='batch_id'/></td>
            <td align="left">
               <input type="text" class="text_field" name="bill_imp_batch_id1" id="bill_imp_batch_id1" inputName="批次号" maxLength="64" style="width:215"/>            </td>
            <td align="right"><fmt:message key='create_date'/></td>
            <td align="left"><w:date format="yyyy-MM-dd" name="create_date_from" width="80px"/>&nbsp;<fmt:message key='to'/>&nbsp;<w:date format="yyyy-MM-dd" name="create_date_to" width="80px"/></td>
            <td align="right"><fmt:message key='create_user'/></td>
            <td align="left">
                <input type="text" class="text_field" name="create_user_name1" id="create_user_name1" inputName="操作人" maxLength="64" style="width:215"/>            </td>
        </tr>
        <tr>
            <td align="right"><font color="red">* </font><fmt:message key='bill_year_month'/></td>
            <td align="left">
                <input type="text" class="text_field" name="bill_year_month1" id="bill_year_month1" inputName="账单年月" maxLength="6" style="width:215" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
            <td><fmt:message key='batch_name'/></td>
            <td><input type="text" class="text_field" name="batch_name" id="batch_name" inputName="导入批次名称" style="width:215"/></td>
            <td>收费属性</td>
           <td><d:select id="bill_imp_type_db1" name="bill_imp_type_db1" dictTypeId="BILL_IMP_TYPE_BD" nullLabel="--请选择--" /></td>
        </tr>
        <tr>
             <td align="right">客户名称</td>
             <td align="left">    
             <w:lookup readonly="true" id="customer_id" name="customer_id"
                 onReturnFunc="rtnFuncCustomer"
                 lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                 messagekey="select_cust" height="500" width="600" style="width:200px;" />
             </td>
             <input type="hidden" id="cust_id" name="cust_id" value="">
             <input type="hidden" id="cost_id" name="cost_id" value="">
             <td align="right">成本中心</td>
             <td align="left">   
                     <r:comboSelect id="cost_center_id" name="cost_center_id"
                         queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                         textField="cost_center_name"
                         valueField="id"
                         xpath="CostcenterVo"
                         width="215px"
                         messagekey="please_select"
                         >
                     </r:comboSelect>
              </td>
        <td align="right">
               <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">&nbsp;&nbsp;
           </td>
           <td>   
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>

<input type="hidden" name="postid" id="postid" value="">
<div id="ccParent1" class="button"> 
     <div class="button_right">
        <!--<ul>
            <li class="e_3"><a onclick="javascript:exportExcelForHistoryUploadData_onClick();">导出</a></li>
            <li class="a"><a onclick="javascript:showWindow()">详细</a></li>
        </ul>
    -->
    <input type="button" class="e_3" value="<fmt:message key='button_exp_'/>" <au:authorityBtn code="qgxtzd_exp" type="1"/> onClick="exportExcelForHistoryUploadData_onClick();" />
    <input type="button" class="a" value="<fmt:message key='button_item'/>" <au:authorityBtn code="qgxtzd_item" type="1"/> onClick="showWindow();" />
     <input type="button" class="a_3" value="全国导入明细" <au:authorityBtn code="qgdr_item" type="1"/> onClick="detailItem();" />
    <input type="button" class="d" value="<fmt:message key='button_shanchu'/>" <au:authorityBtn code="qgxtzd_shanchu" type="1"/> onClick="delete_onClick()" />
    <input type="button" class="e_2" value="<fmt:message key='button_expdetail'/>" <au:authorityBtn code="qgxtzd_exp" type="1"/> onClick="exportExcelForHistory()" />
    <input class="bc" type="button" value="<fmt:message key='button_save'/>" onClick="toUpdate_onclick();">
    
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="celllist1"
        queryAction="/FAERP/FinbillimpbatchnAction.do?cmd=queryHistoryUploadData"
        submitAction="/FAERP/FinbillimpbatchnAction.do?cmd=updateBillImpBatchName"
        width="99%"
        height="305px" 
        xpath="FinbillimpbatchnVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
      <r:field fieldName="bill_imp_batch_id" messagekey="batch_id" width="170">
      </r:field>
      <r:field fieldName="batch_name" messagekey="batch_name_" width="350">
        <h:text/>
      </r:field>
      <r:field fieldName="cust_code" messagekey="cust_code" width="100">
      </r:field>
      <r:field fieldName="cust_name" label="客户名称" width="300">
      </r:field>
      <r:field fieldName="cost_center_name" label="成本中心" width="300">
      </r:field>
      <r:field fieldName="bill_imp_type_db" label="收费属性" width="70">
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" width="100">
        <w:date format="yyyy-MM-dd" name="" readOnly="true"/>
      </r:field>
      <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="80">
      </r:field>
      <r:field fieldName="succeed_num" messagekey="success_num" width="80">
      </r:field>
      <r:field fieldName="error_num" messagekey="error_num" width="80">
      </r:field>
      <r:field fieldName="create_user_name" messagekey="import_user" width="150">
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

