<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.msg.util.LoginControllerAdaptor" %>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%  
		LoginControllerAdaptor loginAdaptor=(LoginControllerAdaptor) Helper.getBean(LoginControllerAdaptor.ImplBeanName);
		String delayTime=(String)session.getAttribute("delayTime");
		String delayShowType=(String)session.getAttribute("delayShowType");
%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmessage/interface/MessageControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmessage/interface/ManageControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmessage/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrmessage/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/jquery/plugin/jquery.timers-1.2.js'></script>
<script language="javascript">
function saveAdvanceData(){
	var userMap ="{\"USERID\":\"<%=loginAdaptor.getOperID(request)%>\",\"delayTime\":\""+document.delayForm.delayTime.value+"\",\"delayShowType\":\""+document.delayForm.delayShowType.value+"\"}";
	ManageControl.save(userMap,saveback);
}
function saveback(data){
	alert(data);
	if(data=="2"){
		alert("<fmt:message key='gap.message.Save_successful_' bundle='${applicationMessageResources}' />");
	}else{
		alert("<fmt:message key='gap.message.Save_failed_' bundle='${applicationMessageResources}' />");
	}
}
/**
 * 功能描述：取产品数据填入表格
 * 参数：	;
 */
var getNewMessage = function(){
	MessageControl.receive4Num('<%=loginAdaptor.getOperID(request)%>',10,callback);
}


/**
 * 功能描述：动态填充表格内容
 * 参数：	data -- 填充表格对象数组
 */
function callback(data){
	var obj = document.getElementById("messagediv");
	if(data.length>0){
		var innerContent = "<font color=red><fmt:message key='gap.message.You_have_new_messages' bundle='${applicationMessageResources}' />" + data.length + "<fmt:message key='gap.message.Article_' bundle='${applicationMessageResources}' /></font>";
		innerContent = innerContent+"<marquee direction=left scrolldelay=100 scrollamount=3 width=25% hight=20>";
		for(var i=0;i<data.length;i++){
			try{
				if (obj) {
					innerContent = innerContent+"<a href='<%=request.getContextPath()%>/MessageAction.do?cmd=findByMessageWithUserId&messageid="+data[i].id+"'>"+data[i].msgTitle+ " <fmt:message key='gap.message.Come_from' bundle='${applicationMessageResources}' /> " +data[i].from +"</a>"+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}
			} catch (ex) {
				alert(ex.message);
			}
		}
		innerContent = innerContent+"</marquee>";
		obj.innerHTML=innerContent;
	}else{
		obj.innerHTML= "";
	}
}
var getNewMessagePop = function(){
	MessageControl.receive4Num('<%=loginAdaptor.getOperID(request)%>',10,getMsg);
}

window.onresize = resizeDiv;
window.onerror = function(){}
var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,i = 0;

function getMsg(data)
{
	if(data.length>0){
		closeDiv();
		document.getElementById("datalength").value=data.length;
        try{
        divTop = parseInt(document.getElementById("msgpopdiv").style.top,10);
        divLeft = parseInt(document.getElementById("msgpopdiv").style.left,10);
        divHeight = parseInt(document.getElementById("msgpopdiv").offsetHeight,10);
        divWidth = parseInt(document.getElementById("msgpopdiv").offsetWidth,10);
        docWidth = document.body.clientWidth;
        docHeight = document.body.clientHeight;
        document.getElementById("msgpopdiv").style.top = parseInt(document.body.scrollTop,10) + docHeight + 10;//  divHeight
        document.getElementById("msgpopdiv").style.left = parseInt(document.body.scrollLeft,10) + docWidth - divWidth;
        document.getElementById("msgpopdiv").style.visibility="visible";
        jQuery(document).everyTime(10,"objTimer",moveDiv);
        }
        catch(e){}
    }  
}

function resizeDiv()
{
        i+=1
        if(i>500) {
        	i=0;
        	closeDiv()
        }
        try{
        divHeight = parseInt(document.getElementById("msgpopdiv").offsetHeight,10)
        divWidth = parseInt(document.getElementById("msgpopdiv").offsetWidth,10)
        docWidth = document.body.clientWidth;
        docHeight = document.body.clientHeight;
        document.getElementById("msgpopdiv").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10)
        document.getElementById("msgpopdiv").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10)
        }
        catch(e){}
}

function moveDiv()
{
        try
        {
        if(parseInt(document.getElementById("msgpopdiv").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10)))
        {
        jQuery(document).stopTime("objTimer");
        jQuery(document).everyTime(1,"objTimer",resizeDiv);
        }
        divTop = parseInt(document.getElementById("msgpopdiv").style.top,10)
        document.getElementById("msgpopdiv").style.top = divTop - 1
        }
        catch(e){}
}
function closeDiv()
{
        document.getElementById('msgpopdiv').style.visibility='hidden';
        jQuery(document).stopTime("objTimer");
}
</script>
<div id="messagediv"> 
</div>
<body><!--scroll=no--> 
  <DIV   id="msgpopdiv"   style="BORDER-RIGHT:   #455690   1px   solid;   BORDER-TOP:   #a6b4cf   1px   solid;   Z-INDEX:99999;   LEFT:   0px;   VISIBILITY:   hidden;   BORDER-LEFT:   #a6b4cf   1px   solid;   WIDTH:   180px;   BORDER-BOTTOM:   #455690   1px   solid;   POSITION:   absolute;   TOP:   0px;   HEIGHT:   116px;   BACKGROUND-COLOR:   #c9d3f3">   
  <TABLE   style="BORDER-TOP:   #ffffff   1px   solid;   BORDER-LEFT:   #ffffff   1px   solid"   cellSpacing=0   cellPadding=0   width="100%"   bgColor=#cfdef4   border=0>   
  <TBODY>   
  <TR>   
  <TD   style="FONT-SIZE:   12px; COLOR:   #0f2c8c"   width=30   height=24></TD>   
  <TD   style="FONT-WEIGHT:   normal;   FONT-SIZE:   12px; COLOR:   #1f336b;   PADDING-TOP:   4px;PADDING-left:   4px"   vAlign=center   width="100%">   <fmt:message key='gap.message.SMS_Tip_' bundle='${applicationMessageResources}' /></TD>   
  <TD   style="PADDING-TOP:   2px;PADDING-right:2px"   vAlign=center   align=right   width=19><span   title="<fmt:message key='gap.message.Close' bundle='${applicationMessageResources}' />"   style="CURSOR:   hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;"   onclick=closeDiv()   >×</span></TD>   
  </TR>   
  <TR>   
  <TD   style="PADDING-RIGHT:   1px;   PADDING-BOTTOM:   1px"   colSpan=3   height=90>   
  <DIV   style="BORDER-RIGHT:   #b9c9ef   1px   solid;   PADDING-RIGHT:   13px;   BORDER-TOP:   #728eb8   1px   solid;   PADDING-LEFT:   13px;   FONT-SIZE:   12px;   PADDING-BOTTOM:   13px;   BORDER-LEFT:   #728eb8   1px   solid;   WIDTH:   100%;   COLOR:   #1f336b;   PADDING-TOP:   18px;   BORDER-BOTTOM:   #b9c9ef   1px   solid;   HEIGHT:   100%"><fmt:message key='gap.message.You_have' bundle='${applicationMessageResources}' /><input type= "text " id="datalength" name= "datalength " value=0 style= "border:0;width:25px;BACKGROUND-COLOR:#c9d3f3" ><fmt:message key='gap.message.For_new_SMS' bundle='${applicationMessageResources}' /><BR><BR>   
  <DIV   align=center   style="word-break:break-all"><a   href="<%=request.getContextPath()%>/MessageAction.do?cmd=receivenew"><font   color=#FF0000><fmt:message key='gap.message.Click_to_view_the_message' bundle='${applicationMessageResources}' /></font></a></DIV>   
    
  </DIV>   
  </TD>   
  </TR>   
  </TBODY>   
  </TABLE>   
  </DIV> 
</body> 
<script>
function advanceTag_HideOrShow(){
		var current=document.getElementById("advanceTag");
  	if(current.style.visibility=="hidden")
    {
      current.style.visibility ="visible";
    }
  	else
   {
     current.style.visibility ="hidden";
   }
}
function changeShowType(avalue){
	document.delayForm.delayShowType.value=avalue;
	jQuery(document).stopTime("delayTimer");
	if(avalue=="1"){
		closeDiv();
		jQuery(document).everyTime(1000*document.delayForm.delayTime.value,"delayTimer",getNewMessage);//轮询时间间隔
	}else if(avalue=="2"){
		document.getElementById("messagediv").innerHTML= "";
		jQuery(document).everyTime(1000*document.delayForm.delayTime.value,"delayTimer",getNewMessagePop());//轮询时间间隔
	}else if(avalue=="0"){
		//停止显示
		closeDiv();
		document.getElementById("messagediv").innerHTML= "";
	}
}
function changeDelayTime(avalue){
	document.delayForm.delayTime.value=avalue;
	jQuery(document).stopTime("delayTimer");
	if(document.delayForm.delayShowType.value=="1"){
		jQuery(document).everyTime(1000*document.delayForm.delayTime.value,"delayTimer",getNewMessage);//轮询时间间隔
	}else if(document.delayForm.delayShowType.value=="2"){
		jQuery(document).everyTime(1000*document.delayForm.delayTime.value,"delayTimer",getNewMessagePop);//轮询时间间隔
	}else if(document.delayForm.delayShowType.value=="0"){
		//停止显示
	}
}
function startReceiveNewMessage(){
 	if(document.delayForm.delayShowType.value==2){
 		jQuery(document).everyTime(1000*document.delayForm.delayTime.value,"delayTimer",getNewMessagePop);//轮询时间间隔
	}else if(document.delayForm.delayShowType.value==1){
		jQuery(document).everyTime(1000*document.delayForm.delayTime.value,"delayTimer",getNewMessage);//轮询时间间隔
	}
}
</script>
<!--<a href="javascript:advanceTag_HideOrShow()">高级选项</a>--><!--有在页面设置配置项的特殊需求可以打开本设置。-->
<div id=advanceTag style="visibility:hidden">
<form name="delayForm">
<input type="hidden" name="delayTime" value="<%=delayTime%>">
<input type="hidden" name="delayShowType" value="<%=delayShowType%>">
<fmt:message key='gap.message.Interval' bundle='${applicationMessageResources}' />:<select name=delaySet onclick="changeDelayTime(this.value)">
<option value="2">2<fmt:message key='gap.message.Second' bundle='${applicationMessageResources}' /></option><!--测试用，实际使用时建议注释掉-->
	<option value="10" <%="10".equals(delayTime)?"selected":""%>>10<fmt:message key='gap.message.Second' bundle='${applicationMessageResources}' /></option>
	<option value="30" <%="30".equals(delayTime)?"selected":""%>>30<fmt:message key='gap.message.Second' bundle='${applicationMessageResources}' /></option>
	<option value="60" <%="60".equals(delayTime)?"selected":""%>>1<fmt:message key='gap.message.Point' bundle='${applicationMessageResources}' /></option>
	<option value="600" <%="600".equals(delayTime)?"selected":""%>>10<fmt:message key='gap.message.Point' bundle='${applicationMessageResources}' /></option>
	<option value="1800" <%="1800".equals(delayTime)?"selected":""%>>30<fmt:message key='gap.message.Point' bundle='${applicationMessageResources}' /></option>
</select>
<br/>
<fmt:message key='gap.message.Display' bundle='${applicationMessageResources}' />:<input type=radio name=showType value=0 onclick="changeShowType(this.value)" <%="0".equals(delayShowType)?"checked":""%>><fmt:message key='gap.message.Disable' bundle='${applicationMessageResources}' /><input type=radio name=showType value=1 onclick="changeShowType(this.value)" <%="1".equals(delayShowType)?"checked":""%>><fmt:message key='gap.message.Cycle' bundle='${applicationMessageResources}' /><input type=radio name=showType value=2 onclick="changeShowType(this.value)" <%="2".equals(delayShowType)?"checked":""%>><fmt:message key='gap.message.Leak' bundle='${applicationMessageResources}' />
<br/>
<input type=button  class="button_ellipse" value=<fmt:message key='gap.message.Save' bundle='${applicationMessageResources}' /> onclick="javascript:saveAdvanceData()">
</form>
</div>
<script language="javascript">
	startReceiveNewMessage();
</script>


