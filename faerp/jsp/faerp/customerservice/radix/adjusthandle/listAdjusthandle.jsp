<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusthandle.adjusthandle_resource" prefix="rayoo.customerservice.radix.adjusthandle.">
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
	
    
    function type_change(){
        var adjusttype = jQuery("#adjust_type_bd").val();
        if(adjusttype!=null && adjusttype=='2'){
            jQuery("#adjust_month").removeAttr("disabled");
        }else{
            jQuery("#adjust_month").attr("disabled","disabled")
        }
    }
    
    function detail(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open("jsp/faerp/customerservice/radix/adjusthandle/detailAdjust.jsp?id="+ids,"newwindow","width=1024px,height=400px,location=no,scroll=yes");
    
        //form.action="<%=request.getContextPath()%>/AdjusthandleAction.do?cmd=queryDetailAdjust&id=" + ids;
        //form.submit();
    }
    
    function temp_detail(){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        window.open("jsp/faerp/customerservice/radix/adjusthandle/tempdetailAdjust.jsp?id="+ids,"newwindow","width=1024px,height=400px,location=no,scroll=yes");
    
        //form.action="<%=request.getContextPath()%>/AdjusthandleAction.do?cmd=queryDetailAdjust&id=" + ids;
        //form.submit();
    }
    
    function findadjusttask(){
        var data = window.showModalDialog('<venus:base/>/AdjustTaskAction.do?cmd=findAdjustTask&task_status_bd=0&backFlag=true&date='+new Date(),'','dialogHeight:500px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(data == undefined) return;
        document.getElementById('group_ids').value = data[0];
        document.getElementById('adjust_task_name').value = data[1];
        document.getElementById('adjust_task_id').value = data[3];
    }
    
    //调整任务选择回调函数
    function rtnFuncTask(arg){
        var lookup = $id("adjust_task_id");
        lookup.value = arg[3];
        lookup.displayValue = arg[1];
        //document.getElementById('group_ids').value = arg[0];
        //document.getElementById('year').value = arg[2];
        document.getElementById('adjust_year').value = arg[2];
        return false;
    }
    
    function trimOrder(type){
        var ids = findSelection("temp");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }else{
            //判断是否替换比例，如果是，则判断是否设置新比例，提示确认！
            var datacell = $id("datacell1");
	        var dataset1 = datacell.dataset;//取得页面的datacell
	        var datasettr1 = dataset1.findEntity("id",ids );
	        var isrepratio = datasettr1.getProperty('is_rep_ratio_bd');
	        var isnewratio= datasettr1.getProperty('is_set_newratio');
	        var isprochange= datasettr1.getProperty('is_prochange');
	        if(isrepratio=='1' && isprochange!='1' && isnewratio!='已设置'){
	           if(!getConfirm('<fmt:message key="this_batch_seted_change_bili_notice"/>')) {  //如果用户在确认对话框中点"取消"
                  return false;
              }
	        }
            
            //提示调整处理中。。。
            showProgressBar();
            var action = "<%=request.getContextPath()%>/AdjusthandleAction.do?cmd=toTrimOrder";
            var myAjax = new Ajax(action,false);
            myAjax.addParam("ids", ids);
            myAjax.addParam("type", type);
            myAjax.submit();
            var returnNode = myAjax.getResponseXMLDom();
            //提示消失
            hideProgressBar();
            if( returnNode ) {
                var resultVal = myAjax.getValue("root/data/returnValue");
                var array = resultVal.split("||");
                var message = "";
                 if(array[0] == "1" ) {
                     message = '<fmt:message key="p_order_adjust_seccuse"/>';
                     if(array[1] != null && array[1] != "" && array[1] != "null"){
	                    var array1 = array[1].split(",");
	                    message += "【成功："+array1[0]+"条，失败："+array1[1]+"条!】";
                     }
                     alert(message);
                 }else if ( array[0] == "2" ) {
                     message = '<fmt:message key="ss_fund_adjust_seccuse"/>';
                     if(array[1] != null && array[1] != "" && array[1] != "null"){
                        var array1 = array[1].split(",");
                        message += "【成功："+array1[0]+"条，失败："+array1[1]+"条!】";
                     }
                     alert(message);
                 }else if ( array[0] == "3" ) {
                     message = '<fmt:message key="one_jian_adjust_seccuse"/>';
                     if(array[1] != null && array[1] != "" && array[1] != "null"){
                        var array1 = array[1].split(",");
                        message += "【成功："+array1[0]+"条，失败："+array1[1]+"条!】";
                     }
                     alert(message);
                 }else if ( array[0] == "11" ) {
                     message = '<fmt:message key="can_not_again_operation"/>';
                     if(array[1] != null && array[1] != "" && array[1] != "null"){
                        var array1 = array[1].split(",");
                        message += "【成功："+array1[0]+"条，失败："+array1[1]+"条!】";
                     }
                     alert(message);
                     return;
                 }else if ( array[0] == "12" ) {
                     message = '<fmt:message key="can_not_again_operation1"/>';
                     if(array[1] != null && array[1] != "" && array[1] != "null"){
                        var array1 = array[1].split(",");
                        message += "【成功："+array1[0]+"条，失败："+array1[1]+"条!】";
                     }
                     alert(message);
                     return;
                 }else if ( array[0] == "13" ) {
                     message = '<fmt:message key="batch_p_order_not_adjust"/>';
                     if(array[1] != null && array[1] != "" && array[1] != "null"){
                        var array1 = array[1].split(",");
                        message += "【成功："+array1[0]+"条，失败："+array1[1]+"条!】";
                     }
                     alert(message);
                     return;
                 }else{
                     alert('<fmt:message key="adjust_task_error"/>');
                     return;
                 }
                 window.location.reload();
            }
        }
    }
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/AdjusthandleAction.do">
<input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="adjust_handle"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s"> 

<!--表格1-->
    <div class="box_tab">
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            <tr>
                <td class="td_1"><fmt:message key="adjust_type"/></td>
                 <td class="td_2">
                      <d:select id="adjust_type_bd" name="adjust_type_bd" dictTypeId="ADJUST_TYPE_BD" nullLabel="--请选择--" onchange="type_change()"/>
        
                 </td>
                <td class="td_1"> <fmt:message key="adjust_type"/></td>
                <td class="td_2">
		                <w:lookup onReturnFunc="rtnFuncTask" readonly="true" id="adjust_task_id" displayValue=""   name="adjust_task_id" lookupUrl="faerp/customerservice/radix/adjusttask/findAdjustTask.jsp" messagekey="choose_adjust_task" height="440" width="600" style="width:170px">
		                  </w:lookup>
                </td>
            </tr>
            <tr>
                <td class="td_1"> <fmt:message key="adjust_year"/></td>
                <td class="td_2"> 
                    <input type="text" class="text_field" disabled="disabled"  id="adjust_year" name="adjust_year" inputName="调整年度"  maxLength="50"/>
        
                </td>
                <td class="td_1"> <fmt:message key="adjust_month"/></td>
                <td class="td_2">
                    <select id="adjust_month" name="adjust_month" disabled="disabled">
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
        </table>
    </div>
<div class="dc_button">
<input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
<input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
</div>
                  
<!--按钮-->
    <div class="button_right">
            <!--<ul>
                <li class="a"><a href="#" onclick="detail();">查看</a></li>
                <li class="bl_3"><a href="#" onclick="trimOrder('1');" >个人订单调整</a></li>
                <li class="bg"><a href="#" onclick="trimOrder('2');">社保/公积金调整</a></li>
                <li class="bg"><a href="#" onclick="trimOrder('3');">一键调整</a></li>
            </ul>
        -->
  <input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="tzcl_view" type="1"/>  onClick="detail();">
  <input class="bg" type="button"   value="<fmt:message key="view_error_emp"/>"  <au:authorityBtn code="view_orderItem33" type="1"/>  onClick="temp_detail();">
  <input class="bl_3" type="button"   value="<fmt:message key="p_order_adjust"/>"  <au:authorityBtn code="view_orderItem33" type="1"/>  onClick="trimOrder('1');">
  <input class="bl_4" type="button"   value="<fmt:message key="ss_fund_adjust"/>"  <au:authorityBtn code="tzcl_sbGjj" type="1"/>  onClick="trimOrder('2');">
  <input class="bl_2" type="button"   value="<fmt:message key="one_jian_adjust"/>"  <au:authorityBtn code="tzcl_yjtz" type="1"/>  onClick="trimOrder('3');">
  
  <div class="clear"></div>
</div>
                            
<!--按钮 end-->
<!--表格 -->


<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AdjusthandleAction.do?cmd=simpleQuery"
        width="98%"
        height="318px"
        xpath="AdjusthandleVo"
        submitXpath="AdjusthandleVo"
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
      <r:field fieldName="batch_name" messagekey="uplourd_file_name" sortAt="server">
      </r:field>
      <r:field fieldName="adjust_year" messagekey="adjust_year"  sortAt="server">
      </r:field>
      <r:field fieldName="adjust_month" messagekey="adjust_month" sortAt="server">
      </r:field>
      
      <r:field width="200" fieldName="group_name" messagekey="ss_fund" sortAt="server">
      </r:field>
      <r:field width="180" fieldName="is_rep_ratio_bd" messagekey="is_rep_ratio1" sortAt="server" allowModify="false">
           <d:select dictTypeId="IS_REP_RATIO_BD"/>
      </r:field>
      <r:field width="180" fieldName="is_set_newratio" messagekey="is_set_newratio" sortAt="server" allowModify="false">
           
      </r:field>
      <r:field fieldName="import_user" messagekey="imp_user" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="import_time" messagekey="imp_date" sortAt="server" allowModify="false">
          <w:date format="yyyy-MM-dd hh:mm:ss" name="import_time"/>
      </r:field>
      <r:field width="150" fieldName="adjust_status_bd" messagekey="p_order_status_adjust_status" sortAt="server" allowModify="false">
           <d:select dictTypeId="OR_ADJUST_STATUS_BD"/>
      </r:field>
      <r:field width="150" fieldName="social_adjust_status_bd" messagekey="ss_fund_adjust_status" sortAt="server" allowModify="false">
           <d:select dictTypeId="SO_ADJUST_STATUS_BD"/>
      </r:field>
      <r:field width="150" fieldName="adjust_user" messagekey="adjust_user" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="adjust_time" messagekey="adjust_time" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="social_adjust_user" messagekey="social_adjust_user" sortAt="server">
      </r:field>
      <r:field width="150" fieldName="social_adjust_time" messagekey="social_adjust_time" sortAt="server">
      </r:field>
    </r:datacell>
</div> 

<!--表格 end-->

<!--表格1 end-->
</div>
       
</div>
</form>
</fmt:bundle>
</body>
</html>
