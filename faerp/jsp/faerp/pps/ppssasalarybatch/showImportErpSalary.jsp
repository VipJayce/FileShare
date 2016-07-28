<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看导入异常数据</title>
<script language="javascript">
    function import_onClick(){
        var erpBatchId = jQuery("#erpbatchId").val();
        var batchId = jQuery("#batchId").val();
        if (erpBatchId){
            url = "<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=importErpSalary" 
                + "&batchId=" + batchId;
    
            jQuery.post(url,function(msg){
                alert(msg);
                window.close();
            });
        }else{
            window.location.href="<%=request.getContextPath()%>/PpssasalarybatchAction.do?cmd=importErpSalarySubmitPage&ids=" + batchId;
        }
    }
    
    function export_onClick(){
        var batchId = jQuery("#batchId").val();
        $id("datacell_formid").action = "<%=request.getContextPath()%>/PpsSaDataErrAction.do?cmd=exportErrInfo&batchId=" + batchId;
        $id("datacell_formid").submit();
    }
</script>
</head>
<body>
    <form name="form" method="post" id="datacell_formid" >
        <input type="hidden" name="cmd" value="queryAll" /> 
        <input type="hidden"  name="backFlag" id="backFlag" value="true">
        <input type="hidden"  name="erpbatchId" id="erpbatchId" value="${batchVo.erp_batch_id }">
        
         <input  type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
  <div id="right"><script language="javascript">
    writeTableTopFesco('查看导入异常数据','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">

    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-left: 10px;">
        <tr>
          <td class="td_1" >PPS客户</td>
            <td class="td_2"  >
                <input type="hidden" id="batchId" value="${batchId }"/>
                <input type="text" name="cust_name" id="cust_name" value="${batchVo.cust_name}" readonly="readonly" style="width: 220px;"/>
            </td>
        <td align="left">PPS客户编号</td>
            <td align="left">
            <input type="text" name="cust_code" id="cust_code" value="${batchVo.cust_code}" style="width: 220px;"  readonly="readonly"/>
            </td>
        </tr>
    </table>
    </div>

    <div id="ccParent1" class="button">
    <div class="button_right">
        <input class="e" type="button" value="重新导入" onClick="import_onClick();">
        <input class="xz_1" type="button" value="导出异常信息" onClick="export_onClick();">
    </div>
    <div class="clear"></div>
    </div>

    <div style="padding: 8 10 8 8;">
	    <r:datacell id="datacell1"
	        queryAction="/FAERP/PpsSaDataErrAction.do?cmd=simpleQuery&batchId=${batchId }"
	        width="98%" height="318px" xpath="PpsSaDataErrVo"
	        paramFormId="datacell_formid" pageSize="99999">
	        <r:toolbar location="bottom" tools="nav,pagesize,info" />
	        <r:field fieldName="emp_name" label="员工姓名" width="60px"></r:field>
	        <r:field fieldName="emp_code" label="员工唯一号" width="60px"></r:field>
	        <r:field fieldName="id_card" label="身份证" width="150px"></r:field>
	        <r:field fieldName="import_time" label="导入时间" width="150px"></r:field>
	        <r:field fieldName="reasons" label="异常信息" width="130px"></r:field>
	        <r:field fieldName="remark" label="备注" width="330px"></r:field>
	    </r:datacell>
	</div>
    </div>
    </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>