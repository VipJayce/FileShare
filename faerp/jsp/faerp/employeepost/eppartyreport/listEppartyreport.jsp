<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>


<html>
<fmt:bundle basename="rayoo.employeepost.eppartyreport.eppartyreport_resource" prefix="rayoo.employeepost.eppartyreport.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function reportselect(obj){
	    var selected = obj.value;
	    if(selected!=null&&selected!=""&&selected=='1'){
	        $("#td1").remove();
            $("#td2").remove();
            $("#td3").remove();
            $("#td4").remove();
	        $("#tongji").append("<td class='td_1' id='td1'>年月（YYYYMM）<\/td><td class='td_2' id='td2'><input id='date' name='date' type='text' inputName='年月' class='xText' \/><\/td>");
	    }else if(selected!=null&&selected!=""&&selected=='2'){
	        $("#td1").remove();
            $("#td2").remove();
            $("#td3").remove();
            $("#td4").remove();
	        $("#tongji").append("<td class='td_1' id='td3'><span class='style_required_red'>*&nbsp;</span>统计类型<\/td><td class='td_2' id='td4'><select name='select2' class='sSelect' id='select2'><option value='0'>请选择<\/option><option value='1'>人数增减统计<\/option><option value='2'>党费统计<\/option><\/select><\/td>");
	        $("#tongji").append("<td class='td_1' id='td1'>年月（YYYYMM）<\/td><td class='td_2' id='td2'><input id='date' name='date' type='text' inputName='年月' class='xText' \/><\/td>");
	    }else if(selected!=null&&selected!=""&&selected=='3'){
            $("#td1").remove();
            $("#td2").remove();
            $("#td3").remove();
            $("#td4").remove();
            $("#tongji").append("<td class='td_1' id='td1'><span class='style_required_red'>*&nbsp;</span>年月（YYYYMM）<\/td><td class='td_2' id='td2'><input id='date' name='date' type='text' inputName='年月' class='xText' \/><\/td>");
        }else if(selected!=null&&selected!=""&&selected=='4'){
            $("#td1").remove();
            $("#td2").remove();
            $("#td3").remove();
            $("#td4").remove();
            $("#tongji").append("<td class='td_1' id='td1'><span class='style_required_red'>*&nbsp;</span>年月（YYYYMM）<\/td><td class='td_2' id='td2'><input id='date' name='date' type='text' inputName='年月' class='xText' \/><\/td>");
        }else if(selected!=null&&selected!=""&&selected=='5'){
            $("#td1").remove();
            $("#td2").remove();
            $("#td3").remove();
            $("#td4").remove();
            $("#tongji").append("<td class='td_1' id='td1'>年月（YYYYMM）<\/td><td class='td_2' id='td2'><input id='date' name='date' type='text' inputName='年月' class='xText' \/><\/td>");
        }else if(selected!=null&&selected!=""&&selected=='6'){
            $("#td1").remove();
            $("#td2").remove();
            $("#td3").remove();
            $("#td4").remove();
            $("#tongji").append("<td class='td_1' id='td1'><span class='style_required_red'>*&nbsp;</span>年（YYYY）<\/td><td class='td_2' id='td2'><input id='date' name='date' type='text' inputName='年月' class='xText' \/><\/td>");
        }else{
	        $("#td1").remove();
	        $("#td2").remove();
	        $("#td3").remove();
	        $("#td4").remove();
	    }
	}

	function exportExcel(){
	    var report= document.getElementById("select1").value;
	     
	     if(report==null|| report=="" || report=="0"){
	         alert("<fmt:message key="please_choose_report_exp_type"/>");
	         return;
	     }else{
		     var date =document.getElementById("date").value;
	         var reg = new RegExp("^[1-2]{1}[0-9]{3}((0[1-9]{1})|(1[0-2]{1}))$");
	         var reg1 = new RegExp("^[1-2]{1}[0-9]{3}$");
	         
            if(report=="1"){ //党员花名册
                if(date !=null && date != ""){
                    if(!reg.test(date)){
                        alert("<fmt:message key="date_format_is_false"/>");
                        return;
                    }
                }
                form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel1";
                form.submit();
	        }else if(report=="2"){ //党员数据统计表
	            var tongjitype= document.getElementById("select2").value;
	            if(tongjitype==null || tongjitype=="" || tongjitype=="0"){
	               alert("<fmt:message key="please_choose_type"/>");
                   return;
	            }
	            if(date !=null && date != ""){
                    if(!reg.test(date)){
                        alert("<fmt:message key="date_format_is_false"/>");
                        return;
                    }
                }
                if(tongjitype=="1"){ //人数增减统计
                    form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel2";
                    form.submit();
                }else if(tongjitype=="2"){ //党费统计
                    form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel3";
                    form.submit();
                }
                /*else if(tongjitype=="3"){ //支部人数统计
                    form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel4";
                    form.submit();
                }*/
	        }else if(report=="3"){ //每月转进党员名册
	            if(date == null || date == ""){
	                alert("<fmt:message key="year_and_month_not_null"/>");
	                return;
	            }else{
	                if(!reg.test(date)){
                        alert("<fmt:message key="date_format_is_false"/>");
                        return;
                    }
	            }
	            form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel5";
                form.submit();
	        }else if(report=="4"){ //每月转出党员名册
	            if(date == null || date == ""){
                    alert("<fmt:message key="year_and_month_not_null"/>");
                    return;
                }else{
                    if(!reg.test(date)){
                        alert("<fmt:message key="date_format_is_false"/>");
                        return;
                    }
                }
                form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel6";
                form.submit();
	        }else if(report=="5"){ //预备党员名册
	            if(date !=null && date != ""){
                    if(!reg.test(date)){
                        alert("<fmt:message key="date_format_is_false"/>");
                        return;
                    }
                }
                form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel7";
                form.submit();
	        }else if(report=="6"){ //捐款名单
	            if(date == null || date == ""){
                    alert("<fmt:message key="year_and_month_not_null"/>");
                    return;
                }else{
                    if(!reg1.test(date)){
                        alert("<fmt:message key="date_format_is_false2"/>");
                        return;
                    }
                }
                form.action="<%=request.getContextPath()%>/EppartyreportAction.do?cmd=exportExcel8";
                form.submit();
	        }
	     }
	}
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EppartyreportAction.do">
 
 <input type="hidden" id="tongjitype" name="tongjitype"/>
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="party_report"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng" style="height: 50px"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr id="tongji">
            <td  class="td_1"><span class="style_required_red">*&nbsp;</span><fmt:message key="report_type"/></td>
            <td  class="td_2">
               <select id="select1" name="select1" class="sSelect" onchange="reportselect(this)">
                    <option value="0"><fmt:message key="please_choose"/></option>
                    <option value="1"><fmt:message key="dyhmc"/></option>
                    <option value="2"><fmt:message key="dysjtjb"/></option>
                    <option value="3"><fmt:message key="myzjdymc"/></option>
                    <option value="4"><fmt:message key="myzcdymc"/></option>
                    <option value="5"><fmt:message key="ybdymc"/></option>
                    <option value="6"><fmt:message key="jkmd"/></option>
               </select>
            </td>
        </tr>
</table>
</div>
<div class="mx_button" style="text-align: center;padding-top:10px;">
        <input type="button" class="icon_2" value="<fmt:message key="export"/>"  <au:authorityBtn code="dwbb_exp" type="1"/> onclick="exportExcel();" />
        </div>
</div>     
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">

</script>	
