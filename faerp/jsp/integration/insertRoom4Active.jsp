<%@ page pageEncoding="UTF-8"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/workflowForm/global4wf.jsp" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<html>
<fmt:bundle basename="gap.template.simple_resource" prefix="gap.template.simple.">
<head>
<%
      boolean is4Aprove = false;
      if(!StringUtils.isEmpty((String)request.getAttribute("is4Aprove")))
          is4Aprove = true;
%>
<title><%=is4Aprove?LocaleHolder.getMessage("gap.wf.approval_page"):LocaleHolder.getMessage("gap.wf.countersigned_page")%></title>
</head>
<body>
<script language="javascript">
	writeTableTop('<%=is4Aprove?LocaleHolder.getMessage("gap.wf.approval_page"):LocaleHolder.getMessage("gap.wf.countersigned_page")%>','<venus:base/>/');
	function commit(){
	   form.action="<venus:base/>/CheckRoomAction.do?cmd=commit";
	   collectRelevantData("wfForm");//调用工作流的方法来收集相关数据。
	   form.submit();
	}
	function approve(){
       form.action="<venus:base/>/ApproveRoomAction.do?cmd=approve";
       collectRelevantData("wfForm");//调用工作流的方法来收集相关数据。
       form.submit();
    }
</script>

<form name="form" method="post" id="wfForm">
	<input type="hidden" name="id" value="${room.id }">
	<table class="table_noframe">
		<tr>
			<td valign="middle">
				<input name="button_save" type="button" class="button_ellipse" value='<%=LocaleHolder.getMessage("gap.wf.submitt_workitem") %>' onClick="javascript:<%=is4Aprove?"approve()":"commit()"%>"/>
				<input name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="cancel" bundle="${applicationResources}"/>'  onClick="javascript:history.go(-1);">
			</td>
		</tr>
	</table>
	
	<div id="ccParent1"> 
	<table class="table_div_control">
		<tr> 
			<td>
				<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
				    <%=is4Aprove?LocaleHolder.getMessage("gap.wf.approval_page"):LocaleHolder.getMessage("gap.wf.countersigned_page")%>
			</td>
		</tr>
	</table>
	</div>
	
	<div id="ccChild1"> 
	<table class="table_div_content">
		<tr> 
			<td align="right" width="10%" nowrap><fmt:message key="BuildingName"/> </td>
			<td align="left">
				<input name="build_Id" type="hidden" value="1099100100000000001">
				<input name="build_name" type="text" value="翠微阁" class="text_field"  readonly="readonly">
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="RoomName"/></td>
			<td align="left">
				<input name="name" type="text" class="text_field"  value="${room.name }"  readonly="readonly">
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="BuildingArea"/></td>
			<td align="left">
				<input name="area" type="text" class="text_field"  value="${room.area }"  readonly="readonly">			
			</td>
		</tr>
			<tr>
			<td align="right"><fmt:message key="RoomType"/></td>
			<td align="left">
				<!-- select name="type" value="${room.type}"  readonly="readonly">
	                <option value="1">普通住宅</option>
	                <option value="0">商业住宅</option>
                </select-->
                <input type="text" name="type" class="text_field" value="${room.type }" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="RoomRate"/></td>
			<td align="left">
				<input name="price" type="text" class="text_field" value="${room.price }" readonly="readonly" >			
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="IsVacant"/></td>
			<td align="left">
					<!-- select name="is_Empty" value="${room.is_Empty }"  readonly="readonly">
                    <option value="1">是</option>
                    <option value="0">否</option>
                </select-->
                <input type="text" name="is_Empty" class="text_field" value="${room.is_Empty }" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="CheckinDate"/></td>
			<td align="left">
				<input name="residing_Date" type="text" class="text_field"  readonly="readonly"  value="${room.residing_Date }">
			</td>
		</tr>
		<tr>
	        <td align="right"><%=LocaleHolder.getMessage("gap.wf.countersigned_views") %></td>
	        <td align="left">
	            <input name="checkMind" type="text" class="text_field" >          
	        </td>
	    </tr>
	    <tr>
	          <td align="right"><%=LocaleHolder.getMessage("gap.wf.idea_list") %></td>
	          <td align="left" id="listname">[会签意见列表]</td>
	     </tr>
	     <tr>
		        <td align="right"><%=LocaleHolder.getMessage("gap.wf.attachment_index") %></td>
		        <td align="left">
		                    <span id="Alexander.Attachment" contenteditable="false" _id="Alexander.Attachment" _name="attachment1">[附件]</span>
		        </td>
	     </tr>
	     <%if(is4Aprove){ %>
	     <tr>
	                <td align="right"><%=LocaleHolder.getMessage("gap.wf.approval_result") %></td>
	                <td align="left">
	                           <select name="isPass" <data:relevantData/>>
	                                <option value="yes">通过</option>
	                                <option value="no">不通过</option>
	                           </select>
	                </td>
	         </tr>
		     <tr>
		            <td align="right"><fmt:message key="remark" bundle="${applicationResources}"/></td>
		            <td align="left">
		                       <input name="brief" type="text" class="text_field" value="${room.brief }">      
		            </td>
		     </tr>
	     <%} %>
	</table>
	</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>
