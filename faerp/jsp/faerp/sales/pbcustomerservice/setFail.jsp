<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.*" %>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="emp_entry"/>设置失效日期</title>
<script language="javascript">
  	function update_onClick(){  //保存修改后的单条数据
        var invalid_date = document.getElementById("invalid_date").value;
        if(invalid_date==null || invalid_date==''){
            alert("请输入失效日期！");
            return;
        }
       if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
       }
       var id = jQuery("#id").val();  
       var url = "<%=request.getContextPath()%>/PbcustomerserviceAction.do?cmd=setFailDate&ids="+id+"&validate="+invalid_date;
       jQuery.post(url,function(sum){
            if(sum!=null && sum!=''&&sum != '0'&&sum != '-1' ) {
                alert("失效日期设置成功！");
                window.close(); //关闭
                window.opener.changeQuery();
            } 
            else if(sum == '-1' ) {
                alert("失效日期不能小于生效日期！");
                return false;
            }else if(sum == '0') {
                alert("失效日期设置失败！");
                return false;
            }
      });
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
        writeTableTopFesco("设置失效日期",'<%=request.getContextPath()%>/');
</script>
 <div class="ringht_s">
<div id="ccChild0" class="box_3">
<table height="40" width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="50%">失效日期</td>
			<td class="td_2" width="50%">
			     <w:date format="yyyy-MM-dd" id="invalid_date" name="invalid_date" width="198px"/></br>
			     <input type="hidden" class="text_field" id="id" name="id" value="${param.id }">
			</td>
		</tr>
	</table>
    </div>
    <div class="foot_button">
        <input type="button" class="foot_icon_1" value="设置" onClick="javascript:update_onClick()" />
        <input type="button" class="foot_icon_1" value="<fmt:message key="close"/>"  onClick="javascript:cancel_onClick()"/>
      </div>
</div>         
</form>
</fmt:bundle>
</body>
</html>
