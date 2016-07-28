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
    basename="rayoo.finance.bill.billcenter.billcenter_resource_zh"
    prefix="rayoo.finance.bill.billcenter.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>账单批量下载</title>
    <script language="javascript">
    
    //账单批次查询
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //查询条件重置
    function resetQuery(){
        $id("batchName").value="";
    }
   
    //显示一般的链接
    function showLink(value,entity,rowNo,cellNo){
        var batch_generate_status = entity.getProperty("batch_generate_status");//计算结果
        var generateBillIBatchd = entity.getProperty("id");//批次id
        if(batch_generate_status == "2"){
            return "<a href='<%=request.getContextPath()%>/FinbillAction.do?cmd=downLoadBatchBill&generateBillId="+generateBillIBatchd+"'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>下载</a>";
        }
    }
    //显示账单计算日志
    function showResultLink(value,entity,rowNo,cellNo){
        var generateBillId = entity.getProperty("id");//批次id
        return "<a href='javascript:showGenerateLog(\""+ generateBillId +"\")'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>查看生成日志</a>";
    }
    function showGenerateLog(generateBillIBatchd){
        var obj = new Array();
        obj.push(generateBillIBatchd);
        showModalCenter("<%=request.getContextPath()%>/jsp/faerp/finance/bill/billothers/showGenerateBillLog.jsp?generateBillIBatchd="+generateBillIBatchd,obj,'','1000','400',"批量账单生成日志");
    }
</script>
    </head>
    <body>
    <form name="datacell_formid" method="post" id="datacell_formid">
    <div id="right"><script language="javascript">
        writeTableTopFesco("<fmt:message key='title_billdownload'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_s">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="132" rowspan="2" style="padding-top: 0;">
            <div class="search_title"><fmt:message key='billcenter_search' /></div>
            </td>
            <td width="85" />
            <td width="196" />
            <td width="85"></td>
            <td width="196"></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='bill_batch_name' /></td>
            <td align="left">  <input type="text" class="text_field" id="batchName" name="batchName" inputName="批次名称" value=""/> </td>
            <td colspan='2' align='right'><input name="button_ok2" class="icon_1" type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()"> 
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset();resetQuery()"></td>
        </tr>
    </table>
    </div>
    <div style="padding: 8 0 8 8;"><r:datacell id="datacell1" paramFormId="datacell_formid"
        queryAction="/FAERP/FinbillAction.do?cmd=searchLimitBatchList" width="99%" height="350px" xpath="FinbillGenerateBatchVo">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="batch_name" messagekey="batch_name"
            width="180" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="batch_generate_status" messagekey="batch_generate_status" width="180"  allowModify="false">
            <h:select name="list_status" property="batch_generate_status">
                <h:option value="1" label="计算中"></h:option>
                <h:option value="2" label="计算成功"></h:option>
                <h:option value="3" label="计算失败"></h:option>
            </h:select>
        </r:field>
        <r:field fieldName="bill_year_month" messagekey="billyearmonth" width="180" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="name" messagekey="create_user_id" width="180" allowModify="false">
            <h:text />
        </r:field>
        <r:field fieldName="create_date" messagekey="create_date" width="180" allowModify="false">
            <w:date format="yyyy-MM-dd HH:mm:ss" />
        </r:field>
        <r:field fieldName="batch_generate_status" messagekey="operation" width="130" allowModify="false" onRefreshFunc="showLink">
        </r:field>
        <r:field fieldName="id" messagekey="operation" width="120" allowModify="false" onRefreshFunc="showResultLink">
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
_$(document).ready(function() {
    //$id("datacell1").isQueryFirst = false;
});
</script>
