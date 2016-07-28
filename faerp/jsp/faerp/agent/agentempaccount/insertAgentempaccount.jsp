<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>

<%  //判断是否为修改页面
    AgentempaccountVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IAgentempaccountConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (AgentempaccountVo)request.getAttribute(IAgentempaccountConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
%>
<%@page import="rayoo.agent.agentempaccount.vo.AgentempaccountVo"%>
<%@page import="rayoo.agent.agentempaccount.util.IAgentempaccountConstants"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=isModify?"员工账号修改":"员工账号增加" %></title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据

       var  housing_fund_account=document.getElementById("housing_fund_account").value;
        var  social_security_account=document.getElementById("social_security_account").value;
        var  medical_insurance_account=document.getElementById("medical_insurance_account").value;
               var emp_post_id=document.getElementById("emp_post_id").value;
               if(emp_post_id==null||emp_post_id==""){
               alert("员工名称不能为空");
               return;
               }
                         if(!checkCode(social_security_account)){
                alert("社保账号应为数字");
                document.form.social_security_account.focus();
                return;
            }
                if(!checkCode(housing_fund_account)){
                alert("住房公积金账号应为数字");
                document.form.housing_fund_account.focus();
                return;
            }
                   if(!checkCode(medical_insurance_account)){
                alert("医保账号应为数字");
                document.form.medical_insurance_account.focus();
                return;
            }
        
      
               
           var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/AgentempaccountAction.do?cmd=insert&"+param;
       jQuery.post(url,function(data){
             if(data){
             alert(data);
                 if(data==""){
                      alert('保存失败');
                      return;
                 } else{
              
                 if(data=='ok'){
                    alert("该员工已存在，不能重复添加");
                    return;
                 }
                 else{
                 alert("保存成功");
                 window.close();
                  window.opener.simpleQuery_onClick();
             }
            }
             }else{
                 alert("保存失败");
              return;
                    }
       });
    }

    function update_onClick(id){  //保存修改后的单条数据
     
                var  housing_fund_account=document.getElementById("housing_fund_account").value;
        var  social_security_account=document.getElementById("social_security_account").value;
        var  medical_insurance_account=document.getElementById("medical_insurance_account").value;
               var emp_post_id=document.getElementById("emp_post_id").value;
           
                         if(!checkCode(social_security_account)){
                alert("社保账号应为数字");
                document.form.social_security_account.focus();
                return;
            }
                if(!checkCode(housing_fund_account)){
                alert("住房公积金账号应为数字");
                document.form.housing_fund_account.focus();
                return;
            }
                   if(!checkCode(medical_insurance_account)){
                alert("医保账号应为数字");
                document.form.medical_insurance_account.focus();
                return;
            }
     var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/AgentempaccountAction.do?cmd=update&"+param;
         
        jQuery.post(url,function(data){
    
             if(data){
                 if(data==0){
                      alert('修改失败!');
                      return;
                 }else{
                    alert("修改成功");
                    window.close();
                     window.opener.simpleQuery_onClick();
                 }
                 
             }else{
                      alert('修改失败!');
          return;
                    }
       });
    }

    function cancel_onClick(){  //取消后返回列表页面
     window.close();
    }
      function checkCode(num){
        if(isNaN(num)) {
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
    <div class="xz_title" style="padding-top: 10px">基本信息</div>
<table  width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2"> 
        <tr>
        <td class="td_1" nowrap="nowrap"><span class="style_required_red">*</span>员工姓名</td>
            <td class="td_2 ">
            <%if(isModify){ %>
                  <w:lookup readonly="true" id="select_name"  name="select_name"
                 lookupUrl="/FAERP/AgentempaccountAction.do?cmd=getAgentEmpname" style="width:180px" dialogTitle="选择员工"
                 height="450" width="745" value="${bean.emp_post_id }" displayValue="${bean.emp_name }"  readOnly="true"
                >
                  </w:lookup>
             <%   } else{%>
              <w:lookup readonly="true" id="select_name"  name="select_name"
                 lookupUrl="/FAERP/AgentempaccountAction.do?cmd=getAgentEmpname" style="width:180px" dialogTitle="选择员工"
                 height="450" width="745" value="${bean.emp_post_id }" displayValue="${bean.emp_name }"  
                ></w:lookup>
             <%} %>
              
                <input type="hidden" id="emp_code" name="emp_code">
                 <input type="hidden" id="emp_post_id" name="emp_post_id">
                  <input type="hidden" id="agent_id" name="agent_id">
            </td>
               <td class="td_1" nowrap="nowrap">社保账号</td>
               <td class="td_2 ">
                <input type="text" class="text_field" name="social_security_account" id="social_security_account" inputName="社保账号" value="${bean.social_security_account }" maxLength="50"  />
            </td>
        </tr>
    
        <tr>
               <td class="td_1" nowrap="nowrap">住房公积金账号</td>
               <td class="td_2 ">
                <input type="text" class="text_field" name="housing_fund_account" id="housing_fund_account" inputName="住房公积金账号" value="${bean.housing_fund_account }" maxLength="50"  />
            </td>
                 <td class="td_1" nowrap="nowrap">医保账号</td>
               <td class="td_2 ">
                <input type="text" class="text_field" name="medical_insurance_account" id="medical_insurance_account" inputName="医保账号" value="${bean.medical_insurance_account }" maxLength="50"  />
            </td>
        </tr>
    </table>
</div>
    <div class="foot_button" >
        <input type="button" id="save1" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>           
</div>     
<input type="hidden" name="id" value="">
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
$id("select_name").onReturnFunc = function (returnValue){
    var lookup = $id("select_name");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[3];
    _$("#emp_post_id").val(returnValue[0]);
     _$("#emp_code").val(returnValue[1]);
      _$("#agent_id").val(returnValue[2]);
    return false;
}
</script>
