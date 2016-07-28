<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.agent.vo.AgentVo"%>
<%@ page import="rayoo.sales.agent.util.IAgentConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<%  //判断是否为修改页面
	AgentVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IAgentConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (AgentVo)request.getAttribute(IAgentConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
	
	String seq_AgentCode = request.getAttribute("code")==null ? "" : request.getAttribute("code").toString();
%>
<html>
<fmt:bundle basename="rayoo.salse.agent.agent_resource" prefix="rayoo.salse.agent.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script type="text/javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    var agent_code=document.form.agent_code.value;
	    var agent_name=document.form.agent_name.value;
	    var agent_type=document.form.agent_type.value;
	    //var city_id=document.form.city_id.value;
	    //var agent_en_name=document.formagent_en_name.value;
	    //var contact_tel1=document.form.contact_tel1.value;
	    //var contact_tel2=document.form.contact_tel2.value;
	    var email=document.form.email.value;
	    //var fax=document.form.fax.value;
	    var zip_code=document.form.zip_code.value;
	    var reckoning_zip_code1=document.form.reckoning_zip_code1.value;
	    var reckoning_zip_code2=document.form.reckoning_zip_code2.value;
	    var bank_account1=document.form.bank_account1.value;
	    var bank_account2=document.form.bank_account2.value;
	    if(agent_code==""||agent_code==null){
            alert(" <fmt:message key='agent_code_not_null'/>");
            return;
        }
	    if(agent_name==""||agent_name==null){
            alert(" <fmt:message key='agent_name_not_null'/>");
            document.form.agent_name.focus();
            return;
        }
	    if(agent_type==""||agent_type==null){
            alert(" <fmt:message key='agent_type_not_null'/>");
            document.form.agent_type.focus();
            return;
        }
//	    if(city_id==""||city_id==null){
//            alert(" <fmt:message key='city_id_not_null'/>");
//            document.form.city_id.focus();
//            return;
//        }
        if(email!=null&&email!=""){
            if(!checkEmail(email)){
                alert("<fmt:message key='right_zip_code'/>");
                document.form.email.focus();
                return;
            }
        }
        if(zip_code!=null&&zip_code!=""){
            if(!checkCode(zip_code)){
                alert("<fmt:message key='zip_code_number'/>");
                document.form.zip_code.focus();
                return;
            }
        }
        if(reckoning_zip_code1!=null&&reckoning_zip_code1!=""){
            if(!checkCode(reckoning_zip_code1)){
                alert("<fmt:message key='zip_code_number'/>");
                document.form.reckoning_zip_code1.focus();
                return;
            }
        }
        if(reckoning_zip_code2!=null&&reckoning_zip_code2!=""){
            if(!checkCode(reckoning_zip_code2)){
                alert("<fmt:message key='zip_code_number'/>");
                document.form.reckoning_zip_code2.focus();
                return;
            }
        }
        if(bank_account1!=null&&bank_account1!=""){
            if(!checkNum(bank_account1)){
                alert("<fmt:message key='bank_account_number'/>");
                document.form.bank_account1.focus();
                return;
            }
        }
        if(bank_account2!=null&&bank_account2!=""){
            if(!checkNum(bank_account2)){
                alert("<fmt:message key='bank_account_number'/>");
                document.form.bank_account2.focus();
                return;
            }
        }
        var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/AgentAction.do?cmd=insert&code="+agent_code+"&"+param;
       jQuery.post(url,function(data){
             if(data){
                 if(data=="false"){
                      alert('<fmt:message key='same_date'/>');
                      return;
                    }
                 } else{
                 alert("<fmt:message key='operation_over'/>");
                 window['returnValue'] = [''];
                 window.close(); //关闭
             }
       });
	}

  	function update_onClick(id){  //保存修改后的单条数据
  	    var agent_code=document.form.agent_code.value;
        var agent_name=document.form.agent_name.value;
        var agent_type=document.form.agent_type.value;
        //var city_id=document.form.city_id.value;
        //var agent_en_name=document.formagent_en_name.value;
        //var contact_tel1=document.form.contact_tel1.value;
        //var contact_tel2=document.form.contact_tel2.value;
        var email=document.form.email.value;
        //var fax=document.form.fax.value;
        var zip_code=document.form.zip_code.value;
        var reckoning_zip_code1=document.form.reckoning_zip_code1.value;
        var reckoning_zip_code2=document.form.reckoning_zip_code2.value;
        var bank_account1=document.form.bank_account1.value;
        var bank_account2=document.form.bank_account2.value;
        if(agent_code==""||agent_code==null){
            alert(" <fmt:message key='agent_code_not_null'/>");
            return;
        }
        if(agent_name==""||agent_name==null){
            alert(" <fmt:message key='agent_name_not_null'/>");
            document.form.agent_name.focus();
            return;
        }
        if(agent_type==""||agent_type==null){
            alert("  <fmt:message key='agent_type_not_null'/>");
            document.form.agent_type.focus();
            return;
        }
//        if(city_id==""||city_id==null){
//            alert(" <fmt:message key='city_id_not_null'/>");
//           document.form.city_id.focus();
//            return;
//        }
        if(email!=null&&email!=""){
            if(!checkEmail(email)){
                alert("<fmt:message key='right_zip_code'/>");
                document.form.email.focus();
                return;
            }
        }
        if(zip_code!=null&&zip_code!=""){
            if(!checkCode(zip_code)){
                alert("<fmt:message key='zip_code_number'/>");
                document.form.zip_code.focus();
                return;
            }
        }
        if(reckoning_zip_code1!=null&&reckoning_zip_code1!=""){
            if(!checkCode(reckoning_zip_code1)){
                alert("<fmt:message key='zip_code_number'/>");
                document.form.reckoning_zip_code1.focus();
                return;
            }
        }
        if(reckoning_zip_code2!=null&&reckoning_zip_code2!=""){
            if(!checkCode(reckoning_zip_code2)){
                alert("<fmt:message key='zip_code_number'/>");
                document.form.reckoning_zip_code2.focus();
                return;
            }
        }
        if(bank_account1!=null&&bank_account1!=""){
            if(!checkNum(bank_account1)){
                alert("<fmt:message key='bank_account_number'/>");
                document.form.bank_account1.focus();
                return;
            }
        }
        if(bank_account2!=null&&bank_account2!=""){
            if(!checkNum(bank_account2)){
                alert("<fmt:message key='bank_account_number'/>");
                document.form.bank_account2.focus();
                return;
            }
        }
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var param = jQuery("#datacell_formid").serialize();
    	var url="<%=request.getContextPath()%>/AgentAction.do?cmd=update&"+param;
        jQuery.post(url,function(data){
             if(data){
                 if(data!="1"){
                      alert('<fmt:message key='modify_false'/>');
                      return;
                 }
             }
       });
       window['returnValue'] = [''];
       window.close(); //关闭
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function checkNum(num){
	    if(isNaN(num)) {
	        return false;
	    }
	    if(num.match(/\d/g).length<12||num.match(/\d/g).length>20){
	        return false;
	    }
	    return true;
	} 
    function checkCode(num){
	    if(isNaN(num)) {
	        return false;
	    }
	    if(num.match(/\d/g).length!=6){
	        return false;
	    }
	    return true;
	}
	function checkEmail(s){ 
		var pattern =/^[a-zA-Z0-9_\-]{1,}@[a-zA-Z0-9_\-]{1,}\.[a-zA-Z0-9_\-.]{1,}$/;
		if(!pattern.exec(s)){
		  return false;
		}
		return true;    
    }
    
</script>
	</head>
	<body>

	<form name="form" method="post" id="datacell_formid">

	<div id="right">

	<div class="ringht_x">
	<div id="ccChild0" class="box_3">
	<table width="100%" height="313" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">

		<tr>
			<td width="20%" class="td_1"><span class="style_required_red">*
			</span><fmt:message key='agent_code'/></td>
			<td width="29%" class="td_2 "><input type="text"
				class="text_field" name="agent_code" inputName="供应商编号"
				value="<%=seq_AgentCode %>" maxLength="25" /></td>
			<td width="20%" class="td_1"><span class="style_required_red">*
			</span><fmt:message key='agent_name'/></td>
			<%if(isModify){ %>
			<td width="31%" class="td_2 "><input type="text"
				class="text_field" name="agent_name" inputName="供应商名称" value=""
				maxLength="50"/></td>
			<%}else{ %>
			<td width="31%" class="td_2 "><input type="text"
                class="text_field" name="agent_name" inputName="供应商名称" value=""
                maxLength="50"/></td>
			<%} %>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='agent_en_name'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="agent_en_name" inputName="供应商英文名称" value="" maxLength="50" />
			</td>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key='agent_type'/></td>
			<td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("agent_type", -1, "AGENT_TYPE", "", " style='width:200px'", false) %>
			</td>
		</tr><%--
		<tr>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key='city_id'/></td>
			<td class="td_2">
			     <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       property="bean/city_id"
                       messagekey="please_choose" />
			     <faerp:cityTag beanname="bean" attribute="city_id" tagname="city_id" style="width:205px"/>
			</td>
			<td class="td_1"><fmt:message key='corporation'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="corporation" inputName="法人" value="" maxLength="50" /></td>
		</tr>
		--%><tr>
			<td class="td_1"><fmt:message key='tax_registration_number'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="tax_registration_number" inputName="税务登记号" value=""
				maxLength="25" /></td>
			<td class="td_1"><fmt:message key='contact_dept'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="contact_dept" inputName="联系部门" value="" maxLength="25" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='contact_person'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="contact_person" inputName="联系人" value="" maxLength="50" /></td>
			<td class="td_1"><fmt:message key='contact_tel1'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="contact_tel1" inputName="联系电话1" value="" maxLength="13"/></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='contact_tel2'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="contact_tel2" inputName="联系电话2" value="" maxLength="13" /></td>
			<td class="td_1">EMAIL</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="email" inputName="EMAIL" value="" maxLength="50"/></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='fax'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="fax" inputName="传真" value="" maxLength="13" /></td>
			<td class="td_1"><fmt:message key='contact_address'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="contact_address" inputName="联系地址" value="" maxLength="75" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='zip_code'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="zip_code" inputName="邮编" value="" maxLength="10"/></td>
			<td class="td_1"><fmt:message key='reckoning_address1'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="reckoning_address1" inputName="帐单地址1" value="" maxLength="75" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='reckoning_address_code1'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="reckoning_zip_code1" inputName="帐单地址邮编1" value=""
				maxLength="50" /></td>
			<td class="td_1">开户名</td>
			<td class="td_2 "><input type="text" class="text_field"
				name="reckoning_address2" inputName="开户名" value="" maxLength="75" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='reckoning_address_code2'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="reckoning_zip_code2" inputName="帐单地址邮编2" value=""
				maxLength="50" /></td>
			<td class="td_1"><fmt:message key='bank1'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="bank1" inputName="开户银行1" value="" maxLength="50" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='bank_account1'/></td>
			<td class="td_2 "><input type="text" class="text_field" name="bank_account1" inputName="银行帐户1" value="" maxLength="20" /></td>
			<td class="td_1"><fmt:message key='bank2'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="bank2" inputName="开户银行2" value="" maxLength="50" /></td>
		</tr>
		<tr>
			<td height="19" class="td_1"><fmt:message key='bank_account2'/></td>
			<td class="td_2 "><input type="text" class="text_field"
				name="bank_account2" inputName="银行帐户2" value="" maxLength="20" />
		    </td>
		    <td class="td_1"><fmt:message key='corporation'/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="corporation" inputName="法人" value="" maxLength="50" />
            </td>
			<!--  <td class="td_2"></td>
			<td class="td_2"></td> -->
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='remark'/></td>
			<td colspan="3" class="td_2"><textarea style="width: 742px" rows="2" name="remark" inputName="备注"></textarea></td>
		</tr>
	</table>

	<div class="foot_button"><input type="button" class="foot_icon_1"
		value='<fmt:message key="save"/>'
		onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
	<input type="button" class="foot_icon_1"
		value='关闭'
		onClick="javascript:cancel_onClick()" /></div>
	</div>

	<input type="hidden" name="id" value=""> <input type="hidden"
		name="create_date" />
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
