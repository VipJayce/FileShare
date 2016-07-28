
/*
 * 调用函数：获取组织参照树<br/>
 * 使用：1) 在页面头部引入该js; <br/>
 *             2) 对应的调用示例：<input name="sendTo" type="text" class="text_field" inputName="收件人"  validate="notNull"><input type="hidden" name="hiddenSendto"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" id="object_reference" onClick="organizationRefrenceTree(document.all('hiddenSendto'),document.all('sendTo'))"/>
 */
function organizationRefrenceTree(inputHiden, inputShow){
      getOrganizationTree(new Array(inputHiden,inputShow),
    "<%=request.getContextPath()%>/",
    "<%=request.getContextPath()%>/jsp/reference/deeptree.jsp"
        +"?inputType=radio"
        +"&enableCookie=true"
        +"&submitType=submitAll"
        +"&nodeRelationType=noRelation"
        +"&rootXmlSource=<%=request.getContextPath()%>/jsp/reference/orgModel4Ref.jsp");
}

function getOrganizationTree(inputArray,path,deeptreePath,width,height){
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
    toDoWriteOrganizationTree(inputArray, rtObj);
}

function toDoWriteOrganizationTree(inputArray,rtObj){
    var textValue = inputArray[0];
    var textName = inputArray[1];
    if(rtObj != undefined && rtObj.length > 0){
        var allTextValue = "";
        var allTextName = "";
        for(var i=0; i<rtObj.length -1; i++) {
            allTextValue += rtObj[i]['returnValue'] + ";";
            allTextName += rtObj[i]['childName'] + ",";
        }
        allTextValue += rtObj[rtObj.length-1]['returnValue'];
        allTextName += rtObj[rtObj.length-1]['childName'];
        textValue.value = allTextValue;
        textName.value = allTextName;
    } else {
        return;
    }
}