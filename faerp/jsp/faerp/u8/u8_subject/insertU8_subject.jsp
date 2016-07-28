<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8_subject.vo.U8_subjectVo" %>
<%@ page import="rayoo.u8.u8_subject.util.IU8_subjectConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	U8_subjectVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IU8_subjectConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (U8_subjectVo)request.getAttribute(IU8_subjectConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/U8_subjectAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/U8_subjectAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/U8_subjectAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >company_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >科目类型</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cclass" inputName="科目类型" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >科目类型英文名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cclass_engl" inputName="科目类型英文名称" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >财务分析类型</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cclassany" inputName="财务分析类型" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >财务分析类型英文名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cclassany_engl" inputName="财务分析类型英文名称" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >科目编码</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ccode" inputName="科目编码" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >科目名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ccode_name" inputName="科目名称" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >科目英文名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ccode_engl" inputName="科目英文名称" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >编码级次</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="igrade" inputName="编码级次" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >bproperty</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="bproperty" inputName="bproperty" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cbook_type</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cbook_type" inputName="cbook_type" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cbook_type_engl</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cbook_type_engl" inputName="cbook_type_engl" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >chelp</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="chelp" inputName="chelp" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cexch_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cexch_name" inputName="cexch_name" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cmeasure</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cmeasure" inputName="cmeasure" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否个人往来核算</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bperson" inputName="是否个人往来核算" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否客户往来核算</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bcus" inputName="是否客户往来核算" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否供应商往来核算</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bsup" inputName="是否供应商往来核算" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否部门核算</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bdept" inputName="是否部门核算" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否项目核算</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bitem" inputName="是否项目核算" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >项目大类编码</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cass_item" inputName="项目大类编码" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否日记账</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="br" inputName="是否日记账" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >be</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="be" inputName="be" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cgather</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cgather" inputName="cgather" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bend</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bend" inputName="bend" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bexchange</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bexchange" inputName="bexchange" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bcash</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bcash" inputName="bcash" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bbank</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bbank" inputName="bbank" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bused</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bused" inputName="bused" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >bd_c</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="bd_c" inputName="bd_c" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dbegin</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="dbegin" id="dbegin" inputName="dbegin" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dbegin','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dend</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="dend" id="dend" inputName="dend" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dend','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >itrans</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="itrans" inputName="itrans" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bclose</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bclose" inputName="bclose" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cother</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cother" inputName="cother" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >iotherused</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="iotherused" inputName="iotherused" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_del</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
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
