<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.alexander.flowdesign.util.IConstants" %>
<%@ page import="gap.wf.wapi.state.ProcDefState" %>
<%@ page import="com.use.tools.helper.VoHelperTools" %>
<!--马啸添加start-->
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList,java.util.HashMap"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@page import="com.alexander.flowdesign.util.FlowSectionCache"%>
<!--马啸添加end-->

<%
    String typeId = request.getParameter(IConstants.TYPE_ID);
    if(typeId == null) {
        typeId = (String)request.getAttribute(IConstants.TYPE_ID);
    }

    if (typeId != null) {
        typeId = URLEncoder.encode(typeId,"GBK");
    }
    
    //马啸添加start
        EnumRepository er = EnumRepository.getInstance();
        er.loadFromDir();
        EnumValueMap sectionMap = er.getEnumValueMap("Section");
    //马啸添加end
    FlowSectionCache sections = FlowSectionCache.getInstance();
%>
<html>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
  
var typeId = '<%=typeId%>';

    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array1 = arrayAll[0];
 
                ids.push(array1);  //加入选中的checkbox
                //马啸添加
                return ids;
            }
        }
        return ids;
    }

    function findSelect(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var state = null;  //定义状态值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(state == null) {
                    state = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array2 = arrayAll[1];

                state.push(array2);  //加入选中的checkbox
                //马啸添加
                return state;
            }
        }
        return state;
    }

    function findSelectWfsection(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var section = null;  //定义状态值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(section == null) {
                    section = new Array(0);
                }
                var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array3 = arrayAll[2];

                section.push(array3);  //加入选中的checkbox
                //马啸添加
                return section;
            }
        }
        return section; 
    }
    
    function monitor_onClick(thisId){  //实现转到详细页面
        var ids = findSelections("checkbox_template","WF_ID");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert(i18n.please_select_a_record)
            return;
        }
        if(ids.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        form.queryCondition.value = "clearPage";
        form.action= '<%=request.getContextPath()%>/MonitorProcInstsByMainDefIdAction.do?mainDefId='+ids;
        form.submit();
    }
    
    function copyFlowDefine(){
        var _id  = findSelections("checkbox_template","WF_ID");
        if(_id == null){
            alert('<fmt:message key="please_select_process_definition"/>');
            return false;
        }
        if(_id.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        if(window.confirm('<fmt:message key="confirm_to_copy_to_the_current_category"/>')){
            //马啸注释
            //window.location.href = '<%=request.getContextPath()%>/flowQuery.do?id='+ _id
            //  +'&typeId=<%=typeId%>&pstate=addcopy';
            //马啸添加
            window.location.href = '<%=request.getContextPath()%>/flowQuery.do?id='+ _id
                +'&typeId='+document.getElementById("flowType").value+'&pstate=addcopy';
            
        }
        return true;
    }
    
    function EditFlowDefine()
    {
        var _ids  = findSelections("checkbox_template","WF_ID");
       
        if(_ids == null){
            alert('<fmt:message key="please_select_process_definition"/>')
            return false;
        }
        if(_ids.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        var _states  = findSelect('checkbox_template','WF_STATE');
        if(_states != <%=ProcDefState.WF_STATE_NORMAL.getCodeStr()%> && _states != <%=ProcDefState.WF_STATE_NEW.getCodeStr()%> )
        {
            alert('<fmt:message key="modify_process_definition_error"/>')
            return false;
        }
        if(!window.confirm('<fmt:message key="whether_to_modify_this_process"/>')){
            return;
        }
        window.location.href = '<%=request.getContextPath()%>/flowQuery.do?id=' + _ids +'&typeId=<%=typeId%>&pstate=edit';
        return true;
    }
    
    function publishFlowDefines()
    {
        var _id  = findSelections("checkbox_template","WF_ID");
        if(_id == null){
            alert('<fmt:message key="please_select_process_definition"/>')
            return false;
        }
        if(_id.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        var _states  = findSelect("checkbox_template","WF_STATE");
        if(_states != <%=ProcDefState.WF_STATE_NORMAL.getCodeStr()%> )
        {
            alert('<fmt:message key="publish_process_definition_error"/>')
            return false;
        }
        if(!window.confirm('<fmt:message key="whether_to_publish_this_process"/>')){
            return;
        }
        var _section = findSelectWfsection('checkbox_template','WF_SECTION');
        /*马啸注释
        window.location.href = '<%=request.getContextPath()%>/flowPublish.do?publishedid=' + _id 
            + '&typeId=<%=(typeId==null)?"'+_section+'":typeId%>&pstate=true';
        */
        //马啸添加
        window.location.href = '<%=request.getContextPath()%>/flowPublish.do?publishedid=' + _id 
            + '&typeId='+document.getElementById("flowType").value+'&pstate=true';
        return true;
    }
    
    function cancelPublishFlowDefine(){
        var _id = findSelections("checkbox_template","WF_ID");
        var _states  = findSelect("checkbox_template","WF_STATE");
        if(_id == null){
            alert('<fmt:message key="please_select_process_definition"/>')
            return false;
        }
        if(_id.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        if(_states != <%=ProcDefState.WF_STATE_PUBLISH.getCodeStr()%>)
        {
            alert('<fmt:message key="please_unpublish_the_published_process"/>')
            return false;
        }
        if(!window.confirm('<fmt:message key="whether_to_unpublish_the_process"/>')){
            return;
        }
        var _section = findSelectWfsection('checkbox_template','WF_SECTION');
        /*马啸注释
        window.location.href = '<%=request.getContextPath()%>/flowPublish.do?publishedid=' + _id 
            + '&typeId=<%=(typeId==null)?"'+_section+'":typeId%>&pstate=false';
        */
        //马啸添加
        window.location.href = '<%=request.getContextPath()%>/flowPublish.do?publishedid=' + _id 
            + '&typeId='+document.getElementById("flowType").value+'&pstate=false';
        return true;
    }
    
    function deleteFlowDefine()
    {
        var _id  = findSelections("checkbox_template","WF_ID");
        var _states = findSelect('checkbox_template','WF_STATE');
        var _section = findSelectWfsection('checkbox_template','WF_SECTION');
        if(_id == null){
            alert('<fmt:message key="please_select_process_definition"/>');
            return false;
        }
        if(_id.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        if(_states == <%=ProcDefState.WF_STATE_PUBLISH.getCodeStr()%>)
        {
            alert('<fmt:message key="can_only_delete_the_non_published_process"/>');
            return false;
        }
        if (confirm('<fmt:message key="whether_to_delete"/>')){
            //马啸注释
            //window.location.href = "<%=request.getContextPath()%>/flowFileDelete.do?<%=IConstants.REQUEST_ID_FLAG%>="+_id +"&WF_SECTION="+ _section;
            //马啸添加
            window.location.href = "<%=request.getContextPath()%>/flowFileDelete.do?<%=IConstants.REQUEST_ID_FLAG%>="+_id+"&WF_SECTION=";
        }else{
            return false;
        }
        /*作废*/
        return true;
    }
    
    function detail_onClick(thisId){  //实现转到详细页面
        var ids = findSelections("checkbox_template","WF_ID");
        if(ids == null) {
            alert(i18n.please_select_a_record)
            return;
        }
        if(ids.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        window.location.href= '<%=request.getContextPath()%>/flowQuery.do?id='+ids+'&typeId=<%=typeId%>&pstate=show';
        /*form.submit();*/
    }
    
    function startProcess(){
        var ids = findSelections("checkbox_template","WF_ID");
        if(ids == null) {
            alert(i18n.please_select_a_record)
            return;
        }
        if(ids.length > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        if(!window.confirm('<fmt:message key="whether_to_launch_this_process"/>')){
            return;
        }
        form.action="<%=request.getContextPath()%>/startprocess.do?mainDefId=" + ids;
        form.submit();
    }
    
    function getFlowSection(event){
    var obj = window.showModalDialog('<venus:base/>/jsp/flowdesign/sectionFrame.jsp?is4Query=true','','dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;status:0;');
        if(obj) {
            document.form.flowType.value = obj["id"];
            document.form.WF_SECTION_NAME.value = obj["name"];
        }
}
    
    //马啸添加start
    function search_OnClick(){
        if(checkAllForms()){
            form.submit();
        }
    }
    //马啸添加end
</script>

</head>
<body>

<%
String path = "";
if ("true".equals(request.getParameter("published"))) {
//  if (request.getParameter("WF_SECTION") != null && "通用类流程".equals(URLDecoder.decode(request.getParameter("WF_SECTION"), "GBK"))) {
//      path = "sectionQuery.do?published=true&WF_SECTION=" + URLEncoder.encode("通用类流程","GBK");
//  } else {
        path = "definesQuery.do?published=true";
//  }
} else if ("true".equals(request.getParameter("monitor"))) {
//  if (request.getParameter("WF_SECTION") != null && "通用类流程".equals(URLDecoder.decode(request.getParameter("WF_SECTION"), "GBK"))) {
//      path = "sectionQuery.do?monitor=true&WF_SECTION=" + URLEncoder.encode("通用类流程","GBK");
//  } else {
        path = "definesQuery.do?monitor=true";
//  }
} else {
//  if (request.getParameter("WF_SECTION") != null) {
//      path = "FlowAction.do?WF_SECTION=" + URLEncoder.encode(request.getParameter("WF_SECTION"),"GBK");
//  } else {
        path = "definesQuery.do";
//  }
}
%>

<form name="form" method="post" action="<%=request.getContextPath()%>/<%=path%>">
<input type="hidden" name="id" value="">
<input type="hidden" name="isPrint" value="">
<input type="hidden" name="queryCondition" value="">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="process_definition_list"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 <%if(!("true".equals(request.getParameter("published")))){%>
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
		 <td align="right" width="10%" nowrap><fmt:message key="process_type"/></td>
        <td>
                 <input type="hidden" name="flowType" id="flowType"/>
                <input id="WF_SECTION_NAME" name="WF_SECTION_NAME" type="text" class="text_field_reference"  validate="isSearch" readOnly="true"><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getFlowSection(event);" class="img_1">
        </td>
       <td align="right" width="10%" nowrap><fmt:message key="process_name"/></td>
        <td>
            <input name="flowName" type="text" class="text_field" validate="isSearch" inputName='<fmt:message key="process_name"/>' >
            <input type="button" name="btnSubmit" class="button_ellipse" value='<fmt:message key="query" bundle="${applicationResources}" />' onclick="search_OnClick()">
            <input type="reset"  class="button_ellipse" name="Reset" value='<fmt:message key="clear" bundle="${applicationResources}" />' >
        </td>
			<td align="right"></td>
		</tr>
		 
		 
		
</table>
</div>

<%}%>

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
				 <table >
                <tr>
                    <td nowrap class="button_ellipse" onClick = "javascript:detail_onClick();">
                    <img src="<%=request.getContextPath()%>/images/icon/search.gif" class="div_control_image"><fmt:message key="view" bundle="${applicationResources}" /></td>
                    <%if("true".equals(request.getParameter("published"))){%>
                        <td nowrap class="button_ellipse" onClick = "javascript:startProcess();">
                        <img src="<%=request.getContextPath()%>/images/icon/print.gif" class="div_control_image"><fmt:message key="launch"/></td>
                    <%}else if("true".equals(request.getParameter("monitor"))){%>
                        <td nowrap class="button_ellipse" onClick = "javascript:monitor_onClick();">
                        <img src="<%=request.getContextPath()%>/images/icon/search.gif" class="div_control_image"><fmt:message key="monitor"/></td>
                    <%}else{%>
                        <td nowrap class="button_ellipse" onClick = "window.location.href='<%=request.getContextPath()%>/flowQuery.do?pstate=add&WF_PACKAGE=Alexander'">
                        <img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="add" bundle="${applicationResources}" /></td>
                        <td nowrap class="button_ellipse" onClick = "javascript:EditFlowDefine();">
                        <img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify" bundle="${applicationResources}" /></td>
                        <td nowrap class="button_ellipse" onClick = "javascript:deleteFlowDefine();">
                        <img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete" bundle="${applicationResources}" /></td>
                        <td nowrap class="button_ellipse" onClick = "javascript:copyFlowDefine();">
                        <img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="copy"/></td>
                        <td nowrap class="button_ellipse" onClick = "javascript:cancelPublishFlowDefine();">
                        <img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="cancel" bundle="${applicationResources}" /></td>   
                        <td nowrap class="button_ellipse" onClick = "javascript:publishFlowDefines();">
                        <img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="publish"/></td>
                    <%}%>
                </tr>
            </table>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box"  style="height:380px"> 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th ><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>流程类别 </th>
<th>流程名称</th>
<th>流程状态</th>
<th>创建者</th>
<th>创建日期</th>
<th>流程版本 </th>
<th>描述</th>
</tr>
<logic:iterate     name="defines"  id="defines_id" scope="request" indexId="indexs">
		<tr>
		<td > 
               <bean:define id="wy3" name="defines_id" property="WF_ID"/>
                <bean:define id="wy4" name="defines_id" property="WF_STATE"/>
                <bean:define id="wy5" name="defines_id" property="WF_SECTION"/>
                <%
                String s = URLEncoder.encode(wy5.toString(),"GBK");
                %>
                <input title="<%=LocaleHolder.getMessage("process")+wy3%>" type="radio" name="checkbox_template" value="<%=wy3 + "," + wy4+ "," + s%>"/>
        </td>

<td>  <bean:define id="sectionId" property="WF_SECTION" name="defines_id"></bean:define>
                 <%=sections.get((String)sectionId) %>   </td>
			
			<td><bean:write name="defines_id" property="WF_NAME"/>   </td>
			
			<td> <bean:define type="String" id="wfsn" name="defines_id" property="wfStateName"/>
                <%=wfsn%>   </td>
               
              <td><bean:write name="defines_id" property="WF_OPERATOR"/>   </td>
              <td>  <bean:define type="String" id="wyx" name="defines_id" property="WF_TIME"/>
                <%=(wyx==null)?"":wyx.substring(0,4)+"-"+wyx.substring(4,6)+"-"+wyx.substring(6,8)+" "
                    +wyx.substring(8,10)+":"+wyx.substring(10,12)+":"+wyx.substring(12,14)%>  </td>
              <td><bean:write name="defines_id" property="WF_VERSION"/>   </td>  
			   <td><bean:write name="defines_id" property="WF_DESC"/>   </td>  
			</tr>
</logic:iterate>

</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

</div>
</div>
 
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<%  //表单回写
    if(request.getAttribute("writeBackFormValues") != null && !("true".equals(request.getParameter("published")))) {
        out.print("<script language=\"javascript\">\n");
        out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
        out.print("writeBackMapToForm();\n");
        out.print("</script>");
    }
%>