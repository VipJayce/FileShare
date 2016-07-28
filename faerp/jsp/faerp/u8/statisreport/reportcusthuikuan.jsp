<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<%@ page import="gap.authority.helper.LoginHelper" %>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
//String login_user_name="";
//LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
//if(null!=loginVo){
    //login_user_name=loginVo.getName();
  //}
%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

<script language="javascript">
    function exportEXCEL_onClick(){
	        var start_date = document.getElementById("start_date").value;
	        
	        var flag="<%=request.getParameter("flag")%>";
	        var url="";
	        
	    if(flag=="1"){
	            if(start_date==null || start_date==""){
                alert("应收年月不能为空！");
                return ;
            }
	         url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showhuikuan.jsp?raq=CUSTPAYMENT_STA.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1&flag=1";
	    }
	    if(flag=="2"){
	       if(start_date==null || start_date==""){
                alert("应收年月不能为空！");
                return ;
            }
	        url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showhuikuan.jsp?raq=report_cust_qiankuantongji.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=2&flag=2";
	    }
	    if(flag=="3"){
	       var end_date = document.getElementById("end_date").value;
	     //if(start_date==null || start_date==""){
        //   alert("统计起始年月不能为空！");
        //   return;
        //}
            if(end_date==null || end_date==""){
                alert("统计截止年月不能为空！");
                return;
            }
            if(start_date!=null && start_date!=""){
	            if(start_date.replace('-','').replace('-','')>end_date.replace('-','').replace('-','')){
	                alert("统计起始年月不能大于截止年月！");
	                return;
	            }
            }
	        url="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showhuikuan.jsp?raq=productfukailu.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=3&flag=3";
	    }
	    window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');

    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
<c:choose>
        <c:when test="${param.flag=='1'}">
            writeTableTopFesco('客户回款统计','<%=request.getContextPath()%>/');  //显示本页的页眉
        </c:when>
        <c:when test="${param.flag=='2'}">
            writeTableTopFesco('客户欠款统计','<%=request.getContextPath()%>/');  //显示本页的页眉
        </c:when>
          <c:when test="${param.flag=='3'}">
            writeTableTopFesco('产品覆盖率统计','<%=request.getContextPath()%>/');  //显示本页的页眉
        </c:when>
 </c:choose>
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
                    <%if ("1".equals(request.getParameter("flag")) || "2".equals(request.getParameter("flag"))){%>
                    <td class="td_1">应收年月</td>
                    <td class="td_2">
                      <input type="text" class="text_field" id="start_date" name="start_date" inputName="应收年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                    </td>
                    <%}else{ %>
                     <td class="td_1">统计起始年月</td>
                     <td class="td_2">
                      <input type="text" class="text_field" id="start_date" name="start_date" inputName="统计起始年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                        <td class="td_1">统计截止年月</td>
                    <td class="td_2">
                        <input type="text" class="text_field" id="end_date" name="end_date" inputName="统计截止年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                    </td>
                    </td>
                    <%} %>
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
