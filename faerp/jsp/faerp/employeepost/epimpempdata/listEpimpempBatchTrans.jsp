<!-- HYL 批量转移明细 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.employeepost.epimpempdata.epimpempdata_resource" prefix="rayoo.employeepost.epimpempdata.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
 
    function Query_onClick(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
	
	
	function exp_onClick(){  //批量转移导出
		form.action="<%=request.getContextPath()%>/EpimpempdataAction.do";
		form.cmd.value = "ExportBatchTansfer";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post"   id="datacell_formid"  action="<%=request.getContextPath()%>/EpimpempdataAction.do">
<input type="hidden" name="cmd" value="ViewBatchTransfer">
 <input type="hidden" id="cmd1"   name="cmd1" value="queryAll">
 <input type="hidden"  id="action1"  name="action1" value="EpimpempdataAction.do">
 
 <%   
	String IMPORT_ID="";
	 String INTERFACE_TYPE="";
	 IMPORT_ID=(String)request.getAttribute("IMPORT_ID");
	 INTERFACE_TYPE=(String)request.getAttribute("INTERFACE_TYPE");
%>
<input  type="hidden"  name="IMPORT_ID" id="IMPORT_ID" value="<%=IMPORT_ID %>">
<input  type="hidden"  name="INTERFACE_TYPE" id="INTERFACE_TYPE" value="<%=INTERFACE_TYPE %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("批量转移明细",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:Query_onClick();">查询</a> </li>
					<li class="b">    	<a  onClick="javascript:exp_onClick();"><fmt:message key="export"/></a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpimpempdataAction.do?cmd=ViewBatchTransfer"
        width="99%"
        xpath="EmimpEmpMoveInfo"
        submitXpath="EmimpEmpMoveInfo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp_name" label="员工姓名" width="60px" >
       </r:field>           
       <r:field fieldName="emp_code" label="员工唯一号"  width="80px">
                  
       </r:field>    
      <r:field fieldName="send_id" width="100px"  label="委派单号">
      </r:field>
      <r:field fieldName="send_code" width="100px"  label="委派单名称">
      </r:field>
		<r:field fieldName="quo_id" label="报价单Id" width="80px"></r:field>
		<r:field fieldName="quo_code" label="报价名称" width="80px"></r:field>
		<r:field fieldName="new_send_id" label="新委派单ID" width="80px"></r:field>
		<r:field fieldName="new_send_code" label="委派名称" width="80px"></r:field>
		<r:field fieldName="emp_post_id" label="员工入离职Id" width="80px"></r:field>
		<r:field fieldName="customer_id" label="客户Id" width="80px"></r:field>
		<r:field fieldName="customer_name" label="客户名称" width="80px"></r:field>
		<r:field fieldName="cust_receive_id" label="接受单位Id" width="80px"></r:field>
		<r:field fieldName="effect_date" label="生效时间" width="80px">
			<w:date format="yyyy-MM-dd" />
		</r:field>
		<r:field fieldName="apply_on_post_date" label="入职时间">
			<w:date format="yyyy-MM-dd" />
		</r:field>
		<r:field fieldName="customer_code" label=" 客户编号" width="80px"></r:field>
		<r:field fieldName="is_or_not_WToW" label="是否外地转外地" width="80px"></r:field>
		<r:field fieldName="status" label="状态" width="120px"></r:field>
		<r:field fieldName="msg" label="消息" width="400px"></r:field>
	</r:datacell>
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>


