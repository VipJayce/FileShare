<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>

<%  
	//翻页
	PageVo pageVo = new PageVo();
	if(request.getAttribute("VENUS_PAGEVO_KEY") != null) {
		pageVo = (PageVo) request.getAttribute("VENUS_PAGEVO_KEY");
	}
%>

 <div class="page">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="12"><img src="<%if(request.getAttribute("online")!=null&&request.getAttribute("online").equals(true)){ %><%=request.getContextPath()%>/<%} %>images/fesco/page_icon_1.gif"/></td>
              <td>共 <%=pageVo.getRecordCount()%> 条记录，每页 <%=pageVo.getPageSize()%> 条</td>
              <td width="30"><a href="JavaScript:firstPage();">首页</a></td>
              <td width="20"><a href="JavaScript:upPage();"><img src="<%if(request.getAttribute("online")!=null&&request.getAttribute("online").equals(true)){ %><%=request.getContextPath()%>/<%} %>images/fesco/page_icon_2.gif"/></a></td>
              <td width="80" align="center"><%=pageVo.getCurrentPage()%>/<%=pageVo.getPageCount()%>页</td>
              <td width="20"><a href="JavaScript:downPage();"><img src="<%if(request.getAttribute("online")!=null&&request.getAttribute("online").equals(true)){ %><%=request.getContextPath()%>/<%} %>images/fesco/page_icon_3.gif" alt=""/></a></td>
              <td width="50"><a href="JavaScript:lastPage();">尾页</a></td>
              <td width="40">转到第</td>
              <td width="45"><input type="text" value="<%=pageVo.getCurrentPage()%>"  name="VENUS_PAGE_NO_KEY_INPUT" id="VENUS_PAGE_NO_KEY_INPUT" class="pText"/>
              <input type="hidden" name="VENUS_PAGE_NO_KEY" value="<%=pageVo.getCurrentPage()%>">
			<input type="hidden" name="VENUS_PAGE_COUNT_KEY" value="<%=pageVo.getPageCount()%>">
			<input type="hidden" name="VENUS_PAGE_SIZE_KEY" value="<%=pageVo.getPageSize()%>">
              <%
	if ( null != pageVo.getOrderKey() ){
%>
			<input type="hidden" name="VENUS_ORDER_KEY" value="<%=pageVo.getOrderKey()%>">
<%	
	}
%>
              </td>
              <td width="20">页</td>
              <td width="20"><a href="JavaScript:goAppointedPage();"><img src="images/fesco/page_icon_4.gif" width="16" height="16" /></a></td>
              <td width="10"><a href="JavaScript:goAppointedPage();">转</a></td>
            </tr>
          </table>
  </div>

<script language="javascript">

//翻页相关
function firstPage(){  //去首页
	form.VENUS_PAGE_NO_KEY.value=1;
	form.submit();
}
function upPage(){  //去上一页
	form.VENUS_PAGE_NO_KEY.value--;
	form.submit();
}
function downPage(){  //去下一页
	form.VENUS_PAGE_NO_KEY.value++;
	form.submit();
}
function lastPage(){  //去末页
	form.VENUS_PAGE_NO_KEY.value=<%=pageVo.getPageCount()%>;
	form.submit();
}
function goAppointedPage(){  //直接跳到某页
	checkPageNoKey();
	form.submit();
}
function checkPageNoKey() {
	form.VENUS_PAGE_NO_KEY.value = form.VENUS_PAGE_NO_KEY_INPUT.value;
	if(form.VENUS_PAGE_NO_KEY_INPUT.value <= 0) {
		form.VENUS_PAGE_NO_KEY.value = 1;
	}
}
</script>