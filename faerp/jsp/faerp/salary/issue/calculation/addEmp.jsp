<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.issue.calculation.calculation_resource" prefix="rayoo.salary.issue.calculation.">
<head>
<base target="_self"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='add_salary_data'/></title>
<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/editbatch.js"></script>
<script type="text/javascript">
    var venusbase = "<%=request.getContextPath()%>";
</script>
</head>
<body>
<form name="form" method="post"  id="datacell_formid">
    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="right" width="25%"><fmt:message key='emp_code_'/>:</td>
          <td align="left" width="25%">
            <input type="text" class="text_field" style="width: 100px;" name="emp_code" id="emp_code"/>
          </td>
          <td align="right" width="25%"><fmt:message key='emp_name_'/>:</td>
          <td align="left" width="25%">
            <input type="text" class="text_field" style="width: 100px;" name="emp_name" id="emp_name"/>
          </td>
        </tr>
         <tr>
            <td align="right"></td>
            <td align="left">
            </td>
            <td align="right"></td>
            <td align="left"><input name="button_ok" class="icon_1" type="button" value='<fmt:message key='button_search'/>' onClick="searchEmp();"></td>
         </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
	    <ul>
	        <li class="g">
	          <a onClick="javascript:select_onClick();"><fmt:message key='button_confirm'/></a>
	        </li>
	    </ul>
    </div>
    <div class="clear"></div>
  </div>
  <input type="hidden" name="sa_class_id" value="${sa_class_id }"/>
  <input type="hidden" name="sa_batch_id" value="${batch_id }"/>
  <input type="hidden" name="new_add_emp" value="${new_add_emp }"/>
  <div  id="div1" style="margin:5 0 0 10px;">
        <r:datacell 
	        queryAction="/FAERP/SalarydataAction.do?cmd=query4AddEmp"
	        id="emplistcelllist"
	        paramFormId="datacell_formid" 
	        width="97%" height="305px" 
	        xpath="PB_EMPLOYEEVo"
	        readonly="true"
	        >
	      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	<r:field allowModify="false" fieldName="chk"
		label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
		sortAt="none" width="30px">
		<h:switchCheckbox name ="chk" id="chk" checkedValue="1" uncheckedValue="0"  />
		<!-- 为什么switchcheckbox的name和id不显示？ -->
	</r:field>
	      <!--<r:field fieldName="id" label="ID" width="130px"></r:field> -->
	      <r:field fieldName="emp_code" messagekey="emp_code_" width="200px"></r:field>
	      <r:field fieldName="emp_name" messagekey="emp_name_" width="240px">
	      </r:field>
      </r:datacell>
  </div>
</form>
</body>
</fmt:bundle>
</html>

