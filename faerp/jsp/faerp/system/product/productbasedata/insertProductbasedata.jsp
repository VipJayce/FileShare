<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.productbasedata.vo.ProductbasedataVo" %>
<%@ page import="rayoo.system.productbasedata.util.IProductbasedataConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	ProductbasedataVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IProductbasedataConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (ProductbasedataVo)request.getAttribute(IProductbasedataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="code" inputName="code" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>typeid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="typeid" inputName="typeid" value="" maxLength="9.5" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>typecode</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="typecode" inputName="typecode" value="" maxLength="32" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" ><span class="style_required_red">* </span>levelnum</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="levelnum" inputName="levelnum" maxLength="3" integerDigits="2" decimalDigits="0" validate="notNull;"/>
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>isleaf</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="isleaf" inputName="isleaf" value="1 " maxLength="1" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="name" inputName="name" value="" maxLength="32" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >isbncode</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="isbncode" inputName="isbncode" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hintcode</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hintcode" inputName="hintcode" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>status</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="status" inputName="status" value="1 " maxLength="1" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >startdate</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="startdate" inputName="startdate" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >enddate</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="enddate" inputName="enddate" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >description</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="description" inputName="description" value="" maxLength="128" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >treecode</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="treecode" inputName="treecode" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" ><span class="style_required_red">* </span>seqno</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="seqno" inputName="seqno" maxLength="4" integerDigits="3" decimalDigits="0" validate="notNull;"/>
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >createdby</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="createdby" inputName="createdby" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >updatedby</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="updatedby" inputName="updatedby" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>created</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="created" id="created" inputName="created" validate="notNull;"/><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('created','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >updated</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="updated" id="updated" inputName="updated" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('updated','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >parentid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="parentid" inputName="parentid" value="" maxLength="32" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >spare1</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="spare1" inputName="spare1" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">spare2</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="spare2" inputName="spare2" maxLength="512" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">spare3</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="spare3" inputName="spare3" maxLength="512" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">spare4</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="spare4" inputName="spare4" maxLength="512" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >spare5</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="spare5" id="spare5" inputName="spare5" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('spare5','<venus:base/>/');"/>
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
        <input type="button" class="icon_2" value='<fmt:message key="cancel"/>'  onClick="javascript:cancel_onClick()"/>
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
