<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.Map.Entry" %>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
 <head>
<title>codegen</title>
<% 
	Map errMsg =(HashMap) request.getAttribute("errMsg");
	Integer successNum = (Integer) request.getAttribute("successNum");
	String msg = "";
	if(errMsg != null && successNum != null){
		msg =  "导入完成，其中：\n成功"+successNum+"条\n失败"+errMsg.size()+"条：\n";
		for(Object object : errMsg.entrySet()){
			Entry key = (Entry) object;
			msg += "第"+key.getKey()+"条:"+key.getValue()+"\n";
		}
		request.setAttribute("errMsg",null);
		request.setAttribute("successNum",null);
	}

%>
 <script language="javascript">
window.onload = function() { 
	var msg = "<%=msg%>"
	if( msg!=null && ""!=msg){
		alert(msg);	
	}
}; 

 
 
 
 function cancel_onClick(){  //取消后返回列表页面
        window.close();
 }
 
  //打开文件上传对话框
 function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
 		window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
 }

//模板下载
function toDownLoad_onclick(){
	    var url="<%=request.getContextPath()%>/ImHolidayAction.do?cmd=downLoadExcel";
	    url=url+"&random="+Math.random();
        formImp.action=url;
        formImp.submit();
}

//提交验证
function insert_submit(){
	 var cust_id = $id("cust_id").value ;
        if(cust_id == null||cust_id==''){
            alert("请选择客户") ;
            return false ;
     }
     var attackAddressInput = $id("attackAddressInput").value ;
     if(attackAddressInput == null||attackAddressInput==''){
            alert("请选择要导入的文件！") ;
            return false ;
     }
     var attachNameInput = $id("attachNameInput").value;
     if(attachNameInput.indexOf(".xls")==-1){
            alert("导入文件必须为Excel 文件！") ;
            $id("attachNameInput").value="";
            $id("attackAddressInput").value=""
            return false ;
     }
}

function toImport_onclick(){
	var cust_id = $id("cust_id").value ;
        if(cust_id == null||cust_id==''){
            alert("请选择客户") ;
            return;
     }
     var attackAddressInput = $id("attackAddressInput").value ;
     if(attackAddressInput == null||attackAddressInput==''){
            alert("请选择要导入的文件！") ;
            return;
     }
     var attachNameInput = $id("attachNameInput").value;
     if(attachNameInput.indexOf(".xls")==-1){
            alert("导入文件必须为Excel 文件！") ;
            $id("attachNameInput").value="";
            $id("attackAddressInput").value=""
            return ;
     }
     var cust_id = document.getElementById("cust_id").value;
     var attackAddressInput = document.getElementById("attackAddressInput").value;
	 if(cust_id!=null&&cust_id!=''&&attackAddressInput!=null&&attackAddressInput!=''){
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/ImHolidayAction.do?cmd=importData&cust_id='+encodeURI(cust_id)+'&attackAddressInput='+encodeURI(attackAddressInput),
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	           error: function(){
	                  alert('导入失败!');
	                  jQuery("#curyear").val(null);
	                  return;
	               },
	           success: function(data){
		                if(data!=''){
		                   alert(data);
		                   return;
		               }
	               }
	           });
           }
}

function rtnFunc(arg){
 		var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#cust_id").val(arg[0]);       
	    return false;
}
   
</script>
</head>
<body>
<form name="formImp" method="post"
	action="<%=request.getContextPath()%>/ImHolidayAction.do?cmd=importData"
	onsubmit="return insert_submit();">
<div id="right">
<div class="box_xinzeng" style="height: 260px">
<table width="90%" border="0" align="center" cellpadding="0"
	cellspacing="1" bgcolor="#c5dbe2">
	<tr>
		<td class="td_1" style="width: 40%;">选择客户</td>
		<td class="td_2" style="width: 60%;">
			<input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
            <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false"  id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
		</td>
	</tr>
	<tr>
		<td class="td_1">请选择数据文件</td>
		<td class="td_2"><input type="text" id="attachNameInput"
			class="text_field_reference_readonly" id="attachNameInput"
			name="attachNameInput" inputName="附件地址" value=""
			hiddenInputId="attach_name" /> <img class="refButtonClass"
			src="<%=request.getContextPath()%>/images/icon/reference.gif"
			onClick="javascript:UploadFileWindow();" /> <input type="hidden"
			id="attackAddressInput" name="attach_address" value=""></td>
	</tr>	 
 </table>
<div class="xz_button">
<input class="icon_2" type="button" value="下载模板" onClick="toDownLoad_onclick();">
<input class="icon_2" type="button" value="导入" onClick="toImport_onclick();">
</div>
</form>
</fmt:bundle>
</body>
</html>

