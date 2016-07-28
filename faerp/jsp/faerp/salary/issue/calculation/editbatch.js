/**
 * 编辑页面JS
 */
var nologin = "未登录或登录已退出。";
_$(document).ready(function() {
    var dc = $id("itemdatacell");
    if (dc) {
        dc.beforeRefreshCell = function(cell,field){
            if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
                return false;
            }
            return true;
        }
        //更新合计
        dc.onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
            refreshTotalMoney(activeCell,newValue);
        }
    }
});
//刷新合计
function refreshTotalMoney(activeCell,newValue){
    var cellIdx = activeCell.cellIndex;
    var dc = $id("itemdatacell");
    var rowNo = dc.activeRow.rowIndex;
    var rc = dc.dataset.getLength();
    var datas = dc.dataset.values;
    var totalMoney = 0;
    //遍历时排除合计行
    for(var i=0; i<rc-1; i++){
        var cell = dc.getCell(i,cellIdx);
        var cellVal = dc.getCellValue(cell);
        if(i == rowNo){
            cellVal = newValue;
        }
        totalMoney = parseFloat(totalMoney) + parseFloat(cellVal);
    }
    var totalCell = dc.getCell(rc-1,cellIdx);
    dc.setCellValue(totalCell,totalMoney); 
}

//给多选框填入员工ID
function setCheckboxStatus(value, entity, rowNo, cellNo){
    var dc = $id("itemdatacell");
    var str = "<input type='checkbox' name='checkbox_template' value=" + entity.getProperty("emp_id") + ">";
    if(dc.dataset.getLength()-1 == rowNo){
        str = "";
    }
   return str;
}

/**
 * 得到打钩的账单数据_上边一条BUTTON
 * @return {Boolean}
 */
function getbillitem() {
    var is_si = $id("h_is_si").value;
    if(is_si==0){
        alert("薪资初始化时 “是否获取社保数据” 设置的为“ 不获取”！");
        return false;
    }
    var flag = false;
    _$("input[name='checkbox_template']").each(function(i){
       if (_$(this).attr("checked")) {
           flag = true;
           return false;
       }
    });
    if (!flag) {
        alert('请至少选择一条记录。');
        return false;
    }
    getbillitem_sub();
}

/**
 * 得到所有人的账单数据_下边一条BUTTON
 */
function getbillitem_all() {
    var is_si = $id("h_is_si").value;
    if(is_si==0){
        alert("薪资初始化时 “是否获取社保数据” 设置的为“ 不获取”！");
        return false;
    }
    _$("input[name='checkall']").attr("checked", true);
    _$("input[name='checkbox_template']").attr("checked", true);
    getbillitem_sub();
}

/**
 * 得到账单数据的子方法
 */
function getbillitem_sub() {
    showProgressBar();
    var dc = $id("itemdatacell");
    var xmlSubmit = dc.dataset.toString();
    var myAjax = new Ajax(venusbase + "/SalarydataAction.do?cmd=getBillitemByEmpid");
    var form = $id("datacell_formid");
    if(form){
        for(var i=0;i<form.elements.length;i++){
            var elem = form.elements[i];
            if(elem.name){
                myAjax.addParam(elem.name, getElementValue(elem) );
            }
        }
    }
    myAjax.submitXML(xmlSubmit, 'UTF-8');
    var rtnDom = myAjax.getResponseXMLDom();
    var retVal = myAjax.getValue("root/data/returnValue");
    var msg = myAjax.getValue("root/data/returnMessage");
    if (retVal == '1') {
        var billitemSecurity = Dataset.create(rtnDom, "root/data/BillitemSecurity", "billitemSecurity");
        if (billitemSecurity) {
            for (var i=0; i<billitemSecurity.getLength(); i++) {
                var securityEn = billitemSecurity.get(i);
                var dcEntity = dc.dataset.findEntity("emp_id", securityEn.getProperty("employee_id"));
                //把security的值放到entity上
                dcEntity.setProperty("def36", securityEn.getProperty("def36"));//社保基数
                dcEntity.setProperty("def35", securityEn.getProperty("def35"));//养老自付
                dcEntity.setProperty("def34", securityEn.getProperty("def34"));//医疗自付
                dcEntity.setProperty("def33", securityEn.getProperty("def33"));//失业自付
                dcEntity.setProperty("def32", securityEn.getProperty("def32"));//公积金基数
                dcEntity.setProperty("def31", securityEn.getProperty("def31"));//公积金自付
                dcEntity.setProperty("def30", securityEn.getProperty("def30"));//个人社保总计
                dcEntity.setProperty("def29", securityEn.getProperty("def29"));//补充公积金(企业部分)
                dcEntity.setProperty("def25", securityEn.getProperty("def25"));//补充公积金(个人部分)
                dcEntity.setProperty("e_fund_money", securityEn.getProperty("e_fund_money"));//公积金企业付
                dcEntity.setProperty("def48", securityEn.getProperty("def48"));//年终奖扣税
                dcEntity.setProperty("def49", securityEn.getProperty("def49"));//风险金
                dcEntity.setProperty("def50", securityEn.getProperty("def50"));//应缴税额
                dcEntity.setProperty("def51", securityEn.getProperty("def51"));//减免税额
                //如果不手动获取账单，那么"公积金企业付"就得不到，当然，如果salaryData中放了公积金企业付这个字段
                //那么就不再需要一定要手动获取账单了。
            }
            //datacell更新entity后，需要手动刷新下row
            for(var j=0; j< dc.tbody.rows.length; j++){
                dc.refreshRow(dc.getRow(j));
            }
            hideProgressBar();
            alert(msg);
        }
    } else {
        if (msg != null && msg != "" && msg != 'null' ) {
            hideProgressBar();
            alert(msg);
        } else {
            hideProgressBar();
        }
    }
}

/**
 * 删除一个薪资数据
 */
function stopitem() {
    if(!confirm("是否删除?")) {
         return false;  
    }
    var dc = $id("itemdatacell");
    var ds = dc.dataset;
    var all_add_emp = _$("#new_add_emp").val();
    var all_add_emp_s = new Array();
    if (all_add_emp) {
        all_add_emp_s = all_add_emp.split(",");
        //alert(all_add_emp_s);
    }
    _$.ajax({
       type: "POST",
       url: venusbase + "/SalarydataAction.do?cmd=stopByEmpIdAndBatchId",
       data: _$("#datacell_formid").serialize(),
       dataType: "html",
       success: function(msg){
         if (msg && msg == '1') {
            _$("input[name='checkbox_template']").each(function(i){
                if (_$(this).attr("checked")) {
                    ds.removeEntity(ds.findEntity("emp_id", _$(this).val()), true);
                    all_add_emp_s.pop(_$(this).val());
                }
            });
            _$("#new_add_emp").val(all_add_emp_s);
            dc.reload();
            alert("删除成功。");
         } else {
            //if (msg) {
            //  alert(msg);
            //} else {
                alert('删除失败。');
            //}
         }
       }
    });
}


/**
 * 点击增加雇员信息按钮，弹出添加窗口
 */
function showAddempPage() {
    var sa_class_id = _$("#h_sa_class_id").val();
    var batch_id = _$("#h_sa_batch_id").val();
    var url = venusbase + "/SalarydataAction.do?cmd=toAddEmpPage" +
            "&sa_class_id=" + sa_class_id + "&batch_id=" + batch_id +
            "&new_add_emp=" + _$("#new_add_emp").val();
    showModalCenter(url, "", showAddempPage_callBack, 500, 455, "添加雇员薪资数据");
}

/**
 * 关闭添加雇员窗口时的动作，用于返回到父页面
 */
function select_onClick(){
    var arrEntity = choose_row("emplistcelllist");
    var returnAry = new Array();
    for(var i=0; i<arrEntity.length; i++) {
        returnAry[i] = arrEntity[i];
    }
    window.returnValue = returnAry;
    window.close();
}

function choose_row(dcId){
    dc = $id(dcId);
    var arr = new Array();
    var rows = dc.table.tBodies[0].rows;
    var count = 0;
    for (var i=0; i<rows.length; i++){
        var row = rows[i];
        var entity = dc.getEntity(row);
        if (entity.getValue("chk") == "1") {
            arr[count] = entity;
            count++;
        }
    }
    return arr;
}

function showAddempPage_callBack(value){
    //添加增加的员工，而不要刷新整个datacell，因为有可能已经对薪资数据做了修改而又未保存
    var dc = $id("itemdatacell");
    var payyearmonth = _$("#h_bill_year_month").val();
    var sa_class_id = _$("#h_sa_class_id").val();
    var sa_batch_id  = _$("#h_sa_batch_id").val();
    var h_salary_class_id = _$("#h_sa_class_id").val();
    //var sa_doc_id 薪资档案需从value中取 
    for(var i=0; i<value.length; i++) {
       //alert(value[i].getValue("id") + " " + value[i].getValue("emp_code") + " " + value[i].getValue("emp_name"));
       var entity = dc.styleEntity.clone(true);
       entity.setValue("emp_code", value[i].getValue("emp_code"));
       entity.setValue("emp_name", value[i].getValue("emp_name"));
       entity.setValue("emp_id", value[i].getValue("id"));
       entity.setValue("pay_year_month", payyearmonth);
       entity.setValue("sa_class_id", sa_class_id);
       entity.setValue("sa_batch_id", sa_batch_id);
       entity.setValue("sa_doc_id", value[i].getValue("sa_doc_id"));
       entity.setValue("is_foreigner", value[i].getValue("is_foreigner"));
       entity.setValue("salary_class_id", h_salary_class_id);
       entity.setValue("stop_flag", value[i].getValue("stop_flag"));
       entity.setValue("is_postpone", value[i].getValue("is_postpone"));
       entity.setValue("is_email", value[i].getValue("is_email"));
       //alert(entity.getValue("salary_class_id"));
       entity.setValue("addnew", '1');
       var rc = dc.dataset.values.length;
       //添加员工到倒数第二行
       var row = dc.insertRow(entity,rc-1);
       //添加左边的checkbox控件
       var field = dc.fields[0];
       var cellText;
       if (field.onRefreshFunc){
           if (typeof(field.onRefreshFunc) == "string"){
               field.onRefreshFunc = eval(field.onRefreshFunc);
           }
           cellText = field.onRefreshFunc("", entity, 0, 0, null);
           row.cells[0].firstChild.innerHTML = cellText;
       }
       dc.refreshRow(row);
       //添加新行后，会默认进入在第一个cell里，并edit，加这句就不不再显示edit状态
       dc.activeField.editor.hideEditor();
       var addemp = "";
       if (!_$("#new_add_emp").val()) {
           addemp = value[i].getValue("id");
       } else {
           addemp = _$("#new_add_emp").val() + "," + value[i].getValue("id");
       }
       _$("#new_add_emp").val(addemp);
    }
}

function searchEmp() {
    $id("emplistcelllist").reload();
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
    var dc1 = $id("emplistcelllist").dataset;
    var values = dc1.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}


/**
 * 保存按钮
 * @param {} flag
 */
function saveSelect(flag) {
    showProgressBar();
    calOrSave(flag, "saveSalaryData", 2);
    hideProgressBar();
}


/**
 * 计算或者保存
 * @param {} 1，上面的button，只处理打钩的数据，2，下面的button，先全部打钩，然后再做处理
 * @param {} funName
 * @param {} procFlag 处理类型，1为计算薪资，2为保存
 * @return {Boolean}
 */
function calOrSave(flag, funName, procFlag){
    if (flag == "1") {
        //保存选中
        if (_$("input[name='checkall']").attr("checked") && _$(":checked").length == 1) {
           alert('请选择一条记录');
           return false;
        }
        if (_$(":checked").length == 0) {
            alert('请选择一条记录');
           return false;
        }
    } else {
        //全部保存
        _$("input[name='checkall']").attr("checked", true);
        _$("input[name='checkbox_template']").attr("checked", true);
    }
    
    var dc = $id("itemdatacell");
    if (procFlag == '1') {
        var calflag = true;
        _$(".eos-body-div input[name='checkbox_template']").each(function(i){
            if (_$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                entity = dc.getEntity(row);
                if (entity.getValue("def30") == null || entity.getValue("def30") == '') {
                    calflag = false;
                    return false;
                }
            }
        });
        if (!calflag) {
            if (!confirm("还有未获取账单的数据，如果此时计算薪资，\r\n\r\n在有补充公积金的情况下，会造成扣税不准确。\r\n\r\n是否继续？")) {
                return false;
            }
        }
    }
    showProgressBar();
    var xmlSubmit = dc.dataset.toString();
    var myAjax = new Ajax(venusbase + "/SalarydataAction.do?cmd=" + funName);
    var form = $id("datacell_formid");
    if(form){
        for(var i=0;i<form.elements.length;i++){
            var elem = form.elements[i];
            if(elem.name){
                myAjax.addParam(elem.name, getElementValue(elem));
            }
        }
    }
    myAjax.submitXML(xmlSubmit, 'UTF-8');    
    var rtnDom = myAjax.getResponseXMLDom();
    if (procFlag == '1') {
        //薪资计算完成后，返回xml，更新datacell
        var msg = myAjax.getValue("root/data/returnValue");
        if (msg == 'true') {
            var salarydataVoList = Dataset.create(rtnDom, "root/data/SalarydataVo", "salarydataVo");
            if (salarydataVoList) {
                for (var i=0; i<salarydataVoList.getLength(); i++) {
                    var salarydataEn = salarydataVoList.get(i);
                    var dcEntity = dc.dataset.findEntity("emp_id", salarydataEn.getProperty("emp_id"));
                    //把salarydataEn的值放到entity上
                    dcEntity.setProperty("def1", salarydataEn.getProperty("def1"));//收入合计
                    dcEntity.setProperty("def2", salarydataEn.getProperty("def2"));//扣款合计
                    dcEntity.setProperty("def3", salarydataEn.getProperty("def3"));//实发合计
                    dcEntity.setProperty("def4", salarydataEn.getProperty("def4"));//税前总额
                    dcEntity.setProperty("def5", salarydataEn.getProperty("def5"));//扣税基数
                    dcEntity.setProperty("def6", salarydataEn.getProperty("def6"));//本次扣税
                    //dcEntity.setProperty("def25", salarydataEn.getProperty("def25"));//补充公积金个人部分
                    //dcEntity.setProperty("def29", salarydataEn.getProperty("def29"));//补充公积金企业部分
                    dcEntity.setProperty("def30", salarydataEn.getProperty("def30"));//个人社保总计
                    //dcEntity.setProperty("def31", salarydataEn.getProperty("def31"));//公积金自付
                    //dcEntity.setProperty("def32", salarydataEn.getProperty("def32"));//公积金基数
                    //dcEntity.setProperty("def33", salarydataEn.getProperty("def33"));//失业自付
                    //dcEntity.setProperty("def34", salarydataEn.getProperty("def34"));//医疗自付
                    //dcEntity.setProperty("def35", salarydataEn.getProperty("def35"));//养老自付
                    //dcEntity.setProperty("def36", salarydataEn.getProperty("def36"));//社保基数
                    dcEntity.setProperty("def37", salarydataEn.getProperty("def37"));//劳务费(劳务所得-劳务报酬税)
                    dcEntity.setProperty("def39", salarydataEn.getProperty("def39"));//劳务报酬税
                    dcEntity.setProperty("def40", salarydataEn.getProperty("def40"));//劳务报酬
                    dcEntity.setProperty("def41", salarydataEn.getProperty("def41"));//工资个税
                    dcEntity.setProperty("def42", salarydataEn.getProperty("def42"));//工会费
                    dcEntity.setProperty("def43", salarydataEn.getProperty("def43"));//营业税
                    dcEntity.setProperty("def44", salarydataEn.getProperty("def44"));//速算扣除数
                    dcEntity.setProperty("def45", salarydataEn.getProperty("def45"));//税率
                    dcEntity.setProperty("def46", salarydataEn.getProperty("def46"));//离职补偿金扣税
                    dcEntity.setProperty("def48", salarydataEn.getProperty("def48"));//年终奖扣税
                    dcEntity.setProperty("def49", salarydataEn.getProperty("def49"));//风险金
                    dcEntity.setProperty("def50", salarydataEn.getProperty("def50"));//应缴税额
                    dcEntity.setProperty("def51", salarydataEn.getProperty("def51"));//减免税额
                    
                    //以下为扩展的字段
                    for(var j=52;j<=150;j++){
                        if(salarydataEn.getProperty("def"+j)!=null){
                            dcEntity.setProperty("def"+j, salarydataEn.getProperty("def"+j));
                        }
                    }
                }
                //datacell更新entity后，需要手动刷新下row
                for(var j=0; j< dc.tbody.rows.length; j++){
                    dc.refreshRow(dc.getRow(j));
                }
                hideProgressBar();
                alert('计算成功。');
            }
        } else {
            if (msg != null && msg != 'null' ) {
                hideProgressBar();
                alert(msg);
            } else {
                hideProgressBar();
            }
        }
    } else {
        //保存
        var msg = myAjax.getValue("root/data/returnValue");
        if (msg) {
            hideProgressBar();
            alert(msg);
        } else {
            hideProgressBar();
        }
        dc.reload();
    }
}

/**
 * 点击计算按钮 税前算税后
 * @param {} flag
 */
function calSalary(flag) {
    //showProgressBar();
    var flag = calOrSave(flag, "calSalaryData", 1);
    //计算完自动保存
    if(flag==false){
        return false;
    }else{
       saveSelect(2);
    }
    //hideProgressBar();
}

/**
 * 税后算税前
 * AT(after-tax)税后
 */
function AT2Salary(flag) {
    if (flag == "1") {
        //保存选中
        if (_$("input[name='checkall']").attr("checked") && _$(":checked").length == 1) {
           alert('请选择一条记录');
           return false;
        }
        if (_$(":checked").length == 0) {
            alert('请选择一条记录');
           return false;
        }
    } else {
        //全部保存
        _$("input[name='checkall']").attr("checked", true);
        _$("input[name='checkbox_template']").attr("checked", true);
    }
    
    var dc = $id("itemdatacell");
    
    var calflag = true;
    _$(".eos-body-div input[name='checkbox_template']").each(function(i){
        if (_$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i];
            entity = dc.getEntity(row);
            if (entity.getValue("def3") == null || entity.getValue("def3") == '' || Number(entity.getValue("def3")) == 0) {
                calflag = false;
                return false;
            }
        }
    });
    if (!calflag) {
        if (!confirm("还有实发合计为空的数据，如果此时税后算税前，\r\n\r\n数据将不准确。是否继续？")) {
            return false;
        } else {
            if (!confirm("确定税后算税前？")) {
                return false;
            }
        }
    }
    showProgressBar();
    var xmlSubmit = dc.dataset.toString();
    var myAjax = new Ajax(venusbase + "/SalarydataAction.do?cmd=calTax2Salary");
    var form = $id("datacell_formid");
    if(form){
        for(var i=0;i<form.elements.length;i++){
            var elem = form.elements[i];
            if(elem.name){
                myAjax.addParam(elem.name, getElementValue(elem));
            }
        }
    }
    myAjax.submitXML(xmlSubmit, 'UTF-8');    
    var rtnDom = myAjax.getResponseXMLDom();
    var msg = myAjax.getValue("root/data/returnValue");
    if (msg == 'true') {
        var salarydataVoList = Dataset.create(rtnDom, "root/data/SalarydataVo", "salarydataVo");
        if (salarydataVoList) {
            for (var i=0; i<salarydataVoList.getLength(); i++) {
                var salarydataEn = salarydataVoList.get(i);
                var dcEntity = dc.dataset.findEntity("emp_id", salarydataEn.getProperty("emp_id"));
                //把salarydataEn的值放到entity上
                dcEntity.setProperty("def1", salarydataEn.getProperty("def1"));//收入合计
                dcEntity.setProperty("def2", salarydataEn.getProperty("def2"));//扣款合计
                //dcEntity.setProperty("def3", salarydataEn.getProperty("def3"));//实发合计
                dcEntity.setProperty("def4", salarydataEn.getProperty("def4"));//税前总额
                dcEntity.setProperty("def5", salarydataEn.getProperty("def5"));//扣税基数
                dcEntity.setProperty("def6", salarydataEn.getProperty("def6"));//本次扣税
                dcEntity.setProperty("def7", salarydataEn.getProperty("def7"));//基本工资
                dcEntity.setProperty("def25", salarydataEn.getProperty("def25"));//补充公积金(个人部分)
                dcEntity.setProperty("def30", salarydataEn.getProperty("def30"));//个人社保总计
                dcEntity.setProperty("def31", salarydataEn.getProperty("def31"));//公积金自付(-)
                dcEntity.setProperty("def32", salarydataEn.getProperty("def32"));//公积金基数
                dcEntity.setProperty("def33", salarydataEn.getProperty("def33"));//失业自付(-)
                dcEntity.setProperty("def34", salarydataEn.getProperty("def34"));//医疗自付(-)
                dcEntity.setProperty("def35", salarydataEn.getProperty("def35"));//养老自付(-)
                dcEntity.setProperty("def36", salarydataEn.getProperty("def36"));//社保基数
            }
            //datacell更新entity后，需要手动刷新下row
            for(var j=0; j< dc.tbody.rows.length; j++){
                dc.refreshRow(dc.getRow(j));
            }
            hideProgressBar();
            alert('计算成功。');
        }
    } else {
        if (msg != null && msg != 'null' ) {
            hideProgressBar();
            alert(msg);
        } else {
            hideProgressBar();
        }
    }
}