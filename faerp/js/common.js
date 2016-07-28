//表格颜色样式
		function add_event(tr){
			tr.onmouseover = function(){
				tr.className += ' hover';
			};
			tr.onmouseout = function(){
				tr.className = tr.className.replace(' hover', '');
			};
		}
		function stripe(table) {
			var trs = table.getElementsByTagName("tr");
			for(var i=1; i<trs.length; i++){
				var tr = trs[i];
				tr.className = i%2 != 0? 'odd' : 'even';
				add_event(tr);
			}
		}

//tab切换
	function setTab03Syn ( i )
	{
		selectTab03Syn(i);
	}
	
	function selectTab03Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font2").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#ffffff";
			break;
		}
	}
//tab切换
	function setTab09Syn ( i )
	{
		selectTab09Syn(i);
	}
	
	function selectTab09Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("fonta").style.color="#ffffff";
			document.getElementById("fontb").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("fonta").style.color="#000000";
			document.getElementById("fontb").style.color="#ffffff";
			break;
		}
	}
//tab切换
	function setTab01Syn ( i )
	{
		selectTab01Syn(i);
	}	
	function selectTab01Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#ffffff";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#ffffff";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#000000";
			break;
			case 4:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#ffffff";
			document.getElementById("font5").style.color="#000000";
			break;
			case 5:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#ffffff";
			break;
		}
	}
//薪资支付
function setTab02Syn ( i )
	{
		selectTab02Syn(i);
	}
	function selectTab02Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#ffffff";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#ffffff";
			document.getElementById("font4").style.color="#000000"
			break;
			case 4:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#ffffff";
			break;
		}
	}
//党组织关系切换
	function setTabSyn ( i )
	{
		selectTabSyn(i);
	}	
	function selectTabSyn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			//document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#075587";
			document.getElementById("font2").style.color="#000000";
			//document.getElementById("font3").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			//document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#075587";
			//document.getElementById("font3").style.color="#000000";
			break;
			//case 3:
			//document.getElementById("TabCon1").style.display="none";
			//document.getElementById("TabCon2").style.display="none";
			//document.getElementById("TabCon3").style.display="block";
			//document.getElementById("font1").style.color="#000000";
			//document.getElementById("font2").style.color="#000000";
			//document.getElementById("font3").style.color="#075587";
			//break;
		}
	}
//党组织关系切换
//公积金账号管理
	function setTab001Syn ( i )
	{
		selectTab001Syn(i);
	}
	function selectTab001Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#FFFFFF";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#FFFFFF";
            document.getElementById("font3").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#FFFFFF";
			break;
		}
	}
//公积金账号管理切换



//所有列表记录全选和反选
function CheckAll(value,obj)  {
	var form=document.getElementsByTagName("form")
 	for(var i=0;i<form.length;i++){
		for (var j=0;j<form[i].elements.length;j++){
			if(form[i].elements[j].name!="checkbox"){ 
			var e = form[i].elements[j]; 
			e.checked=!e.checked;
			//if (value=="selectAll"){e.checked=obj.checked}     
			//else{e.checked=!e.checked;} 
			   }
		}
 	}
}

//所有删除判断只能选择一条数据
function DelSite(){
	var num=0;
	var form=document.getElementsByTagName("form")
 	for(var i=0;i<form.length;i++){
		for (var j=0;j<form[i].elements.length;j++){
			if(form[i].elements[j].type=="checkbox"){ 
			var e = form[i].elements[j]; 
			if (e.checked)num++;    
			}
		}
 	}
	if(num==0){
		alert("\u8bf7\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else if(num>1){
		alert("\u53ea\u80fd\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else{
		if (window.confirm("\u60a8\u786e\u5b9a\u8981\u5220\u9664\u6240\u9009\u62e9\u7684\u8bb0\u5f55\u5417\uff1f")){
			return;
		}
	}
	return;
}

//所有查看和更新判断只能选择一条数据
function ReadAndUpdate(url){
	var num=0;
	var form=document.getElementsByTagName("form")
 	for(var i=0;i<form.length;i++){
		for (var j=0;j<form[i].elements.length;j++){
			if(form[i].elements[j].type=="checkbox"){ 
			var e = form[i].elements[j]; 
			if (e.checked)num++;    
			}
		}
 	}
	if(num==0){
		alert("\u8bf7\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else if(num>1){
		alert("\u53ea\u80fd\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else{
		document.location.href=url;
	}
	return;
}
//查看报价单
function viewQuotation(param){
	var url = dir_base + '/jsp/faerp/common/sales/allQuotation.jsp?' + param + "&date=" + new Date();
    var ids = window.showModalDialog(url,'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    //alert(ids);
    return ids;
}

    //填写审批意见
function addAppReason(basePath){
        var reasonPath = basePath+"/jsp/faerp/common/wfReason/wfAppReason.jsp?date=" + new Date();
        var message =window.showModalDialog(reasonPath,'','dialogHeight:300px;dialogWidth:580px;center:yes;help:no;resizable:no;scroll:no;status:no;');      
       return message;
    
    }
    //填写驳回意见
function addBackReason(basePath){
        var reasonPath = basePath+"/jsp/faerp/common/wfReason/wfBackReason.jsp?date=" + new Date();
        var message =window.showModalDialog(reasonPath,'','dialogHeight:300px;dialogWidth:580px;center:yes;help:no;resizable:no;scroll:no;status:no;');      
       return message;
    
    }   
function choose_row_public(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }   
/**
 * @author: 马宏敏
 * @disc: 账单认领页面改为2个页签后的显示效果
 * 为什么再写一个2个页签效果，因为页面上还是有3个页签，但隐藏了一个，以备用户以后还需使用
 * 隐藏了中间一个页签
 * @param {} i
 */
function setTabSyn_fin(i) {
	selectTabSyn_fin(i);
}
function selectTabSyn_fin(i) {
	switch (i) {
		case 1 :
			document.getElementById("TabCon1").style.display = "block";
			document.getElementById("TabCon3").style.display = "none";
			document.getElementById("font1").style.color = "#075587";
			document.getElementById("font3").style.color = "#000000";
			break;
		case 3 :
			document.getElementById("TabCon1").style.display = "none";
			document.getElementById("TabCon3").style.display = "block";
			document.getElementById("font1").style.color = "#000000";
			document.getElementById("font3").style.color = "#075587";
			break;
	}
}
//认领页面的明细认领页签
function setTabSyn_fin_detail(i) {
    selectTabSyn_fin_detail(i);
}
function selectTabSyn_fin_detail(i) {
    switch (i) {
        case 5 :
            document.getElementById("TabCon5").style.display = "block";
            document.getElementById("TabCon6").style.display = "none";
            document.getElementById("font5").style.color = "#075587";
            document.getElementById("font6").style.color = "#000000";
            break;
        case 6 :
            document.getElementById("TabCon5").style.display = "none";
            document.getElementById("TabCon6").style.display = "block";
            document.getElementById("font5").style.color = "#000000";
            document.getElementById("font6").style.color = "#075587";
            break;
    }
}
/**
 * 异步调用 公共方法
 * @param {} form
 * @param {} funcSuccess
 * @param {} funcFailed
 */
function ajaxRequest(form, funcSuccess, funcFailed, asyncVal) {
	if(asyncVal!=true && asyncVal != false){
		asyncVal = true;
	}
    jQuery.ajax({
        type:form.method,
        url: form.action,
        async: asyncVal,
        data:jQuery(form).serialize(),
        success:function(data, textStatus) {
            var dataObj;
            try {
                dataObj = eval('(' + data + ')');
                if (dataObj) {
                    funcSuccess(dataObj);
                }
            } catch(error) {
            }
        },
        error:function(XMLHttpRequest, XMLHttpRequest, errorThrown) {
            funcFailed();
        }
    });
}
function containCH(v){
	return /[\u4E00-\u9FA5]/g.test(v);
}
 
function f_check_code(obj){
    var str = obj.value; 
  if(containCH(str)){
    	alert(obj,"代码 只能由英文字母和数字和下划线组成！");
    	return false;  } 
    	return true;}
