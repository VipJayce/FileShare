<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
       <div id="right">
    	<div class="ringht_x">
<div id="ccParent0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">PPS客户：</td>
			<td class="td_2">${bean.pps_cust_name}</td>
		</tr>
	</table>
</div>
<div style="padding: 8 5 8 8;">
    <r:datacell 
        id="datacell2"
       queryAction="/FAERP/Pps_erp_cust_relationAction.do?cmd=getERPCust&pps_cust_mapping_id=${bean.id}"
        width="98%"
        xpath="Pps_erp_cust_relationVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="" width="0px" align="center">
       </r:field>   
       <r:field fieldName="erp_cust_name" width="250px" label="ERP客户名称" >
       </r:field>
       <r:field fieldName="erp_cust_code" width="235px" label="ERP客户编号" >
       </r:field> 
       <r:field fieldName="is_pay_im_belong"  label="工资导入所属" width="130px" allowModify="false">
       <d:select dictTypeId="IS_PAY_IM_BELONG"/>
       </r:field> 
    </r:datacell>
</div>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>
</div>
	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
