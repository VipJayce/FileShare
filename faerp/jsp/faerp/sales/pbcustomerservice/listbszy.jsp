<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.pbcustomerservice.vo.PbcustomerserviceVo"%>
<%@ page import="rayoo.sales.pbcustomerservice.util.IPbcustomerserviceConstants"%>
<%@ page import="gap.authority.helper.OrgHelper"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salse.pbcustomerservice.pbcustomerservice_resource" prefix="rayoo.salse.pbcustomerservice.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="not_title_word"/></title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../scripts/common.js"></script>
<style type="text/css">
.fex_row {LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>
<script type="text/javascript">
	function sendSubmit(){
	
		var ids = findSelections("checkbox_template","id");
		//alert(ids);
		var obj = document.getElementById("userId");
		var userName = obj.options[obj.options.selectedIndex].text;
		//alert(txt);
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?ids=" + ids + "&userName=" + userName ;
        form.cmd.value = "submitBszy";
        form.submit();
	}
	
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
    
</script>

</head>
<body>
	<form name="form"
		action="<%=request.getContextPath()%>/PbcustomerserviceAction.do" method="post">
		<input type="hidden" name="cmd" value="">
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key="fenpai_tax_person"/></div>
	</div>
    <div class="ringht_s">
      <div class="box" id="values_div2">
	  <table  width="100%" cellspacing="0"  class="datagrid1">
	    <tr>
	      <th ><input type='checkbox'
				onclick="checkAllList_onClick(this);" pdType='control'
				control='checkbox_template' /></th>
	      <th   ><fmt:message key="customer_name"/></th>
	      <th ><fmt:message key="customer_code"/></th>
	      <th ><fmt:message key="customer_service_person"/></th>
	      <th ><fmt:message key="customer_service_dept"/></th>
        </tr>
	   <logic:iterate name="beans" id="data" scope="request" indexId="indexs">
			<tr>
				<td><input type="checkbox"
					name="checkbox_template"
					id="checkbox_template"
					value="<bean:write name="data" property="id"/>$<bean:write name="data" property="customer_id"/>$<bean:write name="data" property="party_id"/>"/></td>
				<td><bean:write name="data" property="customer_name" /> </td>
				<td><bean:write name="data" property="customer_code" /> </td>
				<td><bean:write name="data" property="server_name" /> </td>
				<td><bean:write name="data" property="custom_dept" /> </td>
			</tr>
		</logic:iterate>
      </table>
	  </div>
	  <jsp:include page="/jsp/include/page.jsp" /></div>
	  </div>
      <div class="xz_title" style="margin:10px;"><fmt:message key="fenpai_tax_person"/></div>
      <div class="box_tab" style="margin:10px;">
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key="please_choose"/></td>
            <td class="td_2"><select name="userId" class="sSelect" id="userId">
              <option value="ro1"><fmt:message key="choose_tax_person"/></option>
            </select></td>
          </tr>
        </table>
        <!--按钮-->
        <!--按钮 end-->
        <!--表格 -->
      </div>
      <div class="foot_button">
        <input type="button" class="foot_icon_1" value="<fmt:message key="save"/>" onclick="sendSubmit()"/>
      </div>
  </div>
</div>
</body>
</fmt:bundle>
</html>
<script langusge="javascript">
 	var returnString = "<%=request.getAttribute("returnString")%>"
	//alert(returnString);
	var userId = document.getElementById("userId");
	emps = returnString.split(",");
			if(emps.length > 0){
				for(var i=0;i<emps.length;i++){
	        		var emp = emps[i].split("$");
	        		var opt=new Option(emp[1],emp[0]);
	            	userId.options.add(opt);
            	}
        	}
</script>
