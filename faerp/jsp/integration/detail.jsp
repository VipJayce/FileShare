<%@ page pageEncoding="UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/workflowForm/global4wf.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<html>
<fmt:bundle basename="gap.template.simple_resource" prefix="gap.template.simple.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="DetailTable" /> </title>
</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="DetailTable" />','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
    <tr>
        <td>
            <!-- 
            <input name="button_update" class="button_ellipse" type="button" value="修改" onClick="javascript:find_onClick();">
            <input name="button_delete" class="button_ellipse" type="button" value="删除" onClick="javascript:delete_onClick();">
            -->
            <input name="button_back" class="button_ellipse" type="button" value='<fmt:message key="return" bundle="${applicationResources}"/>'  onclick="javascript:history.go(-1);" >
        </td>
    </tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="DetailTable" />
        </td>
    </tr>
</table>
</div>

<div id="ccChild0"> 
<table class="viewlistCss" style="width:100%"  cellspacing="1">
    <tr> 
        <th align="right" width="10%" nowrap><fmt:message key="BuildingName" /></th>
        <td align="left">翠微阁</td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="RoomName" /></th>
        <td align="left">${room.name }</td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="BuildingArea" /></th>
        <td align="left">${room.area }</td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="RoomType" /></th>
        <td align="left">${room.type }</td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="RoomRate" /></th>
        <td align="left">${room.price }</td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="IsVacant" /></th>
        <td align="left">${room.is_Empty }</td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="CheckinDate" /></th>
        <td align="left">${room.residing_Date }
        
        </td>
    </tr>
     <tr>
          <th align="right"><%=LocaleHolder.getMessage("gap.wf.countersigned_views") %><div><input name="checkMind" type="hidden" class="text_field" > </div> </th>
          <td align="left" id="listname">[会签意见列表]</td>
     </tr>
     <tr>
            <th align="right"><%=LocaleHolder.getMessage("gap.wf.attachment_index") %></th>
            <td align="left">
                        <span id="Alexander.Attachment" contenteditable="false" _id="Alexander.Attachment" _name="attachment1">[附件]</span>
            </td>
     </tr>
    <tr>
        <th align="right"><fmt:message key="remark" bundle="${applicationResources}"/> </th>
        <td align="left">${room.brief }</td>
    </tr>
</table>
</div>
</form>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>