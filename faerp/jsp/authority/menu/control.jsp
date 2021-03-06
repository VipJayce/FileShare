<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; UTF-8">
<title></title>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery/plugin/ex.tabs.js"></script>
</head>
<body leftmargin="0" topmargin="0" bgcolor="#f5f5f5">
<table width="24" height="100%"  border="0" cellpadding="0" cellspacing="0">
	<tr>
	   <td >    
	       <div id="Layer012" style="position:absolute; width:24px; height:115px; z-index:0; layer-background-color: #f5f5f5; border: 0px none #ffffff;top:200px" >    
	           <img src="<%=request.getContextPath() %>/images/au/close.gif" title = "<fmt:message key='gap.authority.hidemenu' bundle='${applicationAuResources}' />" width="10" height="50" showImage1="<%=request.getContextPath() %>/images/au/close.gif" showImage2="<%=request.getContextPath() %>/images/au/close_01.gif" hiddImage1="<%=request.getContextPath() %>/images/au/open.gif" hiddImage2="<%=request.getContextPath() %>/images/au/open_01.gif" onMouseOver="doMouseOverImg(event)" onMouseOut="doMouseOutImg(event)" status1="show" style="cursor:hand;cursor:pointer;" onClick="hiddenFuncTree(event)" name="Image26" width="24" height="43" border="0">
	       </div>
	    </td>
	</tr>
</table>
</body>
</html>
<script language="javascript">
	var hiddenHandler = new HiddenHandler(0,15,175);
	var thisParentFrame = parent.document.getElementById("subMainFrameSet");
	function hiddenFuncTree(event) {
		var thisObj = event.srcElement ? event.srcElement : event.target;
		if(thisObj.getAttribute("status1") == "show") {
			hiddenHandler.hidden();
			thisObj.setAttribute("status1", "hidden");
			thisObj.src = thisObj.getAttribute("hiddImage1");
			thisObj.title = "<fmt:message key='gap.authority.showmenu' bundle='${applicationAuResources}' />";
		} else if(thisObj.getAttribute("status1") == "hidden") {
			hiddenHandler.show();
			thisObj.setAttribute("status1", "show");
			thisObj.src = thisObj.getAttribute("showImage1");
			thisObj.title = "<fmt:message key='gap.authority.hidemenu' bundle='${applicationAuResources}' />";
		}	
		setSize();
	}
	
	function setSize(){
		var bodyFrame = jQuery( window.parent.document ).find( "#contentFrame" ).attr("contentWindow");
		jQuery( bodyFrame.document.getElementById("tabPanel") ).tabs('resize');
	}
	
	function doMouseOverImg(event) {
		var thisObj = event.srcElement ? event.srcElement : event.target;
		if(thisObj.getAttribute("status1") == "show") {
				thisObj.src = thisObj.getAttribute("showImage2");
		} else if(thisObj.getAttribute("status1") == "hidden") {
				thisObj.src = thisObj.getAttribute("hiddImage2");
		}
	}
	
	function doMouseOutImg(event) {
		var thisObj = event.srcElement ? event.srcElement : event.target;
		if(thisObj.getAttribute("status1") == "show") {
				thisObj.src = thisObj.getAttribute("showImage1");
		} else if(thisObj.getAttribute("status1") == "hidden") {
				thisObj.src = thisObj.getAttribute("hiddImage1");
		}
	}
	
	function HiddenHandler(totalTime, minTime, totalWidth) {
		this.totalTime = totalTime;
		this.totalWidth = totalWidth;
		this.minTime = minTime;
		this.currentWidth = 0;
		this.currentTime = 0;
		this.isInit = false;
		this.getWidth = function() {
			var difWidth = this.totalWidth * (this.minTime / this.totalTime);
			return difWidth;
		}
		
		this.hidden = function() {
			if(this.currentWidth <= 0 && !this.isInit) {
				this.currentWidth = this.totalWidth;
				this.isInit = true;
			}
			
			if(this.currentWidth > 0) {
				setTimeout("hiddenHandler.hidden()", this.minTime);				
			}
			var thisWidth = this.currentWidth - this.getWidth();
			if(thisWidth <= 0) {
					thisWidth = 0;
			}
			doHiddenInstance(thisWidth);
			this.currentWidth = thisWidth;
		}
		
		this.show = function() {
			if(this.currentWidth >= totalWidth && !this.isInit) {
				this.currentWidth = 0;
				this.isInit = true;
			}
			if(this.currentWidth < this.totalWidth) {
				setTimeout("hiddenHandler.show()", this.minTime);				
			}
			var thisWidth = this.currentWidth + this.getWidth();
			if(thisWidth >= this.totalWidth) {
					thisWidth = this.totalWidth;
			}
			doHiddenInstance(thisWidth);
			this.currentWidth = thisWidth;
		}
		
	}
	
	function doHiddenInstance(width) {
			thisParentFrame.setAttribute("cols", width + ",11,*");
	}
	
</script>