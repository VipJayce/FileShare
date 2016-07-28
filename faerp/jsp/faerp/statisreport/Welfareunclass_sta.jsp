<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
String login_user_name="";
LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
if(null!=loginVo){
    login_user_name=loginVo.getName();
}
%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>福利未分类统计报表</title>
<script language="javascript">
    function exportEXCEL_onClick(){
        var start_date = document.form.start_date.value;
        var end_date = document.form.end_date.value;
        var busitype = document.getElementById("busitype").value;
        var user_id = document.getElementById("userlist").value;
        var url = "";
        if(start_date==null || start_date==""){
            alert("报入职起始日期不能为空！");
            return;
        }
        if(end_date==null || end_date==""){
            alert("报入职结束日期不能为空！");
            return;
        }
        if(start_date.replace('-','').replace('-','')>end_date.replace('-','').replace('-','')){
            alert("报入职起始不能大于结束日期！");
            return;
        }
        //if(busitype=="0" || busitype==null || busitype==""){
          //  alert("请选择业务类型！");
            //return ;
        //}
        //$id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_YXBTJ_credisfinish.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
        //$id("datacell_formid").submit();
        url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showWelfareunclass.jsp?raq=WELFAREUNCLASS_STA.raq&start_date="+start_date+"&end_date="+end_date+"&busitype="+busitype+"&user_id="+user_id;
        
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
    }
</script>
</head>
<body>
<%
//获取当前日期
java.util.Date now = new java.util.Date();
java.text.SimpleDateFormat f=new java.text.SimpleDateFormat("yyyy-MM-dd");
String currentDate = f.format(now);
%>
<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
       writeTableTopFesco('统计报表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title">报表</div>
            <!--表格1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1">报入职起始日期</td>
                    <td class="td_2">
                        <w:date format="yyyy-MM" id="start_date" name="start_date" property="bean/start_date" width="189px"/>
                    </td>
                    <td class="td_1">报入职结束日期</td>
                    <td class="td_2">
                        <w:date format="yyyy-MM-dd" id="end_date" value="<%=currentDate %>" name="end_date" property="bean/end_date" width="189px"/>
                    </td>                   
                </tr>
                <tr>
                     <td class="td_1">业务类型</td>
                    <td class="td_2">
                       <r:comboSelect id="busitype" name="busitype"
                           queryAction="/FAERP/AucomcityrelAction.do?cmd=getSecurityGroupList&city_id=1099110100000000050"
                           textField="group_name"
                           valueField="id"
                           xpath="SecuritygroupVo"
                           width="200px"
                           nullText="请选择"/>
                    </td>
                     <td class="td_1">操作专员</td>
                     <td class="td_2">
                         <r:comboSelect id="userlist" name="userlist"
                           queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=1099100700000000112"
	                       textField="name"
	                       valueField="partyId"
	                       xpath="CustServiceVo"
	                       width="200px"
	                       nullText="请选择"/>
                    </td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    </form>
</fmt:bundle>
</body>
</html>
