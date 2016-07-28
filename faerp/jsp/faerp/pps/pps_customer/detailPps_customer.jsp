<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PPS客户查看</title>
<script type="text/javascript">
    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">    
<div id="right">
 <div class="ringht_x">
<div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key='basic_information'/></div>
<table  width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" >
       <tr>
            <td class="td_1" width="24%"><fmt:message key='customer_code'/>：</td>
            <td class="td_2" width="32%" >${bean.customer_code} </td>
            <td class="td_1" width="17%"><fmt:message key='customer_name'/>：</td>
            <td class="td_2" width="27%">${bean.customer_name}</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_simple_name'/>：</td>
            <td class="td_2" >${bean.customer_simple_name }</td>
            <td class="td_1" ><fmt:message key='customer_en_name'/>：</td>
            <td class="td_2" >${bean.customer_en_name }</td>
        </tr>
   </table>
   <div class="mx_button" align="center">
        <input   type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
   
</div>
</div>
</div>

</form>
</fmt:bundle>
</body>
</html>
