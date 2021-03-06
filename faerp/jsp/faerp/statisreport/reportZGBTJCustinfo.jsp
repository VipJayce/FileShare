<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function exportEXCEL_onClick(){
        var start_date = document.form.start_date.value;
        var end_date = document.form.end_date.value;
        var type_bd = document.form.type_bd.value;
        if(type_bd==null || type_bd==""){
            alert("报表类型不能为空！");
            return;
        }
        var url1 = "";
        if(type_bd=='0'){
            //$id("datacell_formid").action= "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_cust.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=0";
            //$id("datacell_formid").submit();
            if(end_date==null || end_date==""){
                alert("统计结束日期不能为空！");
                return;
            }
            if(start_date!=null && start_date!=""){
                 if(start_date.replace('-','').replace('-','')>end_date.replace('-','').replace('-','')){
                     alert("统计开始日期不能大于统计结束日期！");
                    return;
                 }
            }
            url1 = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_cust.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=0";
        }else if(type_bd=='1'){
           //$id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_custbyservice.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            //$id("datacell_formid").submit();
           url1 = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_custbyservice.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1"; 
        }else if(type_bd=='2'){
            //$id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_custbydept.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=2";
            //$id("datacell_formid").submit();
            url1 = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_custbydept.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=2";
        }else if(type_bd=='3'){
            if(start_date==null || start_date==""){
                alert("统计开始日期不能为空！");
                return;
            }
            //if(end_date==null || end_date==""){
              //  alert("统计结束日期不能为空！");
                //return;
            //}
            if(start_date.replace('-','').replace('-','')>end_date.replace('-','').replace('-','')){
                alert("统计开始日期不能大于统计结束日期！");
                return;
            }
            //$id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_custprofile.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=3";
            //$id("datacell_formid").submit();
            url1 = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportCustinfo.jsp?raq=report_QCD_custprofile.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=3";
        }
         window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
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
					<td class="td_1">统计开始时间</td>
					<td class="td_2">
                        <w:date format="yyyy-MM" id="start_date" name="start_date" property="bean/start_date" width="189px"/>
					</td>
					<td class="td_1">统计结束时间</td>
					<td class="td_2">
                        <w:date format="yyyy-MM-dd" id="end_date" value="<%=currentDate %>" name="end_date" property="bean/end_date" width="189px"/>
					</td>
					<td class="td_1">报表类型</td>
					<td class="td_2">
                        <select id="type_bd" name="type_bd" >
		                    <option value="0">   客户完整度统计</option>
		                    <option value="1">   客户完整度（按客服）统计</option>
		                    <option value="2">   客户完整度（按部门）统计</option>
		                    <option value="3">   客户简档情况统计</option>
		                </select>
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
