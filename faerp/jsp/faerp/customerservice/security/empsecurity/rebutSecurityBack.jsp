<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.rebutSecurityBack_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='rebutSecurityBack0000'/></title>
</head>
<body>

<%

EmppostVo vo = (EmppostVo)request.getAttribute("emppostvo");
String id = RmStringHelper.prt(vo.getEmp_post_id());
String security_group_id = (String)request.getAttribute("security_group_id");

%>


<script language="javascript">
    function submit_onClick(){
        var reason = jQuery("#reason").val();
        if(reason==null || reason==''){
            alert('<fmt:message key='rebutSecurityBack0001'/>');
            return;
        }
        var action = "";
        if("${type}" == "2"){//修改审批驳回
            action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toRebutModifyBack";
        }else{//变更审批驳回
            action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toRebutBack";
        }
        var myAjax = new Ajax(action);
        myAjax.addParam("id", jQuery("#id").val());
        myAjax.addParam("group_id", jQuery("#group_id").val());
        myAjax.addParam("reason", reason);
        if("${type}" == "2"){
            myAjax.addParam("change_type", "${change_type}");
            myAjax.addParam("cancleModifySubUser", "${cancleModifySubUser}");
        }
          
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
             if( myAjax.getValue("root/data/returnValue") == 1 ) {
                  if("${type}" == "2"){//修改审批驳回
                      alert('<fmt:message key='rebutSecurityBack0010'/>');
                      returnValue = '1';
		          }else{//变更审批驳回
		              alert('<fmt:message key='rebutSecurityBack0002'/>');
	                  returnValue = '1';
		          }
                  window.close();
             } else {
                  alert('<fmt:message key='rebutSecurityBack0000'/>保存失败，请确认该申报变更状态！'); 
                  returnValue = '0';
                  window.close();
             }
        }
    }
   
</script>

<form name="form" method="post" id="datacell_formid">
      <input type="hidden" id="id" name="id" value="<%=id %>"/>
      <input type="hidden" id="group_id" name="group_id" value="<%=security_group_id %>"/>
    <div id="right">
    <script language="javascript">
        writeTableTopFesco('输入<fmt:message key='rebutSecurityBack0008'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="box_xinzeng" style="margin:0px;">
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
        <tr>
            <td height="39" align="right" width="150" class="td_1"><fmt:message key='rebutSecurityBack0005'/>:
            </td>
            <td align="left" class="td_2"><%=RmStringHelper.prt(vo.getEmp_name()) %></td>
        </tr>
        <tr>
            <td height="39" class="td_1" align="right"><fmt:message key='rebutSecurityBack0006'/>:
            </td>
            <td align="left" class="td_2"><%=RmStringHelper.prt(vo.getEmp_code()) %></td>
        </tr>
        <tr>
            <td height="39" class="td_1" align="right"><fmt:message key='rebutSecurityBack0007'/>:
            </td>
            <td align="left" class="td_2"><%=RmStringHelper.prt(vo.getHire_unit_short_name())%></td>
        </tr>
        <tr>
            <td height="39" class="td_1" align="right"><fmt:message key='rebutSecurityBack0008'/>:
            </td>
            <td align="left" class="td_2">
                <textarea id="reason" name="reason" rows="5" cols="50"></textarea>
            </td>
        </tr>
        <tr>
            <td height="39" class="td_2" colspan="2" align="center">
                <input name="button_ok" class="icon_1" type="button" value='<fmt:message key='rebutSecurityBack0009'/>' onClick="javascript:submit_onClick()">
            </td>
        </tr>
    </table>
</div>
</div>
</form>
</body>
</fmt:bundle>
</fmt:bundle>
</html>
