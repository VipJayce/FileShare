<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@page import="rayoo.employeepost.eppartymemer.vo.EmployeeVo"%>

<%  //判断是否为修改页面

	EmployeeVo vo = null;
	if(request.getAttribute("employee")!=null){
	    vo= (EmployeeVo)request.getAttribute("employee");
	}else{
	    vo = new EmployeeVo();
	}
%>

<html>
<fmt:bundle basename="rayoo.employeepost.eppartymemer.eppartymemer_resource" prefix="rayoo.employeepost.eppartymemer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function toFindEmployee(obj){
        $id("emp_code0").value=obj[0];
        $id("l_emp").value=obj[1];
        $id("l_emp").displayValue=obj[1];
        $id("id_card0").value=obj[2];
        $name("id_card_type_bd0").value=obj[3];
        $id("post_id").value = obj[4];
        $id("on_post_date").value = obj[5]
    }
	
	function simpleQuery_onClick(){
        var emp_name1=$id("l_emp").displayValue;
        var emp_code = $id("emp_code0").value;
        var id_card = $id("id_card0").value;
        if((emp_name1==null || emp_name1=="") && (emp_code==null || emp_code=="") && (id_card==null || id_card=="")){
            alert("<fmt:message key="query_condition_not_null"/>");
            return;
        }
        form.action="<%=request.getContextPath()%>/EppartymemerAction.do?cmd=findParty&emp_name1="+emp_name1;
        form.submit();
    }
	
	function insert_onClick(){  //插入单条数据
		var ids = document.getElementById("emp_id").value;
		
		var is_secretary= document.getElementById("is_secretary").checked;
		if(is_secretary){
		   document.getElementById("is_secretary").value=1;
		}else{
		    document.getElementById("is_secretary").value=0;
		}
		   
		var is_over_sea_in= document.getElementById("is_over_sea_in").checked;
		if(is_over_sea_in){
		   document.getElementById("is_over_sea_in").value=1;
		}else{
		    document.getElementById("is_over_sea_in").value=0;
		}
		
		var is_prepare= document.getElementById("is_prepare").checked;
		if(is_prepare){
		   document.getElementById("is_prepare").value=1;
		}else{
		    document.getElementById("is_prepare").value=0;
		}
		   
		if(ids==null||ids==''){
		   alert("<fmt:message key="please_choose_emp_info"/>");
		   return;
		}
		
		var in_date = document.getElementById("in_date").value;
		var become_date = document.getElementById("become_date").value;
		var relation_area = document.getElementById("relation_area").value;
		var inside_position = document.getElementById("inside_position").value;
	    var is_secretary = document.getElementById("is_secretary").value;
	    var is_over_sea_in = document.getElementById("is_over_sea_in").value;
	    var is_prepare = document.getElementById("is_prepare").value;
	    var remarks = document.getElementById("remarks").value;
	    var post_id = document.getElementById("post_id").value;
	    var on_post_date = document.getElementById("on_post_date").value;
	    if(in_date==null || in_date==""){
	       alert("<fmt:message key="join_party_date_not_null"/>");
	       return;
	    }
	    if(relation_area==null || relation_area==""){
	       alert("<fmt:message key="relation_area_not_null"/>");
	       document.form.relation_area.focus();
	       return;
	    }
	    if(is_prepare=='1'){
            if(become_date==null || become_date==""){
                alert("<fmt:message key="become_date_not_null"/>");
                return ;
            }
	    }
	    jQuery.getJSON("<%=request.getContextPath()%>/EppartymemerAction.do?cmd=save&date="+new Date()+"",{"post_id":post_id,"on_post_date":on_post_date,"emp_id":ids,"in_date":in_date,"become_date":become_date,"relation_area":relation_area,"inside_position":inside_position,"is_secretary":is_secretary,"is_over_sea_in":is_over_sea_in,"is_prepare":is_prepare,"remarks":remarks},function(json){
            alert(json.saia);
            var url = "<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartymemer/insertEppartymemer.jsp";
            refresh(url);
        });
	   // var url = "<%=request.getContextPath()%>/EppartymemerAction.do?cmd=chooseEmppost&emp_id="+ids+"&in_date="+in_date+"&become_date="+become_date+"&relation_area="+relation_area+"&inside_position="+inside_position+"&is_secretary="+is_secretary+"&is_over_sea_in="+is_over_sea_in+"&is_prepare="+is_prepare+"&remarks="+remarks;
	   // showModalCenter(url,window,refresh,950,400,"选择客户页面");
	}
	
	function refresh(reg){
	   if(reg=='undefined' || reg==null || reg==""){
	       
	   }else{
	       window.location.href = reg;
	   }
	}

</script>
</head>
<body>

<form name="form" method="post">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <input type="hidden" name="on_post_date" id="on_post_date" value="<%=vo.getOn_post_date() == null?"":vo.getOn_post_date() %>" />
 <input type="hidden" name="post_id" id="post_id" value="<%=vo.getPost_id()==null?"":vo.getPost_id() %>" />
<div id="right">
<script language="javascript">
        writeTableTopFesco('<fmt:message key="party_info_maintain"/>','<%=request.getContextPath()%>/');

</script>


 <!-- 查询党员信息 -->
 <div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td  width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left">
                <w:lookup onReturnFunc="toFindEmployee" id="l_emp" name="emp_name0"  lookupUrl="/jsp/faerp/common/employee/allEmployeeForParty.jsp" messagekey="choose_emp" height="434" width="750" style="width:188px"/>
            </td>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left">
                <input type="text" class="text_field" id="emp_code0" name="emp_code0" inputName="唯一号" maxLength="18"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="credentials_type"/></td>
            <td align="left">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("id_card_type_bd0", -1,"ID_CARD_TYPE_BD", "", "", false) %>
            </td>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left">
                <input type="text" class="text_field" id="id_card0" name="id_card0" inputName="证件号码" maxLength="18"/>
            </td>
           
        </tr>
        <tr>
         <td align="right"></td>
            <td align="left">
            </td>
           <td align="right"></td>
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            </td>
        </tr>
    
</table>
</div>
<!-- 党员查询信息完成 -->
<!-- 党员基本信息 -->
<div id="ccParent0" class="box_3">
<div class="xz_title"><fmt:message key="party_base_info"/></div>
 <div class="ringht_s">
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><fmt:message key="emp_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getEmp_name()==null?"":vo.getEmp_name() %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="the_unit"/></td>
            <td class="td_2" >
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getCust_name()==null?"":vo.getCust_name() %>" readonly="readonly" style="width:200px" />
            </td>
           
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="address"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getAddress()==null?"":vo.getAddress() %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="emp_code"/></td>
            <td class="td_2" >
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getEmp_code()==null?"":vo.getEmp_code()%>" readonly="readonly" style="width:200px"/>
            </td>
        </tr>
           <tr>
            <td class="td_1" ><fmt:message key="sex"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getEmp_sex()==null?"":BaseDataHelper.getNameByCode("EMP_SEX",vo.getEmp_sex()) %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="nationality"/></td>
            <td class="td_2" >
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getNationality()==null?"":vo.getNationality() %>" readonly="readonly" style="width:200px" />
            </td>
        </tr>
           <tr>
            <td class="td_1" ><fmt:message key="education_bd"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getEducation_bd()==null?"":BaseDataHelper.getNameByCode("EDUCATION_BD",vo.getEducation_bd()) %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="resident_addresss1"/></td>
            <td class="td_2" >
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getResident_addresss()==null?"":vo.getResident_addresss() %>" readonly="readonly" style="width:200px"/>
            </td>
        </tr>
           <tr>
            <td class="td_1" ><fmt:message key="marriage_status"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getMarriage_status_bd()==null?"":BaseDataHelper.getNameByCode("MARRIAGE_STATUS_BD",vo.getMarriage_status_bd()) %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="e_mail"/></td>
            <td class="td_2" >
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getEmail()==null?"":vo.getEmail() %>" readonly="readonly" style="width:200px"/>
            </td>
        </tr>
           <tr>
            <td class="td_1" ><fmt:message key="mobile1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getMobile()==null?"":vo.getMobile() %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ><fmt:message key="tel1"/></td>
            <td class="td_2" >
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getTel()==null?"":vo.getTel() %>" readonly="readonly" style="width:200px"/>
            </td>
        </tr>
           <tr>
            <td class="td_1" ><fmt:message key="address1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field_reference_readonly" value="<%=vo.getAddress1()==null?"":vo.getAddress1() %>" readonly="readonly" style="width:200px"/>
            </td>
            <td class="td_1" ></td>
            <td class="td_2" >
                
            </td>
        </tr>
          </table>
<!-- 党员基本信息完成 -->

<p></p>
<input type="hidden" id ="emp_id" name="emp_id" value="<%=vo.getId()==null?"":vo.getId() %>"/>
<div class="xz_title"><fmt:message key="party_info"/></div>

    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="in_party_date"/></td>
            <td class="td_2">
                  <w:date id="in_date" format="yyyy-MM-dd" name="in_date" property="employee/in_date" width="200px" />
            </td>
            <td  class="td_1" ><fmt:message key="become_date"/></td>
            <td class="td_2" >
                 <w:date id="become_date" name="become_date" format="yyyy-MM-dd" property="employee/become_date" width="200px" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="relation_area"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="relation_area" name="relation_area" inputName="原组织关系 所在(支部)" value="<%=vo.getRelation_area()==null?"":vo.getRelation_area() %>"  />
            </td>
            <td class="td_1" ><fmt:message key="inside_position"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" id="inside_position" name="inside_position" inputName="党内职务" value="<%=vo.getInside_position()==null?"":vo.getInside_position() %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_secretary"/></td>
            <td class="td_2 ">
           
            <%if(vo==null){ %> 
                 <input type='checkbox' id="is_secretary"  name="is_secretary" value="0" pdType='control' control='checkbox_template' /> 
            <%}else{ if((vo.getIs_secretary())!=null&&(vo.getIs_secretary()).equals("1")) {%>
                 <input type='checkbox'  id="is_secretary" name="is_secretary" value="1" pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox'  id="is_secretary" name="is_secretary" value="0" pdType='control' control='checkbox_template' />
            <%}} %>
                
            </td>
            <td class="td_1" ><fmt:message key="is_over_sea_in"/></td>
            <td class="td_2 ">
           
             <%if(vo==null){ %> 
                 <input type='checkbox' id="is_over_sea_in"  name="is_over_sea_in" value="0" pdType='control' control='checkbox_template' /> 
            <%}else{ if((vo.getIs_over_sea_in())!=null&&(vo.getIs_over_sea_in()).equals("1")) {%>
                 <input type='checkbox'  id="is_over_sea_in" name="is_over_sea_in" value="1" pdType='control' control='checkbox_template' checked="checked" />
            <%}else {%>
                 <input type='checkbox'  id="is_over_sea_in" name="is_over_sea_in" value="0" pdType='control' control='checkbox_template' />
            <%}} %>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="is_prepare"/></td>
            <td class="td_2">
            
           <%if(vo==null){ %> 
                 <input type='checkbox' id="is_prepare"  name="is_prepare" value="0" pdType='control' control='checkbox_template' /> 
            <%}else{ if((vo.getIs_prepare())!=null&&(vo.getIs_prepare()).equals("1")) {%>
                 <input type='checkbox'  id="is_prepare" name="is_prepare" value="1" pdType='control' control='checkbox_template' checked="checked"/>
            <%}else {%>
                 <input type='checkbox'  id="is_prepare" name="is_prepare" value="0" pdType='control' control='checkbox_template' />
            <%}} %>
            </td>
            <td class="td_2"></td>
            <td class="td_2"></td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="on_post_desc1"/></td>
            <td class="td_2"><textarea rows="3" class="textarea_limit_words" id="remarks" name="remarks" style="width:200px"><%=vo.getRemarks()==null?"":vo.getRemarks() %></textarea></td>
            <td class="td_2"></td>
            <td class="td_2"></td>
        </tr>
        
    </table>
   
    <div class="foot_button" style="text-align: center;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>'   <au:authorityBtn code="dyxx_save" type="1"/>  onClick="insert_onClick()" />
    </div>
</div>         
<!-- 党内信息 -->            
</form>
</fmt:bundle>
</body>
</html>


