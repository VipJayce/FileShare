<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
	function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#cust_id").val(arg[0]);       
	    return false;
	}
	
	function listchange(){
		 var create_type_bd = document.getElementById("create_type_bd").value; 
	     if(create_type_bd == 2){
	       document.getElementById( "chooseCust").style.display = "";
	     }else{
	       document.getElementById( "chooseCust").style.display = "none";
	     }
	}
	
	function update_onClick(){
		if(vali()){
		    valiQuote();
		    if(!jQuery("#cust_id").val() && document.getElementById( "chooseCust").style.display == ""){
		    	return;
		    }
			if(document.getElementById( "chooseCust").style.display == ""){
				var cust_id =  jQuery("#cust_id").val();
				form.action="<%=request.getContextPath()%>/JcustomerAction.do?cmd=toInsert&cust_id="+cust_id;
			}else{
				form.action="<%=request.getContextPath()%>/JcustomerAction.do?cmd=toInsert";
			}
			form.submit();
		}
	}
	
	function vali(){
		if(document.getElementById( "chooseCust").style.display == ""){
			var cust_id =  jQuery("#cust_id").val();
			if(!cust_id){
			 	alert("请选择客户");
	            return false;
			}
		}
		return true;
	}
	
	function valiQuote(){
		//效验数据是否已经引用
			 jQuery.ajax({
	           url: '<%=request.getContextPath()%>/JcustomerAction.do?cmd=valiQuote&cust_id='+jQuery("#cust_id").val(),
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert('该客户已经被引用!请重新选择');
	                  jQuery("#cust_id").val("");
	                  var lookup = jQuery("#lk_cust");
	   				  lookup.value = "";
	                  lookup.displayValue ="";
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert('该客户已经被引用!请重新选择');
	                  	   jQuery("#cust_id").val("");
	                       var lookup = jQuery("#lk_cust");
	   				  	   lookup.value = "";
	                  	   lookup.displayValue ="";
	                       return;
		               }
	               }
	          });
	}

</script> 
<title>新增方式选择</title>
</head>
<body>
<form name="form" method="post">
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height:200px "> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	<tr>
		<td class="td_1" ><span class="style_required_red">* </span>生成方式</td>
		<td class="td_2">
			<select id="create_type_bd" name="create_type_bd" style="width:200px"  onchange="listchange();">
                            <option value="1" >新建客户</option>
                            <option value="2" >引用原由客户</option>
            </select>
        </td>
    </tr>
    <tr id="chooseCust" style="display:none;">
	    <td class="td_1" ><span class="style_required_red">* </span>选择客户</td>
	    <td class="td_2">
	        <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
	        <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
	                  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
	                  height="440" width="710" allowInput="false" />
	    </td>
     </tr>
 </table>
 <div class="foot_button" style="text-align: center; margin-left: 0px;">
        <input type="button" class="icon_2" value='<fmt:message key="confirm"/>' onClick="javascript:update_onClick();" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="window.close();"/>
 </div> 
 </div>
 </div>
 </form>
 </fmt:bundle>
</body>
</html>
