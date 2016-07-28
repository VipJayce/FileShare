<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.system.announceinfo.pbannounceinfo.vo.PbannounceinfoVo" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	PbannounceinfoVo resultVo = null;  //定义一个临时的vo变量
    String id = "";
    id = request.getParameter("cid");
    PbannounceinfoAction action = new PbannounceinfoAction();
    PbannounceinfoVo vo = action.getBs().find(id);
    request.setAttribute("vo", vo);
%>
<%@page import="rayoo.system.announceinfo.pbannounceinfo.action.PbannounceinfoAction"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
function update_onClick(id){  //保存修改后的单条数据
  	var announcetype=document.getElementById("announce_type").value;
    var announcetitle= document.getElementById("announce_title").value;
    var announcecontent = document.getElementById("announce_content").value;
    var id = document.getElementById("id").value;
          jQuery.getJSON("<venus:base/>/PbannounceinfoAction.do?cmd=update&date="+new Date()+"",{"id":id,"announcetype":announcetype,"announcetitle":announcetitle,"announcecontent":announcecontent},   function(json){
              if(json.saia!=null&&json.saia=="成功")
                {
                window.close();
                 }
                    });
	
	}
</script>
</head>
<body>
<form name="form" method="post">
<div id="right">
<script language="javascript">
</script>
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 <input type="hidden" name="id" id="id" value="${vo.id }">
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>信息类别</td>
			<td class="td_2 ">
				  <d:select dictTypeId="ANNOUNCE_TYPE"  id="announce_type" name="announce_type"  value="${vo.announce_type}"  />
			</td>
			<td class="td_1" ><span class="style_required_red">* </span>标题</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="announce_title" id="announce_title" inputName="announce_title" value="${vo.announce_title }" maxLength="50" validate="notNull;"/>
			</td>
		</tr>
		<tr>
			<td class="td_1"><span class="style_required_red">* </span>公告内容</td>
			<td colspan="5" class="td_2" >
				<textarea class="textarea_limit_words" cols="81" rows="20" id="announce_content" name="announce_content" inputName="公告内容" maxLength="500" validate="notNull;">${vo.announce_content }</textarea>
			</td>
		</tr>
	</table>
 

   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:window.close()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
