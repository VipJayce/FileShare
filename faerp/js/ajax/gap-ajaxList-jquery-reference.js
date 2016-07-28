var pageVo = null;
var oldTableBody;

function setSerial(){//重新分配序号
	if(pageVo.currentPage<=0){
		serial = 1;
	}else{
		serial = pageVo.pageSize*(pageVo.currentPage-1)+1;
	}
	return ;
}

	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;

	/*
	*初始化参照页面和在参照页面中翻页时掉用该方法,用户不需要修改
	*/
	function getActionMap(){
		var tableBody=jQuery("input[name=tableBody]").val();
		loadDelay(contextpath,tableBody);
		getPageVojs(tableBody);
		oldTableBody=tableBody;
		getAjaxURL(tableBody);
		
	}

/**
 * 功能描述：更新表数据时延时等待图片显示
 * 参数描述：tbodyid -- 表tbody的id， 
 *					  
 */
function loadDelay(path,tbodyid){
	DWRUtil.removeAllRows(tbodyid);
	var thead = DWRUtil.byId(tbodyid).parentNode.getElementsByTagName("thead")[0];
	var span = thead.rows[0].cells.length
	var rowObj= DWRUtil.byId(tbodyid).insertRow(0);
	var cell = rowObj.insertCell(0);
	cell.colSpan = span;
	cell.align = "center";
	cell.bgColor = "#FFFFFF";
	cell.innerHTML = '<img src="'+path+'/images/ajaxList/ajax-loader2.gif">加载中...';
}

/*
*返回参照页面显示的参照信息，填充表格时调用此方法
*data:返回的参照页面显示信息
*/
function fillTable(data){
	var tableBody=jQuery("input[name=tableBody]").val();
	DWRUtil.removeAllRows(tableBody);
	DWRUtil.addRows( tableBody, data,getListFields(tableBody));
	var trObjs = DWRUtil.byId(tableBody).childNodes;
	var tdObjs;
	for(var i=0;i<trObjs.length;i++){
		trObjs[i].className = "listCss";
		tdObjs=trObjs[i].childNodes;
		tdObjs[1].align = "center";
	}
		//页面初始化表格的样式
       getTbodyColor();
} 

/*
*点击参照按钮后调用该方法
*dialogDivId,显示参照页面的div的id
*tableBody,显示参照信息的tbody的id
*/
  function reference(dialogDivId,tableBody) {
  	  	jQuery("input[name=tableBody]").val(tableBody);
		jQuery("#"+dialogDivId).dialog("open");
		loadPage(dialogDivId,tableBody);
		
  }
/*
*点击参照页面上的关闭按钮后调用该方法
*dialogDivId,显示参照页面的div的id
*tableBody,显示参照信息的tbody的id
*/
  function closed(dialogDivId){
  	  DWRUtil.removeAllRows(jQuery("input[name=tableBody]").val());
  	  jQuery("#"+dialogDivId).dialog("close");
  }
/*
*点击参照页面的确认按钮后调用该方法
*dialogDivId,显示参照页面的div的id
*tableBody,显示参照信息的tbody的id
*input_id,存储用户选择的记录id的输入框的id
*input_name,存储用户选择的记录name的输入框的id
*/
  function returnValue(dialogDivId,input_id,input_name){
  	  	if((jQuery("input:checked[name='checkbox_template']")).size()==0 || (jQuery("input:checked[name='checkbox_template']")).size()>1){
			return ;
		}
		var elementCheckbox=jQuery("input:checked[name='checkbox_template']");
		var ids = elementCheckbox[0].value;
		
		jQuery("input[name='"+input_id+"']").val(ids.substring(0,ids.indexOf(":")));
		jQuery("input[name='"+input_name+"']").val(ids.substring(ids.indexOf(":")+1));

		closed(dialogDivId);
  }

/***********************************需要用户修改(begin)***************************/
 /*
 *根据参数获取要调用的后台方法,需要用户修改
 */
function getAjaxURL(tableBody){
	if(tableBody == "factoryTableBody"){
		JqueryReferenceAjax.queryAllFromFactory(pageVo,pageVo.getOrderSortStr(),getMapResult);
	} 
	if(tableBody == "productTableBody"){
		JqueryReferenceAjax.queryAllFromProduct(pageVo,pageVo.getOrderSortStr(),getMapResult);
	} 
}
  /*
  *加载参照页面时候调用,需要用户修改
  */
  function loadPage(dialogDivId,tablebody){
  	  if(tablebody == "factoryTableBody"){
		jQuery("#"+dialogDivId).load(contextpath+'/JqueryReferenceAction.do',{cmd:'forwardFactoryReferencePage'},function(){getActionMap();});
  	  }
  	  if(tablebody == "productTableBody"){
		jQuery("#"+dialogDivId).load(contextpath+'/JqueryReferenceAction.do',{cmd:'forwardProductReferencePage'},function(){getActionMap();});
  	  }
  }
/*
*根据参数设置不同的翻页信息对象pageVo,需要用户修改
*/
function getPageVojs(tbodyid){
	if(oldTableBody != tbodyid){
		if(tbodyid=="factoryTableBody"){
			pageVo  = new PageVoJs();
			//设置默认排序方式
			pageVo.setOrderStr("factoryid");
		}
		if(tbodyid == "productTableBody"){
			pageVo  = new PageVoJs();
			//设置默认排序方式
			pageVo.setOrderStr("productid");
		}
	}
	setSerial();//重新设置序号
}

/*
*根据参数获取参照页面显示的表头信息,需要用户修改
*/
function getListFields(tableBody){
	if(tableBody == "factoryTableBody"){
		return getFactoryListFields();
	} 
	if(tableBody == "productTableBody"){
		return getProductListFields();
	} 
}
  
 /*
 *返回工厂参照页面显示的表头信息,需要用户修改
 */
function getFactoryListFields(){
	var column0 = buildSerial;
    //获得公共的checkbox的输出代码
	var column1 = function(data){
		var checkObj = jQuery("<input type='radio'  name='checkbox_template' value='"+data.factoryid+":"+data.name+"' />").get(0);
		return checkObj;
	};
	var column2=  function(data) { return data['factoryid']};
   	var column3 = function(data) { return data.name};
  return [column0,column1,column2,column3];
}
 /*
 *返回产品参照页面显示的表头信息,需要用户修改
 */
function getProductListFields(){
	var column0 = buildSerial;
    //获得公共的checkbox的输出代码
	var column1 = function(data){
        var checkObj = jQuery("<input type='radio'  name='checkbox_template' value='"+data.productid+":"+data.name+"' />").get(0);
		return checkObj;
	};
	var column2=  function(data) { return data['productid']};
   	var column3 = function(data) { return data.name};
  return [column0,column1,column2,column3];
}

/***********************************需要用户修改(end)***************************/