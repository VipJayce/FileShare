<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.policy.vo.PolicyVo" %>
<%@ page import="rayoo.insurance.policy.util.IPolicyConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<html>
<fmt:bundle basename="rayoo.employeepost.eppartyact.eppartyact_resource" prefix="rayoo.employeepost.eppartyact.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    function exportError()
    {
      if(confirm('<fmt:message key="is_sure_exp_error_info"/>')) {
	      form.action="<%=request.getContextPath()%>/cmd=exportToExcelByError";
	      form.submit();
      }
    }
</script>
</head>
<body>

<form name="form"  id="datacell_formid" method="post">
<div id="right">
<div class="button_right">
        <!--<ul>
          <li class="e"><a onClick="javascript:exportError();">导出错误</a></li>
        </ul>
        --></div>
        <div class="clear"></div>
    <div style="margin: 0px;">
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartyactitemAction.do?cmd=queryErrorList"
        width="100%"
        xpath="EppartyactitemVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="error_id" width="215px" messagekey="error_id" >
       </r:field>
       <r:field fieldName="error_desc" width="500px" messagekey="error_discription" >
       </r:field>        
    </r:datacell>
    </div>
    </div>
    <div class="mx_button"  style="text-align: center; margin-top: 10px;">
        <input type="button" class="icon_2" value='<fmt:message key="close"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
       </div> 
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
