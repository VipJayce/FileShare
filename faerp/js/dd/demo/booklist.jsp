		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.core.js\"><\/script>")
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.dialog.js\"><\/script>")
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.draggable.js\"><\/script>")
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.resizable.js\"><\/script>")
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
		window.location=webPath+"/BookStoreDemo.do?cmd=listCart";
	}	
	function viewOrder_onClick()
	{
		document.location=webPath+'/jsp/dd/template/common/list.jsp?moduleName=订单管理&tableView=ORDERLIST&detailView=ORDEREDIT&queryView=ORDERQUERY&toolView=ORDERTOOL';
	}	
	function check_onClick()
	{
		window.location=webPath+"/BookStoreDemo.do?cmd=initOrder";
	}	
	
  	jQuery(document).ready(function(){
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.core.js\"><\/script>")
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.dialog.js\"><\/script>")
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.draggable.js\"><\/script>")
		//document.write("<script   language=\"javascript\"   src=\"<%=request.getContextPath()%>/js/dd/jquery/ui.resizable.js\"><\/script>")
  		 //jQuery("#dialogPanel").dialog({ modal: true, height:250,autoOpen:false,resizable:false,width:800,overlay: { opacity: 0.5, background: "black" }});
	 });
	