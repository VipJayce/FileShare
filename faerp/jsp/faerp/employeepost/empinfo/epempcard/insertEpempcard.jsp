<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empinfo.epempcard.vo.EpempcardVo" %>
<%@ page import="rayoo.employeepost.empinfo.epempcard.util.IEpempcardConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<h:script src="/js/common/backspace_forbid.js"/>
<%  //判断是否为修改页面
	EpempcardVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	String companyID = "";
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEpempcardConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EpempcardVo)request.getAttribute(IEpempcardConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
		companyID = request.getAttribute("companyID")==null?"":request.getAttribute("companyID").toString();
	}
	if(companyID==null || companyID.equals("")) {
	    companyID = request.getParameter("companyID");
	}
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.epempcard.epempcard_resource" prefix="rayoo.employeepost.empinfo.epempcard.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	   var id = document.form.emp_id.value;
	   var emp_name = document.form.emp_name.value;
	   var bank_name = document.form.bank_name.value;
	   var account_num = document.form.account_num.value;
	   var account_name = document.form.account_name.value;
	   var province_name = document.form.province_name.value;
	   var city_area_name = document.form.city_area_name.value;
	   var bank_type_bd = document.form.bank_type_bd.value;

	   if(emp_name==""||emp_name==null){
	       alert("<fmt:message key="emp_name_not_null"/>");
           document.form.emp_name.focus();
           return;
	   }
	   if(bank_name==""||bank_name==null){
           alert("<fmt:message key="bank_name_not_null"/>");
           document.form.bank_name.focus();
           return;
        }
	   if(account_num==""||account_num==null){
           alert("<fmt:message key="account_not_null"/>");
           document.form.account_num.focus();
           return;
        }else{
            if(/^\d+$/.test(account_num)&&account_num.length>9&&account_num.length<21){
				// 工行账号必须为19位  duhuiyang 20140410 添加
            	if(bank_type_bd!=null && bank_type_bd=="1"){
            		if(account_num.length!=19 && account_num.length!=16&& account_num.length!=15){
            			alert("工行账号必须为15位，16位,19位！");
            			document.form.account_num.focus();
            			return;
            		}
            	}
            	
            }else{
                alert("<fmt:message key="account_must_10_and_20"/>");
                document.form.account_num.focus();
                return;
            }
        }
	   if(account_name==""||account_name==null){
           alert("<fmt:message key="account_name_not_null"/>");
           document.form.account_name.focus();
           return;
        }
       if(bank_type_bd!=null && bank_type_bd!="1"){
	   if(province_name==""||province_name==null){
           alert("<fmt:message key="province_name_not_null"/>");
           document.form.province_name.focus();
           return;
        }else{
            if((province_name.length>=3)&&(endWith(province_name, "省") || endWith(province_name,"市") || endWith(province_name, "自治区"))){
                
            }else{
                alert("<fmt:message key="province_name_length_3"/>");
                document.form.province_name.focus();
                return;
            }
        }
	   if(city_area_name==""||city_area_name==null){
           alert("<fmt:message key="city_area_name_not_null"/>");
           document.form.city_area_name.focus();
           return;
        }else{
            if((city_area_name.length>=3)&&(endWith(city_area_name, "市") || endWith(city_area_name, "区") || endWith(city_area_name, "自治州"))){
                
            }else{
                alert("<fmt:message key="city_area_name_length_3"/>");
                document.form.city_area_name.focus();
                return;
            }
        }
        }
	   if(bank_type_bd==""||bank_type_bd==null){
           alert("<fmt:message key="bank_type_not_null"/>");
           document.form.bank_type_bd.focus();
           return;
        }
        form.disabled="disabled";
	   if(id!=null&&id!=""){
	       var param = jQuery("#datacell_formid").serialize();
           var url="<%=request.getContextPath()%>/EpempcardAction.do?cmd=insert&id="+id+"&accnum="+account_num+"&"+param;
	       jQuery.post(url,function(data){
	             if(data != ""){
	                 alert(data);
	                 form.disabled="";
	             }else{
	                 alert("<fmt:message key="operation_succese"/>"); 
	                 window['returnValue'] = [''];
                     window.close(); //关闭
                     window.opener.refesh();
	             }
	       });
	   }
	}

  	function update_onClick(id){  //保存修改后的单条数据
       var id = document.form.emp_id.value;
       var emp_name = document.form.emp_name.value;
       var bank_name = document.form.bank_name.value;
       var account_num = document.form.account_num.value;
       var account_name = document.form.account_name.value;
       var province_name = document.form.province_name.value;
       var city_area_name = document.form.city_area_name.value;
       var bank_type_bd = document.form.bank_type_bd.value;
       if(emp_name==""||emp_name==null){
           alert("<fmt:message key="emp_name_not_null"/>");
           document.form.emp_name.focus();
           return;
       }
       if(bank_name==""||bank_name==null){
           alert("<fmt:message key="bank_name_not_null"/>");
           document.form.bank_name.focus();
           return;
        }
       if(account_num==""||account_num==null){
           alert("<fmt:message key="account_not_null"/>");
           document.form.account_num.focus();
           return;
        }else{
            if(/^\d+$/.test(account_num)&&account_num.length>9&&account_num.length<21){
            	// 工行账号必须为19位  duhuiyang 20140410 添加
            	if(bank_type_bd!=null && bank_type_bd=="1"){
            		if(account_num.length!=19 && account_num.length!=16&& account_num.length!=15){
            			alert("工行账号必须为15位，16位,19位！");
            			document.form.account_num.focus();
            			return;
            		}
            	}
            	
            }else{
                alert("<fmt:message key="account_must_10_and_20"/>");
                document.form.account_num.focus();
                return;
            }
        }
       if(account_name==""||account_name==null){
           alert("<fmt:message key="account_name_not_null"/>");
           document.form.account_name.focus();
           return;
        }
        if(bank_type_bd!=null && bank_type_bd!="1"){
       if(province_name==""||province_name==null){
           alert("<fmt:message key="province_name_not_null"/>");
           document.form.province_name.focus();
           return;
        }else{
            if((province_name.length>=3)&&(endWith(province_name, "省") || endWith(province_name, "市") || endWith(province_name, '自治区'))){
            }else{
                alert("<fmt:message key="province_name_length_3"/>");
                document.form.province_name.focus();
                return;
            }
        }
       if(city_area_name==""||city_area_name==null){
           alert("<fmt:message key="city_area_name_not_null"/>");
           document.form.city_area_name.focus();
           return;
        }else{
            if((city_area_name.length>=3)&&(endWith(city_area_name, "市") || endWith(city_area_name, "区") || endWith(city_area_name, "自治州"))){
                
            }else{
                alert("<fmt:message key="city_area_name_length_3"/>");
                document.form.city_area_name.focus();
                return;
            }
        }
        }
       if(bank_type_bd==""||bank_type_bd==null){
           alert("<fmt:message key="bank_type_not_null"/>");
           document.form.bank_type_bd.focus();
           return;
        }
    	 form.disabled="disabled";
		if(id!=null&&id!=""){
		  var param = jQuery("#datacell_formid").serialize();
           var url="<%=request.getContextPath()%>/EpempcardAction.do?cmd=update&id="+id+"&accnum="+account_num+"&"+param;
           jQuery.post(url,function(data){
                 if(data != ""){
                    alert(data);
	                form.disabled="";
                 }else{
                    alert("<fmt:message key="update_succese"/>");
                    window['returnValue'] = [''];
                    window.close(); //关闭
                    window.opener.refesh();
                 }
           });
       }
	}

    function endWith(src,target) {
        var reg=new RegExp(target+"$");
        return reg.test(src);
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function rtnFuncEmployee(arg){
        var lookup = $id("emp_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        document.form.emp_id.value=arg[0];
        if(arg[2] == null || arg[2] == "" || arg[2] == "null"){
            document.form.emp_code.value="";
        }else{
            document.form.emp_code.value=arg[2];
        }
        if(arg[3] == null || arg[3] == "" || arg[3] == "null"){
            document.form.id_card.value="";
        }else{
            document.form.id_card.value=arg[3];
        }
        if(arg[4] == null || arg[4] == "" || arg[4] == "null"){
            document.form.cust_name.value="";
        }else{
            document.form.cust_name.value=arg[4];
        }
        if(arg[5] == null || arg[5] == "" || arg[5] == "null"){
            document.form.cust_code.value="";
        }else{
            document.form.cust_code.value=arg[5];
        }
        if(arg[1] == null || arg[1] == "" || arg[1] == "null"){
            document.form.account_name.value="";
        }else{
            document.form.account_name.value=arg[1];
        }
        return false;
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="version" id="version">
<div id="right">
 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
 <%if(!isModify){ %>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="emp_name"/></td>
			<td class="td_2 ">
			    <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="emp_name" name= "emp_name" lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" messagekey="choose_emp" height="450" width="800"  style="width:195px"/>
			</td>
			<td class="td_1" ><fmt:message key="emp_code"/></td>
			<td class="td_2 "><input type="text" class="text_field_reference_readonly" id="emp_code" name="emp_code" inputName="员工唯一号" value="" maxLength="19" readonly="readonly" style="width:200px"/>            </td>
		</tr>
		<tr>
		  <td class="td_1" ><fmt:message key="id_card"/></td>
		  <td class="td_2 "><input type="text" class="text_field_reference_readonly" id="id_card" name="id_card" inputName="身份证" value="" maxLength="20" readonly="readonly" style="width:200px"/>          </td>
			<td class="td_1" ><fmt:message key="cust_name"/></td>
			<td class="td_2 "><input type="text" class="text_field_reference_readonly" id="cust_name" name="cust_name" inputName="客户名称" value="" maxLength="19" readonly="readonly" style="width:200px" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="cust_code"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field_reference_readonly" id="cust_code" name="cust_code" inputName="客户编号" value="" maxLength="19" readonly="readonly"  style="width:200px"/>			</td>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="bank_name"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="bank_name" inputName="开户行名称" value="" maxLength="50" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="account"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="account_num" inputName="账号" value="" maxlength="20"/>			</td>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="account_name"/></td>
			<td class="td_2 "><input type="text" class="text_field" id="account_name" name="account_name" inputName="账户名" value="" maxLength="50" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="province_name"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="province_name" inputName="账号省名" value="" maxLength="64"/>			</td>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="city_area_name"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="city_area_name" inputName="账号市区名" value="" maxLength="64"/>            </td>
		</tr>
		<tr>
		  <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="bank_type"/></td>
		  <td class="td_2" >
		  <%if("1099100700000000005".equals(companyID)){ %>
		  <d:select name="bank_type_bd" id="bank_type_bd" property="bean/bank_type_bd" dictTypeId="BANK_TYPE_BD" filterOp="in" filterStr="0,1,2" nullLabel="--请选择--" style="width: 205px" /> 
		  <%}else{ %>
		  <d:select name="bank_type_bd" id="bank_type_bd" property="bean/bank_type_bd" dictTypeId="BANK_TYPE_BD" nullLabel="--请选择--" style="width: 205px" />
		  <%} %>
		  </td>
			<td class="td_1" ><fmt:message key="city_code"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="city_code" inputName="城市编码" value="" maxLength="25" />            </td>
		</tr>
</table>
<%}else{ %>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="emp_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" id="emp_name" name="emp_name" inputName="员工姓名" value="" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="emp_code"/></td>
            <td class="td_2 "><input type="text" class="text_field_reference_readonly" id="emp_code" name="emp_code" inputName="员工唯一号" value="" readonly="readonly" style="width:200px"/>            </td>
        </tr>
        <tr>
          <td class="td_1" ><fmt:message key="id_card"/></td>
          <td class="td_2 "><input type="text" class="text_field_reference_readonly" id="id_card" name="id_card" inputName="身份证" value="" readonly="readonly" style="width:200px"/>          </td>
            <td class="td_1" ><fmt:message key="cust_name"/></td>
            <td class="td_2 "><input type="text" class="text_field_reference_readonly" id="cust_name" name="cust_name" inputName="客户名称" value="" readonly="readonly" style="width:200px"/>            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="cust_code"/></td>
            <td class="td_2 "><input type="text" class="text_field_reference_readonly" id="cust_code" name="cust_code" inputName="客户编号" value="" readonly="readonly" style="width:200px"/>          </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="bank_name"/></td>
            <td class="td_2 "><input type="text" class="text_field" name="bank_name" inputName="开户行名称" value="" maxLength="50" />            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="account"/></td>
            <td class="td_2 "><input type="text" class="text_field" name="account_num" inputName="账号" value="" maxLength="20" />          </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="account_name"/></td>
            <td class="td_2 "><input type="text" class="text_field" id="account_name" name="account_name" inputName="账户名" value="" maxLength="50" />            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="province_name"/></td>
            <td class="td_2 "><input type="text" class="text_field" name="province_name" inputName="账号省名" value="" maxLength="20" />          </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="city_area_name"/></td>
            <td class="td_2 "><input type="text" class="text_field" name="city_area_name" inputName="账号市区名" value="" maxLength="20" />            </td>
        </tr>
        <tr>
          <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="bank_type"/></td>
          <td class="td_2" >
          <%if("1099100700000000005".equals(companyID)){ %>
          <d:select name="bank_type_bd" id="bank_type_bd" property="bean/bank_type_bd" dictTypeId="BANK_TYPE_BD" filterOp="in" filterStr="0,1,2" nullLabel="--请选择--" style="width: 205px" /> 
          <%}else{ %>
          <d:select name="bank_type_bd" id="bank_type_bd" property="bean/bank_type_bd" dictTypeId="BANK_TYPE_BD" nullLabel="--请选择--" style="width: 205px" />
          <%} %> 
          </td>
            <td class="td_1" ><fmt:message key="city_code"/></td>
            <td class="td_2 "><input type="text" class="text_field" name="city_code" inputName="城市编码" value="" maxLength="25" />            </td>
        </tr>
</table>
<%} %>
 
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="close"/>'  onClick="javascript:cancel_onClick()"/>
      </div>
</div>         
            
<input type="hidden" id="emp_id" name="emp_id" value="">
 <%if(isModify){ %>
<input type="hidden" id="cardId" name="cardId" value="<%=resultVo.getId() %>">
<%} %>
<input type="hidden" name = "id" value="">
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
