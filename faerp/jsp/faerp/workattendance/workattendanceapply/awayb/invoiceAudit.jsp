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
<title>出差申请</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
     function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
        form.action="<%=request.getContextPath()%>/AwaybAction.do?cmd=appOperate&approvestatus=3" ;
        form.submit();
         
    }
    
    //驳回操作
    function backOperate_onClick(){
        form.action="<%=request.getContextPath()%>/AwaybAction.do?cmd=appOperate&approvestatus=4" ;
        form.submit();
    }
 
</script>
</head>
<body>

<form name="form" method="post">
 <input type="hidden" id="taskuid" name="taskuid" value="${taskuid}">
 
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
            <td  class="td_1"  width="23%" >出差单编码</td>
            <td  class="td_2 " width="28%" >${bean.awayid}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >出差开始日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.awaybeginday}" type="date"/></td>
            <td class="td_1"  width="23%" >出差结束日期</td>
            <td class="td_2 " width="28%"><fmt:formatDate value="${bean.awayendday}" type="date"/></td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >出差开始时间</td>
            <td class="td_2 " width="28%">${bean.awaybegintime}</td>
            <td class="td_1"  width="23%" >出差结束时间</td>
            <td class="td_2 " width="28%">${bean.awayendtime}</td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >出差事由</td>
            <td class="td_2 " width="28%">${bean.awaynote}</td>
            <td class="td_1"  width="23%" >出差目的地</td>
            <td class="td_2 " width="28%">${bean.awayaddress}</td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >出差合计时数</td>
            <td  class="td_2" width="28%">${bean.awaysumhour}</td>
            <td  class="td_1"  width="23%" >申请日期</td>
            <td  class="td_2 " width="28%" ><fmt:formatDate value="${bean.applydate}" type="date"/></td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >预支费用</td>
            <td  class="td_2" width="28%">${bean.aheadfee}</td>
            <td  class="td_1"  width="23%" >出差工作完成情况</td>
            <td  class="td_2 " width="28%" >${bean.workfinish}</td>
        </tr>
    </table>
   
    <div class="xz_title"></div>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td  class="td_1" width="40%" >审核意见</td>
            <td  class="td_2" colspan="3">
                <textarea name="approveidea" rows="6" cols="50"></textarea>
            </td>
        </tr>
        </table>
   
    <div class="foot_button">
        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <%
        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
        %>
        <input name="button_app" class="foot_icon_2" type="button" value="审批同意"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
        <%} %>
      </div>
</div>         
            
</form>
</body>
</html>

