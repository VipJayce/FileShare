<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.employeepost.emp_into_resignation_query.emp_into_resignation_query_resource" prefix="rayoo.employeepost.emp_into_resignation_query.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function getDetail_onClick() {
    	
    	 //$id("form1").submit();
    	 var cust_name = _$("input[name='cust_name']").val();
    	 var date_from = _$("input[name='date_from']").val();
    	 var date_to = _$("input[name='date_to']").val();
    	 var welfare_schedule = _$("input[name='welfare_schedule']").val();//福利办理进度
    	 var cust_group_input = _$("input[name='cust_group_input']").val();//客户组
    	 var cust_send_id_input = _$("input[name='agent_name']").val();//派出公司
    	 var dimensionality = document.getElementById('dimensionality').value;//维度
    	 //alert(dimensionality);
    	 //alert(cust_group_input);
    	 //alert(cust_send_id_input);
    	 
    	 
    if(dimensionality==0 && (cust_name=="" || cust_name==null)){
    	       alert("客户名称不能为空！");
    	       return;
    	 }
    	 if(dimensionality==1 && (cust_group_input=="" || cust_group_input==null)){
               alert("客户组不能为空！");
               return;
         }
         if(dimensionality==2 && (cust_send_id_input=="" || cust_send_id_input==null)){
               alert("派出公司不能为空！");
               return;
         }
         
         if(dimensionality==0 && (cust_group_input!="" || cust_send_id_input!="" ) ){
          alert("你维度选择了客户，请先清空 客户组、派出公司！");
          return;
         }
          if(dimensionality==1 && (cust_name!=""  || cust_send_id_input!="") ) {
         alert("你维度选择了客户组，请先清空 客户名称、派出公司！");
         return;
         }
          if(dimensionality==2 && (cust_name!="" || cust_group_input!="" ) ) {
         alert("你维度选择了派出公司，请先清空 客户名称、客户组！");
         return;
         }
        
    	 if(date_from!=""){
    	    _$("#button_ok2").attr("disabled", true); 
    	 	$id("form1").submit();
    		//var urlStr = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=getDetail";
	                /*jQuery.ajax({
	                    type : "post",
	                    url : urlStr,
	                    dataType : "html",
	                    data: {cust_name:cust_name,date_from:date_from,date_to:date_to},
	                    error: function(){
	                         alert('Ajax Error!');
	                         return;
	                     },success : function(data) {
	                        if(data=="1"){alert("生成报表失败！")}
	                        else{
	                        	
	                        }
	                        _$("#button_ok2").attr("disabled", false);
	                    }
	                });*/
    	}else{
    		alert("报表开始时间必填！");
    	}
    	 _$("#button_ok2").attr("disabled", false);
    	}
    	
    	    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //jQuery("#h_customer_id").val(arg[0]);        
        return false;
    }
     //派出公司
    function rtnFuncSendName(arg){
        var lookup = $id("lk_pcgs");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        //jQuery("#h_customer_id").val(arg[0]);        
        return false;
    }
    
    
   </script>
</head>
<body>

 <form name="form1" method="post" id="form1" action="/FAERP/EmpsecurityAction.do?cmd=getDetail">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('福利办理明细报表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
 
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

		<tr>
			<td align="left" width="130" height="120" rowspan="20" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
		</tr>
		
		<tr>
		<td align="left">维度</td>
		<td align="left"><select  name="dimensionality" id="dimensionality" datacellEditor="true" style="width:120px"><option value="0">客户</option><option value="1">客户组</option><option value="2">派出公司</option></select></td>
           
		 	<td >客户名称</td>
		 	<td >
                <w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
            </td>
			<td class="td_1">客户组</td>
			<td class="td_2">
                <!-- start of ComboSelect -->
					<div id="cust_group_container"  class="eos-ic-container" ><input class="eos-combo-select-editor-text" type="text" id="cust_group_input" name="cust_group_input" /><img id='cust_group_button' class='eos-ic-button'  /><input type="hidden" id="cust_group_hidden" name="cust_group" /></div><script type="text/javascript" >
					(function(){
					var eos_cust_group =new ComboSelect('cust_group'); 
					eos_cust_group.queryAction = "/FAERP/Cust_groupAction.do?cmd=queryListCustname"; 
					eos_cust_group.xpath = "Cust_groupVo"; 
					eos_cust_group.valueField = "cust_group_code"; 
					eos_cust_group.textField = "cust_group_name"; 
					eos_cust_group.width = "200px"; 
					eos_cust_group.value = ""; 
					eos_cust_group.nullText = ""; 
					eos_cust_group.isIeMode = false; 
					eos_cust_group.readOnly = false; 
					eos_cust_group.allowInput = false; 
					eos_cust_group.allowFilter = true; 
					eos_cust_group.disabled = false; 
					eos_cust_group.onPageLoad();
					})()
</script><!-- end of ComboSelect -->
            </td>
            <td class="td_1">派出公司</td>
            <td class="td_2">
                 
         <w:lookup name="agent_name" onReturnFunc="rtnFuncSendName" id="lk_pcgs" lookupUrl="/AgentAction.do?cmd=queryAllGetByID&queryType=2" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>

                
            </td>
		</tr>
		<tr>
		    <td align="left">报表开始时间</td>
            <td align="left"><w:date format="yyyy-MM-dd" name="date_from" width="80px"/></td>
            <td align="left">报表结束时间</td>
            <td align="left"><w:date format="yyyy-MM-dd" name="date_to" width="80px"/></td>
		
			<td align="left">福利办理进度</td>
            <td align="left"><select  name="welfare_schedule" datacellEditor="true" style="width:120px"><option value="0">统计全部</option><option value="1">统计未完成</option></select></td>
            </td>
            
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>   
 				<input name="button_ok2" id="button_ok2" class="icon_1"   type="button" value='生成报表' onClick="javascript:getDetail_onClick()">             
 			</td>
        </tr>
</table>
</div>
</form>
</body>
</fmt:bundle>
</html>

