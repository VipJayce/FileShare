_$(function(){
    $id("datacell1").isQueryFirst = false;
});


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
    var dc1 = $id("datacell1").dataset;
    var values = dc1.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}

/**
 * 简单的模糊查询
 */
function simpleQuery_onClick() {
    $id("datacell1").loadData();
    $id("datacell1").refresh();
}

/**
 * 选择行后返回ids
 */
function selectIds() {
    var myids = new Array(0);
    var dc = $id("datacell1");
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
 * 退工办理
 */
function firehandle(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条记录！');
        return;
    }
    if(ids.length > 1) {//如果ids有2条以上的纪录
        alert('只能选择一条记录！');
        return;
    }
    var post_id = ids;
    entity=$id("datacell1").getActiveEntity();
    var emp_code = entity.getProperty("emp_code");
    var cust_id = entity.getProperty("cust_id");
    var postId = entity.getProperty("emp_post_id");
    var cehfId = entity.getProperty("id");
    var user_id=entity.getProperty("user_id");
    var url = venusbase + "/HirefireAction.do?cmd=toFireHandle&post_id="+postId+"&id="+cehfId+"&emp_code="+emp_code+"&user_id="+user_id+"&cust_id="+cust_id+"&_ts="+(new Date()).getTime();

    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=退工办理');
    //showModalCenter(url, window, callBack, 1024, 480, "退工办理"); 
}

function isNotReceived(){
	var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条或多条记录！');
        return;
    }
    var url=venusbase + "/HirefireAction.do?cmd=IsNotReceived&ids="+ids;
    url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
    showModalCenter(url, window, callBack, 400, 200, "是否收到退工单");  
   	/*var action = venusbase + "/HirefireAction.do?cmd=NotReceived&ids="+ids;
    var myAjax = new Ajax(action);
    myAjax.submit();
	var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")==1) {
            alert('操作成功！');
            simpleQuery_onClick();
        } else {
            alert('操作失败！');
        }
    } else {
        alert('操作失败！');
    }*/
}

/**
 * 撤销退工
 */
function cancelfire(){
    //var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条记录！');
        return;
    }
    
    var flag = true;
    var dc = $id("datacell1");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            if (entity.getValue("cancel_reason") == null || entity.getValue("cancel_reason") == '') {
                flag = false;
                return false;
            }
        }
    });
    if (!flag) {
        alert('请输入撤销退工原因!');
        return false;
    }
    var action = venusbase + "/HirefireAction.do?cmd=CancelFire";
    var xmlSubmit = ds.toString();
    var myAjax = new Ajax(action);
    myAjax.loadData(xmlSubmit);
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")==1) {
            alert('撤销退工成功！');
            simpleQuery_onClick();
        } else {
            alert('撤销退工提交失败！');
        }
    } else {
        alert('撤销退工提交失败！');
    }
    
}

function callBack(reg){
    $id("datacell1").loadData();
    $id("datacell1").refresh();
}

/**
 * 查看劳动合同
 */
function tolabor(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条记录！');
        return;
    }
    if(ids.length > 1) {//如果ids有2条以上的纪录
        alert('只能选择一条记录！');
        return;
    }
    var post_id = ids;
    entity=$id("datacell1").getActiveEntity();
    var postId = entity.getProperty("emp_post_id");
    //alert(post_id+"AAAA"+postId);return;
    //form.action=venusbase + "/HirefireAction.do?post_id=" + ids;
    //form.cmd.value = "toDetailLabor";
   // form.submit();
    var url = venusbase + "/HirefireAction.do?cmd=toDetailLabor&post_id="+postId+"&_ts="+(new Date()).getTime();
    window.open(url,'','height=300px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看劳动合同');
    //showModalCenter(url, window, callBack, 800, 300, "查看劳动合同"); 
}

/**
 * 外来人员退工证明
 */
function fireProve(){
    var url = venusbase + "/jsp/faerp/customerservice/hirefire/hirefire/fireProve.jsp";
    window.open(url,'','height=300px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=外来人员退工证明');
    //showModalCenter(url, window, callBack_fireProve, 850, 250, "外来人员退工证明"); 
}

/**
 * 批量退工
 */
function batchfire(){	
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条记录！');
        return;
    }
    var flag = true;
    var dc = $id("datacell1");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            if (entity.getValue("fire_handle_date") == null || entity.getValue("fire_handle_date") == '') {
                flag = false;
                return false;
            }
        }
    });
    if (!flag) {
        alert('退工办理日期不能为空！!');
        return false;
    }
    var action = venusbase + "/HirefireAction.do?cmd=batchFire";
    var xmlSubmit = ds.toString();
    var myAjax = new Ajax(action);
    myAjax.loadData(xmlSubmit);
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")==1) {
            alert('批量退工成功！');
            simpleQuery_onClick();
        } else {
            alert('批量退工提交失败！');
        }
    } else {
    	alert('cc');
        alert('批量退工提交失败！');
    }
    
}

/**
 * 导出
 */
function exportexcel(){
    form.action=venusbase + "/HirefireAction.do";
    form.cmd.value = "exportExcelFire";
    form.submit();
}

/**
 * 退工不需办理
 */
/*function firenothandle(){
    var ids = selectIds();
    form.action="<%=request.getContextPath()%>/HirefireAction.do?ids=" + ids;
    form.cmd.value = "fireNotHandle";
    form.submit();
}*/

function setEmp(value,entity,rowNo,cellNo){
      return "<a href=\"#\" onclick='javascript:detail_emp(\"" + entity.getProperty("emp_id") + "\");'>"+value+"</a>";
}

function detail_emp(id){
    var url = venusbase + "/HirefireAction.do?cmd=detailEmployee&id="+id+"&_ts="+new Date().getTime();
    // showModalCenter(url, window, callBack, 1024, 480, "员工基本信息"); 
     window.open(url,'','height=380px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工基本信息明');
    //window.showModalDialog('<venus:base/>/HirefireAction.do?cmd=detailEmployee&id='+emp_id+'&date='+new Date(),'','dialogHeight:384px;dialogWidth:1024px;center:yes;help:no;resizable:no;scroll:no;status:no;');
}

/**
 * 退工状态下拉框change事件
 * @param {} obj
 */
function fire_stauts(obj){	
    if(obj.value=='1'){
        document.getElementById('div_button_0').style.display='block';
        document.getElementById('div_button_1').style.display='none';
        /*document.getElementById('div_button_2').style.display='none';*/
    }else if(obj.value=='2'){
        document.getElementById('div_button_0').style.display='none';
        document.getElementById('div_button_1').style.display='block';
        /*document.getElementById('div_button_2').style.display='none';*/
    }
 /*   else {
        document.getElementById('div_button_0').style.display='none';
        document.getElementById('div_button_1').style.display='none';
        document.getElementById('div_button_2').style.display='block';
    }*/
   //$id("datacell1").reload();//变更时不查询
}

/**
 * 输入退工办理日期后，把打钩的每一行都改成此日期
 */
function batch_change_date(obj) {
	var date = dateToString(obj,"");
    var dc = $id("datacell1");
    var entity = dc.activeEntity;
    if (entity.getValue("chk") == '1') {
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                entity.setProperty("fire_handle_date", date);
                dc.refreshRow(row);
            }
        });
    }
}