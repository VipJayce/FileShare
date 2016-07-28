_$(document).ready(function(){
    //add function by yuanzhe 20160310
    _$("#unLockFin").bind('click', function(){
        var ids = selectIds();
        if (ids.length == 0) {
            alert("主人，你没有选择要解锁的数据呀！");
            return;
        }
        if (confirm("主人，你真的要解锁吗？")) {
            alert("好的主人，我这就给您解锁。");
            jQuery.post(venusbase + "/FinclaimAction.do",{"cmd":"unLockedFinance", "incoming_ids": ids}, function(data){
                alert(data);
                if (data.indexOf("完成") >= 0) {
                    reloadDataCell();
                }
            });
        }
    });

    _$("#lockFin").bind('click', function(){
        var ids = selectIds();
        if (ids.length == 0) {
            alert("主人，你没有选择要锁定的数据呀！");
            return;
        }
        if (confirm("主人，你真的要锁定吗？")){
            alert("好的主人，我这就给您锁定。");
            jQuery.post(venusbase + "/FinclaimAction.do",{"cmd":"lockedFinance", "incoming_ids": ids}, function(data){
                alert(data);
                if (data.indexOf("完成") >= 0) {
                    reloadDataCell();
                }
            });
        }
    });

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
            var id_code = selectIdsNew();
            var ids = selectIds()
            //modify by yuanzhe 20160308
            jQuery.post(venusbase + "/FinclaimAction.do",{"cmd":"checkIsLocked","incoming_ids": ids}, function(data){
                if (data == "pass") {
                    jQuery.ajax({
                        type: "post",
                        url: venusbase + "/FinclaimAction.do?cmd=lockFinIncoming&id_code=" + id_code,
                        dataType: "html",
                        success: function (data) {
                            if (data != "") {
                                alert(data);
                            } else {
                                showClaimingPageByIncomingIDNew();
                            }
                        }
                    });
                } else {
                    alert(data);
                }
            });
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
            
            /**if(!confirm('确认取消该到款的最近一次认领?')){
               return false;
            }**/
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
            var url = venusbase + "/FinclaimAction.do?cmd=exportExcelFromIncoming1";
            _$("form").attr("action", url);
            _$("form").submit();
            _$("form").attr("action", "");
       });
       
       
       
       _$("#button_ok").bind("click", function(){
           var inc_date_to_hid=_$("#inc_date_to_hid_input").val();
           var create_date_to_hid = _$("#create_date_to_hid_input").val();
           //alert(create_date_to_hid);
            if(inc_date_to_hid!=undefined&&inc_date_to_hid!=""){
            _$("#inc_date_to").val(inc_date_to_hid+" 12:59:59");
            }
            if(create_date_to_hid!=undefined&&create_date_to_hid!=""){
                _$("#create_date_to").val(create_date_to_hid+" 23:59:59")
            }
            //alert(_$("#create_date_to").val());
            $id("dcListIncoming").reload();
       });
       
       //取消到款认领
     _$("#cancel_fin").bind('click', function() {
            var ids = selectIds();
            var inc_codes = selectInc_Codes();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
            /*
            var incoming_id=ids[0]+"";
            var datacell = $id("dcListIncoming");
            var dataset1 = datacell.dataset;
            var datasettr1 = dataset1.findEntity("id",incoming_id);
            var claim_status_bd = datasettr1.getValue("claim_status_bd");
            */
            cancelLockFinClaim(inc_codes);
        });        
});

/**
 * 根据预收款跳到认领页面
 */
function showSingleFinclaim() {
    //alert('跳转');
}


function checkCancelclaim(incomingid) {
    showModalCenter(venusbase+"/FinclaimAction.do?cmd=toSelectClaim&incomingid=" + incomingid,null,afterSelect,800,450,"选择认领");
}

//选择完认领的返回方法
function afterSelect(retVal){
    var incomingid = retVal[0];//到款id
    var claim_id = retVal[1];//认领id
    var ver_id = retVal[2];//核销id
    var bill_id = retVal[3];//账单id
    var inc_code = retVal[4];//到款编号
    //add  method to locking claim and bill 
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=lockCancelClaim&inc_id=" + incomingid+"&bill_id="+bill_id,
        dataType : "html",
        async: false,
        success : function(data) {
            if(data != "") {
                alert(data);
            } else {
                    showProgressBar();
				    //取消认领：
				    _$.ajax({
				        type : "post",
				        url : venusbase + "/FinclaimAction.do?cmd=cancelclaim&id=" + incomingid+"&claim_id="+claim_id+"&verification_id="+ver_id,
				        dataType : "html",
				        async: false,
				        success : function(data) {
				            if(data) {
				                if (data == '1') {
				                    //跳转填写原因界面 走审批流
                                    showModalCenter(venusbase+"/FinclaimAction.do?cmd=toCancelRemarks&incomingid=" + incomingid+"&claim_id="+claim_id+"&verification_id="+ver_id,null,freshdc,500,300,"取消原因");
				                }else{
				                    alert(data);
				                }
				            } else {
				               alert("取消认领失败。");
				            }
				        }
				    });
				    unlockBillAndClaim(bill_id,inc_code);
				    hideProgressBar();
            } 
        }
    });
}

function reloadDataCell() {
    $id("dcListIncoming").reload();
    $id("dcListIncoming").refresh();
}

//填写原因后执行的方法
function freshdc(retVal){
    //刷新datacell
    $id("dcListIncoming").reload();
}



//无账单认领
function no_Bill_Claim(flag) {
    
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
            var strUr;
            if(flag == 0){
                strUrl = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIdNoBillNoKP&id=" + incoming_id;
            }else if(flag == 1){
                strUrl = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIdNoBill&id=" + incoming_id;
            }
            
           // var strUrl = venusbase+"/FinclaimAction.do?cmd=showFininvoicePageByIncomingId&incoming_id="+incoming_id+"&no_amount_flag=0";
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
    var inc_code = value[3];
    var uniqueMap = new Map();
    uniqueMap.put(inc_id, inc_code);
    //modify by yuanzhe 20160308
    var ids = new Array(0);
    ids.push(inc_id);
    jQuery.post(venusbase + "/FinclaimAction.do",{"cmd":"checkIsLocked","incoming_ids": ids}, function(data) {
        if (data == "pass") {
            //锁定到款
            jQuery.ajax({
                type: "post",
                url: venusbase + "/FinclaimAction.do?cmd=lockFinIncoming&id_code=" + uniqueMap,
                dataType: "html",
                success: function (data) {
                    if (data != "") {
                        alert(data);
                    } else {
                        var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIDNew&id=" + inc_id + "&cust_id=" + cust_id + "&cost_center_id=" + cost_center_id;
                        window.open(url,'','height=500px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=到款认领');
                    }
                }
            });

        } else {
            alert(data);
        }
    });
}

function selectEntity() {
    var dc = $id("dcListIncoming");
    var entity = dc.getActiveEntity();
    return entity;
}

function showClaimingPageByIncomingIDNew() {
            var ids = selectIds();
            var financialFlag = document.getElementById("financialFlag").value;
            if(financialFlag=="true"){
                var bill_whether_write_off = selectBill();
            }
            var inc_codes = selectInc_Codes();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
             if(financialFlag=="true"){
                if(bill_whether_write_off=="1"){
                    if(ids.length>1){
                     alert("只能选择一条记录！");
                    return;
                    }
                 }
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
                 //取消认领锁定
                cancelLockFinClaimByfalsecount(inc_codes);
                alert('已认领完成的到款不能再次认领。');
                return false;
            }
            if(financialFlag=="true"){
                var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIDNew&id=" + ids+"&inc_codes=" + inc_codes+"&bill_whether_write_off="+bill_whether_write_off;
            }else{
                var url = venusbase + "/FinclaimAction.do?cmd=showClaimingPageByIncomingIDNew&id=" + ids+"&inc_codes=" + inc_codes;
            }
            //window.location.href = url;
            window.open(url,'','height=500px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
            //window.showModalDialog (url,"","location:No;status:No;help:No;dialogWidth:1000px;dialogHeight:600px;scroll:yes;resizable:yes;");
}

function cancelLockFinClaim(inc_codes) {
     _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=unLockFinIncomingByPage&inc_codes=" + inc_codes,
        dataType : "text",
        success : function(data) {
            if(data != null || data != "") {
                alert(data);
            } else {
                alert(data);
            }
        }
    });
}

function cancelLockFinClaimByfalsecount(inc_codes) {
     _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=unLockFinIncomingByPage&inc_codes=" + inc_codes,
        dataType : "text",
        success : function(data) {
            if(data != null || data != "") {
               // alert(data);
            } else {
                //alert(data);
            }
        }
    });
}

function showLockFinIncoming() {
    var url = venusbase + "/FinclaimAction.do?cmd=showLockFinIncomingList";
      // var url = venusbase + "/FinverifcationAction.do?cmd=queryAll&type='ver'";
     showModalCenter(url, "", "", "600", "350", "锁定到款账单列表");
}

function showLockBill() {
    var url = venusbase + "/FinclaimAction.do?cmd=showLockBillList";
     showModalCenter(url, "", "", "700", "350", "锁定账单列表");
}

//核销无账单发票
function verInvoice() {
    
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
            var strUrl = venusbase + "/FinclaimAction.do?cmd=toVerNoBillInvoice&id=" + incoming_id;
           // var strUrl = venusbase+"/FinclaimAction.do?cmd=showFininvoicePageByIncomingId&incoming_id="+incoming_id+"&no_amount_flag=0";
            //window.location.href = url;
            //var strUrl = venusbase + "/FinverifcationAction.do?cmd=queryAll&type='ver'";
            showModalCenter(strUrl, "", refreshBack, "880", "450", "核销无账单发票");//showReceivable_callback
}

function refreshBack(){
    $id("dcListIncoming").loadData();
    $id("dcListIncoming").refresh();
}

//解锁取消认领对 认领和账单的锁定
function unlockBillAndClaim(bill_id,inc_code) {
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=unLockAllFinClaimAndBillByPage&bill_id=" + bill_id + "&inc_codes=" + inc_code,
        dataType : "text",
        success : function(data) {
        }
    });
}

function selectIdsNew() {
    var uniqueMap = new Map();
    var dc = $id("dcListIncoming");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            //此id为post_id
            uniqueMap.put(entity.getValue("id"), entity.getValue("inc_code"));
        }
    });
    return uniqueMap;
}

function selectIds() {
    var myids = new Array(0);
    var dc = $id("dcListIncoming");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            //此id为post_id
            //myids += entity.getValue("id") + ",";
            myids.push(entity.getValue("id"));
        }
    });
    return myids;
}

/**
 * 预览凭证
 */
function showVoucher(){
    var dc = $id("dcListIncoming");
    var entity = dc.getActiveEntity();


    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }

    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }

    var incoming_id = ids[0] ;//entity.getValue("id");
    if (incoming_id) {
        //w为窗口宽度，h为高度
        var w = 815;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no';
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showVoucherIncoming&incoming_id=" + incoming_id +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_gs=010";
        url = encodeURI(url);
        window.open(url, 'newwindow', s);
    }
}

function batchCreateVoucher(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    var incoming_id =ids;
    var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateucherIncoming&incoming_id=" + incoming_id +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_gs=010";;
    turl = encodeURI(turl);
    jQuery.ajax({
        url: turl,
        type: 'GET',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert( text);
            return  null;
        },
        success: function(text){
            alert(text);
            $id("dcListIncoming").reload();
        }
    });
}

function selectBill(){
    var bill_whether_write_off = document.getElementById("bill_whether_write_off").value;
    return bill_whether_write_off;
}

function checkAll(item) {
    if (_$(item).attr("checked")) {
        changeEntityChk(true);
        _$(":checkbox").attr("checked", true);
    } else {
        changeEntityChk(false);
        _$(":checkbox").attr("checked", false);
    }
}

function changeEntityChk(flag) {
    var dc1 = $id("dcListIncoming").dataset;
    var values = dc1.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}

function selectInc_Codes() {
    var myids = new Array(0);
    var dc = $id("dcListIncoming");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            myids.push(entity.getValue("inc_code"));
        }
    });
    return myids;
}