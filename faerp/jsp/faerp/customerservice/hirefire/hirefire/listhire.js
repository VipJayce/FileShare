/*************************************
 * @(C)Copyright 北京瑞友科技股份有限公司上海分公司. 2012
 * @作者: 马宏敏
 * @创建时间：2012-11-9 上午02:52:57
 * @文件名：listhire.js
 * @描述： 用于用工办理页面的js 操作
 *************************************/


//-------------------------------------------用工办理List页面的js------------------------------------------------
_$(function(){
	if($id("datacell1")){
        $id("datacell1").isQueryFirst = false;
	}
});

/**
 * 点击全选按钮
 * @param {} item
 * @author mahongmin
 */
function checkAll(item) {
    if (_$(item).attr("checked")) {
        changeEntityChk('1');//2015-1-13 yangyuting 
        _$(":checkbox").attr("checked", true);
    } else {
        changeEntityChk('0');//2015-1-13 yangyuting 
        _$(":checkbox").attr("checked", false);
    }
}

/**
 * 查看劳动合同
 */
function toDetailLabor(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条记录。');
        return;
    }
    if(ids.length > 1) {//如果ids有2条以上的纪录
        alert('只能选择一条记录。');
        return;
    }
    var post_id = ids;
    var url = venusbase + "/HirefireAction.do?cmd=toDetailLabor&post_id="
    + post_id + "&_ts=" + (new Date()).getTime();
    showModalCenter(url, window, callBack, 1024, 320, "查看劳动合同"); 
}

//得到选中的多选框
function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
    var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
    var number = 0;  //定义游标
    var ids = null;  //定义id值的数组
    for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
        if(elementCheckbox[i].checked) {  //如果被选中
            number += 1;  //游标加1
            if(ids == null) {
                ids = new Array(0);
            }
            ids.push(elementCheckbox[i].value);  //加入选中的checkbox
        }
    }
    return ids;
}

/**
 * 选择行后返回ids
 */
function selectIds() {
    var myids = new Array(0);;
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
 * 得到选中的empid
 * @return {}
 */
function selectEmpIds() {
    var myids = new Array(0);;
    var dc = $id("datacell1");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            //此id为post_id
            //myids += entity.getValue("id") + ",";
            myids.push(entity.getValue("emp_id"));
        }
    });
    return myids;
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
 * @author: mahongmin
 * 用工办理
 */
function toHandle(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('请选择一条记录。');
        return;
    }
    if(ids.length > 1) {//如果ids有2条以上的纪录
        alert('只能选择一条记录。');
        return;
    }
    
    var post_id = ids;
    
    //获取service_item_id
    var dc1 = $id("datacell1").dataset;
    var entity = dc1.findEntity("id", post_id);
    var item_id = entity.getProperty("item_id");
    var hire_fire_status_bd = entity.getProperty("hire_fire_status_bd");
    if(hire_fire_status_bd!=null && hire_fire_status_bd=='6'){
    	alert('该员工正在用工不需办理审批中，不能办理！');
        return;
    }
    
    var emp_id = selectEmpIds();
    //判断该员工是否存在多条待用工记录
    var myAjax = new Ajax(venusbase+"/HirefireAction.do?cmd=checkAll&post_id="+post_id);
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
    if( returnNode ) {
        if(myAjax.getProperty("returnValue")>1){
             if(confirm('此员工存在'+myAjax.getProperty("returnValue")+'条待办理的记录，是否确认要办理？')){
                    var url_showModalCenter = venusbase + "/HirefireAction.do?cmd=toHireHandle&post_id=" + ids +"&item_id=" + item_id;
                    window.open(url_showModalCenter,'','height=480px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=用工办理');
                    /*
                    var url = venusbase + "/HirefireAction.do?cmd=checkIsTransaction&post_id=" + post_id;
                    //判断此员工是否已做用工，保证在进入用工办理页面的员工都是没有办理用工的。
                    _$.ajax({
                        type : "post",
                        url : url,
                        dataType : "html",
                        success : function(data) {
                            if (data == '1') {
                                alert('此员工已办理用工，如需办理，请撤销已用工记录。');
                            } else {
                            	window.open(url_showModalCenter,'','height=480px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=用工办理');
                            	//showModalCenter(url_showModalCenter, window, callBack, 1024, 480, "用工办理"); 
                            }
                        }
                    });
                    */
               }
        }
        else{
            var url_showModalCenter = venusbase + "/HirefireAction.do?cmd=toHireHandle&post_id=" + ids +"&item_id=" + item_id;
            window.open(url_showModalCenter,'','height=480px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=用工办理');
            /*
            var url = venusbase + "/HirefireAction.do?cmd=checkIsTransaction&post_id=" + post_id;
            //判断此员工是否已做用工，保证在进入用工办理页面的员工都是没有办理用工的。
            _$.ajax({
                type : "post",
                url : url,
                dataType : "html",
                success : function(data) {
                    if (data == '1') {
                        alert('此员工已办理用工，如需办理，请撤销已用工记录。');
                    } else {
                    	window.open(url_showModalCenter,'','height=480px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=用工办理');
                       // showModalCenter(url_showModalCenter, window, callBack, 1024, 480, "用工办理"); 
                    }
                }
            });
            */
        }
    }
}
/**
 * 用工不需办理
 */
function hirenothandle(){
    var ids = selectIds();
    if(ids == null || ids.length==0) {
        alert('请选择一条记录。');
        return;
    }
    
    var dc1 = $id("datacell1").dataset;
    for(var i=0; i<ids.length; i++){
        var entity = dc1.findEntity("id", ids[i]);
        var emp_name = entity.getProperty("emp_name");
        var hire_fire_status_bd = entity.getProperty("hire_fire_status_bd");
        if(hire_fire_status_bd!=null && hire_fire_status_bd=='6'){
            alert('员工'+emp_name+'正在用工不需办理审批中，不能再次不需办理！');
            return;
        }
    }
    
    if(!confirm("您确定\"用工不需办理\"?")){  
        return false;
    }
    
    var flag = true;
    var dc = $id("datacell1");
    var ds = dc.dataset;
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            if (entity.getValue("back_reason") == null || entity.getValue("back_reason") == '') {
            	flag = false;
            	return false;
            }
        }
    });
    if (!flag) {
        alert('请输入回退原因。');
        return false;
    }
    var action = venusbase + "/HirefireAction.do?cmd=HireNotHandle";
    var xmlSubmit = ds.toString();
    var myAjax = new Ajax(action);
    myAjax.loadData(xmlSubmit);
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")) {
            alert('提交成功，待审核！');
            window.close();
        } else {
            alert('提交失败！');
        }
    } else {
        alert('提交失败！');
    }
    dc.reload();
}

/**
 * 输入用工不需办理的原因后，把打钩的每一行都改成此原因
 */
function batch_change_reason() {
	var dc = $id("datacell1");
	var entity = dc.activeEntity;
	var reason = entity.getValue("back_reason");
	if (entity.getValue("chk") == '1') {
		_$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                entity.setProperty("back_reason", reason);
            }
        });
	}
}

function batch_cancel_reason() {
	var dc = $id("datacell1");
    var entity = dc.activeEntity;
    var reason = entity.getValue("cancel_reason");
    if (entity.getValue("chk") == '1') {
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                entity.setProperty("cancel_reason", reason);
            }
        });
    }
}

/**
 * 回调函数
 * 弹出层关闭后，调用此方法
 */
function callBack(){
    //modify by mahongmin 直接用 reload
    $id("datacell1").reload();
}

//用工状态下拉框change事件
function hf_select(){
    var obj = document.getElementById('hfselect');
    if(obj.value=='0'){
        document.getElementById('div_button_1').style.display='block';
        document.getElementById('div_button_2').style.display='none';
    }else{
        document.getElementById('div_button_1').style.display='none';
        document.getElementById('div_button_2').style.display='block';
    }
    $id("datacell1").reload();
}

/**
 * 给datacell上的员工添加a标签
 * @param {} value
 * @param {} entity
 * @param {} rowNo
 * @param {} cellNo
 * @return {}
 */
function setEmp(value,entity,rowNo,cellNo){
	return "<a href=\"#\" onclick='detail_emp(\"" + entity.getProperty("emp_id") + "\");'>"+value+"</a>";
}
/**
 * 点击员工后弹出
 */
function detail_emp(emp_id){
    var url = venusbase + "/HirefireAction.do?cmd=detailEmployee&id=" + emp_id + "&_ts="+(new Date()).getTime();
   // showModalCenter(url, window, callBack, 1024, 480, "员工基本信息"); 
    window.open(url,'','height=500px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工基本信息');
    //window.showModalDialog('<venus:base/>/HirefireAction.do?cmd=detailEmployee&id='+emp_id+'&date='+new Date(),'','dialogHeight:384px;dialogWidth:1024px;center:yes;help:no;resizable:no;scroll:no;status:no;');
}


/**
 * 用工不退
 */
function hirenotfire(){
    var ids = selectIds();
    if(ids == null) {
        alert('请选择一条记录。');
        return false;
    }
    
    var dc1 = $id("datacell1").dataset;
    for(var i=0; i<ids.length; i++){
        var entity = dc1.findEntity("id", ids[i]);
        var emp_name = entity.getProperty("emp_name");
        var hire_fire_status_bd = entity.getProperty("hire_fire_status_bd");
        if(hire_fire_status_bd!=null && hire_fire_status_bd=='6'){
            alert('员工'+emp_name+'正在用工不需办理审批中，不能用工不退！');
            return;
        }
    }
    
    if(!confirm("您确定\"用工不退\"?")){  
        return false;
    }
    
    var flag = true;
    var dc = $id("datacell1");
    var ds = dc.dataset;
    var action = venusbase + "/HirefireAction.do?cmd=HireNotFire";
    var xmlSubmit = ds.toString();
    var myAjax = new Ajax(action);
    myAjax.loadData(xmlSubmit);
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")) {
            alert(myAjax.getValue("root/data/returnValue"));
            window.close();
        } else {
            alert('提交失败。');
        }
    } else {
        alert('提交失败');
    }
    dc.reload();
}

/**
 * 撤销用工
 */
function cancelhire(){
    var hire_fire_status_bd = document.getElementById('hire_fire_status_bd').value;
    if(hire_fire_status_bd == '1'){
        var ids = selectIds();
        if(ids == null) {
            alert('请选择一条记录。');
            return false;
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
            alert('请输入撤销原因。');
            return false;
        }
        var action = venusbase + "/HirefireAction.do?cmd=CancelHire";
        var xmlSubmit = ds.toString();
        var myAjax = new Ajax(action);
        myAjax.loadData(xmlSubmit);
        var returnNode = myAjax.getResponseXMLDom();
        if(returnNode) {
            if(myAjax.getValue("root/data/returnValue")) {
                alert(myAjax.getValue("root/data/returnValue"));
                window.close();
            } else {
                alert('提交失败。');
            }
        } else {
            alert('提交失败');
        }
        dc.reload();
    } else {
        alert('请选择用退工状态');
    }
}

//------------------------------------------------用工办理操作页面的js----------------------------------------------


/**
 * 点击信息栏，收缩信息栏
 * @param {} oDiv
 */
function isHidden(oDiv){
  var vDiv = document.getElementById(oDiv);
  vDiv.style.display = (vDiv.style.display == 'none')?'block':'none';
}
    
/**
 * 点击用工办理后，弹出用工办理界面，点击用工办理界面上的"保存"BUTTON
 * @param {} type
 */
function hiresave(type){
    var url = "";
    if (type == '1') {
        url = venusbase + "/HirefireAction.do?cmd=HireSave";
    } else {
        url = venusbase + "/HirefireAction.do?cmd=HireHandleUpdate";
    }
    document.getElementById("btn_save").disabled="disabled";
    _$.ajax({
        type : "post",
        url : url,
        data : _$("form").serialize(),
        dataType : "html",
        success : function(data) {
            if (data == '1') {
                /*if (data.length == 19) {
                    _$("#hfid").val(data);
                }*/
                alert('保存成功。');
            } else {
                alert('保存失败。');
            }
            window.close();
             window.opener.callBack();
        }
    });
}
    
/**
 * 点击用工办理后，弹出用工办理界面，点击用工办理界面上的"用工办理"BUTTON
 * @return {Boolean}
 */
function hirehandle(){
	if (!_$("#social_unit").val()) {
		alert("用工方不能为空。");
		return false;
	}
	if (!_$("#hire_start_date_hidden").val()) {
        alert("用工起始日不能为空。");
        return false;
    }
    if (!_$("#hire_handle_date_hidden").val()) {
        alert("办理用工日期不能为空。");
        return false;
    }
	
    if(!confirm("您确定\"用工办理\"?")){
        return false;
    }
    var url = venusbase + "/HirefireAction.do?cmd=HireHandle";
    _$.ajax({
        type : "post",
        url : url,
        data : _$("form").serialize(),
        dataType : "html",
        success : function(data) {
            if (data == '1') {
                alert('用工办理操作成功。');
                window.close();
                 window.opener.callBack();
            } else if (data == '2') {
                alert('此员工已办理用工，如需办理，请撤销已用工记录。');
            } else {
                alert('用工办理操作失败。');
            }
        }
    });
}
/**
 * 档案所在地选择其它，弹出文本框输入
 */

function doChange(){
	var va=document.getElementById("archivesaddress").value;
	if(va=="其它"){
		document.getElementById("archId").innerHTML="<input   id='otherinput'  name='otherinput' type='text' value=''  class='text_field'/ >";
	}
}

//获取催呼备注信息
    function batch_callcenter_onClick(){
        var url=venusbase +"/jsp/faerp/customerservice/security/empsecurity/tocallcenterremark.jsp";
        window.open(url,'','height=250px,width=400px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=填写催呼原因');
    }
    
/**
 * 催呼确认信息
 */
function callBackByOther(reg){
    var ids = selectIds();
    if(ids == null || ids.length==0) {
        alert('请选择一条记录。');
        return;
    }
    if(!confirm("您确定\"进行催呼确认吗\"?")){  
        return false;
    }
    var flag = true;
    var dc = $id("datacell1");
    var ds = dc.dataset;
    var conf=false;//2015-1-9 yangyuting add 
    _$("input[type='checkbox']").each(function(i) {
        //第0个为全选按钮
        if (i != 0 && _$(this).attr("checked")) {
            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            var call_center_bd = entity.getValue("call_center_bd") ;
            if(call_center_bd ==null||call_center_bd == '1'){//2015-1-9 yangyuting add call_center_bd == '1' 
                alert("只有未催呼的数据才能进行催呼！") ;
            }else{
              conf=true;
            }
        }
    });
    if(!conf){
        return false;
    }
    if (reg ==null) {
        alert("请填写催呼原因！");
        return false;
    }
    var action = venusbase + "/HirefireAction.do?cmd=HireToCallCenter&welfaer_type=3&welfarefailreason="+encodeURIComponent(reg);
    var xmlSubmit = ds.toString();
    var myAjax = new Ajax(action);
    myAjax.loadData(xmlSubmit);
    var returnNode = myAjax.getResponseXMLDom();
    if(returnNode) {
        if(myAjax.getValue("root/data/returnValue")) {
            alert('提交成功，待催呼！');
        } else {
            alert('提交失败！');
        }
    } else {
        alert('提交失败！');
    }
    dc.reload();
}
