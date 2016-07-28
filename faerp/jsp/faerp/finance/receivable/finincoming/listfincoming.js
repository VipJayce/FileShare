_$(document).ready(function(){
    _$("input[type='checkbox']").live('click', function(){
        $id("dcListIncoming").isModefied = false;
    });
    
});

function query() {
    $id("dcListIncoming").reload();
}

/**
 * 点击全选按钮
 * @param {} item
 */
function checkAll(item) {
    if (_$(item).attr("checked")) {
        changeEntityChk(true);
        _$(":checkbox").attr("checked", true);
    } else {
        changeEntityChk(false);
        _$(":checkbox").attr("checked", false);
    }
}

/**
 * 改变datacell中的chk的值
 * @param {} flag
 */
function changeEntityChk(flag) {
    var dc1 = $id("dcListIncoming").dataset;
    var values = dc1.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}

/**
 * 选择行后返回ids
 */
function selectIds() {
    var myids = "";
    var dc = $id("dcListIncoming");
    var ds = dc.dataset;
    var flag = true;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            if (entity.getValue("claim_status_bd") != "1") {
                flag = false;
                return false;
            }
            myids += entity.getValue("id") + ",";
        }
    });
    
    var last = myids.substring(myids.length-1, myids.length);
    if (last == ",") {
        myids = myids.substring(0, myids.length-1);
    }
    
    var retArr = new Array();
    retArr[0] = flag;
    retArr[1] = myids;
    return retArr;
}


/**
 * 删除到款记录
 */
function delIncom() {
	var dc = $id("dcListIncoming");
	if(!confirm("确定要删除吗？")){
        return false;
    }
	
	var arr =  selectIds();
	var flag = arr[0];
	var myids = arr[1];
	
	if (!flag) {
		alert("已认领的到款不能删除。");
        return false;
	}
	
	if (!myids) {
		alert("请选择一条记录！");
		return false;
	}
	
	_$("#ids").val(myids);
	dc.isModefied = true;
	dc.submitAction = venusbase + "/FININCOMINGAction.do?cmd=deleteMulti";
	if (dc.submit()) {
	   alert("删除成功。");
	} else {
	   alert("删除失败。");
	}
	
}



    
/**
 * 修改到款
 */
function editIncom() {
	var arr =  selectIds();
    var flag = arr[0];
    var myids = arr[1];
    
    if (!flag) {
        alert("已认领的到款不能修改。");
        return false;
    }
    
    if (!myids) {
        alert("请选择一条记录！");
        return false;
    }
    
    var myidArr = myids.split(",");
    if (myidArr.length > 1) {
    	alert("只能选择一条记录！");
    	return false;
    }
    
	var url = venusbase + "/FININCOMINGAction.do?cmd=find&id=" + myids;
    showModalCenter(url, "", editIncom_callback, "800", "200", "修改到款");
}

/**
 * 修改到款回调函数
 * @param {} retVal
 */
function editIncom_callback(retVal) {
     var dc = $id("dcListIncoming");
     dc.reload();
}


/**
 * 弹出上传到账信息的页面
 */
function showUploadincomPage() {
	var url = venusbase + "/jsp/faerp/finance/receivable/finincoming/uploadExcel.jsp";
    showModalCenter(url, "", showUploadincomPage_callback, "600", "400", "上传到账信息");
}

/**
 * 弹出上传到账信息的页面后的回调函数
 */
function showUploadincomPage_callback () {
	var dc = $id("dcListIncoming");
    dc.reload();
}

/**
 * 弹出显示上传到款信息时的异常数据
 */
function showUploadException() {
	var url = venusbase + "/Fin_upload_excAction.do?cmd=showPage";
    showModalCenter(url, "", showUploadincomPage_callback, "1000", "430", "上传到款时的异常信息");
}

function test4jdbcandproc() {
	showProgressBar();
	_$.ajax({
            type : "post",
            url : venusbase + "/FinclaimAction.do?cmd=test4jdbcandproc",
            data : _$("form").serialize(),
            dataType : "html",
            success : function(data) {
                if (data) {
                    alert(data);
                }
                hideProgressBar();
            }
        });
    
}


function toAdd_onClick(){
	var url = venusbase +  "/jsp/faerp/finance/receivable/finincoming/insertFincoming.jsp";
	showModalCenter(url, "", showUploadincomPage_callback, "800", "210", "手动添加到款信息");
}

