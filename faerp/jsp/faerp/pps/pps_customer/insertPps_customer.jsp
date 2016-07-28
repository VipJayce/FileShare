<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="/common/common.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PPS客户查看</title>
<script type="text/javascript">
    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
    
    function save_onClick(){  //保存
           var  cust_name = document.getElementById("customer_name").value;
           var  cust_id=document.getElementById("cust_id").value;
           var  cust_en_name = document.getElementById("customer_en_name").value;
           if(cust_name==null||cust_name==""){
                alert("请输入客户名称!");
                return;
           }
           var action="<%=request.getContextPath()%>/Pps_customerAction.do?cmd=update_customername";
           var myAjax = new Ajax(action);
            myAjax.addParam('custname', cust_name);
            myAjax.addParam('custid', cust_id);
            myAjax.addParam('cust_en_name', cust_en_name);
           myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      window.close();
                      window.opener.simpleQuery_onClick();
            }
           
    }
    
    
    
    
    
</script>
</head>
<body>
<form name="form" method="post">    
<div id="right">
 <div class="ringht_x">
<div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key='basic_information'/></div>
<input  type="hidden" id="cust_id" name="cust_id" value="${bean.id }">
<table  width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" >
       <tr>
            <td class="td_1" width="24%"><fmt:message key='customer_code'/>：</td>
            <td class="td_2" width="32%" >${bean.customer_code} </td>
            <td class="td_1" width="17%"><fmt:message key='customer_name'/>：</td>
            <td class="td_2" width="27%"><input  type="text" class="text_field"  name="customer_name" id="customer_name" value="${bean.customer_name}"/></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_simple_name'/>：</td>
            <td class="td_2" >${bean.customer_simple_name }</td>
            <td class="td_1" ><fmt:message key='customer_en_name'/>：</td>
            <td class="td_2" ><input  type="text" class="text_field"  name="customer_en_name" id="customer_en_name" value="${bean.customer_en_name}"/></td>
        </tr>
   </table>
   <div class="mx_button" align="center">
        <input type="button" class="icon_2" value='<fmt:message key='save'/>' onClick="javascript:save_onClick()"/>
        <input   type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
   
</div>
</div>
</div>

</form>
</fmt:bundle>
</body>
</html>
