<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.pps_erp_saitem_relation.vo.Pps_erp_saitem_relationVo" %>
<%@ page import="rayoo.pps.pps_erp_saitem_relation.util.IPps_erp_saitem_relationConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	Pps_erp_saitem_relationVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPps_erp_saitem_relationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Pps_erp_saitem_relationVo)request.getAttribute(IPps_erp_saitem_relationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/Pps_erp_saitem_relationAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/Pps_erp_saitem_relationAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Pps_erp_saitem_relationAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >帐套与薪资类别对应表ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pps_erp_id" inputName="帐套与薪资类别对应表ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >帐套项目ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pps_templ_item_id" inputName="帐套项目ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ERP薪资项目ID</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("erp_item_id", -1, gap.rm.project.RmGlobalReference.get(IPps_erp_saitem_relationConstants.DICTIONARY_), "", "inputName='ERP薪资项目ID' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >PPS对应DEF编号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pps_def_index" inputName="PPS对应DEF编号" value="" maxLength="1.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ERP对应DEF编号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="erp_def_index" inputName="ERP对应DEF编号" value="" maxLength="1.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >状态</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="status" inputName="状态" value="" maxLength="1.5" />
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
