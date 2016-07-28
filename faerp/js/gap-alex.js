//跨浏览器新增
jQuery(function(){
    jQuery("input[class^='2button_']").live("mouseover",doMouseOver).live("mouseout",doMouseOut).live("mousedown",doMouseDown)
               .live("mouseup",doMouseUp).live("click",doClick).live("keydown",DoKeyDown)
               .each(function(){
               	    doInit(this);
               });	
});

function checkItems(){
    return true;
}

function doInit(button){
    var buttonFocusClass;
    if(button.value.length <= 2) {
        buttonFocusClass = "2button_01";
    } else if(button.value.length <= 4) {
        buttonFocusClass = "2button_02";
    } else if(button.value.length <= 6) {
        buttonFocusClass = "2button_03";
    } else {
        buttonFocusClass = "2button_04";
    }
    button.className = buttonFocusClass;
}

function doMouseOver(event){
    var thisObj= getEventObj(event);
    if(thisObj == undefined || thisObj == null)
        return false;
    var buttonFocusClass;
    if(thisObj.value.length <= 2) {
        buttonFocusClass = "2button_01a";
    } else if(thisObj.value.length <= 4) {
        buttonFocusClass = "2button_02a";
    } else if(thisObj.value.length <= 6) {
        buttonFocusClass = "2button_03a";
    } else {
        buttonFocusClass = "2button_04a";
    }
    this.className = buttonFocusClass;
    if(jQuery.isFunction(jQuery(thisObj).attr("push"))){
    	eval(jQuery(thisObj).attr("push"));
    }
}

function doMouseOut(event){
    var thisObj= getEventObj(event);
    if(thisObj == undefined || thisObj == null)
        return false;
    var buttonFocusClass;
    if(thisObj.value.length <= 2) {
        buttonFocusClass = "2button_01";
    } else if(thisObj.value.length <= 4) {
        buttonFocusClass = "2button_02";
    } else if(thisObj.value.length <= 6) {
        buttonFocusClass = "2button_03";
    } else {
        buttonFocusClass = "2button_04";
    }
    this.className = buttonFocusClass;
    if(jQuery.isFunction(jQuery(thisObj).attr("push"))){
        eval(jQuery(thisObj).attr("push"));
    }
}

function doMouseDown(event){
	var thisObj= getEventObj(event);
    if(jQuery.isFunction(jQuery(thisObj).attr("push"))){
        eval(jQuery(thisObj).attr("push"));
    }
}

function doMouseUp(event){
    var thisObj= getEventObj(event);
    if(jQuery.isFunction(jQuery(thisObj).attr("push"))){
        eval(jQuery(thisObj).attr("push"));
    }
}

function doClick(event){
	var thisObj= getEventObj(event);
    var onclickto = jQuery(thisObj).attr("onclickto");
    if(onclickto == null || (typeof onclickto.length== "undefined")){
        return false;
    }
    if(!(onclickto.length>0))
        return false;
     
    showWait(event);
    beginvalidator = true;
    if(!checkItems()){
        event.cancelBubble = true;
        beginvalidator = false;
        hideWait();
        return false;
    }
    
    beginvalidator = false;
    /*disableAllButton();*/
    
    re = eval(onclickto);
    if(re!= null && !re){
        event.cancelBubble = true
        hideWait();
        return false;
    }
    
    if(jQuery.isFunction(jQuery(thisObj).attr("push"))){
        eval(jQuery(thisObj).attr("push"));
    } 
}

function showMessage(){
    alert("Button showMessage run.");
}

function DoKeyDown(event)
{
    if(!(onclickto.length>0))
        return false;
    checkItems();
    if(!NotRun)
        return false;
    if(jQuery.isFunction(jQuery(thisObj).attr("push"))){
        eval(jQuery(thisObj).attr("push"));
    } 
}








//跨浏览器新增结束

//for Alexander
function getWorkflowOrgTree(inputArray,path,deeptreePath,width,height){
	if(path == undefined) {
		path = "../../";
	}
	if(width == undefined) {
		width = 550;
	}
	if(height == undefined) {
		height = 550;
	}
	var myObject = new Object();
	var rtObj = window.showModalDialog(deeptreePath,myObject,'dialogHeight='+height+'px;dialogWidth='+width+'px;');
	toDoWriteWorkflowOrgTree(inputArray, rtObj);
}

//for Alexander
function toDoWriteWorkflowOrgTree(inputArray,rtObj){
	var textValue = inputArray[0];
	var textName = inputArray[1];
	if(rtObj != undefined && rtObj.length > 0){
		var allTextValue = "";
		var allTextName = "";
		for(var i=0; i<rtObj.length-1; i++) {
			allTextValue += rtObj[i]['returnValue'] + ";";
			allTextName += rtObj[i]['childName'] + "，";
		}
		allTextValue += rtObj[rtObj.length-1]['returnValue'];
		allTextName += rtObj[rtObj.length-1]['childName'];
		textValue.value = allTextValue;
		textName.value = allTextName;
	} else {
		//TODO
		return;
	}
}

function getRealInputLength(inputField){
    if(!inputField) return 0;
	return inputField.value.replace(/[^\x00-\xff]/g,'**').length;
}

function warnInputError(_frm,msg){
	if(msg != null)
		alert(msg);
	//_frm.focus();
	_frm.click();
	_frm.select();
	_frm.style.borderStyle = "dashed";
	_frm.style.borderColor = "rgb(255,50,0)";
	if(_frm.value != null && _frm.readonly != null){
		_frm.style.backgroundColor = "highlight";
		_frm.style.color = "white";
	}
}

function getEventObj(thisEvent) {
	if(thisEvent == undefined || thisEvent == null) {
		alert("No current event object, Sir.");
		return null;
	} else {
		return thisEvent.srcElement?thisEvent.srcElement:thisEvent.target;
	}
}

/*------------------------alexander's ajax template----------------------------------*/

//Public, for ajax: get synchronization XML
function ajaxGet(url,callbackFn) {
	ajaxGet2(url,callbackFn,true,true);
}

//Public, for ajax: get
function ajaxGet2(url,callbackFn,isSynchro,isXML) {
	if(callbackFn==null){
		alert("Alexander's ajaxGet error. Some parameters are null.");
		return;	
	}
	else{
		req = getRequest();
		req.open("GET", url, isSynchro); //isSynchro=true is synchronization Ajax
		req.onreadystatechange = function () { alexCallback(callbackFn,isXML); };
		req.send(null);
	}
}

//Public, for ajax: post synchronization XML
function ajaxPost(url,callbackFn,formParamArr) {
	ajaxPost2(url,callbackFn,formParamArr,null,true,true);
}

//Public, for ajax: post
//formParamValueArr could be null.
function ajaxPost2(url,callbackFn,formParamArr,formParamValueArr,isSynchro,isXML) {
	if(formParamArr==null || formParamArr.length<1 || callbackFn==null){
		alert("Alexander's ajaxPost error. Some parameters are null.");
		return;	
	}
	else{
		req = getRequest();
		req.open("POST", url, isSynchro); //isSynchro=true is synchronization Ajax
		req.onreadystatechange = function () { alexCallback(callbackFn,isXML); };
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var postStr = "";
		for(var i=0;i<formParamArr.length;i++){
			var formParamValue;
			if(formParamValueArr==null)
				formParamValue = document.getElementsByName(formParamArr[i])[0].value;
			else
				formParamValue = formParamValueArr[i];
			postStr = postStr + "&" + formParamArr[i] + "=" + formParamValue;
		}
		req.send(postStr);
	}
}

//Private
function getRequest() {
	var xmlreq = false;
	if (window.XMLHttpRequest) {
    	//Create XMLHttpRequest object in non-Microsoft browsers
    	xmlreq = new XMLHttpRequest();
    }
  	else if (window.ActiveXObject) {
    	//Create XMLHttpRequest via MS ActiveX
    	try {
      		//Try version supported by older versions of Internet Explorer
      		xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
      	}
    	catch (e1) {
      		//Failed to create required ActiveXObject
      		try {
      			//Try to create XMLHttpRequest in later versions of Internet Explorer
      			//alert: This ActiveObject not support XML DOM
        		xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
        	}
        	catch (e2) {
        		//Unable to create an XMLHttpRequest with ActiveX
        		alert("Browser no support Ajax.");
        	}
        }
	}
	return xmlreq;
}

//Private, execute user's callback function (callbackFn)
function alexCallback(callbackFn,isXML) {
    if (req.readyState == 4) {
		if (req.status == 200) {
        	var responseData;
        	if(isXML)
        		responseData = req.responseXML;
        	else	
        		responseData = req.responseText;
        	callbackFn(responseData);
        }
    }
}