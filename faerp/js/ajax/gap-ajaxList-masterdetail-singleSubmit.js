/***********************************注册子表的修改页面(begin)***************************/
//注册子表的修改页面
//pageobjMap的键是子表的唯一标识，值是子表的修改页面地址,需要用户修改
var pageobjMap={"ordercontent":"/jsp/ajaxList/masterdetailtable/singleSubmit/ordercontentEdit.jsp",
							"orderadvice":"/jsp/ajaxList/masterdetailtable/singleSubmit/orderAdviceEdit.jsp"}; 

	
	function getPageobj(detailview){//返回要载入的页面地址
		return pageobjMap[detailview];
	}
	
/***********************************注册子表的修改页面(end)***************************/

/***********************************注册子表vo(begin)***************************/
	//ordercontent子表的vo
		var ordercontent= {
			id:"",
			productId:"",
			productName:"",
			price:"",
			productCount:"",
			amount:""
		} ;

	//orderadvice子表的vo
		var orderadvice= {
			id:"",
			person:"",
			adviseDate:"",
			remark:""
		} ;

//注册子表vo,需要用户修改
var destailObj={"ordercontent":ordercontent,
							"orderadvice":orderadvice
							};

	function getDestailObj(detailview){//返回子表的vo
		return getForms(destailObj[detailview]);
	}
	
	


/***********************************注册子表vo(end)***************************/
