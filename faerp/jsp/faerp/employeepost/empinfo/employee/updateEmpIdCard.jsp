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
<title><fmt:message key="emp_entry"/>修改证件号</title>
<script language="javascript">
  	function update_onClick(){  //保存修改后的单条数据
        var show_id_card = jQuery("#show_id_card").val();
        if(show_id_card==null || show_id_card==''){
            alert("<fmt:message key="please_check_in_id_card_num"/>");
            return;
        }
       if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
       }
       var id_card = jQuery("#id_card").val();
       var id_card_type_bd = jQuery("#id_card_type_bd").val();
       var id = jQuery("#id").val(); 
       var emp_code = jQuery("#emp_code").val();   
       var emp_name = jQuery("#emp_name").val();      
       var phoenix_emp_id = jQuery("#phoenix_emp_id").val();       
       var url = "<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=updateIdCard&show_id_card="+show_id_card+"&id_card="+id_card+"&id_card_type_bd="+id_card_type_bd+"&id="+id+"&phoenix_emp_id="+phoenix_emp_id+"&emp_code="+emp_code+"&emp_name="+emp_name;
       var sums = new Array();
       jQuery.post(url,function(sum){
       		sums = sum.split(",");
            if(sums[0] == '1' ) {
                alert("<fmt:message key="emp_info_save_succese"/>");
                window.close(); //关闭
                window.opener.simpleQuery_onClick();
            } 
            else if(sums[0] == '3' ) {
                alert("<fmt:message key="please_again_check_in_emp_card"/>");
                jQuery("#show_id_card").val(id_card);
                return false;
            } 
            else if(sums[0] == '4' ) {
                alert("<fmt:message key="please_again_check_in_emp_id_card"/>");
                 jQuery("#show_id_card").val(id_card);
                return false;
            }
            else if(sums[0] == '5' ) {
                alert(sums[1]);
                 jQuery("#show_id_card").val(id_card);
                return false;
            }
            else {
                alert("<fmt:message key="emp_id_card_update_error"/>"); 
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
        writeTableTopFesco("<fmt:message key="update_credentials"/>",'<%=request.getContextPath()%>/');
</script>
 <div class="ringht_s">
<div id="ccChild0" class="box_3">
<table height="40" width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="50%"><fmt:message key="id_card"/></td>
			<td class="td_2" width="50%">
			     <input type="text" class="text_field" id="show_id_card" name="show_id_card" value="${param.id_card }" />
			     <input type="hidden" class="text_field" id="id_card" name="id_card" inputName="证件号码" value="${param.id_card }"/>
			     <input type=hidden class="text_field" id="id_card_type_bd" name="id_card_type_bd" value="${param.id_card_type_bd }">
			     <input type="hidden" class="text_field" id="id" name="id" value="${param.id }">
			     <input type="hidden" class="text_field" id="emp_code" name="emp_code" value="${param.emp_code }">
			     <input type="hidden" class="text_field" id="emp_name" name="emp_code" value="${param.emp_name }">
			     <input type="hidden" class="text_field" id="phoenix_emp_id" name="phoenix_emp_id" value="${param.phoenix_emp_id }">
			</td>
		</tr>
	</table>
    </div>
    <div class="foot_button">
        <input type="button" class="foot_icon_1" value="<fmt:message key="update"/>" onClick="javascript:update_onClick()" />
        <input type="button" class="foot_icon_1" value="<fmt:message key="close"/>"  onClick="javascript:cancel_onClick()"/>
      </div>
</div>         
</form>
</fmt:bundle>
</body>
</html>
