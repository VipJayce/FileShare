<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="js/jquery/jquery-1.6.1.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%
List<Object[]> list=request.getAttribute("countlist")==null?new ArrayList<Object[]>():(List<Object[]>)request.getAttribute("countlist");
%>
<h:script src="/js/jquery/q_box.js" />
<h:css href="/css/q_box_style.css"/>
<h:css href="/css/index.css"/>

<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@page import="rayoo.system.tab.tabannounceinfo.vo.TabannounceinfoVo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%
String AgencyTask=request.getAttribute("AgencyTask").toString();
String TaskComplete=request.getAttribute("TaskComplete").toString();
%>
<%@page import="java.util.ArrayList"%>
<%@page import="rayoo.system.tab.tabannounceinfo.vo.ImagesVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

</script>
</head>
<body>
<div id="right">
  <div class="ringht_s">
    <!--系统提醒 
    <span style="float: right; margin-right:  20px; color: blue;"><b>版本号：试运行版本    时间：2013-01-20 17:15:00</b></span>-->
    <div class="home">
        <div class="dbxx">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" width="180px"><a href="#" onclick='location.href="<%=request.getContextPath() %>/dynamicQueryTaskByPersonIDAction.do?done=false"'><div class="dbxx_d"><span style="color: black;">待办任务</span>&nbsp;&nbsp;&nbsp;<%=AgencyTask %></div></a></td>
    <td align="left" width="180px" ><a href="#" onclick='location.href="<%=request.getContextPath() %>/dynamicQueryTaskByPersonIDAction.do?done=true"'><div class="dbxx_y"><span style="color: black;">已办任务</span>&nbsp;&nbsp;&nbsp;<%=TaskComplete %></div></a></td>
    <td/>
    <td/>
    <td/>
  </tr>
</table>
    </div>
        <div class="xttt">
            <ul>
            <%for (int i=0;i<list.size();i++) {
                Object[] obj=list.get(i);
                String count=obj[0]==null?"0":obj[0].toString();
                ImagesVo vo=(ImagesVo)obj[1];
            %>
                <a href="<%=vo.getForward_url()%>&flag=true"><li><img src="<%=vo.getImage_src() %>" width="60" height="60" /><br /><%=vo.getImage_name()%></li><div class="xf_icon_<%=i+1 %>"><% if (Integer.parseInt(count)>99){ %>
                    99+
               <% } %>
               <%=count %>
               </div></a>
                 <% }%>
                 </ul>
            <div class="clear"></div>
        </div>              
    </div>
    <!--系统提醒 end-->
    
    <!--公司新闻 -->
    <form name="form" method="post" action="<%=request.getContextPath()%>/TabannounceinfoAction.do">
        <%
         List<TabannounceinfoVo> listvo=( List<TabannounceinfoVo>)request.getAttribute("beans");
             if(listvo.size()!=0&& listvo!=null){
       %>
    <div class="home_index">
      <div class="home_title">
        <div class="home_title_left">公司信息</div>
        <div class="home_title_more"><a href="#" onclick='location.href="<%=request.getContextPath() %>/TabannounceinfoAction.do?cmd=querymore&type=3"'>更多 ></a></div>
      </div>
      <div class="home_box">
        <table width="96%" border="0" cellspacing="0" cellpadding="0">
	        <% 
	         int j=0;
	         for(int i=0;i<listvo.size();i++){
	             TabannounceinfoVo vo=new  TabannounceinfoVo();
	             vo=listvo.get(i);
	             Date date=vo.getSend_date();
	             SimpleDateFormat sd=new SimpleDateFormat("YYYY-MM-dd"); 
	             j=j+1;
	       %>
          <tr>
            <td class="home_index_td_1"><a href= "#" onclick='location.href="<%=request.getContextPath() %>/TabannounceinfoAction.do?cmd=detail&cid=<%=vo.getId() %>"'> <%=vo.getAnnounce_title() %></a></td>
            <td class="home_index_td_3" ><%= vo.getAnnounce_type() %></td>
            <td class="home_index_td_2"><%= sd.format(date) %></td>
             <td class="home_index_td_2"><%= vo.getName() %></td>
          </tr>
           <%
	              if(j==6){
	                  break;
	              }
               }
          %>
        </table>
      </div>
    </div>
    <%} %>
    </form>
    <!--公司新闻 end-->
  </div>
</div>

<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>
</fmt:bundle>
</html>
