//for Alexander
function getMessageOrgTree(inputArray,path,deeptreePath,width,height){
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
	_toDoWriteWorkflowOrgTree(inputArray, rtObj);
}

//for Alexander
function _toDoWriteWorkflowOrgTree(inputArray,rtObj){
	var textValue = inputArray[0];
	var textName = inputArray[1];
	if(rtObj != undefined && rtObj.length > 0){
		var allTextValue = "";
		var allTextName = "";
		for(var i=0; i<rtObj.length-1; i++) {
			allTextValue += rtObj[i]['returnValue'] + ";";
			allTextName += rtObj[i]['childName'] + ",";
		}
		allTextValue += rtObj[rtObj.length-1]['returnValue'];
		allTextName += rtObj[rtObj.length-1]['childName'];
		
        jQuery("#"+textValue).val(allTextValue);
        jQuery("#"+textValue).trigger("change");
        jQuery("#"+textName).val(allTextName);
        jQuery("#"+textName).trigger("change");
	} else {
		//TODO
		return;
	}
}

function getRealInputLength(inputField){
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
		return thisEvent.srcElement;
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

