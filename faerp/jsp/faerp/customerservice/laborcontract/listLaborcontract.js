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
            myids.push(entity.getValue("id"));
        }
    });
    return myids;
}

/**
 * 提交按钮事件
 */
function submit_onClick(){
        //var checkbox_template = document.getElementsByName('checkbox_template');
        //var ischecked=false;
       //var checkValues = findSelections("checkbox_template","id");  //取得多选框的选择项
	    var ids = selectIds();
	    if(ids.length <=0) {  //如果ids为空
            alert('请选择记录');
            return;
        }
    var array ="";
    for(var i=0;i<ids.length;i++)
        {
            //var  enCurEntity = $id("datacell1").dataset.get(i);
             var enCurEntity = $id("datacell1").dataset.findEntity("id",ids[i]);
            if(enCurEntity.getProperty("start_date")>enCurEntity.getProperty("end_date"))
            {
                alert("合同起始日期不能大于结束日期，请更改！");
                return ;
            }
            if(enCurEntity.getProperty("send_start_date")>enCurEntity.getProperty("send_end_date"))
            {
                alert("派遣起始日期不能大于派遣结束日期，请更改！");
                return ;
            }
            if(enCurEntity.getProperty("try_start_date")>enCurEntity.getProperty("try_end_date"))
            {
                alert("试用起始日期不能大于试用结束日期，请更改！");
                return ;
            }
            if(enCurEntity.getProperty("is_fixed_term") == "0"){
                if(enCurEntity.getProperty("continuation_years") == null || enCurEntity.getProperty("continuation_years") == "" || enCurEntity.getProperty("continuation_years") == " "){
                    alert("自动延续状态已勾选，请选择自动延续年数");
                    return;
                }
            }else{
                if(enCurEntity.getProperty("continuation_years") == null || enCurEntity.getProperty("continuation_years") == "" || enCurEntity.getProperty("continuation_years") == " "){
                }else{
                    alert("自动延续状态未勾选，不能选择自动延续年数");
                    return;
                }
            }
            //2016-04-08  by zhouxiaolong update  begin
            array+=enCurEntity.getProperty("id")+",";
            //2016-04-08  by zhouxiaolong update  end
        }
        $id("datacell1").submitAction="/FAERP/LaborcontractAction.do?cmd=Save&emp_code_list="+array;
        $id("datacell1").isModefied = true;
        if($id("datacell1").submit()){
           alert("提交成功！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    /**
     * 续签按钮事件
     */
    function torenew_onClick(){
         var ids = selectIds();
       
        if(ids == null || ids == '') {
            alert('请选择一条记录！');
            return;
        }
        if(ids.length > 1) {//如果ids有2条以上的纪录
            alert('只能选择一条记录！');
            return;
        }
        var enCurEntity = $id("datacell1").activeEntity;
        var labor_status_bd = enCurEntity.getProperty('labor_status_bd');
        var renew_status = enCurEntity.getProperty('renew_status');
         //modify by dongying 20151013
         if(renew_status=='2'){
            alert(' 续签已处理，不可再次续签！');
            return;
        }else{
            if(labor_status_bd == '2'){
                //form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=toRenew&id=" + ids;
                //form.submit();
                var url = venusbase+"/LaborcontractAction.do?cmd=toRenew&id=" + ids+"&_ts='+(new Date()).getTime()";
                showModalCenter(url, window, callBack, 720, 300, "劳动合同续签"); 
            }else{
                alert(enCurEntity.getProperty('emp_name')+'未签署,不可续签');
                return;
            }
        }
    }
    
    /**
     * 个人订单查看
     */
    function info_onClick(){ 
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('请选择一条记录！');
            return;
        }
        if(ids.length > 1) {//如果ids有2条以上的纪录
            alert('只能选择一条记录！');
            return;
        }
        var enCurEntity = $id("datacell1").activeEntity;
        var post_id = enCurEntity.getProperty("emp_post_id");
        window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
    }
    
    function callBack(reg){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    /**
     * 签署状态
     * @param {} obj
     * @param {} num
     * @param {} name
     */
    function btach_change(obj,num,name){
       var sele1 = obj;
       var enCurEntity1 = $id("datacell1").activeEntity;
       var ischecked=false;
       var ids = selectIds();
        for(var i=0;i<ids.length;i++)
        {
            var enCurEntity = $id("datacell1").dataset.get(i);
              if(ids[i].checked){
                if(enCurEntity.getProperty("id")==enCurEntity1.getProperty("id"))
                {
                    ischecked=true;
                }
              }
        }
        if(ischecked)
        {
            for(var i=0;i<ids.length;i++){           
            var enCurEntity = $id("datacell1").dataset.get(i);
            if(ids[i].checked){
                if(obj.value!=null&&obj.value!=""){
                enCurEntity.setProperty(name,obj.value);                
                }
            }          
        }
        }        
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //知道了，不需提醒按钮事件
    function tonotNeedRemind_onClick(){
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert('请选择一条记录！');
            return;
        } 
     //   alert(ids); 
      //  return ;
       // if(ids.length > 1) {//如果ids有2条以上的纪录
        //    alert('只能选择一条记录！');
         //   return;
       // }
        document.form.action=venusbase + "/LaborcontractAction.do?cmd=tonotNeedRemind&id=" + ids+"&_ts="+(new Date()).getTime();
        document.form.submit();
    }
    
    function batch_blue(obj){
        var enCurEntity1 = $id("datacell1").activeEntity;
        var entity = enCurEntity1.getProperty(obj);
        var ischecked=false;
       var ids = selectIds();
        if(ids == null) {  //如果ids为空
   //         alert('<fmt:message key="select_one_record"/>');
        //    return;
        }
        for(var i=0;i<ids.length;i++)
        {
            var enCurEntity = $id("datacell1").dataset.get(i);
              if(ids[i].checked){
                if(enCurEntity.getProperty("id")==enCurEntity1.getProperty("id"))
                {
                    ischecked=true;
                }
              }
          
        }
        if(ischecked)
        {
            for(var i=0;i<ids.length;i++){           
            var enCurEntity = $id("datacell1").dataset.get(i);
            if(ids[i].checked){
                enCurEntity.setProperty(obj,entity);
            }          
        }
        }
        return true;            
    }
    
    function batch_date(obj,name){
        var enCurEntity1 = $id("datacell1").activeEntity;
        var entity = enCurEntity1.getProperty(name);
        var ischecked=false;
       var ids = selectIds();
        for(var i=0;i<ids.length;i++)
        {
        
            var enCurEntity = $id("datacell1").dataset.get(i);
              if(ids[i].checked){
                if(enCurEntity.getProperty("id")==enCurEntity1.getProperty("id"))
                {
                    ischecked=true;
                }
              }
        }
        if(ischecked)
        {
            for(var i=0;i<ids.length;i++){           
            var enCurEntity = $id("datacell1").dataset.get(i);
            if(ids[i].checked){
                var send_start_date = enCurEntity.getProperty("send_start_date");
                var send_end_date = enCurEntity.getProperty("send_end_date");
                if(send_start_date>send_end_date){
                    alert('派遣起始日期不能大于派遣结束日期');
                    return ;
                }
                var start_date = enCurEntity.getProperty("start_date");
                var end_date = enCurEntity.getProperty("end_date");
                if(start_date>end_date){
                    alert('合同起始日期不能大于合同结束日期');
                    return ;
                }
                var try_start_date = enCurEntity.getProperty("try_start_date");
                var try_end_date = enCurEntity.getProperty("try_end_date");
                if(try_start_date>try_end_date){
                    alert('试用期起始日期不能大于试用期结束日期');
                    return ;
                }
                enCurEntity.setProperty(name,obj);
            }          
        }
        }
        return true;            
    }
    
     //批量更改合同签署日期
    function subscribe_date(obj)
    {
        var date = dateToString(obj,"");
    batch_date(date,"subscribe_date");
    }
   //批量更改派遣起始期限开始日期
    function send_start_date(obj)
    {
        var date = dateToString(obj,"");
        batch_date(date,"send_start_date");
    }
    //批量更改派遣起始期限结束日期
     function send_end_date(obj)
    {
        var date = dateToString(obj,"");
        batch_date(date,"send_end_date");
    }
    //批量更改合同开始日期
     function start_date(obj)
    {
        var date = dateToString(obj,"");
        batch_date(date,"start_date");
    }
    //批量更改合同结束日期
     function end_date(obj)
    {
        var date = dateToString(obj,"");
        batch_date(date,"end_date");
    }
    //批量更改试用期开始日期
     function try_start_date(obj)
    {
        var date = dateToString(obj,"");
        batch_date(date,"try_start_date");
    }
    //批量更改试用期结束日期
     function try_end_date(obj)
    {
        var date = dateToString(obj,"");
        batch_date(date,"try_end_date");
    }
    
    
    function back_to(){
    	document.form.action=venusbase + "/TabannounceinfoAction.do?cmd=queryAll1";
        document.form.submit();
    }