<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*"%>
<%@ page import="rayoo.employeepost.empentry.epemporder.vo.EpemporderVo" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.vo.EpempordersummoneyVo" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%  //取出本条记录
    EpemporderVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (EpemporderVo)request.getAttribute("vo");  //从request中取出vo, 赋值给resultVo
    EpempordersummoneyVo vo1 = null;
    vo1 = (EpempordersummoneyVo)request.getAttribute("vo1");
    
    String postId = request.getAttribute("postId").toString();
    request.setAttribute("postId",postId);
    
    String allowModify = request.getAttribute("allowModify").toString();
    allowModify = "false";
    request.setAttribute("allowModify",allowModify);
    
    String service_status_bd = request.getParameter("service_status_bd");
    request.setAttribute("service_status_bd",service_status_bd);
    
    String allowModifyOrder = request.getParameter("allowModifyOrder");
    request.setAttribute("allowModifyOrder",allowModifyOrder);
    
    String minMonth = request.getParameter("minMonth");
    request.setAttribute("minMonth",minMonth);
   
    String maxMonth = request.getParameter("maxMonth");
    request.setAttribute("maxMonth",maxMonth);
    
    String minMonthGjj = request.getParameter("minMonthGjj");
    request.setAttribute("minMonthGjj",minMonthGjj);
   
    String maxMonthGjj = request.getParameter("maxMonthGjj");
    request.setAttribute("maxMonthGjj",maxMonthGjj);
    
    String off_post_date = request.getParameter("off_post_date");
    request.setAttribute("off_post_date",off_post_date);
    
    String sendDataToXpress = request.getParameter("sendDataToXpress");
    request.setAttribute("sendDataToXpress",sendDataToXpress);
    
    System.out.println("~~~~~~~~~~~~~~~:"+allowModify);
    System.out.println("~~~~~~~~~~~~~~~:"+allowModifyOrder);
    System.out.println("~~~~~~~~~~~~~~~:"+minMonth);
    System.out.println("~~~~~~~~~~~~~~~:"+maxMonth);
    System.out.println("~~~~~~~~~~~~~~~:"+minMonthGjj);
    System.out.println("~~~~~~~~~~~~~~~:"+maxMonthGjj);
    System.out.println("~~~~~~~~~~~~~~~:"+off_post_date);
    System.out.println("~~~~~~~~sendDataToXpress~~~~~~~:"+sendDataToXpress);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.common.customer.customerservice.customerservice_resource" prefix="rayoo.common.customer.customerservice.">
<head>
<base target="_self"> 
<script type="text/javascript">
    function back_onClick(){
        var postId = document.form.postId.value;
        var isModify = document.form.isModify.value;
        var backJSP = document.form.backJSP.value;
        if(backJSP == "quanguo"){
            form.action='<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderForQuanGuo&id='+postId
        }else{
            if(isModify!=null && isModify=='1'){
	           form.action='<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+postId+'&isModify=1';
	        }else{
	           form.action='<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrder&id='+postId;
	        }
        }
        form.submit();
    }
    
    
    //个人订单修改
    function updateOrderDetail_onClick(){
        if(confirm('<fmt:message key="sure_update_order_info_operation"/>')) {
                //$id('Method').value="batchback";
                $id("datacell1").submit();//提交       
        }
    }
    
    function checkOrderDate(){
        var end_date_order = "";
        var start_date_order = "";
        var dc = $id("datacell1");
        var ds = dc.dataset;
        var flag1 = true;
        var flag2 = true;
        var elementCheckbox = document.getElementsByName("checkbox_template");  //通过name取出所有的checkbox
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            var row = dc.table.tBodies[0].rows[i];//第二个checkbox其实是第一行
            var entity = dc.getEntity(row);
            var end_date = entity.getValue("end_date");
            var start_date = entity.getValue("start_date");
            if(end_date_order == ""){
                end_date_order = end_date;
            }else{
                if(end_date_order != end_date){
                  flag1 = false;
                }
            }
            
            if(start_date_order == ""){
                start_date_order = start_date;
            }else{
                if(start_date_order != start_date){
                  flag2 = false;
                }
            }
            
        }
        if(flag1 && "${allowModifyOrder}" == "allowModifyEnd"){
            document.getElementById("modifyAllEndDate").value=end_date_order;
        }
        if(flag2 && "${allowModifyOrder}" == "allowModifyStart"){
            document.getElementById("modifyAllStartDate").value=start_date_order;
        }
    }
    
    
    function update_onClick(){  //保存修改
        var start_date = $id("start_date").value;
        var datacell1 = $id("datacell1");
        if(start_date==null || start_date==''){
            alert('<fmt:message key="please_check_in_order_begin_date"/>');
            return;
        }
        var end_date = $id("end_date").value;
        if(end_date==null || end_date==''){
            alert('<fmt:message key="please_check_in_order_end_date"/>');
            return;
        }
        
        var postId = jQuery("#postId").val();
        var orderId = jQuery("#orderId").val();
        if(orderId==null || orderId==''){
            alert('<fmt:message key="order_code_is_null"/>');
            return;
        }
        if(postId==null || postId==''){
            alert('<fmt:message key="post_code_is_null"/>');
            return;
        }
        
       var allowSummitBG = checkModifyStatus(null,false,"2",null);//是否有变更审批中的数据，有则不允许修改
        
       if(allowSummitBG){
	        checkOrderDate();
	        var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=updateOrdercheck";
	        var xmlSubmit = datacell1.dataset.toString();
	        var myAjax = new Ajax(action);
	        
	        myAjax.addParam('start_date', start_date);
	        myAjax.addParam('end_date', end_date);
	        myAjax.addParam('orderId', orderId);
	        myAjax.addParam('postId', postId);
	        
	        myAjax.submitXML(xmlSubmit, 'UTF-8');
	        var returnNode = myAjax.getResponseXMLDom();
	        if( returnNode ) {
	             if( myAjax.getValue("root/data/returnValue") == 2 ) {
	                 alert( '<fmt:message key="notice1"/>');
	                 return false;
	             }
	             else if( myAjax.getValue("root/data/returnValue") == 3 ) {
	                 if(!confirm( '<fmt:message key="notice2"/>')){
	                     return false;
	                 }
	             }
	             //判断是否为GE员工，如果是则不能修改订单明细  tanyanjun 20141027
	             else if( myAjax.getValue("root/data/returnValue") == 4 ) {
	                 alert("GE客户下员工不能修改订单明细！");
	                 window.location.reload();
	                 document.getElementById("modifyButton").disabled = true;
	                 return false;
	             }
	            
	            //获取页面行的修改状态
	            var datacell1 = $id("datacell1");
	            var dataset1 = datacell1.dataset;//取得页面的datacell
	            for(var i=0; i<dataset1.getLength(); i++){
	                var datasettr = dataset1.get(i);
	                datasettr.setProperty("status",datasettr.status);
	           }
	           
	            //魏佳新增，判断是否需要走审批流程
	            var cmd = "";
	            if("${sendDataToXpress}" == "true"){
                    cmd = "updateOrderDetailXpress";
                }else if(needShenPi){
                    cmd = "updateOrderDetailShenPi";
                }else {
                   cmd = "updateOrderDetail";
                }
	            
	            var action1 = "<%=request.getContextPath()%>/EmppostAction.do?cmd="+cmd;
	            var xmlSubmit1 = datacell1.dataset.toString();
	            var myAjax1 = new Ajax(action1);
	            
	            myAjax1.addParam('start_date', start_date);
	            myAjax1.addParam('end_date', end_date);
	            myAjax1.addParam('orderId', orderId);
	            myAjax1.addParam('postId', postId);
	            myAjax1.addParam('allowModifyOrder', "${allowModifyOrder}");
	            
	            myAjax1.addParam('modifyAllEndDate', $id("modifyAllEndDate").value);
	            myAjax1.addParam('modifyAllStartDate', $id("modifyAllStartDate").value);
	            
	            myAjax1.addParam('sbStartDate', $id("sbStartDate").value);
	            myAjax1.addParam('sbEndDate', $id("sbEndDate").value);
	            myAjax1.addParam('gjjStartDate', $id("gjjStartDate").value);
	            myAjax1.addParam('gjjEndDate', $id("gjjEndDate").value);
	            myAjax1.addParam('needShenPi', needShenPi);
	            
	            myAjax1.submitXML(xmlSubmit1, 'UTF-8');
	            var returnNode1 = myAjax1.getResponseXMLDom();
	            if( returnNode1 ) {
	                if( myAjax1.getValue("root/data/returnValue") == 1 ) {
	                     alert( '<fmt:message key="order_date_and_info_save_succese"/>' );
	                 }else if(myAjax1.getValue("root/data/returnValue") == null || (myAjax1.getValue("root/data/returnValue")) == "" || (myAjax1.getValue("root/data/returnValue")) == "null") {
                          alert( '<fmt:message key="order_info_update_error"/>' );
                     }else{
	                   alert(myAjax1.getValue("root/data/returnValue"));
	                 }
	                 window.location.reload();
                     document.getElementById("modifyButton").disabled = true;
	            }
	             
	        }
        }else{
           return; 
        }
    }
    
    //订单的收费起始日期变化了，所有的收费起始日期也要跟着变化
    function toStartDate(){
        var input_date = $id("start_date").getValue();
        if(input_date==null || input_date==''){
            alert('<fmt:message key="check_in_order_fee_begin_date_not_null"/>');
            return;
        }
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;//取得页面的datacell
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            datacell.selectRow(i);
            dataset.get(i).setProperty("start_date",input_date);
            datacell.refreshRow(datacell.getRow(i));
        }
    }
    
    //订单的收费结束日期变化了，所有的收费结束日期也要跟着变化
    function toEndDate(){
        var input_date = $id("end_date").getValue();
        if(input_date==null || input_date==''){
            alert('<fmt:message key="check_in_order_fee_begin_date_not_null"/>');
            return;
        }
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;//取得页面的datacell
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            datacell.selectRow(i);
            dataset.get(i).setProperty("end_date",input_date);
            datacell.refreshRow(datacell.getRow(i));
        }
    }
    
    
    //全选
	function checkAllPro(item){
	    if (jQuery(item).attr("checked")) {
	          chkAllEntity(1);
			  jQuery(":checkbox").attr("checked", true);
	    } else {
	        chkAllEntity(0);
	        jQuery(":checkbox").attr("checked", false);
	    }
	}
	
	//显示一列chkbox
	function setCheckBoxStatus(value,entity,rowNo,cellNo){
	    //初始化checkbox时设置是否选中
	    if(value != "" && value !="null" && value != null){//设置最后一行合计不添加复选框
		    //yangyuting add 2016-04-28 营改增的产品不能做修改
	        //1099110200000000098-营业税  1099110200000000136-工资营业税 
	        //2015800100000000001-专项外包营业税  3014800100000000001-浙江-外包营业税 
	        //2018800100000000001-营业税及营业税附加  2013800100000000169-月度营业税及附加税申报
	        //2013800100000000187-季度营业税申报
	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
	    		 return "";
	    	 }
	    	 else{
	    		  var flag = entity.getProperty("chk")=="1"? "checked" : "";
	  	        return "<input "+flag+" onclick='chkEntity("+rowNo+");' type='checkbox' name='checkbox_template' value='" + value + "' />";

	    	 }
	    }
	}
	
	//设置ENTITY的chk属性
	function chkEntity(rowNo){
	    var emps = $id("datacell1").dataset.values;
	    var entity = emps[rowNo];
	    var chk = entity.getProperty("chk");
	    entity.setProperty("chk",1-chk);
	}
	
	//设置选中ENTITY的chk属性
	function chkAllEntity(flag){
	    var ds = $id("datacell1").dataset;
	    var values = ds.values;
	    for(var i=0; i<values.length; i++){
	        var entity = values[i];
	        if(entity.getValue("product_name") != ""){
			   entity.setProperty("chk", flag);
	        }
	    }
	}
    
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="fee_segment_detail"/></title>

 </head>
<body>
<form name="form" action="" method="post"> 
<input type="hidden" id="postId" name="postId" value="<%=postId %>">
<input type="hidden" id="sumMoney" name="sumMoney" value="<%=vo1.getSum_money() %>">
<input type="hidden" id="sumEMoney" name="sumEMoney" value="<%=vo1.getSum_emoney() %>">
<input type="hidden" id="sumPMoney" name="sumPMoney" value="<%=vo1.getSum_pmoney() %>">
<input type="hidden" id="isModify" name="isModify" value="${isModify}">
<input type="hidden" id="orderId" name="orderId" value="${orderId}">
<input type="hidden" id="backJSP" name="backJSP" value="${backJSP}">

<input type="hidden" id="modifyAllStartDate" name="modifyAllStartDate" value="">
<input type="hidden" id="modifyAllEndDate" name="modifyAllEndDate" value="">

<input type="hidden" id="sbStartDate" name="sbStartDate" value="">
<input type="hidden" id="sbEndDate" name="sbEndDate" value="">

<input type="hidden" id="gjjStartDate" name="gjjStartDate" value="">
<input type="hidden" id="gjjEndDate" name="gjjEndDate" value="">

<div id="right">
 <div class="ringht_s">
 
 
<div id="ccChild0" class="box_3">  

     <div class="xz_title">  </div>
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"> <fmt:message key="begin_date"/></td>
            <td class="td_2">
            <%if(allowModify.equals("false")){%>
                <input type="text" id="start_date" name="start_date" class="xText" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getStart_date(), 10)%>" />
            <%}else{ %>
                <w:date format="yyyy-MM-dd" id="start_date" name="start_date" onchange="toStartDate();" style="width:172px" value="<%=RmStringHelper.prt(resultVo.getStart_date(), 10)%>" />
            <%} %>
            <td class="td_1"> <fmt:message key="end_date"/></td>
            <td class="td_2">
            <%if(allowModify.equals("false")){%>
                <input type="text" id="end_date" name="end_date" class="xText" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getEnd_date(), 10)%>" />
            <%}else{ %>
                <w:date format="yyyy-MM-dd" id="end_date" name="end_date" onchange="toEndDate();" style="width:172px" value="<%=RmStringHelper.prt(resultVo.getEnd_date(), 10)%>" />
            <%} %>
          </tr>
          <tr>
            <td class="td_1"> <fmt:message key="check_in_date"/></td>
            <td class="td_2"><input type="text" value="<%=RmStringHelper.prt(resultVo.getApply_date(), 10) %>" class="xText" id="user3" disabled="disabled"/></td>
            <td class="td_1"> <fmt:message key="money"/></td>
            <td class="td_2"><input name="text22" type="text" class="xText" id="text22" disabled="disabled" value="<fmt:formatNumber value='<%=resultVo.getOrder_amount() %>' pattern='###,###,###,###.##'  minFractionDigits='2'/>"/></td>
          </tr>
          <tr>
            <td class="td_1"> <fmt:message key="last_update_user"/> </td>
            <%
            if(resultVo.getLast_update_user_id()!=null&&resultVo.getLast_update_user_id()!=""&&resultVo.getLast_update_user_id()!="null"){
            %>   
            <td class="td_2"><input name="text3" type="text" class="xText" id="text6" disabled="disabled" value="<%=OrgHelper.getPartyVoByID(resultVo.getLast_update_user_id()).getName() %>"/></td>
            <%}else{%>
            <td class="td_2"><input name="text3" type="text" class="xText" id="text6" disabled="disabled" value=""/></td>
            <%} %>
            <td class="td_1"> <fmt:message key="last_update_date"/></td>
            <%
            if(resultVo.getLast_update_date()!=null){ %>
            <td class="td_2"><input name="text5" type="text" class="xText" id="text8" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getLast_update_date(), 10) %>"/></td>
            <%}else{ %>
            <td class="td_2"><input name="text5" type="text" class="xText" id="text8" disabled="disabled" value=""/></td>
            <%} %>
          </tr>
        
     </table>
    </div>
    
    <div id="ccParent1" class="button"> 
     <div class="button_right">
        <c:if test="${isModify=='1'}">
            <input id="modifyButton" type="button" class="bl" value='<fmt:message key="modify"/>' onClick="update_onClick();" />
       </c:if>
    </div>
    <div class="clear"></div>           
    </div>
    
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=searchDetailPerOrderItemData&orderId=${orderId}"
        submitAction="/FAERP/EmppostAction.do?cmd=updateOrderDetail" 
        width="97%"
        height="320px"
        xpath="EpemporderitemVo"
        submitXpath="EpemporderitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        >
        <r:field fieldName="id" messagekey="group_name" allowModify="false" width="0"></r:field> 
        <r:field fieldName="product_id" label="<input type='checkbox' id='chkbox_all' name='checkAll' onclick='checkAllPro(this);'/>" 
        width="35px" sortAt="none" onRefreshFunc="setCheckBoxStatus"  align="center"></r:field>
          <r:field fieldName="product_name" messagekey="product_name" allowModify="false">
               <h:text/>   
           </r:field>    
          <r:field fieldName="group_name" messagekey="group_name" allowModify="false">
               <h:text/>   
           </r:field>
          <r:field fieldName="group_type_bd" messagekey="group_name" allowModify="false" width="0"></r:field>
          <r:field fieldName="modifyType" messagekey="modifyType" allowModify="false" width="0"></r:field>
          <r:field fieldName="security_status_bd" messagekey="security_status_bd" allowModify="false" width="0"></r:field>
          <r:field fieldName="base" messagekey="base" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey="all_money" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey="e_money" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey="p_money" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="e_ratio" messagekey="e_ratio" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="p_ratio" messagekey="p_ratio" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="e_add_money" messagekey="e_add_money" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="p_add_money" messagekey="p_add_money" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="is_prepay" messagekey="is_prepay" >
            <d:select dictTypeId="IS_PHYSICAL_EXAM"/>
          </r:field>
          <r:field fieldName="frequency_bd" messagekey="frequency_bd" >
            <d:select dictTypeId="FREQUENCY_BD"/>
          </r:field>
          <r:field fieldName="is_preget" messagekey="is_preget" >
            <d:select dictTypeId="ISPREGET"/>
          </r:field>
          <r:field fieldName="start_date"  messagekey="fee_begin_date">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="end_date" messagekey="fee_end_date">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="is_effected" messagekey="status" >
            <d:select dictTypeId="IS_EFFECTED" filterOp="in"/>
          </r:field>
          <r:field fieldName="is_foreign_welfare" label="是否做外地福利" allowModify="false" >
            <d:select dictTypeId="TrueOrFalse" filterOp="in"/>
          </r:field>
          <r:field fieldName="on_apply_date" label="财务开始时间">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="off_apply_date" label="财务结束时间">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="last_update_user_name" messagekey="last_update_user" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="last_update_date" messagekey="last_update_date" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
    </r:datacell>
    </div>
          
    <div class="foot_button">
       <input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
    </div>
    
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>

<script type="text/javascript">
	var dateList = []; //魏佳新增 -- 页面加载完成以后，将所有的对应行的开始时间结束时间放入集合中，供后面限制修改员工法定福利起始时间使用
	//魏佳新增--全局变量，供限制修改员工法定福利起始时间使用
    var oldStartDate = "";
    var oldEndDate = "";
    var needShenPi = false;
    var allowModifyAll = true;
    var fieldName = "";
    var indexrow = "";
    
    
	jQuery(document).ready(function() {
	    if ("${auditStatus}" == "3") {
	        document.getElementById("modifyButton").disabled = true;
	    }
	    $id("datacell1").afterRefresh = function() {
	        var a = jQuery("#sumMoney").val();
	        var b = jQuery("#sumEMoney").val();
	        var c = jQuery("#sumPMoney").val();
	        $id("datacell1").addRow();
	        $id("datacell1").endEdit();
	        jQuery(".eos-body-div tr").last().find("td[fieldId^='product_name']").find("div").text("合计");
	        if (a != null && a != "" && a != "null") {
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='money']").find("div").text(jQuery("#sumMoney").val());
	        } else {
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='money']").find("div").text("0.00");
	        }
	        if (b != null && b != "" && b != "null") {
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='e_money']").find("div").text(jQuery("#sumEMoney").val());
	        } else {
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='e_money']").find("div").text("0.00");
	        }
	        if (c != null && c != "" && c != "null") {
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='p_money']").find("div").text(jQuery("#sumPMoney").val());
	        } else {
	            jQuery(".eos-body-div tr").last().find("td[fieldId^='p_money']").find("div").text("0.00");
	        }
	
	        //魏佳新增
	        var ds = $id("datacell1").dataset;
	        for (var i = 0; i < ds.getLength(); i++) {
	            var entity1 = ds.get(i);
	            var start_date = entity1.getProperty("start_date").substring(0, 10);
	            var end_date = entity1.getProperty("end_date").substring(0, 10);
	            var str = start_date + "|" + end_date; //组装每行的开始时间和结束时间成字符串
	            dateList.push(str); //将组装好的字符串放入集合中
	        }
	        chkAllEntity(0);
            jQuery(":checkbox").attr("checked", false);
            $id("datacell1").isModefied = false;
	    }
	});
	
	//后台返回的信息
	$id("datacell1").afterSubmit = function(ajax) {
	    alert("" + ajax.getProperty("returnValue"));
	}
	
	//魏佳新增 -- 在编辑前判断---已经服务分类了，社保公积金产品不能修改收费起始和结束日期
	$id("datacell1").beforeEdit = function(cell, colIndex, rowIndex) {
	    var datacell = $id("datacell1"); //获取datecell对象
	    var modifyStatus = true; //订单明细修改状态
	    var needTip = true; //是否需要提示
	    var activeRow = datacell.activeRow; //获取当前活动行
	    var entity1 = datacell.getEntity(activeRow); //得到当前操作的行dataset
	    var field = datacell.getField(cell); //获取当前操作的cell
	    var allowModifyOrder = "${allowModifyOrder}"; //限制订单修改的条件
	    var group_name = entity1.getProperty("group_name"); //获取当前操作行的社保组名称
	    var startDate = entity1.getProperty("start_date"); //获取当前操作行的开始日期
	    var endDate = entity1.getProperty("end_date"); //获取当前操作行的结束日期
	    var big_type_id = entity1.getValue("big_type_id"); //大类代码，999
	    var item_id = entity1.getValue("id"); //获取当前操作行的订单明细id
	    var product_name = entity1.getValue("product_name");
	    var product_id = entity1.getValue("product_id");//yangyuting add 2016-4-28 营改增的产品不能做修改
	    fieldName = field.fieldName;
	    indexrow = rowIndex;
       //if (product_name == "" || (allowModifyOrder == "false" && (fieldName == "start_date" || fieldName == "end_date"))) {
       if (product_name == "") {
              return false;
          } else {
            getInitVal(rowIndex,fieldName);
            if((fieldName == "start_date" || fieldName == "end_date") && big_type_id == "999"){
                if (allowModifyOrder == "allowModifyStart" && field.fieldName == "end_date") {
                    alert("在职员工更改代收付产品的收费截止日期请使用订单变更！");
                    return false;
                }
                if (allowModifyOrder == "allowModifyEnd" && field.fieldName == "start_date") {
                    alert("离职员工不得更改代收付产品的收费开始日期，只允许更改收费结束日期！");
                    return false;
                }
                
                modifyStatus = checkModifyStatus(big_type_id, true, "1",item_id); //是否有正在修改审批中的数据，有则不允许修改
                if (!modifyStatus) {
                    return false;
                }
            }else{
               if (group_name == null || group_name == "") { //如果当前操作行的社保组为空，证明不是社保公积金产品，可能是合计行
                   if ((field.fieldName == "start_date" || field.fieldName == "end_date") && (startDate == "" || startDate == null) && (endDate == "" || endDate == null)) {
                       return false;
                   }
               }
            }
            
            //yangyuting add 2016-04-28 营改增的产品不能做修改
            //1099110200000000098-营业税  1099110200000000136-工资营业税 
            //2015800100000000001-专项外包营业税  3014800100000000001-浙江-外包营业税 
            //2018800100000000001-营业税及营业税附加  2013800100000000169-月度营业税及附加税申报
            //2013800100000000187-季度营业税申报
            if(product_id=="1099110200000000098" || product_id=="1099110200000000136"|| product_id=="2015800100000000001" || product_id=="3014800100000000001"|| product_id=="2018800100000000001" || product_id=="2013800100000000169"|| product_id=="2013800100000000187" )
            {
         	   alert("含有营改增的产品不得修改！");
         	   return false;
            }
          }
	};
	
	//修改cell值以后操作
	$id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
	   var datacell = $id("datacell1"); //获取datecell对象
	   var dataset1 = datacell.dataset;//取得页面的datacell
       //var datasettr = dataset1.get(rowIndex);
       
       //datasettr.setProperty("status","2");
       //datasettr.setProperty("status","");
	
	
	   var allowModifyOrder = "${allowModifyOrder}"; //限制订单修改的条件
       var rc = this.dataset.getLength();
       var orderitems = this.dataset.values;
       var field = this.getField(activeCell.cellIndex); //获取当前操作的cell
       var groupType = activeEntity.getValue("group_type_bd");//社保组类别1社保2公积金
       var big_type_id = activeEntity.getValue("big_type_id"); //大类代码，999
       var product_name = activeEntity.getValue("product_name");
       var chk0 = activeEntity.getProperty("chk");
       var security_status_bd0 = activeEntity.getValue("security_status_bd");
       
       //alert(activeEntity.getProperty("status"));
       
       if(activeFieldName != "start_date" && activeFieldName != "end_date"){
           for(var i=0; i<rc; i++){
              var entity = orderitems[i];
              var chk = entity.getProperty("chk");
              if(chk == "1"){
               entity.setProperty("modifyType","1");
               var curCell = this.getCell(i,activeCell.cellIndex);
               this.setCellValue(curCell,newValue); 
              }
           }
       }else{
           var oldValue = "";
           if(activeFieldName == "start_date"){
              oldValue = oldStartDate;
           }else if(activeFieldName == "end_date"){
              oldValue = oldEndDate;
           }
           var minMonth = "";
           var maxMonth = "";
           //日期比较
           var newD = new Date(newValue.replace("-", "/").replace("-", "/"));
           var oldD = new Date(oldValue.replace("-", "/").replace("-", "/"));
           var flag = true;
           if (newD < oldD) {
               flag = false;
           } else {
               flag = true;
           }
              if (activeFieldName == "start_date") { //修改开始时间
                if(big_type_id == "999"){
                    if (newValue != oldStartDate) {
	                    if (!flag) { //往前修改开始时间
	                        alert("在职员工不允许调整开始日期到原订单开始日期之前，需做订单变更！");
	                        allowModifyAll = false;
	                    } else { //往后修改开始时间  //没有支付记录,并且社保状态职位2应办，3在缴的
	                       if(groupType == "1"){
                               minMonth = "${minMonth}";
                               maxMonth = "${maxMonth}";
                           }else if(groupType == "2"){
                               minMonth = "${minMonthGjj}";
                               maxMonth = "${maxMonthGjj}";
                           }
	                        modifyStartForAfterUpdateCell(newD,minMonth,maxMonth,security_status_bd0);
	                    }
	                    if(allowModifyAll){
                            for(var i=0; i<rc; i++){
                              var entity = orderitems[i];
                              var group_type_bd = entity.getValue("group_type_bd");
                              var chk1 = entity.getProperty("chk");
                              var security_status_bd = entity.getValue("security_status_bd");
                              var type_id = entity.getValue("big_type_id");
                              //modifyStartForAfterUpdateCell(newD,minMonth,maxMonth,security_status_bd);
                              if(!allowModifyAll){
                                overWriteStart(rc,orderitems,activeCell);
                                return;
                              }else{
                                  if(chk1 == "1" && chk0 == "1"){
                                    if(group_type_bd == "1"){//社保
                                        document.getElementById("sbStartDate").value=newValue;
                                    }
                                    if(group_type_bd == "2"){//公积金
                                        document.getElementById("gjjStartDate").value=newValue;
                                    }
                          		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                         	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                         	    	 }else{
	           	                        var curCell = this.getCell(i,activeCell.cellIndex);
	           	                        this.setCellValue(curCell,newValue); 
                         	    	 }
                                    entity.setProperty("modifyType","1");
                                  }else if(group_type_bd == groupType && entity.getValue("product_name") != ""){
                                    if(groupType == "1"){//社保
                                        document.getElementById("sbStartDate").value=newValue;
                                    }
                                    if(groupType == "2"){//公积金
                                        document.getElementById("gjjStartDate").value=newValue;
                                    }
                          		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                        	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                        	    	 }else{
	           	                        var curCell = this.getCell(i,activeCell.cellIndex);
	           	                        this.setCellValue(curCell,newValue); 
                        	    	 }
                                    entity.setProperty("modifyType","1");
                                  }
                              }
                           }
                        }else{
                            overWriteStart(rc,orderitems,activeCell);
                            if(groupType == "1"){//社保
                                document.getElementById("sbStartDate").value="";
                            }
                            if(groupType == "2"){//公积金
                                document.getElementById("gjjStartDate").value="";
                            }
                        }
	                }else{
	                    for(var i=0; i<rc; i++){
	                       var entity = orderitems[i];
	                       var group_type_bd = entity.getValue("group_type_bd");
	                       var chk = entity.getProperty("chk");
	                       
	                       if(chk == "1"){
                              var curCell = this.getCell(i,activeCell.cellIndex);
                              if(group_type_bd == groupType && entity.getValue("product_name") != ""){
                                entity.setProperty("modifyType","0");
                      		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                    	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                    	    	 }else{
                              	  this.setCellValue(curCell,oldStartDate);   
                    	    	 }
                              }
                            }else if(group_type_bd == groupType && entity.getValue("product_name") != ""){
                    		    //yangyuting add 2016-04-28 营改增的产品不能做修改
	                 	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
	                 	    	 }else{
                                  var curCell = this.getCell(i,activeCell.cellIndex);
	                           	  this.setCellValue(curCell,oldStartDate);   
	                 	    	 }
                              entity.setProperty("modifyType","0");   
                            }
	                       
                        }
                        if(groupType == "1"){//社保
                            document.getElementById("sbStartDate").value="";
                        }
                        if(groupType == "2"){//公积金
                            document.getElementById("gjjStartDate").value="";
                        }
                        
	                }
                }else{
                  allowModifyAll = true;
                  for(var i=0; i<rc; i++){
                      var entity = orderitems[i];
                      var group_type_bd = entity.getValue("group_type_bd");
                      var big_type_id = entity.getValue("big_type_id");
                      var chk3 = entity.getProperty("chk");
                      if(chk3 == "1" && big_type_id !="999"){
              		    //yangyuting add 2016-04-28 营改增的产品不能做修改
              	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
              	    	 }else{
	                        var curCell = this.getCell(i,activeCell.cellIndex);
	                        this.setCellValue(curCell,newValue); 
              	    	 }
                        entity.setProperty("modifyType","1");
                      }
                   }
                 }
            } else if (activeFieldName == "end_date") { //修改结束时间
                if(big_type_id == "999"){
	                if (newValue != oldEndDate) {
	                    //"${service_status_bd}" //1 驳回2 应办3 在缴4 停缴5 过期
	                    if (!flag) { //往前修改结束时间    有支付记录并且是在缴的员工可以修改但是修改的日期一定要大于支付最晚年月并需要审批
	                       if(groupType == "1"){
                               minMonth = "${minMonth}";
                               maxMonth = "${maxMonth}";
                           }else if(groupType == "2"){
                               minMonth = "${minMonthGjj}";
                               maxMonth = "${maxMonthGjj}";
                           }
	                        modifyEndForAfterUpdateCell1(newD,minMonth,maxMonth,security_status_bd0);
	                    } else { 
	                        modifyEndForAfterUpdateCell2(security_status_bd0);
	                    }
	                    if(allowModifyAll){
	                        for(var i=0; i<rc; i++){
	                          var entity = orderitems[i];
	                          var group_type_bd = entity.getValue("group_type_bd");
	                          var chk2 = entity.getProperty("chk");
	                          var security_status_bd = entity.getValue("security_status_bd");
	                          if(group_type_bd == groupType){
	                              if(group_type_bd == "1"){
		                               minMonth = "${minMonth}";
		                               maxMonth = "${maxMonth}";
		                           }else if(group_type_bd == "2"){
		                               minMonth = "${minMonthGjj}";
		                               maxMonth = "${maxMonthGjj}";
		                           }
		                          if (!flag) { //往前修改结束时间    有支付记录并且是在缴的员工可以修改但是修改的日期一定要大于支付最晚年月并需要审批
	                                    modifyEndForAfterUpdateCell1(newD,minMonth,maxMonth,security_status_bd);
	                              } else { 
	                                    modifyEndForAfterUpdateCell2(security_status_bd);
	                              }
	                          }
	                          
			                  if(!allowModifyAll){
			                      overWriteEnd(rc,orderitems,groupType,activeCell);
			                      return;
		                      }else{
		                          if(chk2 == "1" && chk0 == "1"){
		                            if(group_type_bd == "1"){//社保
                                        document.getElementById("sbEndDate").value=newValue;
                                    }
                                    if(group_type_bd == "2"){//公积金
                                        document.getElementById("gjjEndDate").value=newValue;
                                    }
                          		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                         	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                         	    	 }else{
	           	                        var curCell = this.getCell(i,activeCell.cellIndex);
	           	                        this.setCellValue(curCell,newValue); 
                         	    	 }
           	                        entity.setProperty("modifyType","1");
		                          }else if(group_type_bd == groupType && entity.getValue("product_name") != ""){
		                            if(groupType == "1"){//社保
                                        document.getElementById("sbEndDate").value=newValue;
                                    }
                                    if(groupType == "2"){//公积金
                                        document.getElementById("gjjEndDate").value=newValue;
                                    }
                          		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                        	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                        	    	 }else{
	           	                        var curCell = this.getCell(i,activeCell.cellIndex);
	           	                        this.setCellValue(curCell,newValue); 
                        	    	 }
		                            entity.setProperty("modifyType","1");
		                          }
		                      }
	                       }
	                    }else{
	                       overWriteEnd(rc,orderitems,groupType,activeCell);
	                       if(groupType == "1"){//社保
                                document.getElementById("sbEndDate").value="";
                            }
                            if(groupType == "2"){//公积金
                                document.getElementById("gjjEndDate").value="";
                            }
	                    }
	                }else{
	                    for(var i=0; i<rc; i++){
	                        var entity = orderitems[i];
                            var group_type_bd = entity.getValue("group_type_bd");
                            var chk = entity.getProperty("chk");
                            
	                        if(chk == "1"){
                              if(group_type_bd == groupType && entity.getValue("product_name") != ""){
                        		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                      	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                      	    	 }else{
	                                var curCell = this.getCell(i,activeCell.cellIndex);
	                                this.setCellValue(curCell,oldEndDate);   
                      	    	 }
                                entity.setProperty("modifyType","0");
                              }
	                        }else if(group_type_bd == groupType && entity.getValue("product_name") != ""){
                  		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                   	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                   	    	 }else{
	                                var curCell = this.getCell(i,activeCell.cellIndex);
	                                this.setCellValue(curCell,oldEndDate);   
                   	    	 }
                              entity.setProperty("modifyType","0");   
	                        }
	                     }
	                     if(groupType == "1"){//社保
                             document.getElementById("sbEndDate").value="";
                         }
                         if(groupType == "2"){//公积金
                             document.getElementById("gjjEndDate").value="";
                         }
	                }
                }else{
                  allowModifyAll = true;
	              for(var i=0; i<rc; i++){
	                  var entity = orderitems[i];
	                  var group_type_bd = entity.getValue("group_type_bd");
	                  var big_type_id = entity.getValue("big_type_id");
	                  var chk3 = entity.getProperty("chk");
	                  if(chk3 == "1" && big_type_id !="999"){
                		    //yangyuting add 2016-04-28 营改增的产品不能做修改
                	    	 if(entity.getValue("product_id")=="1099110200000000098" || entity.getValue("product_id")=="1099110200000000136"|| entity.getValue("product_id")=="2015800100000000001" || entity.getValue("product_id")=="3014800100000000001"|| entity.getValue("product_id")=="2018800100000000001" || entity.getValue("product_id")=="2013800100000000169"|| entity.getValue("product_id")=="2013800100000000187" ){
                	    	 }else{
         	                    var curCell = this.getCell(i,activeCell.cellIndex);
        	                    this.setCellValue(curCell,newValue); 
                	    	 }
	                    entity.setProperty("modifyType","1");
	                  }
	               }
	             }
              }    
       }            
    };
    
    $id("datacell1").afterEdit = function(newValue,oldValue) {
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var entity = datacell.getEntity(activeRow);
        if(!allowModifyAll){
           getInitVal(indexrow,fieldName);
           if(fieldName == "start_date"){
              entity.setProperty(fieldName, oldStartDate);
           }
           if(fieldName == "end_date"){
              entity.setProperty(fieldName, oldEndDate);
           }
        }
    }
	
    function modifyStartForAfterUpdateCell(newD,minMonth,maxMonth,security_status_bd){
        if(security_status_bd == "" || security_status_bd == null || security_status_bd == "null"){
            allowModifyAll = true;
        }else{
            if ((minMonth == "" && maxMonth == "") && (security_status_bd == "2" || security_status_bd == "3")) {
	            if (!needShenPi) {
	                needShenPi = true;
	            }
	            allowModifyAll = true;
	        } else { //有支付记录
	            var hasPayMonth = minMonth.substring(0, 4) + "/" + minMonth.substring(4, 6) + "/01";
	            var newHas = new Date(hasPayMonth);
	            if (newD > newHas) {
	                alert("该产品" + minMonth + "月已有支付记录，订单开始时间不能晚于此月!");
	                allowModifyAll = false;
	            } else {
	                if (!needShenPi) {
	                    needShenPi = true;
	                }
	                allowModifyAll = true;
	            }
	        }
        }
    }
    
    function modifyEndForAfterUpdateCell1(newD,minMonth,maxMonth,security_status_bd){
        if(security_status_bd == "" || security_status_bd == null || security_status_bd == "null"){
            allowModifyAll = true;
        }else{//1 驳回2 应办3 在缴4 停缴5 过期
            if (security_status_bd == "4") { //停缴的无法修改
	            alert("离职并已经停缴的员工无法修改订单结束日期！");
	            allowModifyAll = false;
	        } else {
	             if ((minMonth != "" && minMonth != "null" && minMonth != null) || (maxMonth != "" && maxMonth != "null" && maxMonth != null)) { 
	               if(security_status_bd == "2" || security_status_bd == "3"){
	                   if (!needShenPi) {
	                        needShenPi = true;
	                    }
	                    var hasPayMonth = maxMonth.substring(0, 4) + "/" + maxMonth.substring(4, 6) + "/30";
	                    var newHas = new Date(hasPayMonth);
	                    if (newD < newHas) {
	                        alert("该产品" + maxMonth + "月已有支付记录，订单结束日期不得早于该支付月!");
	                        allowModifyAll = false;
	                    } else {
	                        allowModifyAll = true;
	                    }
	                    allowModifyAll = true;
	               }else{
	                    alert("有支付记录并且不是在缴的员工!");
	                    allowModifyAll = false; 
	               }
	           }else{
	               if(security_status_bd == "2" || security_status_bd == "3" || security_status_bd == "1"){
	                    if (!needShenPi) {
	                        needShenPi = true;
	                    }
	                    allowModifyAll = true;
	               }
	           }
	        }
        }
    }
    
    
    function modifyEndForAfterUpdateCell2(security_status_bd){
        //往后修改结束时间
        //已停办的员工不允许修改
        //没有停办的员工可以修改，但是需要审批，审批后需修改员工的社保公积金表中的起止日期，
        //并且还要修改该员工在停办界面的收费截止月
        if(security_status_bd == "" || security_status_bd == null || security_status_bd == "null"){
            allowModifyAll = true;
        }else{
            if (security_status_bd == "4" || security_status_bd == "5") { //停缴的无法修改
	             alert("已经停缴的无法修改订单日期！");
	             allowModifyAll = false;
	         } else {
	             if (!needShenPi) {
	                 needShenPi = true;
	             }
	             allowModifyAll = true;
	         }  
        }
    }
    
    
    
    function overWriteStart(rc,orderitems,activeCell,activeFieldName){
        var datacell = $id("datacell1");
        for(var i=0; i<rc; i++){
          getInitVal(i,fieldName);
          var entity = orderitems[i];
          if(entity.getValue("product_name") != ""){
            var curCell = datacell.getCell(i,activeCell.cellIndex)
            datacell.setCellValue(curCell,oldStartDate);
            entity.setProperty("modifyType","0");
          }
        }
    }
    
    function overWriteEnd(rc,orderitems,groupType,activeCell,activeFieldName){
        var datacell = $id("datacell1");
        for(var i=0; i<rc; i++){
           var entity = orderitems[i];
           var group_type_bd = entity.getValue("group_type_bd");
           var chk = entity.getProperty("chk");
           var type_id = entity.getValue("big_type_id"); //大类代码，999
           getInitVal(i,fieldName);
           if(chk == "1" && type_id == "999"){
             var curCell = datacell.getCell(i,activeCell.cellIndex)
             datacell.setCellValue(curCell,oldEndDate);
           }else if(group_type_bd == groupType && entity.getValue("product_name") != ""  && type_id == "999"){
             var curCell = datacell.getCell(i,activeCell.cellIndex)
             datacell.setCellValue(curCell,oldEndDate);
           }
           entity.setProperty("modifyType","0");
     	     }
    }
    
    //魏佳新增，检查是否已经修改过该条数据
    function checkModifyStatus(big_type_id, needTip, type,item_id) {
        var status = true;
        var url = "";
        if (type == "1") {//是否有修改审批中的数据
            url = "<%=request.getContextPath()%>/EmppostAction.do?cmd=checkModifyStatus&type=5&postID=" + jQuery("#postId").val() + "&itemID="+item_id;
        } else if (type == "2") {//是否有变更审批中的数据
            url = "<%=request.getContextPath()%>/EmppostAction.do?cmd=checkModifyStatus&type=4&postID=" + jQuery("#postId").val();
        }
        
        jQuery.ajax({
            url: url,
            type: 'post',
            dataType: 'html',
            async: false,
            timeout: 80000,
            error: function() {
                alert('Error loading XML document');
                return null;
            },
            success: function(text) {
                if (text != null) {
                    if (type == "1" && text == "1" && big_type_id == "999") {
                        if (needTip) {
                            if("${sendDataToXpress}" == "true"){
                                alert("该员工的订单已经修改过，正等待Xpress审核确认，不能再次修改订单！");
                            }else{
                                alert("该员工的订单已经修改过，正等待审核确认，不能再次修改订单！");
                            }
                        }
                        status = false;
                    } else {
                        if (text == "1") {
                            if (needTip) {
                                alert("该员工的订单已经变更过，正等待审核确认，不能再次修改订单！");
                            }
                            status = false;
                        }
                    }
                }
            }
        });
        return status;
    }
    
    
    function getInitVal(rowIndex,fieldName){
      if (dateList[rowIndex]) {
          var obj = dateList[rowIndex].split("|");
          if (fieldName == "start_date") {
              oldStartDate = obj[0];
          } else if (fieldName == "end_date") {
              oldEndDate = obj[1];
          }
      }
    }
</script>

