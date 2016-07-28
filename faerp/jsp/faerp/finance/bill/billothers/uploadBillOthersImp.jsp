<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.finance.bill.billothers.vo.BillOthersImpVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	 <base target="_self"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<%
		//取出本条记录 
		BillOthersImpVo resultVo = null; //定义一个临时的vo变量
		resultVo = (BillOthersImpVo) request
				.getAttribute("billOthersImpVo"); //从request中取出vo, 赋值给resultVo
		RmVoHelper.null2Nothing(resultVo);//把vo中的每个值过滤
	%>

	<script language="javascript">
	  	function upload_onClick(id){  //保存修改后的单条数据
			var file1=document.form.file1.value.trim();
			file1=file1.substring(file1.lastIndexOf(".")+1);
			if(file1!="xls"&&file1!="xlsx"){
				alert("文件类型必须为excel！");
				return ;
			}
			
		    form.action="<%=request.getContextPath()%>/BillOthersImpAction.do?cmd=upload";
	    	form.submit();
		}
		
		window.onload = function(){ 
			var lastStepStatus = document.getElementById("lastStepStatus").value;
			if (lastStepStatus){
				if("err" == lastStepStatus){
					alert(document.getElementById("lastStepMsg").value);
				}else if("done" == lastStepStatus){
					alert(document.getElementById("lastStepMsg").value);
					window.close();
					window.opener.insertcallBack();
				}
			}
		} 
	</script>
	</head>
	<body>

	<form name="form" method="post" enctype="multipart/form-data">
	<input type="hidden" id="lastStepStatus" value="${lastStepStatus}">
	<input type="hidden" id="lastStepMsg" value="${lastStepMsg}">
	<div id="ccChild1" class="box_xinzeng"
		style="height: 160px; width: 700px;"><input type="hidden"
		id="impId" name="impId" value="${billOthersImpVo.id}" />
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">客户编号</td>
			<td class="td_2 ">${billOthersImpVo.cust_code}</td>
			<td class="td_1">客户名称</td>
			<td class="td_2 ">${billOthersImpVo.cust_name}</td>
		</tr>
		<tr>
			<td class="td_1">城市</td>
			<td class="td_2 ">${billOthersImpVo.city_name}</td>
			<td class="td_1">账单年月</td>
			<td class="td_2 ">${billOthersImpVo.bill_year_month}</td>
		</tr>
		<tr>
			<td class="td_1">项目名称</td>
			<td class="td_2 " colspan="3"><%=BaseDataHelper.getNameByCode("CHARGE_ITEM_BD", resultVo
							.getCharge_item_bd())%>
			</td>
		</tr>
		<tr>
			<td class="td_1">导入文件</td>
			<td class="td_2 " colspan="3"><input type="file" id="fileInput"
				name="file1" validate="notNull;" inputName="导入文件"></td>
		</tr>
		<tr>
			<td class="td_1" colspan="4"><input type="button" class="icon_2"
				value='上传' onClick="javascript:upload_onClick()" /></td>
		</tr>
	</table>
	</div>
	</form>
</fmt:bundle>
</body>
</html>