<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.au.aufunctree.vo.AuFunctreeVo" %>
<%@ page import="gap.authority.au.aufunctree.util.IAuFunctreeConstants" %>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ include file="/jsp/include/global.jsp" %>
<%  //取出本条记录
	AuFunctreeVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AuFunctreeVo)request.getAttribute(IAuFunctreeConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
	VoHelperTools.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<head>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
 <%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<link href="<venus:base/>/css/index.css" type="text/css" rel="stylesheet">
<link href="<venus:base/>/css/common.css" type="text/css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ranmin-based architecture project</title>
<script language="javascript">
	function find_onClick(){  //直接点到修改页面
		var parent_code = document.form.parent_code.value;
		form.action="<%=request.getContextPath()%>/AuFunctreeAction.do?cmd=find&parent_code="+parent_code;
		form.submit();
	}
	function delete_onClick(){  //直接点删除单条记录
		if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
			return false;
		}
		form.action="<%=request.getContextPath()%>/AuFunctreeAction.do?cmd=delete";
		form.target="_parent";
		form.submit();
	}  
	function toAdd_onClick() {  //到增加记录页面
		form.action="<venus:base/>/jsp/authority/au/aufunctree/insertAuFunctree.jsp";
		form.submit();
	}
	function toSort_onClick() {  //到排序页面
		form.action="<venus:base/>/jsp/authority/au/aufunctree/sortAuFunctree.jsp";
		form.submit();
	}
</script>
</head>
<body>
<form name="form" method="post">
<div class="tissue_right">
  <div class="ringht_s">
 
    <div class="xz_title" style="background:#f2fbff;">详细页面</div>
    <div class="button">
     
      <div class="button_right">
        <ul>
          <li class="c"><a onclick="javascript:toAdd_onClick();">新增</a></li>
          <li class="b"><a onclick="javascript:find_onClick();">修改</a></li>
      
          <li class="d"><a onclick="javascript:delete_onClick();" >删除</a></li>
          <li class="d"><a onclick="javascript:toSort_onClick();">排序</a></li>
        </ul>
      </div>
      <div class="clear"></div>
    </div>
    <div class="box" style="height:350px; overflow: auto;">
      
      <table  width="100%" cellspacing="0"  class="datagrid1" >
        <tr>
          <td width="10%" class="fex_row">节点类型</td>
          <td class="fex_row">菜单管理</td>
        </tr>
        <tr>
          <td class="fex_row">节点中文名称</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getName())%></td>
          </tr>
              <tr>
          <td class="fex_row">节点英文名称</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getEn_name())%></td>
          </tr>
        <tr>
          <td class="fex_row">节点标识</td>
          <td class="fex_row">&nbsp;<%=GlobalConstants.getResType_menu().equals(resultVo.getType())?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Function_menu"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Page_button")%></td>
          </tr>
        <tr>
          <td class="fex_row">自身编码</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getKeyword())%></td>
          </tr>
          <tr>
			<td align="right">图片路径:</td>
			<td align="left" bgcolor="#FFFFFF">&nbsp;
				<%=StringHelperTools.prt(resultVo.getImages_url())%>
			</td>
		</tr>
        <tr>
          <td class="fex_row">父级编码</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getParent_code())%></td>
          </tr>
        <tr>
          <td class="fex_row">节点编码</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getTotal_code())%></td>
          </tr>
        <tr>
          <td class="fex_row">帮助信息</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getHelp())%></td>
          </tr>
        <tr>
          <td class="fex_row">实际链接</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getUrl())%></td>
          </tr>
        <tr>
          <td class="fex_row">支持SSL</td>
          <td class="fex_row">&nbsp;<%="1".equals(StringHelperTools.prt(resultVo.getIs_ssl()))?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Be"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.No0")%></td>
          </tr>
        <tr>
          <td class="fex_row">功能公开</td>
          <td class="fex_row">&nbsp;<%="1".equals(StringHelperTools.prt(resultVo.getIs_public()))?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Be"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.No0")%></td>
        </tr>
        <tr>
          <td class="fex_row">排序编码</td>
          <td class="fex_row">&nbsp;<%=StringHelperTools.prt(resultVo.getOrder_code())%></td>
        </tr>
        <tr>
          <td class="fex_row">添加时间</td>
          <td class="fex_row"><%=StringHelperTools.prt(resultVo.getCreate_date(),16)%></td>
        </tr>
        <tr>
          <td class="fex_row">修改时间</td>
          <td class="fex_row"><%=StringHelperTools.prt(resultVo.getModify_date(),16)%>&nbsp;</td>
        </tr>
      </table>
</div>
   
    </div>
</div>


<input type="hidden" name="id" value="<%=StringHelperTools.prt(resultVo.getId())%>">
<input type="hidden" name="parent_type" value="<%=StringHelperTools.prt(resultVo.getType())%>">
<input type="hidden" name="total_code" value="<%=StringHelperTools.prt(resultVo.getTotal_code())%>">
<input type="hidden" name="parent_name" value="<%=StringHelperTools.prt(resultVo.getName())%>">
<input type="hidden" name="parent_code" value="<%=StringHelperTools.prt(resultVo.getParent_code())%>">
</form>
</body>
</html>
	

