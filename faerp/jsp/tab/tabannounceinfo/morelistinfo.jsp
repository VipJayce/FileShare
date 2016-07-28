<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.tab.tabannounceinfo.vo.TabannounceinfoVo" %>
<%@ page import="rayoo.system.tab.tabannounceinfo.util.ITabannounceinfoConstants" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<h:css href="/css/index.css"/>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
 function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/TabannounceinfoAction.do?cmd=queryAll1&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/TabannounceinfoAction.do">
<div id="right">
  <div class="ringht_s">
    <div class="home_index">
    <div class="home_title"><div class="home_title_left">公司信息</div></div>
        <div class="home_box">
       <table width="96%" border="0" cellspacing="0" cellpadding="0">
         <%
         List<TabannounceinfoVo> listvo=( List<TabannounceinfoVo>)request.getAttribute("beans");
         if(listvo.size()==0|| listvo==null){
             %>
                   <span class="li_date" style="color:#999;">暂无消息</span>
            <% 
              }
         for(int i=0;i<listvo.size();i++){
             TabannounceinfoVo vo=new  TabannounceinfoVo();
             vo=listvo.get(i);
             Date date=vo.getSend_date();
             SimpleDateFormat sd=new SimpleDateFormat("YYYY-MM-dd"); 
             %>
            <tr>
            <td class="home_index_td_1"><a href= "#" onclick='location.href="<%=request.getContextPath() %>/TabannounceinfoAction.do?cmd=detail&cid=<%=vo.getId() %>"'> <%=vo.getAnnounce_title() %></a></td>
            <td class="home_index_td_3" ><%= vo.getAnnounce_type() %></td>
            <td class="home_index_td_2"><%= sd.format(date) %></td>
             <td class="home_index_td_2"><%= vo.getName() %></td>
          </tr>
            <%
         }
            %>
        </table>
        </div>
    </div>
    </div>
    <jsp:include page="/jsp/include/page.jsp" />
    <div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>
</div>
</form>

<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
<script language="javascript">
</script>	
