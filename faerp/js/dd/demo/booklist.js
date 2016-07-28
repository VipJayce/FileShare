function addToCart_onClick(){  
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids +=  elementCheckbox[i].value;
			}
		}
		
		if(number == 0) {
	  		alert("请选择书籍!")
	  		return;
		}
		if(number>1) {
			alert("一次只能选择一本书！")
			return;
		}
		bookStoreService.addToCart(ids,function(data){
			alert(data);
	   		jQuery(":checkbox").attr("checked", false);
		})
	}
	
	function viewCart_onClick()
	{
		sayHello();
		//jQuery("#dialogPanel").dialog("open");
		//jQuery('#dialogPanel').load('/web/jsp/dd/demo/cartItemList.jsp');
	}	
	function viewOrder_onClick()
	{
		document.location=webPath+'/jsp/dd/template/common/list.jsp?moduleName=订单管理&tableView=ORDERLIST&detailView=ORDEREDIT&queryView=ORDERQUERY&toolView=ORDERTOOL';
		//document.location='http://127.0.0.1:9999/web/';
	}	
	function check_onClick()
	{
		window.location=webPath+"/BookStoreDemo.do?cmd=initOrder";
	}	