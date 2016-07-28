<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="credentials_erroneous_information"/></title>
<script language="javascript">
  function simpleQuery_onClick(){
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    function export_onClick(){
    var employee_name=document.getElementById("employee_name").value;
    var emp_card_no=document.getElementById("emp_card_no").value;
    var credentials_type=document.getElementById("credentials_type").value;
    $id("datacell_formid").action="<%=request.getContextPath()%>/CredentialsAction.do?cmd=exportErrorInfo&employeename="+employee_name+"&empcardno="+emp_card_no+"&credentialstype="+credentials_type;
    $id("datacell_formid").submit();
    }
</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="credentials_erroneous_information_select"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 

<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="157" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="Query_conditions"/></div> </td>
        </tr>
                <tr>
            <td align="right"><fmt:message key="employee_name"/></td>
            <td align="left"><input type="text" class="text_field" id="employee_name" name="employee_name" inputName="员工姓名" maxLength="50"/>            </td>
               <td align="right"><fmt:message key="emp_card_no1"/></td>
          <td align="left"><input type="text" class="text_field" id="emp_card_no" name="emp_card_no" inputName="身份证号码" maxLength="20"/>          </td>
        </tr>
        <tr>
           <td align="right"><fmt:message key="credentials_type"/></td>
            <td align="left"><input type="text" class="text_field" id="credentials_type" name="credentials_type" inputName="证件类型" maxLength="50"/>            </td>
          <td align="right"></td>
            <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
        </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                  <li class="e">    <a href="#" onClick="javascript:export_onClick();"><fmt:message key="leading_out"/></a></li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>


<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/CredentialsAction.do?cmd=queryerrorCredentials"
        width="98%"
        height="320px"
        xpath="CredentialsErrorVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="employee_name" messagekey="employee_name1">
            <h:text/>
          </r:field>
          <r:field fieldName="emp_card_no"  width="150px" messagekey="emp_card_no1">
            <h:text/>
          </r:field>
             <r:field fieldName="cust_name" messagekey="cust_name" width="200px">
            <h:text/>
          </r:field>
          <r:field fieldName="credentials_type" messagekey="credentials_type"  width="100px">
               <h:text/>
           </r:field>
           <r:field fieldName="credentials_status" messagekey="credentials_type_state" width="150px">
               <h:text/>
           </r:field>
           <r:field fieldName="validity" messagekey="validity" width="100px">
                <w:date format="yyyy-MM-dd"/>
           </r:field>
          <r:field fieldName="remark" messagekey="remark" width="200px">
               <h:text/>
           </r:field>
             <r:field fieldName="error_info" messagekey="error_info" width="200px">
               <h:text/>
           </r:field>
             <r:field fieldName="import_date" messagekey="import_date" width="100px">
               <w:date format="yyyy-MM-dd"/>
           </r:field>
    </r:datacell>
 
    </div>
    <div class="foot_button">
        <input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>' onclick="location.href='javascript:history.go(-1);'" />
   </div>
   
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>