<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>
 <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<title><fmt:message key="my_task"/></title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
        var form1 = document.getElementById("form1");
        form1.submit();
        jQuery("#doneSpan").click(function(){
            if(form1.target != "doneIframe"){
	            jQuery("#done").val("true");
	            form1.target="doneIframe";
	            form1.submit();
            }
        });
    });
</script>

</head>
<body> 
<script language="javascript">
    writeTableTop('<fmt:message key="my_task_list"/>','<venus:base/>/');
</script>
        <div id="container-1"> 
            <ul>
                <li><a href="#fragment-1"><span id="todoSpan"><fmt:message key="actived_task_list"/></span></a></li>
                <li><a href="#fragment-2"><span id="doneSpan"><fmt:message key="completed_task_list"/></span></a></li>
            </ul>
            <div id="fragment-1" class="table_div_content" >
                <iframe name="todoIframe"  width="100%" height="500px"
                           frameborder= "0"    marginheight= "0" marginwidth= "0"></iframe>
            </div>
            <div id="fragment-2" class="table_div_content">
                <iframe name="doneIframe" width="100%" height="500px"
                           frameborder= "0"    marginheight= "0" marginwidth= "0"></iframe>
            </div>
            <form id="form1" action="<venus:base/>/dynamicQueryTaskByPersonIDAction.do" target="todoIframe">
                <input name="done" id="done" value="false" type="hidden"/>
                <input name="procName" value='<%=request.getParameter("procName") %>' type="hidden"/>
            </form>
        </div>


<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>