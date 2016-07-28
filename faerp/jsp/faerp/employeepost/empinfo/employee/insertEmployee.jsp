<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.List"%>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empinfo.employee.util.IEmployeeConstants" %>
<%  //判断是否为修改页面
	EmployeeVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEmployeeConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EmployeeVo)request.getAttribute(IEmployeeConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="emp_info_update_page"/></title>
<script language="javascript">
	
	function insert_onClick(){  //插入单条数据
	   if (!validCertificate()) {
	       return false;
	   }
        if(checkAllForms()) {
            form.action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=insert";
            form.submit();
	   }
	}

  	function update_onClick(){  //保存修改后的单条数据
  	     //验证居住证、积分 by liangyixiong 20150408
  	    if (!validCertificate()) {
            return false;
       }
    	var emp_code = jQuery("input[name='emp_code']").val();
        if(emp_code==null || emp_code==''){
            alert("<fmt:message key="please_check_in_emp_code"/>");
            return;
        }
		var emp_sex = jQuery("select[name='emp_sex']").val();
        if(emp_sex==null || emp_sex==''){
            alert("<fmt:message key="please_choose_emp_sex"/>");
            return;
        }
		var birth_date = $id("birth_date").getValue();
		if($id("birthShow").style.display=="inline"){
	        if(birth_date==null || birth_date==''){
	            alert("<fmt:message key="please_check_in_emp_birthday"/>");
	            return;
	        }
        }
        //联系地址
        //var address = document.getElementById("address").value;
        //if(address==null || address==''){
        //    alert('请输入联系地址！');
        //    return;
        //}
        //家财险地址
        //var insurence_address = document.getElementById("insurence_address").value;
        //if(insurence_address==null || insurence_address==''){
        //    alert('请输家财投保地址！');
        //    return;
        //}
        var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
                var datasettr = dataset1.get(i);
                if(datasettr.status!=3&&datasettr.status!=4){
	                if(datasettr.getProperty("sib_name")==null || datasettr.getProperty("sib_name")==''){
	                    alert("<fmt:message key="please_check_in_sib_name"/>");
	                    return;
	                }
	                if(datasettr.getProperty("sib_id_card_type_bd")!=null && datasettr.getProperty("sib_id_card_type_bd")!=''){
	                    if(datasettr.getProperty("sib_id_card_num")==null || datasettr.getProperty("sib_id_card_num")==''){
	                        alert("<fmt:message key="please_check_in_sib_id_card_num"/>");
	                        return;
	                    }
	                }
	                if(datasettr.getProperty("sib_sex_bd")==null || datasettr.getProperty("sib_sex_bd")==''){
	                    alert("<fmt:message key="please_check_in_sib_sex"/>");
	                    return;
	                }
	                if(datasettr.getProperty("sib_relation")!=null && datasettr.getProperty("sib_relation")!='' && datasettr.getProperty("sib_relation")=='2'){
		                if(datasettr.getProperty("sib_birthday")==null || datasettr.getProperty("sib_birthday")==''){
		                    alert("<fmt:message key="please_check_in_sib_birthday"/>");
		                    return;
		                }
	                }
                }
                datasettr.setProperty("status",datasettr.status);
       }
       if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
       }
        var default_emp_code = jQuery("input[name='default_emp_code']").val();
            var action = "<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=updateAll";
            var xmlSubmit = datacell1.dataset.toString();
            var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
             	var returnValue = myAjax.getValue("root/data/returnValue");
             	var returnValues = returnValue.split(',');
                 if( returnValues[0] == '1' ) {
                      alert("<fmt:message key="emp_info_save_succese"/>");
                      window.location.href="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryAll";
                  } 
                  else if( returnValues[0] == '2' ) {
                      alert(returnValues[1]);
                      jQuery("input[name='emp_code']").val(default_emp_code);
                      return false;
                  } 
                  else {
                      alert("<fmt:message key="emp_info_save_error"/>"); 
                  }
             }
             
		//if(checkAllForms()){
		    //form.action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=update";
	    	//form.submit();
    	//}
    	
    	
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryAll";
        form.submit();
    }
    
    function addEmpsibling() { 
        $id("datacell1").addRow();
    }
    
    function remove(){
       if(confirm("<fmt:message key="sure_delete_by_selected_sbi"/>")) {  //如果用户在确认对话框按"确定"
            $id("datacell1").deleteRow();
       }
       
    }
    
    function save(){
        $id("datacell1").submit();
    }
    
    function setCheckbox(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow1(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow1(value){
        
    }
    
     function setother(){
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
       
        var idcardtype = datasettr.getProperty("sib_id_card_type_bd");
        var idcard = datasettr.getProperty("sib_id_card_num");
        var empsex = datasettr.getProperty("sib_sex_bd");
        var birthdate = datasettr.getProperty("sib_birthday");
        
        if(idcardtype!=null && idcardtype=='1'){
            //判断是不是身份证
            
            
            
                var tmpSex='';
                if(idcard.length==15){
                    tmpSex=idcard.substr(14,1);
                }
                if(idcard.length==18){
                    tmpSex=idcard.substr(16,1);
                }
                if(tmpSex%2==1){
                    datasettr.setProperty("sib_sex_bd",'1');
                }else{
                    datasettr.setProperty("sib_sex_bd",'0');
                }
            
                var birth = '';
                if(idcard.length==15){
                    birth='19'+idcard.substr(6,2)+'-'+idcard.substr(8,2)+'-'+idcard.substr(10,2);
                }
                if(idcard.length==18){
                    birth=idcard.substr(6,4)+'-'+idcard.substr(10,2)+'-'+idcard.substr(12,2);
                }
                datasettr.setProperty("sib_birthday",birth);
            
        
        }
        
        return true;
    }
    
    function openfujia(type){
        if(type!=null && type==1){
            jQuery("#xianshi").hide();
            jQuery("#yincang").show();
            jQuery("#fujia").show();
        }else{
            jQuery("#xianshi").show();
            jQuery("#yincang").hide();
            jQuery("#fujia").hide();
        }
    }
    
    function checkForeigner(isForeigner){
        if(isForeigner.value=="1"){
            $id("birthShow").style.display="none";
        }else{
            $id("birthShow").style.display="inline";
        }
    }
    
    //验证居住证、积分 by liangyixiong 20150408
    function validCertificate() {
        var resident_addresss = jQuery("#resident_addresss").val();
        var shanghai_city_card = jQuery("#is_shanghai_city_card").val();
        var point = jQuery("#is_point").val();      
        if (shanghai_city_card == '1') {
            var card_valid_date =  jQuery("input[name='shanghai_city_card_valid_date']").val();
            if (card_valid_date == null || card_valid_date == '') {
                alert("请选择居住证有效期！");
                return false;
            }
        }
 
        if (point == '1') {
            var point_valid_date =  jQuery("input[name='point_valid_date']").val();
            if (point_valid_date == null || point_valid_date == '') {
                alert("请选择积分有效期有效期！");
                return false;
            }
        }
        return true;
    }
    
    function checkMobile(){ 
    var sMobile = document.datacell_formid.mobile.value ;
    if( null != sMobile && "" != sMobile){
	    if(!(/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(sMobile)) || sMobile.length != 11){ 
	        alert("不是完整的11位手机号"); 
	        document.datacell_formid.mobile.focus(); 
	        return false; 
	    } 
	}
} 
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco("<fmt:message key="emp_info_update_page"/>",'<%=request.getContextPath()%>/');
    else
        writeTableTopFesco("<fmt:message key="emp_info_add_page"/>",'<%=request.getContextPath()%>/');
</script>
<div style="float: right;"><fmt:message key="last_update_user"/>： <%=RmStringHelper.prt(resultVo.getLast_update_user_id())%>&nbsp;&nbsp;&nbsp;<fmt:message key="last_update_date"/>： <%=RmStringHelper.prt(resultVo.getLast_update_date(),10)%></div>
 <div class="ringht_s">
 
<div id="ccChild0" class="box_3">
<div class="xz_title"><fmt:message key="info"/></div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="8%" class="td_1" ><fmt:message key="emp_code1"/></td>
			<td width="18%" class="td_2 ">
				<input type="text" class="text_field" name="emp_code" inputName="唯一号" value="<%=RmStringHelper.prt(resultVo.getEmp_code()) %>" maxLength="19" />			</td>
			    <input type="hidden" name="default_emp_code" id="default_emp_code" value="<%=RmStringHelper.prt(resultVo.getEmp_code()) %>"/>
			   	<input type="hidden" name="default_emp_name" id="default_emp_name" value="<%=RmStringHelper.prt(resultVo.getEmp_name()) %>"/>
			    
                 <!-- yangyuting 2014-7-23 -->
               <!--<input type="hidden" name="phoenix_emp_id" id="phoenix_emp_id" value=" <%=RmStringHelper.prt(resultVo.getPhoenix_emp_id()) %>"/>-->
                <!--  -->
            
			<td width="9%" class="td_1" ><fmt:message key="employee_name"/></td>
			<td width="23%" class="td_2 "><input type="text" class="text_field" name="emp_name" inputName="员工姓名" value="<%=resultVo.getEmp_name() %>" maxLength="50" />            </td>
			<td width="20%" class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="emp_sex"/></td>
			<td width="22%" class="td_2 "><%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_sex", -1, "EMP_SEX", RmStringHelper.prt(resultVo.getEmp_sex()),"", false)%> </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_foreigner"/></td>
			<td class="td_2 ">
			<%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_foreigner", -1, "IS_FOREIGNER", RmStringHelper.prt(resultVo.getIs_foreigner()),"", false)%>
			<d:select name="is_foreigner" id="is_foreigner" property="bean/is_foreigner" dictTypeId="IS_FOREIGNER" nullLabel="--请选择--" style="width: 205px" onchange="checkForeigner(this)"/>
			</td>
			<td class="td_1" ><fmt:message key="country"/></td>
            <td class="td_2 ">
                <r:comboSelect id="country" name="country" queryAction="/FAERP/FaerpEmployeeAction.do?cmd=queryCountryData" 
                textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  messagekey="please_choose" value="${bean.country}"/>
            </td>
			<td class="td_1" ><fmt:message key="province_id"/></td>
			<td class="td_2 ">
			     <r:comboSelect id="city_idList_search" name="province_bd"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       property="bean/province_bd"
                       messagekey="please_choose" />
			     <!--<faerp:cityTag beanname="bean" attribute="province_bd" tagname="province_bd" />-->
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="nationality"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="nationality" inputName="民族" value="<%=RmStringHelper.prt(resultVo.getNationality()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="credentials_type"/></td>
			<td class="td_2 ">
			    <input name="id_card_type_bd" id="id_card_type_bd" type="hidden" value="<%=RmStringHelper.prt(resultVo.getId_card_type_bd())%>"/>
                <input name="id_card_type_name" type="text" class="sText" disabled="disabled" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",String.valueOf(resultVo.getId_card_type_bd()))%>"/>
			
			<td class="td_1" ><fmt:message key="id_card"/></td>
			<td class="td_2 ">
			     <input type="text" class="text_field" id="show_id_card" name="show_id_card" value="<%=RmStringHelper.prt(resultVo.getId_card()) %>" disabled="disabled" />
			     <input type="hidden" class="text_field" id="id_card" name="id_card" inputName="证件号码" value="<%=RmStringHelper.prt(resultVo.getId_card()) %>"/>
			
			</td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red" id="birthShow">*&nbsp;</span><fmt:message key="birthday"/></td>
			<td class="td_2">
			    <w:date format="yyyy-MM-dd" id="birth_date" name="birth_date" property="bean/birth_date" width="200px"/>
			</td>
			<td class="td_1" ><fmt:message key="pocicy"/></td>
			<td class="td_2 ">
			<%//=gap.rm.tools.helper.RmJspHelper.getSelectField("pocicy_bd", -1, "POCICY_BD", RmStringHelper.prt(resultVo.getPocicy_bd()),"", false)%>
			<d:select name="pocicy_bd" property="bean/pocicy_bd" dictTypeId="POCICY_BD" nullLabel="--请选择--" style="width: 205px"/></td>
			<td class="td_1" ><fmt:message key="education"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("education_bd", -1, "EDUCATION_BD", RmStringHelper.prt(resultVo.getEducation_bd()),"", false)%>
			<d:select name="education_bd" property="bean/education_bd" dictTypeId="EDUCATION_BD" nullLabel="--请选择--" style="width: 205px"/></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="contact_tel1"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="contact_tel1" inputName="联系电话" value="<%=RmStringHelper.prt(resultVo.getContact_tel1()).equals("null")?"":RmStringHelper.prt(resultVo.getContact_tel1()) %>" maxLength="25" />            </td>
			<td class="td_1" ><fmt:message key="tel"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" id = "mobile" name="mobile" inputName="手机" value="<%=RmStringHelper.prt(resultVo.getMobile()) %>" 
				         onkeyup="value=value.replace(/[^\d{11}]/g,'') " onblur="checkMobile();" maxLength="64" /></td>
			<td class="td_1" ><fmt:message key="email"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="email" inputName="电子邮件" value="<%=RmStringHelper.prt(resultVo.getEmail()) %>" maxLength="64" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="address1"/></td>
			<td class="td_2 "><input type="text" class="text_field" id="address" name="address" inputName="联系地址" value="<%=RmStringHelper.prt(resultVo.getAddress()) %>" maxLength="250" />            </td>
			<td class="td_1" ><fmt:message key="resident_code"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_code" inputName="户籍编号" value="<%=RmStringHelper.prt(resultVo.getResident_code()) %>" maxLength="64" />			</td>
			<td class="td_1" ><fmt:message key="postal_code"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="postal_code" inputName="邮政编码" value="<%=RmStringHelper.prt(resultVo.getPostal_code()) %>" maxLength="64" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="resident_type"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("resident_type_bd", -1, "RESIDENT_TYPE_BD", RmStringHelper.prt(resultVo.getResident_type_bd()),"", false)%>
			<d:select name="resident_type_bd" property="bean/resident_type_bd" dictTypeId="RESIDENT_TYPE_BD" nullLabel="--请选择--" style="width: 205px"/></td>
			<td class="td_1" ><fmt:message key="resident_address"/></td>
			<td class="td_2 ">
				<input id="resident_addresss" type="text" class="text_field" name="resident_addresss" inputName="户口所在地" value="<%=RmStringHelper.prt(resultVo.getResident_addresss()) %>" maxLength="250" />			</td>
			<td class="td_1" ><fmt:message key="insurence_address"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="insurence_address" name="insurence_address" inputName="家财投保地址" value="<%=RmStringHelper.prt(resultVo.getInsurence_address()) %>" maxLength="250" />          </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="marriage_status"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("marriage_status_bd", -1, "MARRIAGE_STATUS_BD", RmStringHelper.prt(resultVo.getMarriage_status_bd()),"", false)%>
			<d:select name="marriage_status_bd" property="bean/marriage_status_bd" dictTypeId="MARRIAGE_STATUS_BD" nullLabel="--请选择--" style="width: 205px"/></td>
		    <td class="td_1" ><fmt:message key="language_type"/></td>
            <td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("language_type_bd", -1, "LANGUAGE_TYPE_BD", RmStringHelper.prt(resultVo.getLanguage_type_bd()),"", false)%>
            <d:select name="language_type_bd" property="bean/language_type_bd" dictTypeId="LANGUAGE_TYPE_BD" nullLabel="--请选择--" style="width: 205px"/></td>
			<td class="td_1" ><fmt:message key="language_level"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("language_level_bd", -1, "LANGUAGE_LEVEL_BD", RmStringHelper.prt(resultVo.getLanguage_level_bd()),"", false)%>
			<d:select name="language_level_bd" property="bean/language_level_bd" dictTypeId="LANGUAGE_LEVEL_BD" nullLabel="--请选择--" style="width: 205px"/></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="archive_card"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="archive_card" inputName="存档卡" value="<%=RmStringHelper.prt(resultVo.getArchive_card()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="internal_code1"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" disabled="disabled" name="internal_code" inputName="客户方编号" value="<%=RmStringHelper.prt(resultVo.getInternal_code()) %>" maxLength="64" />			</td>
			<td class="td_1" ><fmt:message key="is_incompleteinfo"/></td>
			<td class="td_2" ><d:select dictTypeId="TrueOrFalse" id="is_incompleteinfo" name="is_incompleteinfo" property="bean/is_incompleteinfo" /></td>
        </tr>
        <!-- 20150407 新增-->
        <tr>
            <td class="td_1">是否有上海市居住证</td>
            <td class="td_2" ><d:select dictTypeId="TrueOrFalse" id="is_shanghai_city_card" name="is_shanghai_city_card" property="bean/is_shanghai_city_card" /></td>
            <td class="td_1">居住证有效期</td>
            <td class="td_2" ><w:date format="yyyy-MM-dd" id="shanghai_city_card_valid_date" name="shanghai_city_card_valid_date" property="bean/shanghai_city_card_valid_date" width="200px"/></td>
        </tr>

        <tr>
            <td class="td_1">是否有积分</td>
            <td class="td_2" ><d:select dictTypeId="TrueOrFalse" id="is_point" name="is_point" property="bean/is_point" /></td>
            <td class="td_1">积分有效期</td>
            <td class="td_2" ><w:date format="yyyy-MM-dd" id="point_valid_date" name="point_valid_date" property="bean/point_valid_date" width="200px"/></td>           
        </tr>
        
        <tr>     
            <td class="td_1"><fmt:message key="remark"/></td>
            <td class="td_2" >
                <textarea rows="4" name="emp_desc" style="width: 350px" inputName="备注" maxLength="100"><%=RmStringHelper.prt(resultVo.getEmp_desc()) %></textarea>
            </td>
            <% if((resultVo.getCompany_id())!=null&&(resultVo.getCompany_id()).equals(IEmployeeConstants.COMPANY_ID_HZ)) {%>
	            <td class="td_1" >户口性质</td>
	            <td class="td_2 " colspan="3">
		            <d:select name="resident_property_bd" property="bean/resident_property_bd" dictTypeId="RESIDENT_PROPERTY_BD" nullLabel="--请选择--" style="width: 205px"/>
	            </td>
            <%}%>
	     </tr>
            

		</tr>
	</table>
	<p></p>
    <div class="xz_title"><fmt:message key="address_manually_split_account"/></div>
	<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="20%" class="td_1" ><fmt:message key="resident_address1"/></td>
			<td width="20%" class="td_2 ">
		  <input type="text" class="text_field" name="resident_address1" inputName="区、县" value="<%=RmStringHelper.prt(resultVo.getResident_address1()) %>" maxLength="64" />			</td>
			<td class="td_1" ><fmt:message key="resident_address2"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="resident_address2" inputName="街道、乡、镇" value="<%=RmStringHelper.prt(resultVo.getResident_address2()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="resident_address3"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="resident_address3" inputName="路" value="<%=RmStringHelper.prt(resultVo.getResident_address3()) %>" maxLength="64" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="resident_address4"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address4" inputName="弄、村" value="<%=RmStringHelper.prt(resultVo.getResident_address4()) %>" maxLength="64" />			</td>
			<td class="td_1" ><fmt:message key="resident_address5"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="resident_address5" inputName="号" value="<%=RmStringHelper.prt(resultVo.getResident_address5()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="resident_address6"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="resident_address6" inputName="室、队" value="<%=RmStringHelper.prt(resultVo.getResident_address6()) %>" maxLength="64" />            </td>
		</tr>
	</table>
	
	<p></p>
	</div>     
    <div class="xz_title"><fmt:message key="sib_info"/></div>
     <div class="button_right">
         <ul>
             <li class="c">      <a onClick="javascript:addEmpsibling();"><fmt:message key="insert"/> </a></li>
             <li class="d">      <a  onClick="javascript:remove();"><fmt:message key="delete"/> </a> </li>
         </ul>
        <div class="clear"></div>        
     </div>
     <div style="padding: 8 0 8 8;" >
        <r:datacell 
            id="datacell1"
            paramFormId="datacell_formid"
            queryAction="/FAERP/FaerpEmployeeAction.do?cmd=searchEmpSiblingData&emp_id=${emp_id}"
            submitAction="/FAERP/FaerpEmployeeAction.do?cmd=insertEmpSiblingData&emp_id=${emp_id}"
            width="99%"
            height="160px"
            xpath="EmpsiblingVo"
            submitXpath="EmpsiblingVo"
            pageSize="-1"
            > 
          <r:field fieldName="sib_name" messagekey="name">
            <h:text/>
          </r:field>
          <r:field fieldName="sib_relation" messagekey="sib_relation1">
            <d:select dictTypeId="SIB_RELATION" />
          </r:field>
          <r:field fieldName="sib_id_card_type_bd" messagekey="id_card_type" width="130px">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="sib_id_card_num" messagekey="id_card" width="180px">
            <h:text onchange="javascript:setother();"/>
          </r:field>
          <r:field fieldName="sib_sex_bd" messagekey="emp_sex">
            <d:select dictTypeId="EMP_SEX" nullLabel="--请选择--"/>
          </r:field>
          <r:field fieldName="sib_birthday" messagekey="sib_birthday" width="130px">
           <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="sib_desc" messagekey="remark" width="220px">
            <h:text/>
          </r:field>
          <!--<r:field fieldName="fadep_Sibbling_Id"  width="0px" ></r:field>-->
        </r:datacell>
    </div> 
    
    <p></p>
    <div class="box_3">
    <div class="xz_title" style="display:inline" align="left"><fmt:message key="add_info"/>&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="xz_title" style="display:inline" align="left">
        <a id="xianshi" onClick="javascript:openfujia(1);"><u><font color="blue"><fmt:message key="show"/></font></u></a>
        <a id="yincang" style="display:none" onClick="javascript:openfujia(2);"><u><font color="blue"><fmt:message key="hidden"/></font></u></a>
    </div>
    
    
    <div id="fujia" style="display:none">
	<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><fmt:message key="health_status"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("health_status_bd", -1, "HEALTH_STATUS_BD", RmStringHelper.prt(resultVo.getHealth_status_bd()),"", false)%>
			<d:select name="health_status_bd" property="bean/health_status_bd" dictTypeId="HEALTH_STATUS_BD" nullLabel="--请选择--" style="width: 205px"/></td>
			<td class="td_1" ><fmt:message key="deformity_type"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("deformity_type_bd", -1, "DEFORMITY_TYPE_BD", RmStringHelper.prt(resultVo.getDeformity_type_bd()),"", false)%>
			<d:select name="deformity_type_bd" property="bean/deformity_type_bd" dictTypeId="DEFORMITY_TYPE_BD" nullLabel="--请选择--" style="width: 205px"/></td>
			<td class="td_1" ><fmt:message key="medicare_type"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("medicare_type_bd", -1, "MEDICARE_TYPE_BD", RmStringHelper.prt(resultVo.getMedicare_type_bd()),"", false)%>
			<d:select name="medicare_type_bd" property="bean/medicare_type_bd" dictTypeId="MEDICARE_TYPE_BD" nullLabel="--请选择--" style="width: 205px"/></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_care_object"/></td>
			<td class="td_2 ">
			<%if(resultVo==null){ %> 
                 <input type='checkbox' name="is_care_object" value="1" pdType='control' control='checkbox_template' /> 
            <%}else{ if((resultVo.getIs_care_object())!=null&&(resultVo.getIs_care_object()).equals("1")) {%>
                 <input type='checkbox' name="is_care_object" value="1" pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox' name="is_care_object" value="1" pdType='control' control='checkbox_template' />
            <%}} %>
			<td class="td_1" ><fmt:message key="family_member_card_no"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="family_member_card_no" inputName="家属劳保卡号" value="<%=RmStringHelper.prt(resultVo.getFamily_member_card_no()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="is_national_service"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("is_national_service", -1, "IS_NATIONAL_SERVICE", RmStringHelper.prt(resultVo.getIs_national_service()),"", false)%>
			<d:select name="is_national_service" property="bean/is_national_service" dictTypeId="IS_NATIONAL_SERVICE" nullLabel="--请选择--" style="width: 205px"/></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="join_army_date"/></td>
			<td class="td_2">
				<w:date format="yyyy-MM-dd" name="join_army_date" property="bean/join_army_date" width="200px"/>
            </td>
			<td class="td_1" ><fmt:message key="retire_army_date"/></td>
			<td class="td_2">
			     <w:date format="yyyy-MM-dd" name="retire_army_date" property="bean/retire_army_date" width="200px"/>
			</td>
			<td class="td_1" ><fmt:message key="is_care_object1"/></td>
			<td class="td_2 ">
			<%if(resultVo==null){ %> 
            <%}else{ if((resultVo.getIs_deformity_army())!=null&&(resultVo.getIs_deformity_army()).equals("1")) {%>
                 <input type='checkbox' name="is_deformity_army" value="1" pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox' name="is_deformity_army" value="1" pdType='control' control='checkbox_template' />
            <%}} %>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="tech_grade"/></td>
			<td class="td_2 "><%//=gap.rm.tools.helper.RmJspHelper.getSelectField("tech_grade", -1, "TECH_GRADE", RmStringHelper.prt(resultVo.getTech_grade()),"", false)%>
			<d:select name="tech_grade" property="bean/tech_grade" dictTypeId="TECH_GRADE" nullLabel="--请选择--" style="width: 205px"/></td>
			<td class="td_1"><fmt:message key="tech_award_unit"/>：</td>
            <td class="td_2">
                <input type="text" class="text_field" name="tech_award_unit" inputName="职称发证单位" value="<%=RmStringHelper.prt(resultVo.getTech_award_unit()) %>" maxLength="50" />            </td>
			<td class="td_1" ><fmt:message key="tech_award_date"/></td>
			<td class="td_2">
			     <w:date format="yyyy-MM-dd" name="tech_award_date" property="bean/tech_award_date" width="200px"/>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="profession_name"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="profession_name" inputName="职业工种名称" value="<%=RmStringHelper.prt(resultVo.getProfession_name()) %>" maxLength="50" />			</td>
			<td class="td_1" ><fmt:message key="profession_level"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="profession_level" inputName="职业工种等级" value="<%=RmStringHelper.prt(resultVo.getProfession_level()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="profession_award_unit"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="profession_award_unit" inputName="职业工种发证单位" value="<%=RmStringHelper.prt(resultVo.getProfession_award_unit()) %>" maxLength="64" />            </td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="profession_award_date"/></td>
			<td class="td_2">
				<w:date format="yyyy-MM-dd" name="profession_award_date" property="bean/profession_award_date" width="200px"/>
			</td>
			<td class="td_1" ><fmt:message key="begin_work_date"/></td>
			<td class="td_2">
			     <w:date format="yyyy-MM-dd" name="begin_work_date" property="bean/begin_work_date" width="200px"/>
			</td>
			<td class="td_1" ><fmt:message key="is_have_bad_record"/></td>
            <td class="td_2 ">
            <%if(resultVo==null){ %> 
                 <input type='checkbox' name="is_have_bad_record" value="1" pdType='control' control='checkbox_template' /> 
            <%}else{ if((resultVo.getIs_have_bad_record())!=null&&(resultVo.getIs_have_bad_record()).equals("1")) {%>
                 <input type='checkbox' name="is_have_bad_record" value="1" pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox' name="is_have_bad_record" value="1" pdType='control' control='checkbox_template' />
            <%}} %>
            </td>
		</tr>
	</table>
	</div>
    </div>
    <div class="foot_button">
        <input type="button" class="foot_icon_1" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
      
</div>         
            
<input type="hidden" name="emp_id" value="<%=resultVo.getId() %>">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
    if($id("is_foreigner").value=="1"){
        $id("birthShow").style.display="none";
    }else{
        $id("birthShow").style.display="inline";
    }

    jQuery(document).ready(function(){
        var idcardtype = jQuery(this).find("input[name='id_card_type_bd']").val();
        var empsex = jQuery(this).find("select[name='emp_sex']").val();
        var birthdate= jQuery(this).find("input[name='birth_date']").val();
        var idcard = jQuery("#id_card").val();
        //加载证件号码
        jQuery("#show_id_card").val(idcard);
        //如果是身份证
        if(idcardtype!=null && idcardtype=='1'){
            //如果性别为空
            if(empsex==null || empsex==''){
            
                var tmpSex='';
                if(idcard.length==15){
                    tmpSex=idcard.substr(14,1);
                }
                if(idcard.length==18){
                    tmpSex=idcard.substr(16,1);
                }
                if(tmpSex%2==1){
                    jQuery(this).find("select[name='emp_sex']").val('1');
                }else{
                    jQuery(this).find("select[name='emp_sex']").val('0');
                }
            }
            //如果生日为空
            if(birthdate==null || birthdate==''){
                var birth = '';
                if(idcard.length==15){
                    birth='19'+idcard.substr(6,2)+'-'+idcard.substr(8,2)+'-'+idcard.substr(10,2);
                }
                if(idcard.length==18){
                    birth=idcard.substr(6,4)+'-'+idcard.substr(10,2)+'-'+idcard.substr(12,2);
                }
                $id("birth_date").setValue(birth);
            }
                
        }
    });
</script>
