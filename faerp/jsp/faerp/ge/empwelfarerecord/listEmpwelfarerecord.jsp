<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@page import="gap.authority.helper.LoginHelper"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="" prefix="">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
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
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    
    function export_submit(){
	        $id("datacell_formid").submit() ;
    }
    
     function queryall(){
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
    function resetstr(){
    	window.resetstr() ;
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
    
    
   
 //执行操作   
 function update_onClick(handle_type){
   var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        var errrow = 0 ;
        var errrow2 = 0 ;
        var errmsg = "" ;
        var document_type_new = null ;   //记录单据类型
        _$("input[type='checkbox']").each(function(i) {
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                var document_status = entity.getValue("document_status") ;
                var document_type = entity.getValue("document_type") ;
                if(handle_type == '1'){ //出当月
                 if(document_status !='1'){
                   errmsg="只有待确认的数据才能执行出当月操作！" ;
                   errrow++ ;
                 }
                }else if (handle_type == '2'){ //转下月
                 if(document_status !='1'){
                   errmsg="只有待确认的数据才能执行转下月操作！" ;
                   errrow++ ;
                 }
                }else if (handle_type == '3'){ //取消收费
                  if(document_status =='1'){
                   errmsg="待确认数据不能做取消操作！" ;
                   errrow++ ;
                  }
                  if (document_type_new != null&&document_type_new != document_type ){
                     errrow2++ ;
                  }else if (document_type_new == null){
                     document_type_new = document_type  ;
                  }
                }
                myids.push(entity.getValue("id"));
            }
        });
        if(errrow > 0 ){
          alert(errmsg) ;
          return false ;
        }
        if(errrow2 >0 ){
           alert("做取消操作时所选的数据中单据类型必须是一样，可以先把报入职类型先取消再做变更取消！") ;
           return false ;
        }
   if(myids == null || myids == '') {
        alert("请选择操作数据！");
        return  false ;
   }
  jQuery.ajax({
              url: '<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=update&ids='+myids+'&handle_type='+handle_type,
                                type: 'post',
                                dataType: 'html',
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                       alert(text);
                                       $id("celllist1").loadData();
                                       $id("celllist1").refresh();
                                    }
                                }
                                });
   
 }   
    
    
    function detail_onClick(){  //实现转到详细页面
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
	    _$("input[type='checkbox']").each(function(i) {
	            if (i != 0 && _$(this).attr("checked")) {
	                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	                var entity = dc.getEntity(row);
	                myids.push(entity.getValue("emp_post_id"));
	            }
	        });
	        if(myids == null || myids == '') {
		        alert("请选择操作数据！");
		        return  false ;
		    }else if (myids.length >1){
		    	alert("选择的数据多于一条！");
		        return  false ;
		    }
           var emp_post_id="";
           emp_post_id = myids  ;
                if(emp_post_id!=null&&emp_post_id!=""){
                    window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
                }else{
                    alert("请选择记录！");
                    return;
                }
    }
    
    function  exportExcel_onClick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=exportExcel";
        $id("datacell_formid").submit();
    }
    
</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" action="" method="post"> 
<input type="hidden" name="cmd" value="">
<input type="hidden" name="company_id" id="company_id" value="<%=LoginHelper.getLoginVo(request).getCompany_id()%>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">福利办理反馈</div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="right" style="width:80px">客户名称&nbsp;&nbsp;</td>
    <td align="left" >
     <div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
            id="customer_id" name="customer_id" property="customer_id"
            displayProperty="customer_name"
            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
            title="客户" height="450" width="610" style="width:100px"  /></div>
    </td>
    <td align="right" style="width:80px">客户编号&nbsp;&nbsp;</td>
    <td align="left"><input type="text" value="" class="sText" id="customer_code" name="customer_code" style="width:100px"/></td>
  	<td  align="right"  style="width:80px">成本中心&nbsp;&nbsp;</td>
  	<td  align="left" >
  	<r:comboSelect id="cost_center_id"
            name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
            width="100" messagekey="please_select">
        </r:comboSelect>
    </td>
    <td  align="right" style="width:80px">产品类别&nbsp;&nbsp;</td>
    <td  align="left" ><d:select dictTypeId="GE_PRODUCT_TYPE" id="product_type" name="product_type" style="width:100px" nullLabel="--请选择--"></d:select></td>
    <td  align="right" style="width:80px">单据状态&nbsp;&nbsp;</td>
    <td  align="left" ><d:select dictTypeId="DOCUMENT_STATUS" id="document_status" name="document_status" style="width:100px" nullLabel="--请选择--"></d:select></td>    
      <td align="right" style="width:80px">单据类型&nbsp;&nbsp;</td>
    <td  align="left" ><d:select dictTypeId="DOCUMENT_TYPE" id="document_type" name="document_type" style="width:100px" nullLabel="--请选择--"></d:select></td>
    </td>
       
   </tr>
   
  <tr>
			<td align="right" style="width: 80px">唯一号&nbsp;&nbsp;</td>
			<td align="left"><input type="text" value="" class="sText" id="emp_code" name="emp_code" style="width: 100px" /></td>
			<td align="right" style="width: 80px">员工姓名&nbsp;&nbsp;</td>
			<td align="left"><input type="text" value="" class="sText" id="emp_name" name="emp_name" style="width: 100px" /></td>
			<td align="right" style="width: 80px">客户方编号&nbsp;</td>
			<td align="left" colspan="2"><input type="text" value=""	class="sText" id="internal_code" name="internal_code" style="width: 180px"  /></td>
			<td align="right" style="width: 80px">证件号&nbsp;&nbsp;</td>
			<td align="left" colspan="2"><input type="text" value=""class="sText" id="id_card" name="id_card"  style="width: 180px" /></td>
			<td align="right" style="width: 80px">计账年月&nbsp;&nbsp;</td>
			<td align="left"><input type="text" value="" class="sText" id="account_bill_year_month" name="account_bill_year_month"  style="width: 100px" /></td>
		</tr>
  
  <tr>
  <td align=right style="width: 80px">运行确认时间</td>
    <td align="left" colspan="3"><w:date format="yyyy-MM-dd" name="create_date_start" id="create_date_start" width="100px"/>&nbsp;至&nbsp;<w:date format="yyyy-MM-dd" name="create_date_end" id="create_date_end" width="100px"/></td>
  
  	<td  align="right" style="width: 80px">客服确认时间</td>
  	<td  align="left" colspan="3"><w:date format="yyyy-MM-dd" name="confirm_date_start" id="confirm_date_start" width="100px"/>&nbsp;至&nbsp;<w:date format="yyyy-MM-dd" name="confirm_date_end" id="confirm_date_end" width="100px"/></td>
  <!--  
  	<td align="right">收费起始年月&nbsp;&nbsp;</td>
    <td align="left">
    <input type="text" value="" class="sText" id="start_date" name="start_date" />
    </td>
      -->
      <td></td>
  	<td align="right"><input type="button" class="icon_1" value="查询" onClick="queryall()"/></td>
  	<td>  <input name="button_reset2" class="icon_1" type="reset" value="重置" onclick="resetstr()" /></td>
    <td><input type="button" class="icon_1" value="导出" onClick="exportExcel_onClick()"/></td>
        
  </tr>

    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right" style="width: 99%;">
        <input class="a_2" type="button"   value="查看订单明细"    onClick="detail_onClick();">
        <input class="b_1" type="button"   value="出当月"    onClick="update_onClick('1');">
        <input class="b_1" type="button"   value="转下月"    onClick="update_onClick('2');">
        <input class="b_1" type="button"   value="取消收费"    onClick="update_onClick('3');">
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/EmpwelfarerecordAction.do?cmd=simpleQuery_old"
            paramFormId="datacell_formid" width="99%" height="318px"
            xpath="EmpwelfarerecordVo" readonly="true" pageSize="100" >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field allowModify="false" fieldName="chk"
                label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                 width="30px">
                <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
            </r:field>
            <r:field fieldName="document_status" label="状态" width="60px">
             <d:select dictTypeId="DOCUMENT_STATUS"></d:select>
            </r:field>
            <r:field fieldName="document_type"  label="类型" width="45px">
             <d:select dictTypeId="DOCUMENT_TYPE"></d:select>
            </r:field>
            <r:field fieldName="product_type" label="产品" width="45px">
            <d:select dictTypeId="GE_PRODUCT_TYPE"></d:select>
            </r:field>
            <r:field fieldName="emp_code" label="唯一号" width="60px">
            </r:field>
            <r:field fieldName="internal_code" label="客户方编号" width="70px">
            </r:field>
             <r:field fieldName="emp_name" label="姓名" width="45px">
            </r:field>
             <r:field fieldName="id_card" label="证件号" width="135px">
            </r:field>
             <r:field fieldName="cost_center_name" label="成本中心" width="120px">
            </r:field>
            <r:field fieldName="cust_name" label="客户名称" width="120px">
            </r:field>
            <r:field fieldName="cust_code" label="客户编号" width="80px">
            </r:field>
            <r:field fieldName="start_date" label="收费起始" width="60px">
            </r:field>
            <r:field fieldName="create_date" label="运行确认时间" width="85px">
             <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
            <r:field fieldName="confirm_date" label="客服确认时间" width="85px">
             <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
            <!--<r:field fieldName="operation_bill_year_month" label="操作账单年月" width="90px">
            </r:field>
            <r:field fieldName="confirm_bill_year_month" label="确认账单年月" width="90px">
            </r:field>
            --><r:field fieldName="account_bill_year_month" label="计账年月" width="60px">
            </r:field>
            <r:field fieldName="v_version"  label="版本" width="30px">
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
