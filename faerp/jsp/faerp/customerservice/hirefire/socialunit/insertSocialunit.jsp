<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.hirefire.socialunit.vo.SocialunitVo" %>
<%@ page import="rayoo.customerservice.hirefire.socialunit.util.ISocialunitConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	SocialunitVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISocialunitConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SocialunitVo)request.getAttribute(ISocialunitConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.socialunit.insertSocialunit_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/SocialunitAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/SocialunitAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SocialunitAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
      //查询<fmt:message key='insertSocialunit0011'/>名称
    function getSupplierList(){
        var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.agent_id.value=ids[0];
        document.form.agent_name.value=ids[1];
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
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key='insertSocialunit0011'/></td>
			<td class="td_2 ">
<!--				<input type="text" class="text_field" name="agent_id" inputName="<fmt:message key='insertSocialunit0012'/>" value="" maxLength="9.5" />-->
				 <input type="hidden" name="agent_id"   value=""/>
                <input type="text" class="text_field_reference_readonly"  validate="notNull;" hiddenInputId="agent_id"  name="agent_name" inputName="<fmt:message key='insertSocialunit0013'/>"  maxLength="10" value=""/>
                 <img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getSupplierList();"/>
			</td>
			 <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='insertSocialunit0014'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="hire_unit_real_name" inputName="<fmt:message key='insertSocialunit0014'/>" validate="notNull;"  value="" maxLength="50" />
            </td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key='insertSocialunit0016'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hire_unit_short_name" validate="notNull;"  inputName="<fmt:message key='insertSocialunit0016'/>" value="" maxLength="50" />
			</td>
			<td class="td_1" ><fmt:message key='insertSocialunit0018'/></td>
            <td class="td_2" >
                <%=RmJspHelper.getSelectField("is_indie_bd", -1,"TrueOrFalse",isModify ? resultVo.getIs_indie_bd() : "1","",true) %> 
            </td>
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
</fmt:bundle>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
