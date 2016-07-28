<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_person.vo.JOB_PERSONVo" %>
<%@ page import="rayoo.job.job_person.util.IJOB_PERSONConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	JOB_PERSONVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IJOB_PERSONConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (JOB_PERSONVo)request.getAttribute(IJOB_PERSONConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/JOB_PERSONAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/JOB_PERSONAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/JOB_PERSONAction.do?cmd=queryAll&backFlag=true";
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
			<td align="right"><span class="style_required_red">* </span>iid</td>
			<td align="left">
				<input type="text" class="text_field" name="iid" inputName="iid" maxLength="23" integerDigits="22" decimalDigits="0" validate="notNull;"/>
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
			<td align="right">eename</td>
			<td align="left">
				<input type="text" class="text_field" name="eename" inputName="eename" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">isex</td>
			<td align="left">
				<input type="text" class="text_field" name="isex" inputName="isex" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sbirthyear</td>
			<td align="left">
				<input type="text" class="text_field" name="sbirthyear" inputName="sbirthyear" value="" maxLength="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sbirthmonth</td>
			<td align="left">
				<input type="text" class="text_field" name="sbirthmonth" inputName="sbirthmonth" value="" maxLength="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sbirthday</td>
			<td align="left">
				<input type="text" class="text_field" name="sbirthday" inputName="sbirthday" value="" maxLength="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sbirthdate</td>
			<td align="left">
				<input type="text" class="text_field" name="sbirthdate" inputName="sbirthdate" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">scardid</td>
			<td align="left">
				<input type="text" class="text_field" name="scardid" inputName="scardid" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">dtall</td>
			<td align="left">
				<input type="text" class="text_field" name="dtall" inputName="dtall" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">imarry</td>
			<td align="left">
				<input type="text" class="text_field" name="imarry" inputName="imarry" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">inationaltype</td>
			<td align="left">
				<input type="text" class="text_field" name="inationaltype" inputName="inationaltype" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">inationality</td>
			<td align="left">
				<input type="text" class="text_field" name="inationality" inputName="inationality" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">iprovince</td>
			<td align="left">
				<input type="text" class="text_field" name="iprovince" inputName="iprovince" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">icity</td>
			<td align="left">
				<input type="text" class="text_field" name="icity" inputName="icity" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">iresidencecountry</td>
			<td align="left">
				<input type="text" class="text_field" name="iresidencecountry" inputName="iresidencecountry" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">iresidenceprovince</td>
			<td align="left">
				<input type="text" class="text_field" name="iresidenceprovince" inputName="iresidenceprovince" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">iresidencecity</td>
			<td align="left">
				<input type="text" class="text_field" name="iresidencecity" inputName="iresidencecity" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">isoverseas</td>
			<td align="left">
				<input type="text" class="text_field" name="isoverseas" inputName="isoverseas" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">idegree</td>
			<td align="left">
				<input type="text" class="text_field" name="idegree" inputName="idegree" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifuturewage</td>
			<td align="left">
				<input type="text" class="text_field" name="ifuturewage" inputName="ifuturewage" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifuturecountry</td>
			<td align="left">
				<input type="text" class="text_field" name="ifuturecountry" inputName="ifuturecountry" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifutureprovince</td>
			<td align="left">
				<input type="text" class="text_field" name="ifutureprovince" inputName="ifutureprovince" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifuturecity</td>
			<td align="left">
				<input type="text" class="text_field" name="ifuturecity" inputName="ifuturecity" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">startwork</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="startwork" id="startwork" inputName="startwork" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('startwork','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">company</td>
			<td align="left">
				<input type="text" class="text_field" name="company" inputName="company" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">iscontactor</td>
			<td align="left">
				<input type="text" class="text_field" name="iscontactor" inputName="iscontactor" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">skeywords</td>
			<td align="left">
				<input type="text" class="text_field" name="skeywords" inputName="skeywords" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">istemp</td>
			<td align="left">
				<input type="text" class="text_field" name="istemp" inputName="istemp" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cflag</td>
			<td align="left">
				<input type="text" class="text_field" name="cflag" inputName="cflag" value="'0'" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sindustry</td>
			<td align="left">
				<input type="text" class="text_field" name="sindustry" inputName="sindustry" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sindustry2</td>
			<td align="left">
				<input type="text" class="text_field" name="sindustry2" inputName="sindustry2" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sindustry3</td>
			<td align="left">
				<input type="text" class="text_field" name="sindustry3" inputName="sindustry3" value="" maxLength="250" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifunction</td>
			<td align="left">
				<input type="text" class="text_field" name="ifunction" inputName="ifunction" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifunction2</td>
			<td align="left">
				<input type="text" class="text_field" name="ifunction2" inputName="ifunction2" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ifunction3</td>
			<td align="left">
				<input type="text" class="text_field" name="ifunction3" inputName="ifunction3" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">stype</td>
			<td align="left">
				<input type="text" class="text_field" name="stype" inputName="stype" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ireferral</td>
			<td align="left">
				<input type="text" class="text_field" name="ireferral" inputName="ireferral" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">isource</td>
			<td align="left">
				<input type="text" class="text_field" name="isource" inputName="isource" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">isourcechannel</td>
			<td align="left">
				<input type="text" class="text_field" name="isourcechannel" inputName="isourcechannel" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sphoto</td>
			<td align="left">
				<input type="text" class="text_field" name="sphoto" inputName="sphoto" value="" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ileavetime</td>
			<td align="left">
				<input type="text" class="text_field" name="ileavetime" inputName="ileavetime" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">icreator</td>
			<td align="left">
				<input type="text" class="text_field" name="icreator" inputName="icreator" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">iupdater</td>
			<td align="left">
				<input type="text" class="text_field" name="iupdater" inputName="iupdater" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">dtcreate</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="dtcreate" id="dtcreate" inputName="dtcreate" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dtcreate','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">dtupdate</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="dtupdate" id="dtupdate" inputName="dtupdate" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dtupdate','<venus:base/>/');"/>
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
