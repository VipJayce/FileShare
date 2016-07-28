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
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function exportError()
    {
      if(confirm('是否确定要导出错误信息？')) {
	      form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=exportToExcelByError";
	      form.submit();
      }
    }
</script>
</head>
<body>

<form name="form"  id="datacell_formid" method="post">
<div id="right">
<div class="button_right">
        <ul>
          <li class="e"><a onClick="javascript:exportError();">导出错误</a></li>
        </ul>
        </div>
        <div class="clear"></div>
    <div style="margin: 0px;">
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/SettlementclaimAction.do?cmd=queryErrorList"
        width="100%"
        xpath="SettlementclaimVo"
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="error_id" width="215px" label="错误ID" >
       </r:field>
       <r:field fieldName="error_desc" width="500px" label="错误描述" >
       </r:field>        
    </r:datacell>
    </div>
    </div>
    <div class="mx_button"  style="text-align: center; margin-top: 10px;">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
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
