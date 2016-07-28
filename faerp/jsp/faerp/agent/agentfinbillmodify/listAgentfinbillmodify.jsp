<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>账单修改</title>
    <script language="javascript" src="<venus:base/>/jsp/faerp/agent/agentfinbillmodify/billmodifypage.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco('账单修改','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="135" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div></td>
    <td width="100"> 账单年月</td>
    <td width="240"><input type="text" value="" class="sText" id="s_bill_year_month" name="s_bill_year_month"/></td>
    <td width="80"> 应收类型</td>
    <td width="240">
    <select name="s_bill_type_bd" class="sSelect" id="s_bill_type_bd">
      <option value="">请选择</option>
      <option value="1">社保福利+工资</option>
      <option value="2">仅含社保福利</option>
      <option value="3">仅含工资</option>
    </select></td>
        <td width="60"> 选择客户</td>
    <td width="200"> <w:lookup
                id="lk_cust"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                dialogTitle="选择客户" height="450" width="610" style="width:180px" readonly="true"/>
           <input type="hidden" name="cust_id" id="cust_id"></td>
  </tr>
  <tr>
    <td> 客户成本中心</td>
    <td>
    <r:comboSelect id="cost_center_id" name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name"
            valueField="id"
            xpath="CostcenterVo"
            width="203" nullText="--请选择--">
        </r:comboSelect></td>
    <td>申请修改时间</td>
    <td>
    <w:date allowInput="false" id="s_applyfortime" name="s_applyfortime" format="yyyy-MM-dd" style="width:85px;"/>
    <w:date allowInput="false" id="s_applyfortime2" name="s_applyfortime2" format="yyyy-MM-dd" style="width:85px;"/>
    </td>
        <td width="60">申请人</td>
    <td width="200"><input type="text" value="" class="sText" id="s_adjust_man" name="s_adjust_man"/></td>
        </tr>
  <tr>
    <td>审批时间</td>
    <td><w:date allowInput="false" id="s_approvetime" name="s_approvetime" format="yyyy-MM-dd" style="width:85px;"/>
    <w:date allowInput="false" id="s_approvetime2" name="s_approvetime2" format="yyyy-MM-dd" style="width:85px;"/>
      </td>
    <td>审批状态</td>
    <td><select name="s_approve_bd" class="sSelect" id="s_approve_bd" >
      <option value="">请选择</option>
      <option value="1">未修改</option>
      <option value="2">审批中</option>
      <option value="3">通过</option>
      <option value="4">驳回</option>
    </select></td>
    <td>&nbsp;</td>
    <td><input type="button" class="icon_1" value="查询" onclick="search_onclick();" />&nbsp;&nbsp;&nbsp;<input  class="icon_1"  type="reset" /> </td>
    </tr>
    </table>
</div>
<div class="button">
    <div class="button_right">
        <!--<ul>
            <li class="b_1"><a href="javascript:void(0);" onclick="list2item();">修改明细</a></li>
        </ul>
        -->
        <input class="b_1" type="button"   value="修改明细"    onClick="list2item();">
    </div>
    <div class="clear"></div>
</div>
<!-- BillmodifyVo -->
<div style="padding: 5 0 8 8;">
        <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/AgentfinbillAction.do?cmd=queryAllByModify"
        width="98%"
        height="318px"
        xpath="AgentfinbillVo"
        readonly="true"
        >
     <r:toolbar location="bottom" tools="nav,pagesize,info" />
     <r:field fieldName="agent_code" label="供应商编号" width="100px">
            </r:field>
            <r:field fieldName="agent_name" label="供应商名称" width="200px">
            </r:field>
            <r:field fieldName="cust_code" label="客户编号" width="100px">
            </r:field>
            <r:field fieldName="cust_name" label="客户名称" width="200px">
            </r:field>
            <r:field fieldName="bill_year_month" label="应收年月" width="100px">
            </r:field>  
            <r:field fieldName="version" label="版本号" width="100px">
            </r:field>              
            <r:field fieldName="approve_bd" label="修改审批状态" width="130px">
            <h:select property="approve_bd" disabled="true">
                         <h:option value="1" label="未修改"/>
                         <h:option value="2" label="审批中"/>
                         <h:option value="3" label="通过"/>
                         <h:option value="4" label="驳回"/>
              </h:select>
            </r:field>        
              <r:field fieldName="applyfortime" label="申请修改时间" width="130px">
              <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field>      
            <r:field fieldName="applyforusername" label="申请人" width="100px">
            </r:field>          
            <r:field fieldName="approvetime" label="审批时间" width="130px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field> 
            <r:field fieldName="approveusername" label="审批人" width="130px">
            </r:field>   
            <r:field fieldName="bill_type_bd" label="应收类型" width="130px">
             <h:select property="bill_type_bd" disabled="true">
                         <h:option value="1" label="社保福利+工资"/>
                         <h:option value="2" label="仅含社保福利"/>
                         <h:option value="3" label="仅含工资"/>
                         <h:option value="4" label="一次性收费"/>
              </h:select>
            </r:field>      
    </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script>
    if (${msg != null } && ${msg != "" }) {
        alert('${msg}');
    }

    
    window.setInterval("requestActionForSession()",600000);
    
    function requestActionForSession(){
         var _url = " <%=request.getContextPath() %>/FinbillAction.do?cmd=requestActionForSession&date=" +new Date();
               _$.ajax({
                    type : "post",
                    url : _url, 
                    dataType : "html" ,
                    success : function (data) {
                       
                    }
        });

}

    
_$(document).ready(function() {
        $id("datacell").isQueryFirst = false;
});

</script>
