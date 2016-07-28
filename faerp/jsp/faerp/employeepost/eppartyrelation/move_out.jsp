<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyrelation.vo.EppartyrelationVo" %>
<%@ page import="rayoo.employeepost.eppartyrelation.util.IEppartyrelationConstants" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	EppartyrelationVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEppartyrelationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EppartyrelationVo)request.getAttribute(IEppartyrelationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
 function moveOut_onClick()
    {
         if(document.getElementById("rid").value=="null"||document.getElementById("rid").value=="")
        {
            alert("请选择一名党员！");
            return;
        }
        if($id("move_out_date").value==null)
        {
            alert("请选择转出日期！");
            return ;
        }
        if( document.getElementById("relationship_to").value==null|| document.getElementById("relationship_to")=='')
        {
            alert('转出地不能为空！');
            return ;
        }
              
        form.action="<%=request.getContextPath()%>/EppartyrelationAction.do?cmd=partyMove&moveid=out&status=3";
        form.submit();
    }
</script>
<body>

<form name="form" method="post">
<input id="rid" name="rid" type="hidden">
<div id="right">
<div id="ccParent0" class="box_3"> 
 <div class="xz_title">转出</div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
          <td style="background:#f1f7f9; text-align:right; width:200px;"><span>*</span>转出日期</td>
          <td style="background:#fff;width:200px;"> <w:date allowInput="true" id="move_out_date" name="move_out_date" format="YYYY-MM-DD"/></td>
          <td style="background:#f1f7f9; text-align:right; width:200px;">转往何处</td>
          <td style="background:#fff;width:200px;"><input  name="relationship_to" name="relationship_to" type="text"  class="sText" /></td>
        </tr>
        <tr>
          <td style="background:#f1f7f9; text-align:right; width:200px;">备注</td>
          <td colspan="3" style="background:#fff;width:200px;"><textarea name="remarks" rows="3" style="width:350px;" class="xText_d" id="remarks"></textarea>
            <span class="dc_button" style="margin-left:40%;">
            <input type="button" class="icon_2" value="关系转出"   onClick="javascript:moveOut_onClick();"/>
            </span></td>
        </tr>
    </table>
</form>
     </div>       
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
document.getElementById("rid").value="<%=request.getParameter("rid")%>";
</script>
