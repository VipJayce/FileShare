<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>

<%String custId = request.getAttribute("customer_id")!=null? request.getAttribute("customer_id").toString() : ""; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.employeepost.empentry.empsendinfo.empsendinfo_resource" prefix="rayoo.employeepost.empentry.empsendinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<h:script src="/jsp/faerp/employeepost/empentry/empsendinfo/addEmpSend.js"/> 
<script language="javascript">
var vpath = "<%=request.getContextPath()%>";
</script>

<title><fmt:message key="add_emp"/></title>

</head>
<body>
<form name="empSendForm" method="post" id="empSendForm"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key="add_emp_entry"/></div>
	</div>
    <div class="ringht_s">
   	<!--表格2-->
    <div class="box_3">
    	<div class="xz_title"><fmt:message key="is_send"/></div>
		<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key="send_name"/></td>
            <td class="td_2"><input readonly name="sendName" type="text" class="text_field" id="text" style="width:320px" value="${sendName }"/></td>
            <input id="hid_sendID" type="hidden" name="sendID" value="${sendID }"/>
            <input id="hid_custID" type="hidden" name="custId" value="<%=custId %>"/>
          </tr>
        </table>
    </div>
    <!--表格2 end-->
    <table width="99%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="45%">
			<div class="zbox">
				<div class="xz_title"><fmt:message key="is_quotation"/></div>
				<!--按钮-->
				<div class="button">
					<div class="button_right">
						<ul>   	
							<li class="c" style="padding-top:7px;"><a id="addbaojia" href="###" );"><fmt:message key="add"/></a></li>
							<li class="d" style="padding-top:7px;"><a id="delbaojia"><fmt:message key="delete"/></a></li>
						</ul>
						<div class="clear"></div>
					</div>
				</div>
			<!--按钮 end-->
			
			<!--报价单表格 -->
			<r:datacell 
		              id="dc_quo"
		              queryAction="/FAERP/EmpSendInfoAction.do?cmd=qryQuos"
		              submitAction="/FAERP/EmpSendInfoAction.do?cmd=update"
		              width="100%"
		              xpath="EmpSendDTO"
		              submitXpath="EmpSendDTO"
		              paramFormId="empSendForm"
		              pageSize="100"
		              >
	              
	      
	              <r:field width="200px" fieldName="quo_code" messagekey="quotation_code" >
	              </r:field>
	              <r:field width="270px" fieldName="quo_name" messagekey="quotation_name">
	              </r:field>
	              
	        </r:datacell>
			<!--报价单表格 end-->
			</div>
		</td>
	
		<td>&nbsp;</td>
	
		<td>
			<div class="zbox">
			<div class="xz_title"><fmt:message key="employee"/></div>
			<!--按钮-->
			<div class="button">
				<div class="button_right">
					<ul>
						<li class="c" style="padding-top:7px;"><a id="a_emp_add" href="###"><fmt:message key="add"/></a></li>
						<li class="d" style="padding-top:7px;"><a id="a_emp_del"><fmt:message key="delete"/></a></li>
					</ul>
					 <div class="clear"></div>
				</div>
			   
			</div>
			<!--按钮 end-->	
			<!--员工表格 -->
			<input id="h_quo_id" type="hidden" name="quotID" value="${quotID }"/>
			<r:datacell 
		              id="dc_emp"
		              queryAction="/FAERP/EmpSendInfoAction.do?cmd=qryQuoEmps"
		              submitAction="/FAERP/EmpSendInfoAction.do?cmd=saveAll"
		              width="100%"
		              xpath="EmpSendDTO"
		              submitXpath="EmpSendDTO"
		              paramFormId="empSendForm"
		              pageSize="1000"
		              >
	              
	      
	              <r:field width="70px" fieldName="emp_name" messagekey="employee_name" allowModify="false">
	              	<h:text validateAttr="maxLength=100;allowNull=false"/>
	              </r:field>
	              <r:field width="70px" fieldName="emp_code" messagekey="emp_unique_num" allowModify="false">
	              	<h:text validateAttr="maxLength=50;allowNull=true"/>
	              </r:field>
	              <r:field width="100px" fieldName="id_card_type" messagekey="id_card_type"  allowModify="false">
	              	<d:select dictTypeId="ID_CARD_TYPE_BD" extAttr="validateAttr='allowNull=false'"/>
	              </r:field>
	              <r:field width="180px" fieldName="id_card" messagekey="id_card" allowModify="false">
	              	<h:text validateAttr="type=checkIdcard;maxLength=20;allowNull=false"/>
	              </r:field>
	        </r:datacell>
			<!--员工表格 end-->
			</div>
		</td>
	</tr>
	</table>
	<div class="foot_button">
          <input id="btn_submit" type="button" class="foot_icon_1" value="<fmt:message key="save"/>"/>
          <!-- <input type="button" class="foot_icon_1" value="返回" onClick="javascript:history.go(-1);"/>-->
          <input type="button" class="foot_icon_1" value="<fmt:message key="close"/>" onClick="javascript:window.close();"/>
    </div>
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
