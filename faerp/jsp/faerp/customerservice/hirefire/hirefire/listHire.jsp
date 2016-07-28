﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.listHire_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listHire0000'/>List页面</title>
<script language="javascript">
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	
    function toEmploySingle(){
        //form.action="<%=request.getContextPath()%>/HirefireAction.do?id=" + ids;
        //form.cmd.value = "toEmploySingle";
        //form.submit();
        var url = "<%=request.getContextPath()%>/HirefireAction.do?cmd=toEmploySingle&_ts="+(new Date()).getTime();
        //showModalCenter(url, window, callBack_toEmploySingle, 850, 250, "<fmt:message key='listHire0002'/>"); 
        window.open(url,'','height=300px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listHire0002'/>');
    
    }
    
    function callBack_toEmploySingle(reg){
        var emp_name =  _$("#emp_name").val();
        var emp_code =  _$("#emp_code").val();
        var id_card =  _$("#id_card").val();
        var cust_name = $id("cust_name").getValue();
        var classify_date_from = $id("classify_date_from").getValue();
        var classify_date_to = $id("classify_date_to").getValue();
        var service_status = _$("#service_status").val();
        var big_name = _$("#big_name").val();
        var hire_fire_status_bd = _$("#hfselect").val();
        var social_unit = $id("social_unit").getValue();
        reg+= "&arg8="+emp_name+"&arg9="+emp_code+"&arg10="+id_card+"&arg11="+classify_date_from+"&arg12="+classify_date_to+"&arg13="+service_status+"&arg14="+big_name+"&arg15="+hire_fire_status_bd+"&arg16="+encodeURIComponent(cust_name)+"&arg17="+social_unit;
        form.action = reg;
        form.submit();
    }
    
    function exportexcel(){
        form.action="<%=request.getContextPath()%>/HirefireAction.do";
        form.cmd.value = "exportExcelHire";
        form.submit();
    }
    
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){return;
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    
    function rtnFuncCustomer(obj){
        var lookup = $id("cust_name");
        lookup.value = obj[2];
        lookup.displayValue = obj[2];
        return false;
    }
    
    /**
	 * <fmt:message key='listHire0004'/>emp_id
	 */
	function getEmpId() {
	   var ids = selectIds();
	   if(ids == null || ids == '') {
	        alert('<fmt:message key='listHire0005'/>');
	        return;
	    }
	    if(ids.length > 1) {//如果ids<fmt:message key='listHire0006'/>2条以上的纪录
	        alert('<fmt:message key='listHire0008'/>');
	        return;
	    }
	    var empId = "";
	    var id = "";
	    var unitShortName = "";
	    var hire_security_unit_id = "";
	    var dc = $id("datacell1");
	    
	    _$("input[type='checkbox']").each(function(i) {
	         //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            empId = entity.getValue("emp_id");
	            unitShortName = entity.getValue("hire_unit_short_name");
	            hire_security_unit_id = entity.getValue("hire_security_unit_id");
	        }
	    });
	    unitShortName = encodeURI(unitShortName);//编码json
	    var url = "<%=request.getContextPath()%>/BaseinfoAction.do?cmd=toDetailBaseinfo&empId="+empId+"&unitShortName="+unitShortName+"&hire_security_unit_id="+hire_security_unit_id;
	    var width = window.screen.width-20;
	    var height = window.screen.height-80;
        window.open(url,'个人<fmt:message key='listHire0047'/>','height='+height+',width='+width+',top =0,left=0,help=no,resizable=yes,scrollbars=yes,menubar=yes,location=no,status=not,title=个人<fmt:message key='listHire0047'/>');
	}
	 //无人机加急处理
	 function uavhandle(){
		 var ids = selectIds();//取得多选框的选择项
			if(ids == null || ids == "") {  //如果ids为空
		  		alert('请选择一条需要加急处理数据！');
		  		return;
			}else{
	        	var flags=true;
	            jQuery.ajax({
	            url: '/FAERP/PremiumProcessing.do?cmd=getSecurityProductInfoZG&emp_post_id='+ids+"&date="+new Date(),
	            type: 'GET',
	            dataType: 'html',
	            async: false,
	            timeout: 80000,
	            error: function(){
	            	alert('Error loading XML document');
	                return  null;
	            },
	            success: function(text){
	            	if(text!=null){
	                   alert(text);
	                   simpleQuery_onClick();
	                }

	            }
	            });
	            return flags;
	        }
	 }
	// tangyong  线路转换js start 
		function getEmpId2(){
		    var ids = selectIds();
		    if(ids == null) {
		        alert('请选择一条记录。');
		        return false;
		    }
		    var dc1 = $id("datacell1").dataset;
		    for(var i=0; i<ids.length; i++){
		        var entity = dc1.findEntity("id", ids[i]);
		        var emp_name = entity.getProperty("emp_name");
		        var uav_line_name = entity.getProperty("uav_line_name");
		    }
		    var flag = true;
		    var dc = $id("datacell1");
		    var ds = dc.dataset;
		    var action = venusbase + "/HirefireAction.do?cmd=hirupdateforline";
		    var xmlSubmit = ds.toString();
		    var myAjax = new Ajax(action);
		    myAjax.loadData(xmlSubmit);
		    var returnNode = myAjax.getResponseXMLDom();
		    if(returnNode) {
		        if(myAjax.getValue("root/data/returnValue")) {
		            alert(myAjax.getValue("root/data/returnValue"));
		           
		           	// window.close();
		        } else {
		            alert('转换失败');
		        }
		    } else {
		        alert('转换失败');
		    }
		    simpleQuery_onClick();
		  //  dc.reload();
		}
		// tangyong  线路转换js end  
</script>
<script language="javascript" src="<venus:base/>/jsp/faerp/customerservice/hirefire/hirefire/listhire.js"></script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryHireData">
<input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key='listHire0000'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listHire0014'/></div> </td>
    </tr>
    <tr>  
          <td align="left"><fmt:message key='listHire0015'/></td>
          <td align="left">
              <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="<fmt:message key='listHire0016'/>" value="" maxLength="50"/>
          </td>
          <td align="left"><fmt:message key='listHire0017'/></td>
          <td align="left">
              <input type="text" class="text_field" name="emp_code" id="emp_code" inputName="<fmt:message key='listHire0018'/>" value="" maxLength="64"/>
          </td>
          <td align="left"><fmt:message key='listHire0019'/></td>
          <td align="left">
              <input type="text" class="text_field" name="id_card" id="id_card" inputName="<fmt:message key='listHire0019'/>" value="" maxLength="50"/>
          </td>
    </tr>
	<tr>
	        <td align="left"><fmt:message key='listHire0021'/></td>
            <td align="left">
                <w:lookup id="cust_name" validateAttr="allowNull=false;" name="cust_name"
                lookupUrl="/CustomersimpleAction.do?cmd=queryCustomerData" 
                messagekey="listHire0022" height="500" width="810"  onReturnFunc="rtnFuncCustomer" />
            </td>    
            <td align="left"><fmt:message key='listHire0023'/></td>
            <td align="left">
                <!--<input type="text" class="text_field_half_reference_readonly" name="classify_date_from" id="classify_date_from" inputName="<fmt:message key='listHire0023'/>" value=""/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('classify_date_from','<venus:base/>/');"/>&nbsp;<fmt:message key='listHire0025'/>&nbsp;<input type="text" class="text_field_half_reference_readonly" name="classify_date_to" id="classify_date_to" inputName="<fmt:message key='listHire0023'/>" value=""/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('classify_date_to','<venus:base/>/');"/>
            -->
            <w:date allowInput="true" id="classify_date_from" name="classify_date_from" format="yyyy-MM-dd" style="width:70px;"/>
            &nbsp;<fmt:message key='listHire0025'/>&nbsp;
            <w:date allowInput="true" id="classify_date_to" name="classify_date_to" format="yyyy-MM-dd" style="width:70px;"/>
            </td>
            <td align="left"><fmt:message key='listHire0028'/></td>
            <td align="left">
                <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("service_status", -1,"TrueOrFalse"," ","",false) %> 
                <d:select dictTypeId="TrueOrFalse" id="service_status" property="service_status" nullLabel="" />
            </td>    
	</tr>	
	<tr>
	        <td align="left"><fmt:message key='listHire0030'/></td>
            <td align="left">
                <input type="text" class="text_field" name="big_name" id="big_name" inputName="<fmt:message key='listHire0030'/>" value="" maxLength="50" />
            </td>
            <td align="left"><fmt:message key='listHire0032'/></td>
            <td align="left">
                <d:select dictTypeId="HIRE_STATUS_BD" id="hfselect" name="hire_fire_status_bd" onchange="hf_select()" value="0"></d:select> 
            </td>
          <td align="left"><fmt:message key='listHire0033'/></td>
          <td align="left">
              <r:comboSelect id="social_unit"  name="social_unit"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText=""
                width="205px">
            </r:comboSelect> 
          </td>    
	</tr>	
	<tr>
		<td align="left">入职日期</td>
        <td align="left">
        	<w:date allowInput="true" id="apply_on_post_date_from" name="apply_on_post_date_from" format="yyyy-MM-dd" style="width:70px;"/>
            &nbsp;到&nbsp;
            <w:date allowInput="true" id="apply_on_post_date_to" name="apply_on_post_date_to" format="yyyy-MM-dd" style="width:70px;"/>
        </td>
	       <td align="left">反馈状态</td>
            <td align="left">
            <d:select dictTypeId="FEEDBACK_STATE" id="p_feedback_state" name="p_feedback_state"  nullLabel="--请选择--"></d:select> 
            </td>
           <!-- tangyong  添加查询条件为专员  start-->
		  <td align="left">专员</td>
           <td align="left">
              <r:comboSelect id="user_id"  name="user_id"
                queryAction="/FAERP/FaerpEmployeeAction.do?cmd=getListzhuanlist"
                textField="user_name" 
                valueField="user_id" 
                xpath="EmployeeVo"
                nullText="--请选择--"
                width="205px">
            </r:comboSelect> 
          </td>  
            <!-- tangyong  添加查询条件为专员 end-->  
	</tr>
	<tr>
	  <td align="left">办理阶段</td>
           <td align="left">
              <select name="person_name" id="person_name" style="width:210">
                     <option value ="">请选择</option>
                     <option value="0">IA</option>
                     <option value="1">MW</option>
               </select>
       </td> 
	<td align="left"></td>
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"   type="button" value="<fmt:message key='listHire0035'/>" >
	
	</tr>		
</table>
</div>


 

					
<div id="ccParent1" class="button">
<div class="button_right" id="div_button_1" style="display: block;">
    <!--<ul>
    <li class="a_2"><a href="#" onClick="javascript:toDetailLabor()"><fmt:message key='listHire0036'/></a></li>
    <li class="bl_1"><a href="#" onClick="javascript:toHandle()"><fmt:message key='listHire0000'/></a></li>
    <li class="nbl_1"><a href="#" onClick="javascript:hirenothandle()"><fmt:message key='listHire0038'/></a></li>
    <li class="tb_1"><a href="#" onClick="javascript:hirenotfire()"><fmt:message key='listHire0039'/></a></li>
    <li class="dj_2"><a href="#" onClick="javascript:toEmploySingle()"><fmt:message key='listHire0002'/></a></li>
    <li class="e"><a href="#" onclick="javascript:exportexcel()"><fmt:message key='listHire0041'/></a></li>
    </ul>
-->
<input class="bl_1" type="button"   value=" <fmt:message key='listHire0000'/>"  <au:authorityBtn code="ygbl_ygbl" type="1"/>  onClick="toHandle();">
<input class="nbl_1" type="button"   value=" <fmt:message key='listHire0038'/>"  <au:authorityBtn code="ygbl_ygbxbl_" type="1"/>  onClick="hirenothandle();">
<input class="tb_1" type="button"   value=" <fmt:message key='listHire0039'/>"  <au:authorityBtn code="ygbl_ygbt" type="1"/>  onClick="hirenotfire();">
<input class="dj_2" type="button"   value=" <fmt:message key='listHire0002'/>"  <au:authorityBtn code="ygbl_lyd" type="1"/>  onClick="toEmploySingle();">
<input class="e" type="button"   value=" <fmt:message key='listHire0041'/>"  <au:authorityBtn code="ygbl_exp" type="1"/>  onClick="exportexcel();">
<input class="bl_1" type="button"   value=" <fmt:message key='listHire0047'/> "  <au:authorityBtn code="ygbl_xxcj" type="1"/>  onClick="getEmpId();">
<input class="h_1" type="button"   value="催呼确认"  <au:authorityBtn code="gjjbl_email" type="1"/>  onClick="batch_callcenter_onClick();">
<input class="r" type="button" id="elfHand" name="elfHand" value="精灵之手">
<!-- tangyong 添加线路转换按钮 start -->
<input class="r" type="button"   value=" 线路转换 " onClick="getEmpId2();">
<input class="bl_1" type="button"   value="加急办理"    onClick="uavhandle();"><!-- tangyong 添加线路转换按钮 end -->

</div>
<div class="button_right" id="div_button_2" style="display: none;">
    <!--<ul>
    <li class="a_2"><a href="#"  onClick="javascript:toDetailLabor()"><fmt:message key='listHire0036'/></a></li>
    <li class="m_1" ><a href="#"  onClick="javascript:cancelhire()"><fmt:message key='listHire0049'/></a></li>
    <li class="dj_2"><a href="#"   onClick="javascript:toEmploySingle()"><fmt:message key='listHire0002'/></a></li>
    <li class="e"><a href="#" onclick="javascript:exportexcel()"><fmt:message key='listHire0041'/></a></li>
    </ul>
-->
<input class="m_1" type="button"   value=" <fmt:message key='listHire0049'/>"  <au:authorityBtn code="ygbl_cancel" type="1"/>  onClick="cancelhire();">
<input class="dj_2" type="button"   value=" <fmt:message key='listHire0002'/>"  <au:authorityBtn code="ygbl_lyd" type="1"/>  onClick="toEmploySingle();">
<input class="e" type="button"   value=" <fmt:message key='listHire0041'/>"  <au:authorityBtn code="ygbl_exp" type="1"/>  onClick="exportexcel();">
<input class="bl_1" type="button"   value=" <fmt:message key='listHire0047'/> "  <au:authorityBtn code="ygbl_xxcj" type="1"/>  onClick="getEmpId();">
</div>           
<div class="clear"></div>			
</div>
 
 
<div style="padding: 8 10 8 8;">
<!-- 如果新增删除列表内容请通知精灵之手项目组 -->
 <r:datacell id="datacell1"
		queryAction="/FAERP/HirefireAction.do?cmd=queryHireData" width="98%"
		height="320px" xpath="HirefireVo" submitXpath="HirefireVo" paramFormId="datacell_formid"
	>
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<!-- 
    <r:field fieldName="id" messagekey='listHire0056' width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>    
     -->
		<r:field allowModify="false" fieldName="chk"
			label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
			sortAt="none" width="30px">
			<h:switchCheckbox name="chk" id="chk" checkedValue="1"
				uncheckedValue="0" />
		</r:field>
		
		<r:field fieldName="hire_security_unit_id" label="hire_security_unit_id" width="0px;" sortAt="none"></r:field>
		<r:field fieldName="emp_id" label="<fmt:message key='listHire0057'/>id" width="0px;" sortAt="none"></r:field>
		<r:field fieldName="feedback_state"  label="反馈状态" width="70px" allowModify="false" sortAt="none">
			<d:select dictTypeId="FEEDBACK_STATE"></d:select> 
		</r:field>
        <r:field fieldName="feedback_info" label="反馈信息" width="140px" sortAt="none"></r:field>
		<r:field fieldName="emp_name" messagekey='listHire0016' onRefreshFunc="setEmp" sortAt="none"></r:field>
		<r:field fieldName="emp_code" messagekey='listHire0017' sortAt="none"></r:field>
		<r:field fieldName="id_card" messagekey='listHire0060' width="150px;" sortAt="none"></r:field>
		<r:field fieldName="bigname" messagekey='listHire0030' width="180px;" sortAt="none"></r:field>
		<r:field fieldName="cust_code"  label="客户编号"  width="100" sortAt="none"></r:field>
		<r:field fieldName="cust_name" messagekey='listHire0021' width="150px;" sortAt="none"></r:field>
		<r:field fieldName="hire_unit_short_name" messagekey='listHire0033' width="180px;" sortAt="none"></r:field>
		<r:field fieldName="on_post_desc" messagekey='listHire0068' sortAt="none"></r:field>
		<r:field fieldName="service_desc"  label="入职分类备注" sortAt="none"></r:field>
		<r:field fieldName="classify_date" messagekey='listHire0064' allowModify="false" sortAt="none">
			<w:date format="yyyy-MM-dd" />
		</r:field>
		<r:field fieldName="apply_on_post_date" messagekey='listHire0065'
			allowModify="false" sortAt="none">
			<w:date format="yyyy-MM-dd" />
		</r:field>
		<r:field fieldName="apply_off_post_date" messagekey='listHire0066'
			allowModify="false" sortAt="none">
			<w:date format="yyyy-MM-dd" />
		</r:field>
		<r:field fieldName="smallname" messagekey='listHire0067' sortAt="none"></r:field>
		<r:field fieldName="on_post_desc" messagekey='listHire0068' sortAt="none"></r:field>
		<r:field fieldName="cs_name" messagekey='listHire0069' sortAt="none"></r:field>
		<r:field fieldName="back_reason" messagekey='listHire0070' sortAt="none" >
			<h:text name="back_reason" value="back_reason" onblur="batch_change_reason();"/>
		</r:field>
		<r:field fieldName="cancel_reason" messagekey='listHire0071' sortAt="none">
			<h:text name="cancel_reason" value="cancel_reason" onblur="batch_cancel_reason();"/>
		</r:field>
		<r:field fieldName="start_date" messagekey='listHire0072' allowModify="false" sortAt="none">
			<w:date format="YYYY-MM-DD" />
		</r:field>
		<r:field fieldName="end_date" messagekey='listHire0073' allowModify="false" sortAt="none">
			<w:date format="YYYY-MM-DD" />
		</r:field>
		<r:field fieldName="is_tiaodang" messagekey='listHire0074' allowModify="false" sortAt="none">
		    <d:select dictTypeId="TrueOrFalse"/>
		</r:field>
		<r:field fieldName="hire_memo" messagekey='listHire0075' sortAt="none"></r:field>
		<r:field fieldName="callcenterremark" label="催呼原因" sortAt="none"></r:field>
		<r:field fieldName="call_center_bd" label="催呼状态" sortAt="none">
		<d:select dictTypeId="CALL_CENTER_BD" disabled="true"/>   
		</r:field>
		<r:field fieldName="callcenterresult" label="催呼结果" sortAt="none">
		<d:select dictTypeId="CALLCENTERRESULT" disabled="true" />   
		</r:field>
		<r:field fieldName="callcenterresultremark" label="催呼结果备注" sortAt="none"></r:field>
		<r:field fieldName="id" label="入离职ID" width="0px;" sortAt="none"></r:field>
		
		<r:field fieldName="item_id" label="明细ID" width="0px;" sortAt="none"></r:field>
		<r:field fieldName="secutity_id" width="0px;" sortAt="none"></r:field>
	<!-- tangyong 增加专员办理阶段及其用工时间字段显示 start -->
		<r:field fieldName="is_new" label="转入类型" sortAt="none"></r:field>
		<r:field fieldName="uav_line_name" label="办理阶段" sortAt="none"></r:field>
		<r:field fieldName="user_name" label="专员" sortAt="none"></r:field>
		<r:field fieldName="apply_on_post_date" label="用工时间"
			allowModify="false" sortAt="none">
			<w:date format="yyyy-MM-dd" />
		</r:field>
			<r:field fieldName="uav_status" width="0px;" sortAt="none"></r:field>
			<!-- tangyong 增加专员办理阶段及其用工时间字段显示 end -->
		
		
	</r:datacell>
</div>

 
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
</script>	
