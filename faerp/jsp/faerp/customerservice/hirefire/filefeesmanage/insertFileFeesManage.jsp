<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.hirefire.filefeesmanage.vo.FileFeesManageVo" %>
<%@ page import="rayoo.customerservice.hirefire.filefeesmanage.util.IFileFeesManageConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	FileFeesManageVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IFileFeesManageConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (FileFeesManageVo)request.getAttribute(IFileFeesManageConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		var emp_name = $id("emp_name").value;
		var money = $id("money").value;
		var start_date = $id("start_date").value;
		var end_date = $id("end_date").value;
		var payment_place = $id("payment_place").value;
		var cust_name = $id("cust_id").value;
		var reg=/^[0-9]+\.{0,1}[0-9]{0,2}$/;     
		if(emp_name==null || emp_name == ""){
			alert("请选择员工信息！");
			return;
		}
		if(cust_name==null || cust_name == ""){
			alert("请选择客户信息！");
			return;
		}
		if(money==null||money==""||money=="0"){
            alert("缴费金额不能为空或为0！");
            return;
        }else{
            if(!reg.test(money)){
                alert("缴费金额格式不正确！");
                return;
            }
        }
		if(start_date==null||start_date==""){
			alert("请选择缴费开始日期！");
			return;
		}		
		if(end_date==null||end_date==""){
			alert("请选择缴费结束日期！");
			return;
		}
		if(end_date!=null&&end_date.trim().length!=0){
           if(start_date!=null){
		       var beginTime = start_date.trim();
		       var endTime = end_date.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("缴费结束日期小于缴费开始日期！");
	               return;
	           }
           }
       }
		if(payment_place==null||payment_place==""){
			alert("请输入缴纳地点！");
			return;
		}
		var param=jQuery("#formId").serialize();
	    var url="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=insert&"+param;
	    jQuery.post(url,function(data){
     		if(data!=""){
	        	alert("保存成功！");
	        	window.close();
	        }else{
           		alert("保存失败，请修改信息！");
	     	}
	    })
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var emp_name = $id("emp_name").value;
		if(emp_name==null){
		  emp_name=$id("emp_name_hidden").value;
		}
		var cust_name = $id("cust_id").value;
		if(cust_name==null){
		cust_name=$id("cust_id_hidden").value;
		}
		var money = $id("money").value;
		var start_date = $id("start_date").value;
		var end_date = $id("end_date").value;
		var payment_place = $id("payment_place").value;
		var reg=/^[0-9]+\.{0,1}[0-9]{0,2}$/;     
		if(emp_name==null || emp_name == ""){
			alert("请选择员工信息！");
			return;
		}
		if(cust_name==null || cust_name == ""){
			alert("请选择客户信息！");
			return;
		}
		if(money==null||money==""||money=="0"){
            alert("缴费金额不能为空或为0！");
            return;
        }else{
            if(!reg.test(money)){
                alert("缴费金额格式不正确！");
                return;
            }
        }
		if(start_date==null||start_date==""){
			alert("请选择缴费开始日期！");
			return;
		}		
		if(end_date==null||end_date==""){
			alert("请选择缴费结束日期！");
			return;
		}
		if(end_date!=null&&end_date.trim().length!=0){
           if(start_date!=null){
		       var beginTime = start_date.trim();
		       var endTime = end_date.trim();
	           var beginTimes=beginTime.substring(0,10).split('-');
	           var endTimes=endTime.substring(0,10).split('-');
	           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
	           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
	           if(beginTime>endTime){
	               alert("缴费结束日期小于缴费开始日期！");
	               return;
	           }
           }
       }
		if(payment_place==null||payment_place==""){
			alert("请输入缴纳地点！");
			return;
		}
		var param=jQuery("#formId").serialize();
	    var url="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=update&"+param;
	    jQuery.post(url,function(data){
     		if(data!=""&&data!="0"){
	        	alert("修改成功！");
	        	window.close();
	        }else{
           		alert("修改失败，请核对信息重新修改！");
	     	}
	    })
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function toFindEmployee(obj){
        $id("emp_code").value=obj[0];
        $id("emp_name").value=obj[1];
        $id("emp_name").displayValue=obj[1];
        $id("id_card").value=obj[2];
        $id("emp_id").value=obj[3];
        return false;
    }
    
    function rtnFuncCustomer(obj){
        var lookup = $id("cust_id");
        lookup.value = obj[0];
        lookup.displayValue = obj[2];
        return false;
    }
</script>
</head>
<body>
<form name="form" method="post" id="formId">
<input type="hidden" id="emp_id" name="emp_id">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	<tr>
		<td class="td_1"><span style="color: red;">*</span>员工姓名</td>
		<td class="td_2">
		<%if(isModify){%>
			<w:lookup onReturnFunc="toFindEmployee" id="emp_name" name="emp_name" displayValue="${bean.emp_name }" value="${bean.emp_id }"   lookupUrl="/FileFeesManageAction.do?cmd=getAllEmployeeByCondition" dialogTitle="选择员工" readonly="true" height="434" width="550" style="width:188px"/>
		<%}else{ %>
			<w:lookup onReturnFunc="toFindEmployee" id="emp_name" name="emp_name" lookupUrl="/FileFeesManageAction.do?cmd=getAllEmployeeByCondition" dialogTitle="选择员工" readonly="true" height="434" width="550" style="width:188px"/>
		<%} %>
		</td>
		<td class="td_1">唯一号</td>
		<td class="td_2">
			<input type="text" class="text_field" name="emp_code" id="emp_code" inputName="唯一号" value="" maxLength="25" readonly="readonly" />
		</td>
	</tr>
	<tr>
		<td class="td_1">证件号码</td>
		<td class="td_2">
			<input type="text" class="text_field" name="id_card" id="id_card" inputName="证件号码" value="" maxLength="64" readonly="readonly" />
		</td>
		<td class="td_1"><span style="color: red;">*</span>客户名称</td>
		<td class="td_2">
		<%if(isModify){%>
			<w:lookup id="cust_id" name="cust_id" displayValue="${bean.cust_name}"  value="${bean.cust_id }"  lookupUrl="/CustomersimpleAction.do?cmd=queryCustomerData" dialogTitle="选择客户" height="500" width="810" readonly="true" onReturnFunc="rtnFuncCustomer" style="width:188px;" />
		<%}else{ %>
			<w:lookup id="cust_id" name="cust_id" lookupUrl="/CustomersimpleAction.do?cmd=queryCustomerData" dialogTitle="选择客户" height="500" width="810" readonly="true" onReturnFunc="rtnFuncCustomer" style="width:188px;" />
		<%} %>
		</td>
	</tr>
	<tr>
		<td class="td_1"><span style="color: red;">*</span>缴费开始日期</td>
		<td class="td_2">
			<w:date format="yyyy-MM-dd" name="start_date" id="start_date" property="bean/start_date" width="189px" />
		</td>
		<td class="td_1"><span style="color: red;">*</span>缴费结束日期</td>
		<td class="td_2">
			<w:date format="yyyy-MM-dd" name="end_date" id="end_date" property="bean/end_date" width="189px" />
		</td>
	</tr>
	<tr>
		<td class="td_1"><span style="color: red;">*</span>缴费金额</td>
		<td class="td_2">
			<input type="text" class="text_field" name="money" id="money" inputName="缴费金额" maxLength="21" integerDigits="18" decimalDigits="2" />
		</td>
		<td class="td_1"><span style="color: red;">*</span>缴纳地点</td>
		<td class="td_2">
			<input type="text" class="text_field" name="payment_place" id="payment_place" inputName="缴纳地点" maxLength="1000" />
		</td>
	</tr>
	<tr>
		<td class="td_1">备注</td>
		<td colspan="3" class="td_2">
			<textarea class="textarea_limit_words" cols="60" rows="5" name="remark" id="remark" inputName="备注" maxLength="1000" ></textarea>
		</td>
	</tr>
</table>
</div>
<div class="mx_button" align="center">
	<input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
	<input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
</div>
</div>
</div> 
<input type="hidden" name="id">
<input type="hidden" name="emp_post_id">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
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
