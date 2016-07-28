
	var idxInput = new Array();  //需要监听的input数组列表
	function initMyKeyDown() {  //初始化键盘监听
		try {
			var enabledInput = new Array('text','button','select-one','textarea');  //定义需要监听的input类型
			for(var i=0; i<document.all.length; i++) {  //循环document的所有对象
				var thisObj = document.all[i];  //定义当前处理对象的临时变量
				if(arrayHasString(enabledInput,thisObj.type)) {  //如果thisObj的type在enabledInput的数组中
					idxInput[idxInput.length] = thisObj;  //把thisObj加入需要监听input数组列表
				}
			}
			for(var j=0; j<idxInput.length; j++) {  //循环需要监听的input数组列表
				if(idxInput[j] != null && (idxInput[j].type == "text" || idxInput[j].type == "textarea") && !idxInput[j].readOnly) {  //如果是text或textarea
					try {
						idxInput[j].focus();  //聚焦第1个input对象
					} catch(e) {
					}
					break;  //完成聚焦, 跳出循环
				}
			}
		} catch(e) {
			//alert(e.message);
		}
	}
	document.onkeydown = function() {  //处理回车事件
		if(event.keyCode!=13) {  //如果不是enter键
			event.cancelBubble = false;  //继续冒泡
			return true;  //继续处理键盘事件
		}
		if(event.srcElement.type == "textarea" && !event.ctrlKey) {  //如果是textarea,不是ctrl+enter,也返回
			event.cancelBubble = false; 
			return true; 
		}
		var toFocus = 0;  //定义游标
		for(var i=0; i<idxInput.length; i++) {  //循环需要监听的input数组列表
			if(idxInput[i]== event.srcElement) {  //如果事件来源在需要监听的input数组列表中
				if(i == (idxInput.length -1)) {  //如果到了最后一个监听input对象
					toFocus = 0;  //游标归0
				} else {
					toFocus = i +1 ;  //游标加1
				}
				break;  //完成处理,退出循环
			}
		}
		var focusObj = idxInput[toFocus];  //定义聚焦的对象
		if(focusObj != undefined && focusObj.focus != undefined) {  //如果可以聚焦
			try {
				focusObj.focus();  //聚焦对象
			} catch(e) {
				if(focusObj.type == "button") {  //如果是按钮
					focusObj.click();
				}
			}
		}
	}
	
	window.attachEvent("onload", initMyKeyDown);
