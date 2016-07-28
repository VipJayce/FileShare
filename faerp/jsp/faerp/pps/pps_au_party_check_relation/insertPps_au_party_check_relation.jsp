<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.pps_au_party_check_relation.vo.Pps_au_party_check_relationVo" %>
<%@ page import="rayoo.pps.pps_au_party_check_relation.util.IPps_au_party_check_relationConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	Pps_au_party_check_relationVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPps_au_party_check_relationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Pps_au_party_check_relationVo)request.getAttribute(IPps_au_party_check_relationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		var  pps_cust_id = $id("pps_cust_id").getValue();
        var  pps_cust_check_id=$id("pps_cust_check_id").getValue();
        var  o_remark = document.getElementById("o_remark").value;
        if(pps_cust_id==null||pps_cust_id==""){
        	alert("请选择PPS客户!");
            return;
        }else{
        	 var isTure = "false";
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=vailCust&id='+pps_cust_id,
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert("请重新选择PPS客户");
	                  $id("pps_cust_id").setValue("");
	                  $id("pps_cust_id").getDisplayValue("");
	                  isTure = "true";
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert("请重新选择PPS客户");
		                   $id("pps_cust_id").setValue("");
		                   $id("pps_cust_id").getDisplayValue("");
		                   isTure = "true";
		                   return;
		               }else{
		               	   isTure = "false";
		               }
	               }
	        });
	        if(isTure == "true"){
	        	return;
	        }
        }
        if(pps_cust_check_id==null||pps_cust_check_id==""){
        	alert("请输入PPS复核客户!");
            return;
        }else{
             var isTure = "false";
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=vailCust&check_id='+pps_cust_check_id,
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert("请重新选择PPS复核客户");
	                  $id("pps_cust_id").setValue("");
	                  $id("pps_cust_id").getDisplayValue("");
	                  isTure = "true";
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert("请重新选择PPS复核客户");
		                   $id("pps_cust_check_id").setValue("");
		                   $id("pps_cust_check_id").getDisplayValue("");
		                   isTure = "true";
		                   return;
		               }else{
		               	   isTure = "false";
		               }
	               }
	        });
	        if(isTure == "true"){
	        	return;
	        }
        }
        if(pps_cust_id==pps_cust_check_id){
        	alert("PPS复核客户不能与PPS客户冲突！");
        	return;
        }
        var action="<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=insert";
        var myAjax = new Ajax(action);
        myAjax.addParam('pps_cust_id', pps_cust_id);
        myAjax.addParam('pps_cust_check_id', pps_cust_check_id);
        myAjax.addParam('o_remark', o_remark);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
	        alert(""+myAjax.getProperty("returnValue"));
	        window['returnValue'] = ""+myAjax.getProperty("returnValue");
	        window.close();
	        window.opener.simpleQuery_onClick();
        }
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var  pps_cust_id = $id("pps_cust_id").getValue();
        var  pps_cust_check_id=$id("pps_cust_check_id").getValue();
        var  o_remark = document.getElementById("o_remark").value;
        var  id = document.getElementById("id").value;
        var  pps_cust_check_id_bak = document.getElementById("pps_cust_check_id_bak").value;
        if(pps_cust_check_id==null||pps_cust_check_id==""){
        	alert("请输入PPS复核客户!");
            return;
        }else if(pps_cust_check_id!=pps_cust_check_id_bak){
        	 var isTure = "false";
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=vailCust&check_id='+pps_cust_check_id,
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert("请重新选择PPS复核客户");
	                  $id("pps_cust_id").setValue("");
	                  $id("pps_cust_id").getDisplayValue("");
	                  isTure = "true";
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert("请重新选择PPS复核客户");
		                   $id("pps_cust_check_id").setValue("");
		                   $id("pps_cust_check_id").getDisplayValue("");
		                   isTure = "true";
		                   return;
		               }else{
		               	   isTure = "false";
		               }
	               }
	        });
	        if(isTure == "true"){
	        	return;
	        }
        }
        if(pps_cust_id==pps_cust_check_id){
        	alert("PPS复核客户不能与PPS客户冲突！");
        	return;
        }
        var action="<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=update";
        var myAjax = new Ajax(action);
        myAjax.addParam('pps_cust_id', pps_cust_id);
        myAjax.addParam('pps_cust_check_id', pps_cust_check_id);
        myAjax.addParam('o_remark', o_remark);
        myAjax.addParam('id', id);
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
	        alert(""+myAjax.getProperty("returnValue"));
	        window['returnValue'] = ""+myAjax.getProperty("returnValue");
	        window.close();
	        window.opener.simpleQuery_onClick();
        }
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function rtnFunc(arg){
	    var lookup = $id("pps_cust_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    return false;
	}
	
	function rtnFuncCheck(arg){
	    var lookup = $id("pps_cust_check_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    return false;
	}
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
 <div class="ringht_x" style="height: 220px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 200px;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><span style="color: red;">*</span>PPS客户</td>
			<td class="td_2 ">
			<%if(isModify) { %>
				<w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" readOnly="true" name="pps_cust_id"  id="pps_cust_id" value="${bean.pps_cust_id }" displayValue="${bean.pps_cust_name }" lookupUrl="/PpssasalarytempletAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="710"/>
			<%}else{ %>
				<w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="true" name="pps_cust_id"  id="pps_cust_id" value="${bean.pps_cust_id }" displayValue="${bean.pps_cust_name }" lookupUrl="/PpssasalarytempletAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="710"/>
			<%} %>
			</td>
			<td class="td_1" ><span style="color: red;">*</span>PPS复核客户</td>
			<td class="td_2 ">
				<w:lookup onReturnFunc="rtnFuncCheck" lookupWidth="189px" readonly="true" name="pps_cust_check_id" id="pps_cust_check_id" value="${bean.pps_cust_check_id }" displayValue="${bean.pps_cust_check_name }" lookupUrl="/PpssasalarytempletAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="710"/>
				<input type="hidden" name="pps_cust_check_id_bak" id="pps_cust_check_id_bak" value="${bean.pps_cust_check_id }">
			</td>
		</tr>
		<tr>
			<td class="td_1" >备注</td>
			<td class="td_2" colspan="3">
				<textarea style="width: 420px;" rows="4"  name="o_remark" id="o_remark" inputName="备注" maxLength="100" ></textarea>
			</td>
		</tr>
	</table>
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
</div>         
<input type="hidden" name="id" id="id" value="">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
