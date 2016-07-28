<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.tablist_resource' prefix='auto.'>
<head>
<script language="javascript">
    var dir_base = "/FAERP";
</script>
<%
String security_type = request.getParameter("security_type");
%>

<link href="/FAERP/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript" src="/FAERP/js/jquery/jquery-1.3.min.js"></script>
<script type='text/javascript' src='/FAERP/js/common/variable-i18n_zh.js'></script>

<link href="/FAERP/css/alex-css.jsp" type="text/css" rel="stylesheet">
<!-- liuping add -->
<link href="/FAERP/css/common.css" type="text/css" rel="stylesheet">

<link href="/FAERP/css/index.css" type="text/css" rel="stylesheet">
<link href="/FAERP/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>


<script language="javascript" src="/FAERP/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='tablist0000'/></title>
 <script  language="javascript">
    var tabs;
       var security_type = '<%=security_type%>';
     function updateData() { //定义修改状态时显示的标签页
     if(security_type=='1'){
              tabs  =  new Array(   
            new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listSecurityPay&security_type=1"),
            new Array ("<fmt:message key='tablist0002'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listSecurityFind")
        );
     }
     else if(security_type=='3'){//镇保
        tabs  =  new Array(   
            new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listSecurityPay&security_type=3"),
            new Array ("<fmt:message key='tablist0002'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listZhenBaoFind")
            );
     }
     else if(security_type=='4'){//综保
        tabs  =  new Array(   
            new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listSecurityPay&security_type=4"),
            new Array ("<fmt:message key='tablist0002'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listZongBaoFind")
            );
     }else if(security_type=='5'){//异地社保
        tabs  =  new Array(   
            new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listYdSecurityPay&security_type=1"),
            new Array ("<fmt:message key='tablist0002'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listYDSheBaoFind")
            );
     }else if(security_type=='6'){//异地公积金
        tabs  =  new Array(   
            new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listYdSecurityPay&security_type=2"),
            new Array ("<fmt:message key='tablist0002'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listYDGongJiJinFind")
            );
     }
     else{
           tabs  =  new Array(   ///EmpsecurityAction.do?cmd=queryAll
               new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listSecurityPay&security_type=2"),
      //       new Array ("<fmt:message key='tablist0001'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listshebaoPay"),
            new Array ("<fmt:message key='tablist0002'/>","<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listshebaoFind")
        );
     
     }
      
        
    }
 updateData(); 
 </script>
 
 <script src="/FAERP/js/template/tabs.js"></script>

</head>
<body>
<div id="right">
<div>
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

writeTabs(600);
</script>
</body>
</fmt:bundle>
</html>