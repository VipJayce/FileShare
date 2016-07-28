<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
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
 
	<input type="hidden" name="id" value="${bean.id }">
       <div id="right">
    	<div class="ringht_s">
<div id="ccChild0" class="box_3" style="height: 380px" > 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	<tr>
            <td class="td_1" >U8客户编码：</td>
            <td class="td_2" >${bean.custcode_u8}</td>
        </tr>
        <tr>
            <td class="td_1" >U8客户名称：</td>
            <td class="td_2" >${bean.ccusname}</td>
        </tr>
		<tr>
			<td class="td_1" >ERP客户名称：</td>
			<td class="td_2" >${bean.customer_name}</td>
		</tr>
		
		<tr>
			<td class="td_1" >生效日期：</td>
			<td class="td_2" ><fmt:formatDate value="${bean.startdate}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td class="td_1" >截止日期：</td>
			<td class="td_2" ><fmt:formatDate value="${bean.enddate}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
   			<td class="td_1">业务类型</td>
			<td class="td_2"><%=RmStringHelper.prt(request.getAttribute("BUS_TYPE_NAME"))%></td>	
   		</tr>
		<tr>
			<td class="td_1" >创建人</td>
			<td class="td_2" >${bean.create_user_name}</td>
		</tr>
		  <tr>
            <td class="td_1" >创建时间</td>
            <td class="td_2" ><fmt:formatDate value="${bean.create_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
          <tr>
            <td class="td_1" >最后修改人</td>
            <td class="td_2" >${bean.last_update_user_name}</td>
        </tr>  <tr>
            <td class="td_1" >最后修改时间</td>
            <td class="td_2" ><fmt:formatDate value="${bean.last_update_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
        <tr>
   			<td class="td_1">开票属性</td>
			<td class="td_2"><%=RmStringHelper.prt(request.getAttribute("OPEN_INVOICE_NAME"))%></td>	
   		</tr>
   		<tr>
            <td class="td_1">凭证属性</td>
            <td class="td_2"><%=RmStringHelper.prt(request.getAttribute("voucher_class_name"))%></td>    
        </tr>
		<tr>
            <td class="td_1" >备注：</td>
            <td class="td_2" >${bean.remark}</td>
        </tr>
	</table>

	<div class="foot_button">
<input type="button" class="foot_icon_1" value='关闭'   onclick="javascript:back_onClick();" />
    </div>
</div>
</div>
	 </div>

</form>
</fmt:bundle>
</body>
</html>
