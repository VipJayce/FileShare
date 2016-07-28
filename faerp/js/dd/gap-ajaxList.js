  	/*
	 *从enum文件中读取信息，填充选择框
	 *@param data 从enum文件中读取的数据（List）
 	 *@param selectid
	 */
  	function setSelect(data,selectid){ 
  		var sel = DWRUtil.getValue(selectid);   
	    DWRUtil.removeAllOptions(selectid); 
	    var dataPre={
	    	label:"--------",
	    	value:"000"
	    }
	    var items = [dataPre];
	    DWRUtil.addOptions(selectid,items,"value","label");
	    DWRUtil.addOptions(selectid,data,"value","label");
	    DWRUtil.setValue(selectid,sel); 
  	}  

function $name(name){
	return document.getElementsByName(name)[0];
}
/**
 * 功能描述：获得多选框对应的行内隐藏主键集合
 * 参数描述：checkName -- 多选框的名称
 *					  idName -- 行记录的隐藏主键id;
 */    
function buildDeleteIds(checkName,idName){
	var checkboxall = document.getElementsByName(checkName);
	var data = new Array();//对象集合
	var number = 0;
	for(var i=0;i<checkboxall.length;i++){
		if(checkboxall[i].checked==false){
			continue;
		}
		var trObj = checkboxall[i].parentElement.parentElement;
		data[number] = getObjectByNameRecursive(trObj,idName).value;
		number++;
	}
	return data;
}

/**
 * 功能描述：对指定表的指定行的单元格填充数据
 * 参数描述：tableObj -- 指定的表对象 
 *					  rowObj -- 指定的行对象;
 *					  cells -- 要填充到行内单元格的对象数据集;
 */    
function changeCell(rowObj,cells){
	//rowObj.className="listCss";
	for(var i=0;i<rowObj.cells.length;i++){
		if(i>=2){
			rowObj.cells[i].innerHTML=cells[i];
		}
	}
}

/**
 * 功能描述：动态编辑添加行时按照行号为动态创建的控件名进行编号，即将控件名修改为带有序号的控件名
 * 参数描述：htmlcomponentstr -- 控件字符串 
 *					  num -- 序号;
 */    
function changeName(htmlcomponentstr,num){
	if(htmlcomponentstr.indexOf("checkbox")!=-1) return htmlcomponentstr;//不修改checkbox类型的控件名称
	var strArray = htmlcomponentstr.split(" name=");
	for(var i=1;i<strArray.length;i++){
		var middlestr = strArray[i].substring(0,strArray[i].indexOf(" "));
		var nameArray = middlestr.split("\"");//截取name属性值
		middlestr = strArray[i].substring(strArray[i].indexOf(" "),strArray[i].length);//去掉截取字符串后，name属性剩下的值
		strArray[i] = "\""+nameArray[1]+num+"\""+middlestr;//修改name属性值
	}
	var modifystr="";
	if(strArray.length >2){
		for(var j=1;j<strArray.length;j++){
			(j==(strArray.length-1))?modifystr = modifystr+strArray[j]:modifystr = modifystr+strArray[j]+" name=";
		}
	}else{
		modifystr = modifystr+strArray[1];
	}
	var prestr = strArray[0]+" name=";
	return prestr+modifystr;
}

/**
 * 功能描述：填充指定表的tbody内容
 * 参数描述：tableId -- 指定的表对象id 
 *					  cellObjects -- 要填充到行内单元格的对象数据集;
 *					  num -- 要填充的行数;
 */  
function changeRow(tableId,cellObjects,num){
	var tbodyObj = DWRUtil.byId(tableId);
	//var tableObj = tbodyObj.parentElement;
	var rowObj1= tbodyObj.rows[num-1];
	//alert(dwr.util.toDescriptiveString(cellObjects, 2));
	changeCell(rowObj1,cellObjects);
}

/**
 * 功能描述：动态编辑表格时创造参照
 * 参数描述：tdObj -- 单元格对象 
 *					  refrenceObj -- 参照对象数组，创建参照用;
 */
function createRefrence(tdObj,refrenceObj){
	var divElement = document.createElement("DIV");
	var inputElement = document.createElement(refrenceObj[0]);
	inputElement.style.width = tdObj.offsetWidth-20; 
	inputElement.value = tdObj.innerText;
	var imgElement = document.createElement(refrenceObj[1]);
	var hiddenElement = document.createElement(refrenceObj[2]);
	divElement.innerHTML = inputElement.outerHTML+imgElement.outerHTML+hiddenElement.outerHTML;
	return divElement;
}

/**
 * 功能描述：从多选框物理删除多条记录
 * 参数描述：checkName -- 多选框的名称
 */  
function deleteRows(checkName){ 
	var elementCheckbox = document.getElementsByName(checkName);
	var tableElement=elementCheckbox[0].parentElement.parentElement.parentElement;
	for(var i=0;i<elementCheckbox.length;i++){
		if(elementCheckbox[i].checked) {
			tableElement.deleteRow(elementCheckbox[i].parentElement.parentElement.rowIndex-1);
			i--;
		}
	}
    return;
}

/**
 * 功能描述：删除本行记录
 * 参数描述：obj -- 删除按钮对象
 */  
function deleteRow(obj){
	var trObj = obj.parentElement.parentElement;
	var tableObj = trObj.parentElement;
	tableObj.deleteRow(trObj.rowIndex-1);
}

/**
 * 功能描述：生成存放提示结果的javascript对象
 * 参数描述：id -- 提示的前提条件对应的id
 *					  collectionId -- 根据前提条件产生的提示结果存放的控件id;
 */  
function displaySuggestion(id,collectionId){
	if($(id).value == ""){
		return;
	}
	jsAutoInstance._msg = [];
  	jsAutoInstance.item($(collectionId).value);
}

/**
 * 功能描述：获取元素的横坐标
 * 参数描述：e -- HTML控件元素对象
 *					  
 * 					 
 */  
function getLeft(e){
	var offset=e.offsetLeft;
	if(e.offsetParent!=null) offset+=getLeft(e.offsetParent);
	return offset;
} 

/**
 * 功能描述：获取元素的纵坐标
 * 参数描述：e -- HTML控件元素对象
 *					  
 * 					 
 */  
function getTop(e){
	var offset=e.offsetTop;
	if(e.offsetParent!=null) offset+=getTop(e.offsetParent);
	return offset;
}

/**
 * 功能描述：包含页面
 * 参数描述：pageobj --要包含的页面的相对路径;
 */    
function include(pageobj,divId,func) {
	AjaxControl.getInclude(pageobj,function(data) {
		if (data != null && typeof data == 'object') {
			alert(dwr.util.toDescriptiveString(data, 2));
		}
		else dwr.util.setValue(divId, data, { escapeHtml:false });
		func;
	});
}

/**
 * 功能描述：输入参照数据尾数可根据样例生成完整的参照数据代码和显示（主要用于规则数据）
 * 参数描述：refrenceCode -- 参照数据样例数据
 *					  id -- 参照数据隐藏id;
 * 					  showId -- 参照数据显示id;
 */  
function inputTransfer(refrenceCode,id,showId) {
	if(event.keyCode==13||event.keyCode==0){//响应键盘事件及点击鼠标左键事件
		if ($(showId).value == "") {
			$(id).value = "";
			return;
		}else{
			$(id).value = refrenceCode.substring(0,(refrenceCode.length-$(showId).value.length))+$(showId).value;
		}
		event.keyCode=9;
	}
}

 
/**
 * 功能描述：对指定表的指定行的单元格填充数据
 * 参数描述：tableObj -- 指定的表对象 
 *					  rowObj -- 指定的行对象;
 *					  cells -- 要填充到行内单元格的对象数据集;
 */    
function insertCell(tableObj,rowObj,cells){
	rowObj.className="listCss";
	var irow=tableObj.rows;
	var icell=tableObj.rows[0].cells;
	for(i=0;i<icell.length;i++){
		rowObj.insertCell(0);
	}
	for(var i=0;i<icell.length;i++){
		if(i<2){
			rowObj.cells[i].style.textAlign="center";
		}
		i==1?rowObj.cells[i].innerHTML=rowObj.rowIndex : rowObj.cells[i].innerHTML=changeName(cells[i],rowObj.rowIndex);
	}
}

/**
 * 功能描述：填充指定表的tbody内容
 * 参数描述：tableId -- 指定的表对象id 
 *					  cellObjects -- 要填充到行内单元格的对象数据集;
 *					  num -- 要填充的行数;
 */  
function insertEndRow(tableId,cellObjects){
	var tbodyObj = DWRUtil.byId(tableId);
	var rowObj1= tbodyObj.insertRow(tbodyObj.rows.length);
	insertCell(tbodyObj,rowObj1,cellObjects);
}

/**
 * 功能描述：重新填充指定表的tbody内容
 * 参数描述：tableId -- 指定的表对象id 
 *					  cellObjects -- 要填充到行内单元格的对象数据集;
 *					  num -- 要填充的行数;
 */  
function insertRow(tableId,cellObjects,num){
	var table =document.all[tableId];
	var childElements = table.getElementsByTagName("table");
	var tableObj = childElements[1];
	var tbodyObj = tableObj.getElementsByTagName("tbody");
	for(i=tbodyObj[0].rows.length-1;i>0;i--){
		tbodyObj[0].deleteRow(i);
	}
	for(j=1;j<=num;j++){
		var rowObj1= tbodyObj[0].insertRow(j);
		insertCell(tbodyObj[0],rowObj1,cellObjects);
	}
}

/**
 * 功能描述：校验是否全由数字组成
 * 参数描述：s -- 要校验的字符串， 
 *					  
 */
function isDigit(s)  
{  
	var patrn=/^[0-9]{1,20}$/;  
	if (!patrn.exec(s)) return false  
	return true  
}  
/**
 * 功能描述：更新表数据时延时等待图片显示
 * 参数描述：tbodyid -- 表tbody的id， 
 *					  
 */
function loadDelay(path,tbodyid){
	//var tbodyid = "tableBody";
	DWRUtil.removeAllRows(tbodyid);
	var thead = DWRUtil.byId(tbodyid).parentNode.getElementsByTagName("thead")[0];
	var span = thead.rows[0].cells.length
	var rowObj= DWRUtil.byId(tbodyid).insertRow(0);
	var cell = rowObj.insertCell(0);
	cell.colSpan = span;
	cell.align = "center";
	cell.bgColor = "#FFFFFF";
	cell.innerHTML = '<img src="'+path+'/images/dd/Loading.gif">'+i18n_dd.loading;
}

/**
 * 功能描述：重置选择框
 * 参数描述：
 */    
function resetCheckbox(checkName){  
	var checkboxall = document.getElementsByName(checkName);
	for(var i=0;i<checkboxall.length;i++){
		if(checkboxall[i].checked==true){
			checkboxall[i].checked = false;
		}
	}
}

/**
 * 功能描述：在行上点击鼠标，把行内的数据填充到页内对应form控件内容
 * 参数描述：
 */
function rowToForm(trObj){
	if(trObj.childNodes.length == 0) {
		return null;
	} else{
		var formElementsArray = defineFormElements();
		for(var i=0,j=0; i<trObj.childNodes.length&&j<formElementsArray.length; i++,j++) {
		//alert("formElementsArray["+j+"] = "+formElementsArray[j]);
		//var thisObj = $(formElementsArray[j]);
			if(i==0){
				var elementCheckbox = document.getElementsByName("checkbox_template");
				//thisObj.value = elementCheckbox[parseInt(trObj.childNodes[1].innerText)].value;
			}
			if(i==1){
				j--;
				continue;
			}
			var thisChild = trObj.childNodes[i];
			//alert(" thisChild = "+ thisChild.tagName+" thisChild.innerHTML = "+thisChild.innerHTML+" thisChild.innerText = "+thisChild.innerText+" formElementsArray[i] = "+formElementsArray[j]);
			/*
			if(thisObj.tagName.toLowerCase() == "select"){ 
				//alert("select length "+thisObj.options.length);
				for(var k=0; k<thisObj.options.length;k++){
				//alert(thisObj.options[k].text+" "+thisChild.innerHTML);
					if(thisObj.options[k].text=thisChild.innerHTML){
						thisObj.options[k].selected = true;
					}
				}
			}else{
				thisObj.value = thisChild.innerText;
				setRefrenceId(thisObj,thisChild);
			}
			*/
			/*
			if(thisChild.type == "checkbox" || thisChild.type == "radio") {
				return thisChild;
			} else {
				var tempResult = getCheckboxFromTr(thisChild);
				if(tempResult != null) {
					return tempResult;
				}
			}
			*/
			
		}
	}
}

/**
 * 功能描述：填充输入控件值(一般作为被掉函数用在回调函数内)
 * 参数描述：data -- 要填入输入控件的值(一般为主调含数的返回值) 
 *					  inputId -- 要填入的控件的id;
 */  
function setInput(data,inputId) {
	 if (data != null && typeof data == 'object') {
	 	alert(dwr.util.toDescriptiveString(data, 2));
	 } else {
	 	dwr.util.setValue(inputId, data, { escapeHtml:false });
	 }
}

/**
 * 功能描述：向应用服务器发送信息，由应用服务器更新所有连接页面信息
 * 参数描述：inputId -- 显示服务器端信息的输入控件id 
 */
function sendMessage(inputId,ulId) {
	AjaxControl.addMessage(dwr.util.getValue(inputId),ulId);
	$(inputId).value="";
}

/**
 * 功能描述：设置参照隐藏值，供动态编辑时选择参照后设置隐藏值使用
 * 参数描述：obj -- 参照窗口的返回值 
 *					  imageObj -- 参照中图片按钮对象;
 */ 
function setRefrenceTd(obj, imageObj){
	 if(obj) {
		var divObj = imageObj.parentElement;
		var tdObj = divObj.parentElement;
		var hiddenElement = tdObj.childNodes[1];
		hiddenElement.value = obj[0];
		tdObj.innerHTML = obj[1]+hiddenElement.outerHTML;
		divObj.innerHTML = "";
		divObj.style.display = "none";
	}
 }
 
/**
 * 功能描述：动态生成下拉菜单的内容
 * 参数描述：selectId --下拉框id;
 *					  data -- 填充下拉框的对象数组
 *					  key -- 填充时作为option value的对象属性
 *					  value -- 填充时作为option展示的对象属性
 */
function setSelectForBean(selectId,data,key,value){
	DWRUtil.removeAllOptions(selectId); //移除id为company_name的select的内容
	DWRUtil.addOptions(selectId,{"":i18n_dd.select});
	DWRUtil.addOptions(selectId,data,key,value);
}

/**
 * 功能描述：动态生成下拉菜单的内容
 * 参数描述：selectId --下拉框id;
 *					  data -- 填充下拉框的对象数组
 */
function setSelectForString(selectId,data){
	DWRUtil.removeAllOptions(selectId); //移除id为company_name的select的内容
	DWRUtil.addOptions(selectId,{000:i18n_dd.select});
	DWRUtil.addOptions(selectId,data);
}