<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.elfhand.vo.SingletatsudoVo" %>
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
	SingletatsudoVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IElfhandConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SingletatsudoVo)request.getAttribute(IElfhandConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		    var name=document.form.name.value;
	        var customerCode=document.form.customerCode.value;
	        var organization=document.form.organization.value;
	        var employment = document.form.employment.value;
            var jName = document.form.JName.value;
            var jCode = document.form.JCode.value;
			var action="<%=request.getContextPath()%>/ElfhandAction.do?cmd=insert1";
            var myAjax = new Ajax(action);
            myAjax.addParam('name', name);
            myAjax.addParam('customerCode', customerCode);
            myAjax.addParam('organization', organization);
            myAjax.addParam('employment', employment);
            myAjax.addParam('jName', jName);
            myAjax.addParam('jCode', jCode);
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
            	alert(""+myAjax.getProperty("returnValue"));
                window['returnValue'] = ""+myAjax.getProperty("returnValue");
                window.close();
            }
		}
	}

  	function update_onClick(){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if(checkAllForms()){
	        var name=document.form.name.value;
	        var customerCode=document.form.customerCode.value;
	        var organization=document.form.organization.value;
	        var employment = document.form.employment.value;
            var jName = document.form.JName.value;
            var jCode = document.form.JCode.value;
	    	var action="<%=request.getContextPath()%>/ElfhandAction.do?cmd=update1";
            var myAjax = new Ajax(action);
            myAjax.addParam('name', name);
            myAjax.addParam('customerCode', customerCode);
            myAjax.addParam('organization', organization);
            myAjax.addParam('employment', employment);
            myAjax.addParam('jName', jName);
            myAjax.addParam('jCode', jCode);
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
	<div id="right" style="width: 98%;height: 90%;">
		<!-- <script language="javascript">
		    if(<%=isModify%>)
		        writeTableTopFesco('修改单立户、大库','<%=request.getContextPath()%>/');
		    else
		        writeTableTopFesco('新增单立户、大库','<%=request.getContextPath()%>/');
		</script> --> 
		<div class="ringht_s">
			<div id="ccChild1" class="box_3"> 
				<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
					<tr>
						<td class="td_1" width="25%"><span class="style_required_red">* </span>客户名称</td>
						<td class="td_2" width="25%">
							<input type="text" class="text_field" name="name" inputName="客户名称" value="" maxLength="64" validate="notNull;"/>
						</td>
						<td class="td_1" width="25%"><span class="style_required_red">* </span>客户编号</td>
						<td class="td_2" width="25%">
							<input type="text" class="text_field" name="customerCode" inputName="客户编号" value="" maxLength="50" validate="notNull;"/>
						</td>
					</tr>
					<tr>
			            <td class="td_1">档案代保管地</td>
			            <td class="td_2">
			                <input type="text" class="text_field" name="organization" inputName="档案代保管地" value="" maxLength="75" />
			            </td>
			            <td class="td_1">外地人用工地</td>
			            <td class="td_2">
			                <input type="text" class="text_field" name="employment" inputName="外地人用工地" value="" maxLength="50" />
			            </td>
			        </tr>
			        <tr>
			            <td class="td_1">组织机构代码</td>
			            <td class="td_2">
			                <input type="text" class="text_field" name="JName" inputName="组织机构代码" value="" maxLength="20" />
			            </td>
			            <td class="td_1">网上办事密码</td>
			            <td class="td_2">
			                <input type="text" class="text_field" name="JCode" inputName="网上办事密码" value="" maxLength="20"/>
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
