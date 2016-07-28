<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>


<title>查询模板</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="../../../js/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../../../js/ext/js/ext-all.js"></script>
<script type="text/javascript" src="../../../js/ext/js/ext-lang-zh_CN-GBK-min.js"></script>
<script type="text/javascript" src="../../../js/ext/js/dwrproxy.js"></script>
<script type="text/javascript" src="../../../js/dd/demo/orderlist.js"></script>
<script type="text/javascript" src="../../../js/dd/controldata/enumerate.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdddemo/interface/bookStoreService.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<link rel="stylesheet" type="text/css" href="../../../js/ext/resources/css/ext-all.css"/>
</head>
<body onload="javascript:refresh();">
<script language="javascript">
	writeTableTop('查看订单详细信息','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/BookStoreDemo.do?cmd=disposeOrder">
<div id="ccChild0"> 
	
		<table class="table_noframe">
			<tr>
				<td valign="middle">
					<input name="button_save" type="button" class="button_ellipse" value="确认" onclick='javascript:form.submit();' >
					<input name="button_cancel" type="button" class="button_ellipse" value="返回"  onClick="javascript:history.go(-1);">
				</td>
			</tr>
		</table>
<table class="table_div_content">
	<tr> 
		<td align="right" width="20%" nowrap>订单号:</td>
		<td align="left" id="orderId" name="id"><input type="hidden" name="orderId"></td>
	</tr>
	<tr> 
		<td align="right" width="20%" nowrap>收货人:</td>
		<td align="left" id="orderName">
		</td>
	</tr>
	<tr>
		<td align="right">地址:</td>
		<td align="left" id="orderAddr">
		</td>
	</tr>
	<tr>
		<td align="right">联系电话:</td>
		<td align="left" id="orderTel">
		</td>
	</tr>
	
	<tr>
		<td align="right">邮编:</td>
		<td align="left" id="orderPostcode">
		</td>
	</tr>
	<tr>
		<td align="right">订单金额:</td>
		<td align="left" id="orderMon"></td>
	</tr>
	<tr>
		<td align="right">订单状态:</td>
		<td align="left" id="orderStatus">
		</td>
	</tr>
		<tr id="viewFlag">
			<td align="right">处理结果:</td>
			<td align="left">
				<select name="orderStatus">
					<option value="2">处理成功</option>
					<option value="3">处理不成功</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">备注:</td>
			<td align="left" id="orderResult">
				<textArea name="result" style="width:200px">
				</textArea>
			</td>
		</tr>
</table>
</div>
<div id="ccChild1"> 
	<table class="table_div_content">
		<tr>
			<td><%
				String condition = " and order_id ='" + request.getParameter("orderId") + "'";
				%>
				<dd:tableView code='<%=request.getParameter("tableView")%>' condition='<%=condition%>' />
			</td>
		</tr>
	</table>
</div>

</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
	function refresh(){
		var orderId='<%=request.getParameter("orderId").toString()%>';
    	bookStoreService.getOrder(orderId,renderData);
	}
    function renderData(data){
    	var cmd = '<%=request.getParameter("cmd")%>';
    	$("orderId").innerHTML='<input type="hidden" name="orderId" value="'+data.id+'">'+data.id;
    	$("orderName").innerHTML=data.name;
    	$("orderAddr").innerHTML=data.address;
    	$("orderTel").innerHTML=data.tel;
    	$("orderPostcode").innerHTML=data.postcode;
    	$("orderMon").innerHTML='￥<font color="red">' + data.money;
    	var corderStatus='';
    	if(data.orderStatus==1){
    		corderStatus='待处理';
    	}else if(data.orderStatus==2){
    		corderStatus='已处理';
    	}else if(data.orderStatus==3){
    		corderStatus='处理不成功';
    	}else if(data.orderStatus==4){
    		corderStatus='取消';
    	}
    	var result="";
	    if(data.result != null)result+=data.result;
	    $("orderStatus").innerHTML=corderStatus;
    	if(cmd !=null && cmd=='view'){
    		$("orderResult").innerHTML=result;
    		$("viewFlag").style.display="none";
    		$("button_save").style.display="none";
    	}else{
	    	$("result").value=result;
    	}

    }
</script>
</body>
</html>
