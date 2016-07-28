<%@ include file="/jsp/include/global.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.au.auuser.vo.AuUserVo" %>
<%@ page import="gap.authority.au.auuser.util.IAuUserConstants" %>
<%@ page import="gap.authority.util.GlobalConstants" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Modify_page"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.New_page")%></title>
<script language="javascript">
	var originalLoginId;
	var domain_login_id
	var validLoginId = true;
	function insert_onClick(){  //插入单条数据
	    var flag = true;
	    if(form.name.value == null || form.name.value == ""){
	       alert("真实姓名不能为空！");
	       return false;
	    }
	    if(form.login_id.value == null || form.login_id.value == "") {
	       alert("登录帐号不能为空！");
	       return false;
	    }
		if(!validLoginId) {
			alert("<fmt:message key='gap.authority.This_account_has_been_occupied' bundle='${applicationAuResources}' />");
			setVenusInputError(form.login_id);
			return false;		
		}
		if(form.domain_login_id.value == null || form.domain_login_id.value == ""){
		  alert("域账号不能为空！");
		  return false;
		}else{
		  jQuery.ajax({
	           url: "<%=request.getContextPath()%>/AuUserAction.do?cmd=checkDomainLoginId",
	           type: "POST",
	           dataType: "html",
	           data: jQuery("form").serialize(),
	           async: false,
	           timeout: 10000,
	           error: function(XMLHttpRequest, textStatus, errorThrown) {
	                   alert(XMLHttpRequest.status);
	                   alert(XMLHttpRequest.readyState);
	                   alert(textStatus);
	            },
	           success: function(size){
	               if(size!="0"){
                         alert("域帐户在系统中已存在！");
                         flag = false;
                     }else{
                          flag = true;
                     }
	           }
	       });
		}
		if(flag==false){
            return;
        }
        if(form.password.value == null || form.password.value == ""){
            alert("登录密码不能为空！");
            return;
        }
        if(form.password2.value != form.password.value) {
            alert("<fmt:message key='gap.authority.Confirm_Password_inconsistent' bundle='${applicationAuResources}' />");
            return false;
        }
    	form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=insert";
	    form.submit();
	}
  	function update_onClick(id){  //保存修改后的单条数据
		var flag = true;
        if(form.login_id.value == null || form.login_id.value == "") {
           alert("登录帐号不能为空！");
           return false;
        }
        if(!validLoginId) {
            alert("<fmt:message key='gap.authority.This_account_has_been_occupied' bundle='${applicationAuResources}' />");
            setVenusInputError(form.login_id);
            return false;       
        }
        if(form.domain_login_id.value == null || form.domain_login_id.value == ""){
          alert("域账号不能为空！");
          return false;
        }else{
          if(form.domain_login_id.value == domain_login_id){
            flag = true;
          }else{
	          jQuery.ajax({
	               url: "<%=request.getContextPath()%>/AuUserAction.do?cmd=checkDomainLoginId",
	               type: "POST",
	               dataType: "html",
	               data: jQuery("form").serialize(),
	               async: false,
	               timeout: 10000,
	               error: function(XMLHttpRequest, textStatus, errorThrown) {
	                       alert(XMLHttpRequest.status);
	                       alert(XMLHttpRequest.readyState);
	                       alert(textStatus);
	                },
	               success: function(size){
	                   if(size!="0"){
	                         alert("域帐户在系统中已存在！");
	                         flag = false;
	                     }else{
	                          flag = true;
	                     }
	               }
	           });
           }
        }
        if(flag==false){
            return;
        }
        if(form.password.value == null || form.password.value == ""){
            alert("登录密码不能为空！");
            return;
        }
        if(form.password2.value != form.password.value) {
            alert("<fmt:message key='gap.authority.Confirm_Password_inconsistent' bundle='${applicationAuResources}' />");
            return false;
        }
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=update";
    	form.submit();
	}
	function getEmployeeRef(rootCode,type) {  //获取人员参照列表
		refPath = "<venus:base/>/jsp/authority/au/auuser/chooseDiv.jsp?typeId="+type;
		var rtObj = window.showModalDialog(refPath, new Object(),'dialogHeight=500px;dialogWidth=600px;resizable:yes;status:no;scroll:auto;');
		if(rtObj != undefined && rtObj.length > 0){
			form.party_id.value = rtObj[0]['returnValue'];
			form.name.value = rtObj[0]['childName'];
		}
	}
	
	function getOrgTree() {
		var treePath = "<venus:base/>/jsp/authority/tree/treeRef.jsp?inputType=radio&submit_all=0&rootXmlSource=<venus:base/>/jsp/authority/au/auuser/xmlData.jsp?parent_code%3D%26return_type%3Dparty_id";
		var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
		
		if(rtObj != undefined && rtObj.length > 0) {
			var allTextValue = "";
			var allTextName = "";
			for(var i=0; i<rtObj.length-1; i++) {
				allTextValue += rtObj[i]['returnValue'] + ",";
				allTextName += rtObj[i]['childName'] + ",";
			}
			allTextValue += rtObj[rtObj.length-1]['returnValue'];
			allTextName += rtObj[rtObj.length-1]['childName'];
			
			form.party_id.value = allTextValue;
			form.name.value = allTextName;
		} 
	}
	
	function validateLoginId() {
		var loginId = form.login_id.value;
		if (loginId != null && loginId != "") { 
			if (loginId == originalLoginId) { //在修改页面，如果改变后的值与原始loginId相同，验证通过
				validLoginId = true;
				setVenusInputDefault(form.login_id);
				return true;
			}
			jQuery.ajax({
				type: "GET",
				url: "<%=request.getContextPath()%>/AuUserAction.do",
				data: "cmd=validateLoginId&loginId=" + loginId,
				async: true,
				success: function(msg) {
					 	if (msg > 0) {
					 		validLoginId = false;
					 		alert("<fmt:message key='gap.authority.This_account_has_been_occupied' bundle='${applicationAuResources}' />");
					 		setVenusInputError(form.login_id);
					 	} else {
					 		validLoginId = true;
					 		setVenusInputDefault(form.login_id);
					 	}					
				},
				error: function(xmlhttp,msg) {
					alert("<fmt:message key='gap.authority.Network_link_fails_' bundle='${applicationAuResources}' />");
				}
			});			
		}
	}
	
   //选择供应商
	function rtnFunc1(arg){
   	 var lookup = $id("lk_cust1");
     lookup.value = arg[0];
     lookup.displayValue = arg[1];
     jQuery("#agent_id").val(arg[0]);    
     jQuery("#agent_name").val(arg[1]);    
     return false;
    }
    
	//调用getEmployeeRef 的代码：
	//onClick="javascript:getEmployeeRef('<%//=GlobalConstants.getRelaType_comp()%>','<%//=GlobalConstants.getPartyType_empl()%>');"/>
</script>
<script language="javascript" for=window event=onload>
	originalLoginId = form.login_id.value; //修改之前记录原始loginId
	domain_login_id = form.domain_login_id.value;
</script>
</head>
<body>
 
<form name="form" method="post">

<div id="right">
	<div class="right_title_bg"><div class=" right_title"><%if(!isModify){%>用户新增<%}else{ %>用户修改<%} %></div></div>
    <div class="ringht_x">
	<!--表格 -->
    	<div class="box_xinzeng">
        <div class="xz_title">基本信息</div>
          <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
		<tr>
			<td  class="td_1" width="80" align="right" nowrap>&nbsp;</td>
			<td  class="td_2" align="left">&nbsp;</td>
			<td  class="td_2 align="left" rowspan="5"><br>
			<fmt:message key='gap.authority.Tips_' bundle='${applicationAuResources}' /><br><br>
			<fmt:message key='gap.authority.Sign_restricted_account_letters_numbers_underscores_can_not_use_Chinese_characters_in_length' bundle='${applicationAuResources}' />24<fmt:message key='gap.authority.Characters_or_less_' bundle='${applicationAuResources}' /><br><br>
			<fmt:message key='gap.authority.To_protect_the_security_of_your_information_passwords_can_not_be_too_simple_you_can_use_letters_and_Arabic_numerals' bundle='${applicationAuResources}' /><br>
			<fmt:message key='gap.authority.Combination_of_length' bundle='${applicationAuResources}' />24<fmt:message key='gap.authority.Characters_within_and_to_distinguish_the_case_of_the_English_alphabet_' bundle='${applicationAuResources}' /></td>
		</tr>
		<tr>
			<td  class="td_1" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Real_Name' bundle='${applicationAuResources}' /></td>
			<td  class="td_2" align="left">
				<input type="text" <%if(!isModify){%>class="text_field_reference_readonly"<%} else {%>class="text_field_readonly"<%}%>
				validate="notNull;" name="name" inputName="<fmt:message key='gap.authority.Real_Name' bundle='${applicationAuResources}' />" maxlength="50" 
				hiddenInputId="party_id"/><input type="hidden" name="party_id"/><%if(!isModify){%><img class="refButtonClass" 
				src="<venus:base/>/images/au/09.gif" onClick="javascript:getOrgTree();"/> 
				<%}%>
			</td>
		</tr>
		
		
		<tr>
			<td  class="td_1" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Login_Account' bundle='${applicationAuResources}' /></td>
			<td  class="td_2" align="left">
				<input type="text" class="text_field" name="login_id" inputName="<fmt:message key='gap.authority.Login_Account' bundle='${applicationAuResources}' />" value="" maxLength="24" validate="notChinese;notNull;" onchange="validateLoginId();"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1" align="right"><span class="style_required_red">* </span>域账号</td>
			<td  class="td_2" align="left">
				<input type="text" class="text_field" name="domain_login_id" id="domain_login_id" inputName="域账号" value="" maxLength="24" validate="notChinese;" />
			</td>
		</tr>
		<tr>
			<td  class="td_1" align="right">供应商</td>
			<td  class="td_2" align="left">
                <w:lookup onReturnFunc="rtnFunc1" lookupWidth="189px" readonly="false" displayValue="${bean.agent_name}" id="lk_cust1" 
                                   lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" dialogTitle="选择供应商" 
                                   height="440" width="710" allowInput="false"/>
                <input type="hidden" name="agent_id" id="agent_id" value="" />
                <input type="hidden" name="agent_name" id="agent_name" value=""/>
			</td>
		</tr>
		<tr>
			<td  class="td_1" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Password' bundle='${applicationAuResources}' /></td>
			<td  class="td_2" align="left">
				<input type="password" class="text_field" name="password" inputName="<fmt:message key='gap.authority.Password' bundle='${applicationAuResources}' />" value="" maxLength="24" validate="notChinese;notNull;"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Password_confirmation' bundle='${applicationAuResources}' /></td>
			<td  class="td_2" align="left">
				<input type="password" class="text_field" name="password2" inputName="<fmt:message key='gap.authority.Password_confirmation' bundle='${applicationAuResources}' />" value="" maxLength="24" validate="notChinese;notNull;"/>
			</td>
		</tr>
		<%if(!isModify){%>
		<tr>
			<td  class="td_1" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Enabled0' bundle='${applicationAuResources}' /></td>
			<td  class="td_2" align="left">
				<input type="radio" name="enable_status" inputName="<fmt:message key='gap.authority.Enabled0' bundle='${applicationAuResources}' />" value="1" checked="checked" /><fmt:message key='gap.authority.Enabled' bundle='${applicationAuResources}' />
				<input type="radio" name="enable_status" inputName="<fmt:message key='gap.authority.Enabled0' bundle='${applicationAuResources}' />" value="0" /><fmt:message key='gap.authority.Disable' bundle='${applicationAuResources}' />
			</td>
		</tr>
		<%} else {%>
		<tr>
			<td  class="td_1" align="right"></td>
			<td  class="td_2" align="left"><input type="hidden" name="enable_status"/></td>
			<td  class="td_2" align="left"></td>
		</tr>
		<%}%>
		<!--tr>
			<td align="right">是否超级管理员</td>
			<td align="left">
				<input type="radio" name="is_admin" inputName="是否超级管理员" value="1"/>是
				<input type="radio" name="is_admin" inputName="是否超级管理员" value="0" checked />否
			</td>
		</tr-->
	</table>
          <p></p>
         
       
        <div class="mx_button">
        <input type="button" class="icon_2" value="保存" onclick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value="返回" onclick="javascript:returnBack()"/>
        </div>
        </div>
	<!--表格 end-->

    </div>
</div>
<input type="hidden" name="is_admin" value="0"/>
<input type="hidden" name="create_date" />
<input type="hidden" name="password1" />
<input type="hidden" name="modify_date" />     
<input type="hidden" name="agent_status" />       
<input type="hidden" name="id" value="" >
<%
	String system_id = (String)request.getAttribute("system_id");
	if(system_id==null || system_id.length()==0) {
		system_id = request.getParameter("system_id");
		if(system_id==null) {
			system_id = "";
		}
	}
	String func_code = (String)request.getAttribute("func_code");
	if(func_code==null || func_code.length()==0) {
		func_code = request.getParameter("func_code");
		if(func_code==null) {
			func_code = "";
		}
	}
%>
<input type="hidden" name="system_id" value="<%=system_id%>">
<input type="hidden" name="func_code" value="<%=func_code%>">
</form>			
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
  		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
  		AuUserVo resultVo = null;  //定义一个临时的vo变量
  		if(request.getAttribute(IAuUserConstants.REQUEST_BEAN_VALUE) != null) {  //如果request中取出的bean不为空
  			resultVo = (AuUserVo)request.getAttribute(IAuUserConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
  		}
  		if(resultVo != null) {  //如果vo不为空
			out.print(VoHelperTools.writeBackMapToForm(VoHelperTools.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
			out.print("writeBackMapToForm();\n");  //输出执行回写方法
			out.print("document.form.password1.value=document.form.password.value;\n");
			out.print("document.form.password2.value=document.form.password.value;\n");  //回写密码确认
		}
		out.print("</script>");  //输出script的声明结束
  	}
%>

