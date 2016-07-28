<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.datainterface.vo.DatainterfaceVo" %>
<%@ page import="rayoo.salary.datainterface.util.IDatainterfaceConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	DatainterfaceVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IDatainterfaceConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (DatainterfaceVo)request.getAttribute(IDatainterfaceConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value='"+value+"' onclick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("inf_name") + "\");>";//inf_nameList
    }
    function ClickRow(id,name){    }
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if(checkAllForms()){
		    form.action="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=update";
	    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=queryAll&backFlag=true";
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
	<div class="ringht_s">
<div class="xz_title">数据接口信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><div align="right">接口名称</div></td>
			<td class="td_2 "><input type="text" class="text_field" name="inf_name" inputName="接口名称" value="" maxLength="50" />			</td>
			<td class="td_2" ><div align="right"><span class="td_1">员工姓名列标</span></div></td>
			<td class="td_2 "><input type="text" class="text_field" name="emp_name_col" inputName="员工姓名列" value="" maxLength="50" />            </td>
			<td class="td_2" ><div align="right">员工识别方式</div></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("excel_col_bd", -1,"EXCEL_COL_BD","","",false) %> 
			</td>
		</tr>
		<tr>
			<td class="td_1" ><div align="right">员工识别列标</div></td>
			<td class="td_2 "><input type="text" class="text_field" name="emp_indentify_col" inputName="员工唯一标识列" value="" maxLength="50" /></td>
			<td class="td_2" ><div align="right"><span class="td_1">开始行</span></div></td>
			<td class="td_2" ><input type="text" class="text_field" name="row_begin" inputName="开始行" value="2" maxLength="19" integerDigits="18" decimalDigits="0" /></td>
			<td class="td_2" ><div align="right"><span class="td_1">结束行</span></div></td>
			<td class="td_2" ><input type="text" class="text_field" name="row_end" inputName="结束行" maxLength="19" integerDigits="18" decimalDigits="0" /></td>
		</tr>
		<tr>
			<td class="td_1"><div align="right">备注</div></td>
			<td colspan="5" class="td_2" >
				<textarea class="textarea_limit_words" cols="100" rows="3" name="remarks" inputName="备注" maxLength="1000" ></textarea>			</td>
		</tr>
	</table>
<div class="xz_title">数据接口关联信息</div>
<div style="display;padding: 8 10 8 8;">
     <r:datacell  id="celllist1" isCount="false" paramFormId="datacell_formid"
        queryAction="/FAERP/InterfaceitemAction.do?cmd=seachInterfaceitemData"
        submitAction="/FAERP/InterfaceitemAction.do?cmd=insertInterfaceitemData"
        width="99%" xpath="InterfaceitemVo" submitXpath="InterfaceitemVo"  >

		<r:toolbar location="top" tools="nav,pagesize,info"/>
      	<r:toolbar location="bottom" tools="nav,edit,pagesize,info"/>
      	<r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center"/>
      	<r:field fieldName="excel_col_name" label="excel文件列标" width="150px">
       		<h:text/>
      	</r:field>
      	<r:field fieldName="sal_item_name" label="薪资项目名称" width="150px">
        	<d:select dictTypeId="TrueOrFalse"/>
      	</r:field>
	</r:datacell>
</div>
</div>          
</div>  
 <div class="mx_button" style="padding-left:500px">
       <input type="button" class="icon_2" value='<fmt:message key="save"/>' onclick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
       <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onclick="javascript:cancel_onClick()"/>
 </div>       
<input type="hidden" name="id" value=""/>
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
</body>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
