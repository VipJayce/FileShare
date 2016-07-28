<%@include file="/common/common.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<script language="javascript">
	var dir_base = "/FAERP";
</script>

<link href="/FAERP/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript" src="/FAERP/js/jquery/jquery-1.3.min.js"></script>
<script type='text/javascript' src='/FAERP/js/common/variable-i18n_zh.js'></script>

<link href="/FAERP/css/alex-css.jsp" type="text/css" rel="stylesheet">
<!-- liuping add -->
<link href="/FAERP/css/common.css" type="text/css" rel="stylesheet">

<link href="/FAERP/css/index.css" type="text/css" rel="stylesheet">
<link href="/FAERP/css/tabs.css.jsp" rel="stylesheet" type="text/css">



<script language="javascript" src="/FAERP/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
 <script  language="javascript">
    var tabs;
     function updateData() { //定义修改状态时显示的标签页
        tabs  =  new Array(
            
            new Array ("<fmt:message key="post_notice_or_exam"/>","<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryNoticeExam"),
            new Array ("<fmt:message key="apply_off_post_notice"/>","<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryQuitNotice")
        );
        
    }
 updateData(); 
 </script>
 
 <script src="/FAERP/js/template/tabs.js"></script>

</head>
<body>

    <table class="table_div_content" style="width:100%">
        <tr>
            <td>
                <table width="100%">
                  <tr>
                    <td>
                    <div id="tabsDiv"></div>
                    </td>
                </tr>
                </table>
            </td>
        </tr>
    </table>
</div>  

</div>
<script type="text/javascript">

writeTabs(480);
</script>
</body>
</fmt:bundle>
</html>
