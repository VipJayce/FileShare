<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.salary.datainterface.vo.DatainterfaceVo" %>
<%@ page import="rayoo.salary.datainterface.util.IDatainterfaceConstants" %>
<%  //取出本条记录
	DatainterfaceVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (DatainterfaceVo)request.getAttribute(IDatainterfaceConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >分公司ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >薪资类别ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSalary_class_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >接口名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInf_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >接口类型：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInf_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >身份识别方式：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getExcel_col())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工姓名列：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_name_col())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工唯一标识列：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_indentify_col())%></td>
		</tr>
		<tr>
			<td class="td_1" >客户唯一标识列：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCol_cust_identify())%></td>
		</tr>
		<tr>
			<td class="td_1" >开始行：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRow_begin())%></td>
		</tr>
		<tr>
			<td class="td_1" >结束行：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRow_end())%></td>
		</tr>
		<tr>
			<td class="td_1" >最后导入数据ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_import_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >备注：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否删除：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" align="right"></td>
			<td class="td_2" align="left"></td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
