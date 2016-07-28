<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.visitrecord.vo.VisitrecordVo" %>
<%@ page import="rayoo.employeepost.visitrecord.util.IVisitrecordConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<% 
VisitrecordVo resultVo = null;  //定义一个临时的vo变量
    if(request.getAttribute(IVisitrecordConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (VisitrecordVo)request.getAttribute(IVisitrecordConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm."><script language="JavaScript" src="../../scripts/common.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post"><div id="right">
<div class="ringht_s">
     <div class="social_tab">
         <!--表格1-->
         <div class="xz_title" style="margin-top:10px;">回访记录</div>
         <div class="box_3">
           <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	        <tr>
	            <td class="td_1" width="30%">唯一号</td>
	            <td class="td_2" width="20%"><%=RmStringHelper.prt(resultVo.getEmp_code()) %></td>
	            <td class="td_1" width="30%">员工姓名</td>
	            <td class="td_2" width="20%"><%=RmStringHelper.prt(resultVo.getEmp_name()) %></td>
	        </tr>
	        <tr>
	            <td class="td_1" >客户编号</td>
	            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getCust_code()) %></td>
	            <td class="td_1" >客户名称</td>
	            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getCust_name()) %></td>
	        </tr>
	        <tr>
	            <td class="td_1">身份证号</td>
                <td class="td_2"><%=RmStringHelper.prt(resultVo.getId_card()) %></td>
                <td class="td_1" >手机</td>
                <td class="td_2 "><%=RmStringHelper.prt(resultVo.getMobile()) %></td>
	        </tr>
	        <tr>
	            <td class="td_1" >入职时间</td>
	            <td class="td_2 "><fmt:formatDate value="${bean.apply_on_post_date}" pattern="yyyy-MM-dd"/></td>
	            <td class="td_1" >呼叫时间</td>
	            <td class="td_2 "><fmt:formatDate value="${bean.call_time}" pattern="yyyy-MM-dd"/></td>
	        </tr>
	        <tr>
	            <td class="td_1" >福利城市</td>
                <td class="td_2 "><%=RmStringHelper.prt(resultVo.getCity_name()) %></td>
                <td class="td_1" >员工是否收到福利供应商办理入职手续通知</td>
                <td class="td_2 "><%=BaseDataHelper.getNameByCode("IS_NOTICE",String.valueOf(resultVo.getIs_notice())) %></td>
	        </tr>
	        <tr>
	            <td  class="td_1" >呼叫类型</td>
	            <td  class="td_2" ><%=BaseDataHelper.getNameByCode("CALL_TYPE", String.valueOf(resultVo.getCall_type())) %></td>
	            <td class="td_1" >呼叫结果</td>
	            <td class="td_2 "><%=BaseDataHelper.getNameByCode("CALL_RESULT", String.valueOf(resultVo.getCall_result())) %></td>
	        </tr>
	        <tr>
                <td  class="td_1" >员工对入职流程是否明确</td>
                <td  class="td_2" ><%=BaseDataHelper.getNameByCode("IS_UNDERSTAND", String.valueOf(resultVo.getIs_understand())) %></td>
                <td class="td_1" >员工不清晰流程记录</td>
                <td class="td_2 "><%=RmStringHelper.prt(resultVo.getCause_remark()) %></td>
            </tr>
            <tr>
                <td class="td_1" >备注</td>
                <td class="td_2 " colspan="3"><%=RmStringHelper.prt(resultVo.getOther_remark()) %></td>
            </tr>
	    </table> 
	    <div class="foot_button">
	        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
	    </div>    
    </div>
    </div></div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
%>
</script>
