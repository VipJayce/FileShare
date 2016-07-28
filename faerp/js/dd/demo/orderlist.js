function resubmitOrder_onClick(){
	var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	if(ids == null) {  //如果ids为空
  		alert("请选择一条记录!")
  		return;
	}
	if(ids.length > 1) {  //如果ids有2条以上的纪录
  		alert("只能选择一条记录!")
  		return;
	}
	var table=$("ccChild1").getElementsByTagName("table")[0].getElementsByTagName("table")[0];
	var values=findSelectedValues(table,"checkbox_template",10);
	if(values!="处理不成功"){
		alert("只能对处理不成功的订单操作！");
		return;
	}
	if(confirm("确定要重新提交订单吗？")) {
		window.location=webPath+"/BookStoreDemo.do?cmd=reSubmitOrder&orderId=" +ids;
	}
}
function handle(){
	handleOrder();
}
function detail(){
	handleOrder('view');
}
function handleOrder(cmd){
	var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	if(ids == null) {  //如果ids为空
  		alert("请选择一条记录!")
  		return;
	}
	if(ids.length > 1) {  //如果ids有2条以上的纪录
  		alert("只能选择一条记录!")
  		return;
	}
	var url = webPath+"/jsp/dd/demo/orderDetail.jsp";
	url += "?orderId="+ids+"&tableView=ITEMLIST";
	if(cmd != null)url = url+"&cmd="+cmd;
	window.location=url;
}