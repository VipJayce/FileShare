<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.system.tab.tabannounceinfo.vo.TabannounceinfoVo" %>
<%@ page import="rayoo.system.tab.tabannounceinfo.util.ITabannounceinfoConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //取出本条记录
	TabannounceinfoVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (TabannounceinfoVo)request.getAttribute(ITabannounceinfoConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	//RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
	String status=RmStringHelper.prt(resultVo.getAnnounce_type());
	String type="";
	if(status.equals("1")){
	 type="公司新闻" ;
	}
	else if(status.equals("2")){
	     type="公司公告" ;
	    }
	else{
	     type="人力资源政策" ;
	    }
	String str=RmStringHelper.prt(resultVo.getAnnounce_content()).replaceAll("<BR>","\r");
%>
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
 
<form name="form" method="post">
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	详细信息
	 </div>
	 </div>
    	<div class="ringht_s">
<div id="ccParent0" class="box_3"> 
</div>
<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
		    <td class="td_1" >标题：</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getAnnounce_title())%></td>
			<td class="td_1" >类型：</td>
			<td class="td_2" ><%=type%></td>
		</tr>
		<tr>
			<td class="td_1" >发送人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getName())%></td>
			<td class="td_1" >发送日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSend_date(), 10)%></td>
		</tr>
		<tr>
		<td class="td_1"></span>公告内容：</td>
            <td colspan="5" class="td_2" >
                <textarea cols="120" rows="15"  readonly="readonly" inputName="公告内容" maxLength="500" ><%=str %></textarea>
            </td>
        </tr>
                <%
                String attachment_id=RmStringHelper.prt(resultVo.getAttachment_id());
                if(attachment_id!=null&&attachment_id!=""){ %>
                  <td class="td_1">附件名称：</td>
                  <td class="td_2">
                  <a href="<%=request.getContextPath()%>/TabannounceinfoAction.do?cmd=downLoad&attachment_id=<%=attachment_id%>"><%=RmStringHelper.prt(resultVo.getAttachment_file_name()) %>(点击下载)</a></td>
                  <td class="td_1"></td>
                  <td class="td_2"></td>
                  
                 <%} %>
        </tr>
	</table>
</div>
  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
