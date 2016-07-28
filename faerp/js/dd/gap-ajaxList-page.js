
function PageVoJs(){
	this.recordCount = 0;
	this.pageSize = -1; 
	this.pageCount = 1;
	this.currentPage = 1;
	this.orderStr = "";
	this.sortStr ="DESC";
}
PageVoJs.prototype.getOrderStr = function(){
	return this.orderStr;
}
PageVoJs.prototype.getRecordCount = function(){
	return this.recordCount;
}
PageVoJs.prototype.getPageSize = function(){
	return this.pageSize;
}
PageVoJs.prototype.getPageCount= function(){
	return this.pageCount;
}
PageVoJs.prototype.getCurrentPage = function(){
	return this.currentPage;
}
PageVoJs.prototype.getOrderSortStr = function(){
	return this.orderStr+" "+this.sortStr;
}

PageVoJs.prototype.setRecordCount = function(num){
	this.recordCount = num;
}
PageVoJs.prototype.setPageSize = function(num){
	this.pageSize = num;
	this.resetPage();
	this.action();
}
PageVoJs.prototype.setPageCount= function(num){
	this.pageCount = num;
}
PageVoJs.prototype.setCurrentPage = function(num){
	this.currentPage = num;
}
PageVoJs.prototype.setOrderStr = function(str){
	this.orderStr = str;
}
PageVoJs.prototype.changeSortStr = function(obj,str){
	if(this.orderStr!=str){
		return this.sortStr;
	}
	if(this.sortStr =="DESC"){
		this.sortStr ="ASC";
		obj.src = obj.src.substring(0,obj.src.indexOf("images"))+"images/layout/sort.gif";
		obj.alt = "升序";
	}else{
		this.sortStr ="DESC";
		obj.src = obj.src.substring(0,obj.src.indexOf("images"))+"images/layout2/sort.gif";
		obj.alt = "降序";
	}
	return this.sortStr;
}

PageVoJs.prototype.action = function(){
	alert("请自定义行为");
}

PageVoJs.prototype.updatePageVo = function(obj){
	this.recordCount = obj.recordCount;
	this.pageSize = obj.pageSize; 
	this.pageCount = obj.pageCount;
	this.currentPage = obj.currentPage;
}

/**
 * 功能描述：向后翻页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.downPage =function(){
	if(this.currentPage == this.pageCount){
		alert("已经到最后一页了");
		return;
	}
	this.currentPage +=1;
	this.action();
}

/**
 * 功能描述：翻到第一页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.firstPage = function(){
	if(this.currentPage==1){
		alert("已经到第一页了");
		return;
	}
	serial = 1;
	this.currentPage=1;
	this.action();
}

PageVoJs.prototype.resetPage = function(){
	serial = 1;
	this.currentPage=1;
}

PageVoJs.prototype.initAction = function(){
	this.resetPage();
	this.action();
}

/**
 * 功能描述：跳转到某页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.goAppointedPage = function(){
	var patrn = /^[1-9]\d*$/;//正整数
	if(form.VENUS_PAGE_NO_KEY_INPUT.value==""){
		alert("请先输入你要跳转到的页码");
		return;
	}
	if(!patrn.exec(form.VENUS_PAGE_NO_KEY_INPUT.value)){
		alert("请输入正确的页码");
		return;
	}
	if(this.pageCount < parseInt(form.VENUS_PAGE_NO_KEY_INPUT.value)){
		alert("输入跳转到的页码过大不存在");
		return;
	}
	if(this.currentPage == parseInt(form.VENUS_PAGE_NO_KEY_INPUT.value)){
		alert("已经到第 "+this.currentPage+" 页了");
		return;
	}
	this.currentPage= form.VENUS_PAGE_NO_KEY_INPUT.value;
	serial = (this.currentPage-1) * this.pageSize+1;
	this.action();
}



/**
 * 功能描述：翻到最后一页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.lastPage = function(){
	if(this.currentPage == this.pageCount){
			alert("已经到最后一页了");
			return;
		}
	this.currentPage=this.pageCount;
	serial = (this.currentPage-1) * this.pageSize+1;
	this.action()
}

/**
 * 功能描述：向前翻页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.upPage = function(){
	if(this.currentPage==1){
		alert("已经到第一页了");
		return;
	}
	this.currentPage -=1;
	serial = (this.currentPage-1) * this.pageSize+1;
	this.action();
	return;
}

/**
 * 功能描述：排序
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.sortOrder = function(obj,orderStr){
	this.changeSortStr(obj,orderStr);
	this.setOrderStr(orderStr);
	this.resetPage();
	this.action();
	return;
}

function setOrder(obj,orderStr)
{
	pageVo.sortOrder(obj,orderStr);
}


var serial = 1;

function setSerial(){
	if(currentPage<=0){
		serial = 0;
	}else{
		serial = this.pageSize*(this.currentPage-1)+1;
	}
	return ;
}

function  buildSerial(){
	return serial++;
}
