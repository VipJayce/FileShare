<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyrelation.vo.EppartyrelationVo" %>
<%@ page import="rayoo.employeepost.eppartyrelation.util.IEppartyrelationConstants" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
<body>
<script>
 function moveinternal_onClick()
    {
        if(document.getElementById("rid").value=="null"||document.getElementById("rid").value=="")
        {
            alert("请选择一名党员！");
            return;
        }
        if($id("partyCode").getValue()=="")
        {
            alert("请选择要转入的党支部！");
            return;
        }
        if($id("last_update_date").value==null)
        {
            alert("请选择转移时间！");
            return;
        }
        form.action="<%=request.getContextPath()%>/EppartyrelationAction.do?cmd=partyMove&moveid=internal";
        form.submit();
    }
</script>
<form name="form" method="post">

<div id="right">
<div id="ccParent0" class="box_3"> 
<input id="rid" name="rid" type="hidden">
<div class="xz_title">内部转移</div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;">转入哪个党支部</td>
            <td style="background:#fff;width:200px;">
            <r:comboSelect id="partyCode" name="partyCode"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="200px" nullText="请选择" />
            </td>
            <td style="background:#f1f7f9; text-align:right; width:200px;">转移日期</td>
            <td style="background:#fff;width:200px;"><w:date allowInput="true" id="last_update_date" name="last_update_date" format="YYYY-MM-DD"/></td>
        </tr>
          <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;">备注</td>
            <td colspan="3" style="background:#fff;width:200px;"><textarea name="remarks" rows="3" class="xText_d"  style="width:350px;"  id="remarks"></textarea>
              <span class="dc_button" style="margin-left:40%;">
              <input type="button" class="icon_2" value="内部转移"  onClick="javascript:moveinternal_onClick();"/>
              </span></td>
            </tr>
          </table>
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
