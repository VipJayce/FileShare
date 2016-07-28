
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.pbcustomerservice.vo.PbcustomerserviceVo"%>
<%@ page
	import="rayoo.sales.pbcustomerservice.util.IPbcustomerserviceConstants"%>
<%@ page import="gap.authority.helper.OrgHelper"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<link href="../../style/common.css" rel="stylesheet" type="text/css" />
	<link href="../../style/index.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
tr.odd {
	background: #fff;
}

tr.even {
	background: #f9fcfd;
}

.box tr:hover,tr.hover {
	background: #c4e7f8;
}

.box tr:selected,tr.selected {
	background-color: #eef8ff;
	border-bottom-color: #daf1ff;
	border-right-color: #daf1ff;
}

.fex_row {
	LEFT: expression(document . getElementById('values_div') . scrollLeft );
	POSITION: relative;
}
</style>
	<script language="JavaScript" src="../../scripts/common.js"></script>
	<script language="javascript">
    function sendSubmit(){
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do";
        form.cmd.value = "changeCustomer";
        form.submit();
    }
    
     function changeSave(){
     	var obj = document.getElementById("newUser");
     	var ids = findSelections("checkbox_template","id");
     	var effTime = document.getElementById("effective_date");
     	
     	if(obj.value == ""){
     		alert("请选择新业务员！");
     		return;
     	}
     	if(effTime == null){
     		alert("生效时间必填！");
     		return;
     	}
    	if(ids == null || ids == "" || ids == undefined){
    		alert("选择具体的合同！");
    		return;
    	}
    	var userName  = obj.options[obj.options.selectedIndex].text;
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?ids=" + ids + "&userName=" + userName;
        form.cmd.value = "changeSave";
        form.submit();
    }
    
     function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    
    function changeAuLevel(slt1){
    	//alert(document.form.auType.options.length);
    	var sltAuType = document.getElementById("role_type_bd");
    	if(slt1.value == 1){
    			for(var i=sltAuType.length;i>0;i--){
    				sltAuType.remove(i-1);
    			}
    			var opt0=new Option('请选择','');
    		    var opt =new Option('销售','0');
    		    var opt1=new Option('派单客服','1');
    		    var opt2=new Option('接单客服','2');
    		    var opt3=new Option('社保专管员','3');
    		    var opt4=new Option('公积金专管员','4');
    		    var opt5=new Option('员工关系专员','5');
    		    var opt6=new Option('劳动用工专员','6');
    		    document.form.role_type_bd.options.add(opt0);
                document.form.role_type_bd.options.add(opt);
                document.form.role_type_bd.options.add(opt1);
                document.form.role_type_bd.options.add(opt2);
                document.form.role_type_bd.options.add(opt3);
                document.form.role_type_bd.options.add(opt4);
                document.form.role_type_bd.options.add(opt5);
                document.form.role_type_bd.options.add(opt6);
    	}else if(slt1.value == 3){
    			for(var i=sltAuType.length;i>0;i--){
    				sltAuType.remove(i-1);
    			}
    			var opt=new Option('请选择','');
    		    var opt2=new Option('接单客服','2');
    		    var opt3=new Option('社保专管员','3');
    		    var opt4=new Option('公积金专管员','4');
    		    var opt5=new Option('员工关系专员','5');
    		    var opt6=new Option('劳动用工专员','6');
    		    sltAuType.options.add(opt);
                sltAuType.options.add(opt2);
                sltAuType.options.add(opt3);
                sltAuType.options.add(opt4);
                sltAuType.options.add(opt5);
                sltAuType.options.add(opt6);
    	}else{
    			for(var i=sltAuType.length;i>0;i--){
    				sltAuType.remove(i-1);
    			}
    			var opt=new Option('请选择','');
    			var opt1=new Option('派单客服','1');
    		    var opt2=new Option('接单客服','2');
    		    var opt3=new Option('社保专管员','3');
    		    var opt4=new Option('公积金专管员','4');
    		    var opt5=new Option('员工关系专员','5');
    		    var opt6=new Option('劳动用工专员','6');
    		    sltAuType.options.add(opt);
               	sltAuType.options.add(opt1);
                sltAuType.options.add(opt2);
                sltAuType.options.add(opt3);
                sltAuType.options.add(opt4);
                sltAuType.options.add(opt5);
                sltAuType.options.add(opt6);
    	}
    }
    
    function changeAuType(){
    	//alert("123123123");
		if(document.getElementById("auLevel").value == ""){
    	 	alert("请先选择要替换的权限级别！");
    		document.getElementById("role_type_bd").value = "";
    		return;
    	}
    	initUserId();
    }
    
    function initUserId(){
    	var emps ;
    	var userId = document.getElementById("user_id");
    	var newUser = document.getElementById("newUser");
    	var type = document.getElementById("role_type_bd").value;
    	//删除人员下拉列表中所有项
    	for(var i=userId.length;i>0;i--){
    				userId.remove(i-1);
    	}
    	//删除人员下拉列表中所有项
    	for(var i=newUser.length;i>0;i--){
    				newUser.remove(i-1);
    	}
   		jQuery.getJSON("<venus:base/>/PbcustomerserviceAction.do?cmd=getEmp",{"type":type},function(json){
			emps = json.returnString.split(",");
			if(emps.length > 0){
				for(var i=0;i<emps.length;i++){
	        		var emp = emps[i].split("$");
	        		var opt=new Option(emp[1],emp[0]);
	            	userId.options.add(opt);
	            	var opt1=new Option(emp[1],emp[0]);
	            	newUser.options.add(opt1);
            	}
        	}   
        });
            return userId;
    	
    }
    
    function changeUserId(){
     	if(document.getElementById("auLevel").value == "" || document.getElementById("role_type_bd").value == ""){
     	 	alert("请先选择要替换的权限级别 或者 业务员类型！ ");
     		document.getElementById("user_id").value = "";
     		return;
     	}
    }
    
    function checkedEvent(cbx){
    	if(document.getElementById("auLevel").value == ""){
    		alert("请先选择要替换的权限级别!")
    		cbx.checked = "";
    		return;
    	}
    	var type = document.getElementById("auLevel").value;
    	var arr = document.getElementsByName("checkbox_template");
    	var id ;
    	if(!cbx.checked){
    		for(var i=0;i<arr.length;i++){
    			arr[i].checked ="";
    		}
    	}
    	if(cbx.checked){
    		var idArray = cbx.value.split("$");
    		switch(type){
    			case '1' : 
    				id = idArray[0];
    				for(var i=0;i<arr.length;i++){
    					if((arr[i].value.split("$"))[0] == id){
    						arr[i].checked ="checked";
    					}else{
    						arr[i].checked ="";
    					}
    				}
    			break;
    			case '2' : 
    				id = idArray[1];
    				for(var i=0;i<arr.length;i++){
    					if((arr[i].value.split("$"))[1] == id){
    					arr[i].checked ="checked";
    					}else{
    						arr[i].checked ="";
    					}
    				}
    			break;
    			case '3' : 
    				id = idArray[2];
    				for(var i=0;i<arr.length;i++){
    					if((arr[i].value.split("$"))[2] == id){
    					arr[i].checked ="checked";
    					}else{
    						arr[i].checked ="";
    					}
    				}
    			break;
    		}
    	}
    	
    }
    
</script>

	</head>
	<body>
	<form name="form"
		action="<%=request.getContextPath()%>/PbcustomerserviceAction.do"
		method="post"><input type="hidden" name="cmd"
		value="changeCustomer"> <input type="hidden" name="backFlag"
		id="backFlag" value="true">
	<div id="right">
	<div class="right_title_bg">
	<div class="right_title">分配客户</div>
	</div>
	<div class="ringht_s"><!--查询 -->
	<div class="search">

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="135" rowspan="2" style="padding-top: 0;">
			<div class="search_title">查询条件</div>
			</td>
			<td width="80">替换权限级别<font color="red">*</font></td>
			<td width="220"><select name="auLevel" class="sSelect"
				id="auLevel" onchange="changeAuLevel(this)">
				<option value="">请选择</option>
				<option value="1">替换客户级权限</option>
				<option value="2">替换合同级权限</option>
				<option value="3">替换委派单级权限</option>
			</select></td>
			<td width="70">业务员类型<font color="red">*</font></td>
			<td width="220"><select name="role_type_bd" class="sSelect"
				id="role_type_bd" onchange="changeAuType()">
				<option value="">请选择</option>
				<option value="0">销售</option>
				<option value="1">派单客服</option>
				<option value="2">接单客服</option>
				<option value="3">员工关系专员</option>
				<option value="4">劳动用工专员</option>
				<option value="5">社保专管员</option>
				<option value="6">公积金专管员</option>

			</select></td>
			<td width="70">业务员<font color="red">*</font></td>
			<td width="220"><select name="user_id" class="sSelect"
				id="user_id" onchange="changeUserId()">
			</select>
			 <r:comboSelect id="user_id" name="user_id" class="sSelect"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       property="writeBackFormValues/city_id"
                       nullText="请选择" />
			
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>客户名称</td>
			<td><select name="customer_id" class="sSelect" id="customer_id">
				<option value="">请选择</option>
			</select></td>
			<td>合同名称</td>
			<td><input name="constract_name" type="text" class="sText"
				id="constract_name" value="" /></td>
			<td>委派单名称</td>
			<td><input name="send_name" type="text" class="sText"
				id="send_name" value="" /></td>
			<td><input type="button" class="icon_1" value="查询"
				onclick="sendSubmit()" /></td>
		</tr>
	</table>
	</div>
	<!--查询 end--> <!--表格 -->
	<div class="box" id="values_div"
		style="overflow: scroll; overflow-x: scroll; overflow-y: scroll;">
	<table width="100%" cellspacing="0" class="datagrid1">
		<tr>
			<th class="fex_row"><input type='checkbox'
				onclick="checkAllList_onClick(this);" pdType='control'
				control='checkbox_template' /></th>
			<th class="fex_row">客户名称</th>
			<th>合同名称</th>
			<th>委派单名称</th>
			<th>业务员类型</th>
			<th>业务员</th>
			<th>生效日期</th>
			<th>失效日期</th>
			<th>服务外服公司</th>
		</tr>
		<logic:iterate name="beans" id="data" scope="request" indexId="indexs">
			<tr>
				<td class="fex_row"><input type="checkbox"
					name="checkbox_template"
					value="<bean:write name="data" property="customer_id"/>$<bean:write name="data" property="contract_id"/>$<bean:write name="data" property="send_id"/>"
					displayName="<bean:write name="data" property="id"/>"
					onclick="checkedEvent(this)" /></td>
				<td><bean:write name="data" property="customer_name" /> </td>

				<td><bean:write name="data" property="contract_name" /></td>

				<td><bean:write name="data" property="send_name" /> </td>

				<td><bean:write name="data" property="role_type_bd" /> </td>

				<td><bean:write name="data" property="user_name" /> </td>

				<td><bean:write name="data" property="effective_date" /> </td>
				<td><bean:write name="data" property="invalid_date" /> </td>
				<td><bean:write name="data" property="agent_name" /> </td>
				</td>

			</tr>
		</logic:iterate>
	</table>
	</div>
	<!--表格 end--> <!--翻页 -->
	<div class="page"><jsp:include page="/jsp/include/page.jsp" /></div>
	</div>
	<!--翻页 end--> <!--表格2-->
	<div class="box_2">
	<div class="xz_title">分配客服</div>
	<table width="100%" height="76" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">新业务员</td>
			<td class="td_2"><select name="newUser" class="sSelect_190"	id="newUser">
			</select></td>
			<td class="td_1">生效日期</td>
			<td class="td_2"><w:date name="effective_date" id="effective_date" readonly="true" allowNull="false"/></td>
		</tr>
		<tr>
			<td colspan="4" class="td_2" colspan=4>
			<center><span class="mx_button"> <input name="button1"
				type="button" class="icon_2" value="保存" onclick="changeSave()" /> </span></center>
			</td>

		</tr>
	</table>
	<br>
	<div class="mx_button"></div>
	</div>
	<!--表格2 end--></div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>
<script language="javascript">
<%  //表单回写
    if(request.getAttribute(IPbcustomerserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPbcustomerserviceConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
	
%>
	var retVal = "<%=request.getAttribute("user1")%>";
	
    function initUserId(){
    	var emps ;
    	var userId = document.getElementById("user_id");
    	var newUser = document.getElementById("newUser");
    	var type = document.getElementById("role_type_bd").value;
    	//删除人员下拉列表中所有项
    	for(var i=userId.length;i>0;i--){
    				userId.remove(i-1);
    	}
    	//删除人员下拉列表中所有项
    	for(var i=newUser.length;i>0;i--){
    				newUser.remove(i-1);
    	}
   		jQuery.getJSON("<venus:base/>/PbcustomerserviceAction.do?cmd=getEmp",{"type":type},function(json){
			emps = json.returnString.split(",");
			if(emps.length > 0){
				for(var i=0;i<emps.length;i++){
	        		var emp = emps[i].split("$");
	        		var opt=new Option(emp[1],emp[0]);
	            	userId.options.add(opt);
	            	var opt1=new Option(emp[1],emp[0]);
	            	newUser.options.add(opt1);
            	}
            	
            	for(var i=0;i<userId.options.length;i++){    
       				if(userId.options[i].value == retVal){
						userId.options[i].selected = true;    
    				}
  				}
        	}
        });
    }

	initUserId();
	
	
	
	//var objSel = document.getElementById("user_id");
	
	
	//document.getElementById("user_id") = "<%=request.getAttribute("user_id1")%>";
</script>
