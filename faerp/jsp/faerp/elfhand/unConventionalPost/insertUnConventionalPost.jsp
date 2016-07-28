<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.elfhand.vo.UnConventionalPostVo" %>
<%@ page import="rayoo.elfhand.util.IElfhandConstants" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	UnConventionalPostVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IElfhandConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (UnConventionalPostVo)request.getAttribute(IElfhandConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据	
	    if(checkAllForms()){	    
		    var empCode=document.form.empCode.value;
	        var name=document.form.name.value;
	        var unit=document.form.unit.value;
	        var typeOfWork = document.form.typeOfWork.value;
			var action="<%=request.getContextPath()%>/ElfhandAction.do?cmd=insert2";
            var myAjax = new Ajax(action);
            myAjax.addParam('empCode', empCode);
            myAjax.addParam('name', name);
            myAjax.addParam('unit', unit);
            myAjax.addParam('typeOfWork', typeOfWork);
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
            	alert(""+myAjax.getProperty("returnValue"));
                window['returnValue'] = ""+myAjax.getProperty("returnValue");
                window.close();
           	}
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if(checkAllForms()){
	        var empCode=document.form.empCode.value;
	        var name=document.form.name.value;
	        var unit=document.form.unit.value;
	        var typeOfWork = document.form.typeOfWork.value;
	    	var action="<%=request.getContextPath()%>/ElfhandAction.do?cmd=update2";
            var myAjax = new Ajax(action);
            myAjax.addParam('empCode', empCode);
            myAjax.addParam('name', name);
            myAjax.addParam('unit', unit);
            myAjax.addParam('typeOfWork', typeOfWork);
            myAjax.addParam('id', document.form.id.value);
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
            	alert(""+myAjax.getProperty("returnValue"));
                window['returnValue'] = ""+myAjax.getProperty("returnValue");
                window.close();
            }
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
	<div id="right" style="width: 98%;height: 90px;">
		<!-- <script language="javascript">
		    if(<%=isModify%>)
		        writeTableTopFesco('修改非常规岗位','<%=request.getContextPath()%>/');
		    else
		        writeTableTopFesco('新增非常规岗位','<%=request.getContextPath()%>/');
		</script>  -->
		<div class="ringht_s">
			<div id="ccChild1" class="box_3"> 
				<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
					<tr>
						<td class="td_1" width="25%"><span class="style_required_red">* </span>唯一号</td>
						<td class="td_2" width="25%">
							<input type="text" class="text_field" name="empCode" inputName="唯一号" value="" maxLength="64" validate="notNull;"/>
						</td>
						<td class="td_1" width="25%"><span class="style_required_red">* </span>姓名</td>
						<td class="td_2" width="25%">
							<input type="text" class="text_field" name="name" inputName="姓名" value="" maxLength="50" validate="notNull;"/>
						</td>
					</tr>
					<tr>
			            <td class="td_1">单位</td>
			            <td class="td_2">
			                <input type="text" class="text_field" name="unit" inputName="单位" value="" maxLength="75" />
			            </td>
			            <td class="td_1">岗位工种</td>
			            <td class="td_2">
			                <input type="text" class="text_field" name="typeOfWork" inputName="岗位工种" value="" maxLength="50" />
			            </td>
			        </tr>
				</table>
			</div>
    		<div class="mx_button" align="center">
		        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
		        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        	</div>
		</div>
	</div> 
	<input type="hidden" name="id">
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
