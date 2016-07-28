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
        if(start_date==null || start_date==""){
            alert("开始日期不能为空！");
            return;
        }
        if(end_date==null || end_date==""){
            alert("结束日期不能为空！");
            return;
        }
        if(start_date.replace('-','').replace('-','')>end_date.replace('-','').replace('-','')){
            alert("开始日期大于结束日期！");
            return;
        }
        
        if(type_bd=='1'){
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_KFB_declareEntry.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            $id("datacell_formid").submit();
        }else if(type_bd=='2'){
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_KFB_declareDeparture.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            $id("datacell_formid").submit();
        }else if(type_bd=='3'){
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_KFB_declareChange.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            $id("datacell_formid").submit();
        }else if(type_bd=='4'){
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_KFB_bankcardmaintain.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            $id("datacell_formid").submit();
        }else if(type_bd=='5'){
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_KFB_empinfoChange.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            $id("datacell_formid").submit();
        }else if(type_bd=='6'){
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showZGBTJreportEmpinfo.jsp?raq=report_KFB_declareEntry.raq&start_date="+start_date+"&end_date="+end_date+"&report_type_bd=1";
            $id("datacell_formid").submit();
        }
    }
</script>
</head>
<body>

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
                        <w:date format="yyyy-MM-dd" id="end_date" name="end_date" property="bean/end_date" width="189px"/>
					</td>
					<td class="td_1">报表类型</td>
					<td class="td_2">
                        <select id="type_bd" name="type_bd" >
		                    <option value="1">   申报入职统计</option>
		                    <option value="2">   申报离职统计</option>
		                    <option value="3">   申报变更统计</option>
		                    <option value="4">   银行卡维护统计</option>
		                    <option value="5">   员工信息变更统计</option>
		                    <option value="6">   入职分类统计</option>
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
