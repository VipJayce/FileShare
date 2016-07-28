<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
   String costid = request.getAttribute("costid")==null?"":request.getAttribute("costid").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>选择集团户账单</title>
    <script language="javascript">
    var _jQuery = window.jQuery, _$ = window.$;
    jQuery.noConflict();
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
         var returnStr = "";
	     returnStr =  "<input   type='checkbox' name='checkbox1'  id='" + entity.getProperty("id") + "'   value='" + entity.getProperty("id") + "'>";
	     return returnStr;
    }
    //获得选中的账单
    function selectIds1() {
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if ( _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                myids.push(entity.getValue("id"));
            }
        });
        //去重
        var dic = {};
        for (var i = myids.length; i--; ) {
            dic[myids[i]]=myids[i];
        }
        var r = [];
        for (var v in dic) {
            r.push(dic[v]);
        }
        return r;
    }
    
    
    function select_onClick(){
        /**entity=choose_row("celllist1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("receipt_title");
        returnAry[1] = entity.getProperty("customer_code");
        returnAry[2] = entity.getProperty("customer_name");
        returnAry[3] =entity.getProperty("contact_person");
        returnAry[4] =entity.getProperty("contact_address"); 
        returnAry[5] =entity.getProperty("zip_code");
        returnAry[6] =entity.getProperty("contact_tel1");
        window.returnValue = returnAry;
        window.close();**/
       var datacell = $id("celllist1");
       var dataset1 = datacell.dataset;
       var ids = selectIds1();
       var entityArray = new Array();
       if(ids == null || ids == '') {
             alert("请选择账单！");
             return;
       }
       for(var i=0;i<ids.length;i++){
             var entity = dataset1.findEntity("id",ids[i]);
             entityArray.push(entity);
       }
       window.returnValue = entityArray;
       window.close();
    }
    

    function simpleQuery_onClick(){  //简单的模糊查询
          $id("celllist1").addParam("customer_code",$id("customer_code").value);
          $id("celllist1").addParam("customer_name",$id("customer_name").value);
          $id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
          $id("celllist1").addParam("max",$id("max").value);
          $id("celllist1").addParam("min",$id("min").value);
          $id("celllist1").loadData();
          $id("celllist1").refresh();
    }
    
    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }

</script>
    </head>
    <body>
    
    <form name="form" method="post"  id="datacell_formid">
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="costid" id="costid" value="<%=costid %>">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="270" rowspan="3" style="padding-top: 0;">
          <div class="search_title">查询条件</div>            </td>
        </tr>
        <tr>
            <td align="left">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" name="customer_code" id="customer_code" inputName="员工编号" maxLength="25"/>            
            </td>
            <td align="left">账单年月</td>
            <td align="left">
                <input type="text" class="text_field" name="bill_year_month" id="bill_year_month" inputName="账单年月" maxLength="25" value="${bill_year_month}"/>            
            </td>
            <td rowspan="2" align="left"><input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
        </tr>
         <tr>
            <td align="left">客户名称</td>
            <td align="left">
                <input type="text" class="text_field" name="customer_name" id="customer_name" inputName="员工姓名" maxLength="50"/>            
            </td>
            <td align="left">账单金额</td>
            <td align="left">
                <input type="text" class="text_field_half" id="min" name="min"  maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  style="width: 93px"/>至<input type="text" class="text_field_half" maxLength="15"  onKeyUp="if(isNaN(value))execCommand('undo')" id="max" name="max" style="width: 93px"/>            
            </td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
                            <r:datacell 
                            queryAction="/FAERP/FinbillAction.do?cmd=queryForGroupBill&cust_id=${cust_id}"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="FinbillVo"
                            readonly="true"
                            >
	                        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	                        <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
				            <r:field fieldName="cust_code" label="客户编码" width="60px">
				            </r:field>
				            <r:field fieldName="cust_name" label="客户名称" width="160px">
				            </r:field>
				            <r:field fieldName="cost_center_name" label="成本中心名称" width="160px">
				            </r:field>
				            <r:field fieldName="bill_year_month" label="应收年月" width="80px">
				            </r:field>
				            <r:field fieldName="bill_amount" label="账单金额" width="80px">
				            </r:field>
				            <r:field fieldName="verification_amount" label="实收金额" width="80px">
				            </r:field>
				            <r:field fieldName="rate_odds" label="小额调整" width="80px">
				            </r:field>
				            <r:field fieldName="rate_amount" label="汇差" width="80px">
				            </r:field>
				            <r:field fieldName="invoice_code" label="发票号" width="100px">
				            </r:field>
				            <r:field fieldName="bill_gather_status_bd" label="实收状态" width="100px">
				                <d:select dictTypeId="GATHER_STATUS_BD" ></d:select>
				            </r:field>
				            <r:field fieldName="bill_invoice_status_bd" label="开票状态" width="100px">
				                <d:select dictTypeId="INVOICE_STATUS_BD" ></d:select>
				            </r:field>
				            <r:field fieldName="bill_type_bd" label="账单类型" width="100px">
				                <d:select dictTypeId="FB_BILL_TYPE_BD"></d:select>
				            </r:field>
				            <r:field fieldName="user_name" label="客服" width="80px">
				                <h:text />
				            </r:field>
				            <r:field fieldName="is_finance_invoice" label="是否需要开票" width="100px">
				                <d:select dictTypeId="TrueOrFalse"></d:select>
				            </r:field>
				            <r:field fieldName="open_invoice" label="开票类型" width="70px">
				                <d:select dictTypeId="OPEN_INVOICE"></d:select>
				            </r:field>
                        </r:datacell>
            </div>
    </form>


</body>
</fmt:bundle>
</html>
