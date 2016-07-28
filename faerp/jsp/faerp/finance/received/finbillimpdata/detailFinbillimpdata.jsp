<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.received.finbillimpdata.vo.FinbillimpdataVo" %>
<%@ page import="rayoo.finance.received.finbillimpdata.util.IFinbillimpdataConstants" %>
<%  //取出本条记录
	FinbillimpdataVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (FinbillimpdataVo)request.getAttribute(IFinbillimpdataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >company_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >bill_imp_batch_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_imp_batch_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否错误：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_failure())%></td>
		</tr>
		<tr>
			<td class="td_1" >错误原因：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFailure_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工唯一号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >身份证：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id_card_no())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工姓名：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >a1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA1())%></td>
		</tr>
		<tr>
			<td class="td_1" >a2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA2())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >a3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA3())%></td>
		</tr>
		<tr>
			<td class="td_1" >a4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA4())%></td>
		</tr>
		<tr>
			<td class="td_1" >a5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA5())%></td>
		</tr>
		<tr>
			<td class="td_1" >a6：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA6())%></td>
		</tr>
		<tr>
			<td class="td_1" >a7：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA7())%></td>
		</tr>
		<tr>
			<td class="td_1" >a8：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA8())%></td>
		</tr>
		<tr>
			<td class="td_1" >a9：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA9())%></td>
		</tr>
		<tr>
			<td class="td_1" >a10：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA10())%></td>
		</tr>
		<tr>
			<td class="td_1" >a11：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA11())%></td>
		</tr>
		<tr>
			<td class="td_1" >a12：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA12())%></td>
		</tr>
		<tr>
			<td class="td_1" >a13：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA13())%></td>
		</tr>
		<tr>
			<td class="td_1" >a14：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA14())%></td>
		</tr>
		<tr>
			<td class="td_1" >a15：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA15())%></td>
		</tr>
		<tr>
			<td class="td_1" >a16：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA16())%></td>
		</tr>
		<tr>
			<td class="td_1" >a17：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA17())%></td>
		</tr>
		<tr>
			<td class="td_1" >a18：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA18())%></td>
		</tr>
		<tr>
			<td class="td_1" >a19：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA19())%></td>
		</tr>
		<tr>
			<td class="td_1" >a20：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA20())%></td>
		</tr>
		<tr>
			<td class="td_1" >a21：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA21())%></td>
		</tr>
		<tr>
			<td class="td_1" >a22：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA22())%></td>
		</tr>
		<tr>
			<td class="td_1" >a23：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA23())%></td>
		</tr>
		<tr>
			<td class="td_1" >a24：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA24())%></td>
		</tr>
		<tr>
			<td class="td_1" >a25：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA25())%></td>
		</tr>
		<tr>
			<td class="td_1" >a26：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA26())%></td>
		</tr>
		<tr>
			<td class="td_1" >a27：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA27())%></td>
		</tr>
		<tr>
			<td class="td_1" >a28：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA28())%></td>
		</tr>
		<tr>
			<td class="td_1" >a29：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA29())%></td>
		</tr>
		<tr>
			<td class="td_1" >a30：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA30())%></td>
		</tr>
		<tr>
			<td class="td_1" >a31：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA31())%></td>
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
