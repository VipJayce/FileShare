<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.finance.receivable.MyUtils"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	   function cancel_onClick(){  //取消后返回列表页面
	       form.action="<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_template/listfin_invoice_template.jsp";
	       form.submit();
	   }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<div class="xz_title" style="padding-top: 10px">发票模板</div>
<div id="values_div2" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/Fin_invoice_template_itemAction.do?cmd=getListBySimpleQuery&fin_invoice_template_id=${param.id}&fin_subjects_name=view"
            paramFormId="datacell_formid" width="99%" height="250px"
            xpath="Fin_invoice_template_itemVo" readonly="true" pageSize="100">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="fin_subjects_name" label="财务开票名称" width="200px">
            </r:field>
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
