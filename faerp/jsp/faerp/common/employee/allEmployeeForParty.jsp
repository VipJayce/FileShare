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
<fmt:bundle basename="rayoo.common.employee.employee_resource" prefix="rayoo.common.employee.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

    function simpleQuery_onClick(){
        $id("datacell1").addParam("emp_name",$id("emp_name1").value);  
        $id("datacell1").addParam("emp_code",$id("emp_code1").value);
        $id("datacell1").addParam("id_card_type_bd",$name("id_card_type_bd1").value);
        $id("datacell1").addParam("id_card",$id("id_card1").value);
        $id("datacell1").loadData();
        $id("datacell1").refresh();

    }
    
    function select_onClick(){
          entity=choose_row("datacell1");
          var returnAry = new Array();
          returnAry[0] = entity.getProperty("emp_code");
          returnAry[1] = entity.getProperty("emp_name");
          returnAry[2] = entity.getProperty("id_card");
          returnAry[3] = entity.getProperty("id_card_type_bd");
          returnAry[4] = entity.getProperty("post_id");
          returnAry[5] = entity.getProperty("on_post_date");
          window.returnValue=returnAry;
          window.close();
    }
    function choose_row(dcId){
        dc = $id(dcId);
        obj = dc.getActiveEntity();
            if(!obj){
               alert("<fmt:message key="select_one_record"/>");
               return;
            }
         return obj;
    }
</script>
</head>
<body>

	<form name="form" method="post" id="datacell_formid">
	<div id="right"><!-- 查询党员信息 -->
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right"><fmt:message key="employee_name"/></td>
			<td align="left"><input type="text" class="text_field"
				id="emp_name1" name="emp_name1" inputName="员工姓名" /></td>
			<td align="right"><fmt:message key="emp_unique_num"/></td>
			<td align="left"><input type="text" class="text_field"
				id="emp_code1" name="emp_code1" inputName="唯一号" /></td>
		</tr>
		<tr>
            <td align="right"><fmt:message key="credentials_type"/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("id_card_type_bd1", -1, "ID_CARD_TYPE_BD", "", "",false)%></td>
			<td align="right"><fmt:message key="id_card"/></td>
			<td align="left"><input type="text" class="text_field"
				id="id_card1" name="id_card1" inputName="证件号码" /></td>
		</tr>
		<tr>
			<td align="right"></td>
            <td align="left"></td>
			<td align="right"></td>
			<td align="left">
			 <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
			 <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
		    </td>
		</tr>
	</table>
	</div>
	 <div id="ccParent1" class="button">
	 <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="choice"/> </a></li>
    </ul>
    </div>
        <div class="clear"></div>
    </div>
    <div  id="div1" style="margin:5 0 0 10px;">
	<r:datacell id="datacell1"
		queryAction="/FAERP/EppartymemerAction.do?cmd=searchEmpForParty"
		width="98%" height="305px" xpath="EmployeeVo"
		paramFormId="datacell_formid">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="emp_code" width="120px" messagekey="emp_unique_num">
		</r:field>
		<r:field fieldName="emp_name" width="120px" messagekey="employee_name">
		</r:field>
		<r:field fieldName="id_card_type_bd" width="120px" messagekey="credentials_type" allowModify="false">
		  <d:select dictTypeId="ID_CARD_TYPE_BD"/>
		</r:field>
		<r:field fieldName="id_card" width="150px" messagekey="id_card">
		</r:field>
	</r:datacell> 
	</div>
	</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>   
