<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page  import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<fmt:bundle  basename='rayoo.customerservice.custservice.security.empsecurity.listSecurityUpdate_resource'	prefix='auto.'>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%
		    String type = (String) request.getParameter("type");
		    String tablename = "";
		    if (type != null) {
		        if (type.equals("1")) {
		            tablename = "社保变更";
		        } else if (type.equals("2")) {
		            tablename = "镇保变更";
		        } else if (type.equals("3")) {
		            tablename = "综保变更";
		        } else if (type.equals("4")) {
		            tablename = "公积金变更";
		        }
		    }
		%>
		<title>codegen</title>
		<script language="javascript">
    jQuery(function(){
        $id("emppostback_init").isQueryFirst = false;
    });
    var vpath = "<%=request.getContextPath()%>";

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       var emp_post_id = entity.getProperty("emp_post_id");
       return "<input type='checkbox'  name='temp' id='temp_"+rowNo+"' value=\"" + emp_post_id + "\">";
    }
    
    var cancleModifyChangeType = "";
    var cancleModifySubUser = "";
    function findSelection(checkboxName) {  //从radio中找出选中的id值列表
        var datacell = $id("emppostback_init");
        var dataset = datacell.dataset;//取得页面的datacell
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name<fmt:message key='listSecurityUpdate0006'/>checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        var idFlagID = "";
        var reload = false;
        var errorCode = "";
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            var row = datacell.table.tBodies[0].rows[i];//获取选中行对象
            var entity = datacell.getEntity(row);//获取选中行的数据对象
            var bake_type = entity.getValue("bake_type");
            var change_type = entity.getValue("change_type");
            
            if(elementCheckbox[i].checked) {  //如果被选中
                if(submitType == "biangeng" && bake_type == "3"){
                    alert("选中的数据中含有需要审核修改的数据，请重新选择！");
                    reload = true;
                    errorCode = "error";
                    break;
                }else if(submitType == "modify" && (bake_type == "1" || bake_type == "2")){
                    alert("选中的数据中含有需要审核变更的数据，请重新选择！");
                    reload = true;
                    errorCode = "error";
                    break;
                }
               number += 1;  //游标加1
               if(ids == null) {
                   ids = new Array(0);
               }
               if(submitType == "biangeng" || submitType == ""){
                  ids.push(elementCheckbox[i].value);  //加入选中的checkbox
               }else if(submitType == "modify"){
                  cancleModifyChangeType = change_type;
                  cancleModifySubUser = entity.getValue("last_update_user_id");
                  ids.push(elementCheckbox[i].value+"_"+change_type);  //加入选中的checkbox
               } 
            }
        }
        if(reload){
            return errorCode;
        }else{
            return ids;
        }
    }
    
    //<fmt:message key='listSecurityUpdate0032'/>列表，点击全选按钮
    function emp_onClick(obj){
        var datacell = $id("emppostback_init");
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
      
    function checkradio(xlid){  //点击行，选中对应的radio
        var elementRadio = document.getElementsByName("temp");  //
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].value==xlid) {  //如果被选中
                elementRadio[i].checked=true;  
                break;
            }
        }
        
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("emppostback_init").loadData();
        $id("emppostback_init").refresh();
    }

    //<fmt:message key='listSecurityUpdate0074'/>信息 参数为PB_EMP_POST<fmt:message key='listSecurityUpdate0011'/>id
    function detail_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate0049'/>！');
            return;
        }
        if(ids!=null && ids!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+ids,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
        }
    }
    
    //<fmt:message key='listSecurityUpdate0074'/>信息 参数为PB_EMP_POST<fmt:message key='listSecurityUpdate0011'/>id
    function detail_update_onClick(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate0049'/>！');
            return;
        }
        if(ids!=null && ids!=""){
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrderBack&id='+ids,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
        }
    }
    
    //查看按钮
    function detail_Click(){
        //取得办理ID
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate0049'/>！');
            return;
        }
        var type = jQuery("#type").val();
        var types = '';
        if(type=='1') types='social_security';
        if(type=='2') types='town_insurance';
        if(type=='3') types='complex_insurance';
        if(type=='4') types='provident_fund';
        
        if(ids!=null && ids!=""){
            var datacell = $id("emppostback_init");//datacell列表对象
            var dataset = datacell.dataset;
            var trentity = dataset.findEntity("emp_post_id", ids);
            var securityId = trentity.getProperty("security_id");
            
            if(securityId == null || securityId == ""){
                alert('<fmt:message key='listSecurityUpdate0024'/>');
                return;
            }
            window.open('<venus:base/>/EmpsecurityAction.do?cmd=detailQuerySocialSecurity&securityId=' + securityId +'&types='+types,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
            
        }
    }
    
    var submitType = "";
    
    //批量提交审核
    function toUpdateAll_onClick(){
        submitType = "biangeng";
        if(checkAllCont()){
            var dc1 = $id("emppostback_init");
            var ids = findSelection("temp");  //取得多选框的选择项
            var postids = "";
            for(var i=0;i<ids.length;i++){
                if(i==0){
                    postids= ids[i];
                }else{
                    postids = postids+","+ids[i];
                }
            }
            //校验是否在福利办理页面有待办理的数据
            //现在放开了办理的限制，不做校验了 2014年9月15日
            //var action_check="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=checkEmpWelfareInfo";
           // var myAjax_check = new Ajax(action_check);
            //var group_id_f = jQuery("#security_group_id").val();
            //myAjax_check.addParam("group_id", group_id_f);
            //myAjax_check.addParam("ids", postids);
           // myAjax_check.submit();
            //var returnNode_check = myAjax_check.getResponseXMLDom();
            //if( returnNode_check) {
           // var  flag=myAjax_check.getProperty("returnValue");
           // if(flag==0){
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toUpdateOver";
            var xmlSubmit = dc1.dataset.toString();
            var myAjax = new Ajax(action);
            var form = $id("simpleQuery");
            var group_id = jQuery("#security_group_id").val();
             myAjax.addParam("group_id", group_id);
             myAjax.addParam("ids", postids);
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                     alert("<%=tablename%><fmt:message key='listSecurityUpdate0025'/>!");
                     window.location.reload();
                 } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
                     alert("<%=tablename%><fmt:message key='listSecurityUpdate0026'/>!");
                     window.location.reload();
                 }else if ( myAjax.getValue("root/data/returnValue") == 0 ) {
                     alert("<%=tablename%><fmt:message key='listSecurityUpdate0027'/>!");
                     window.location.reload();
                 }else{
                     alert(myAjax.getValue("root/data/returnValue"));
                     return;
                 }
            }
       //}else {
        //alert("所选员工存在待确认的GE福利记录，请办理完成后再做变更！");
       // return;
       // }
      //  }else{
       // alert("系统异常，请稍后再试！");
       // return;
       // }
    }
    }
    
    //魏佳新增 -- 批量提交修改审核
    function toModifyAll_onClick(){
            submitType = "modify";
            var dc1 = $id("emppostback_init");
            var ids = findSelection("temp");  //取得多选框的选择项
            if(ids == "error"){
                return;
            }else if(ids == null || ids == ""){
                alert('<fmt:message key='listSecurityUpdate0013'/>');
                return;
            }else{
                var postids = "";
                for(var i=0;i<ids.length;i++){
                    if(i==0){
                        postids= ids[i];
                    }else{
                        postids = postids+","+ids[i];
                    }
                }
                var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toModifyOver";
                var xmlSubmit = dc1.dataset.toString();
                var myAjax = new Ajax(action);
                var form = $id("simpleQuery");
                var group_id = jQuery("#security_group_id").val();
                 myAjax.addParam("group_id", group_id);
                 myAjax.addParam("ids", postids);
                 myAjax.submitXML(xmlSubmit, 'UTF-8');
                 var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                     if( myAjax.getValue("root/data/returnValue") == 1 ) {
                         alert("<%=tablename%><fmt:message key='listSecurityUpdate0025'/>!");
                         window.location.reload();
                     } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
                         alert("<%=tablename%><fmt:message key='listSecurityUpdate0026'/>!");
                         window.location.reload();
                     }else if ( myAjax.getValue("root/data/returnValue") == 0 ) {
                         alert("<%=tablename%><fmt:message key='listSecurityUpdate0027'/>!");
                         window.location.reload();
                     }else if ( myAjax.getValue("root/data/returnValue") == 3 ) {
                         alert("<%=tablename%><fmt:message key='listSecurityUpdate0027'/>!");
                         window.location.reload();
                     }else if ( myAjax.getValue("root/data/returnValue") == 4 ) {
                         alert("<%=tablename%><fmt:message key='listSecurityUpdate0027'/>!");
                         window.location.reload();
                     }else if ( myAjax.getValue("root/data/returnValue") == 5 ) {
                         alert("<%=tablename%><fmt:message key='listSecurityUpdate0027'/>!");
                         window.location.reload();
                     }else{
                         alert(myAjax.getValue("root/data/returnValue"));
                         simpleQuery_onClick();
                         return;
                     }
                }
            }
    }
    
    //魏佳新增 -- 批量提交修改驳回
    function cancleModifyAll_onClick(){
        submitType = "modify";
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate0049'/>！');
            return;
        }
        var security_group_id = jQuery("#security_group_id").val();
        if(ids!=null && ids!=""){
            var val = window.showModalDialog('/FAERP/EmppostAction.do?cmd=toRebutPage&id='+ids+'&group_id='+security_group_id+'&type=2&change_type='+cancleModifyChangeType+'&cancleModifySubUser='+cancleModifySubUser,'','dialogHeight:300px;dialogWidth:600px;center:yes;help:no;resizable:no;scroll:no;status:no;');
            if(val=='1'){
                simpleQuery_onClick();
            }
        }
    }
    
    
     function checkAllCont(){//页面提交验证
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){//如果ids为空
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else{
            var ali = true;
	        var datacell = $id("emppostback_init");
	        var dataset = datacell.dataset;//取得页面的datacell
	        for(var i=0;i<ids.length;i++){
	            var datasettr = dataset.findEntity("emp_post_id",ids[i]);
	            var post_id = datasettr.getProperty("emp_post_id");
	            
	            var is_update_security=datasettr.getProperty("is_update_security");
	            //选择了<fmt:message key='listSecurityUpdate0076'/>社保公积金，才需要验证
	            if(is_update_security=='1'){
	                var start_month = datasettr.getProperty("start_month");
	                var end_month = datasettr.getProperty("end_month");
	                var securityId = datasettr.getProperty("security_id");
	                var securitystatus = datasettr.getProperty("security_status_bd");
	                var empname = datasettr.getProperty("emp_name");
	                if(end_month==null || end_month==''){
	                    alert('<fmt:message key='listSecurityUpdate0030'/>');
	                    return;
	                }
	                if(start_month==null || start_month==''){
	                    alert('<fmt:message key='listSecurityUpdate0031'/>');
	                    return;
	                }
	                if(securityId == null || securityId == ""){
	                    alert('<fmt:message key='listSecurityUpdate0032'/>:'+empname+'<fmt:message key='listSecurityUpdate0033'/>');
	                    return;
	                }
	                if(securitystatus != null && securitystatus == "2"){
	                    alert('<fmt:message key='listSecurityUpdate0032'/>:'+empname+'<fmt:message key='listSecurityUpdate0038'/>');
	                    return;
	                }
	            }
	                
	        }
        }
        return ali;
    }
    
    //原先单个提交的方法，已作废
    function toUpdateAll_onClick_one(type) {
        var ids = findSelection("temp");  //取得多选框的选择项
        var group_id = jQuery("#security_group_id").val();
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else{
            var datacell = $id("emppostback_init");
            var dataset = datacell.dataset;//取得页面的datacell
            var datasettr = dataset.findEntity("emp_post_id", ids);
            
            var start_month = datasettr.getProperty("start_month");
            var end_month = datasettr.getProperty("end_month");
            var securityId = datasettr.getProperty("security_id");
            if(end_month==null || end_month==''){
                alert('<fmt:message key='listSecurityUpdate0030'/>');
                return;
            }
            if(start_month==null || start_month==''){
                alert('<fmt:message key='listSecurityUpdate0031'/>');
                return;
            }
            if(securityId == null || securityId == ""){
                alert('<fmt:message key='listSecurityUpdate0024'/>');
                return;
            }
            
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=toUpdateOver";
            var myAjax = new Ajax(action);
            myAjax.addParam("id", ids);
            myAjax.addParam("group_id", group_id);
            myAjax.addParam("start_month", start_month);
            myAjax.addParam("end_month", end_month);
              
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate0044'/>!');
                 } else if ( myAjax.getValue("root/data/returnValue") == 2 ) {
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate0026'/>!');
                 }else{
                     alert('<%=tablename%><fmt:message key='listSecurityUpdate0027'/>!');
                 }
                 window.location.reload();
            }
            
        }
        
    }
    
    //单个<fmt:message key='listSecurityUpdate0077'/><fmt:message key='listSecurityUpdate0085'/>
    function toRebutAll_onClick(){
        submitType = "biangeng";
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == "error"){
            return;
        }else if(ids == null || ids == ""){
            alert('<fmt:message key='listSecurityUpdate0013'/>');
            return;
        }else if(ids.length>1){
            alert('<fmt:message key='listSecurityUpdate0049'/>！');
            return;
        }
        var security_group_id = jQuery("#security_group_id").val();
        if(ids!=null && ids!=""){
            var val = window.showModalDialog('/FAERP/EmppostAction.do?cmd=toRebutPage&id='+ids+'&group_id='+security_group_id+'&type=1','','dialogHeight:300px;dialogWidth:600px;center:yes;help:no;resizable:no;scroll:no;status:no;');
            if(val=='1'){
                simpleQuery_onClick();
            }
        }
    }
    
    //新收费起始月有变动，原收费截止月自动<fmt:message key='listSecurityUpdate0076'/>为起始月减一个月
    function anyStartMonth(){
        var datacell = $id("emppostback_init");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前<fmt:message key='listSecurityUpdate0085'/>的行dataset
        
        var fields = datacell.fields;//获得页面所有的列
        
        var start_month = datasettr.getProperty("start_month");
        
        if(!checkMonth(start_month,'<fmt:message key='listSecurityUpdate0050'/>')){
            datasettr.setProperty("start_month","");
            return;
        }
        
        var end_month = toEndmonth(start_month);
        datasettr.setProperty("end_month", end_month);
        
        //其他打钩的行也要联动
        var rowNo=activeRow.rowIndex;
        if($id("temp_"+rowNo).checked){//已经勾选上
            var temps = document.getElementsByName("temp");
            var number = 0;  //定义游标
            var ids = null;  //定义id值的数组
            for(var i=0;i<temps.length;i++){  //循环checkbox组
                 if(temps[i].checked) {  //如果被选中,则替换
                      var enCurEntity = $id("emppostback_init").dataset.get(i);
                      enCurEntity.setProperty("start_month", start_month);
                      enCurEntity.setProperty("end_month", end_month);
                          
                      $id("emppostback_init").refreshRow($id("emppostback_init").getRow(i));
                      
                  }
            }
        }
       
    }
    
    //<fmt:message key='listSecurityUpdate0097'/>为<fmt:message key='listSecurityUpdate0050'/>减一个月
    function toEndmonth(start_month){
        var year=start_month.substring(0,4);
        var month=start_month.substring(4,6);
        
        var end_month='';
        if(parseFloat(month)==1){
            var year1=parseFloat(year)-1;
            var month1=12;
            end_month = year1+''+month1;
        }else{
            var month1=parseFloat(month)-1;
            if(month1<10){
                end_month = year+'0'+month1;
            }else{
                end_month = year+''+month1;
            }
        }
        
        return end_month ;
    
    }
    
//判断某个六位数是不是年份月份格式yyyymm
function checkMonth(yearMonth,msg){
  if(yearMonth=="") return true;  
  var rtn=true;
  var s=yearMonth+"";
  //alert(s.length);
  if(s.length!=6) rtn=false;
  if(!checkNumber(yearMonth))rtn=false; //必须全是数字
  var year=s.substring(0,4);
  var month=s.substring(4,6);
  if(parseFloat(year)<2000 || parseFloat(year)>2030) rtn=false;
  if(parseFloat(month)<1 || parseFloat(month)>12) rtn=false;
  
  if(!rtn){
     alert(msg+"<fmt:message key='listSecurityUpdate0054'/>!");     
  }  
  return rtn;
}

</script>
</head>
<body>


<div id="right">
<script language="javascript">
    writeTableTopFesco('<%=tablename %>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAllpost">
<input type="hidden" id="type" name="type" value="<%=type %>">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listSecurityUpdate0055'/></div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>

        <tr>
            <td align="right"><fmt:message key='listSecurityUpdate0039'/></td>
            <td align="left">
                <select id="security_group_id" name="security_group_id">
                    <%if(type.equals("1")){ %>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID %>"><fmt:message key='listSecurityUpdate0056'/></option>
                    <%}
                    if(type.equals("2")){%>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID3 %>"><fmt:message key='listSecurityUpdate0057'/></option>
                    <%}
                    if(type.equals("3")){%>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID4 %>"><fmt:message key='listSecurityUpdate0058'/></option>
                    <%} 
                    if(type.equals("4")){%>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message key='listSecurityUpdate0059'/></option>
                    <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message key='listSecurityUpdate0060'/></option>
                    <%} %>
                </select>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate0061'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listSecurityUpdate0061'/>" maxLength="25"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate0063'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listSecurityUpdate0063'/>" maxLength="50"/>
            </td>
           
        </tr>
        <tr>
            <td align="right"><fmt:message key='listSecurityUpdate0065'/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="<fmt:message key='listSecurityUpdate0065'/>" maxLength="25"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate0067'/></td>
            <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listSecurityUpdate0067'/>" maxLength="64"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate0069'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listSecurityUpdate0069'/>" maxLength="50"/>
            </td>
            
        </tr>
        <tr>
            <td align="right"><fmt:message key='listSecurityUpdate0071'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listSecurityUpdate0071'/>" maxLength="64"/>
            </td>
            <td align="right"><fmt:message key='listSecurityUpdate0073'/></td>
            <td>
               <faerp:SoialunitSelectTag  tagname="security_unit_id"  beanname="security_unit_id" />
            </td>
            <td align="right"></td>
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
       
    
</table>

</div>


 


<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="a_4"><a onClick="javascript:detail_update_onClick()"><fmt:message key='listSecurityUpdate0074'/></a></li>
                    <li class="a_2"><a onClick="javascript:detail_Click()"><fmt:message key='listSecurityUpdate0075'/></a></li>
                    <li class="gg"><a onClick="javascript:toUpdateAll_onClick()"><fmt:message key='listSecurityUpdate0076'/></a></li>
                    <li class="gg"><a onClick="javascript:toRebutAll_onClick()"><fmt:message key='listSecurityUpdate0077'/></a></li>
                </ul>
         -->
                    <input class="a_4" type="button"   value="<fmt:message key='listSecurityUpdate0074'/>"  <au:authorityBtn code="view_orderItem12" type="1"/>  onClick="detail_update_onClick();">  
                    <%if(type.equals("4")){ %>
                        <input class="a_3" type="button"   value="<fmt:message key='listSecurityUpdate0079'/>"  <au:authorityBtn code="sbbg_veiwSbbl" type="1"/>  onClick="detail_Click();">  
                   <%}else if(type.equals("3")){%>
                         <input class="a_3" type="button"   value="<fmt:message key='listSecurityUpdate0080'/>"  <au:authorityBtn code="sbbg_veiwSbbl" type="1"/>  onClick="detail_Click();">  
                  <% }else if(type.equals("2")){%>
                <input class="a_3" type="button"   value="<fmt:message key='listSecurityUpdate0081'/>"  <au:authorityBtn code="sbbg_veiwSbbl" type="1"/>  onClick="detail_Click();">  
                   <%}
                    else{%>
                    <input class="a_2" type="button"   value="<fmt:message key='listSecurityUpdate0075'/>"  <au:authorityBtn code="sbbg_veiwSbbl" type="1"/>  onClick="detail_Click();">  
                  <%} %>
                    <input id="bgButton" class="gg" type="button"   value="<fmt:message key='listSecurityUpdate0076'/>"  <au:authorityBtn code="sbbg_bg" type="1"/>  onClick="toUpdateAll_onClick();">
                    <input class="gg" type="button"   value="<fmt:message key='listSecurityUpdate0077'/>"  <au:authorityBtn code="sbbg_bh" type="1"/>  onClick="toRebutAll_onClick();">
                    <input id="modifyButton" class="bl_1" type="button"   value="<fmt:message key='listSecurityUpdate0103'/>"  <au:authorityBtn code="sbbg_xgsh" type="1"/>  onClick="toModifyAll_onClick();">
                    <input id="cancleModifyButton" class="bl_1" type="button"   value="<fmt:message key='listSecurityUpdate0104'/>"  <au:authorityBtn code="sbbg_bhxg" type="1"/>  onClick="cancleModifyAll_onClick();">  
         </div>
           <div class="clear"></div>            
</div>
                    <r:datacell 
                         id="emppostback_init"
                         queryAction="/FAERP/EmppostAction.do?cmd=toRebackQuery"
                         width="100%"
                         xpath="EmppostVo"
                         submitXpath="EmppostVo"
                         paramFormId="simpleQuery"
                         freezeNumber="3"
                         >
                         <r:toolbar  tools="nav,pagesize,info"/>
                         <r:field fieldName="emp" label="操作<input type='checkbox' id='empselect' name='empselect' onclick='emp_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none" align="center">
                         </r:field>   
                         <r:field fieldName="bake_type" sortAt="none" messagekey="listSecurityUpdate0101" width="0">
                         </r:field>
                         <r:field fieldName="change_type" sortAt="none" messagekey="listSecurityUpdate0102" width="0">
                         </r:field>
                         <r:field fieldName="emp_name" sortAt="none" messagekey="listSecurityUpdate0063">
                         </r:field>
                          <r:field fieldName="emp_code" sortAt="none" messagekey='listSecurityUpdate0061'>
                         </r:field>
                         <r:field fieldName="id_card_type_bd" sortAt="none" messagekey='listSecurityUpdate0088' allowModify="false">
                             <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                         </r:field>
                         <r:field width="160" fieldName="id_card" sortAt="none" messagekey='listSecurityUpdate0067'>
                         </r:field>
                         <r:field fieldName="cust_code" sortAt="none" messagekey='listSecurityUpdate0069'>
                         </r:field>
                         <r:field width="250" fieldName="cust_name" sortAt="none" messagekey='listSecurityUpdate0071'>
                         </r:field>
                         <r:field fieldName="big_type_name" sortAt="none" messagekey='listSecurityUpdate0092'>
                         </r:field>
                         <r:field fieldName="small_type_name" sortAt="none" messagekey='listSecurityUpdate0093'>
                         </r:field>
                         <r:field fieldName="security_unit_id" sortAt="none" messagekey='listSecurityUpdate0073' allowModify="false">
                            <r:comboSelect id="com2" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="listSecurityUpdate0036">
                            </r:comboSelect>     
                         </r:field>
                         <r:field fieldName="is_update_security" sortAt="none" messagekey="listSecurityUpdate0040">
                             <d:select dictTypeId="TrueOrFalse"/>
                         </r:field>
                         <r:field fieldName="security_status_bd" sortAt="none" messagekey="listSecurityUpdate0105">
                             <d:select dictTypeId="SECURITY_STATUS_BD"/>
                         </r:field>
                         <r:field fieldName="start_month" sortAt="none" messagekey='listSecurityUpdate0050' allowModify="true">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" onchange="javascript:anyStartMonth();"/>
                         </r:field>
                         <r:field fieldName="end_month" sortAt="none" messagekey='listSecurityUpdate0097' allowModify="true">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
                         </r:field>
                         <r:field fieldName="back_desc" sortAt="none" messagekey='listSecurityUpdate0100' allowModify="true" width="200">
                         </r:field>
                         <r:field fieldName="last_update_user_id" sortAt="none" messagekey='listSecurityUpdate0100' allowModify="true" width="0">
                         </r:field>
                       </r:datacell>
    
</div>
</div>
</fmt:bundle>
</form>
</body>
</fmt:bundle>
</html>
<script>
$id("emppostback_init").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    }
</script>