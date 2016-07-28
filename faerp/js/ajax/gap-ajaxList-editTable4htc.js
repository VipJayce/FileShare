jQuery(function(){

   getTbodyColor4ajax();
   jQuery("table.editlistCss").live("mouseover",layoutDoMouseOver).live("mouseout",layoutDoMouseOut).live("click",layoutDoClick);
       
   jQuery("td.editlistCss").live("dblclick",layoutOfEditlistCss);
   jQuery("td.editSelectCss").live("dblclick",layoutOfEditSelectCss);
   jQuery("td.editDateCss").live("dblclick",layoutOfEditDateCss);
   jQuery("td.editRefrenceCss").live("dblclick",layoutOfEditRefrenceCss);
});


//设置表体颜色（奇数和偶数行）
function getTbodyColor4ajax(element,selector) {
    var tables;
    if(element&&jQuery(element).size>0)
            tables= jQuery("table.editlistCss,"+selector,jQuery(element)).find("td > table")
    else
            tables= jQuery("table.editlistCss,"+selector).find("td > table")
   
    initTableColor4ajax(tables);
}
function initTableColor4ajax(tables){
     tables.each(function(){
        var trs = jQuery(this).children().children().filter(function(i){return i!=0});
        
        trs.each(function(i){
                if (i%2 == 1) {
                    jQuery(this).css("background-color",layoutConfig.evenColor);
                } else {
                    jQuery(this).css("background-color",layoutConfig.oddColor);
                }//选中后保留颜色
                var thisCheckbox = getCheckboxFromTr(this);
                if(thisCheckbox&&thisCheckbox.checked) {
                   jQuery(this).css("background-color",layoutConfig.selectedColor);
                }
        });
    })
}


function layoutDoMouseOver(event) {  //处理鼠标进入事件
    
   var thisObj = getEventObj(event);
   var onPush = jQuery(this).attr("onPush");
    if (thisObj.tagName.toLowerCase()=="td"&&jQuery(thisObj).attr("class")!=null){
        thisObj.style.cursor = "pointer";
        var thisTr = jQuery(thisObj).parent();
        if(thisTr.attr("tagName").toLowerCase() != "tr") {
            thisTr = thisTr.parent();
        }
         if(!thisTr.attr("isClick"))thisTr.attr("oldColor",thisTr.css("background-color")).css("background-color",layoutConfig.focusColor);
    } else {
        if(jQuery(onPush)) eval(onPush);
    }
}

function layoutDoMouseOut(event) {  //处理鼠标离开事件
   var thisObj = getEventObj(event);
    if (thisObj.tagName.toLowerCase() == "td") {
       // getTbodyColor();
       var tr = jQuery(thisObj).parent();
        if(!tr.attr("isClick")){
            tr.css("background-color",tr.attr("oldColor"));
        }else{
            tr.removeAttr("isClick");
        }
    } else {
    
    }
}

function layoutDoClick(event) {  //处理鼠标单击事件
    var thisObj = getEventObj(event);
    var thisTag = undefined;
    if (thisObj.tagName.toLowerCase() != "input" && thisObj.tagName.toLowerCase() != "img") {
        if (thisObj.firstChild != null && thisObj.firstChild != "") {
            thisTag = thisObj.firstChild.tagName;
        }
    }
   //表头复选框多选
    if(thisObj.tagName.toLowerCase() == "input" && jQuery(thisObj).attr("type") == "checkbox" && jQuery(thisObj).attr("pdType") == "control") {
        var tempControl = jQuery(thisObj).attr("control");
        var aCheckbox = getObjectByName(tempControl);
        if ( !aCheckbox || aCheckbox.size == 0 )
             aCheckbox = getObjectById(tempControl);
        if(aCheckbox == null) {
        
        } else if(aCheckbox.length == null) {
            aCheckbox.checked = thisObj.checked;
        } else {
            for(var i=0; i<aCheckbox.length; i++) {
                aCheckbox[i].checked = thisObj.checked;
            }
        }
    } else if(thisObj.tagName.toLowerCase() == "td" && (thisTag == undefined || thisTag != undefined && thisTag.toLowerCase() != "table")) {
        var thisTr = jQuery(thisObj).parent();
        thisTr.attr("isClick",true).css("background-color",layoutConfig.selectedColor);
        var thisCheckbox = getCheckboxFromTr(thisTr[0]);
        if(thisCheckbox != undefined && thisCheckbox != null) {
            thisCheckbox.checked = !thisCheckbox.checked;
        }
    } else {
    
    }
    var tables = jQuery(thisObj).parents("table").get(0);
    initTableColor(jQuery(tables));
    event.stopPropagation();
}

function getEventObj(thisEvent) {
   if(thisEvent == undefined || thisEvent == null ) {
        alert("当前的对象为空!");
        return null;
    } else if(thisEvent.srcElement){
        return thisEvent.srcElement;
    }else{
        return thisEvent.target;
    }
}

function layoutOfEditlistCss(event){//文本输入框样式
    var thisObj = getEventObj(event);
    if (jQuery(thisObj).attr("class") != 'editlistCss') return;
    var editObj;
    editObj =  document.createElement("INPUT"); 
    editObj.type='text';
    editObj.value=thisObj.innerHTML;
    
    editObj.style.height = (thisObj.offsetHeight-(4)) + "px"; 
    editObj.style.width = thisObj.offsetWidth; 
    editObj.className = "text_field"; 
    editObj.wrap = "soft"; 
    editObj.style.textAlign = thisObj.align; 
    
    editObj.onblur = function(e)
    {
            thisObj.innerHTML = editObj.value;
    }
    
    thisObj.innerHTML = ""; 
    thisObj.appendChild(editObj); 
    jQuery(editObj).focus();
    
}

function layoutOfEditSelectCss(event){//下拉选择框的样式
    var thisObj = getEventObj(event);
    if (jQuery(thisObj).attr("class") != 'editSelectCss') return;
    var editObj;
    editObj = createSelect();
    editObj.style.height = (thisObj.offsetHeight-(4)) + "px"; 
    editObj.style.width = thisObj.offsetWidth; 
    editObj.wrap = "soft"; 
    editObj.style.textAlign = thisObj.align; 
    
    var inputElement = thisObj.getElementsByTagName('input')[0];
    editObj.onblur = function(e)
    {       
            inputElement.value =  editObj.value;
            thisObj.innerHTML = editObj.options[editObj.selectedIndex].text;
            thisObj.appendChild(inputElement);
    }
    thisObj.innerHTML = ""; 
    thisObj.appendChild(editObj); 
    jQuery(editObj).focus();
    
}

function layoutOfEditDateCss(event){//日期参照的样式
    var thisObj = getEventObj(event);
    if (jQuery(thisObj).attr("class") != 'editDateCss') return;
    var refrenceObj = getDateObj();
    editObj = createDateRefrence(thisObj,refrenceObj);
    editObj.style.height = (thisObj.offsetHeight-(4)) + "px"; 
    editObj.style.width = thisObj.offsetWidth; 
    editObj.className = "text_field_reference"; 
    editObj.wrap = "soft"; 
    editObj.style.textAlign = thisObj.align; 
       
    editObj.onblur = function(e)
    {   
        if(getLeft(thisObj)>event.clientX||(getLeft(thisObj)+thisObj.offsetWidth)<event.clientX||getTop(thisObj)>event.clientY||(getTop(thisObj)+thisObj.offsetHeight)<event.clientY){
            thisObj.innerHTML = editObj.value;
            editObj.value = "";
            editObj.style.display = "none";
        }
    }
    thisObj.innerHTML = ""; 
    thisObj.appendChild(editObj);   
    jQuery(editObj).focus();
    
}

function layoutOfEditRefrenceCss(event){//对象参照的样式
    var thisObj = getEventObj(event);
    if (jQuery(thisObj).attr("class") != 'editRefrenceCss') return;
    var refrenceObj = getRefrenceObj();
    editObj = createRefrence(thisObj,refrenceObj);
    editObj.style.height = (thisObj.offsetHeight-(4)) + "px"; 
    editObj.style.width = thisObj.offsetWidth; 
    editObj.className = "text_field_reference"; 
    editObj.wrap = "soft"; 
    editObj.style.textAlign = thisObj.align; 
       
    editObj.onblur = function(e)
    {
        if(getLeft(thisObj)>event.clientX||(getLeft(thisObj)+thisObj.offsetWidth)<event.clientX||getTop(thisObj)>event.clientY||(getTop(thisObj)+thisObj.offsetHeight)<event.clientY){
            thisObj.innerHTML = editObj.value;
            editObj.value = "";
            editObj.style.display = "none";
        }
    }
    thisObj.innerHTML = ""; 
    thisObj.appendChild(editObj);   
    jQuery(editObj).focus();
    
}