<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.workattendancerule.psncalendarsub.vo.PsncalendarsubVo" %>
<%@ page import="rayoo.workattendance.workattendancerule.psncalendarsub.util.IPsncalendarsubConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	PsncalendarsubVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPsncalendarsubConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (PsncalendarsubVo)request.getAttribute(IPsncalendarsubConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/PsncalendarsubAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/PsncalendarsubAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/PsncalendarsubAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<script language="javascript">
    if(<%=isModify%>)
        writeTableTop('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTop('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td><br>&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_save" class="button_ellipse" type="button" value='<fmt:message key="save"/>' onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
			<input name="button_cancel" class="button_ellipse" type="button" value='<fmt:message key="cancel"/>'  onClick="javascript:cancel_onClick()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
            <c:if test="<%=isModify%>">
                <fmt:message key="update_detail"/>
            </c:if>
            <c:if test="<%=(isModify==false)%>">
                <fmt:message key="add_detail"/>
            </c:if>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
<tr><td> 
	<table class="table_div_content_inner">
		<tr>
			<td align="right">开始截至时间</td>
			<td align="left">
				<input type="text" class="text_field" name="ksto" inputName="开始截至时间" value="" maxLength="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">下班是否打卡</td>
			<td align="left">
				<input type="text" class="text_field" name="checkoutflag" inputName="下班是否打卡" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">时段序号</td>
			<td align="left">
				<input type="text" class="text_field" name="timeid" inputName="时段序号" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">上班是否打卡</td>
			<td align="left">
				<input type="text" class="text_field" name="checkinflag" inputName="上班是否打卡" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">是否跨天</td>
			<td align="left">
				<input type="text" class="text_field" name="sfkt" inputName="是否跨天" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">结束截止时间</td>
			<td align="left">
				<input type="text" class="text_field" name="jsto" inputName="结束截止时间" value="" maxLength="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">结束时间</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="jssj" id="jssj" inputName="结束时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('jssj','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">开始时间</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="kssj" id="kssj" inputName="开始时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('kssj','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">公司编码</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="公司编码" value="" maxLength="10" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">作息时间ID</td>
			<td align="left">
				<input type="text" class="text_field" name="pk_wtid" inputName="作息时间ID" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">人员工作日历主键</td>
			<td align="left">
				<input type="text" class="text_field" name="pk_psncalendar" inputName="人员工作日历主键" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">是否有效</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="是否有效" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">是否删除</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="是否删除" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">最后修改人</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="最后修改人" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">最后修改日期</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="最后修改日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">分公司id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="分公司id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</td></tr>
</table>
</div>
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
