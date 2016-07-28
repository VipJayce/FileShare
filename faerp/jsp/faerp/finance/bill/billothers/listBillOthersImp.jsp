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
    
     function rtnFuncCS(arg){
     var lookup = $id("lk_cs");
     lookup.value = arg[0];
     lookup.displayValue = arg[1];
     return false;
 }
 
    function setOthersImpCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox' class='othersImpCheck' >";
    }
  
  function queryall(){
      $id("celllist1").addParam("customer_id",_$("#select_cust_id").val());
      $id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
      $id("celllist1").addParam("cust_code",$id("cust_code").value);
      $id("celllist1").addParam("status",$id("status").value);
      $id("celllist1").loadData();
      $id("celllist1").refresh();
  }
    
  function download(){
    var myids = new Array(0);
    var dc = $id("celllist1");
    _$(".othersImpCheck:checkbox").each(function(i) {
        if ( _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            myids.push(entity.getValue("id"));
        }
    });
    
    if(myids == null || myids == '') {
       alert("请选择所要拆分的数据！");
       return  false ;
    }
    
    if (myids.length > 1){
    	alert("只能选择一条拆分的数据！");
       return  false ;
    }
    
    _$.ajax({ 
  		url: "<%=request.getContextPath()%>/BillOthersImpAction.do?cmd=checkOthersImpStatus", 
  		async: false,
  		data: {"impId":myids[0]},
  		type:'POST',
		ataType : "html",
  		success: function(rsStr){
  			if ("done" == rsStr){
			    window.open("<%=request.getContextPath()%>/BillOthersImpAction.do?cmd=downLoad&impId=" + myids[0]);
  			}else{
  				alert("已拆分的费用不可再次拆分！");
        	}
        }
    });
  }
  
  function upload(){
  	var myids = new Array(0);
    var dc = $id("celllist1");
    _$(".othersImpCheck:checkbox").each(function(i) {
        if ( _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            myids.push(entity.getValue("id"));
        }
    });
    
    if(myids == null || myids == '') {
       alert("请选择所要上传拆分的数据！");
       return  false ;
    }
    
    if (myids.length > 1){
    	alert("只能选择一条上传拆分的数据！");
       return  false ;
    }
    
     _$.ajax({ 
  		url: "<%=request.getContextPath()%>/BillOthersImpAction.do?cmd=checkOthersImpStatus", 
  		async: false,
  		data: {"impId":myids[0]},
  		type:'POST',
		ataType : "html",
  		success: function(rsStr){
  			if ("done" == rsStr){
			  	var url="<%=request.getContextPath()%>/BillOthersImpAction.do?cmd=uploadPage&impId=" + myids[0];
			  	window.open(url,'','height=200px,width=760px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=上传拆分数据');
  			}else{
  				alert("已拆分的费用不可再次拆分！");
        	}
        }
    });
  }
    
    function insertcallBack(){
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<input type="hidden" name="cmd" value="">
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">XP客户费用拆分</div>
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
   <td width="54"><fmt:message key='bill_year_month'/></td>
    <td width="212"><input type="text" value="" class="sText"
            id="bill_year_month" name="bill_year_month" /></td>
	</tr>
  	<tr>
    <td align="left">客户编号</td>
    <td>
        <input type="text" value="" class="sText" id="cust_code" name="cust_code"/>
    </td>
    <td align="left">状态</td>
	<td align="left">
		 <select name="status" id=status style="width: 190px;">
		   <option value="" selected="selected">--请选择--</option>
		   <option value="1">已拆分</option>
		   <option value="0" >未拆分</option>
		</select>
	</td>
    <td  align="right" colspan="2">
        <input type="button" class="icon_1" value="<fmt:message key='button_query'/>" onClick="queryall()"/>
        <input name="button_reset2" class="icon_1" type="reset" value="<fmt:message key='button_reset'/>" onclick="resetstr()" />
    </td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div style="padding-top: 5px; padding-right: 0px; padding-bottom: 0px; padding-left: 8px;">
      	<input name="download_btn" class="icon_3" id="download_btn" onclick="download();" type="button" value="下载拆分模板"/>
      	<input name="upload_btn" class="icon_3" id="upload_btn" onclick="upload();" type="button" value="上传拆分数据"/>
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/BillOthersImpAction.do?cmd=simpleQuery"
            paramFormId="datacell_formid" width="99%" height="318px"
            xpath="BillOthersImpVo" readonly="true" pageSize="10">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field allowModify="false" fieldName="chk" label="" sortAt="none" width="30px" onRefreshFunc="setOthersImpCheckboxStatus">
            </r:field>
            <r:field fieldName="cust_code" messagekey="customer_code" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="cust_name" messagekey="customer_name" width="250px">
                <h:text />
            </r:field>
            <r:field fieldName="city_name" label="城市" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="service_year_month" label="服务年月" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="amount" messagekey="bill_amount" width="90px">
                <h:text />
            </r:field>
            <r:field fieldName="charge_item_bd" messagekey="charge_item_bd" width="200px">
                <d:select dictTypeId="CHARGE_ITEM_BD" />
            </r:field>
            <r:field fieldName="create_date" messagekey="create_date" width="140px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
            <r:field fieldName="is_lock" label="状态" width="70px">
            	<d:select dictTypeId="ADP_SPLIT_STATUS" />
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

</script>