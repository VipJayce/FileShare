<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<html>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<head>
<title>workflow-workcalendar</title>
<style>
/* 表单基本元素的样式表 */
.text_field {
    /* 最长的text */
    font-size: 9pt;
    color: #003300;
    height: 20px;
    vertical-align: middle;
    border-top: 1px solid #333333;
    border-right: 1px solid #B3B3B3;
    border-bottom: 1px solid #B3B3B3;
    border-left: 1px solid #333333;
    line-height: 13px;
    width: 40px;
}

</style>
<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/js/workcalendar/skins/aqua/theme.css" title="Aqua" />
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrworkflow/interface/DwrControlFactory.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrworkflow/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrworkflow/util.js'></script>
<!-- main calendar program -->
<script src="<%=request.getContextPath()%>/js/workcalendar/js/calendar.js"></script>
<!-- language for the calendar -->

<i18n:javascript src="/js/workcalendar/lang/calendar.js"/>
<!-- calendar setup -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/workcalendar/js/calendar-setup.js"></script>
<script type="text/javascript">
function getWorkTime(){
    DwrControlFactory.getWorkTime(function(data){
            dwr.util.setValue('amStartTime', data[0], { escapeHtml:false });
            dwr.util.setValue('amEndTime', data[1], { escapeHtml:false });
            dwr.util.setValue('pmStartTime', data[2], { escapeHtml:false });
            dwr.util.setValue('pmEndTime', data[3], { escapeHtml:false });
        });
}
function setAllTime(){
    var workDateItem={
    }
    /*时间校验*/
    var regA1  = /^([0-9]|0[0-9]|1[0-2]):([0-5][0-9])$/;
    var regA2  = /^([0-9]|0[0-9]|1[0-2]):([0-5][0-9])$/;
    var regB1  = /^([1][3-9]||[2][0-3]):([0-5][0-9])$/;
    var regB2  = /^([1][3-9]||[2][0-3]):([0-5][0-9])$/;

    var amStartStr = jQuery('#amStartTime').val();
    var amEndStr = jQuery('#amEndTime').val();
    var pmStartStr = jQuery('#pmStartTime').val();
    var pmEndStr = jQuery('#pmEndTime').val();
    
    if (!regA1.test(amStartStr)||!regA2.test(amEndStr)) {
        alert('<fmt:message key="morning_input_wrong" />');
        return;
    } else if (!regB1.test(pmStartStr)||!regB2.test(pmEndStr)) {
        alert('<fmt:message key="afternoon_input_wrong"/>');
        return;
    } else if (parseInt(amStartStr.split(":")[0]) >= parseInt(amEndStr.split(":")[0])){
        alert('<fmt:message key="morning_input_wrong_input_again" />');
        return;
    } else if (parseInt(pmStartStr.split(":")[0]) >= parseInt(pmEndStr.split(":")[0])){
        alert('<fmt:message key="afternoon_input_wrong_input_again"/>');
        return;
    }

    workDateItem.defineTime = jQuery('#amStartTime').val()+"-"+jQuery('#amEndTime').val() + "," + jQuery('#pmStartTime').val()+"-"+jQuery('#pmEndTime').val();
    DwrControlFactory.setAllTime(workDateItem,function(data){
        alert('<fmt:message key="operation_successful" bundle="${applicationResources}"/>');
    });
}

function setWorkTime(cal){
    var workDateItem={
    }
    workDateItem.defineDate = cal.date;
    workDateItem.defineTime = jQuery('#amStartTime').val()+"-"+jQuery('#amEndTime').val() + "," + jQuery('#pmStartTime').val()+"-"+jQuery('#pmEndTime').val();
   
    workDateItem.defineState = 0;
    
    var ds = cal.date.print("%Y%m%d");
    var cell = cal.datesCells[ds];
    if (cell) {
        var d = cal.multiple[ds];
        if (!d) {
            workDateItem.defineState = 1;//工作日
        } else {
            workDateItem.defineState = 0;//假日
        }
    }
    DwrControlFactory.setWorkTime(workDateItem);
}
//<![CDATA[
// the default multiple dates selected, first time the calendar is instantiated
var MA=[];
//MA = [ ];
//MA = [new Date() ];
//alert("MA是"+MA);
function myCallback(cal) {
    setWorkTime(cal);
}
// Popup calendar setup
/*
var c2 = Calendar.setup({
    align       : 'BR',
    //customArea  : 'output-popup',
    displayArea : 'output-popup',
    button      : 'trigger-popup-calendar',
    multiple    : MA,
    onClose     : myCallback
});
*/
//]]>
</script>
</head>
<body onload="javascript:getWorkTime();">
<script language="javascript">
    writeTableTop('<fmt:message key="work_calendar"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<!-- 列表开始 -->
<div id="ccParent1"> 
<table class="table_div_control">
    <tr>
        <td>
        <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
            <fmt:message key="process_success"/>
        </td>
    </tr>
</table>
</div>
<!--a id="trigger-popup-calendar" href="#">[<b>Open popup calendar...</b>]</a-->
<div id="output-popup"></div>
<div id="ccChild1">
<table class="table_div_content2">
    <tr>
        <td width=90><fmt:message key="working_hours"/></td>   
        <td><fmt:message key="morning"/>&nbsp;&nbsp;<input type="text" name="amStartTime" id="amStartTime" class="text_field"  value=""/>-&nbsp;<input type="text" name="amEndTime" id="amEndTime" class="text_field"  value=""/></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td width=90>&nbsp;</td>  
        <td><fmt:message key="afternoon"/>&nbsp;&nbsp;<input type="text" name="pmStartTime" id="pmStartTime" class="text_field"  value=""/>-&nbsp;<input type="text" name="pmEndTime" id="pmEndTime" class="text_field"  value=""/></td>
        <td><input name="goback" class="button_ellipse" type="button" value='<fmt:message key="save" bundle="${applicationResources}"/>' onclick="setAllTime();"></td>
    </tr>
    <tr>
        <td><fmt:message key="working_day"/></td>   
        <td width=100><div id="calendar-container-flat"></div></td>
        <td>&nbsp;</td> 
    </tr>

</table>
</div>
<script type="text/javascript">
DwrControlFactory.getWorkDate(function(data){
    MA = data;
    MA = [new Date() ]
    var c1 = Calendar.setup({
        displayArea  : 'output-flat',
        flat         : 'calendar-container-flat',
        multiple     : data,
        flatCallback : myCallback
    }); 
});

</script>



<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>

</fmt:bundle>
</html>
