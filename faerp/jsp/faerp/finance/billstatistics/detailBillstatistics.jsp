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
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%  //取出本条记录
    EmppostVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (EmppostVo)request.getAttribute("empPVo");  //从request中取出vo, 赋值给resultVo
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>成本中心明细</title>
</head>
<body>
 <form id="datacell1_formid" name="form" method="post" action="">
 </form>
<div id="right">
  <div class="ringht_s">
        <div style="padding: 8 0 8 8;" >
            <r:datacell 
                id="datacell1"
                paramFormId="datacell1_formid"
                queryAction="/FAERP/BillStatisticsAction.do?cmd=searchBilDetailData&bill_year_month=${bill_year_month}&type=${type}&user_id=${user_id}"
                width="99%"
                height="300px"
                xpath="BillStatisticsVo"
                readonly="true"
                >
                 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		         <r:field fieldName="user_id" label="客服ID" width="0px;"></r:field>
		         <r:field fieldName="user_name" label="客服名称" width="100px"></r:field>
		         <r:field fieldName="cost_center_name" label="成本中心名称"   width="200px"></r:field>
            </r:datacell>
         </div>  
  </div>
</div>
</body>
</html>
