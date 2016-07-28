<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="gap.quartz.scheduledata.bo.DefinitionManager"%>
<%@ page import="gap.quartz.scheduledata.bo.JobDefinition"%>
<%@ page import="gap.quartz.extend.QuartzUtil"%>

<%
    DefinitionManager def = (DefinitionManager)session.getServletContext().getAttribute(QuartzUtil.JOB_DEFINITIONS_PROP);
    Map defMap = def.getDefinitions();
    String jobName = "";
    if(defMap ==null)
    {
        System.out.println("defMap is null--------");
    }
%>
<html>
<fmt:bundle basename="gap.quartz.quartz_resource" prefix="gap.quartz.">
<head>
<script language="javascript">
function button1_onclick(){
window.returnValue=document.form1.jobName.value;
    //window.opener.location.href="<%=request.getContextPath()%>/createJobForm.do?cmd=doCreateJobForm";
    //window.opener.location.reload();
//window.opener.document.form1.jobName.value=document.form1.jobName.value;
//changeJobOthers(window.opener.document.form1); 

//window.opener.checkJobClass();
window.close();
}

function changeJobOthers(obj){
//alert("obj.value = "+obj.value);
    <%if(defMap!=null)
    {
        for(Iterator iter=defMap.entrySet().iterator(); iter.hasNext();){
            Map.Entry entry = (Map.Entry)iter.next();
            jobName = (String)entry.getKey();
            //System.out.println("jobName = "+jobName);
            %>
            if(obj.jobName.value=="<%=jobName%>"){
            obj.jobGroup.value="test";
            obj.className.value="<%=((JobDefinition)entry.getValue()).getClassName()%>"
            //alert(" classname"+"<%=((JobDefinition)entry.getValue()).getClassName()%>");
            obj.className.readOnly=true;
            obj.description.value="<%=((JobDefinition)entry.getValue()).getDescription()%>";
            return;
            }
            <%
        }   
    }
    %>
}

</script>
</head>
<body>

<script language="javascript">
    writeTableTop('<fmt:message key="Create_Job"/>','<venus:base/>/');
</script>

<form name="form1" id="form1" method="post" >
<div id="ccParentq"> 
<table class="table_div_control">
    <tr>
        <td>
        <img src="<venus:base/>/images/icon/07.gif" onClick="javascript:hideshow('ccChildq',this,'<venus:base/>/')">
            <fmt:message key="Select_Job"/>
        </td>
    </tr>
</table>
</div>
<div id="ccChildq"><span id="pos"></span>
<table id="jobTable" class="table_div_content" border="0">
    <tr >
        <td><select id="jobName" style="width:140">
            <%
            for(Iterator iter=defMap.entrySet().iterator();iter.hasNext();){
                Map.Entry entry = (Map.Entry)iter.next();
                out.println("<option value="+entry.getKey()+" >"+entry.getKey()+"</option>");
            }
            %>
            </select>&nbsp;&nbsp;
        </td>
        <td><input type="button" class="button_ellipse" value='<fmt:message key="Confirm"/>' onclick="return button1_onclick();">
        </td>
    </tr>
</table>
</div> 
</form>
</fmt:bundle>

<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>

<body>
</html>