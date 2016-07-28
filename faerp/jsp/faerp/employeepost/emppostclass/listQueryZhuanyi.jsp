<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.project.IToolsConstants"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<fmt:bundle basename="rayoo.employeepost.emppostclass.emppostclass_resource" prefix="rayoo.employeepost.emppostclass.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
    });
    
    function ClickRow(value,value1){
         getSendbyid();
    }

    function checkAll(field){
         var checkboxes = document.getElementsByName("checkbox_template");
         for(var i=0;i<checkboxes.length;i++){
             checkboxes[i].checked = field.checked;
         }
     }
     
    function findSelection(radioName, idName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value;
            }
        }
        return ids;
    }

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

</script>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp' id='temp_"+rowNo+"' onClick=ClickRow(\"" + entity.getProperty("emp_service_id") + "\",\"" + entity.getProperty("city_id") + "\");>";//city_idList
    }
    
    //员工列表，点击全选按钮
    function emp_onClick(obj){
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            //针对第一行有问题，其他行可行
            if(obj.checked){//勾选上
                $id("temp_"+i).checked=true;
            }else{//勾选去掉
                $id("temp_"+i).checked=false;
            }
        }
    }

    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmppostAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/EmppostAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/insertEmppost.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
          var product_name = document.getElementsByName("temp");
           var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var emp_post_id="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i);
                      emp_post_id = enCurEntity.getProperty("emp_post_id");
                     break;
              }
           }
        if(emp_post_id!=null&&emp_post_id!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'个人订单信息','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            //window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
        }else{
            alert('<fmt:message key="select_records"/>');
            return;
        }
    }
    
    function showNewdiv(){
        selectAllRows();
        var ids = findSelections("radio_template","id");  //取得复选框的选择项
        if(ids == null) {  //如果ids为空
             return;
        }
        var obj=document.getElementById("zlTab");
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            var xlid=ids[i];
            var j=document.getElementById(xlid).rowIndex;
            obj.deleteRow(j);
        }
    }
    
        //客户名称查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
         document.form.cust_name.value=data[2];
    }
    
        function exportEmpSend(){
        form.cmd.value = "export";
        form.submit();
    }
    
      function getquotation(){
       var contract_id=document.form.contract_id.value;
        var ids = window.showModalDialog('<venus:base/>/QuotationAction.do?cmd=queryAllGetByID&contract_id='+contract_id+'&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.quotation_id.value=ids[0];
        document.form.quotation_name.value=ids[1];
    }
    
 function addAt(selectCtl,optionValue,optionText,position)
{
    var userAgent = window.navigator.userAgent;
    if (userAgent.indexOf("MSIE") > 0) {
        var option = document.createElement("option");
        option.innerText = optionValue;
        option.value = optionText;
        selectCtl.insertBefore(option, selectCtl.options[position]);
    }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
    }
}

function submit_onClick() { //保存修改后的单条数据
    //------------------------------------------------------选择员工
    var send_id=document.getElementById("send_id").value;   //委派单
    if (null==send_id||send_id=="") {
        alert("<fmt:message key="send_not_null"/>");
        return;
    }
    var isOrNotWToW = false;//魏佳新增,用于后台判断是否为外地转外地的员工转移
    var quotation_name=document.getElementById("quotation_name").value;   //报价单
    var   customer_code  =document.getElementById("customer_code").value;   //客户
    var   customer_name  =document.getElementById("customer_name").value;   //客户
    var   cust_receive_id  =document.getElementById("cust_receive_id").value;   //接受单位
    var   effect_date  =document.getElementById("effect_date").value;   //转移生效日期
    var   apply_on_post_date  =document.getElementById("apply_on_post_date").value;   //入职时间
    if (null==quotation_name||quotation_name=="") {
        alert("<fmt:message key="quotation_not_null"/>");
        return;
    }
    if (null==effect_date||effect_date=="") {
        alert("<fmt:message key="effect_date_not_null"/>");
        return;
    }
    if (null==apply_on_post_date||apply_on_post_date=="") {
        alert("<fmt:message key="apply_on_post_date_not_null"/>");
        return;
    }

    var product_name = document.getElementsByName("temp");
    var number = 0;  //定义游标
    var ids = null;  //定义id值的数组
    var   customer_id  =document.getElementById("customer_id").value;   //客户
    var   city_name  =  document.getElementById("city_name").value;   //城市名称
    var emp_post_id="";

    var emp_id ="";
    var emp_code="";
    var emp_name="";
    var security_unit_id="";
    var fund_security_unit_id="";
    var hire_security_unit_id="";
    for (var i=0;i<product_name.length;i++) {  //循环checkbox组
        if (product_name[i].checked) { //如果被选中
            var enCurEntity = $id("datacell1").dataset.get(i);
            emp_post_id  += enCurEntity.getProperty("emp_post_id")+",";
            emp_id+= enCurEntity.getProperty("emp_id")+",";
            emp_code+= enCurEntity.getProperty("emp_code")+",";
            emp_name+= enCurEntity.getProperty("emp_name")+",";
            security_unit_id=     enCurEntity.getProperty("security_unit_id");
            var security_unit_id1=document.getElementById("security_unit_id").value;   //社保办理方
            fund_security_unit_id= enCurEntity.getProperty("fund_security_unit_id");
            var fund_security_unit_id1=document.getElementById("fund_security_unit_id").value;   //公积金办理方
            hire_security_unit_id= enCurEntity.getProperty("hire_security_unit_id");
            var hire_security_unit_id1=document.getElementById("hire_security_unit_id").value;   //用退工办理方

            var start_date=enCurEntity.getProperty("start_date");
            var end_date=enCurEntity.getProperty("end_date");
            var customer_id1 = enCurEntity.getProperty("cust_id");
            var   emp_post_type_bd  =  enCurEntity.getProperty("emp_post_type_bd");
            var   service_status_bd  =  enCurEntity.getProperty("service_status_bd");
            var   city_name1  =  enCurEntity.getProperty("city_name");
            if (city_name != city_name1) {
                    alert("新委派单和旧委派单对应的城市不一样，不能转移！");
                    return ;
            }
            //是否线上
            var isonline = enCurEntity.getProperty("isonline");
            if (isonline == '' || isonline == null) {
                    alert("此员工不确定为线上还是线下，不能转移！");
                    return ;
            }
            
            //if(emp_post_type_bd==2&&customer_id!=customer_id1){
            //   alert("<fmt:message key="custname_and_sendname_not_consistency"/>");
            //  return ;
            // }
            /*if((city_name=='上海' || city_name1=='上海') && city_name!=city_name1){
               alert("<fmt:message key="sendname_correspond_sh_and_other_city"/>");
               return ;
            }*/
            //魏佳修改,取消外地转外地的限制
            if (city_name=='上海' || city_name1=='上海') {
                if (security_unit_id!=security_unit_id1) {
                    alert("<fmt:message key="emp_security_unit_id_not_consistency"/>");
                    return ;
                }
                if (fund_security_unit_id!=fund_security_unit_id1) {
                    alert("员工公积金福利办理方不一致，不能转移！");
                    return ;
                }

                if (hire_security_unit_id!=hire_security_unit_id1) {
                    alert("员工用退工福利办理方不一致，不能转移！");
                    return ;
                }

                if (security_unit_id=='1099141600000000111' || security_unit_id=='1099141600000000102') {
                    alert("员工社保福利办理方为单立户，不能转移");
                    return ;
                }

                if (fund_security_unit_id=='1099141600000000111'  || fund_security_unit_id=='1099141600000000102') {
                    alert("员工公积金福利办理方为单立户，不能转移");
                    return ;
                }

                if (hire_security_unit_id=='1099141600000000111'  || hire_security_unit_id=='1099141600000000102') {
                    alert("员工用退工福利办理方为单立户，不能转移！");
                    return ;
                }
            } else {
                isOrNotWToW = true;
                if (security_unit_id!=security_unit_id1) {
                    alert("<fmt:message key="emp_security_unit_id_not_consistency"/>");
                    return ;
                }


               
                if (fund_security_unit_id!=fund_security_unit_id1) {
                    alert("员工公积金福利办理方不一致，不能转移！");
                    return ;
                }

                if (hire_security_unit_id!=hire_security_unit_id1) {
                    alert("员工用退工福利办理方不一致，不能转移！");
                    return ;
                }

                if (security_unit_id=='1099141600000000111' || security_unit_id=='1099141600000000102') {
                    // 20150120 修改 判断如果两边客户不一致，提示信息
                    if (customer_id !=  customer_id1) {
                        alert("员工社保福利办理方为单立户，不能转移");
                        return ;
                    }
                }

                if (fund_security_unit_id=='1099141600000000111'  || fund_security_unit_id=='1099141600000000102') {
                    // 20150120 修改 判断如果两边客户不一致，提示信息
                    if (customer_id !=  customer_id1) {
                        alert("员工公积金福利办理方为单立户，不能转移！");
                        return ;
                    }
                }

                if (hire_security_unit_id=='1099141600000000111'  || hire_security_unit_id=='1099141600000000102') {
                    // 20150120 修改 判断如果两边客户不一致，提示信息
                    if (customer_id !=  customer_id1) {
                        alert("员工用退工福利办理方为单立户，不能转移！");
                        return ;
                    }
                }
            }
            var start_date1=start_date.substring(0,10);
            var end_date1=end_date.substring(0,10);

            if (effect_date<start_date1||effect_date>end_date1) {
                alert("<fmt:message key="notice_one"/>");
                return ;
            }
        }
    }

    //  alert(emp_post_id)
    if (emp_post_id==null||emp_post_id=="") {
        alert("<fmt:message key="select_records"/>");
        return;
    }

    if (!getConfirm()) { //如果用户在确认对话框中点"取消"
        return false;
    }

    //validateInjury(function(){
        showProgressBar('page_progBarId',' <div   class="loading" ></div> ');
        maskWindow();
        //使用ajax保存小类列表及其对应大类
        validateSaveFw(emp_post_id,send_id,emp_id,quotation_name,customer_id,effect_date,cust_receive_id,apply_on_post_date ,emp_code,emp_name,customer_code,customer_name,isOrNotWToW);
    //}, emp_post_id, customer_code, effect_date);
}

    function validateInjury(callback, ids,  customer_code, effect_date) {
        var url = "<%=request.getContextPath()%>/EmppostAction.do";
        jQuery.post(url, {"cmd": "checkInjury", "ids": ids, "customer_code":customer_code,"effect_date":effect_date}, function(){
            if (!!data) {
                if (data == '0'){
                    callback.call(this);
                } else {
                    alert(data);
                }
            }
        });
    }

//ajax提交保存数据
function validateSaveFw(ids,send_id,emp_id,quotation_name,customer_id,effect_date,cust_receive_id,apply_on_post_date,emp_code,emp_name,customer_code,customer_name,isOrNotWToW) {
    var flags=true;
    jQuery.ajax({
        url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=insertUpdateZhuanyi&ids='+ids+"&date="+new Date()+"&send_id="+send_id+"&emp_id="+emp_id+"&quotation_name="+encodeURIComponent(quotation_name)+"&customer_id="+customer_id+"&cust_receive_id="+cust_receive_id+"&effect_date="+effect_date+"&apply_on_post_date="+apply_on_post_date+"&emp_name="+encodeURIComponent(emp_name)+"&emp_code="+emp_code+"&customer_code="+customer_code+"&customer_name="+encodeURIComponent(customer_name)+"&isOrNotWToW="+isOrNotWToW,
        type: 'GET',
        dataType: 'html',
        async: false,
        timeout: 1000000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(text) {
            if(text!=null) {
                if(text.length>1000){
                    alert("<fmt:message key="shift_errer"/>");
                                             
                }else{
                    if (text == '1') {
                        form.action="<%=request.getContextPath()%>/EmppostAction.do?send_id=" + send_id + "&emppostIds=" + ids + "&customer_id=" + customer_id + "&cust_receive_id=" + cust_receive_id + "&quotation_name=" + encodeURIComponent(quotation_name) + "&emp_ids=" + emp_id;
                        form.cmd.value = "initInsertBatForZhuanYi";
                        form.submit();
                    }
                     else {
                        alert(text);
                        //inputToEmpty();
                        simpleQuery_onClick();
                    }
                }
                hideProgressBar('page_progBarId');
                unMaskWindow();
            }
        }
    });return flags;
}
                            
                    function   inputToEmpty(){
                      
                       document.getElementById("send_id").value= "";                  //报价单
                       document.getElementById("send_name").value="";
                       document.getElementById("customer_id").value="";
                       document.getElementById("customer_name").value="";
                       document.getElementById("customer_code").value="";                                                    //接受单位
                       document.getElementById("cust_receive_id").value="";                                            //转移生效日期
                       document.getElementById("cust_receive_name").value="";
                       document.getElementById("security_unit_id").value="";
                       document.getElementById("fund_security_unit_id").value="";
                       document.getElementById("hire_security_unit_id").value="";
                         $id("effect_date").setValue("");
                         $id("apply_on_post_date").setValue("");
                          $id("send_name").setDisplayValue("");
                          
                               //   加载报价单al
                       var quotation_name = document.getElementById("quotation_name");
                         var   j=quotation_name.options.length;
                          for(var   i=j-1;i>0;i--)
                          {
                             quotation_name.remove(i);
                          }
                       
                    }


    function getsendid(){
         var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&agent_type=3&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_send_id.value=ids[0];
        document.form.cust_send_name.value=ids[1];
    }
    
    function getreceiveid(){
        var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&agent_type=3&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_receive_id1.value=ids[0];
        document.form.cust_receive_name1.value=ids[1];
    }
          function rtnFuncCustomer(arg){
            var lookup = $id("cust_id");
            lookup.value = arg[0];
            lookup.displayValue = arg[2];
            return false;
        }
        
        
        //派出单位选择回调函数
    function rtnFuncSend(arg){
        var lookup = $id("cust_send_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    //接收单位选择回调函数
    function rtnFuncRecive(arg){
        var lookup = $id("cust_receive_id1");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    
    
     function getSendbyid(){
        
          var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
          var ids = null;  //定义id值的数组
          var emp_post_id="";
          
          var  emp_post_type_bd1="";
          var  customer_id2="";
          var cust_name2="";
          var n=0;
          for(var i=0;i<product_name.length;i++){  //循环checkbox组
                if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i);
                      emp_post_id = enCurEntity.getProperty("emp_post_id");
                      customer_id1= enCurEntity.getProperty("cust_id");
                     cust_name1= enCurEntity.getProperty("cust_name");
                     var emp_post_type_bd=enCurEntity.getProperty("emp_post_type_bd");
                           if(emp_post_type_bd==2&&n!=0){
                                                if(customer_id1!=customer_id2){
                                                    alert("<fmt:message key="emp_type_for_cust"/>");
                                                    return;
                                                }
                                        
                                        }
                                        emp_post_type_bd1=emp_post_type_bd;
                                       customer_id2=customer_id1;
                                       cust_name2=cust_name1;
                                       n++;
                }
           }
           if(emp_post_id==null||emp_post_id==""){
                     alert("<fmt:message key="select_records"/>");
                     return;
           }
             
          
           if(emp_post_type_bd1==2){
               $id("send_name").lookupUrl = "<venus:base/>/SendAction.do?cmd=queryAllSend&date="+new Date()+"&customer_id="+customer_id2+"&customer_name="+encodeURIComponent(cust_name2);
           }else{
               $id("send_name").lookupUrl = "<venus:base/>/SendAction.do?cmd=queryAllSend&date="+new Date() ;
           }
       }
    
        function rtnFuncSend_id(data){
        var lookup = $id("send_name");
        lookup.value = data[0];
        lookup.displayValue = data[1];
        
                       document.form.send_id.value=data[0];
                //      document.form.send_name.value=data[1];
                      document.form.customer_id.value=data[2];
                 //      document.form.customer_name.value=data[3];
                        document.form.city_name.value=data[9];
                      
                      if(data[3]==""||data[3]=="null"){
                               document.form.customer_name.value="";
                      }else{
                             document.form.customer_name.value=data[3];
                      }
                      
                      if(data[4]==""||data[4]=="null"){
                      document.form.cust_receive_name.value="";
                      }else{
                             document.form.cust_receive_name.value=data[4];
                      }
                     
                       document.form.cust_receive_id.value=data[5];
                  //     document.form.contract_id.value=data[6];
                      document.form.customer_code.value=data[7];
                      document.form.security_unit_id.value=data[8];
                      document.form.fund_security_unit_id.value=data[10];
                      document.form.hire_security_unit_id.value=data[11];

        return false;
    }
    
    //给报价单赋值
  function rtnFuncquotation_id(data){
      var lookup = $id("quotation_name");
        lookup.value = data[0];
        lookup.displayValue = data[2];
        return false ;
  }
    

</script>
</head>
<body>

<form name="form" method="post"    id="datacell_formid"   action="<%=request.getContextPath()%>/EmppostAction.do">
<input type="hidden" name="cmd" value="queryzhuanyiList">
<input type="hidden" name="backFlag" value="true">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key="declare_shift"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr>
            <td width="55" rowspan="10" style="padding-top:0;" nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
   
             <td align="left" width="210">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="50"/>
             </td>
         
       
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_name" inputName="客户名称" maxLength="50"/>      </td>
            
             <td align="right"><fmt:message key="internal_code"/></td>
            <td align="left"><input type="text" class="text_field" name="internal_code" inputName="员工姓名" maxLength="50" style="width:250"/>            </td>
         
        </tr>
           <tr>
            <td align="right"><fmt:message key="cust_code"/></td>
   
             <td align="left" width="210">
             <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="50"/>
             </td>
         
            <td align="right"><fmt:message key="post_status"/></td>
            <td align="left" >
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd", -1, "POST_STATUS_BD", "", " id=post_status_bd", false)%>
            </td>
       
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_id" name="cust_id"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="choose_customer" height="440" width="600"  style="width:234px"/>
                  </td>
                         
        </tr>
        
            <tr>
            <td align="right"><fmt:message key="user_name"/></td>
   
             <td align="left" width="210">
             
            <r:comboSelect id="combo_cs" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                  
                       messagekey="please_choose" />
             
             
             </td>
         
       
            <td align="right"><fmt:message key="cust_send_id"/></td>
            <td align="left">

                
                  <w:lookup onReturnFunc="rtnFuncSend" readonly="true" id="cust_send_id" displayValue=""   name="cust_send_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" messagekey="choose_agent" height="440" width="800" style="width:170px">
                </w:lookup>
                
                    </td>
            
             <td align="right"><fmt:message key="cust_receive_id"/></td>
            <td align="left">
                  <select name="cust_receive_id1" id="cust_receive_id1" style="width:250">
                     <option value="">请选择</option>
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>
                              
              </td>
         
        </tr>
        <tr>
            <td align="right"><fmt:message key="send_code"/></td>
            <td align="left"><input type="text" class="text_field" name="send_code" inputName="委派单编号" maxLength="25"/>          </td>
           
             <td align="right"><fmt:message key="emp_type"/></td>
            <td align="left">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd", -1, "EMP_POST_TYPE_BD", "", " id=emp_post_type_bd", true)%>
            </td>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left"><input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="64" style="width:250"/></td>
            </td>
        </tr>
        <tr>
            <td colspan="6" align="center">
            <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
               <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>

</table>
</div>
                    
<div id="ccParent1" class="button">
    <div class="button_right">
    <!--
        <ul>
            <li class="a_2">      <a  onClick="javascript:detail_onClick();">查看个人订单</a> </li>
             <li class="e">      <a  onClick="exportEmpSend()">导出</a> </li>
            <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
            <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
        </ul>
        -->
        <input type="button" class="a_2" value="<fmt:message key="look_person_order"/>" <au:authorityBtn code="view_orderItem3" type="1"/> onClick="detail_onClick();" />
    </div>
    <div class="clear"></div>
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryzhuanyiList"
        width="98%"
        height="400px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="datacell_formid"
        pageSize="100"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="<input type='checkbox' name='empselect' onclick='emp_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus" sortAt="none" align="center">
       </r:field>
       <r:field fieldName="emp_name" messagekey="emp_name" width="100px">
                  
       </r:field>
      <r:field fieldName="emp_code" width="140px" messagekey="emp_code">
      </r:field>
      <r:field fieldName="move_desc" messagekey="move_desc">
      </r:field>
      
      <r:field fieldName="id_card" messagekey="emp_card_no1">
      </r:field>
      
      <r:field fieldName="cust_code" messagekey="cust_code">
      </r:field>
      
      <r:field fieldName="cust_name" messagekey="cust_name" >
      </r:field>
      <r:field fieldName="start_date" messagekey="fee_start_date"  allowModify="false" >
        <w:date format="yyyy-MM-dd" />
      </r:field>
      <r:field fieldName="end_date" messagekey="fee_end_date" allowModify="false"  >
        <w:date format="yyyy-MM-dd" />
      </r:field>
      
      <r:field fieldName="post_status_bd" messagekey="status_name"  >
          <d:select dictTypeId="POST_STATUS_BD" />
      </r:field>
      
      
      <r:field fieldName="on_post_date" messagekey="on_post_date"   allowModify="false">
           <w:date format="yyyy-MM-dd" />
      </r:field>
      
        <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date"  allowModify="false">
          <w:date format="yyyy-MM-dd" />
      </r:field>
       <r:field fieldName="off_post_date" messagekey="off_post_date1"  allowModify="false">
         <w:date format="yyyy-MM-dd" />
      </r:field>
      
       <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1"  allowModify="false">
         <w:date format="yyyy-MM-dd" />
      </r:field>
      
      
      
       <r:field fieldName="name" messagekey="emp_type">
      </r:field>
      
    <r:field fieldName="city_name" messagekey="city"  >
          
      </r:field>
      
    <r:field fieldName="isonline" messagekey="isonline"  >
    </r:field>
      
    </r:datacell>
    </div>
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


        <tr>
            <td align="right"><fmt:message key="choose_send"/></td>
   
             <td align="left" width="250" nowrap="nowrap">
              <input id="security_unit_id"  type="hidden" class="text_field" name="security_unit_id" inputName="社保办理方" maxLength="50"/>
              <input id="fund_security_unit_id"  type="hidden" class="text_field" name="fund_security_unit_id" inputName="公积金办理方" maxLength="50"/>
              <input id="hire_security_unit_id"  type="hidden" class="text_field" name="hire_security_unit_id" inputName="用退工办理方" maxLength="50"/>
             <input id="send_id"  name="send_id"  type="hidden"/>
             <input id="city_name"  name="city_name"  type="hidden"/>
             
             <w:lookup onReturnFunc="rtnFuncSend_id" readonly="true" id="send_name" name="send_name"  lookupUrl="#"
                            messagekey="choose_send" height="440" width="800"  style="width:170px"    />
             </td>
         
       
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
            <input  id="customer_id"  type="hidden" class="text_field" name="customer_id" inputName="客户名称" maxLength="50"/>
            <input   id = "customer_name"  type="text" class="text_field" name="customer_name" inputName="客户名称" maxLength="50" readonly="readonly"/>
            <input   id = "customer_code"  type="hidden" class="text_field" name="customer_code" inputName="客户名称" maxLength="50" />
            
                 </td>
            
             <td align="right"><fmt:message key="cust_receive_name"/></td>
            <td align="left">
           
            <input type="hidden" class="text_field" name="cust_receive_id"      id="cust_receive_id"   inputName="接受单位" maxLength="50"/>
            <input type="text" class="text_field" name="cust_receive_name"  id="cust_receive_name"  inputName="接受单位" maxLength="50" readonly="readonly" />
            </td>
            
            
         
        </tr>
        <tr>
            <td align="right"><fmt:message key="choose_quotation"/></td>
            <td align="left" nowrap="nowrap">
            <w:lookup onReturnFunc="rtnFuncquotation_id" readonly="true" id="quotation_name" name="quotation_name"  lookupUrl="#"
                            messagekey="choose_quotation" height="440" width="800"  style="width:170px"    />
            <!--<select   id= "quotation_name"   name="quotation_name" style="width:235">
            <option value="--">请选择</option>
            </select>
            
                   --></td>
           
             <td align="right"><fmt:message key="move_effect_date"/></td>
            <td align="left">
            
          
 
         <w:date format="yyyy-MM-dd"     id = "effect_date"   name="effect_date" width="80px" property="writeBackFormValues/transact_date_from"   onchange="changePost();"/>
            </td>
            
             <td align="right"><fmt:message key="apply_on_post_date"/></td>
            <td align="left">
            <w:date format="yyyy-MM-dd"    id = "apply_on_post_date"    name="apply_on_post_date" width="80px" property="writeBackFormValues/transact_date_from" />
            </td>
         

        </tr>
        
    <tr>
            <td colspan="6" align="center">
            
                <div class="mx_button">
                    <input type="button" class="icon_2" value="<fmt:message key="ask_move"/>" <au:authorityBtn code="sbzy_bzy" type="1"/> onClick="submit_onClick();"   width="200"/>
                    </div>
            
            </td>
</tr>

</table>
</div>


</div>
</div>
</form>



</body>
</html>
<script>
    $id("send_name").beforeOpenDialog = function ( dialog1) {
        if (dialog1.lookupUrl == "#" ) {
        alert("<fmt:message key="selecte_emp"/>");
            return false;
        }else{
            return true;
        }
    }
    
    
     $id("quotation_name").beforeOpenDialog = function (dialog1) {
        var send_customerid = $id("customer_id").value ;
        if (send_customerid == null ||send_customerid =='') {
        alert("<fmt:message key="please_choose_send1"/>");
            return false;
        }else{
            dialog1.lookupUrl = "<venus:base/>/EmppostAction.do?cmd=gotoquotationClzLookupPage&send_customerid="+send_customerid ;
            return true;
        }
    }
    
    
      function  changePost(){
         var   effect_date  =document.getElementById("effect_date").value;   //转移生效日期
         $id("apply_on_post_date").setValue($id("effect_date").value);
  
  
  }
</script>


</fmt:bundle>
