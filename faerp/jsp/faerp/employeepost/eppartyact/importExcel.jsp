<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
String act_id = request.getParameter("act_id");
System.out.println(request.getAttribute("errorcount"));
int errorcount=request.getAttribute("errorcount")==null?0:(Integer)request.getAttribute("errorcount");
int allcount=request.getAttribute("allcount")==null?0:(Integer)request.getAttribute("allcount");
%>
<html>
<fmt:bundle basename="rayoo.employeepost.eppartyact.eppartyact_resource" prefix="rayoo.employeepost.eppartyact.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 

<title><fmt:message key="imp_lectures_party_act_emp"/></title>

</head>
<script>

    
    function Upload(){
        var attachName = document.getElementById("attachNameInput").value;
        var act_id = document.getElementById("act_id").value;
        if(attachName==null&&attachName==""){
            alert("<fmt:message key="uplord_file_is_null"/>");
            return ;
        }else{
            var  length = attachName.lastIndexOf(".");
            var postfix = attachName.substring(length+1,attachName.length);
            if(postfix!="xls"&&postfix!="xlsx"){
                alert("<fmt:message key="uplord_file_is_not_excel"/>");
                document.getElementById("attachNameInput").value="";
                return ;
            }else if (checkAllForms()){
		        form.action="<%=request.getContextPath()%>/EppartyactitemAction.do?cmd=importToExcel&act_id=<%=act_id%>";
		        form.submit();
            }
        }
    }
    
    function downLoad_onClick(){
        form.action="<%=request.getContextPath()%>/EppartyactitemAction.do?cmd=downLoadExcel";
        form.submit();
    }
    
    //查看导入错误的原因
        function openError_onClick()
    {
         var url = "<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyact/errorDesc.jsp";
         showModalCenter(url, window,null,750,400,"查看错误信息");
    }
</script>
<body>
 
<form name="form" id="inputform" method="post" enctype="multipart/form-data">
<input type="hidden" name="act_id" id="act_id" value="<%=act_id %>"/>
        <div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
    <%
        if(errorcount>0){
        %>
        <center><a style="color: red;" href="#" onClick="javascript:openError_onClick();"><fmt:message key="notice1"/><%=allcount %><fmt:message key="notice2"/><%=errorcount %><fmt:message key="notice3"/></a></center>
        <%
    }
    %>
</div>

<div id="ccChild0" class="box_3"> 
    <table width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
       <tr>
       <td class="td_1"  style="width: 200px;"><fmt:message key="excel_format"/>：</td>
            <td class="td_2">   
                <fmt:message key="party_code"/>&nbsp;<fmt:message key="emp_name"/>&nbsp;<fmt:message key="sex"/>&nbsp;<fmt:message key="email"/>&nbsp;<fmt:message key="tel"/>&nbsp;
            </td>
       </tr>
        <tr>
            <td class="td_1"  style="width: 200px;"> <fmt:message key="file_uplord"/>：</td>
            <td class="td_2">   

                <input type="file"  id="attachNameInput" name="attachNameInput"/>
            </td>
            
        </tr>
    </table>
</div>


    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="templete_downlord"/>' onClick="javascript:downLoad_onClick();">
<input type="button" class="foot_icon_1" value='<fmt:message key="imp"/>'  onclick="javascript:Upload();" />
<input type="button" class="foot_icon_1" value='<fmt:message key="close"/>'  onclick="javascript:window.close();" />
</div>


</div>


     </div>

</form>

</body>
</fmt:bundle>
</html>
