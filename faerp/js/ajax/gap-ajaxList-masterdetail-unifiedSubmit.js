 
 //------------复用主子表组件的时候需要手工修改 start-----------------------------------------------------------------------------
var pageobjMap={"masterView_list":"/jsp/ajaxList/masterdetailtable/unfiedSubmit/masterlist.jsp",
							"masterView_edit":"/jsp/ajaxList/masterdetailtable/unfiedSubmit/masteredit.jsp",
							"detail1View_list":"/jsp/ajaxList/masterdetailtable/unfiedSubmit/detail1list.jsp",
							"detail1View_edit":"/jsp/ajaxList/masterdetailtable/unfiedSubmit/detail1edit.jsp",
							"detail2View_list":"/jsp/ajaxList/masterdetailtable/unfiedSubmit/detail2list.jsp",
							"detail2View_edit":"/jsp/ajaxList/masterdetailtable/unfiedSubmit/detail2edit.jsp"}; 
function getPageobj(mdView){//返回要载入的页面地址
	return pageobjMap[mdView];
}							

//---------------构造主子表的vo对象 备注:每个vo的前三个字段(sessionid,state,serial)是继承于CacheVo对象，必须保留，其余字段按各自主子表的情况进行修改。start------------------------------------
/**
 * 功能描述：构造主表对象
 *					  
 */  
 function getMasterVo(){
	var factory= {
		sessionId:"",
		state:"",
		serial:"",
		factoryid:"",
		name:"", 
		beginDate:"",
		address:"",
		personname:"",
		telephone:"",
		description:""
		};
	return factory;
}

 
 function getDetail1Vo(){
	var product= {
		sessionId:"",
		state:"",
		serial:"",
		productid:"",
		categoryid:"", 
		name:"",
		price:"",
		beginDate:"",
		endDate:"",
		factoryid:"",
		factoryName:"",
		categoryname:""
		};
	return product;
}

 function getDetail2Vo(){
	var agent= {
		sessionId:"",
		state:"",
		serial:"",
		agentid:"",
		agentName:"", 
		factoryId:"",
		categoryId:"",
		productId:"",
		agentLevel:"",
		agentProductName:"",
		categoryname:""
		};
	return agent;
}

/**
 * 功能描述：根据参数查找vo对象
 *					  
 */  

function getMasterDetailVo(mdView){
    var masterDetailVo;
    if(mdView == "masterView"){
    	masterDetailVo = getMasterVo();
    }
    if(mdView == "detail1View"){
        masterDetailVo = getDetail1Vo();
    }
    if(mdView == "detail2View"){
    	masterDetailVo = getDetail2Vo();
    }
    return masterDetailVo;
}

 //--------------------构造主子表的vo对象   end--------------------------------------

  //--------------------构造主子表的列表对象,  start --------------------------------------
  
 function getMasterList(){
	var factorylist= {
		factoryid:"",
		name:"", 
		beginDate:"",
		address:"",
		personname:"",
		telephone:"",
		description:""
		};
	return factorylist;
}

function getDetail1List(){
	var productlist= {
		name:"",
		categoryname:"",		
		price:"",
		beginDate:"",
		endDate:""
		};
	return productlist;
}

function getDetail2List(){
	var agentlist= {
		agentName:"", 
		categoryname:"",
		agentProductName:"",
		agentLevel:""
		};
	return agentlist;
}
/**
 * 功能描述：根据回调返回的data对象，由使用者自己订制主子表列表要显示哪些列以及显示的顺序
 * 参数描述：mdView:主子表列表显示的类型id：masterView,detail1View,detail2View,detatil3View....必须按前面的命名规则填写
 *
 *  备注：开发人员需要修改这个函数以及下面每个子函数已达到自己的要求。
 */  
 
function getMdFields(mdView){
	if(mdView == "masterView"){
		return getMasterFields();
	} 
	if(mdView == "detail1View"){
		return getDetail1Fields();
	}
	if(mdView == "detail2View"){
		return getDetail2Fields();
	}
	
	//....如果超过2个子表,在此依次添加getDetatil3Fields,getDetatilFields.....方法
}

/**
 * 功能描述：根据返回的data对象，由使用者自己订制主子表列表要显示哪些列以及显示的顺序
 * 参数描述：mdView:主子表列表显示的类型id：masterView,detail1View,detail2View,detatil3View....必须按前面的命名规则填写
 *
 *  备注：开发人员需要修改这个函数以及下面每个子函数已达到自己的要求。
 */  
function getDetailsListView(mdView,data){
	var list;
	if(mdView == "detail1View"){
		list = getDetail1List();
	}
	if(mdView == "detail2View"){
		list = getDetail2List();
	}
	
		//....如果超过2个子表,在此依次添加getDetatil3List,getDetatil4List....方法
	
	var newlist = new Array();
	newlist[0] =  "<input type='checkbox' id='checkbox_"+mdView+"' name='checkbox_template' value='' />";
	newlist[1] = data.serial;
	var i = 2;
	for(prop in list){		
	    newlist[i] =  data[prop];
	    i++;
	}

	return newlist;
}

/**
* 功能描述：返回主表列表页面显示的对象集合。
*   				 data:是利用dwr请求服务器端函数，回调返回的结果，一般为map或者list
*/
function getMasterFields(){
    //获得公共的checkbox的输出代码
	var column0 = function(data){
		var checkObj = jQuery("<input type='checkbox' id='checkbox_master' name='checkbox_template' value='"+data.factoryid+"'/>").get(0);
		return checkObj;
	};
   var column1 = buildSerial;
   var column2 = function(data) { return data['name']};
   var column3=  function(data) { return data['personname']};
   var column4 = function(data) { return data['telephone']};
   var column5 = function(data) { return data['beginDate']};
   var column6 = function(data) { return data['address']};
  return [column0,column1,column2,column3,column4,column5,column6];
}

/**
* 功能描述：返回子表1列表页面要显示的对象集合。此处为product表的信息
*   				 data:是利用dwr请求服务器端函数，回调返回的结果，一般为map或者list
*/
function getDetail1Fields(){
    //获得公共的checkbox的输出代码
	var column0 = function(data){
        var checkObj = jQuery("<input type='checkbox' id='checkbox_detail1View' name='checkbox_template' value='"+data.productid+"'/>").get(0);
        return checkObj;
	};
  var column1 = function(data) { return DWRUtil.byId("detail1View").rows.length+1;}; 
  var column2 = function(data) { return data['name']};
  var column3 = function(data) { return data['categoryname']};
  var column4 = function(data) { return data['price']};
  var column5 = function(data) { return data['beginDate']};	
  var column6 = function(data) { return data['endDate']};
  return [column0,column1,column2,column3,column4,column5,column6];
}

/**
* 功能描述：返回子表2列表页面要显示的对象集合。此处为agent表的信息
*   				 data:是利用dwr请求服务器端函数，回调返回的结果，一般为map或者list
*/
function getDetail2Fields(){
    //获得公共的checkbox的输出代码
	var column0 = function(agent){
        var checkObj = jQuery("<input type='checkbox' id='checkbox_detail2View' name='checkbox_template' value='"+agent.agentid+"'/>").get(0);
        return checkObj;
	};
   var column1 = function(agent){ return DWRUtil.byId("detail2View").rows.length+1};
   var column2 = function(agent) { return agent['agentName']};
   var column3 = function(agent) { return agent['categoryname']};
   var column4 = function(agent) { return agent['agentProductName']};
   var column5 = function(agent) { return agent['agentLevel']};
   return [column0,column1,column2,column3,column4,column5];
}

 //--------------------构造主子表的列表对象  end--------------------------------------
 //------------复用主子表组件的时候需要手工修改 end-----------------------------------------------------------------------------
 
 
 //------------主子表的公共方法，不用修改  start-----------------------------------------------------------------------------------
 /**
 *功能描述：获取参数mdView下的新增行的序号
 *参数描述：mdView ，子表表体的标识。
 *
 *
 **/
 function getRowLength(mdView){
	var rowLength=DWRUtil.byId(mdView).rows.length;
	if(rowLength!=0) {
	rowLength=DWRUtil.byId(mdView).rows.item(rowLength-1).cells.item(1).innerHTML;
	}
	rowLength=parseInt(rowLength)+1;
	return rowLength;
 }


 /**
 * 功能描述：重载setTimeout,使它可以传递对象参数
 * 默认的setTimeout方法调用方式 setTimeout("function('obj')",1000(1000毫秒))，会延迟1秒执行function()函数
 * 其中function('obj')函数的obj参数不支持对象的传递，因此此函数重写了setTimeout函数，使它能够支持obj参数为对象进行调用
 */  
var _st = window.setTimeout;
window.setTimeout = function(fRef, mDelay) {
    if (typeof fRef == 'function') {
        var argu = Array.prototype.slice.call(arguments,2);
        var f = (function(){ fRef.apply(null, argu); });
        return _st(f, mDelay);
    }
    return _st(fRef,mDelay);
}

 
 /**
 * 功能描述：根据主表的主键id，初始化页签页面:
 *1 显示主表页面详细信息 
 *2 显示子表的列表页面
 * 参数描述：masterId
 */  
function initMDTabPage(masterId){
		UnifiedSubmitAjax.findMasterById(masterId,function(data) {
		     if (data != null && typeof(data) == 'object') { //有值,表示是修改页面
		     	 	//给页面控件赋值，显示主表页面详细信息
		     	 	setTimeout(setForms,500,data);
			     	//setForms(data);
					//填充主表下的所有子表列表页面
			     	UnifiedSubmitAjax.findAllDetailsByMasterId('masterDetailBo',masterId,function(data1){
				     	if(data1 != null && typeof(data1) == 'object'){
					     	for(prop in data1){
					     		setTimeout(loadViewDelay,500,prop,data1[prop]);
					     	}
				     	} 	
			     	});
			  }
		 });
}


function loadViewDelay(prop,data){
	fillMDListPage(prop,data);
}

/**
 * 功能描述：利用dwr.util 填充主表或者子表的列表内容数据
 * 参数描述：MDTypeId:主子表列表显示的类型id：MasterListData,Detail1ListData,Detail2ListData,Detatil3ListData....
 *					  data:利用dwr请求服务器端函数，回调返回的结果，一般为map或者list
 */  
function fillMDListPage(mdView,tempdata){
    dwr.util.removeAllRows(mdView);
	//填充主表或子表的列表内容到页面中去，主要使用getFieldValue函数，来加载不同的主子表列表页面
	dwr.util.addRows(mdView, tempdata,getMdFields(mdView));
	var trObjs = DWRUtil.byId(mdView).childNodes;
//	var tdObjs;
//	for(var i=0;i<trObjs.length;i++){
//		trObjs[i].className = "listCss";
//		tdObjs=trObjs[i].childNodes;
//		tdObjs[0].align = "center";
//	}
	
jQuery(trObjs).each(
     function () {
         jQuery(this).attr("class", "listCss").find("td:first-child").attr("align", "center");
     }
 );
	
	//页面初始化表格样式
	getTbodyColor();
}

function getMapFromPage(mdView){
    var masterDetailVo = getMasterDetailVo(mdView);
	for(var property in masterDetailVo){
			masterDetailVo[property] = dwr.util.getValue(property);		
	}
	return masterDetailVo;
}

/**
 * 功能描述：填充指定表的tbody内容
 * 参数描述：tableId -- 指定的表对象id 
 *					  cellObjects -- 要填充到行内单元格的对象数据集;
 *					  num -- 要填充的行数;
 */  
function insertRow(tableId,cellObjects,num){
	var tbodyObj = DWRUtil.byId(tableId);
	var rowObj1= tbodyObj.insertRow(tbodyObj.rows.length);
	insertCell(tbodyObj,rowObj1,cellObjects);
}
/**
 * 功能描述：填充tr的内容
**/
function insertCell(tableObj,rowObj,cells){
	rowObj.className="listCss";
	var irow=tableObj.rows;
	var icell;
	if(rowObj.rowIndex==1){
		var theadObj = tableObj.parentElement.getElementsByTagName("thead");
		icell = theadObj[0].rows[0].cells;
	}else{
		icell=tableObj.rows[0].cells;
	}
	for(i=0;i<icell.length;i++){
		rowObj.insertCell(0);
	}
	for(var i=0;i<icell.length;i++){
		rowObj.cells[i].innerHTML=cells[i];
	}
	//马啸修改，解决多选框对齐的问题
	var tdObjs=rowObj.childNodes;
	tdObjs[0].align = "center";
}

  	/*
	 *从enum文件中读取信息，填充选择框
	 *@param data 从enum文件中读取的数据（List）
 	 *@param selectid
	 */
  	function initSelect(data,selectid){ 
  		var sel = DWRUtil.getValue(selectid);   
	    DWRUtil.removeAllOptions(selectid); 
	    DWRUtil.addOptions(selectid,data,"value","label");
	    DWRUtil.setValue(selectid,sel); 
  	}  
/**
 * 功能描述：获得多选框对应的行内隐藏主键集合
 * 参数描述：checkName -- 多选框的名称
 */    
function getSelectIds(checkName){
	var data = new Array();//对象集合
    jQuery(":checked[id='"+checkName+"']").each(function(number){ data[number]=jQuery(this).val();});
	return data;
	
	
	
}

/**
 * 功能描述：获得多选框对应的行内隐藏主键集合
 * 参数描述：checkName -- 多选框的名称
 *					  idName -- 行记录的隐藏主键id;
 */    
function getSelectIdArray(checkName){
	var data = new Array();
	 jQuery(":checked[id='"+checkName+"']").each(function(){ data ={'serial':jQuery("input[id='"+checkName+"']").index(jQuery(this)[0]),'idvalue':jQuery(this).val()};});
	return data;
}


/**
 * 功能描述：包含页面
 * 参数：	pageobj --要包含的页面的相对路径;
 *  		divId---显示页面内容的div id.
 */    
function include(divId,pageobj) {
	if(DWRUtil.byId(divId).childNodes.length>0){
		return;
	}
	AjaxControl.getInclude(pageobj,function(data) {
		if (data != null && typeof data == 'object') {
			alert(dwr.util.toDescriptiveString(data, 2));
		}
		else dwr.util.setValue(divId, data, { escapeHtml:false });
	});
}

/**
 * 功能描述：自动获取主键
 * 参数:pkid:对应表主键的控件name
 *          tablename:对应表名
 * 备注:masterid都是从masterDetailTab.jsp中获得的公共变量
 */ 
function checkMasterId(pkid,tablename){
	if($name(pkid).value == ""){
		UnifiedSubmitAjax.getMasterTableId(tablename,function(data){
			$name(pkid).value = data;
			masterid = data;
		});
		masterFlag = "insert";
	}
}

function changeMasterState(){
	if(masterFlag == "query"){
		masterFlag = "update";
	}
}

/**
 * 功能描述：主子表统一提交操作
 * 参数:mdBoName:对应applicationContext-ajaxControl.xml的主子表关于bo的节点
 * 备注:masterFlag,sessionid,masterid都是从masterDetailTab.jsp中获得的公共变量
 */    
function unifiedSubmit(mdBoName){
    if(checkAllForms()!=true){
		return;
	}
	  if(masterFlag=="insert" || masterFlag=="update"){
			var masterVo = getMapFromPage('masterView');
			masterVo.sessionId = sessionid;
			masterVo.state = "insert";
			if(masterFlag =="update"){
				masterVo.state = "update";
			}
			UnifiedSubmitAjax.insertCache(mdBoName,'masterView',masterVo,function(data){
				if (data != null && typeof(data) == 'object') {
					alert(dwr.util.toDescriptiveString(data, 2));
				}
				else {
					UnifiedSubmitAjax.updateMasterDetailCache(sessionid,mdBoName,function(data){
						if (data != null && typeof(data) == 'object') {
							alert(dwr.util.toDescriptiveString(data, 2));
						}
						else {
							alert(data);
						};
						flush();
					});
				};
			});
		}
		else{
			UnifiedSubmitAjax.updateMasterDetailCache(sessionid,mdBoName,function(data){
				if (data != null && typeof(data) == 'object') {
					alert(dwr.util.toDescriptiveString(data, 2));
				}
				else {
					alert(data);
				};
				
				flush();
			});
		}

}
//刷新子表列表页面数据
function flush(){
	masterFlag="query";//重置状态位
	//填充主表下的所有子表列表页面
	UnifiedSubmitAjax.findAllDetailsByMasterId('masterDetailBo',DWRUtil.byId("factoryid").value,function(data1){
	 	if(data1 != null && typeof(data1) == 'object'){
	     	for(prop in data1){
	     		setTimeout(loadViewDelay,500,prop,data1[prop]);
	     	}
	 	} 	
	});
}

/**
 * 功能描述: 子表列表增加按钮操作
 * 参数: mdView 主子表唯一标识
 *          masteridName: 子表中关联主表的页面控件的名称
 * 备注: masterFlag,sessionid,masterid都是从masterDetailTab.jsp中获得的公共变量
 *					  
 */  
function addDetail(mdView,masteridName){
var checkName = "checkbox_"+mdView;
	if(masterid ==""){
		alert(i18n.please_fill_the_main_table);
		return;
	}
    var detail = getMasterDetailVo(mdView);
	detail['sessionId'] =  sessionid;
	detail['state'] = "insert";
	//detail['serial'] = ($(mdView).rows.length)+1;
	detail['serial'] = getRowLength(mdView);
	detail[masteridName] = masterid;
	var cmd;
	cmd = "insert_"+mdView;
	
	//var event = window.event?window.event:addDetail.caller.arguments[0];
	//var obj = window.showModalDialog(basepath+'/MasterDetailAction.do?cmd='+cmd,[detail],"日期参照","status:1;dialogHeight:500px;dialogWidth:490px;dialogTop: "+event.screenY+"px; dialogLeft: "+event.screenX+"px");
	var obj = window.showModalDialog(basepath+'/MasterDetailAction.do?cmd='+cmd,[detail],'dialogHeight:500px;dialogWidth:490px;center=yes;help:no;resizable:no;scroll:no;status:0;');
	if(obj == null || obj == undefined ){
		return;
	}
	var cellObjects = getDetailsListView(mdView,obj);
	
	if(DWRUtil.byId(mdView) == null){
		inlcude(mdView+"_list",getPageobj(mdView+"_list"));
		insertEndRow(mdView,cellObjects); 	
	}
	else{
		insertEndRow(mdView,cellObjects); 
	}
	clearSelect(checkName);
	//页面初始化表格的样式
	getTbodyColor();
}

/**
 * 功能描述：子表列表修改按钮操作
 * 参数描述：mdView:主子表唯一标识，detail1View,detail2View....
 *                    masteridName: 子表中关联主表字段的页面控件的名称
 *                    pkid:子表主键的页面控件名称
 */  
function modifyDetail(mdView,masteridName,pkid){

	var checkName = "checkbox_"+mdView;
	var ids=getSelectIds(checkName); //批量删除
	if(ids.length == 0) {
  		alert(i18n.please_choose_a_records_to_modify)
  		return;
	}
	if(ids.length !=1) {
  		alert(i18n.can_only_choose_a_record_to_modify)
  		return;
	}
    
    ids = getSelectIdArray(checkName);
    var detail = getMasterDetailVo(mdView);
	detail['sessionId'] =  sessionid;
	detail['state'] = "update";
	detail['serial'] = ids['serial'];
    var detailid = ids['idvalue'];
    detail[masteridName] = masterid;
    detail[pkid] = detailid;
    if(detailid == ""){
    	detail['state'] = "insert";
    }
    var cmd;
	cmd = "insert_"+mdView;
	var obj = window.showModalDialog(basepath+'/MasterDetailAction.do?cmd='+cmd,[detail],'dialogHeight:500px;dialogWidth:490px;center=yes;help:no;resizable:no;scroll:no;status:0;');
	if(obj == null || obj == undefined){
		return;
	}

	var cellObjects = getDetailsListView(mdView,obj);
	changeRow(mdView,cellObjects,ids['serial']); 
	clearSelect(checkName);
    //页面初始化表格的样式
    getTbodyColor();
}

/**
*功能描述：勾选掉当前页面中选中的多选框
*参数描述：checkName -- 多选框的名称
*/
function clearSelect(checkName){
    jQuery(":checked[id='"+checkName+"']").each(function(){ jQuery(this).attr("checked",false);});
}


/**
 * 功能描述：子表列表删除按钮操作
 * 参数描述：mdView:子表id，Detail1,Detail2....
 *					  
 */  
function deleteDetail(mdBoName,mdView,pkid){
	var checkName = "checkbox_"+mdView;
	var ids=getSelectIds(checkName,"id"); //批量删除
	if(ids.length == 0) {
  		alert(i18n.please_choose_record_to_delete);
  		return;
	}
	if(confirm(i18n.confirm_to_delete_record)) {
    	var detail = getMasterDetailVo(mdView);
		detail.sessionId =  sessionid;
		detail.state = "delete";
		  var data=getSelectIdArray(checkName);
          detail[pkid] = data['idvalue'];
          detail['serial'] = data['serial'];
           if (detail[pkid]  == "") {
              UnifiedSubmitAjax.deleteCache(mdBoName,mdView,detail);
           }
           else{
              UnifiedSubmitAjax.insertCache(mdBoName,mdView,detail);  //此处将来可改进成批量删除
           }
          jQuery(":checked[id='"+checkName+"']").parent().parent().remove();
	}
}

/**
 * 功能描述：根据子表的主键id，初始化子表编辑页面
 * 参数描述：mdBoName:bo的标识，对应applicationContext-ajaxControl关于bo的节点
 * 					  mdView:主子表唯一标识：masterView,detail1View,detail2View....
 *					  vo:前台组成的vo对象
 *                    pkid:子表主键的页面控件名称
 */  
function initDetailPage(mdBoName,mdView,vo,pkid){
    var detailid = vo[pkid];
    if(vo['state']=='insert') return;//新增页面不从缓存中取值
    UnifiedSubmitAjax.getFromCacheOrDataBase(mdBoName, mdView, vo,detailid,function(data){
				setForms(data);
		});
}
/**
*功能描述：根据sessionId清除缓存中的数据
**/
function clearMasterDetailData_onClick(){
	var cache= {
		sessionId:"",
		name:"",
		state:"",
		serial:""
	} ;
	cache.sessionId =  sessionid;
	UnifiedSubmitAjax.clearMasterDetailCache(cache.sessionId,function(data){
		if (data != null && typeof data == 'object') {
			alert(dwr.util.toDescriptiveString(data, 2));
		}
		else alert(i18n.clear_cache_success);
	});
}
 //------------主子表的公共方法，不用修改  end-----------------------------------------------------------------------------------


 