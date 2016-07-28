<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>休假申请</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/LeavehAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td  class="td_1" width="23%" >客户名称</td>
            <td  class="td_2" colspan="3">${bean.customer_name}</td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >申请单据名称</td>
            <td  class="td_2" width="28%">${bean.billname}</td>
            <td  class="td_1"  width="23%" >申请人</td>
            <td  class="td_2 " width="28%" >${bean.applier_name}</td>
        </tr>
         <tr>
            <td  class="td_1" width="23%" >申请部门</td>
            <td  class="td_2" width="28%">${bean.applydept}</td>
            <td  class="td_1"  width="23%" >休假假别</td>
            <td  class="td_2 " width="28%" >${bean.leavetype}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >休假开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.leavebeginday}" type="date"/></td>
            <td class="td_1"  width="23%" >休假结束日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.leaveendday}" type="date"/></td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >休假开始时间</td>
            <td class="td_2 " width="28%">${bean.leavebegintime}</td>
            </td>
            <td class="td_1"  width="23%" >休假结束时间</td>
            <td class="td_2 " width="28%">${bean.leaveendtime}</td>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >计划开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.planbeginday}" type="date"/></td>
            <td class="td_1"  width="23%" >计划结束日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.leaveendday}" type="date"/></td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >休假事由</td>
            <td class="td_2 " width="28%">${bean.leavenote}</td>
            <td class="td_1"  width="23%" >假别周期开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.leavecycbegindate}" type="date"/></td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >休假合计工时</td>
            <td  class="td_2" width="28%">${bean.leavesumhour}</td>
            <td  class="td_1"  width="23%" >实际休假时长</td>
            <td  class="td_2 " width="28%" >${bean.sumhour}</td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >结余天数/小时</td>
            <td  class="td_2" width="28%">${bean.restdayorhour}</td>
            <td  class="td_1"  width="23%" >享有天数/小时</td>
            <td  class="td_2 " width="28%" >${bean.realdayorhour}</td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >工作交接情况</td>
            <td  class="td_2" width="28%">${bean.workprocess}</td>
            <td  class="td_1"  width="23%" >工作交接人</td>
            <td  class="td_2 " width="28%" >${bean.emp_name}</td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >销假状态</td>
            <td  class="td_2" width="28%">
                 <%
                rayoo.workattendance.workattendanceapply.leaveh.vo.LeavehVo beanVo = (rayoo.workattendance.workattendanceapply.leaveh.vo.LeavehVo)request.getAttribute("bean");
                String bean_leaveoffstatus = "";
                if (beanVo != null){
                    bean_leaveoffstatus = String.valueOf(beanVo.getLeaveoffstatus());
                }
                %>
                <%=BaseDataHelper.getNameByCode("LEAVE_OFF_STATUS",bean_leaveoffstatus)%> 

            </td>
            <td  class="td_1"  width="23%" >销假日期</td>
            <td  class="td_2 " width="28%" ><fmt:formatDate value="${bean.backdate}" type="date"/></td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >假期联系电话</td>
            <td  class="td_2" width="28%">${bean.relatetel}</td>
            <td  class="td_1"  width="23%" >备注</td>
            <td  class="td_2 " width="28%" >${bean.remark}</td>
        </tr>
    </table>
   
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>  
</div>         
</form>
</body>
</html>
