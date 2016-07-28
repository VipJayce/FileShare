<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.credentials.util.ICredentialsConstants" %>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="choose_employee"/></title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
   
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
   
    function confirm_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var enCurEntity = $id("datacell1").activeEntity;
        var returnAry = new Array();
        returnAry[0] = ids;
        returnAry[1] = enCurEntity.getProperty('emp_name');
        returnAry[2] = enCurEntity.getProperty('cust_name');
         returnAry[3] = enCurEntity.getProperty('id_card');
        window.returnValue=returnAry;
        window.close();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsAction.do">
<input type="hidden" name="cmd" value="simpleEmployee">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="Query_conditions"/></div> </td>
     </tr>
      <tr>
            <td align="left"><fmt:message key="employee"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="50"/>
            </td>
            <td align="left"><fmt:message key="card_no"/></td>
            <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="身份证号" maxLength="18"/>
            </td>
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button">
<div class="button_right">
    <ul>
        <li class="bc"><a onClick="javascript:confirm_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>

<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CredentialsAction.do?cmd=queryEmployeeData" 
  width="98%" height="318px" xpath="EmployeeVO" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="id" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus"></r:field>
  <r:field fieldName="emp_code" messagekey="employee_code" width="150px"></r:field>
  <r:field fieldName="emp_name" messagekey="employee_name" width="150px"></r:field>
  <r:field fieldName="id_card" messagekey="id_card" width="200px"></r:field>
  <r:field fieldName="cust_name" messagekey="cust_comp" width="300px"></r:field>
  </r:datacell>
</div>
 
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    
</script>
</body>
</html>

<script language="javascript">
</script>   
