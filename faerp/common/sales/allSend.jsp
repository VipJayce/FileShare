<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.send.vo.SendVo" %>
<%@ page import="rayoo.sales.send.util.ISendConstants" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.common.sales.sales_resource" prefix="rayoo.common.sales.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
     function select_onClick(){
        entity=choose_row("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("send_name");
        returnAry[2] = entity.getProperty("customer_id");
        returnAry[3] = entity.getProperty("customer_name");
        returnAry[4] = entity.getProperty("cust_receive_name");
        returnAry[5] = entity.getProperty("cust_receive_id");
        returnAry[6] = entity.getProperty("contract_id");
        returnAry[7] = entity.getProperty("customer_code");
        returnAry[8] = entity.getProperty("security_unit_id");
        returnAry[9]=entity.getProperty("city_id");
        returnAry[10] = entity.getProperty("fund_security_unit_id");
        returnAry[11] = entity.getProperty("hire_security_unit_id");
        window.returnValue = returnAry;
        window.close();
    }
    function simpleQuery_onClick(){  //简单的模糊查询
      $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
   
   function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }
   
</script>
</head>
<body>
<form name="form" method="post"  id="datacell_formid" action="<%=request.getContextPath()%>/SendAction.do">
<input type="hidden" name="backFlag" id="backFlag" value="true"> 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
            </tr>
            <tr>
            <td align="left"><fmt:message key="send_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="sendcode1" inputName="委派单编号" value="" maxLength="19"/>

            </td>

            <td align="left"><fmt:message key="send_name"/></td>

            <td align="left">

                <input type="text" class="text_field" name="sendname1" inputName="委派单名称" value="" maxLength="50"/>

            </td>
            </tr>
            <tr>

            <td align="left"><fmt:message key="cust_name"/></td>

            <td align="left">

              
                 <input type="hidden" class="text_field" name="customerid1" inputName="客户名称" value="" maxLength="50"/>
                     <input type="text" class="text_field" name="customername1" inputName="客户名称" value="<%  String customer_name  =(String)request.getAttribute("customer_name1") ;  if(null!=customer_name&&!"".equals(customer_name))  out.print(customer_name.trim());  %>" maxLength="50"/>
                 

            </td>
            <td>
            </td>

            <td align="center"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>

            </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="a">   <a  onClick="javascript:select_onClick();"><fmt:message key="choice"/> </a> </li>
                </ul>
         </div>
           <div class="clear"></div>            
</div>
<r:datacell id="datacell1"
            queryAction="/FAERP/SendAction.do?cmd=queryAllSend1" 
            isCount="false"
            width="100%" 
            xpath="SendVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="320px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" /> 
            <r:field fieldName="send_name" width="150px" messagekey="send_name" >
            </r:field>
              <r:field fieldName="send_code" width="300px" messagekey="send_code" >
            </r:field>
           <r:field fieldName="customer_code" width="230px" messagekey="cust_code"  >
            </r:field>
             <r:field fieldName="customer_name" width="230px" messagekey="cust_name"  >
            </r:field>
             <r:field fieldName="cust_send_name" width="230px" messagekey="cust_send_name"  >
            </r:field>
             <r:field fieldName="cust_receive_name" width="230px" messagekey="cust_rece_name"  >
            </r:field>
            <r:field fieldName="city_id" width="230px" messagekey="city"  >
            </r:field>
             
        </r:datacell>
</div>
</div>
</form>
<script language="javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>
</body>
</fmt:bundle>
</html>
