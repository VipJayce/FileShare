<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp" %>
<jsp:include page="include/globalDeepTree.jsp"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="organization_reference" bundle="${applicationResources}"/></title>

<script language="javascript">
    
    //定义全局路径
    var treeImagePath = "images";//树图标路径
    //xslt文件相对路径
    var xslPath = "deeptree_xsl.jsp?inputType="+inputType+"&treeImagePath="+treeImagePath;
    //xmlSourceType为nodeCode时有效, 默认xml主路径, 转义影射：&-->%26, =-->%3D
    //var defaultXmlUrlPath = "deeptree_data.jsp?rootnode=";
    //xmlSourceType为nodeCode时有效, 默认取节点本身数据参数标识：&-->%26, =-->%3D
    var defaultNodeCodeGetCurrent = "&getcurrent=1";
    
    //根据需要可以重写的方法
    function toDoMouseClick(thisEvent) {
        return;
    }
    function toDoMouseDbClick(thisEvent) {
        //var thisHiddenValue = getHiddenValueByEvent(thisEvent.srcElement.id);
        //alert(thisHiddenValue.huqi);
        //alert("事件对象的id是" + thisEvent.srcElement.id + "\n隐藏值的代码是\n" + thisHiddenValue.outerHTML);
    }
    function toDoMouseOver(thisEvent) {
        return;
    }
    function toDoMouseOut(thisEvent) {
        return;
    }
    
/********************** 开始表单提交相关方法 **********************/
function returnValueName() {  //获得所有选择的checkbox

    currentId = "";
    var checkedArray = new Array(0);        
    var submitStringArray = new Array(0);
    var submitObjectArray = new Array(0);
            
    var obj = null;
    if(inputType == "checkbox") {
        obj = window.document.getElementsByName(prefixCheckbox);
        for(i=0;i<obj.length;i++){
            if(obj[i].checked){
                checkedArray.push(obj[i].id.substring(prefixCheckbox.length));
            }
        }
        if(submitType == "parentPriority") {
            submitStringArray = clearChild(checkedArray);  //全面扫描checkedArray,把其中冗余的字节点信息去掉,Id列表放入submitStringArray
        } else {
            submitStringArray = filterHidden(checkedArray);
        }
    } else if(inputType == "radio") {
        obj = window.document.getElementsByName(prefixRadio);
        for(i=0;i<obj.length;i++){
            if(obj[i].checked){
                checkedArray.push(obj[i].id.substring(prefixRadio.length));
            }
        }
        submitStringArray = checkedArray;
    }
    for(var i=0; i<submitStringArray.length; i++) {  //把要提交的checkbox属性填满放入submitObjectArray
        var tempObj = new Object();
        var thisObj = jQuery(getObjectById(prefixDiv + submitStringArray[i]));
        var parentObj = getParentObject(thisObj.get(0));

        tempObj["childName"] = thisObj.attr("text");
        tempObj["childId"] = thisObj.attr("returnValue");
        if(submitStringArray.length > 1) {
            tempObj["returnValue"] = thisObj.attr("returnValue") +"/" + thisObj.attr("thisType");
        }else {
            tempObj["returnValue"] = thisObj.attr("returnValue");
        }
        tempObj["thisType"] = thisObj.attr("thisType");

        tempObj["parentName"] = parentObj["parentName"];
        tempObj["parentId"] = parentObj["parentId"];
        submitObjectArray[submitObjectArray.length] = tempObj;
    }
    
    if(submitObjectArray.length == 0) {
        alert(i18n.please_select_a_record);
        return false;
    }
    
    window.returnValue = submitObjectArray;
    
    if(outputType == "doubleClick") {
        window.close();
    } else {
        window.close();
    }
}
/**********************　结束表单提交相关方法 **********************/
    
</script>
<script type="text/javascript" src="deeptree.js">
</head>

<body>

<script language="javascript">
    writeTableTop('<fmt:message key="organization_reference" bundle="${applicationResources}"/>','<%=request.getContextPath()%>/');
</script>

<form name="form" method="post">
<table width="100%" class="table_div_content2">
  <tr> 
    <td valign="center">
        <input type="button" class="button_ellipse" value='<fmt:message key="confirm" bundle="${applicationResources}"/>' onClick="javascript:returnValueName();">
        <input type="button" class="button_ellipse" value='<fmt:message key="close" bundle="${applicationResources}"/>' onClick="window.close();">
    </td>
  </tr>
  <tr> 
     <td width="*" valign="top" align="left"> 
        <!--树开始-->
        <div name="deeptree" id="deeptree" class="deeptree"></div>
        <!--树结束-->
    </td>
  </tr>
</table>
</form>

<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');
</script>

</body>
</html>