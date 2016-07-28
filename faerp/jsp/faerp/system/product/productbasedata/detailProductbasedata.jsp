<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.system.productbasedata.vo.ProductbasedataVo" %>
<%@ page import="rayoo.system.productbasedata.util.IProductbasedataConstants" %>
<%  //取出本条记录
	ProductbasedataVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (ProductbasedataVo)request.getAttribute(IProductbasedataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCode())%></td>
		</tr>
		<tr>
			<td class="td_1" >typeid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTypeid())%></td>
		</tr>
		<tr>
			<td class="td_1" >typecode：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTypecode())%></td>
		</tr>
		<tr>
			<td class="td_1" >levelnum：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLevelnum())%></td>
		</tr>
		<tr>
			<td class="td_1" >isleaf：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIsleaf())%></td>
		</tr>
		<tr>
			<td class="td_1" >name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getName())%></td>
		</tr>
		<tr>
			<td class="td_1" >isbncode：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIsbncode())%></td>
		</tr>
		<tr>
			<td class="td_1" >hintcode：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHintcode())%></td>
		</tr>
		<tr>
			<td class="td_1" >status：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStatus())%></td>
		</tr>
		<tr>
			<td class="td_1" >startdate：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStartdate())%></td>
		</tr>
		<tr>
			<td class="td_1" >enddate：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEnddate())%></td>
		</tr>
		<tr>
			<td class="td_1" >description：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDescription())%></td>
		</tr>
		<tr>
			<td class="td_1" >treecode：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTreecode())%></td>
		</tr>
		<tr>
			<td class="td_1" >seqno：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSeqno())%></td>
		</tr>
		<tr>
			<td class="td_1" >createdby：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreatedby())%></td>
		</tr>
		<tr>
			<td class="td_1" >updatedby：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getUpdatedby())%></td>
		</tr>
		<tr>
			<td class="td_1" >created：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreated(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >updated：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getUpdated(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >parentid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getParentid())%></td>
		</tr>
		<tr>
			<td class="td_1" >spare1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSpare1())%></td>
		</tr>
		<tr>
			<td class="td_1" >spare2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSpare2())%></td>
		</tr>
		<tr>
			<td class="td_1" >spare3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSpare3())%></td>
		</tr>
		<tr>
			<td class="td_1" >spare4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSpare4())%></td>
		</tr>
		<tr>
			<td class="td_1" >spare5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSpare5(), 10)%></td>
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
