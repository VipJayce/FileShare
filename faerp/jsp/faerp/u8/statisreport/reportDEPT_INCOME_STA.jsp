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
<title>部门收入汇总统计报表</title>
<script language="javascript">
    function exportEXCEL_onClick(){
        var start_month = document.getElementById("start_month").value;
        var end_month = document.getElementById("end_month").value;
	    if(start_month==null || start_month==""){
	         alert("统计起始年月不能为空！");
	         return;
	    }
	    if(end_month==null || end_month==""){
	            alert("统计截止年月不能为空！");
	            return;
	    }   
	    if(start_month > end_month){
	            alert("统计起始年月不能大于统计截止年月！");
	            return;
	        }    
        var url1 ="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showDEPT_INCOME_STA.jsp?raq=DEPT_INCOME_STA.raq&start_month="+start_month+"&end_month="+end_month;
        //$id("datacell_formid").submit();
        window.open(url1,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
        
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
       writeTableTopFesco('部门收入汇总统计报表','<%=request.getContextPath()%>/');  //显示本页的页眉
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
					<td class="td_1">统计起始年月</td>
					<td class="td_2">
                        <!--<w:date format="yyyy-MM" id="start_month" name="start_month" property="bean/start_month" width="189px"/>-->
                         <input type="text" class="text_field" id="start_month" name="start_month" inputName="统计起始年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
					</td>
					<td class="td_1">统计截止年月</td>
					<td class="td_2">
                        <!--<w:date format="yyyy-MM" id="end_month" name="end_month" property="bean/end_month" width="189px"/>-->
                        <input type="text" class="text_field" id="end_month" name="end_month" inputName="统计截止年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
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
