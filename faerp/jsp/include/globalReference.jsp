<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base target="_self"> 
<title>选择参照</title>
</head>
<body class="referencePage">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr height="90%">
    <td>
		<iframe name="referenceContent" width="100%" height="100%">
		
		</iframe>
	</td>
  </tr>
  <tr height="10%">
    <td align="center">
	    <input type="button" class="button_ellipse" name="button_ok" value="确定" onClick="ok_onClick();">&nbsp;&nbsp;&nbsp;&nbsp;
	    <input type="button" class="button_ellipse" name="button_cancel" value="取消" onClick="cancel_onClick();">
    </td>
  </tr>
</table>
</body>
</html>
<script language="javascript">
	function ok_onClick(){  //确定
    	var rtObject = null;
		var thisInputObj = referenceContent.document.getElementsByName('checkbox_template');
		try {
			rtObject = document.frames['referenceContent'].toDoReadReference(thisInputObj);
		} catch(e) {
			rtObject = toDoReadReference(thisInputObj);
		}
		if(rtObject) {
	 	 	window.returnValue = rtObject;
			window.close();		
		}
  	}

	function toDoReadReference(thisInputObj) {
		var ids = findSelections(thisInputObj,"id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("请选择一条记录!")
	  		return false;
		}
		var rtObject = new Object();
		rtObject.realValue = ids + "";
		try {
			var aDisplayName = new Array();
			for(var i=0; i<ids.length; i++) {
				for(var j=0;j<thisInputObj.length;j++){  //循环checkbox组
					if(thisInputObj[j].value == ids[i]) {
						aDisplayName.push(thisInputObj[j].displayName);
						break;
					}
				}
			}
			rtObject.displayName = aDisplayName + "";
		} catch(e) {
			rtObject.displayName = ids;
		}
		return rtObject;
	}

	function cancel_onClick(){  //取消
		window.close();
	}
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = checkboxName;  //通过name取出所有的checkbox
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
	var myObject = window.dialogArguments;
	document.all['referenceContent'].src = myObject.urlPath;
</script>