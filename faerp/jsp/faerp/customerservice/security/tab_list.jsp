<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%
String group_type = request.getParameter("group_type");
String security_type = request.getParameter("security_type");
%>
<fmt:bundle basename="rayoo.customerservice.security.security_resource" prefix="rayoo.customerservice.security.">
<html>
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
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>


<script language="javascript" src="/FAERP/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
 <script  language="javascript">
    var tabs;
     function updateData() { //定义修改状态时显示的标签页
        var group_type = '<%=group_type%>';
        var security_type = '<%=security_type%>';
        if(group_type == '1'){//上海社保
            tabs  =  new Array(
                 new Array ("<fmt:message key="agent_ss_account"/>","<%=request.getContextPath()%>/SocialaccountpvdAction.do?cmd=queryAll&group_type="+group_type+"&security_type="+security_type),
                 new Array ("<fmt:message key="cust_ss_account"/>","<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=queryAll&group_type="+group_type+"&security_type="+security_type)
                   );
        }else if(group_type == '2'){//上海公积金
             tabs  =  new Array(
                new Array ("<fmt:message key="agent_fund_account"/>","<%=request.getContextPath()%>/SocialaccountpvdAction.do?cmd=queryAll&group_type="+group_type+"&security_type="+security_type),
                new Array ("<fmt:message key="cust_fund_account"/>","<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=queryAll&group_type="+group_type+"&security_type="+security_type)
             //   new Array ("批量导入","<%=request.getContextPath()%>/EmpaccountAction.do?cmd=queryAll")
                  );
        }
        else if(group_type == '11'){//杭州社保
            tabs  =  new Array(
                 new Array ("<fmt:message key="agent_ss_account"/>","<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountpvd/listSocialaccountpvd_zj.jsp?group_type=1&security_type="+security_type),
                 new Array ("<fmt:message key="cust_ss_account"/>","<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountcust/listSocialaccountcust_zj.jsp?group_type=1&security_type="+security_type)
                   );
        }
        else if(group_type == '21'){//杭州公积金
            tabs  =  new Array(
                 new Array ("<fmt:message key="agent_fund_account"/>","<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountpvd/listSocialaccountpvd_zj.jsp?group_type=2&security_type="+security_type),
                 new Array ("<fmt:message key="cust_fund_account"/>","<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountcust/listSocialaccountcust_zj.jsp?group_type=2&security_type="+security_type)
                   );
        }
        else if(group_type == '3' || group_type == '4'){
            tabs  =  new Array(//异地社保公积金
              new Array ("<fmt:message key="agent_ss_fund_account"/>","<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountpvd/listOtherSocialaccountpvd.jsp?group_type="+group_type),
              new Array ("<fmt:message key="cust_ss_fund_account"/>","<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountcust/listOtherSocialaccountcust.jsp?group_type="+group_type)
              );  
        }
            
      
        
    }
 updateData(); 
 </script>
 
 <script src="/FAERP/js/template/tabs.js"></script>

</head>
<body>
<div id="right">
    <!--<div class="right_title_bg">
      <div class=" right_title">社保/公积金账号管理</div>
    </div>
--><div>
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

writeTabs(500);
</script>
</body>
</html>
</fmt:bundle>