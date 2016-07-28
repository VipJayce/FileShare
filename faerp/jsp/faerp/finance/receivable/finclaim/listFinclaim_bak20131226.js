_$(document).ready(function(){
        //认领
        _$("#c_1").bind('click', function() {
            var entity = selectEntity();
            
            if(!entity){
               alert("请选择一条记录！");
               return;
            }
            var claim_status_bd = entity.getValue("claim_status_bd");
            if (claim_status_bd == '3'||claim_status_bd == '4') {
                alert('已认领完成的到款不能再次认领。');
                return false;
            }
            var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingID&id=" + entity.getValue("id");
            window.location.href = url;
        });
        
        
        //新认领
        _$("#g_1").bind('click', function() {
        	
        	var ids = selectIds();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
            var falsecount=0;
            for(i=0;i<ids.length;i++){
            var incoming_id=ids[i]+"";
            var datacell = $id("dcListIncoming");
            var dataset1 = datacell.dataset;
        	
            var datasettr1 = dataset1.findEntity("id",incoming_id);
            var claim_status_bd = datasettr1.getValue("claim_status_bd");
            /*
            var entity = selectEntity();
            if(!entity){
               alert("请选择一条记录！");
               return;
            }
            var claim_status_bd = entity.getValue("claim_status_bd");
            */
            if (claim_status_bd == '3'||claim_status_bd == '4') {
                falsecount=1;//只要选中的到款中有一条是认领完成的，则不能进行认领
            }
            }
            if(falsecount==1){
            	alert('已认领完成的到款不能再次认领。');
                return false;
            }
            var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIDNew&id=" + ids;
            window.location.href = url;
        });
        
        /**
         *  备份之前的认领
        //新认领
        _$("#g_1").bind('click', function() {
            
            var ids = selectIds();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
            
            if(ids.length>1){
                alert("只能选择一条记录！");
                return;
            }
            var incoming_id=ids[0]+"";
            var datacell = $id("dcListIncoming");
            var dataset1 = datacell.dataset;
            
            var datasettr1 = dataset1.findEntity("id",incoming_id);
            var claim_status_bd = datasettr1.getValue("claim_status_bd");
       
            if (claim_status_bd == '3'||claim_status_bd == '4') {
                alert('已认领完成的到款不能再次认领。');
                return false;
            }
            var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIDNew&id=" + incoming_id;
            window.location.href = url;
        });
         */
        
        _$("#f_1").bind('click', function() {
        	
        	var ids = selectIds();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
            
            if(ids.length>1){
                alert("只能选择一条记录！");
                return;
            }
            var incoming_id=ids[0]+"";
            var datacell = $id("dcListIncoming");
            var dataset1 = datacell.dataset;
            
            var datasettr1 = dataset1.findEntity("id",incoming_id);
            var claim_status_bd = datasettr1.getValue("claim_status_bd");
            
            if(!confirm('确认取消该到款的最近一次认领?')){
               return false;
            }
            /*
            var entity = selectEntity();
            if(!entity){
               alert("请选择一条记录！");
               return;
            }
            var claim_status_bd = entity.getValue("claim_status_bd");
            */
            
            if (claim_status_bd == "1") {
              alert('未认领的到款不能取消认领。');
              return false;
            }else{
              checkCancelclaim(incoming_id);
            }
        });
        
        
    
       //导出
       _$("#exp").bind("click", function(){
            if(!confirm('确认导出数据?')){
               return false;
            }
            var url = venusbase + "/FinclaimAction.do?cmd=exportExcelFromIncoming";
            _$("form").attr("action", url);
            _$("form").submit();
            _$("form").attr("action", "");
       });
       
       
       
       _$("#button_ok").bind("click", function(){
           var inc_date_to_hid=_$("#inc_date_to_hid_input").val();
           //alert(inc_date_to_hid);
           	if(inc_date_to_hid!=undefined&&inc_date_to_hid!=""){
           	_$("#inc_date_to").val(inc_date_to_hid+" 12:59:59");
           	}
           	//alert(_$("#inc_date_to").val());
            $id("dcListIncoming").reload();
       });
       
    
});

/**
 * 根据预收款跳到认领页面
 */
function showSingleFinclaim() {
    //alert('跳转');
}


function checkCancelclaim(incomingid) {
	showProgressBar();
    //取消认领：
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=cancelclaim&id=" + incomingid,
        dataType : "html",
        success : function(data) {
            if(data) {
                if (data == '1') {
                    alert("取消认领成功。");
                    $id("dcListIncoming").reload();
                } else {
                    alert(data);
                }
            } else {
               alert("取消认领失败。");
            }
        }
    });
    hideProgressBar();
}




//无账单认领
function no_Bill_Claim() {
	
            var ids = selectIds();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
            
            if(ids.length>1){
                alert("只能选择一条记录！");
                return;
            }
            var incoming_id=ids[0]+"";
            var datacell = $id("dcListIncoming");
            var dataset1 = datacell.dataset;
            
            var datasettr1 = dataset1.findEntity("id",incoming_id);
            var claim_status_bd = datasettr1.getValue("claim_status_bd");
            
            if (claim_status_bd == '3'||claim_status_bd == '4') {
                alert('已认领完成的到款不能再次认领。');
                return false;
            }
            var strUrl = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIdNoBill&id=" + incoming_id;
            //window.location.href = url;
            //var strUrl = venusbase + "/FinverifcationAction.do?cmd=queryAll&type='ver'";
            showModalCenter(strUrl, "", show_callback, "880", "410", "无账单认领");//showReceivable_callback
}

function show_callback(value) {
	$id("dcListIncoming").reload();
}

//认领预收款
function showReceivable() {
    var strUrl = venusbase + "/FinverifcationAction.do?cmd=queryAll&type='ver'";
    showModalCenter(strUrl, "", showReceivable_callback, "880", "450", "认领预收款");
}

function showReceivable_callback(value) {
    var inc_id = value[0];
    var cust_id = value[1];
    var cost_center_id = value[2];
    var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIDNew&id=" + inc_id + "&cust_id=" + cust_id+ "&cost_center_id=" + cost_center_id;
    window.location.href = url;
}

function selectEntity() {
    var dc = $id("dcListIncoming");
    var entity = dc.getActiveEntity();
    return entity;
}