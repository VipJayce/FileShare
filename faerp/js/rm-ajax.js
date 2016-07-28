
	var rmRequest_synchronized;
	var rmXpath_synchronized;
	var rmReturnXml_synchronized;
	
	function retrieveUrl_synchronized(url) {
		try {
		    if (url != null && url != "") {
		      if (window.XMLHttpRequest) { // Non-IE browsers
		        rmRequest_synchronized = new XMLHttpRequest();
		        rmRequest_synchronized.onreadystatechange = processStateChange_synchronized;
		        try {
		          rmRequest_synchronized.open("get", url, false);
		        } catch (e) {
		          alert(e);
		        }
		        rmRequest_synchronized.send(null);
		      } else if (window.ActiveXObject) { // IE
		        rmRequest_synchronized = new ActiveXObject("Microsoft.XMLHTTP");
		        if (rmRequest_synchronized) {
		          rmRequest_synchronized.onreadystatechange = processStateChange_synchronized;
		          rmRequest_synchronized.open("get", url, false);
		          rmRequest_synchronized.send();
		        }
		      }
		    }
		} catch(e) {
			alert(e.message);	
		}
		return rmReturnXml_synchronized;
	}

  function processStateChange_synchronized() {
    if (rmRequest_synchronized.readyState == 4) { 
      if (rmRequest_synchronized.status == 200) {
        rmXml = rmRequest_synchronized.responseXML;
        if(rmXpath_synchronized == null) {
        	rmReturnXml_synchronized = rmXml;
        } else {
			rmReturnXml_synchronized = rmXml.documentElement.selectNodes(rmXpath_synchronized);
        }
      } else {
        alert("Problem:" + rmRequest_synchronized.statusText);
      }
    }
  }
  
  	var rmXmlHttpRequest;
	
	var rmXmlHttpRequest_update;
  
	function retrieveUrl_asynchronous(url, processFunction_callback, submitType, parameters) {
		rmXmlHttpRequest = null;
		if(submitType == undefined || (submitType != "GET" && submitType != "POST")) {
			submitType = "GET";
		}
		try {
		    if (url != null && url != "") {
		      if (window.XMLHttpRequest) { // Non-IE browsers
		        rmXmlHttpRequest = new XMLHttpRequest();
		        rmXmlHttpRequest.onreadystatechange = processFunction_callback;
		        try {
		        	if(submitType == "GET") {
		        		if(url.indexOf("?") > 0) {
		        			url += "&" + parameters;
		        		} else {
		        			url += "?" + parameters;
		        		}
						rmXmlHttpRequest.open("GET", url, true);
		        		rmXmlHttpRequest.send(null);
		        	} else if(submitType == "POST") {
		        		rmXmlHttpRequest.open("POST", url, true);
		        		rmXmlHttpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded;");
		        		rmXmlHttpRequest.send(parameters);
		        	}
		        } catch (e) {
		          alert(e);
		        }
		      } else if (window.ActiveXObject) { // IE
		        rmXmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		        if (rmXmlHttpRequest) {
		          rmXmlHttpRequest.onreadystatechange = processFunction_callback;
		        	if(submitType == "GET") {
		        		if(url.indexOf("?") > 0) {
		        			url += "&" + parameters;
		        		} else {
		        			url += "?" + parameters;
		        		}
						rmXmlHttpRequest.open("GET", url, true);
		        		rmXmlHttpRequest.send(null);
		        	} else if(submitType == "POST") {
		        		rmXmlHttpRequest.open("POST", url, true);
		        		rmXmlHttpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded;");
		        		rmXmlHttpRequest.send(parameters);
		        	}
		        }
		      }
		    }
		} catch(e) {
			alert(e.message);	
		}
	}
	
	  function retrieveUrl_asynchronousUpdate(url, processFunction_callback, submitType, parameters) {
		rmXmlHttpRequest_update = null;
		if(submitType == undefined || (submitType != "GET" && submitType != "POST")) {
			submitType = "GET";
		}
		try {
		    if (url != null && url != "") {
		      if (window.XMLHttpRequest) { // Non-IE browsers
		        rmXmlHttpRequest_update = new XMLHttpRequest();
		        rmXmlHttpRequest_update.onreadystatechange = processFunction_callback;
		        try {
		        	if(submitType == "GET") {
		        		if(url.indexOf("?") > 0) {
		        			url += "&" + parameters;
		        		} else {
		        			url += "?" + parameters;
		        		}
						rmXmlHttpRequest_update.open("GET", url, true);
		        		rmXmlHttpRequest_update.send(null);
		        	} else if(submitType == "POST") {
		        		rmXmlHttpRequest_update.open("POST", url, true);
		        		rmXmlHttpRequest_update.setRequestHeader("Content-type", "application/x-www-form-urlencoded;");
		        		rmXmlHttpRequest_update.send(parameters);
		        	}
		        } catch (e) {
		          alert(e);
		        }
		      } else if (window.ActiveXObject) { // IE
		        rmXmlHttpRequest_update = new ActiveXObject("Microsoft.XMLHTTP");
		        if (rmXmlHttpRequest) {
		          rmXmlHttpRequest_update.onreadystatechange = processFunction_callback;
		        	if(submitType == "GET") {
		        		if(url.indexOf("?") > 0) {
		        			url += "&" + parameters;
		        		} else {
		        			url += "?" + parameters;
		        		}
						rmXmlHttpRequest_update.open("GET", url, true);
		        		rmXmlHttpRequest_update.send(null);
		        	} else if(submitType == "POST") {
		        		rmXmlHttpRequest_update.open("POST", url, true);
		        		rmXmlHttpRequest_update.setRequestHeader("Content-type", "application/x-www-form-urlencoded;");
		        		rmXmlHttpRequest_update.send(parameters);
		        	}
		        }
		      }
		    }
		} catch(e) {
			alert(e.message);	
		}
	}
	
	function transferFormValueToString(form) {
		var aValue = new Array();
		var mValue = new Object();
		for(var i=0; i<form.elements.length; i++) {
			var thisElement = form.elements[i]; 
			var tempName = thisElement.name;
			if(!arrayHasString(aValue, thisElement.name)) {
				aValue.push(tempName);
				mValue[tempName] = "";
			}
			if(thisElement.tagName.toUpperCase() == "TEXTAREA" || thisElement.tagName.toUpperCase() == "SELECT") {
				mValue[tempName] = thisElement.value;
			} else if(thisElement.tagName.toUpperCase() == "INPUT") {
				if(thisElement.type == "checkbox" || thisElement.type == "radio") {
					if(thisElement.check) {
						if(mValue[tempName] != "") {
							mValue[tempName] += ",";
						} 
						mValue[tempName] = thisElement.value;
					}
				} else {
					mValue[tempName] = thisElement.value;
				}
			}
		}
		var str = "";
		for(var i=0; i<aValue.length; i++) {
			if(str != "") {
				str += "&";
			}
			str += aValue[i] + "=" + escape(mValue[aValue[i]]);
		}
		return str;
		
	}
	
			//回写表单
 		function writeBackValueToForm(inputName, thisValueOrArray) {
 			//TODO 整合
			if(form.elements[inputName] == undefined) {
				return false;
			}
			if(form.elements[inputName].value != undefined) {  //如果有value属性，直接赋值
				form.elements[inputName].value = thisValueOrArray;			
			} 
			if(form.elements[inputName].length != undefined ) {  //没有value属性
				if(thisValueOrArray[0] == undefined) {
					thisValue = new Array();
					thisValue[thisValue.length] = thisValueOrArray;							
				}
				if(form.elements[inputName].length != null) {  //length不为空
					var tempLength = form.elements[inputName].length;
					for(var j=0; j<tempLength; j++) {
						var thisObj = form.elements[inputName][j];
						for(var k=0; k<thisValue.length; k++) {
							if(thisObj.value == thisValue[k]) {  //如有选中，继续循环
								if( thisObj.checked != undefined) {
									thisObj.checked = true;	
									break;									
								} else if( thisObj.selected != undefined) {
									thisObj.selected = true;								
									break;
								}
							} else {                             //如没有选中，察看下一个
								if( thisObj.checked != undefined) {
									thisObj.checked = false;	
								} else if( thisObj.selected != undefined) {
									thisObj.selected = false;								
								}	
							}
						}
					}
				} 	
							
			}
		}
  
  function getNodeText(node, xpath) {
  	if(node != null && node.selectSingleNode(xpath) != null) {
  		return node.selectSingleNode(xpath).text;
  	} else {
  		return null;
  	}
  }
  
    function ListDataHandler() {
		this.columnName = new Array();
		this.columnChineseName = new Array();
		this.columnPk = "id";
		this.actionPath = "";
		this.table = null;
		this.tableBody = null;

		this.initTable = function() {
			var thisTable = document.createElement("table");
			var cssStr = "width: 100%; border: 1px; text-align:center; background-color:#93B3CA";
			thisTable.setAttribute("style", cssStr);
			thisTable.style.cssText = cssStr;

			var thisTableHead = document.createElement("thead");
			thisTable.appendChild(thisTableHead);

			myNewRow = thisTableHead.insertRow();
			myNewRow.bgColor = "#B8D5F5";

			myNewRow.insertCell().innerHTML = "<input name=myCheckAll type=checkbox class=check value=checkbox onClick='javascript: rmListData.checkAll(this.checked)'>";
			myNewRow.insertCell().innerHTML = "序";
			for(var i=0; i<this.columnChineseName.length; i++) {
				myNewRow.insertCell().innerHTML = this.columnChineseName[i];
			}

			document.getElementById("td_listData").appendChild(thisTable);
			this.table = document.getElementById("td_listData").getElementsByTagName("table")[0];
			this.refreshData();
		}

		this.refreshData = function() {
			if(this.table.getElementsByTagName("tbody").length > 0) {
				this.table.removeChild(this.table.getElementsByTagName("tbody")[0]);
			}
			var thisTableBody = document.createElement("tbody");
			this.table.appendChild(thisTableBody);
			this.tableBody = thisTableBody;

			retrieveUrl_asynchronous(this.actionPath + "queryAll", function() {
				if(rmXmlHttpRequest.readyState == 4) {
					if(rmXmlHttpRequest.status == 200) {
						var xml = rmXmlHttpRequest.responseXML;
						var rmDatas = xml.selectNodes("/rmdatas/rmdata");
						for(var i=0; i<rmDatas.length; i++) {
							var thisTr = document.createElement("tr");
							thisTr.bgColor = "#FFFFFF";
							rmListData.tableBody.appendChild(thisTr);
							
							var td1 = document.createElement("td");
							td1.innerHTML = "<input name=idcheckbox type=checkbox>";
							thisTr.appendChild(td1);

							var td2 = document.createElement("td");
							td2.innerHTML = (i+1) + "<input type=hidden name=hiddenObj value=" + getNodeText(xml, "/rmdatas/rmdata[" + i + "]/" + rmListData.columnPk + "/text()") + ">";
							thisTr.appendChild(td2);
	
							for(var j=0; j<rmListData.columnName.length; j++) {
								var tdTemp = document.createElement("td");
								var xpath = "/rmdatas/rmdata[" + i + "]/" + rmListData.columnName[j] + "/text()";
								var columnValue = getNodeText(xml, xpath);
								if(columnValue == null) {
									columnValue = "";
								}
								tdTemp.innerHTML = columnValue;
								thisTr.appendChild(tdTemp);
							}
						}
					}
				}
			});
		}

		this.checkAll = function (bSelected) {
			var elements = this.tableBody.getElementsByTagName("input");
			for(var i=0; i<elements.length; i++) {
				if(elements[i].type == "checkbox") {
					elements[i].checked = bSelected;
				}
			}
		}

		this.findSelections = function () {
			var hiddenObjs = this.tableBody.getElementsByTagName("input");
			var ids = null;  //定义id值的数组
			for(var i=0;i<hiddenObjs.length;i++){  //循环checkbox组
				if(hiddenObjs[i].type != "hidden") {
					continue;
				}
				var thisCheckbox = hiddenObjs[i].parentElement.parentElement.getElementsByTagName("input")[0];
				if(thisCheckbox.checked) {  //如果被选中
					if(ids == null) {
						ids = new Array(0);
					}
					ids.push(hiddenObjs[i].value);  //加入选中的checkbox
				}
			}
			return ids;
		}

		this.insertRecord = function () {  // 新增行
			retrieveUrl_asynchronousUpdate(this.actionPath + "insert", function() {
				rmListData.refreshData();
			}, "POST", transferFormValueToString(form));
		}

		this.findRecord = function (ids) {  // 新增行
			retrieveUrl_asynchronous(this.actionPath + "find", function() {
				if(rmXmlHttpRequest.readyState == 4) {
					if(rmXmlHttpRequest.status == 200) {
						var xml = rmXmlHttpRequest.responseXML;
						var rmData = xml.selectSingleNode("/rmdatas/rmdata");
						for(var j=0; j<rmData.childNodes.length; j++) {
							var thisNode = rmData.childNodes[j];
							writeBackValueToForm(thisNode.nodeName, thisNode.text);
						}
					}
				}
			}, "GET", "id=" + ids);
		}

		this.updateRecord = function () {  // 新增行
			retrieveUrl_asynchronousUpdate(this.actionPath + "update", function() {
				rmListData.refreshData();
			}, "POST", transferFormValueToString(form));
		}


		this.deleteRecord = function(ids) {  //删除文件
			retrieveUrl_asynchronousUpdate(this.actionPath + "deleteMulti", function() {
				rmListData.refreshData();
			}, "POST", "ids=" + ids);
		}

	}
  
