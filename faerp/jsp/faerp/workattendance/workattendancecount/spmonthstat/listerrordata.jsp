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
    <title>考勤计算</title>
<script type="text/javascript">
      function search_onclick() {
        $id("datacell").reload() ;
    }
    </script>
</head>
<body>
<form name="form" action="" id="datacell_formid" method="post"> 
<input id="period_id" name="period_id" type="hidden" value="<%=request.getParameter("period_id") %>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">考勤计算</div></div>
    <div class="ringht_s">
    <div style="padding: 5 0 8 8;">
       <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/SpmonthstaterrordataAction.do?cmd=queryAll"
        width="98%"
        height="318px"
        xpath="SpmonthstaterrordataVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="errorrow" label="错误行" width="150px">
            </r:field>
            <r:field fieldName="errorcell" label="错误列" width="150px">
            </r:field>
            <r:field fieldName="errormsg" label="错误信息" width="300px">
            </r:field>       
    </r:datacell>
</div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>

