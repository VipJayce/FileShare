<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle
    basename="rayoo.finance.bill.billresponse.billresponse_resource_zh"
    prefix="rayoo.finance.bill.billresponse.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Datacell</title>
    <script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "@" + entity.getProperty("bill_type_bd") + "\");>";
    }
    
    //账单响应查询
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        $id("bill_id").value="";
    }
    
    //查询条件重置
    function resetQuery(){
        $id("cust_id").value="";
        $id("cost_center_id").value="";
    }
    
    //显示一般的链接
    function showLink(value,entity,rowNo,cellNo){
        var bill_status_bd = entity.getProperty("bill_status_bd");//计算结果
        if(value != '' && value !=null && bill_status_bd=='2'){
        	var customer_name = entity.getProperty("customer_name");//客户名称
        	var bill_year_month = entity.getProperty("bill_year_month");//计算结果
            return "<a href='<%=request.getContextPath()%>/FinbillAction.do?cmd=downLoadBill&excelName="+value+"&customer_name="+ customer_name +"&bill_year_month="+ bill_year_month +"'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>文件下载</a>";
        }
        
    }
    //显示重算链接
    function showRecalculationLink(value,entity,rowNo,cellNo){
        var bill_status_bd = entity.getProperty("bill_status_bd");//计算结果
        var billValid = entity.getProperty("billValid");//计算结果
        if(value != '' && value !=null && bill_status_bd=='2' && billValid=='1'){
            return "<a href='javascript:recalculaeBill_onClick(\""+ value +"\")'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>更换模版</a>";
        }
    }
    
    //账单重算
    function recalculaeBill_onClick (id){
        var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=recalculateBill";
        var myAjax = new Ajax(action);
        myAjax.addParam("id",id);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
               var flag = ""+myAjax.getProperty("returnValue");
               var msg = ""+myAjax.getProperty("returnMessage");
               alert(msg);
               if("true"==flag){
                   $id("datacell1").loadData();
                    $id("datacell1").refresh();
               }
         }
    }
</script>
    </head>
    <body>
    <form name="datacell_formid" method="post" id="datacell_formid">
    <div id="right"><script language="javascript">
        writeTableTopFesco("<fmt:message key='title_billresponse'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_s">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="132" rowspan="4" style="padding-top: 0;">
            <div class="search_title"><fmt:message
                key='billresponse_search' /></div>
            </td>
            <td width="85" />
            <td width="196" />
            <td width="143"></td>
            <td width="240" />
        </tr>
        <tr>
            <td align="right"><fmt:message key='customer_name' /></td>
            <td align="left"><w:lookup readonly="true" id="lk_cust"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                messagekey="choose_cust" height="450" width="610"
                style="width:180px" /> <input id="cust_id" name="cust_id"
                type="hidden" /></td>
            <td align="right"><fmt:message key='cost_center_decs' /></td>
            <td align="left"><r:comboSelect id="cost_center_id"
                name="cost_center_id"
                queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                textField="cost_center_name" valueField="id" xpath="CostcenterVo"
                width="190" messagekey="please_select"/></td>
            <td width="100" align="right"><fmt:message key='bill_type_bd' /></td>
            <td width="213" align="left"><select name="bill_type_bd">
                <option value="">==请选择==</option>
                <option value="1">社保福利+工资</option>
                <option value="2">仅含社保福利</option>
                <option value="3">仅含工资</option>
                <option value="4">仅一次性收费</option>
            </select></td>
        </tr>

        <tr>
            <td width="100" align="right"><fmt:message key='billyearmonth' /></td>
            <td align="left"><input type="text" class="text_field"
                id="billyearmonth" name="billyearmonth" inputName="账单年月"
                maxLength="50" value="" style="width: 180" /></td>
            <td width="100" align="right"><fmt:message key='create_user_id' /></td>
            <td align="left"><input type="text" id="create_user_name" name="create_user_name"
                class="text_field" value="" style="width: 180" /></td>
            <td colspan='4' align='right'><input name="button_ok2"
                class="icon_1" type="button"
                value='<fmt:message key="button_query"/>'
                onClick="javascript:showListData()"> <input
                name="button_reset2" class="icon_1" type="button"
                value='<fmt:message key="button_reset"/>'
                onClick="javascript:this.form.reset();resetQuery()"></td>
        </tr>
    </table>
    </div>

    <div style="padding: 8 0 8 8;"><r:datacell id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinbillAction.do?cmd=searchBillResponseLogData"
        width="99%" height="350px" xpath="FinBillResponseLog">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="cust_code" messagekey="cust_code" width="100"
            allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="customer_name" messagekey="customer_name"
            width="140" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="cost_center_code" messagekey="cost_center_code"
            width="100" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="cost_center_name" messagekey="cost_center_name"
            width="140" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="bill_year_month" messagekey="billyearmonth"
            width="70" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="version" messagekey="version"
            width="70" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="bill_type_bd" messagekey="bill_type_bd"
            allowModify="false">
            <d:select dictTypeId="BILL_TYPE_BD" />
        </r:field>
        <r:field fieldName="bill_status_bd" messagekey="bill_status_bd"
            allowModify="false">
            <h:select name="list_apply_state" property="bill_status_bd">
                <h:option value="1" label="计算中"></h:option>
                <h:option value="2" label="成功"></h:option>
                <h:option value="3" label="失败"></h:option>
            </h:select>
        </r:field>
        <r:field fieldName="bill_remark" messagekey="bill_remark" width="200"
            allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="excel_url" messagekey="excel_url"
            allowModify="false" onRefreshFunc="showLink">
        </r:field>
        <r:field fieldName="id" messagekey="excel_url"
            allowModify="false" onRefreshFunc="showRecalculationLink">
        </r:field>
        <r:field fieldName="billValid" messagekey="excel_url" width = '0'
            allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="create_user_name" messagekey="create_user_id"
            width="140" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="create_date" messagekey="create_date" width="140"
            allowModify="false">
            <w:date format="yyyy-MM-dd HH:mm:ss" />
        </r:field>
    </r:datacell></div>

    <div class="clear"></div>
    </div>
    </div>
    </form>
</fmt:bundle>
</body>
</html>
<script>
//客户查询
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    _$("#cust_id").val(returnValue[0]);
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}

_$(document).ready(function() {
    //$id("datacell1").isQueryFirst = false;
});
</script>
