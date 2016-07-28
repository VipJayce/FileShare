<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.u8.u8_subject.vo.U8_subjectVo" %>
<%@ page import="rayoo.u8.u8_subject.util.IU8_subjectConstants" %>
<%  //取出本条记录
	U8_subjectVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (U8_subjectVo)request.getAttribute(IU8_subjectConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/U8_subjectAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >科目类型：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCclass())%></td>
		</tr>
		<tr>
			<td class="td_1" >科目类型英文名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCclass_engl())%></td>
		</tr>
		<tr>
			<td class="td_1" >财务分析类型：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCclassany())%></td>
		</tr>
		<tr>
			<td class="td_1" >财务分析类型英文名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCclassany_engl())%></td>
		</tr>
		<tr>
			<td class="td_1" >科目编码：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCcode())%></td>
		</tr>
		<tr>
			<td class="td_1" >科目名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCcode_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >科目英文名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCcode_engl())%></td>
		</tr>
		<tr>
			<td class="td_1" >编码级次：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIgrade())%></td>
		</tr>
		<tr>
			<td class="td_1" >bproperty：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBproperty())%></td>
		</tr>
		<tr>
			<td class="td_1" >cbook_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCbook_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >cbook_type_engl：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCbook_type_engl())%></td>
		</tr>
		<tr>
			<td class="td_1" >chelp：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChelp())%></td>
		</tr>
		<tr>
			<td class="td_1" >cexch_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCexch_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >cmeasure：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCmeasure())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否个人往来核算：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBperson())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否客户往来核算：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBcus())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否供应商往来核算：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBsup())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否部门核算：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBdept())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否项目核算：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBitem())%></td>
		</tr>
		<tr>
			<td class="td_1" >项目大类编码：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCass_item())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否日记账：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBr())%></td>
		</tr>
		<tr>
			<td class="td_1" >be：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBe())%></td>
		</tr>
		<tr>
			<td class="td_1" >cgather：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCgather())%></td>
		</tr>
		<tr>
			<td class="td_1" >bend：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBend())%></td>
		</tr>
		<tr>
			<td class="td_1" >bexchange：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBexchange())%></td>
		</tr>
		<tr>
			<td class="td_1" >bcash：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBcash())%></td>
		</tr>
		<tr>
			<td class="td_1" >bbank：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBbank())%></td>
		</tr>
		<tr>
			<td class="td_1" >bused：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBused())%></td>
		</tr>
		<tr>
			<td class="td_1" >bd_c：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBd_c())%></td>
		</tr>
		<tr>
			<td class="td_1" >dbegin：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDbegin(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >dend：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDend(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >itrans：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getItrans())%></td>
		</tr>
		<tr>
			<td class="td_1" >bclose：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBclose())%></td>
		</tr>
		<tr>
			<td class="td_1" >cother：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCother())%></td>
		</tr>
		<tr>
			<td class="td_1" >iotherused：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIotherused())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
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
