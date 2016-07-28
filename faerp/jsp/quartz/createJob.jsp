<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<fmt:bundle basename="gap.quartz.quartz_resource" prefix="gap.quartz.">
<script language="javascript">
function createJob(){
	form1.action = "<venus:base/>/createTrigger.do";
	form1.submit();
}

function guide_onClick(){
    //取得event，firefox下通过guide_onClick.caller.arguments[0]获取。
    var event = window.event?window.event:guide_onClick.caller.arguments[0];
	var obj = window.showModalDialog('<venus:base/>/createJobForm.do?cmd=doCreateCronExpression','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:370px;dialogWidth:450px;help:no;resizable:no;scroll:no;status:0;');
	if(obj) {
		//alert("guid_onClick = "+obj);
		document.form1.cronExpression.value = obj;
	}
}

function setHHMM(obj){
    //取得event，firefox下通过setHHMM.caller.arguments[0]获取。
    var event = window.event?window.event:setHHMM.caller.arguments[0];
	var returnAry = window.showModalDialog("<%=request.getContextPath()%>/jsp/quartz/HHMM.jsp",obj,"status:1;dialogHeight:20px;dialogWidth:162px;dialogTop: "+event.screenY+"px; dialogLeft: "+event.screenX+"px");
	if (typeof(returnAry) == "undefined") {
       obj.value = "";
	} else if (returnAry != null) {
        obj.value = returnAry;
        focus();
	}
}

function chkall(input1,input3,input2)
{
//alert(input3);
    var objForm = document.forms[input1];
    var objLen = objForm.length;
    for (var iCount = 0; iCount < objLen; iCount++)
    {
       if (input2.checked == true)
        {
            if (objForm.elements[iCount].name == input3)
            {
                objForm.elements[iCount].checked = true;
            }
        }
        else
        {
            if (objForm.elements[iCount].name == input3)
            {
                objForm.elements[iCount].checked = false;
            }
        }
    }
}

function checkDayOrWeek(obj){
	if(obj.value=="day"){
	document.form1.date.disabled = false;
	document.form1.dayOfWeek.disabled = true;
	document.form1.weekOfMonth.disabled = true;
	}else{
	document.form1.date.disabled = true;
	document.form1.dayOfWeek.disabled = false;
	document.form1.weekOfMonth.disabled = false;
	}
	
}

function onceClick(){
	planParent.style.display="block";
	onceChild.style.display="block";
	dayChild.style.display="none";
	weekChild.style.display="none";
	monthChild.style.display="none";
	customerChild.style.display="none";
}

function dayClick(){
	planParent.style.display="block";
	onceChild.style.display="none";
	dayChild.style.display="block";
	weekChild.style.display="none";
	monthChild.style.display="none";
	customerChild.style.display="none";
	
}
function monthClick(){
	planParent.style.display="block";
	onceChild.style.display="none";
	dayChild.style.display="none";
	weekChild.style.display="none";
	monthChild.style.display="block";
	customerChild.style.display="none";
}
function weekClick(){
	planParent.style.display="block";
	onceChild.style.display="none";
	dayChild.style.display="none";
	weekChild.style.display="block";
	monthChild.style.display="none";
	customerChild.style.display="none";
}
function customerClick(){
	planParent.style.display="none";
	onceChild.style.display="none";
	dayChild.style.display="none";
	weekChild.style.display="none";
	monthChild.style.display="none";
	customerChild.style.display="block";
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<script language="javascript">
	writeTableTop('<fmt:message key="Scheduling_Scheme_Settings"/>','<venus:base/>/');
</script>

<form name="form1" id="form1" method="post" >

<div id="ccParentq">
<table class="table_div_control">
	<tr>
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChildq',this,'<venus:base/>/')">
			<fmt:message key="Choose_Scheduling_Scheme"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChildq">
<table class="table_div_content">
	<tr>
		<td><input type="radio" name="plan" value="once" onclick="onceClick()" checked><fmt:message key="One_Time"/></td>
		<td><input type="radio" name="plan" value="perDay" onclick="dayClick()"><fmt:message key="Daily"/></td>
		<td><input type="radio" name="plan" value="perWeek" onclick="weekClick()"><fmt:message key="Weekly"/></td>
		<td><input type="radio" name="plan" value="perMonth" onclick="monthClick()"><fmt:message key="Monthly"/></td>
		<td><input type="radio" name="plan" value="customer" onclick="customerClick()"><fmt:message key="Custom"/></td>		
	</tr>		
</table>
</div> 

<div id="planParent">
<table class="table_div_control">
	<tr>
		<td>
			<fmt:message key="Choose_Date_And_Time"/>
		</td>
	</tr>
</table>
</div>

<div id="onceChild" >
<table class="table_div_content" border="0">
	<tr>
		<td width="80"><fmt:message key="Start_Date"/></td>
	    <td width="220"><input type="text" readOnly name="beginDate1" id="beginDate1" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate1','<%=request.getContextPath()%>/');" class="img_1"/>
	    </td>
		<td width="100"><fmt:message key="Start_Time"/></td>
		<td width="220"><input type="text" readOnly name="beginTime1" id="beginTime1" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(beginTime1);"  class="img_1"/>
		</td>
	</tr>
</table>
</div> 
	
<div id="dayChild" style="display:none;">
<table class="table_div_content">
	<tr>
		<td>
			<table>
				<tr>
		<td width="100"><fmt:message key="Start_Date"/></td>
	    <td width="220"><input type="text" name="beginDate2" id="beginDate2" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate2','<%=request.getContextPath()%>/');" class="img_1"/>
	    </td>
		<td width="100"><fmt:message key="End_Date"/></td>
	    <td width="220"><input type="text" name="endDate2" id="endDate2" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate2','<%=request.getContextPath()%>/');" class="img_1"/>
	    </td>
	    </tr>
	    </table>
	    </td>
	</tr>
	<tr>
			<td>
			<table>
				<tr>
		<td width="100"><fmt:message key="Start_Time"/></td>
		<td width="220"><input type="text" name="beginTime2" id="beginTime2" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(beginTime2);"  class="img_1"/>
	    </td>
		<td width="100"><fmt:message key="End_Time"/></td>
		<td width="220"><input type="text" name="endTime2" id="endTime2" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(endTime2);"  class="img_1"/>
	    </td>
	    	    </tr>
	    </table>
	    </td>
	</tr>
	<tr>	
				<td>
			<table>
				<tr>
		<td width="100"><fmt:message key="Run_Task"/></td>
		<td ><input type="radio" name="dayPlan" value="perDay" checked> <fmt:message key="Daily"/></td>
		<td ><input type="radio" name="dayPlan" value="perWorkDay"><fmt:message key="Each_Working_Day"/></td>
    	<td ><input type="radio" name="dayPlan" value="perDays"><fmt:message key="Each"/>
			<select name="days" style="width:40">
			<%
			for(int i=1;i<=31;i++){
				
				out.println("<option value="+i+" >"+i+"</option>");
			}
			%>			
		    </select><fmt:message key="Day"/>
		</td>
			    </tr>
	    </table>
	    </td>
	</tr>			
</table>
</div> 

<div id="weekChild" style="display:none;">
<table class="table_div_content">
	<tr>
	<td>
		<table>
			<tr>
				<td width="100"><fmt:message key="Start_Date"/></td>
			    <td width="220"><input type="text" name="beginDate3" id="beginDate3" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate3','<%=request.getContextPath()%>/');" class="img_1"/>
			    </td>
				<td width="100"><fmt:message key="End_Date"/></td>
			    <td width="220"><input type="text" name="endDate3" id="endDate3" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate3','<%=request.getContextPath()%>/');" class="img_1"/>
			    </td>
			</tr>
			</tr>
			<tr>	
				<td width="100"><fmt:message key="Start_Time"/></td>
				<td width="220"><input type="text" name="beginTime3" id="beginTime3" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(beginTime3);"  class="img_1"/>
				</td>
				<td width="100"><fmt:message key="End_Time"/></td>
				<td width="220"><input type="text" name="endTime3" id="endTime3" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(endTime3);"  class="img_1"/>
			    </td>
			</tr>
		</table>
	</td>
	</tr>
	<tr>
	<td>
		<table>
		<tr>	
			<td width="100"><fmt:message key="Select_Week"/></td>
			<td ><input type="checkbox" value='<fmt:message key="Select_All"/>' onclick='chkall("form1","weekDay",this)' name=chk><fmt:message key="Select_All"/></td> 
			<td >&nbsp;</td>
		</tr>
		</table>
	</td>
	</tr>
	<tr>	
	<td>
		<table>
			<tr>	
				<td><input type="checkbox" name="weekDay" value="2"><fmt:message key="Monday"/></td> 
				<td><input type="checkbox" name="weekDay" value="3"><fmt:message key="Tuesday"/></td> 
				<td><input type="checkbox" name="weekDay" value="4"><fmt:message key="Wednesday"/></td> 
				<td><input type="checkbox" name="weekDay" value="5"><fmt:message key="Thursday"/></td> 
				<td ><input type="checkbox" name="weekDay" value="6"><fmt:message key="Friday"/></td> 
				<td ><input type="checkbox" name="weekDay" value="7"><fmt:message key="Saturday"/></td> 
				<td ><input type="checkbox" name="weekDay" value="1"><fmt:message key="Sunday"/></td> 
			</tr>
		</table>
	</td>
	</tr>
</table>
</div> 

<div id="monthChild" style="display:none;">
<table class="table_div_content">
	<tr>
		<td>
			<table>
				</tr>
		<td width="100"><fmt:message key="Start_Date"/></td>
	    <td width="220"><input type="text" name="beginDate4" id="beginDate4" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate4','<%=request.getContextPath()%>/');" class="img_1"/>
	    </td>
		<td width="100"><fmt:message key="End_Date"/></td>
	    <td width="220"><input type="text" name="endDate4" id="endDate4" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate4','<%=request.getContextPath()%>/');" class="img_1"/>
	    </td>
	    </tr>
	    </table>
	    </td>
	</tr>
	<tr>	
			<td>
			<table>
				</tr>
		<td width="100"><fmt:message key="Start_Time"/></td>
		<td width="220"><input type="text" name="beginTime4" id="beginTime4" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(beginTime4);"  class="img_1"/>
		</td>
		<td width="100"><fmt:message key="End_Time"/></td>
		<td width="220"><input type="text" name="endTime4" id="endTime4" class="text_field_reference"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:setHHMM(endTime4);"  class="img_1"/>
	    </td>
	    	    </tr>
	    </table>
	    </td>
	</tr>
	<tr>	
			<td>
			<table>
				</tr>
		<td width="100"><fmt:message key="Choose_Period"/></td> 
		<td width="120"><input type="radio" name="dayOrweek" value="day" onclick="checkDayOrWeek(this);" checked><fmt:message key="Day"/>
			<select name="date" readOnly style="width:40">
			<%
			for(int i=1;i<=31;i++){
				
				out.println("<option value="+i+" >"+i+"</option>");
			}
			%>		
		    </select>
    	</td>
		<td ><input type="radio" name="dayOrweek" value="week" onclick="checkDayOrWeek(this);"><fmt:message key="Week"/>
			<select name="weekOfMonth" DISABLED style="width:90">
		      <option selected value="1" ><fmt:message key="First"/></option>
			  <option value="2"><fmt:message key="Second"/></option>
			  <option value="3"><fmt:message key="Third"/></option>
			  <option value="4"><fmt:message key="Fourth"/></option>
			  <option value="L"><fmt:message key="Last"/></option>
		    </select>
		</td>
		<td ><select name="dayOfWeek" DISABLED style="width:90">
			  <option value="2"><fmt:message key="Monday"/></option>
			  <option value="3"><fmt:message key="Tuesday"/></option>
			  <option value="4"><fmt:message key="Wednesday"/></option>
			  <option value="5"><fmt:message key="Thursday"/></option>
			  <option value="6"><fmt:message key="Friday"/></option>
			  <option value="7"><fmt:message key="Saturday"/></option>
		      <option selected value="1"><fmt:message key="Sunday"/></option>
		    </select>
		</td>
			    </tr>
	    </table>
	    </td>
	</tr>
	<tr>		
				<td>
			<table>
				</tr>
		<td ><fmt:message key="Choose_Month"/>&nbsp;</td> 
		<td ><input type="checkbox" value='<fmt:message key="Select_All"/>' onclick='chkall("form1","month",this)' name=chk><fmt:message key="Select_All"/></td> 
		<td >&nbsp;</td> 
		<td >&nbsp;</td> 
			    </tr>
	    </table>
	    </td>
	</tr>
	<tr>	
	<tr>
		<td>
			<table>
				<tr>	
					<td><input type="checkbox" name="month" value="1"><fmt:message key="January"/> </td>
					<td><input type="checkbox" name="month" value="2"><fmt:message key="February"/> </td>
					<td><input type="checkbox" name="month" value="3"><fmt:message key="March"/> </td>
					<td><input type="checkbox" name="month" value="4"><fmt:message key="April"/></td>
					<td><input type="checkbox" name="month" value="5"><fmt:message key="May"/></td>
					<td><input type="checkbox" name="month" value="6"><fmt:message key="June"/></td>
				</tr>
			</table>
		</td>
	</tr>
		<tr>
		<td>
			<table>
				<tr>	
					<td><input type="checkbox" name="month" value="7"><fmt:message key="July"/> </td>
				    <td><input type="checkbox" name="month" value="8"><fmt:message key="August"/> </td>
					<td><input type="checkbox" name="month" value="9"><fmt:message key="September"/></td>
					<td><input type="checkbox" name="month" value="10"><fmt:message key="October"/></td>
					<td><input type="checkbox" name="month" value="11"><fmt:message key="November"/></td>
					<td><input type="checkbox" name="month" value="12"><fmt:message key="December"/></td>
				</tr>
			</table>
		</td>
	</tr>

</table>
</div> 

<div id="customerChild" style="display:none;">
<table class="table_div_content" border="0">
	<tr>
		<td align="left" width="15%" nowrap><fmt:message key="Advanced_Triggering_Rules"/></td>
		<td><input name="cronExpression" type="text" class="text_field" inputName='<fmt:message key="Advanced_Triggering_Rules"/>' readOnly>
				<input type="button" name="guide" class="button_ellipse" value='<fmt:message key="Guide"/>' onClick="javascript:guide_onClick();">
		</td>
		
	</tr>
</table>
</div> 

<input type="button" class="button_ellipse" value='<fmt:message key="Confirm"/>' onclick="createJob()">

</form>
</fmt:bundle>

<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>

</body>
</html>
