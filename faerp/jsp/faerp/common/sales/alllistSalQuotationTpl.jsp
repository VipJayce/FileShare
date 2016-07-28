<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
  	
function choose() {
    entity = choose_row_public("datacell1");
    var returnAry = new Array();
    returnAry[0] = entity.getProperty("id");
    returnAry[1] = entity.getProperty("name");
    window.returnValue = returnAry;
    window.close();

}
function ClickRow(id, name) {
}
</script>
	</head>
	<body>

	<form name="datacell_formid" id="datacell_formid" method="post">
        <input type="hidden" name="tpl_status" id="tpl_status" value="1">
	<div id="right">
	<div class="ringht_s">


	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="g"><a onClick="javascript: choose();"><fmt:message
			key="choice" /> </a></li>

	</ul>

	</div>
	<div class="clear"></div>
	</div>
<!--<input type="hidden" id="contractid" name="contractid"/>-->

         <r:datacell id="datacell1" queryAction="/FAERP/Sal_quotation_tplAction.do?cmd=queryForDatacell" width="100%" height="385px" 
         xpath="Sal_quotation_tplVo" paramFormId="datacell_formid">
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
         <r:field fieldName="name" label="模版名称" width="250px" ></r:field>    
         <r:field fieldName="create_date" label="创建时间" width="200px" ></r:field>    
         <r:field fieldName="create_user_name" label="创建者" width="250px" ></r:field>    
         
         </r:datacell>
       
       

	</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	
	$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
        choose();
    }
</script>
</body>
</html>
