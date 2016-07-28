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
<title>加班申请</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/OvertimehAction.do?cmd=queryAll&backFlag=true";
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
            <td  class="td_1"  width="23%" >加班类别</td>
            <td  class="td_2 " width="28%" >${bean.overtimetype}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.overtimebeginday}" type="date"/></td>
            <td class="td_1"  width="23%" >加班结束日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.overtimeendday}" type="date"/></td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班开始时间</td>
            <td class="td_2 " width="28%">${bean.overtimebegintime}</td>
            <td class="td_1"  width="23%" >加班结束时间</td>
            <td class="td_2 " width="28%">${bean.overtimeendtime}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班考勤开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.kqstartdate}" type="date"/></td>
            <td class="td_1"  width="23%" >加班考勤结束日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.kqenddate}" type="date"/></td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班考勤开始时间</td>
            <td class="td_2 " width="28%">${bean.kqendtime}</td>
            <td class="td_1"  width="23%" >加班考勤结束时间</td>
            <td class="td_2 " width="28%">${bean.kqendtime}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >计划开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.planbeginday}" type="date"/></td>
            <td class="td_1"  width="23%" >计划结束日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.planendday}" type="date"/></td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >计划开始时间</td>
            <td class="td_2 " width="28%">${bean.planbegintime}</td>
            <td class="td_1"  width="23%" >计划结束时间</td>
            <td class="td_2 " width="28%">${bean.planendtime}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班原因</td>
            <td class="td_2 " width="28%">${bean.reason}</td>
            <td  class="td_1"  width="23%" >实际加班时长</td>
            <td  class="td_2 " width="28%" >${bean.sumhour}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >申请日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.applydate}" type="date"/></td>
            <td  class="td_1"  width="23%" >合计加班工时</td>
            <td  class="td_2 " width="28%" >${bean.overtimesumhour}</td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >是否转调休</td>
            <td  class="td_2" width="28%">
                <%
                rayoo.workattendance.workattendanceapply.overtimeh.vo.OvertimehVo beanVo = (rayoo.workattendance.workattendanceapply.overtimeh.vo.OvertimehVo)request.getAttribute("bean");
                String bean_isstorest = "";
                if (beanVo != null){
                    bean_isstorest = String.valueOf(beanVo.getIstorest());
                }
                %>
                <%=BaseDataHelper.getNameByCode("TrueOrFalse",bean_isstorest)%> 
            </td>
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
