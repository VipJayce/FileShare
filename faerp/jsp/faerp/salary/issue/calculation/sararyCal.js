/**
 * 薪资计算list的JS
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

function clz_rtnFunc(arg){
    var lookup = $id("sa_class_id");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    //_$("#h_salary_class_id").val(arg[0]);        
    return false;
}

/**
 * batchList页面点击查询按钮
 */
function listquery() {
   $id("batchListdatacell").reload();
}

/**
 * 点击 生成发放数据 按钮
 */
function showIssuePage() {
	/*
	var dc = $id("batchListdatacell");
	var entity = dc.getActiveEntity();
    if(!entity){
        alert("请先选择一条记录");
        return ;
    }
    */
	var h_salary_class_id = _$("#sa_class_id_hidden").val();
	if (!h_salary_class_id) {
		alert("请选择薪资类别");
		return false;
	}
	_$.ajax({
       type: "POST",
       //得到最近的一次工资批次
       url: venusbase + "/SalarybatchAction.do?cmd=getLasttimeVoBySalaryclassid",
       data: _$("#datacell_formid").serialize(),
       dataType: "html",
       success: function(msg){
           	if (msg) {
           		//如果有提示，表示没有最近的发放工资
           		alert(msg);
           	} else {
           		var url = venusbase + '/jsp/faerp/salary/issue/calculation/crarteIssuedata.jsp';
                showModalCenter(url, h_salary_class_id, showIssuePage_callBack, 500, 300, "<fmt:message key='button_scffsj'/>");
           	}
        }
    });
	
	
}

function closeIssuePage(param) {
	if (param == '1') {
		if (_$("#pay_name").val() == '') {
			alert("请输入发放名称");
			return false;
		}
		if ($id("pay_year_month").value == null || $id("pay_year_month").value == '') {
			alert("请输入工资所属年月");
			return false;
		}
		if ($id("tax_month").value == null || $id("tax_month").value == '') {
            alert("请输入工资计税年月");
            return false;
        }
        if ($id("bill_year_month").value == null || $id("bill_year_month").value == '') {
        	alert("请输入工资账单年月");
        	return false;
        }
        createdata();
	} else {
        window.close();
	}
	
}

/**
 * 计算  生成发放数据
 * //ajax提交，生成完成后，返回页面，并刷新datacell
 * @param {} retval
 */
function createdata () {
	_$.ajax({
       type: "POST",
       url: venusbase + "/SalarybatchAction.do?cmd=createIssueData",
       data: _$("#createissuedataform").serialize(),
       dataType: "html",
       success: function(msg){
         alert(msg);
         window.close();
       }
    });
}


function showIssuePage_callBack (retVal) {
	$id("batchListdatacell").reload();
}

/**
 * 对多选框的提示提示
 */
function selectCount() {
	var count = 0;
    _$("input[name='checkbox_template']").each(function(i){
       if (_$(this).attr("checked")) {
          count ++;
       }
    });
    return count;
}

function delayStateExmportTpl() {
	
	window.location = venusbase + "/DatainterfaceAction.do?cmd=downLoadDelayImportTpl"
	
}

/**
 * 缓发状态批量修改
 * yangxu
 */
function delayStateImport() {
    var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录");
        return false;
    }
    var entity=entity_re[1];
    var batch_id = entity.getValue("id");
    var customer_id = entity.getValue("customer_id");
    if(!customer_id){
    	alert('客户ID为空。');
    }
 //   if (entity.getValue("pps_batch_id") == '是') {
  //      alert("由PPS导入的数据不能再修改。");
  //      return false;
   // }
    
    if (entity.getValue("is_verify") == '是') {
        alert("确认后的数据不能再修改。");
        return false;
    }
    //提交审核的也不能修改
    //如果薪资批次的审核申请状态为未申请或已申请了，但被驳回了，才可以提交财务审核
    //审核申请状态：0：未申请 1：已申请
    //审核状态：0：待审核 1：已通过　2：未通过（驳回）3：已完成
    if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '0') {
        alert("此薪资批次已提交，正待审核。");
        return false;
    } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '1') {
        alert("此薪资批次已通过审核。");
        return false;
    } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '3') {
        alert("此薪资批次已完成审核。");
        return false;
    } else if (entity.getValue('apply_state') == '0' || 
              (entity.getValue('apply_state') == '1' && 
               entity.getValue('audit_state') == '2')) {
//        showProgressBar();
//        var queryString = _$("form").serialize();
//        url = venusbase + "/SalarybatchAction.do?cmd=list2item&forward_type=1&batch_id=" + batch_id + "&" + queryString;
//        //window.location.href = url;
//        window.open(url,'','height=500px,width=1200px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
               	
               	//yangxu
               	//alert('daochu ')
               	var sa_inf_id = 0;
               	var salary_class_id = 0;
               	url="/FAERP/jsp/faerp/salary/datainterface/importDelayStateData.jsp?batch_id="+batch_id+"&customer_id="+customer_id+"&random="+Math.random();
	       		showModalCenter(url, window, callBack, 640, 310, "<fmt:message key='input_data'/>");  //增加子岗位
               	
               	
               	
               	
    } else {
        alert("此薪资批次审核状态异常。");
        return false;
    }
    
    
}
function callBack(reg){
        //alert("操作完成！");
    if(reg){
    	if(reg[0] && reg[1]){
    		$id("batchId").value=reg[0];
    		$id("pay_name").value=reg[1];
    	}
    }
    
    $id("dc_inter").loadData();
    $id("dc_inter").refresh();
}
    
    
/**
 * 编辑数据
 */
function editdata() {
    var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录");
        return false;
    }
    var entity=entity_re[1];
    var batch_id = entity.getValue("id");
    
    if (entity.getValue("pps_batch_id") == '是') {
        alert("由PPS导入的数据不能再修改。");
        return false;
    }
    
    if (entity.getValue("is_verify") == '是') {
        alert("确认后的数据不能再修改。");
        return false;
    }
    //提交审核的也不能修改
    //如果薪资批次的审核申请状态为未申请或已申请了，但被驳回了，才可以提交财务审核
    //审核申请状态：0：未申请 1：已申请
    //审核状态：0：待审核 1：已通过　2：未通过（驳回）3：已完成
    if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '0') {
        alert("此薪资批次已提交，正待审核。");
        return false;
    } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '1') {
        alert("此薪资批次已通过审核。");
        return false;
    } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '3') {
        alert("此薪资批次已完成审核。");
        return false;
    } else if (entity.getValue('apply_state') == '0' || 
              (entity.getValue('apply_state') == '1' && 
               entity.getValue('audit_state') == '2')) {
        //showProgressBar();
        var queryString = _$("form").serialize();
        url = venusbase + "/SalarybatchAction.do?cmd=list2item&forward_type=1&batch_id=" + batch_id + "&" + queryString;
        //window.location.href = url;
        window.open(url,'','height=500px,width=1200px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
    } else {
        alert("此薪资批次审核状态异常。");
        return false;
    }
    
    
}


/**
 * 缓发数据
 * 2014-04-16
 * 吴敬磊
 */
function delayData() {
    var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录");
        return false;
    }
    var entity=entity_re[1];
    var batch_id = entity.getValue("id");
    
    if (entity.getValue("is_verify") == '是') {
        alert("确认后的数据不能再缓发。");
        return false;
    }
    //提交审核的也不能修改
    //如果薪资批次的审核申请状态为未申请或已申请了，但被驳回了，才可以提交财务审核
    //审核申请状态：0：未申请 1：已申请
    //审核状态：0：待审核 1：已通过　2：未通过（驳回）3：已完成
    if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '0') {
        alert("此薪资批次已提交，正待审核。");
        return false;
    } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '1') {
        alert("此薪资批次已通过审核。");
        return false;
    } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '3') {
        alert("此薪资批次已完成审核。");
        return false;
    } else if (entity.getValue('apply_state') == '0' || 
              (entity.getValue('apply_state') == '1' && 
               entity.getValue('audit_state') == '2')) {
        //showProgressBar();
        var queryString = _$("form").serialize();
        url = venusbase + "/SalarybatchAction.do?cmd=list2item&forward_type=3&batch_id=" + batch_id + "&" + queryString;
        //window.location.href = url;
        window.open(url,'','height=500px,width=1200px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
    } else {
        alert("此薪资批次审核状态异常。");
        return false;
    }
    
    
}


/**
 * 删除一个批次信息
 */
function deldata() {
	if(!confirm("您确定要删除吗?")) {  
         return false;  
    }
    var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录");
        return false;
    }
    var entity=entity_re[1];
    if(entity.getValue("pay_state") == '1' && entity.getValue("apply_pay_state") =='1'){
        alert("该薪资批次已发放，无法删除!");
        return ;
    }
    
    //apply_state 审核申请状态：0：未申请 1：已申请 
    //AUDIT_STATE 审核状态：0：待审核 1：已通过　2：未通过（驳回）3：已完成
    if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '0') {
        alert("此薪资批次已提交，正待审核。");
        return false;
    } else if ((entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '1') || (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '3') || (entity.getValue("is_verify") == '是')) {
    
        //删除审核状态
        var dState = entity.getValue("delete_verify_state");
        if(dState == 0){
            alert("该薪资已提交删除审核,不能再次提交!");
            return ;
        }else if(dState ==1){
            alert("该薪资正在等待财务部门审核,不能再次提交!");
            return;
        }else if(dState ==2){
            alert("该薪资已被驳回,不能再次提交!");
            return;
        }
        //对薪资关联的账单进行相关验证  add by whj 2015-01-08
        var verify_flag = true;
        _$.ajax({
                       type: "POST",
                       url: venusbase +"/SalarybatchAction.do?cmd=verifySalaryBatchBill&id=" +entity.getValue("id"),
                       data:"",
                       dataType: "html",
                       async:false,
                       success: function(msg){
	                         if(msg != "" && msg != null && msg != "null"){
	                            if(msg.substring(0,1) == 5){
                                    //未红冲 邮件通知AR
                                   if(confirm("该批次对应账单数据财务已入账，是否邮件通知财务AR组取消入账！")){
                                           _$.ajax({
                                                type : "post",
                                                url : venusbase + "/FinbillAction.do?cmd=sendEmailToARTeam&bill_id=" + msg.substring(2),
                                                dataType : "html",
                                                success : function(data) {
                                                                       alert(data);
                                                                 }
                                        });
                                     }
                                }else{
                                     alert(msg);
                                }
                                verify_flag = false;
	                       }
                       }
        });
        if(verify_flag == false){
            return false;
        }
        //对于已确认的薪资  当审核状态为空 可以发起删除审核
        if(dState =="" || dState== null){
            showModalCenter(venusbase+"/SalarybatchAction.do?cmd=toDeleteRemarks&batchId=" + entity.getValue("id"),null,freshdc,600,200,"删除原因");
        }
        
    } else if (entity.getValue('apply_state') == '0' || 
       (entity.getValue('apply_state') == '1' && 
        entity.getValue('audit_state') == '2')) {
        var datacell = $id("batchListdatacell");
        _$.ajax({
           type: "POST",
           url: venusbase + "/SalarybatchAction.do?cmd=deleteById&id=" + entity.getValue("id"),
           data: _$("#datacell_formid").serialize(),
           dataType: "html",
           success: function(msg){
             if (msg && msg == '1') {
                alert("删除成功。");
                datacell.reload();
             } else {
                alert("删除失败。");
             }
           }
        });
    } else {
    	alert("此薪资批次审核状态异常。");
    }
}

//填写原因后执行的方法
function freshdc(retVal){
    _$.ajax({
                   type: "POST",
                   url: venusbase +"/SalarybatchAction.do?cmd=deleteVerifySalaryBatch&id=" + retVal[0]+"&remarks="+encodeURI(retVal[1]),
                   data:"",
                   dataType: "html",
                   success: function(msg){
                         alert(msg);
                         $id("batchListdatacell").reload();
                         $id("batchListdatacell").refresh();
                   }
     });
}

/**
 * 明细数据
 */
function toitemdata() {
	var entity_re = getSelectedEntity();
	if (entity_re[0]==0) {
        alert("请先选择一条记录");
        return false;
    }
    if(entity_re[0]>1){
    	 alert("只能选择一条记录");
        return false;
    }
    var entity=entity_re[1];
    var batch_id = entity.getValue("id");
    var queryString = _$("form").serialize();
    url = venusbase
            + "/SalarybatchAction.do?cmd=list2item&forward_type=2&batch_id="
            + batch_id + "&" + queryString;
    //alert(url);
    //window.location.href = url;
    window.showModalDialog (url,"","location:No;status:No;help:No;dialogWidth:1200px;dialogHeight:600px;scroll:yes;resizable:yes;");
    //window.open(url,'','height=500px,width=1200px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增报价单');
}

/**
 * 获取当前选中的entity 
 * modify by sqp 现在页面因需求变更 增加了checkbox，所以此方法修改  2014年6月18日
 * @return {}
 */
function getSelectedEntity(){
	//var dc = $id("batchListdatacell");
    //var entity = dc.getActiveEntity();
    //return entity;
	
	//有checkbox的情况
	var entity = null;
	var count = 0;
	var datacell = $id("batchListdatacell");
	_$("input[type='checkbox']").each(function (i){
	   if (i != 0 &&_$(this).attr("checked")) {
         var row = datacell.table.tBodies[0].rows[i-1];
         entity = datacell.getEntity(row);
	   	 count++;
	   	 if (count > 1) {
	   	 	return;
	   	 }
	   }
	});
	var arr = new Array();
	arr[0] = count;
	arr[1] = entity;
    return arr;
   
}

