<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.rebutSecurityBack_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>填写<c:if test="${type eq 1}">暂不撤户</c:if>
<c:if test="${type eq 2}">恢复撤户</c:if>操作原因</title>
</head>
<body>

<%
	CustomerVo vo = (CustomerVo)request.getAttribute("customervo");
	System.out.println("===================================="+vo.getId());
%>


<script language="javascript">
    function submit_onClick(){
        var reason = jQuery("#reason").val();
        if(reason==null || reason==''){
            if("${type}" == "1"){
	            alert('请填写暂不撤户原因！');
	        }
	        if("${type}" == "2"){
	            alert('请填写恢复撤户原因！');
	        }
            return;
        }
        
        var action = "";
        if("${type}" == "1"){
            action = "<%=request.getContextPath()%>/CustomerAction.do?cmd=zanBuCheHu&id=<%=RmStringHelper.prt(vo.getId()) %>";
        }
        if("${type}" == "2"){
            action = "<%=request.getContextPath()%>/CustomerAction.do?cmd=submitAPProvalCust&cust_id=<%=RmStringHelper.prt(vo.getId()) %>";
        }
        
            
        var myAjax = new Ajax(action);
        myAjax.addParam("cust_id", jQuery("#id").val());
        myAjax.addParam("reason", reason);
          
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
             if( myAjax.getValue("root/data/returnValue") == 1 ) {
                  if("${type}" == "1"){
                    alert('保存成功');
                  }
	              if("${type}" == "2"){
                    alert("申请恢复撤户提交成功！");
                  }
                  returnValue = '1';
                  window.close();
             } else {
                  if("${type}" == "1"){
                    alert('保存失败！'); 
                  }
                  if("${type}" == "2"){
                    alert("申请恢复撤户提交失败！");
                  }
                  returnValue = '0';
                  window.close();
             }
        }
    }
   
</script>

<form name="form" method="post" id="datacell_formid">
    <input type="hidden" id="id" name="id" value="<%=RmStringHelper.prt(vo.getId()) %>"/>
    <div id="right">
	    <script language="javascript">
	        if("${type}" == "1"){
	           writeTableTopFesco('输入暂不撤户原因','<%=request.getContextPath()%>/');  //显示本页的页眉
            }
            if("${type}" == "2"){
               writeTableTopFesco('输入恢复撤户原因','<%=request.getContextPath()%>/');  //显示本页的页眉
            }
	    </script>
	    <div class="box_xinzeng" style="margin:0px;">
		    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
		        <tr>
		            <td height="39" align="right" width="150" class="td_1">客户名称:
		            </td>
		            <td align="left" class="td_2"><%=RmStringHelper.prt(vo.getCustomer_name()) %></td>
		        </tr>
		        <tr>
		            <td height="39" class="td_1" align="right">客户编码:
		            </td>
		            <td align="left" class="td_2"><%=RmStringHelper.prt(vo.getCustomer_code()) %></td>
		        </tr>
		        <tr>
		            <td height="39" class="td_1" align="right">原因:
		            </td>
		            <td align="left" class="td_2">
		                <textarea id="reason" name="reason" rows="5" cols="50"></textarea>
		            </td>
		        </tr>
		        <tr>
		            <td height="39" class="td_2" colspan="2" align="center">
		                <input name="button_ok" class="icon_1" type="button" value='提交' onClick="javascript:submit_onClick()">
		            </td>
		        </tr>
		    </table>
		</div>
	</div>
</form>
</body>
</fmt:bundle>
</fmt:bundle>
</html>
