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
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox' class='impCheck' >";
    }
  
  function queryall(){
      $id("celllist1").addParam("custCode",_$("#cust_code").val());
      $id("celllist1").addParam("custName",_$("#cust_name").val());
      $id("celllist1").addParam("billYearMonth",_$("#bill_year_month").val());
      $id("celllist1").loadData();
      $id("celllist1").refresh();
  }
    
  function download(flag){
    var myids = new Array(0);
    var service_date = new Array(0);
    var dc = $id("celllist1");
    _$(".impCheck:checkbox").each(function(i) {
        if ( _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            myids.push(entity.getValue("id"));
            service_date.push(entity.getValue("bill_year_month"))
        }
    });

    if (flag == 'o'){
	    if(myids == null || myids == '' || myids.length > 1) {
	       alert("只能选择一条反馈的数据！");
	       return  false;
	    }
    }else{
    	if(myids.length == 0) {
	       alert("请选择一条或多条数据！");
	       return  false;
	    }
    }
    
    window.open("<%=request.getContextPath()%>/ExportAdpAction.do?cmd=downLoad&adpId=" + myids.join(',')+"&service_date="+service_date.join(','));
  }
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<input type="hidden" name="cmd" value="">
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">福利反馈报表</div>
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
		<td class="td_1">
	   		<fmt:message key='bill_year_month'/>
	   	</td>
	    <td width="212">
	    	<input type="text" value="" class="sText" id="bill_year_month" name="billYearMonth" />
	    </td>
	    <td align="left">客户名称</td>
	    <td align="left">
			<input type="text" value="" class="sText" id="cust_name" name="custName"/>
	    </td>
	    <td align="left">客户编号</td>
	    <td>
	        <input type="text" value="" class="sText" id="cust_code" name="custCode"/>
	    </td>
	</tr>
 <tr>
    <td align="center" colspan="6">
        <input type="button" class="icon_1" value="<fmt:message key='button_query'/>" onClick="queryall()"/>
        <input name="button_reset2" class="icon_1" type="reset" value="<fmt:message key='button_reset'/>" onclick="resetstr()" />
    </td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div style="padding-top: 5px; padding-right: 0px; padding-bottom: 0px; padding-left: 8px;">
      	<input name="download_btn" class="icon_3" id="download_btn" onclick="download('o');" type="button" value="下载福利反馈"/>
      	<input name="mergeDownload_btn" class="icon_3" id="mergeDownload_btn" onclick="download('m');" type="button" value="合并下载"/>
      </div>
      <div class="clear"></div>
    </div>
	<div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
		<r:datacell id="celllist1"
            queryAction="/FAERP/ExportAdpAction.do?cmd=simpleQuery"
            paramFormId="datacell_formid" width="99%" height="318px"
            xpath="FinbillVo" readonly="true" pageSize="10">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field allowModify="false" fieldName="chk" label="" sortAt="none" width="30px" onRefreshFunc="setCheckboxStatus">
            </r:field>
            <r:field fieldName="cust_code" messagekey="customer_code" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="cust_name" messagekey="customer_name" width="250px">
                <h:text />
            </r:field>
            <r:field fieldName="cost_center_name" messagekey="cost_center" width="250px">
                <h:text />
            </r:field>
            <r:field fieldName="bill_code" messagekey="bill_code" width="250px">
                <h:text />
            </r:field>
            <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="70px">
                <h:text />
            </r:field>
            <r:field fieldName="create_date" messagekey="create_date" width="250px">
                <w:date format="yyyy-MM-dd HH:mm:ss"/>
            </r:field>
        </r:datacell>
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