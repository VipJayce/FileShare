<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">
<head>
<%
      String custID = request.getParameter("custID");
      request.setAttribute("custID",custID);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新进客户员工明细</title>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco("新进客户员工明细",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccParent1" style="padding-top: 5px;padding-right: 10px;padding-left: 10px;width: 97%;"> 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/FaerpEmployeeAction.do?cmd=getEmployeesForNewCust&custID=${custID}"
        width="100%"
        height="320px"
        xpath="EmployeeVo"
        paramFormId="datacell_formid"
        readonly="true"
        pageSize="10"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="emp_name" messagekey="employee_name">
            <h:text/>
          </r:field>
          <r:field fieldName="emp_code" messagekey="emp_unique_num">
               <h:text/>   
           </r:field>    
          <r:field fieldName="internal_code" messagekey="internal_code">
               <h:text/>
           </r:field>
          <r:field fieldName="id_card_type_bd" messagekey="credentials_type">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="id_card" messagekey="id_card" width="180px">
            <h:text/>
          </r:field>
          <!--<r:field fieldName="cust_code" messagekey="customer_code">
            <h:text/>
          </r:field>-->
          <!--<r:field fieldName="cust_name" messagekey="customer_name" width="220px">
            <h:text/>
          </r:field>-->
          <r:field fieldName="user_name" messagekey="user_name">
            <h:text/>
          </r:field>
          <r:field fieldName="post_status_bd" messagekey="status">
            <d:select dictTypeId="POST_STATUS_BD" />
          </r:field>
    </r:datacell>
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

<script language="javascript">

jQuery(document).ready(function(){
    $id("datacell1").isQueryFirst = true;//初始化不加载页面信息
});

</script>	
