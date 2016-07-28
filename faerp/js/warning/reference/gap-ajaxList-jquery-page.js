
function PageVoJs(){
	this.recordCount = 0;
	this.pageSize = 10; 
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
		obj.alt = i18n.ascending;
	}else{
		this.sortStr ="DESC";
		obj.src = obj.src.substring(0,obj.src.indexOf("images"))+"images/layout2/sort.gif";
		obj.alt = i18n.descending;
	}
	return this.sortStr;
}

PageVoJs.prototype.action = function(){
	alert(i18n.please_customize_behavior);
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
		alert(i18n.has_reached_the_last_page);
		return;
	}
	this.currentPage +=1;
	this.setCheckBox();
	this.action();
}

/**
 * 功能描述：翻到第一页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.firstPage = function(){
	if(this.currentPage==1){
		alert(i18n.has_reached_first_page);
		return;
	}
	serial = 1;
	this.currentPage=1;
	this.setCheckBox();
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
	var jumppage=jQuery("input[name=VENUS_PAGE_NO_KEY_INPUT]").val();//注意这里的jQues，不是$
	if(jumppage==""){
		alert(i18n.please_enter_page_number);
		return;
	}

	if(!patrn.exec(jumppage)){
		alert(i18n.please_enter_correct_page_number);
		return;
	}
	if(this.pageCount < parseInt(jumppage)){
		alert(i18n.input_page_number_too_big);
		return;
	}
	if(this.currentPage == parseInt(jumppage)){
		alert(i18n.has_to_nth_page(this.currentPage));
		return;
	}
	this.currentPage= jumppage;
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
			alert(i18n.has_reached_the_last_page);
			return;
		}
	this.currentPage=this.pageCount;
	serial = (this.currentPage-1) * this.pageSize+1;
	this.setCheckBox();
	this.action()
}

/**
 * 功能描述：向前翻页
 * 参数描述：
 *					  
 */    
PageVoJs.prototype.upPage = function(){
	if(this.currentPage==1){
		alert(i18n.has_reached_first_page);
		return;
	}
	this.currentPage -=1;
	serial = (this.currentPage-1) * this.pageSize+1;
	this.setCheckBox();
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


var serial = 1;

function  buildSerial(){
	return serial++;
}
function initSerial(){//初始化序号
	serial = 1;
	return serial ;
}

//翻页时，把复选框勾选掉--马啸添加
PageVoJs.prototype.setCheckBox= function(){
	 	var element = document.getElementsByTagName("input");
		for(var i=0;i<element.length;i++){
			if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
				element[i].checked=false;
			}
		}
}
