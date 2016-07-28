<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

	<%
	   String security_group_id= request.getParameter("security_group_id");
	   String report_month= request.getParameter("report_month");
	   if(report_month==null || report_month.equals("null") || report_month.equals("undefined")){
	       report_month = "";
	   }
	   String  isQuery = request.getParameter("isQuery")==null?"false":request.getParameter("isQuery");
	%>

<html>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listTransactionHousingEmpsecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listTransactionHousingEmpsecurity0000'/></title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listTransactionHousingEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                //alert(elementCheckbox[i].value);
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                number += 1;  //游标加1
               if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    
    function findPostIds(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listStopHousingEmpsecurity0006'/>的checkbox
        var number = 0;  //定义游标
        var postIds = null;  //定义id值的数<fmt:message key='listStopHousingEmpsecurity0004'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listStopHousingEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                var enCur = $id("datacell1").dataset.get(i);
                number += 1;  //游标加1
               if(postIds == null) {
                    postIds = new Array(0);
                }
                postIds.push(enCur.getProperty("emp_post_id"));  //加入选中的checkbox
            }
        }
        return postIds;
    }
    //判断是否已经催呼过
    function isCallCenter(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listStopHousingEmpsecurity0006'/>的checkbox
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listStopHousingEmpsecurity0004'/>
            if(elementCheckbox[i].checked) {  //如果被选中
                var enCur = $id("datacell1").dataset.get(i);
                var call_center_bd = enCur.getProperty(idName)
                if(call_center_bd==null||call_center_bd=='1'){
                	return false ;
                }
            }
        }
        return true ;
    }
    
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listTransactionHousingEmpsecurity0067'/><fmt:message key='listTransactionHousingEmpsecurity0012'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listTransactionHousingEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listTransactionHousingEmpsecurity0009'/>"
            form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function toAdd_onClick() {  //<fmt:message key='listTransactionHousingEmpsecurity0067'/>增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/empserviceitem/insertEmpserviceitem.jsp";
        form.submit();
    }
    //检查<fmt:message key='listTransactionHousingEmpsecurity0006'/>没<fmt:message key='listTransactionHousingEmpsecurity0006'/>选择行,<fmt:message key='listTransactionHousingEmpsecurity0010'/>,并且把选择行对象<fmt:message key='listTransactionHousingEmpsecurity0013'/>改成“<fmt:message key='listTransactionHousingEmpsecurity0012'/>”<fmt:message key='listTransactionHousingEmpsecurity0013'/>
    function checkSelections(checkboxName) {  
        var elementCheckbox = document.getElementsByName(checkboxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                //alert(enCur.getProperty("social_unit_id")+"--"+enCur.getProperty("is_social_not_stop")+"--"+enCur.getProperty("social_copy_month"));
                if(enCur.getProperty("insert_back_reason")==null||enCur.getProperty("insert_back_reason")==""){
                    alert(enCur.getProperty("emp_name")+" <fmt:message key='listTransactionHousingEmpsecurity0015'/>");
                    return false;
                }
            }
        }
        if(ids==null){
            alert("<fmt:message key='listTransactionHousingEmpsecurity0016'/>");
            return false;
        }
        return true;
    }
     //提交公积金申请
    function apply_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listTransactionHousingEmpsecurity0017'/>')) {
                $id('applyMethod').value="apply";
                $id("datacell1").submit();//提交       
            }    
    }

    //简单的模糊查询
    function simpleQuery_onClick(){  
        //$id("com2").refresh();
    
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + " />";
    }
    
    function changeCheck(rowNo,checkB){
        //alert(checkB.value + "" + rowNo);
        //alert(rowNo);
        var enCur = $id("datacell1").dataset.get(rowNo);
        $id("datacell1").isModefied = true;
        enCur.status = Entity.STATUS_MODIFIED;
    }
    
    function ClickRow(value,value1){
        //document.getElementById("div1").style.display='';
        //alert("id="+value+"city_id="+value1);
        $id("security_group_id").value = value;
        $id("selectcity_id").value = value1;
        
        $id("product_id").queryParam= "<param><key>security_group_id</key><value>" + value + "</value><key>city_id</key><value>" + value1 + "</value></param>";
       
        $id("celllist1").loadData();
        //$id("celllist1").refresh();
        $id("product_id").loadData();
        $id("product_id").refresh();
        $id("celllist1").refresh();
        
        
        
        $id("celllist2").loadData();
        $id("celllist2").refresh();
        
        $id("celllist3").loadData();
        $id("celllist3").refresh();
    }
    
    
//操作
//<fmt:message key='listTransactionHousingEmpsecurity0072'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listTransactionHousingEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
//<fmt:message key='listTransactionHousingEmpsecurity0073'/>界面
function in_Transaction_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listTransactionHousingEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    //var report_month=document.getElementById("report_month").value;
    var curId = '' + ids[0];
    var entity1 = $id("datacell1").dataset.findEntity("id", curId);
    var report_month = entity1.getProperty("report_month");
    //如果员工<fmt:message key='listTransactionHousingEmpsecurity0026'/>两条待办记录则给用户提示
    var entity = $id("datacell1").dataset.findEntity("id", ids[0]);
    //alert(entity.getProperty("security_group_id"));
    var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
        myAjax.addParam("emp_id", entity.getProperty("emp_id"));
        myAjax.addParam("security_group_id", entity.getProperty("security_group_id"));
        myAjax.addParam("emp_post_id", entity.getProperty("emp_post_id"));
        myAjax.addParam("type","4");
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
              if(myAjax.getProperty("returnValue")=="ordererror"){
                alert(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0024'/>');
                return;
              }
              else if(myAjax.getProperty("returnValue")=="updateerror"){
                alert(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0025'/>');
                return;
              }
              else if(myAjax.getProperty("returnValue")=="modifyerror"){
	               alert(entity.getProperty("emp_name")+'该员工存在修改订单审批中的数据！');
	               isali = false;
	               return;
	             }
              else if(myAjax.getProperty("returnValue")>1){
                if(confirm(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0026'/>'+myAjax.getProperty("returnValue")+'<fmt:message key='listTransactionHousingEmpsecurity0027'/>')){
                    window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0]+'&report_month='+report_month+'&_ts='+(new Date()).getTime()+'&applytype=1','','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
                }
              }else{
                window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0]+'&report_month='+report_month+'&_ts='+(new Date()).getTime()+'&applytype=1','','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
              }
         }
}

function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        setTimeout(simpleQuery_onClick,4000);
    }
}
//批量退回操作
function batch_back_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm('<fmt:message key='listTransactionHousingEmpsecurity0028'/>')) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}
//批量<fmt:message key='listTransactionHousingEmpsecurity0076'/>
function batch_cancel_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        
        var postIds = findPostIds("checkbox_template","id");  //取得多选框的选择项
        if(postIds == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        
        var security_group_id=document.getElementById("security_group_id").value;
        var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
            myAjax.addParam("postIds", postIds);
            myAjax.addParam("security_group_id",security_group_id);
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
                  if(myAjax.getProperty("returnValue")=="modifyerror"){
                       alert('存在修改订单审批中的数据！');
                       isali = false;
                       return;
                  }else{
                    if(confirm('<fmt:message key='listTransactionHousingEmpsecurity0030'/>')) {
                            //$id('Method').value="batchback";
                            $id("datacell1").submit();//提交       
                    }
                  }
             }
    }
    
    //判断pb_emp_post.is_employ_notice方法
    function isEmployNotice(postid){
    	 var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkNoticetype");
         myAjax.addParam("postId", postid);
         myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         var a = "";
          if( returnNode ) {
          	a = myAjax.getProperty("returnValue")
          }
         return a;
    }
    
    //催呼确认
  function callBackByOther(reg){
        if(reg == null||reg==''){
           alert("请填写催呼原因！") ;
           return false ;
        }
        
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项        
	    if(ids == null) {  //如果ids为空
	        alert('请选择一条记录！');
	        return;
	    }else{
	    	//判断pb_emp_post.is_employ_notice决定发邮件还是催呼
	    	var postIds = [];//定义需要催呼的id数组
           var sendContext = [];//定义需要发送邮件的数组
           var elementCheckbox = document.getElementsByName("checkbox_template");
           for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
               if(elementCheckbox[i].checked) {  //如果被选中
                   var entity = $id("datacell1").dataset.get(i);
                   var isEmployeeNotice = isEmployNotice(entity.getValue("emp_post_id"));
                   if(isEmployeeNotice=='1'){//为1催呼
                   		var call_center_bd = entity.getValue("call_center_bd");
                   		if(call_center_bd==null||call_center_bd=='1'){//过滤掉催呼过的数据
                		}else{
                			postIds.push(entity.getValue("emp_post_id"));
                		}
                   }else{//否则发邮件
                   		var jsonStr = '{"cs_email":"'+entity.getValue("cs_email")+'","emp_code":"'+entity.getValue("emp_code")+'",'+'"emp_name":"'+entity.getValue("emp_name")+'",'+'"id_card":"'+entity.getValue("id_card")+'",'+'"cust_name":"'+entity.getValue("cust_name")+'",'+'"receive_cs_name":"'+entity.getValue("receive_cs_name")+'",'
		                   +'"accounts":"'+entity.getValue("accounts")+'",'+'"transact_type_name":"'+entity.getValue("transact_type_name")+'",'+'"social_unit_name":"'+entity.getValue("social_unit_name")+'",'+'"start_month":"'
		                   +entity.getValue("start_month")+'",'+'"transact_remarks":"'+entity.getValue("transact_remarks")+'"}';
		                   sendContext.push(jsonStr);//组装json字符串
                   }
               }
           }
           
            if(postIds.length==0&&sendContext.length==0){
           	alert('操作成功');
           	return;
           }
           
           if(postIds.length!=0){
           	    var security_group_id=document.getElementById("security_group_id").value;
         		var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
            	myAjax.addParam("postIds", postIds);
            	myAjax.addParam("security_group_id",security_group_id);
            	myAjax.submit();
            	var returnNode = myAjax.getResponseXMLDom();
            	if( returnNode ) {
                  if(myAjax.getProperty("returnValue")=="modifyerror"){
                       alert('存在修改订单审批中的数据！');
                       return;
                  }else{
                    if(confirm("你确定发送未办反馈？")) {
                            $id('Method').value="callcenter";
                            $id('welfaer_type').value="2";
                            $id('welfarefailreason').value=reg;
                            $id("datacell1").submit();//提交       
                    }
                  }
             }
           }
           
           if(sendContext.length != 0){
              //sendContext = encodeURI(encodeURI(sendContext));//编码json
               var urlStr = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcelOrSendEmail";
               jQuery.ajax({
                   type : "post",
                   url : urlStr,
                   dataType : "html",
                   data: {sendContext:sendContext.toString()},
                   error: function(){
                        alert('Ajax Error!');
                        return;
                    },success : function(data) {
                       alert(data);
                   }
               });
           }
	    }
    }
    //催呼和邮件合并 add by yiwenbin
    function feedback(){
        var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/tocallcenterremark.jsp";
        window.open(url,'','height=250px,width=400px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=填写催呼原因');
    }
    
   //<fmt:message key='listTransactionHousingEmpsecurity0075'/>
   function batch_transaction_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        //先判断是否<fmt:message key='listTransactionHousingEmpsecurity0006'/>问题数据<fmt:message key='listTransactionHousingEmpsecurity0026'/>
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            //如果员工<fmt:message key='listTransactionHousingEmpsecurity0026'/>两条待办记录则给用户提示
            var entity = $id("datacell1").dataset.findEntity("id", ids[i]);
            var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
            myAjax.addParam("emp_id", entity.getProperty("emp_id"));
            myAjax.addParam("security_group_id", entity.getProperty("security_group_id"));
            myAjax.addParam("emp_post_id", entity.getProperty("emp_post_id"));
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            var isali = true;
            if( returnNode ) {
                  if(myAjax.getProperty("returnValue")=="ordererror"){
                    alert(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0024'/>');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="ishaveerror"){
                    alert(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0034'/>');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="updateerror"){
                    alert(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0025'/>');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")=="modifyerror"){
                    alert(entity.getProperty("emp_name")+'该员工存在修改订单审批中的数据！');
                    isali = false;
                    return;
                  }
                  else if(myAjax.getProperty("returnValue")>1){
                    if(!confirm(entity.getProperty("emp_name")+' <fmt:message key='listTransactionHousingEmpsecurity0026'/>'+myAjax.getProperty("returnValue")+'<fmt:message key='listTransactionHousingEmpsecurity0027'/>')){
                        isali = true;
                    }else{
                        isali = false;
                        return;
                    }
                  }else{
                       isali = true;
                  }
                  //验证全部通过
                  if(isali){
                       if(confirm('<fmt:message key='listTransactionHousingEmpsecurity0038'/>')) {
                            $id('Method').value="batchtransaction";
                            $id("datacell1").submit();//提交       
                        }
                  }else{
                       break;
                       return;
                  }
                  
             }
            
        }
   }
//<fmt:message key='listTransactionHousingEmpsecurity0077'/>所选备注
function save_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key='listTransactionHousingEmpsecurity0040'/>');
            return;
        }
        $id('Method').value="saveremark";
        $id("datacell1").submit();//提交       

}

//<fmt:message key='listTransactionHousingEmpsecurity0078'/>excel
    function exportExcel_onClick(){  //<fmt:message key='listTransactionHousingEmpsecurity0078'/>Excel
        var queryType=document.getElementById("queryType").value;
       // var stopType=document.getElementById("stopType").value;
        var group_id=document.getElementById("security_group_id").value;
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel3&queryType="+queryType+"&stopType="+""+"&group_id="+group_id;
        //form.cmd.value="exportExcel;
        form.submit();
    } 
   //查看<fmt:message key='listTransactionHousingEmpsecurity0041'/>
    function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listTransactionHousingEmpsecurity0041'/>');  //查看<fmt:message key='listTransactionHousingEmpsecurity0041'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

function changeit(){
    //alert($id("security_group_id").value);
   $id("com1").addParam("security_group_id", $id("security_group_id").value);
   $id("com1").loadData();
   $id("com1").refresh();
}

//邮件客服触发事件
function sendEmailToCS(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	    if(ids == null) {  //如果ids为空
	        alert('请选择一条记录！');
	        return;
	    }else{
	        if(confirm("邮件通知客服，是否继续！")){
	           var sendContext = [];
	            var elementCheckbox = document.getElementsByName("checkbox_template");
	            for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
	                if(elementCheckbox[i].checked) {  //如果被选中
	                    var entity = $id("datacell1").dataset.get(i);
	                    var jsonStr = '{"cs_email":"'+entity.getValue("cs_email")+'","emp_code":"'+entity.getValue("emp_code")+'",'+'"emp_name":"'+entity.getValue("emp_name")+'",'+'"id_card":"'+entity.getValue("id_card")+'",'+'"cust_name":"'+entity.getValue("cust_name")+'",'+'"receive_cs_name":"'+entity.getValue("receive_cs_name")+'",'
	                    +'"accounts":"'+entity.getValue("accounts")+'",'+'"transact_type_name":"'+entity.getValue("transact_type_name")+'",'+'"social_unit_name":"'+entity.getValue("social_unit_name")+'",'+'"start_month":"'
	                    +entity.getValue("start_month")+'",'+'"transact_remarks":"'+entity.getValue("transact_remarks")+'"}';
	                    sendContext.push(jsonStr);//组装json字符串
	                }
	            }
	            
	            if(sendContext != null){
	               //sendContext = encodeURI(encodeURI(sendContext));//编码json
	                var urlStr = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcelOrSendEmail";
	                jQuery.ajax({
	                    type : "post",
	                    url : urlStr,
	                    dataType : "html",
	                    data: {sendContext:sendContext.toString()},
	                    error: function(){
	                         alert('Ajax Error!');
	                         return;
	                     },success : function(data) {
	                        alert(data);
	                    }
	                });
	            }
	        }
	    }
    }
    
    
    
    
    
    
//批量<fmt:message key='listTransactionHousingEmpsecurity0076'/>
function selectedEntitiesXML() {
        var entitiesXML;
        var dc = $id("datacell1");
        var ds = dc.dataset;
        //checkbox_template
        //checkbox_template
        jQuery("input[name='checkbox_template']").each(function(i) {
            if ( jQuery(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                entitiesXML += entity.toString();
            }
        });
        return entitiesXML;
    }

     function getEmpId2(){
          var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=updateforline&TSflag=2";
          var xmlSubmit = selectedEntitiesXML();
          if (typeof(xmlSubmit)=="undefined" || xmlSubmit=="" || xmlSubmit=="null")
       	  {
       	     alert("请选择要操作的数据") ;
       	     return false;
       	 }
          //alert(xmlSubmit);
          var myAjax = new Ajax(action);
          myAjax.loadData(xmlSubmit);
          var returnNode = myAjax.getResponseXMLDom();
          if(returnNode) 
          {
              if(myAjax.getValue("root/data/returnValue")) 
              {
                  alert(myAjax.getValue("root/data/returnValue"));
                  $id("gjjbl_line").disabled = true;
                  simpleQuery_onClick();
                  $id("gjjbl_line").disabled = false;
                  // window.close();
              } 
              else
              {
                  alert('提交失败');
              }
          } 
          else 
          {
              alert('提交失败');
          }
      }
     
     function getEmpId3(){
    	 var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
         if(ids == null) {  //如果ids为空
             alert('<fmt:message key="select_one_record"/>');
             return;
         }
         var idSelected="";
    	 for(var i=0;i<ids.length;i++){
             var curId = '' + ids[i];
             var entity1 = $id("datacell1").dataset.findEntity("id", curId);
             if(idSelected!=""){
            	 idSelected+=",";
             }
             idSelected+=entity1.getProperty("emp_post_id");
    	 }
     	 alert(idSelected); 
     }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_2 %>">
<input type="hidden" id="Method" name="Method" value=""/>
<input type="hidden" id="queryType" name="queryType" value="transact"/>
<input type="hidden" id="report_month" name="queryType" value="<%=report_month %>"/>
<input type="hidden" id="welfaer_type" name="welfaer_type" value=""/> 
<input type="hidden" id="welfarefailreason" name="welfarefailreason" value=""/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key='listTransactionHousingEmpsecurity0000'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0109'/></td>
              <td align="left">
                    <select id="security_group_id"  name="security_group_id" style="width: 200px" onchange="changeit();">
                            <option value="0" selected="selected"><fmt:message key='listTransactionHousingEmpsecurity0043'/></option>
                            <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key='listTransactionHousingEmpsecurity0044'/></option>
                            <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key='listTransactionHousingEmpsecurity0045'/></option>
                    </select>
              </td>
              <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0046'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listTransactionHousingEmpsecurity0046'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0048'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listTransactionHousingEmpsecurity0048'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0050'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listTransactionHousingEmpsecurity0048'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0052'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" value="${param.customer_code }" inputName="<fmt:message key='listTransactionHousingEmpsecurity0052'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0054'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" value="${param.customer_name }"  inputName="<fmt:message key='listTransactionHousingEmpsecurity0054'/>" maxLength="50" size="25"/>
            </td>
            <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0056'/></td>
            <td align="left">
                <r:comboSelect id="com1" name="transact_type_id" 
                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
                    textField="type_name" 
                    valueField="id" 
                    xpath="SecuritygroupnewVo"                   
                    messagekey='listTransactionHousingEmpsecurity0043' 
                    width="205px">
                </r:comboSelect>
            </td>
            <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0058'/></td>
            <td align="left">
                <select name="hire_fire_status" style="width: 205px">
                    <option value=""><fmt:message key='listTransactionHousingEmpsecurity0043'/></option>
                    <option value="0"><fmt:message key='listTransactionHousingEmpsecurity0060'/></option>
                    <option value="1"><fmt:message key='listTransactionHousingEmpsecurity0061'/></option>
                    <option value="2"><fmt:message key='listTransactionHousingEmpsecurity0062'/></option>
                </select>
<!--                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="<fmt:message key='listTransactionHousingEmpsecurity0043'/>" style="width: 205px"/>-->
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0064'/></td>
              <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey='listTransactionHousingEmpsecurity0043'
                value="${param.social_unit_id }"
                width="205px">
                
            </r:comboSelect> 
              </td>
            <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0066'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" size="8"/><fmt:message key='listTransactionHousingEmpsecurity0067'/><w:date format="yyyy-MM-dd" name="apply_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0108'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  value="1" nullLabel="--请选择--" style="width: 205px"/>
            </td>
             <td align="right"><fmt:message key='listTransactionHousingEmpsecurity0070'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        <tr>
        
         	<td align="right">同步状态</td>
            <td align="left">
                <d:select name="sync_status" id="sync_status" dictTypeId="SYNC_STATUS" nullLabel="--请选择--" style="width:200px;"/>
            </td>
            <td align="right">专员</td>
            <td align="left">
	            <r:comboSelect id="com3" name="commissioner" 
	                    queryAction="/FAERP/EmpsecurityAction.do?cmd=GetCommissioner&Role_Type_BD=6"
	                    textField="emp_name" 
	                    valueField="emp_id" 
	                    xpath="EmpsecurityVo"                   
	                    messagekey='listTransactionHousingEmpsecurity0043' 
	                    width="205px">
	                </r:comboSelect>
             </td>
            
            <td align="right">办理阶段</td>
            <td align="left">
                <select name="sel_uav_line_str" style="width: 205px">
                	<option value="">--请选择--</option>
                    <option value="IA">IA</option>
                    <option value="MW">MW</option>
                </select>
             </td>
            
            <td align="left" colspan="1">
                
            </td>
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
                    <div class="button_right">
                        <!--<ul>
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0072'/> </a> </li>
                            <li class="bl_1">      <a onClick="javascript:in_Transaction_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0073'/> </a></li>
                            <li class="pl">      <a onClick="javascript: batch_back_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0074'/> </a></li>
                            <li class="h_1">      <a onClick="javascript:batch_transaction_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0075'/> </a></li>
                            <li class="h_1">       <a  onClick="javascript:batch_cancel_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0076'/></a> </li>
                            <li class="bc">         <a  onClick="javascript:save_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0077'/> </a> </li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0078'/> </a> </li>
                              //<li class="dj">         <a  onClick="javascript:_onClick();"><fmt:message key='listTransactionHousingEmpsecurity0079'/> </a> </li> 
                        </ul>
                    -->
                     <input class="a_2" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0072'/>"  <au:authorityBtn code="view_orderItem21" type="1"/>  onClick="detail_onClick();">
                     <input class="bl_1" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0073'/>"  <au:authorityBtn code="gjjbl_jrbl" type="1"/>  onClick="in_Transaction_onClick();">
                     <input class="pl" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0074'/>"  <au:authorityBtn code="gjjbl_plthsq" type="1"/>  onClick="batch_back_onClick();">
                     <input class="h_1" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0075'/>"  <au:authorityBtn code="gjjbl_plbl" type="1"/>  onClick="batch_transaction_onClick();">
                     <input class="h_1" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0076'/>"  <au:authorityBtn code="gjjbl_bubl" type="1"/>  onClick="batch_cancel_onClick();">
                     <input class="bc_1" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0077'/>"  <au:authorityBtn code="gjjbl_save" type="1"/>  onClick="save_onClick();">
                     <input class="e" type="button"   value=" <fmt:message key='listTransactionHousingEmpsecurity0078'/>"  <au:authorityBtn code="gjjbl_exp" type="1"/>  onClick="exportExcel_onClick();">
                     <!--  <input class="yj_1" type="button"   value="邮件客服"  <au:authorityBtn code="gjjbl_email" type="1"/> onClick="sendEmailToCS();">
                     <input class="h_1" type="button"   value="催呼确认"  <au:authorityBtn code="gjjbl_email" type="1"/>  onClick="batch_callcenter_onClick();">-->
                     <input class="yj_1" type="button"   value="未办反馈"  <au:authorityBtn code="gjjbl_email" type="1"/> onClick="feedback();">
                      <input class="bl_1" type="button"  Id="gjjbl_line"  value="线路转换"   onClick="getEmpId2();">
                    </div>
                </div>   
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=transactionSimpleQuery" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=transactionSecurity" width="98%"
        xpath="EmpsecurityVo"
        submitXpath="EmpsecurityVo"
        paramFormId="datacell_formid" height="318px"
        freezeNumber="3"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
      <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      
      </r:field>      
        
      <r:field fieldName="emp_code" sortAt="none" messagekey='listTransactionHousingEmpsecurity0048' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0046' width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      <r:field fieldName="accounts" label="公积金帐号" width="0px"></r:field>   
      <r:field fieldName="group_name" sortAt="none" messagekey="listTransactionHousingEmpsecurity0109" width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="internal_code" sortAt="none" messagekey='listTransactionHousingEmpsecurity0089' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listTransactionHousingEmpsecurity0090' width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" messagekey="listTransactionHousingEmpsecurity0091" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <!--<r:field fieldName="emp_post_type_bd" sortAt="none" messagekey='listTransactionHousingEmpsecurity0092' width="100px" allowModify="false">
            <d:select dictTypeId="EMP_POST_TYPE_BD"/> 
      </r:field>-->
      
      <r:field fieldName="cust_code" sortAt="none" messagekey='listTransactionHousingEmpsecurity0052' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0054' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0095' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_dept_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0099' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <!--<r:field fieldName="send_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0096' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_big_type_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0097' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0098' width="100px" allowModify="false">
            <h:text />      
      </r:field>陈旭<fmt:message key='listTransactionHousingEmpsecurity0012'/>-->
      
      <!--<r:field fieldName="cust_send_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0100' width="100px" allowModify="false">
            <h:text />      
      </r:field>-->
      
      <!--<r:field fieldName="cust_receive_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0101' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" sortAt="none" messagekey='listTransactionHousingEmpsecurity0102' width="100px" allowModify="false">
            <h:text />
      </r:field>
      
      <r:field fieldName="on_post_date" sortAt="none" messagekey='listTransactionHousingEmpsecurity0103' width="100px" allowModify="false">
            <h:text />      
      </r:field>陈旭<fmt:message key='listTransactionHousingEmpsecurity0012'/>-->
      
      <r:field fieldName="on_post_desc" sortAt="none" messagekey='listTransactionHousingEmpsecurity0105' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_off_post_date" sortAt="none" messagekey='listTransactionHousingEmpsecurity0106' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="emp_account" sortAt="none" messagekey='listTransactionHousingEmpsecurity0107' width="100px" allowModify="false">
            <h:text readonly="true"/>      
      </r:field>
      
      <r:field fieldName="transact_type_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0056' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <!--<r:field fieldName="hire_fire_status" sortAt="none" messagekey='listTransactionHousingEmpsecurity0058' width="100px" allowModify="false">
            <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />  
      </r:field>-->
      
      <r:field fieldName="social_unit_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0064' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_man_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0111' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_date" sortAt="none" messagekey='listTransactionHousingEmpsecurity0066' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" sortAt="none" messagekey='listTransactionHousingEmpsecurity0113' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="report_month" width="100px" messagekey='listTransactionHousingEmpsecurity0114'>
        <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
       </r:field>
      <r:field fieldName="back_reason" sortAt="none" messagekey='listTransactionHousingEmpsecurity0116' width="100px" >
            <h:text />      
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" messagekey='listTransactionHousingEmpsecurity0117' width="100px" >
            <h:text />      
      </r:field>

      <r:field fieldName="transact_remarks" sortAt="none" messagekey='listTransactionHousingEmpsecurity0118' width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="old_cust_name" sortAt="none" messagekey='listTransactionHousingEmpsecurity0123' width="200px" allowModify="false">
            <h:text/>
      </r:field>
      
      <r:field fieldName="fund_base" sortAt="none" messagekey='listTransactionHousingEmpsecurity0119' width="100px" allowModify="false">
            <h:text/>
      </r:field>
      
      <r:field fieldName="fund_e_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>

      <r:field fieldName="fund_p_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="supplyfund_base" sortAt="none" messagekey='listTransactionHousingEmpsecurity0122' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="supplyfund_e_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="supplyfund_p_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="callcenterremark" label="催呼原因" width="100px" allowModify="false" ></r:field>
		<r:field fieldName="call_center_bd" label="催呼状态" width="100px" allowModify="false" >
		<d:select dictTypeId="CALL_CENTER_BD" disabled="true"/>   
		</r:field>
		<r:field fieldName="callcenterresult" label="催呼结果" width="100px" allowModify="false">
		<d:select dictTypeId="CALLCENTERRESULT" disabled="true" />   
		</r:field>
		<r:field fieldName="callcenterresultremark" label="催呼结果备注" width="100px" allowModify="false"></r:field>
		 <r:field fieldName="sync_status" label="同步状态" width="150px" allowModify="false">
	          <d:select dictTypeId="SYNC_STATUS" disabled="true"/>
	     </r:field>
	      
	     <r:field fieldName="sync_remark" label="同步备注" width="150px" allowModify="false">
	           <d:select dictTypeId="SYNC_REMARK" disabled="true"/>  
	     </r:field>
	     
	     <r:field fieldName="sync_date" label="同步时间" width="130px" allowModify="false">
                                <w:date format="yyyy-MM-dd HH:mm:ss" />
         </r:field>
         <r:field fieldName="rename_remark" label="同步历史" width="350px" allowModify="false">
	           <h:text/>
	      </r:field>
			<r:field fieldName="uav_line_str" label="办理阶段" width="80px"   allowModify="false">
				<h:text />
			</r:field>
			<r:field fieldName="name" label="专员" width="80px"   allowModify="false">
				<h:text />
			</r:field>
			<r:field fieldName="uav_status" label="发送" width="0px"   allowModify="false">
				<h:text />
			</r:field>

<!--      <r:field fieldName="unemployment_base" sortAt="none" messagekey='listTransactionHousingEmpsecurity0125' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="unemployment_e_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0120' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="unemployment_p_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0121' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="industrial_base" sortAt="none" messagekey='listTransactionHousingEmpsecurity0128' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="industrial_e_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0120' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="industrial_p_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0121' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="maternity_base" sortAt="none" messagekey='listTransactionHousingEmpsecurity0131' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="maternity_e_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0120' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="maternity_p_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0121' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="disability_base" sortAt="none" messagekey='listTransactionHousingEmpsecurity0134' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="disability_e_ratio" sortAt="none" messagekey='listTransactionHousingEmpsecurity0120' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
<!--      -->
<!--      <r:field fieldName="disability_p_ratio" messagekey='listTransactionHousingEmpsecurity0121' width="100px" allowModify="false">-->
<!--            <h:text/>      -->
<!--      </r:field>-->
      
    </r:datacell>
    </div>

</div>
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">

    //解决<fmt:message key='listTransactionHousingEmpsecurity0012'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listTransactionHousingEmpsecurity0137'/>
    $id("datacell1").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           //alert("run hear");
           return false;
        }
        return true;
    }
    //后台返回的信息
    $id("datacell1").afterSubmit= function(ajax){
             $id('Method').value="saveremark";//表单提交后<fmt:message key='listTransactionHousingEmpsecurity0012'/>方法为<fmt:message key='listTransactionHousingEmpsecurity0077'/>，翻页时提交表单用<fmt:message key='listTransactionHousingEmpsecurity0067'/>
           alert(""+ajax.getProperty("returnValue"));
    }
          /*  
    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 15){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
        return true;
    }

   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            var activeEditor = $id("datacell1").activeEditor;
            activeEntity.setProperty("transact_type_name", activeEditor.getDisplayValue(newValue));
            activeEntity.setProperty("transact_type_id", newValue);
        }
        return true;
    }    
    //忽略datacell的<fmt:message key='listTransactionHousingEmpsecurity0012'/>
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }    
   $id("datacell1").beforeRefresh = function(){
        $id("com2").refresh();
   }*/
   
   
   //解决翻页不提示数据变化
   function is_datacell_change(checkBoxName){
        var is_change = false;        
        var elementCheckbox = document.getElementsByName(checkBoxName);
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                if(ids == null) {
                    ids = new Array(0);
                }
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(enCur.getProperty("id"));  //加入选中的checkbox
                //alert(enCur.getProperty("social_unit_id")+"--"+enCur.getProperty("is_social_not_stop")+"--"+enCur.getProperty("social_copy_month"));
            }
        }
        //alert(ids);
        if(ids==null){
            is_change = false;
        }else{
            is_change = true;     
        }   
        return is_change;
   }
    /*
    function reload(){
        $id("datacell1").endEdit();
        var pilot = $id("datacell1_toolbar")
        //alert(datacell.dataset.get(0).getProperty("deptcode"));
        //是否变化
        var is_change = is_datacell_change("checkbox_template");
        if (is_change && confirm(DATACELL_MODIFY_CONFIRM)) {
            pilot.datacell.submit();
        } else {
            pilot.datacell.reload();
        }
        eventManager.stopBubble();
    }  
    */  
    
    //从公积金管理页面进来时，需要加载查询条件和<fmt:message key='listTransactionHousingEmpsecurity0114'/>列
    $id("datacell1").afterInit = function (){
	    var isQuery= <%=isQuery%>;
	    var security_group_id ='<%=security_group_id%>';
	    
	    if(isQuery){
	         if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>'){
	                document.getElementById("security_group_id").options[1].selected=true;
	        }
	        else if(security_group_id=='<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>'){
	               document.getElementById("security_group_id").options[2].selected=true;
	        }
	       $id('isClickQuery').value=true;
	       //$id("datacell1").loadData();
	       //$id("datacell1").refresh();
	      
	    }
	}
	
	$id("datacell1").afterLoadData = function(){
	       var report_month=document.getElementById("report_month").value;
           var dataset = $id("datacell1").dataset;
           if(report_month!=''){
                for(var i=0; i<dataset.getLength(); i++){
                    var entity1 = dataset.get(i);
                    entity1.setProperty("report_month",report_month);
                }         
           }
    }
</script>   
