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
	<title>账单手工修改审核</title>
	<script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodify.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco('账单修改审批','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div class="box_3">
   <div class="xz_title">账单手工修改审核</div>
   <table width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
     <tr>
       <td class="td_1">客户编号</td>
       <td class="td_2"><input type="text" value="" class="sText" name="cust_code"></td>
       <td class="td_1">客户名称</td>
       <td class="td_2"><input type="text" value="" class="sText" name="cust_name"></td>
     </tr>
   </table>
</div>
<div class="foot_button">
   <input type="button" id="searchApproval" value="查询" class="foot_icon_1">
</div>
<div class="button">
    <div class="button_right">
        <ul>
            <li class="h_2" onclick="list2approvalItem();"><a href="###">进入审核页面</a></li>
        </ul>
    </div>
    <div class="clear"></div>
</div>
<!-- BillmodifyVo -->
<div style="padding: 0 0 8 8;">
        <r:datacell 
        id="datacell3"
        paramFormId="datacell_formid"
        queryAction="/FAERP/BillmodifyAction.do?cmd=queryAll4App"
        width="98%"
        height="304px"
        xpath="FinbillVo"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="cust_code" label="客户编号" sortAt="server">
      </r:field>
      <r:field fieldName="cust_name" label="客户名称" width="190px" sortAt="server">
      </r:field>
      <r:field fieldName="cost_center_name" label="成本中心名称" width="205px">
      </r:field>
      <r:field fieldName="bill_year_month" label="应收年月">
      </r:field>
      <r:field fieldName="version" label="版本号">
      </r:field>
      <r:field fieldName="approve_bd" label="审批状态" allowModify="false">
        <d:select dictTypeId="APPROVE_BD"/>
      </r:field>
      <r:field fieldName="applyfortime" label="申请修改时间" allowModify="false">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="applyforusername" label="申请人">
      </r:field>
      <r:field fieldName="approvetime" label="审批时间">
      </r:field>
      <r:field fieldName="approveusername" label="审批人">
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
</script>
