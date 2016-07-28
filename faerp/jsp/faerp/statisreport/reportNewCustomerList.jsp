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
<title>新户数据报表</title>
<script language="javascript">
    function exportEXCEL_onClick(){
    	var start_date = document.getElementById("start_date").value; //开始日期
        var end_date = document.getElementById("end_date").value; //截止日期
        if(start_date==null||start_date==""){
        	alert('请选择开始日期');
        	return;
        }
        if(end_date==null||end_date==""){
        	alert('请选择截止日期');
        	return;
        }
        var is_sale_achievement = document.form.is_sale_achievement.value;
        var create_user_name = document.getElementById("create_user_name").value;
        
        var url = "";
        
        url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showNewCustomerList.jsp?raq=new_customer_list.raq&end_date="+end_date+"&start_date="+start_date+"&is_sale_achievement="+is_sale_achievement+"&create_user_name="+encodeURIComponent(create_user_name);
        
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
       writeTableTopFesco('新户数据报表','<%=request.getContextPath()%>/');  //显示本页的页眉
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
					<td class="td_1"><font color="red">*</font>开始时间</td>
					<td class="td_2">
                        <w:date format="yyyy-MM-dd" id="start_date" name="start_date" property="bean/start_date" width="189px"/>
					</td>
					<td class="td_2"><font color="red">*</font>截止时间</td>
					<td class="td_2">
                        <w:date format="yyyy-MM-dd" id="end_date" name="end_date" property="bean/end_date" width="189px"/>
					</td>
				</tr>
				<tr>
					<td class="td_1">是否销售业绩</td>
					<td class="td_2">
                        <select id="is_sale_achievement" name="is_sale_achievement" >
                        	<option value=""> </option>
		                    <option value="1">是</option>
		                    <option value="0">否</option>
		                </select>
					</td>
					<td class="td_2">建户人</td>
					<td class="td_2">
                        <input type="text" class="text_field" id="create_user_name" name="create_user_name" inputName="建户人"  />
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
