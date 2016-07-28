<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_personresume.vo.JOB_PERSONRESUMEVo" %>
<%@ page import="rayoo.job.job_personresume.util.IJOB_PERSONRESUMEConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	JOB_PERSONRESUMEVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IJOB_PERSONRESUMEConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (JOB_PERSONRESUMEVo)request.getAttribute(IJOB_PERSONRESUMEConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/JOB_PERSONRESUMEAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/JOB_PERSONRESUMEAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/JOB_PERSONRESUMEAction.do?cmd=queryAll&backFlag=true";
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
			<td align="right">persion_id</td>
			<td align="left">
				<input type="text" class="text_field" name="persion_id" inputName="persion_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><span class="style_required_red">* </span>iid</td>
			<td align="left">
				<input type="text" class="text_field" name="iid" inputName="iid" maxLength="23" integerDigits="22" decimalDigits="0" validate="notNull;"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ipersonid</td>
			<td align="left">
				<input type="text" class="text_field" name="ipersonid" inputName="ipersonid" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ilan</td>
			<td align="left">
				<input type="text" class="text_field" name="ilan" inputName="ilan" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sname</td>
			<td align="left">
				<input type="text" class="text_field" name="sname" inputName="sname" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sdept</td>
			<td align="left">
				<input type="text" class="text_field" name="sdept" inputName="sdept" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sposition</td>
			<td align="left">
				<input type="text" class="text_field" name="sposition" inputName="sposition" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sevaluate</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="sevaluate" inputName="sevaluate" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">straining</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="straining" inputName="straining" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">sproject</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="sproject" inputName="sproject" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">scertificate</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="scertificate" inputName="scertificate" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">sbasicsalary</td>
			<td align="left">
				<input type="text" class="text_field" name="sbasicsalary" inputName="sbasicsalary" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sbonus</td>
			<td align="left">
				<input type="text" class="text_field" name="sbonus" inputName="sbonus" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sallowance</td>
			<td align="left">
				<input type="text" class="text_field" name="sallowance" inputName="sallowance" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sstock</td>
			<td align="left">
				<input type="text" class="text_field" name="sstock" inputName="sstock" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">scomments</td>
			<td align="left">
				<input type="text" class="text_field" name="scomments" inputName="scomments" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">scopypaste</td>
			<td align="left">
				<input type="text" class="text_field" name="scopypaste" inputName="scopypaste" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sfulltext</td>
			<td align="left">
				<input type="text" class="text_field" name="sfulltext" maxLength="2000" />
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
