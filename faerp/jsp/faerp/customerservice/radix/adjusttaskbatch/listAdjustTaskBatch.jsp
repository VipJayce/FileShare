<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusttaskbatch.adjusttaskbatch_resource" prefix="rayoo.customerservice.radix.adjusttaskbatch.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       
       return "<input type='radio'  name='temp'  value=\"" + entity.getProperty("id") + "\">";
    }
    
    function findSelection(radioName) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);  //
        var ids = null;  //定义id值
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
            if(elementRadio[i].checked) {  //如果被选中
                ids=elementRadio[i].value; 
            }
        }
        return ids;
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
     function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
        //window.showModalDialog('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','','dialogHeight:240px;dialogWidth:320px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    }


    function ImportAdjust(){
        var attachNameInput = document.getElementById('attachNameInput').value;
        if(attachNameInput == null || attachNameInput == ''){
            alert('<fmt:message key="please_imp_file"/>');
            return;
        }
        jQuery("#batch_name").val(attachNameInput);
        var adjust_type = document.getElementById('adjust_type_bd').value;
        if(adjust_type == null || adjust_type == ''){
            alert('<fmt:message key="please_choose_adjust_type"/>');
            return;
        }else{
            if(adjust_type=='2'){
                var mouth = document.getElementById('mouth').value;
		        if(mouth == null || mouth == ''){
		            alert('<fmt:message key="please_choose_month"/>');
		            return;
		        }
            }
        }
        var adjust_task_id = document.getElementById('adjust_task_id').value;
        if(adjust_task_id == null || adjust_task_id== ''){
            alert('<fmt:message key="please_choose_adjust_task"/>');
            return;
        }
        var is_rep_ratio_bd = document.getElementById('is_rep_ratio_bd').value;
        var is_prochange = document.getElementById('is_prochange').value;
        if(is_rep_ratio_bd=='0' && is_prochange=='1'){
            alert('<fmt:message key="notice"/>');
            return;
        }
        
        jQuery("input[name='button_reset1']").attr('disabled','disabled');
        var myAjax = new Ajax("<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=importAdjust");
	    var form = $id("datacell_formid");
        if (form) {
            for (var i = 0; i < form.elements.length; i++) {
                var elem = form.elements[i];
                if (elem.name) {
                    myAjax.addParam(elem.name, getElementValue(elem));
                }
            }
        }        
	    myAjax.submit();
	    var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
             if( myAjax.getValue("root/data/returnValue") == 1 ) {
                 alert('<fmt:message key="all_date_imp_seccuse"/>' );
                 simpleQuery_onClick();
                 
             }else if( myAjax.getValue("root/data/returnValue") == 2 ) {
                 alert('<fmt:message key="imp_date_error"/>' );
                 simpleQuery_onClick();
             }else if( myAjax.getValue("root/data/returnValue") == 3 ) {
                 alert('导入的excel必须为97~2000版本，即后缀为.xls的文件!' );
             }else{
                  alert('<fmt:message key="imp_error_try_again"/>' );
             }
             jQuery("input[name='button_reset1']").removeAttr("disabled");
        }
        //form.action="<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=importAdjust";
        //form.submit();
    }
    
    //已作废
    function findadjusttask(){
        var data = window.showModalDialog('<venus:base/>/AdjustTaskAction.do?cmd=findAdjustTask&task_status_bd=0&backFlag=true&date='+new Date(),'','dialogHeight:500px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        document.getElementById('group_ids').value = data[0];
        document.getElementById('adjust_task_name').value = data[1];
        document.getElementById('year').value = data[2];
        document.getElementById('adjust_task_id').value = data[3];
    }
    
    //调整任务选择回调函数
    function rtnFuncTask(arg){
        var lookup = $id("adjust_task_id");
        lookup.value = arg[3];
        lookup.displayValue = arg[1];
        document.getElementById('group_ids').value = arg[0];
        document.getElementById('year').value = arg[2];
        document.getElementById('adjust_year').value = arg[2];
        return false;
    }
    
    function type_change(){
        var adjusttype = jQuery("#adjust_type_bd").val();
        if(adjusttype!=null && adjusttype=='2'){
            jQuery("#mouth").removeAttr("disabled");
        }else{
            jQuery("#mouth").attr("disabled","disabled")
        }
    }
    
    function importerror(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open("jsp/faerp/customerservice/radix/adjusttaskbatch/importError.jsp?id="+ids,"","width=1024px,height=400px,location=no,scroll=yes");
    
        //form.action="<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=importError&id="+ids;
        //form.submit();
    }
    
    function setProductId(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var datacell = $id("datacell1");
        var dataset1 = datacell.dataset;//取得页面的datacell
        var datasettr1 = dataset1.findEntity("id",ids );
        var orderstatus = datasettr1.getProperty('adjust_status_bd');
        var securitytatus = datasettr1.getProperty('social_adjust_status_bd');
        var isratstatus = datasettr1.getProperty('is_rep_ratio_bd');
        var is_prochange = datasettr1.getProperty('is_prochange');
        if(orderstatus=='1' || securitytatus=='1'){
            alert('<fmt:message key="not_change_adjust"/>');
            return;
        }
        if(isratstatus==null || isratstatus!='1'){
            alert('<fmt:message key="this_batch_not_change_adjust"/>');
            return;
        }
        if(is_prochange!=null && is_prochange=='1'){
            alert('<fmt:message key="this_batch_set_fund_adjust"/>');
            return;
        }
        
        
        window.open("jsp/faerp/customerservice/radix/adjusttaskbatch/setProductId.jsp?id="+ids,"","width=1024px,height=400px,location=no,scroll=yes");
        
    }
    
    function detailinfo(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open("jsp/faerp/customerservice/radix/adjusttaskbatch/detailInfo.jsp?id="+ids,"","width=1024px,height=400px,location=no,scroll=yes");
    
         //form.action="<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=detailInfo&id="+ids;
         //form.submit();
    }
    
    function update(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        var datacell = $id("datacell1");
        var dataset1 = datacell.dataset;//取得页面的datacell
        var datasettr1 = dataset1.findEntity("id",ids );
        var orderstatus = datasettr1.getProperty('adjust_status_bd');
        var securitytatus = datasettr1.getProperty('social_adjust_status_bd');
        if(orderstatus=='1' || securitytatus=='1'){
            alert('<fmt:message key="this_batch_p_order_or_ss_fund_adjust"/>');
            return;
        }else{
	        if(confirm('<fmt:message key="sure_invalid_adjust_task_imp_date"/>')) {
	           form.action="<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=updateIsVaild&id="+ids;
	           form.submit();
	        }
	    }
    }
    
  
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" class="text_field" id="attackAddressInput" name="attach_address" value=""/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="imp_adjust_task"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="imp_condition"/></div> </td>
    </tr>
    <tr>
        <td align="left"><font color="red">*</font>&nbsp;<fmt:message key="adjust_type"/></td>
        <td align="left">
            <d:select id="adjust_type_bd" name="adjust_type_bd" dictTypeId="ADJUST_TYPE_BD" nullLabel="--请选择--" onchange="type_change()"/>
        </td>
        <td align="left"><font color="red">*</font>&nbsp;<fmt:message key="choose_imp_file_correspond_adjust_task"/></td>
        <td align="left">
            <w:lookup onReturnFunc="rtnFuncTask" readonly="true" id="adjust_task_id" displayValue=""   name="adjust_task_id" lookupUrl="faerp/customerservice/radix/adjusttask/findAdjustTask.jsp" messagekey="choose_adjust_task" height="440" width="600" style="width:170px">
            </w:lookup>
            <input type="hidden" name="group_ids" id="group_ids"/>
        </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key="adjust_year"/></td>
        <td align="left">
            <input type="hidden" name="year" value="">
            <input type="text" class="text_field" disabled="disabled"  id="adjust_year" name="adjust_year" inputName="调整年度"  maxLength="50"/>
        </td>
        <td align="left"><fmt:message key="adjust_month"/></td>
        <td align="left">
            <select name="mouth" id="mouth" disabled="disabled">
            <option value=""><fmt:message key="please_choose"/></option>
                <%
                for(int i=1;i<=12;i++){
                    %>
                    <option value="<%=i <10?"0"+i:i%>"><%=i<10?"0"+i:i %><fmt:message key="month"/></option>
                    <%
                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        
        <td align="left"><font color="red">*</font>&nbsp;<fmt:message key="is_rep_ratio"/></td>
        <td align="left">
            <select name="is_rep_ratio_bd">
                <option value="1"><fmt:message key="rep_ratio"/></option>
                <option value="0" selected><fmt:message key="no_rep_ratio"/></option>
            </select>
        </td>
        <td align="left"><font color="red">*</font>&nbsp;<fmt:message key="is_prochange"/></td>
        <td align="left">
            <select name="is_prochange">
                <option value="1"><fmt:message key="yes"/></option>
                <option value="0" selected><fmt:message key="no"/></option>
            </select>
        </td>
    </tr>   
    <tr>
        <td align="left"><fmt:message key="imp_file_name"/></td>
        <td align="left">
            <input type="text" class="text_field" disabled="disabled" id="attachNameInput" name="attachNameInput" value=""/> 
            <input type="hidden" id="batch_name" name="batch_name" value=""/> 
        </td>
        <td align="right" colspan="2">
			    <input type="button" class="icon_4" <au:authorityBtn code="drtzsj_one" type="1"/>  value="<fmt:message key="one_uplourd_file"/>" onclick="UploadFileWindow();"/>
			    <input type="button" name="button_reset1" class="icon_4" <au:authorityBtn code="drtzsj_two" type="1"/>   value="<fmt:message key="two_imp_adjust_data"/>" onclick="ImportAdjust();"/>
			
        </td>
    </tr>   
</table>
</div>
                           
<div id="ccParent1" class="button"> 
 <div class="button_right">
    <!--<ul>
        <li class="f">   <a href="#" onclick="javascript:update();">作废</a></li>
        <li class="bg"><a href="#" onclick="javascript:detailinfo();">查看导入的明细</a></li>
        <li class="bg"><a href="#" onClick="javascript:importerror();">查看该次导入的问题数据</a></li>
    </ul>
-->
   <input class="f" type="button"   value="<fmt:message key="invalid"/>"  <au:authorityBtn code="drtzsj_zf" type="1"/>  onClick="update();">
   <input class="bg" type="button"   value="<fmt:message key="set_rep_ratio"/>"  onClick="setProductId();">
   <input class="bg" type="button"   value="<fmt:message key="look_imp_info"/>"  <au:authorityBtn code="drtzsj_viewExpItem" type="1"/>  onClick="detailinfo();">
   <input class="bg" type="button"   value="<fmt:message key="look_imp_problems_data"/>"  <au:authorityBtn code="drtzsj_viewExpError" type="1"/>  onClick="importerror();">
   
   
</div>
<div class="clear"></div>           
</div>


<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AdjustTaskBatchAction.do?cmd=searchAdjustTaskBatch"
        width="98%"
        height="318px"
        xpath="AdjustTaskBatchVo"
        submitXpath="AdjustTaskBatchVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>   
      <r:field fieldName="emp" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>          
      <r:field fieldName="adjust_type_bd"  messagekey="adjust_type" sortAt="server" allowModify="false">
           <d:select dictTypeId="ADJUST_TYPE_BD"/>
      </r:field>
      <r:field width="150" fieldName="adjust_task_name" messagekey="adjust_task_name" sortAt="server">
      </r:field>
      <r:field fieldName="batch_code" messagekey="imp_batch_code" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="batch_name" messagekey="uplourd_file_name" sortAt="server">
      </r:field>
      <r:field fieldName="adjust_year" messagekey="adjust_year"  sortAt="server">
      </r:field>
      <r:field fieldName="adjust_month" messagekey="adjust_month" sortAt="server">
      </r:field>
      
      <r:field width="200" fieldName="group_name" messagekey="ss_fund" sortAt="server">
      </r:field>
      <r:field  fieldName="is_rep_ratio_bd" messagekey="is_rep_ratio1" sortAt="server" allowModify="false">
           <d:select dictTypeId="IS_REP_RATIO_BD"/>
      </r:field>
      <r:field  fieldName="is_set_newratio" messagekey="is_set_newratio" sortAt="server" allowModify="false">
           
      </r:field>
      <r:field fieldName="import_user" messagekey="imp_user" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="import_time" messagekey="imp_date" sortAt="server" allowModify="false">
          <w:date format="yyyy-MM-dd hh:mm:ss" name="import_time"/>
      </r:field>
      <r:field width="150" fieldName="adjust_status_bd" messagekey="p_order_adjust_status" sortAt="server" allowModify="false">
           <d:select dictTypeId="OR_ADJUST_STATUS_BD"/>
      </r:field>
      <r:field width="150" fieldName="social_adjust_status_bd" messagekey="social_adjust_status" sortAt="server" allowModify="false">
           <d:select dictTypeId="SO_ADJUST_STATUS_BD"/>
      </r:field>
      <r:field width="150" fieldName="adjust_user" messagekey="adjust_user" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="adjust_time" messagekey="adjust_time" sortAt="server" allowModify="false">
        <w:date format="yyyy-MM-dd hh:mm:ss" name="adjust_time"/>
      </r:field>
      <r:field width="150" fieldName="social_adjust_user" messagekey="social_adjust_user" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="social_adjust_time" messagekey="social_adjust_time" sortAt="server" allowModify="false">
        <w:date format="yyyy-MM-dd hh:mm:ss" name="social_adjust_time"/>
      </r:field>
    </r:datacell>
</div> 


</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

