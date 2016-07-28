
//构造javascript视图对象
function getView() {
	var view = {sessionId:"", state:"", serial:"", id:"", code:"", name:"", viewType:"", condition:"", tables:null, fields:null};
	return view;
}
//构造javascript视图辅助表对象
function getTable() {
	var table = {id:"", viewId:"", viewCode:"", tableId:"",tableName:""};
	return table;
}
//构造javascript显示字段对象
function getField() {
	var field = {id:"", name:"", displayName:"", viewId:"", viewCode:"", status:"1", description:"", displayType:1, refModel:"", refSource:"",refSourceClass:"", condition:"", callBack:"", tableName:"", columnName:"", columnSql:"", readOnly:"0", display:"1",sort:"0", seqNo:0, sortNo:0,width:"",align:""};
	return field;
}
function getFieldForTableView() {
	var field = {id:"", name:"", displayName:"", viewId:"", viewCode:"", status:"1", description:"", displayType:0, refModel:"", refSource:"",refSourceClass:"", condition:"", callBack:"", tableName:"", columnName:"", columnSql:"", readOnly:"0", display:"1",sort:"0", seqNo:0, sortNo:0,width:"",align:""};
	return field;
}

/**
	 *
	 *   数据字典动态参照专用
	 */
function getDataRefrence(textRefrence, path, str) {
	var returnAry;
	if (path == undefined) {
		path = "../../";
	}
	var returnAry = window.showModalDialog(path, [str, "\u7ec4\u7ec7\u6811"], "status:1;dialogHeight:450px;dialogWidth:300px;dialogTop: " + event.screenY + "px; dialogLeft: " + event.screenX + "px");
	if (typeof (returnAry) == "undefined") {
		document.getElementsByName(textRefrence)[0].value = "";
	} else {
		if (returnAry != null) {
			document.getElementsByName("refrence_" + textRefrence)[0].value = returnAry[1];
			document.getElementsByName(textRefrence)[0].value = returnAry[0];
			focus();
		}
	}
}	
//覆盖gap-validator.js中的同名方法，解决下拉列表框设置select报错的问题	
function setVenusInputError(_frm) {
	try {
		//_frm.click();  // click会导致文件上传错误
		_frm.focus();
		if (_frm.select) {
			_frm.select();
		}
		_frm.style.borderStyle = "dashed";
		_frm.style.borderColor = "rgb(255,50,0)";
		if (_frm.value != null && _frm.value.length > 0) {
			_frm.style.backgroundColor = "highlight";
			_frm.style.color = "white";
		}
	}
	catch (e) {
		alert(e.message);
	}
}
	
