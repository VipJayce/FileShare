<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.sales.customer.vo.*" %>
<%@ page import="rayoo.sales.customer.util.*" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>

<%
    String taskuid = null == request.getAttribute("taskuid") ? "0" : request.getAttribute("taskuid").toString();
%>

<%
    String done = (String) request.getParameter("done");
    System.out.println("done===:"+done);
    CustomerVo resultVo = (CustomerVo) request.getAttribute(ICustomerConstants.REQUEST_BEAN); //从request中取出vo, 赋值给resultVo
%>



<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>

<STYLE TYPE="text/css" MEDIA=screen>
.tree_node_onfocus{
  TEXT-DECORATION: none;
  background-color: highlight;
  color:white;
}

ul.rootNode{
    CURSOR: default; MARGIN-LEFT: 5px; MARGIN-RIGHT: 5px; MARGIN-TOP: 5px;padding-top:0px; padding-left:0px;
}
ul.baseNode{
    MARGIN-LEFT: 0px; MARGIN-RIGHT: 0px; MARGIN-TOP: 0px;MARGIN-BOTTOM: 0px;padding-top:0px; padding-left:0px;
}
LI {
    MARGIN-LEFT: 15px;LIST-STYLE: none; MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px; VERTICAL-ALIGN: middle;
}
</STYLE>

<script>
function backTask_onClick() { //返回到列表页面
    form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done="+<%=done %>;
    form.submit();
}

//审批操作
function appOperate_onClick(){        
    var message =addAppReason("<%=request.getContextPath()%>");
    if(message==null)return;
    //alert('审批操作'+message);
    //form.action="<venus:base/>/SalcontractAction.do?cmd=appOperate&message="+message[0]+"&taskuid=<%=taskuid%>";
  
    form.action="<venus:base/>/CustomerAction.do?message="+message[0]+"&_ts="+(new Date()).getTime();
    document.getElementById("cmd").value="appOperate";
    form.submit();
}

//驳回操作
function backOperate_onClick(){
    //驳回原因
    var message =addBackReason("<%=request.getContextPath()%>");
    if(message==null)return;
    var url="/FAERP/CustomerAction.do?date=" + new Date();
    form.action=url;
    document.getElementById("info_msg").value=message[0];
    document.getElementById("cmd").value="backOperate";
    form.submit();
    
}

//撤销操作
function cancelOperate_onClick(){
    //驳回原因
    var message =addBackReason("<%=request.getContextPath()%>");
    if(message==null)return;
    form.action="<venus:base/>/CustomerAction.do?message="+message[0];
    document.getElementById("cmd").value="backOperate";
    form.submit();
}
</script>
<html>
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
function cancel_onClick(){  //取消后返回列表页面
	form_treebasic.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=queryAll";
	form_treebasic.submit();
}

function getSupplierList(){
	var ids = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
	if(ids==undefined)return;
	document.form_treebasic.cust_a_id.value=ids[0];
	document.form_treebasic.cust_a_name.value=ids[2];
	document.form_treebasic.customer_code.value=ids[1];
}
   
function getSupplierList1(){
	var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
	if(ids==undefined)return;
	document.form_treebasic.agent_b_id.value=ids[0];
	document.form_treebasic.agent_b_name.value=ids[1];
}
    
    
</script>
</head>
<body >
<div id="right">
<div class="tab">

<form action="" name="form" id="form"><input type="hidden"
	value="" name="cmd" id="cmd"> <input type="hidden" value=""
	name="info_msg" id="info_msg"> <input type="hidden"
	value="<%=taskuid%>" name="taskuid" id="taskuid">

<table class="table_noFrame">
	<tr>
		<td><input name="button_back" class="button_ellipse"
			type="button" value="<fmt:message key="go_back"/>"
			onclick="javascript:backTask_onClick();"> <input
			name="button_app" class="button_ellipse" type="button"
			value="<fmt:message key="agree"/>"
			onclick="javascript:appOperate_onClick();"> <input
			name="button_back" class="button_ellipse" type="button"
			value="<fmt:message key="reject"/>"
			onclick="javascript:backOperate_onClick();"></td>
	</tr>
</table>
</form>
<div id="TabCon1">
  <div class="ringht_x">
      <div id="ccChild1"     class="box_xinzeng"> 
          <table  width="50%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
              <tr>
                  <td class="td_1" style="width: 20%;">客户名称</td>
                  <td class="td_2"  nowrap="nowrap">
                    <%=resultVo.getCustomer_name() %>
                  </td>
              </tr>
              <tr>
                  <td class="td_1" >客户编码</td>
                  <td class="td_2 " nowrap="nowrap">
                    <%=resultVo.getCustomer_code() %>
                  </td>
              </tr> 
              <tr>
                  <td class="td_1" >恢复撤户原因</td>
                  <td class="td_2 " nowrap="nowrap">
                    ${subreason }
                  </td>
              </tr>   
          </table>
      </div>     
</div>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>
</fmt:bundle>
</html>



