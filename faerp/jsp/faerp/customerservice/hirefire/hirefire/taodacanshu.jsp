<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.taodacanshu_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% 
   String join_date = "";
   String file_now = "";
   if(request.getParameter("join_date") != null&&!"".equals(request.getParameter("join_date"))){
	   join_date = request.getParameter("join_date").toString().substring(0,10); 
   }
   if(request.getParameter("file_now") != null&&!"".equals(request.getParameter("file_now"))){
	   file_now = request.getParameter("file_now");
   }
  
%>
<title>codegen</title>
<script language="javascript">
  	function ok_onClick(){  //<fmt:message key='taodacanshu0003'/>后生成报表
    	var arg1 = "<%=request.getParameter("arg1").toString() %>";
    	var arg2 = "<%=request.getParameter("arg2")%>";
    	var emp_post_id = "<%=request.getParameter("emp_post_id")%>";
    	var join_date = $id('join_date').value;
    	var file_now = $id('file_now').value;
		var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/taoda.jsp?raq=shanghaituigongtaoda.raq&arg1="+arg1+"&emp_post_id="+emp_post_id+"&arg2="+arg2+"&arg5=10"    	
    	if(join_date != null && join_date!=""){
    		url = url + "&join_date="+join_date;
    	}
    	if(file_now != null && file_now!=""){
    		url = url + "&file_now="+file_now;
    	}
    	//alert(url);
    	window.open(url);
    	window.close();
    }
  	
  	
  	
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<div class="xz_title">留空时不修改</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
		  <td class="td_1" nowrap="true"><fmt:message key='taodacanshu0001'/></td>
          <td class="td_2" align="left" style="width: 250px">
          	<w:date id="join_date" format="yyyy-MM-dd" value="<%=join_date %>"/>
          </td>
		</tr>
		<tr>
			<td class="td_1" nowrap="true" ><fmt:message key='taodacanshu0002'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" id="file_now" name="file_now" maxLength="64"  style="width: 195px"  value="<%=file_now %>"/>
			</td>
		</tr>
		
	</table>
	</div>
    <div class="foot_button">
        <input type="button" class="icon_2" value="<fmt:message key='taodacanshu0003'/>" onClick="javascript: ok_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>
</div>         
</form>
</fmt:bundle>
</body>
</fmt:bundle>
</html>


