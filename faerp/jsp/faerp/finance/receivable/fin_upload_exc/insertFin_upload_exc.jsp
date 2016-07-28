<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.receivable.fin_upload_exc.vo.Fin_upload_excVo" %>
<%@ page import="rayoo.finance.receivable.fin_upload_exc.util.IFin_upload_excConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	Fin_upload_excVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IFin_upload_excConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Fin_upload_excVo)request.getAttribute(IFin_upload_excConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/Fin_upload_excAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/Fin_upload_excAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Fin_upload_excAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1">到款编号</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="inc_code" inputName="到款编号" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">到款日期</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="inc_date" inputName="到款日期" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">到款公司名称</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="inc_cust_name" inputName="到款公司名称" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">到款金额</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="inc_amout" inputName="到款金额" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">错误消息</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="exc_message" inputName="错误消息" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">上传文件名</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="file_name" inputName="上传文件名" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td  class="td_1" >出错行</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="exc_rownum" inputName="出错行" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">上传人</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="upload_user" inputName="上传人" maxLength="500" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >上传日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="upload_date" id="upload_date" inputName="上传日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('upload_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
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
