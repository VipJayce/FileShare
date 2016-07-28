

/**
* @author 冉闵
* 启用或禁用按钮
*/

function SetButtonEnabledState(sButtonID, bEnabledState){
	var e = new Error();
	try {
		var oBtn = eval("document.all." + sButtonID);
		oBtn.disabled = !bEnabledState;
		oBtn.style.cursor = ((bEnabledState) ? "hand" : "default");
	}catch (e) {
		return;
	}
	
	try {
		var oBtnImage = eval("document.all." + sButtonID + "_Image");
		oBtnImage.filters.Gray.enabled   = !bEnabledState;
		oBtnImage.filters.alpha.enabled  = !bEnabledState;
	}catch (e) {
	}
}

function rmSetupAuthorize(formName, accessType) {
	var element = window.document.getElementsByName(formName);
	if(element != null && element.length > 0) {
		if(element.length == 1) {
			var tempElement = element[0];
			if(tempElement.type == "hidden") {
				return;
			}
			if(accessType == "DISABLED") {
				rmSetDisableFormElement(tempElement);
			} else if (accessType == "READ") {
				rmSetReadFormElement(tempElement);
			} else if (accessType == "WRITE") {
				//什么也不做
			} else if (accessType == "") {  //表示没有任何权限
				rmHiddenFormElement(tempElement.parentElement.previousSibling, "visibility", "hiddenChild");
				rmHiddenFormElement(tempElement.parentElement, "visibility", "hiddenChild");
			}
		} else {
			//循环处理，如法炮制
			for(var i=0; i<element.length; i++) {
				var tempElement = element[i];
				if(accessType == "DISABLED") {
					rmSetDisableFormElement(tempElement);
				} else if (accessType == "READ") {
					rmSetReadFormElement(tempElement);
				} else if (accessType == "WRITE") {
					//什么也不做
				} else if (accessType == "") {  //表示没有任何权限
					rmHiddenFormElement(tempElement.parentElement, "visibility", "hiddenChild");
					rmHiddenFormElement(tempElement.parentElement.previousSibling, "visibility", "hiddenChild");
				}
			}
		}

	}
}

function rmSetDisableFormElement(formElement) {
	formElement.insertAdjacentHTML("beforeBegin", formElement.outerHTML);
	var disabledElement = formElement.previousSibling;
	disabledElement.disabled = true;
	disabledElement.style.backgroundColor = "#CCCCCC";
	disabledElement.style.color = "#000000";

	rmHiddenFormElement(formElement);

}

function rmSetReadFormElement(formElement) {
	if(formElement.rmtype == "accessory") {
		formElement.rmauthorize = "READ";
		return;
	}
	var thisElementValue = "";
	if(formElement.tagName != null && formElement.tagName.toUpperCase() == "SELECT") {
		for(var i=0; i<formElement.options.length; i++) {
			var thisOption = formElement.options[i];
			if(!thisOption.selected) {
				continue;
			}
			if(thisElementValue != "") {
				thisElementValue = ",";
			}
			thisElementValue += thisOption.text;
		}
	} else {
		thisElementValue = formElement.value;
	}
	if(formElement.tagName.toUpperCase() == "TEXTAREA") {
		thisElementValue = thisElementValue.replace(/\n/g, "<br>");
	}
	var readOnlyStr = "<span>";
	readOnlyStr += thisElementValue + "</span>";
	formElement.insertAdjacentHTML("beforeBegin", readOnlyStr);
	var readOnlyElement = formElement.previousSibling;
	
	rmHiddenFormElement(formElement);
}

function rmHiddenFormElement(formElement, hiddenType, hiddenContent) {
	if(hiddenType == undefined ) {
		hiddenType = "display";
	}
	if(hiddenContent == undefined) {
		hiddenContent = "hiddenAll";
	}
	if(formElement == null) {
		return false;
	}
	if(hiddenContent == "hiddenAll") {
		if(hiddenType == "display") {
			formElement.style.display = "none";
		} else if(hiddenType == "visibility") {
			formElement.style.visibility = "hidden";
		}
		var thisImg = formElement.nextSibling;
		if(thisImg != null && thisImg.tagName == "IMG" && thisImg.className == "refButtonClass") {
			thisImg.style.display = "none";
		} else if(thisImg != null && thisImg.type == "hidden"){
			rmHiddenFormElement(thisImg.nextSibling);
		}
	} else if(hiddenContent == "hiddenChild") {
		for(var i=0; i<formElement.all.length; i++) {
			if(hiddenType == "display") {
				formElement.all[i].style.display = "none";
			} else if(hiddenType == "visibility") {
				formElement.all[i].style.visibility = "hidden";
			}
		}
		if(formElement.align == "right") {  //说明它是左边的说明文字
			formElement.innerText = " ";			
		}
	}
}


function enableDocumentByTagName(tagName) {
	var elements = document.getElementsByTagName(tagName);
	for(var i=0; i<elements.length; i++) {
		if(elements[i].disabled) {
			elements[i].disabled = false;
		}
	}
}

function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
	var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
	var number = 0;  //定义游标
	var ids = null;  //定义id值的数组
	for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
		if(elementCheckbox[i].checked) {  //如果被选中
			number += 1;  //游标加1
			if(ids == null) {
				ids = new Array(0);
			}
			ids.push(elementCheckbox[i].value);  //加入选中的checkbox
		}
	}
	return ids;
}

function getRowHiddenId() {  //从事件取得本行的id
	var thisA = event.srcElement;  //定义事件来源对象
	
	if(thisA.tagName != "TD") {
		thisA = thisA.parentElement;
	}
	
	var thisTr = thisA.parentElement.parentElement;  //定义本行的tr对象
	var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
	if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
		return thisHidden.value;
	} else {
		return null;
	}
}

//，把复选框勾选掉--马啸添加
function selectAllRows (){
	 	var element = document.getElementsByTagName("input");
		for(var i=0;i<element.length;i++){
			if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
				element[i].checked=true;
			}
		}
}

//，把复选框勾选掉--马啸添加
function unSelectAllRows (){
	 	var element = document.getElementsByTagName("input");
		for(var i=0;i<element.length;i++){
			if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
				element[i].checked=false;
			}
		}
}
function checkAllList_onClick(thisObj){  //全选，全不选
	//alert(thisObj);
	if(thisObj.checked) {  //如果选中
		selectAllRows('template');  //全选checkbox
	} else {
		unSelectAllRows('template');  //全不选checkbox
	}
}


