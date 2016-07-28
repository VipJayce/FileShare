<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>政策大表</title>

<script language="javascript">
    function exportEXCEL_onClick(){
         var frm = $id("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          return;
      }
        
        var emp_code = document.getElementById("emp_code").value;
        var emp_name = document.getElementById("emp_name").value;
        var customer_id=$id("lk_clz").getValue();
        var customer_code=document.getElementById("cust_code").value;
        var agent_id=document.getElementById("agent_id").value;
        var agent_code=document.getElementById("agent_code").value;

      var param="emp_code="+emp_code+"&emp_name="+emp_name+"&customer_id="+customer_id+"&customer_code="+customer_code+"&agent_id="+agent_id+"&agent_code="+agent_code;
        url = "<%=request.getContextPath()%>/jsp/faerp/agent/agentreport/showemployee.jsp?raq=agent_employee.raq&"+param;

         window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
        
    }
        //选择客户
 

</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
       writeTableTopFesco('政策大表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title">报表</div>
            <!--表格1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                <td  align="right" class="td_1">         唯一号  </td>
                <td align="left" class="td_2"><input type="text" class="text_field" id="emp_code" name="emp_code"></td>
                   <td  align="right" class="td_1">       姓名  </td>
                <td align="left" class="td_2"><input type="text" class="text_field" id="emp_name" name="emp_name"></td>
                    <td align="right" class="td_1">客户名称</td>
            <td align="left" class="td_2">
                <w:lookup name="cust_name"  id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"  height="440" width="600"  style="width:195px" dialogTitle="选择客户" readonly="false"/>
            </td>
              </tr>
                         <tr>
                <td  align="right" class="td_1">客户编号  </td>
                <td align="left" class="td_2" >  <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="25"/></td>
                   <td  align="right" class="td_1">       供应商名称  </td>
                <td align="left" class="td_2">    <w:lookup readonly="false" id="agent_id"  name="agent_id"
            lookupUrl="/FAERP/AgentAction.do?cmd=getAllagentByCondition" 
            dialogTitle="选择供应商" height="450" width="610"  style="width:195px"/></td>
                    <td align="right" class="td_1">供应商唯一号</td>
            <td align="left" class="td_2" >
             <input type="text" class="text_field" id="agent_code" name="agent_code">
            </td>
              </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    </form>
</body>
</fmt:bundle>
</html>
<script language="javascript">
$id("agent_id").onReturnFunc=function(returnValue){
   var lookup=$id("agent_id");
    lookup.value=returnValue[0];
    lookup.displayValue = returnValue[1];
    return false;
}
 $id("lk_clz").onReturnFunc=function(returnValue){
        var lookup = $id("lk_clz");
        lookup.value = returnValue[0];
        lookup.displayValue = returnValue[2];
            
        return false;
    }
</script>