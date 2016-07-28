<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyfee.vo.EppartyfeeErrorVo" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>
<div id="right">
<form name="datacell_formid" method="post" action="<%=request.getContextPath()%>/EppartyactAction.do">

<div class="ring2ht_s">
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartyfeeAction.do?cmd=partyfeeerror"
        width="100%"
        height="320px"
        xpath="EppartyfeeErrorVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="party_comp_code" width="120px" label="党支部编号">
       </r:field>    
      <r:field fieldName="emp_name" width="120px" label="员工姓名">
       </r:field>    
      <r:field fieldName="end_month" width="120px" label="党费截止月">
      </r:field>
      <r:field fieldName="start_month" width="120px" label="党费起始月">
      </r:field>
      <r:field fieldName="in_money" width="120px" label="党费缴纳金额">
      </r:field>
      <r:field fieldName="don_money" width="120px" label="捐款金额">
      </r:field>
      <r:field fieldName="imp_date" width="120px" label="导入时间">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="err_desc" width="350px" label="错误信息">
      </r:field>
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
