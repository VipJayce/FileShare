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
<fmt:bundle basename="rayoo.employeepost.empinfo.epempimperr.epempimperr_resource" prefix="rayoo.employeepost.empinfo.epempimperr.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="emp_imp_err_page"/></title>
<script language="javascript">
    function simpleQuery_onClick(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function back_onClick(){
        $id("datacell_formid").action = "<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryAll";
        $id("datacell_formid").submit();
    }
</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key="look_emp_imp_err"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
			<td width="157" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
		</tr>
				<tr>
			<td align="right"><fmt:message key="emp_code"/></td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>			</td>
			<td align="right"><fmt:message key="emp_name"/></td>
			<td align="left"><input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="50"/>            </td>
		</tr>
		<tr>
		  <td align="right"><fmt:message key="emp_card_no1"/></td>
		  <td align="left"><input type="text" class="text_field" name="id_card1" inputName="身份证号码" maxLength="20"/>          </td>
			<td align="right"><fmt:message key="imp_date"/></td>
			<td align="left">
			     <w:date format="yyyy-MM-dd" id="imp_date_from" name="imp_date_from" width="80px"/>&nbsp;<fmt:message key="to"/>&nbsp;<w:date format="yyyy-MM-dd" id="imp_date_to" name="imp_date_to" width="80px"/>
            </td>
		</tr>
		<tr>
		  <td align="right"><fmt:message key="imp_user"/></td>
		  <td align="left"><input type="text" class="text_field" name="imp_user_name1" inputName="导入人" maxLength="18"/>          </td>
			<td align="right"></td>
			<td align="left"><input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();"></td>
		</tr>
</table>
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpempimperrAction.do?cmd=searchEpempimperrData"
        width="98%"
        height="320px"
        xpath="EpempimperrVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="emp_code" messagekey="emp_code">
               <h:text/>   
           </r:field>    
          <r:field fieldName="emp_name" messagekey="emp_name">
            <h:text/>
          </r:field>
          <r:field fieldName="id_card" messagekey="emp_card_no1" width="180px">
            <h:text/>
          </r:field>
          <r:field fieldName="err_desc" messagekey="imp_discription" width="300px">
               <h:text/>
           </r:field>
          <r:field fieldName="imp_user_name" messagekey="imp_user">
            <h:text/>
          </r:field>
          <r:field fieldName="imp_date" messagekey="imp_date">
            <w:date format="yyyy-MM-dd" />
          </r:field>
    </r:datacell>
    </div>

    <div class="foot_button">
        <input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>" onclick="javascript:back_onClick();" />
   </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>