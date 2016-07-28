/**
 * 薪资计算list和薪资计算detail的公用JS
 * 用于"确认"和"提交财务审核"两个功能
 */
_$(document).ready(function() {
    //文件无密码，隐藏密码框
    if (_$("#rblPassWord_0")) {
        _$("#rblPassWord_0").click(function(){
          _$("#div1").hide();
        });
    }
    //文件有密码，显示密码框
    if (_$("#rblPassWord_1")) {
        _$("#rblPassWord_1").click(function(){
          _$("#div1").show();
        });
    }
});


/**
 * 数据确认
 * type 1 列表上的确认，2编辑页面上的确认
 * datacellid datacell的名字
 */
function affirm(type) {
    if (type == '1') {
    	
    } else {
        if(!confirm("您保存了吗?")) {
            return false;  
        }
    }
    
    
    if(!confirm("您确定要确认吗?")) {
         return false;  
    }
    var is_verify = "";
    var id = "";
    //审核申请状态
    var apply_state = "";
    //审核状态
    var audit_state = "";
    var dc = null;
    if (type == "1") {
        dc = $id("batchListdatacell");
        /*
         var entity = dc.getActiveEntity();
          if (!entity) {
            alert("请选择一条数据。");
            return false;
        }
        */
    var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录!");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录!");
        return false;
    }
    var entity=entity_re[1];
        if (entity.getValue("pps_is_export") == '1'){
        	alert("部份导入的PPS薪资数据不能进行数据确认操作。");
            return false;
        }
        
      
        if (entity.getValue("is_verify") == '是') {
            alert('此条数据已确认，不能再操作。');
            return false;
        }
        apply_state = entity.getValue('apply_state');
        audit_state = entity.getValue('audit_state');
        is_verify = entity.getValue('is_verify');
        id = entity.getValue("id");
    } else {
        apply_state = _$("#h_apply_state").val();
        audit_state = _$("#h_audit_state").val();
        is_verify = _$("#h_is_verify").val();
        id = _$("#batch_id").val();
    }
    
    //APPLY_STATE 审核申请状态：0：未申请 1：已申请  
    //AUDIT_STATE 审核状态：0：待审核 1：已通过　2：未通过（驳回）3：已完成
    //注意，如果这里的判断条件改变，ACTION中也要改变(在ACTION中做了后台校验，防止用户
    //跳过前端JS校验)
    //alert(is_verify + " " + apply_state + " " + audit_state);
    var message = checkState(is_verify, apply_state, audit_state);
    if (message) {//message不为空，则提示错误信息，并返回
        alert(message);
        return false;
    }
    
    //客服确认时 提示确认的薪资批次有多少人属于大库报税
    var flag = true;
     _$.ajax({
	     type: "POST",
	     async: false,//同步后再执行后面的js
	     url: venusbase + "/SalarybatchAction.do?cmd=notifyTaxData&id=" + id,
	     dataType: "html",
	     success: function(msg){
	        if (parseInt(msg)>0) {
	             if(!confirm("该薪资批次共有"+msg+"笔明细记录属于FA大库报税，是否继续确认！")){
	                 flag =  false;
	             }
	        }
	     }
    });
    
    if(flag == false){
        return;
    }
    showProgressBar();
    _$.ajax({
       type: "POST",
       url: venusbase + "/SalarybatchAction.do?cmd=batchVerify&id=" + id,
       //data: _$("#datacell_formid").serialize(),
       dataType: "html",
       success: function(msg){
         if (msg && msg == '1') {
            hideProgressBar();
            alert("确认成功。");
            if (type == '1') {
                dc.reload();
            } else {
                window.location.href = venusbase + "/SalarybatchAction.do?cmd=leftbar2list";
            }
         } else {
            hideProgressBar();
            alert(msg);
         }
       }
    });
    
}

/**
 * 提交财务审核
 */
function approval2fin(type) {
    var entity = null;
    var is_verify = "";
    var apply_state = "";
    var audit_state = "";
    var id = "";
    
    if (type == '1') {
        dc = $id("batchListdatacell");
    var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录!");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录!");
        return false;
    }
    var entity=entity_re[1];
    if (entity.getValue("pps_is_export") == '1'){
                alert("部份导入的PPS薪资数据不能进行数据确认操作。");
                return false;
        }
        
        checkMoneyServer(entity,type);
    } else {
        //修改薪资数据页面里的数据确认
        is_verify = _$("#h_is_verify").val();
        apply_state = _$("#h_apply_state").val();
        audit_state = _$("#h_audit_state").val();
        id = _$("#batch_id").val();
        if(!confirm("您保存了吗?")) {
            return false;  
        }
        checkMoneyServer(null,type,is_verify,apply_state,audit_state,id);
    }
    
    
}
/**
 * 后台验证实发合计是否有效
 */
function checkMoneyServer(entity,type,p_is_verify,p_apply_state,p_audit_state,p_batch_id){
    var is_verify = entity?entity.getValue("is_verify"):p_is_verify;
    var apply_state = entity?entity.getValue('apply_state'):p_apply_state;
    var audit_state = entity?entity.getValue('audit_state'):p_audit_state;
    var batch_id = entity?entity.getValue("id"):p_batch_id;
    _$.post(venusbase + "/SalarybatchAction.do?cmd=checkTotalTaxAmount&batchId=" + batch_id,function(msg){
        if(eval(msg)){
            var message = checkState(is_verify, apply_state, audit_state);
            if (message) {
                alert(message);
                return false;
            } else {
                showApproval2fin(batch_id, type);
            }
        }else{
            alert("所有员工的实发合计及扣税合计均为0！");
        }
    })
}

/**
 * 校验此薪资批次是否可以确认，以及提交财务审核
 * //如果薪资批次的审核申请状态为未申请或已申请了，但被驳回了，才可以提交财务审核
 * @param {} is_verify
 * @param {} apply_state 
 * @param {} audit_state
 */
function checkState(is_verify, apply_state, audit_state) {
    var message = "";
    if (is_verify == '1' || is_verify == '是') {
        message = "此条数据已确认，不能提交审核。";
        return message;
    }
    if (apply_state == '0'
    || (apply_state == '1' && audit_state == '2')) {
        //正常CASE
    } else if (apply_state == '1' && audit_state == '0') {
        message = '此薪资批次已提交，正待审核。';
    } else if (apply_state == '1' && audit_state == '1') {
        message = '此薪资批次已通过审核。';
    } else if (apply_state == '1' && audit_state == '3') {
        message = '此薪资批次已完成审核。';
    } else {
        message = '此薪资批次审核状态异常。';
    }
    return message;
}
/**
 * 检查每一行的实发是否大于0
 */
function checkMoney(){
    var dc = $id("itemdatacell");
    var rc = dc.dataset.getLength();
    var entities = dc.dataset.values;
    for(var i=0;i<rc;i++){
        var entity = entities[i];
        //实发
        var def3 = entity.getProperty("def3");
        var emp = entity.getProperty("emp_name");
        if(def3<=0){
            return "员工："+emp+" 实发合计小于等于0！不能提交审核";
        }
    }
    return "";
}



/**
 * 弹出提交页面
 */
function showApproval2fin(batch_id, type) {
    //后台验证
    
    _$.ajax({
        type : "post",
        url : venusbase + "/SalarybatchAction.do?cmd=checkMessage&batch_id=" + batch_id,
        dataType : "html",
        success : function(data) {
            if (data && data != null && data != 'null') {
                alert(data);
            } else {
                var url = venusbase + "/SalarybatchAction.do?cmd=showApproval2fin&batch_id=" + batch_id + "&type=" + type;
                showModalCenter(url, "", showApproval2fin_callBack, 900, 450, "提交财务审核");
            }
        }
    });
}


/**
 * 提交页面点击提交按钮后  到 action
 */
function subAudit(type) {
    if (!_$("#attachNameInput").val()) {
        alert('请上传文件。');
        return null;
    }
    if (!_$("#attackAddressInput").val()) {
        alert('上传文件地址有误。');
        return null;
    }
    if (!_$("#e_tax_list").val()) {
        alert('单位承担税收的名单不能为空。');
        return null;
    }
    if (!_$("#rblPassWord_0").attr("checked") && _$("#rblPassWord_1").attr("checked")) {
        if (!_$("#file_pwd").val()) {
            alert('请输入密码。');
            return null;
        }
    }
    if (!_$("#e_fund_list").val()) {
        alert('单位承担四金的名单不能为空。');
        return null;
    }
    if (!_$("#emp_differ_list").val()) {
        alert('人数差异名单不能为空。');
        return null;
    }
    if (!_$("#only_tax_list").val()) {
        alert('只报税的名单不能为空。');
        return null;
    }
    if (!_$("#emp_differ_cause").val()) {
        alert('人数差异原因不能为空。');
        return null;
    }
    if (!_$("#alien_list").val()) {
        alert('外籍人员名单不能为空。');
        return null;
    }
    if (!_$("#sum_differ_list").val()) {
        alert('金额差异名单不能为空。');
        return null;
    }
    if (!_$("#other_cause").val()) {
        alert('其他特殊情况不能为空。');
        return null;
    }
    if (!_$("#sum_differ_cause").val()) {
        alert('金额差异原因不能为空。');
        return null;
    }
    _$.ajax({
       type: "POST",
       url: venusbase + "/SalarybatchAction.do?cmd=submitAudit",
       data: _$("#submitAuditform").serialize(),
       dataType: "html",
       success: function(msg){
         if (msg > 0) {
            alert("提交成功！您的前面还有"+msg+"个待审核的批次！");
            window.returnValue = type;
            window.close();
         } else if(msg <= 0){
            alert("提交成功！您的前面暂无待审核的批次！");
            window.returnValue = type;
            window.close();
         }
       }
    });
}

/**
 * showApproval2fin的回调函数
 */
function showApproval2fin_callBack(retVal) {
    //刷新页面
    if (retVal == '1') {
        $id("batchListdatacell").reload();
    } else {
        window.location.href = venusbase + "/SalarybatchAction.do?cmd=leftbar2list";
    }
}
