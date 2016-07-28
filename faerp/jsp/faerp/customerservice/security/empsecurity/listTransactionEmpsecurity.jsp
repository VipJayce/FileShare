<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%
       String report_month= request.getParameter("report_month");
       if(report_month==null || report_month.equals("null") || report_month.equals("undefined")){
           report_month = "";
       }
       
       String party_id = LoginHelper.getPartyId(request);
    %>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listTransactionEmpsecurity_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listTransactionEmpsecurity0000'/></title>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script language="javascript">

var _jQuery = window.jQuery, _$ = window.$;
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listTransactionEmpsecurity0006'/>的checkbox
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
    function findCheckbox_onClick() {  //从多选框<fmt:message key='listTransactionEmpsecurity0068'/><fmt:message key='listTransactionEmpsecurity0012'/>页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listTransactionEmpsecurity0006'/>2条以上的纪录
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
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listTransactionEmpsecurity0009'/>"
            form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function toAdd_onClick() {  //<fmt:message key='listTransactionEmpsecurity0068'/>增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/empserviceitem/insertEmpserviceitem.jsp";
        form.submit();
    }
    //检查<fmt:message key='listTransactionEmpsecurity0006'/>没<fmt:message key='listTransactionEmpsecurity0006'/>选择行,<fmt:message key='listTransactionEmpsecurity0010'/>,并且把选择行对象<fmt:message key='listTransactionEmpsecurity0013'/>改成“<fmt:message key='listTransactionEmpsecurity0012'/>”<fmt:message key='listTransactionEmpsecurity0013'/>
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
                    alert(enCur.getProperty("emp_name")+"<fmt:message key='listTransactionEmpsecurity0015'/>");
                    return false;
                }
            }
        }
        if(ids==null){
            alert("<fmt:message key='listTransactionEmpsecurity0016'/>");
            return false;
        }
        return true;
    }
     //提交社保申请
    function apply_onClick(){
        if(!checkSelections('checkbox_template')){
            return;        
        }
        if(confirm("<fmt:message key='listTransactionEmpsecurity0017'/>")) {
                $id('applyMethod').value="apply";
                $id("datacell1").submit();//提交       
            }    
    }

     
    /************add by zhuyj Start 20160601**************/

    function selectedEntitiesXML() {
        var entitiesXML;
        var dc = $id("datacell1");
        var ds = dc.dataset;
        //checkbox_template
        //checkbox_template
        _$("input[name='checkbox_template']").each(function(i) {
            if ( _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                entitiesXML += entity.toString();
            }
        });
        return entitiesXML;
    }

     function getEmpId2(){
    	 var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=updateforline&TSflag=0";
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
    /*add by zhuyj end 20160601 */

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
//<fmt:message key='listTransactionEmpsecurity0073'/>
function detail_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listTransactionEmpsecurity0006'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var curId = '' + ids[0];
        var entity1 = $id("datacell1").dataset.findEntity("id", curId);
        var id=entity1.getProperty("emp_post_id");
        window.open('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }
    
//<fmt:message key='listTransactionEmpsecurity0074'/>界面
function in_Transaction_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
    if(ids == null) {  //如果ids为空
        alert('<fmt:message key="select_one_record"/>');
            return;
    }
    if(ids[0] == null || ids[0] == '' || ids.length > 1) {  //如果ids<fmt:message key='listTransactionEmpsecurity0006'/>2条以上的纪录
        alert('<fmt:message key="only_can_a_record"/>');
            return;
    }
    //如果员工存在两条待办记录则给用户提示
    var entity = $id("datacell1").dataset.findEntity("id", ids[0]);
    var report_month = entity.getProperty("report_month");
    //alert(entity.getProperty("security_group_id"));
    var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=checkRepeatEmp");
        myAjax.addParam("emp_id", entity.getProperty("emp_id"));
        myAjax.addParam("security_group_id", entity.getProperty("security_group_id"));
        myAjax.addParam("emp_post_id", entity.getProperty("emp_post_id"));
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
              if(myAjax.getProperty("returnValue")=="ordererror"){
                alert(entity.getProperty("emp_name")+"<fmt:message key='listTransactionEmpsecurity0024'/>");
                return;
              }
              else if(myAjax.getProperty("returnValue")=="updateerror"){
                alert(entity.getProperty("emp_name")+"<fmt:message key='listTransactionEmpsecurity0025'/>");
                return;
              }
              else if(myAjax.getProperty("returnValue")>1){
                if(confirm(entity.getProperty("emp_name")+' 存在'+myAjax.getProperty("returnValue")+'<fmt:message key="listTransactionEmpsecurity0027"/>')){
                    window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0]+'&report_month='+report_month,'','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
                }
              }else{
                window.open('<venus:base/>/EmpsecurityAction.do?cmd=getEmpSecurityById&id='+ids[0]+'&report_month='+report_month,'','height=600px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
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
        if(confirm("<fmt:message key='listTransactionEmpsecurity0028'/>")) {
                $id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
}
//批量<fmt:message key='listTransactionEmpsecurity0077'/>
function batch_cancel_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm("<fmt:message key='listTransactionEmpsecurity0030'/>")) {
                $id('Method').value="batchcancel";
                $id("datacell1").submit();//提交       
        }    
    }
    
   //<fmt:message key='listTransactionEmpsecurity0076'/>
   function batch_transaction_onClick(){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        //先判断是否<fmt:message key='listTransactionEmpsecurity0006'/>问题数据存在
        for(var i=0;i<ids.length;i++){  //循环checkbox组
            //如果员工存在两条待办记录则给用户提示
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
	                alert(entity.getProperty("emp_name")+"<fmt:message key='listTransactionEmpsecurity0024'/>");
	                isali = false;
	                return;
	              }
	              else if(myAjax.getProperty("returnValue")=="ishaveerror"){
                    alert(entity.getProperty("emp_name")+"<fmt:message key='listTransactionEmpsecurity0034'/>");
                    isali = false;
                    return;
                  }
	              else if(myAjax.getProperty("returnValue")=="updateerror"){
	                alert(entity.getProperty("emp_name")+"<fmt:message key='listTransactionEmpsecurity0025'/>");
	                isali = false;
	                return;
	              }
	              else if(myAjax.getProperty("returnValue")>1){
	                if(!confirm(entity.getProperty("emp_name")+"<fmt:message key='exist'/>"+myAjax.getProperty("returnValue")+"<fmt:message key='listTransactionEmpsecurity0027'/>")){
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
	                   if(confirm("<fmt:message key='listTransactionEmpsecurity0038'/>")) {
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
//<fmt:message key='listTransactionEmpsecurity0078'/>所选备注
function save_onClick(){
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key='listTransactionEmpsecurity0040'/>');
            return;
        }
        $id('Method').value="saveremark";
        $id("datacell1").submit();//提交       

}

//<fmt:message key='listTransactionEmpsecurity0079'/>excel
    function exportExcel_onClick(){  //<fmt:message key='listTransactionEmpsecurity0079'/>Excel
       var queryType=document.getElementById("queryType").value;
      // var stopType=document.getElementById("stopType").value;
       var group_id=document.getElementById("security_group_id").value;
        //window.open(url,'','height=0px,width=0px,top=0,left=0,help=no,resizable=no,scrollbars=no,location=no,status=no');
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=exportExcel1&queryType="+queryType+"&stopType="+""+"&group_id="+group_id;
        //form.cmd.value="exportExcel;
        form.submit();
    } 
//无人机加急处理
	 function uavhandle(){
		 var ids = findSelections("checkbox_template","id");  //取得多选框的选择项        
			if(ids == null) {  //如果ids为空
		  		alert('<fmt:message key="select_one_record"/>');
		  		return;
			}else{
	        	var flags=true;
	            jQuery.ajax({
	            url: '/FAERP/PremiumProcessing.do?cmd=getSecurityProductInfoZR&emp_post_id='+ids+"&date="+new Date(),
	            type: 'GET',
	            dataType: 'html',
	            async: false,
	            timeout: 80000,
	            error: function(){
	            	alert('Error loading XML document');
	                return  null;
	            },
	            success: function(text){
	            	if(text!=null){
	                   alert(text);
	                   simpleQuery_onClick();
	                }

	            }
	            });
	            return flags;
	        }
			
	 }
//催呼确认
function callBackByOther(reg){
        if(reg == null||reg==''){
           alert("请填写催呼原因！") ;
           return false ;
        }
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
        if(!isCallCenter("checkbox_template","call_center_bd")){
            alert("只有未催呼的数据才能进行催呼确认！") ;
        	return false ;
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
                    if(confirm("你确定进行催呼确认吗？")) {
                            $id('Method').value="callcenter";
                            $id('welfaer_type').value="1";
                            $id('welfarefailreason').value=reg;
                            $id("datacell1").submit();//提交       
                    }
                  }
             }
    }
    
    //获取催呼备注信息
    function batch_callcenter_onClick(){
        var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/tocallcenterremark.jsp";
        window.open(url,'','height=250px,width=400px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=填写催呼原因');
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

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" name="security_status_bd" value="<%=IEmpsecurityConstants.SECURITY_STATUS_2 %>">
<input type="hidden" id="Method" name="Method" value=""/>
<input type="hidden" id="queryType" name="queryType" value="transact"/>
<input type="hidden" id="report_month" name="report_month" value="<%=report_month %>"/>

<input type="hidden" id="welfaer_type" name="welfaer_type" value=""/> 
<input type="hidden" id="welfarefailreason" name="welfarefailreason" value=""/>

<input type="hidden" id="service_email" name="service_email" value=""/>

<div id="right">
<script language="javascript">
<%
  String security_type=request.getParameter("security_type");
if(security_type.equals("1")){
%>
   writeTableTopFesco("<fmt:message key='listTransactionEmpsecurity0000'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
if(security_type.equals("2")){
    %>
   writeTableTopFesco("<fmt:message key='listTransactionEmpsecurity0042'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
if(security_type.equals("3")){
    %>
   writeTableTopFesco("<fmt:message key='listTransactionEmpsecurity0043'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    <%
}
%>
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
              <td align="right"><fmt:message key='listApplyEmpsecurity1000'/></td>
              <td align="left">
                    <select id="security_group_id" name="security_group_id" style="width: 205px" >
                       <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listTransactionEmpsecurity0044'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listTransactionEmpsecurity0045'/></option>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listTransactionEmpsecurity0046'/></option>
                            </c:when>
                        </c:choose>
                    </select>
              </td>
              <td align="right"><fmt:message key='listTransactionEmpsecurity0047'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listTransactionEmpsecurity0047'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listTransactionEmpsecurity0049'/></td>
              <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listTransactionEmpsecurity0049'/>" maxLength="20" size="25"/>
              </td>
              <td align="right"><fmt:message key='listTransactionEmpsecurity0051'/></td>
              <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listTransactionEmpsecurity0049'/>" maxLength="18" size="25"/>
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listTransactionEmpsecurity0053'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listTransactionEmpsecurity0053'/>" maxLength="64" size="25"/>
            </td>
            <td align="right"><fmt:message key='listTransactionEmpsecurity0055'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listTransactionEmpsecurity0055'/>" maxLength="50" size="25"/>
            </td>
            <td align="right"><fmt:message key='listTransactionEmpsecurity0057'/></td>
            <td align="left">
                <r:comboSelect id="com1" name="transact_type_id" 
                    queryAction="/FAERP/SecuritygroupnewAction.do?cmd=getListNewType"
                    textField="type_name" 
                    valueField="id" 
                    xpath="SecuritygroupnewVo"                   
                    nullText=''
                    width="205px">
                    <c:choose>
                            <c:when test="${param.security_type=='1'}">
                                <h:param name="security_group_id" value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"/>
                            </c:when>
                            <c:when test="${param.security_type=='2'}">
                                <h:param name="security_group_id" value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"/>
                            </c:when>
                            <c:when test="${param.security_type=='3'}">
                                <h:param name="security_group_id" value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"/>
                            </c:when>
                        </c:choose>
                </r:comboSelect>
            </td>
            <td align="right"><fmt:message key='listTransactionEmpsecurity0059'/></td>
            <td align="left">
                <select name="hire_fire_status" style="width: 205px">
                    <option value=""><fmt:message key='listTransactionEmpsecurity0058'/></option>
                    <option value="0"><fmt:message key='listTransactionEmpsecurity0061'/></option>
                    <option value="1"><fmt:message key='listTransactionEmpsecurity0062'/></option>
                    <option value="2"><fmt:message key='listTransactionEmpsecurity0063'/></option>
                </select>
<!--                    <d:select name="post_status_bd" dictTypeId="POST_STATUS_BD"  nullLabel="<fmt:message key='listTransactionEmpsecurity0058'/>" style="width: 205px"/>-->
              </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='listTransactionEmpsecurity0065'/></td>
              <td align="left">
                    <r:comboSelect id="com2"  name="social_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText=''
                width="205px">
            </r:comboSelect> 
              </td>
            <td align="right"><fmt:message key='listTransactionEmpsecurity0067'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="apply_date_from" size="8"/><fmt:message key='listTransactionEmpsecurity0068'/><w:date format="yyyy-MM-dd" name="apply_date_to" size="8" />
            </td>
             <td align="right"><fmt:message key='listTransactionEmpsecurity0069'/></td>
            <td align="left">
                <d:select dictTypeId="SECURITY_ORDER" name="order_type"  nullLabel="" style="width: 205px"/>
            </td>
             <td align="right"><fmt:message key='listTransactionEmpsecurity0071'/></td>
            <td align="left">
                <d:select dictTypeId="SORT_ORDER" name="sort_order"  nullLabel="" style="width: 205px"/>
            </td>
        </tr>
        <tr>
                    <!-- add by 20160607 Start -->
          <td align="right">专员</td>
            <td align="left">
	            <r:comboSelect id="com3" name="commissioner" 
	                    queryAction="/FAERP/EmpsecurityAction.do?cmd=GetCommissioner&Role_Type_BD=5"
	                    textField="emp_name" 
	                    valueField="emp_id" 
	                    xpath="EmpsecurityVo"                   
	                    messagekey='listTransactionHousingEmpsecurity0043' 
	                    width="205px"
	                    nullText="--请选择--">
	                </r:comboSelect>
             </td>
             <!-- add by zhuyj 20160607 End -->
            <!-- add by zhuyj 20160617 Start -->
            <td align="right">办理阶段</td>
            <td align="left">
                <select name="sel_uav_line_str" style="width: 205px">
                	<option value="">--请选择--</option>
                    <option value="IA">IA</option>
                    <option value="MW">MW</option>
                </select>
             </td>
             <!-- add by zhuyj 20160617 End -->
             
            <!-- del by zhuyj 20160607 Start-->
             <!--<td align="left" colspan="7"> -->
             <!-- del by zhuyj 20160607 Start-->
             
             <!-- add by zhuyj 20160607 Start-->
            <td align="left" colspan="3">
            <!-- add by zhuyj 20160607 Start-->
                
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
                            <li class="a_2">       <a  onClick="javascript:detail_onClick();"><fmt:message key='listTransactionEmpsecurity0073'/> </a> </li>
                            <li class="bl_1">      <a onClick="javascript:in_Transaction_onClick();"><fmt:message key='listTransactionEmpsecurity0074'/> </a></li>
                            <li class="pl">      <a onClick="javascript: batch_back_onClick();"><fmt:message key='listTransactionEmpsecurity0075'/> </a></li>
                            <li class="h_1">      <a onClick="javascript:batch_transaction_onClick();"><fmt:message key='listTransactionEmpsecurity0076'/> </a></li>
                            <li class="h_1">       <a  onClick="javascript:batch_cancel_onClick();"><fmt:message key='listTransactionEmpsecurity0077'/></a> </li>
                            <li class="bc">         <a  onClick="javascript:save_onClick();"><fmt:message key='listTransactionEmpsecurity0078'/> </a> </li>
                            <li class="e">         <a  onClick="javascript:exportExcel_onClick();"><fmt:message key='listTransactionEmpsecurity0079'/> </a> </li>

                            <li class="dj">         <a  onClick="javascript:_onClick();"><fmt:message key='listTransactionEmpsecurity0080'/> </a> </li>
                      
                        </ul>
                    -->
                    <input class="a_2" type="button"   value="<fmt:message key='listTransactionEmpsecurity0073'/>"  <au:authorityBtn code="view_orderItem9" type="1"/>  onClick="detail_onClick();">  
                    <input class="bl_1" type="button"   value="<fmt:message key='listTransactionEmpsecurity0074'/>"  <au:authorityBtn code="sbbl_jrbl" type="1"/>  onClick="in_Transaction_onClick();">  
                    <input class="pl" type="button"   value="<fmt:message key='listTransactionEmpsecurity0075'/>"  <au:authorityBtn code="sbbl_plthsq" type="1"/>  onClick="batch_back_onClick();">  
                    <input class="h_1" type="button"   value="<fmt:message key='listTransactionEmpsecurity0076'/>"  <au:authorityBtn code="sbbl_plbl" type="1"/>  onClick="batch_transaction_onClick();">  
                    <input class="h_1" type="button"   value="<fmt:message key='listTransactionEmpsecurity0077'/>"  <au:authorityBtn code="sbbl_bxbl" type="1"/>  onClick="batch_cancel_onClick();">  
                    <input class="bc" type="button"   value="<fmt:message key='listTransactionEmpsecurity0078'/>"  <au:authorityBtn code="sbbl_save" type="1"/>  onClick="save_onClick();">  
                    <input class="e" type="button"   value="<fmt:message key='listTransactionEmpsecurity0079'/>"  <au:authorityBtn code="sbbl_exp" type="1"/>  onClick="exportExcel_onClick();">  
                    <input class="h_1" type="button"   value="催呼确认"  <au:authorityBtn code="gjjbl_email" type="1"/>  onClick="batch_callcenter_onClick();">
                    <input class="r" type="button" id="securityelfHand" name="securityelfHand" value="精灵之手">
                    <!-- add by zhuyj Start 20160614 -->
                    <input class="bl_1" type="button"  Id="gjjbl_line"  value="线路转换"   onClick="getEmpId2();">
                    <input class="bl_1" type="button"   value="加急办理"    onClick="uavhandle();">
                    <!-- add by zhuyj End 20160614 -->
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
      <r:field fieldName="emp_code" sortAt="none" messagekey='listTransactionEmpsecurity0049' width="100px" allowModify="false">
            <h:text/>  
      </r:field>
      
      <r:field fieldName="emp_name" sortAt="none" messagekey='listTransactionEmpsecurity0047' width="100px" allowModify="false" onRefreshFunc="tolistDetail">
        <h:text/>
      </r:field>
      
      <r:field fieldName="group_name" sortAt="none" messagekey='listTransactionEmpsecurity0090' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="internal_code" sortAt="none" messagekey='listTransactionEmpsecurity0091' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listTransactionEmpsecurity0092' width="100px" allowModify="false">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />   
      </r:field>
      
      <r:field fieldName="id_card" sortAt="none" messagekey="listTransactionEmpsecurity0093" width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="emp_post_type_bd" sortAt="none" messagekey='listTransactionEmpsecurity0094' width="100px" allowModify="false">
            <d:select dictTypeId="EMP_POST_TYPE_BD"/> 
      </r:field>
      
      <r:field fieldName="cust_code" sortAt="none" messagekey='listTransactionEmpsecurity0053' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_name" sortAt="none" messagekey='listTransactionEmpsecurity0055' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_name" sortAt="none" messagekey='listTransactionEmpsecurity0097' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cs_email" sortAt="none" messagekey='客服邮箱' width="0px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="receive_cs_dept_name" sortAt="none" messagekey='listTransactionEmpsecurity0096' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="send_name" sortAt="none" messagekey='listTransactionEmpsecurity0098' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_big_type_name" sortAt="none" messagekey='listTransactionEmpsecurity0099' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="service_small_type_name" sortAt="none" messagekey='listTransactionEmpsecurity0100' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_send_name" sortAt="none" messagekey='listTransactionEmpsecurity0101' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="cust_receive_name" sortAt="none" messagekey='listTransactionEmpsecurity0102' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_on_post_date" sortAt="none" messagekey='listTransactionEmpsecurity0103' width="100px" allowModify="false">
            <h:text />
      </r:field>
      
      <r:field fieldName="on_post_date" sortAt="none" messagekey='listTransactionEmpsecurity0104' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="on_post_desc" sortAt="none" messagekey='listTransactionEmpsecurity0105' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_off_post_date" sortAt="none" messagekey='listTransactionEmpsecurity0106' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="serial_no" sortAt="none" messagekey='listTransactionEmpsecurity0107' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="transact_type_name" sortAt="none" messagekey='listTransactionEmpsecurity0057' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="hire_fire_status" sortAt="none" messagekey='listTransactionEmpsecurity0059' width="100px" allowModify="false">
            <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />  
      </r:field>
      
      <r:field fieldName="social_unit_name" sortAt="none" messagekey='listTransactionEmpsecurity0065' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_man_name" sortAt="none" messagekey='listTransactionEmpsecurity0111' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="apply_date" sortAt="none" messagekey='listTransactionEmpsecurity0067' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="start_month" sortAt="none" messagekey='listTransactionEmpsecurity0113' width="100px" allowModify="false">
            <h:text />      
      </r:field>
      
      <r:field fieldName="report_month" width="100px" messagekey='listTransactionEmpsecurity0114'>
        <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=<fmt:message key='listTransactionEmpsecurity0115'/>;allowNull=false;"/>
       </r:field>
      <r:field fieldName="back_reason" sortAt="none" messagekey='listTransactionEmpsecurity0116' width="100px" >
            <h:text />      
      </r:field>
      
      <r:field fieldName="insert_back_reason" sortAt="none" messagekey='listTransactionEmpsecurity0117' width="100px" >
            <h:text />      
      </r:field>

       <r:field fieldName="feedback_info" label="精灵之手备注" width="100px" allowModify="false"></r:field>
       
      <r:field fieldName="transact_remarks" sortAt="none" messagekey='listTransactionEmpsecurity0118' width="100px">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="pension_base" sortAt="none" messagekey='listTransactionEmpsecurity0119' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="pension_e_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>

      <r:field fieldName="pension_p_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="medical_base" sortAt="none" messagekey='listTransactionEmpsecurity0122' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="medical_e_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="medical_p_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="unemployment_base" sortAt="none" messagekey='listTransactionEmpsecurity0125' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="unemployment_e_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="unemployment_p_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="industrial_base" sortAt="none" messagekey='listTransactionEmpsecurity0128' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="industrial_e_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="industrial_p_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="maternity_base" sortAt="none" messagekey='listTransactionEmpsecurity0131' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="maternity_e_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="maternity_p_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="disability_base" sortAt="none" messagekey='listTransactionEmpsecurity0134' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="disability_e_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0120' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="disability_p_ratio" sortAt="none" messagekey='listTransactionEmpsecurity0121' width="100px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="salary" sortAt="none" messagekey='listTransactionEmpsecurity0123' width="100px" allowModify="false">
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
		<!-- add by zhuyj 20160531 Start -->
		<r:field fieldName="uav_line_str" label="办理阶段"  sortAt="none" width="100px" allowModify="false"><h:text/>     </r:field>
		<r:field fieldName="name"  sortAt="none" label="专员" width="100px" allowModify="false"><h:text/>     </r:field>
		<r:field fieldName="uav_status" sortAt="none" messagekey='发送' width="0px" allowModify="false">
            <h:text/>  
      	</r:field>
		<!-- end by zhuyj 20160531 Start -->
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
        //2015-05-19查询当前登录人的邮箱
     var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getUserEmail");
     myAjax.submit();
     var returnNode = myAjax.getResponseXMLDom();
     if( returnNode ) {
        $id("service_email").value = myAjax.getProperty("returnValue");
      }
      
    //解决<fmt:message key='listTransactionEmpsecurity0012'/>行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell<fmt:message key='listTransactionEmpsecurity0137'/>
    $id("datacell1").beforeLoadData = function(){
	    if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
	       //alert("run hear");
	       return false;
	    }
	    return true;
    }
    //后台返回的信息
    $id("datacell1").afterSubmit= function(ajax){
           alert(""+ajax.getProperty("returnValue"));
    }
    /* 
    //实现beforeEdit<fmt:message key='listTransactionEmpsecurity0138'/>
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
    //忽略datacell的<fmt:message key='listTransactionEmpsecurity0012'/>
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
function tolistDetail(value,entity,rowNo,cellNo){
        var empname = entity.getProperty("emp_name");
        var ids=entity.getProperty("emp_id");
        return "<a href='javascript:;' onClick='javascript:openTOListDetail(\""+ids+"\");'>"+empname+"</a>";
    }
    
 function   openTOListDetail(id){
       // var url="<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id="+id; 
       // showModalCenter(url, window, "", 1100, 830, '<fmt:message key='listTransactionEmpsecurity0141'/>');  //查看<fmt:message key='listTransactionEmpsecurity0141'/>
        window.open('<venus:base/>/FaerpEmployeeAction.do?cmd=detail&id='+id+'&flag=true','','height=830px,width=1100px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
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
