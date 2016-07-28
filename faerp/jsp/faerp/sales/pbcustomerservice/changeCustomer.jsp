<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salse.pbcustomerservice.pbcustomerservice_resource" prefix="rayoo.salse.pbcustomerservice.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<script language="javascript">
    function changeQuery(){
    	var oldUser = $id("user_id").getValue();
     	var customer = $id("customer_id1").value;
     	if((oldUser == "" || oldUser==null) &&(customer == "" || customer==null ) ){     
     		alert("<fmt:message key="customer_not_null"/>");
     		return;
     	}
       	$id("celllist1").addParam("user_id",$id("user_id").getValue());
    	$id("celllist1").addParam("role_type_bd",$id("role_type_bd").value);
    	$id("celllist1").addParam("customer_id",$id("customer_id1").value);
    	$id("celllist1").addParam("constract_id",$id("constract_id").value);
    	$id("celllist1").addParam("send_id",$id("send_id").value);
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
    
    function setFail(){
        var ids = findSelections("checkbox_template","id");
        if(ids!=null&&ids!=""){
            showModalCenter('<%=request.getContextPath()%>/jsp/faerp/sales/pbcustomerservice/setFail.jsp?id='+ids,window,changeQuery,500,200,"设置失效日期");
        }else{
            alert("<fmt:message key="select_records"/>");
            return;
        }
    }
    
     function changeSave(){
     	var newUserId = $id("newUser").getValue();
     	var newUserName = $id("newUser").getText();
     	var user_id = $id("user_id").getValue();
     	var ids = findSelections("checkbox_template","id");
     	var effTime = $id("effTime").value;
     	var role_type_bd = $id("role_type_bd").value;
     	var modRole = '0';
     	if(role_type_bd == ""){
     		alert("<fmt:message key="choose_customer_type"/>");
     		return;
     	}
     	/*if(user_id == ""){
     		alert("请选择要被替换的业务员！");
     		return;
     	}*/
     	if(newUserId == ""){
     		alert("<fmt:message key="choose_new_customer"/>");
     		return;
     	}
     	if(effTime == null){
     		alert("<fmt:message key="efftime_not_null"/>");
     		return;
     	}
    	if(ids == null || ids == "" || ids == undefined){
    		alert("<fmt:message key="choose_contract"/>");
    		return;
    	}
    	var user_id = $id("user_id").getValue();
    	if(role_type_bd == '2'){
			if(confirm("<fmt:message key="modify_customer_service"/>")){
				if (ids.length >1){
					if(confirm("<fmt:message key="choose_recodes"/>")){
						modRole = '1';
					}
				}else{
					modRole = '1';
				}
			}
    	}
	    jQuery.getJSON("/FAERP/PbcustomerserviceAction.do?cmd=changeSave&effTime=" + effTime +"&modRole=" + modRole
	   				+ "&ids=" + ids +"&newUserId=" + newUserId +"&user_id=" + user_id +"&role_type_bd=" + role_type_bd,{"newUserName":newUserName},function(json){
			alert(json.returnString);
	        json = null;
		    $id("celllist1").addParam("user_id",$id("user_id").getValue());
	    	$id("celllist1").addParam("role_type_bd",$id("role_type_bd").value);
	    	$id("celllist1").addParam("customer_id",$id("customer_id1").value);
	    	$id("celllist1").addParam("constract_id",$id("constract_id").value);
	    	$id("celllist1").addParam("send_id",$id("send_id").value);
	        $id("celllist1").reload();
	    });
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
    			var opt0=new Option('<fmt:message key="please_choose"/>','');
    		    var opt =new Option('<fmt:message key="customer_service"/>','0');
    		    var opt1=new Option('<fmt:message key="send_customer_service"/>','2');
    		    var opt2=new Option('<fmt:message key="receive_customer_service"/>','1');
    		    var opt5=new Option('<fmt:message key="employee_relations_person"/>','3');
    		    var opt6=new Option('<fmt:message key="labor_employment_person"/>','4');
    		    var opt3=new Option('<fmt:message key="social_security_person"/>','5');
    		    var opt4=new Option('<fmt:message key="public_security_person"/>','6');
    		    var opt8=new Option('<fmt:message key="project_manage"/>','7');
    		    var opt7=new Option('Share Center','8');
    		    document.form.role_type_bd.options.add(opt0);
                document.form.role_type_bd.options.add(opt);
                document.form.role_type_bd.options.add(opt1);
                document.form.role_type_bd.options.add(opt2);
                document.form.role_type_bd.options.add(opt3);
                document.form.role_type_bd.options.add(opt4);
                document.form.role_type_bd.options.add(opt5);
                document.form.role_type_bd.options.add(opt6);
                document.form.role_type_bd.options.add(opt7);
                document.form.role_type_bd.options.add(opt8);
    	}else if(slt1.value == 3){
    			for(var i=sltAuType.length;i>0;i--){
    				sltAuType.remove(i-1);
    			}
    			var opt=new Option('<fmt:message key="please_choose"/>','');
    		    var opt2=new Option('<fmt:message key="receive_customer_service"/>','1');
    		    var opt5=new Option('<fmt:message key="employee_relations_person"/>','3');
    		    var opt6=new Option('<fmt:message key="labor_employment_person"/>','4');
    		    var opt3=new Option('<fmt:message key="social_security_person"/>','5');
    		    var opt4=new Option('<fmt:message key="public_security_person"/>','6');
    		    var opt8=new Option('<fmt:message key="project_manage"/>','7');
    		    var opt7=new Option('Share Center','8');
    		    sltAuType.options.add(opt);
                sltAuType.options.add(opt2);
                sltAuType.options.add(opt3);
                sltAuType.options.add(opt4);
                sltAuType.options.add(opt5);
                sltAuType.options.add(opt6);
                sltAuType.options.add(opt7);
                sltAuType.options.add(opt8);
    	}else{
    			for(var i=sltAuType.length;i>0;i--){
    				sltAuType.remove(i-1);
    			}
    			var opt=new Option('<fmt:message key="please_choose"/>','');
    			var opt1=new Option('<fmt:message key="send_customer_service"/>','2');
    		    var opt2=new Option('<fmt:message key="receive_customer_service"/>','1');
    		    var opt5=new Option('<fmt:message key="employee_relations_person"/>','3');
    		    var opt6=new Option('<fmt:message key="labor_employment_person"/>','4');
    		    var opt3=new Option('<fmt:message key="social_security_person"/>','5');
    		    var opt4=new Option('<fmt:message key="public_security_person"/>','6');
    		    var opt8=new Option('<fmt:message key="project_manage"/>','7');
    		    var opt7=new Option('Share Center','8');
    		    sltAuType.options.add(opt);
               	sltAuType.options.add(opt1);
                sltAuType.options.add(opt2);
                sltAuType.options.add(opt3);
                sltAuType.options.add(opt4);
                sltAuType.options.add(opt5);
                sltAuType.options.add(opt6);
                sltAuType.options.add(opt7);
                sltAuType.options.add(opt8);
    	}
    }
    
    function changeAuType(){
    	//alert("123123123");
		if(document.getElementById("auLevel").value == ""){
    	 	alert("<fmt:message key="choose_role_type"/>");
    		document.getElementById("role_type_bd").value = "";
    		return;
    	}
    	var type = document.getElementById("role_type_bd").value;
		$id("user_id").addParam("type", type);
        $id("user_id").loadData();
        $id("user_id").refresh();
        $id("newUser").addParam("type", type);
        $id("newUser").loadData();
        $id("newUser").refresh();
    }
    
    function changeUserId(){
     	if(document.getElementById("auLevel").value == "" || document.getElementById("role_type_bd").value == ""){
     	 	alert("<fmt:message key="choose_role_type_customertype"/>");
     		//document.getElementById("user_id").value = "";
     		return;
     	}
    }
      //datacell1 checkbox begin   "customer_id"$"contract_id"$"send_id"
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input type='checkbox' onclick='changeCheck(" + rowNo + ",this);' name='checkbox1' id='checkbox_template' value='" + entity.getProperty("customer_id") + "$" + entity.getProperty("contract_id") + "$" + entity.getProperty("send_id") + "$" +entity.getProperty("id") + "' >";
       return returnStr;
    }
    function checkAllList(all){
    	if(all.checked){
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= true;
	            }
	        } 
	    }else{
	    	var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= false;
	            }
	        } 
	    }
    }
    
    function changeCheck(rowNo,box){
    	if(document.getElementById("auLevel").value == ""){
    		alert("<fmt:message key="choose_role_type"/>")
    		box.checked = "";
    		return;
    	}
    	var type = document.getElementById("auLevel").value;
    	var arr = document.getElementsByName("checkbox_template");
    	var id ;
    	if(!box.checked){
    		for(var i=0;i<arr.length;i++){
    			arr[i].checked ="";
    		}
    	}
    	if(box.checked){
    		var idArray = box.value.split("$");
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
    
  	// end
    
    function toFindContract(arg)
    {
    	var lookup = $id("constract_id");
    	
    	
    	lookup.value = arg[0];
    	lookup.displayValue = arg[1];
    	return false;
    	//document.form.contract_name.value=arg[3];
    }
    
     
	function rtnFuncCustomer(arg){
    	var lookup = $id("customer_id1");
    	
    	//alert(arg[0]);	id
    	//alert(arg[1]);	code
    	
    	lookup.value = arg[0];
    	lookup.displayValue = arg[2];
    	return false;
    }
    function toFindSend(arg){
    	var lookup = $id("send_id");
    	lookup.value = arg[1];
    	lookup.displayValue = arg[1];
    	return false;
    	//document.form.customer_name.value=obj[1];
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
	<div class="right_title"><fmt:message key="fenpen_customer"/></div>
	</div>
	<div class="ringht_s"><!--查询 -->
	<div class="search">

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="135" rowspan="2" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_conditions"/></div>
			</td>
			<td width="80"><fmt:message key="change_aulevel"/><font color="red">*</font></td>
			<td width="220"><select name="auLevel" class="sSelect"
				id="auLevel" onchange="changeAuLevel(this)">
				<option value=""><fmt:message key="please_choose"/></option>
				<option value="1"><fmt:message key="change_customer_aulevel"/></option>
				<option value="2"><fmt:message key="change_contract_aulevel"/></option>
				<option value="3"><fmt:message key="change_send_aulevel"/></option>
			</select></td>
			<td width="70"><fmt:message key="service_person_type"/><font color="red">*</font></td>
			<td width="220"><select name="role_type_bd" class="sSelect"
				id="role_type_bd" onchange="changeAuType()">
				<option value="">请选择</option>
				<option value="0">销售</option>
				<option value="2">派单客服</option>
				<option value="1">接单客服</option>
				<option value="3">员工关系专员</option>
				<option value="4">劳动用工专员</option>
				<option value="5">社保专管员</option>
				<option value="6">公积金专管员</option>
				<option value="7">项目经理</option>
				<option value="8">Share Center</option>
				<option value="9">报税专员</option>
			</select></td>
			<td width="70"><fmt:message key="tax_person"/><fmt:message key="salse_man"/><font color="red">*</font></td>
			<td width="220">
             <r:comboSelect id="user_id" name="user_id"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose">
            </r:comboSelect>
			
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><fmt:message key="customer_name"/><font color="red">*</font></td>
			<td>
			<div>
			<w:lookup name="customer_id1"  allowInput="false" onReturnFunc="rtnFuncCustomer" id="customer_id1" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" messagekey="choose_customer" height="440" width="600"  style="width:170px"/>
			</div>
		</td>
			</td>
			<td><fmt:message key="contract_name"/></td>
			<td>
			<w:lookup onReturnFunc="toFindContract" allowInput="false"
          		readonly="false" 
          		id="constract_id"
         		name="constract_id" 
          		lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"  
          		height="444" width="753" style="width:170px" messagekey="choose_contract_name"/>
          
			<td><fmt:message key="send_name"/></td>
			<td>
				<w:lookup onReturnFunc="toFindSend" 
	          		readonly="false" 
	          		id="send_id"
	         		name="send_id" 
	          		lookupUrl="/FAERP/jsp/faerp/common/sales/allSend.jsp"  
	          		messagekey="choose_send"
	          		height="444" width="753" style="width:170px"/>
			</td>
			<td><input type="button" class="icon_1" value="<fmt:message key="query"/>" onclick="changeQuery()" />&nbsp;&nbsp;<input type="button" class="icon_1" value="失效" onclick="setFail()" /></td>
		</tr>
	</table>
	</div>
	<!--查询 end--> <!--表格 -->
	<div id="values_div"
		style="overflow: scroll; overflow-x: scroll; overflow-y: scroll;">
		<r:datacell id="celllist1"
	queryAction="/FAERP/PbcustomerserviceAction.do?cmd=changeQuery"
	paramFormId="form" width="100%" height="350px"
	xpath="ChangeCustomerListVo" readonly="true"  pageSize="99999">
	<r:field allowModify="false" fieldName="id" sortAt="none"
		label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
		width="45px" onRefreshFunc="setCheckboxStatus">
	</r:field>
	<r:field fieldName="customer_name" messagekey="customer_name" width="180px">
		<h:text />
	</r:field>
	<r:field fieldName="customer_code" messagekey="customer_code" width="180px">
        <h:text />
    </r:field>
	<r:field fieldName="contract_name" messagekey="contract_name" width="200px">
		<h:text />
	</r:field>
	<r:field fieldName="send_name" messagekey="send_name" width="235px">
		<h:text />
	</r:field>
	<r:field fieldName="role_type_bd" messagekey="type" width="65px">
		<h:select name="list_apply_state" property="role_type_bd">
			<h:option value="0" label="销售"></h:option>
	       	<h:option value="1" label="接单客服"></h:option>
			<h:option value="2" label="派单客服"></h:option>
			<h:option value="3" label="员工关系专员"></h:option>
			<h:option value="4" label="用退工专员"></h:option>
			<h:option value="5" label="社保专员"></h:option>
			<h:option value="6" label="公积金专员"></h:option>
			<h:option value="7" label="项目经理"></h:option>
			<h:option value="8" label="Share Center"></h:option>
       </h:select>
	</r:field>
	<r:field fieldName="user_name" messagekey="salse_man" width="65px">
		<h:text />
	</r:field>
	<r:field fieldName="effective_date" messagekey="effective_date" width="115px">
		<w:date format="yyyy-MM-dd"/>
	</r:field>
	<r:field fieldName="invalid_date" messagekey="invalid_date" width="115px">
		<w:date format="yyyy-MM-dd"/>
	</r:field>
	<r:field fieldName="agent_name" messagekey="agent_name" width="115px">
		<h:text />
	</r:field>
	</r:datacell>
	</div>
	<!--翻页 end--> <!--表格2-->
	<div class="box_2">
	<div class="xz_title"><fmt:message key="fenpen_customer"/></div>
	<table width="100%" height="76" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><fmt:message key="new_salse_man"/></td>
			<td class="td_2">
			<r:comboSelect id="newUser" name="newUser"
               queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp"
                textField="name"
                valueField="partyid"
                xpath="Partyrelation"
                width="180" messagekey="please_choose">
            </r:comboSelect>
			</td>
			<td class="td_1"><fmt:message key="effective_date"/></td>
			<td class="td_2"><w:date name="effTime" id="effTime" readonly="true" format="yyyy-MM-dd" allowNull="false"/></td>
		</tr>
		<tr>
			<td colspan="4" class="td_2" colspan=4>
			<center><span class="mx_button"> <input name="button1"
				type="button" class="icon_2" value="<fmt:message key="save"/>" <au:authorityBtn code="allocate_save" type="1"/> onclick="changeSave()" /> <input type="reset" class="icon_1"  /></span></center>
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
