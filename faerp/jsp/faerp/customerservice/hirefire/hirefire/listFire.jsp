<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.hirefire.hirefire.vo.HirefireVo" %>
<%@ page import="rayoo.customerservice.hirefire.hirefire.util.IHirefireConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IHirefireConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IHirefireConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    HirefireVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.listFire_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript" src="<venus:base/>/jsp/faerp/customerservice/hirefire/hirefire/listfire.js"></script>
<script language="javascript">    
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
//无人机加急处理
	 function uavhandle(){
		 var ids = selectIds();  //取得多选框的选择项
		 if(ids == null || ids == "") {  //如果ids为空
		  		alert('请选择一条需要加急处理数据！');
		  		return;
			}else{
	        	var flags=true;
	            jQuery.ajax({
	            url: '/FAERP/PremiumProcessing.do?cmd=getSecurityProductInfoTG&emp_post_id='+ids+"&date="+new Date(),
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
    function blur_change(str,obj){
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            var popid = obj.name.substring(0,19);
            document.getElementById('popid').value =  popid;
            return;
        }
        for(var i=0;i<ids.length;i++){
            var id = ids[i];
            document.getElementById(id+str).value = obj.value;
        }
        return true;
    }

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }

    function callBack_fireProve(reg){
        window.location.href=reg;
    }
 	// tangyong 线路转换 start 
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
	    var action = venusbase + "/HirefireAction.do?cmd=fireupdateforline";
	    var xmlSubmit = ds.toString();
	    var myAjax = new Ajax(action);
	    myAjax.loadData(xmlSubmit);
	    var returnNode = myAjax.getResponseXMLDom();
	    if(returnNode) {
	        if(myAjax.getValue("root/data/returnValue")) {
	            alert(myAjax.getValue("root/data/returnValue"));
	           	// window.close();
	        } else {
	            alert('提交失败。');
	        }
	    } else {
	        alert('提交失败');
	    }
	    simpleQuery_onClick();
	}
 	// tangyong 线路转换按钮 end
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryAllHire">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key='listFire0011'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listFire0012'/></div> </td>
    </tr>
    <tr>
          <td align="left"><fmt:message key='listFire0062'/>名称</td>
          <td align="left">
              <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listFire0062'/>姓名" value="" maxLength="50"/>
          </td>
          <td align="left"><fmt:message key='listFire0015'/></td>
          <td align="left">
              <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listFire0015'/>" value="" maxLength="50"/>
          </td>
          <td align="left"><fmt:message key='listFire0067'/>号码</td>
          <td align="left">
              <input type="text" class="text_field" name="id_card" inputName="" value="" maxLength="50"/>
          </td>
    </tr>
    <tr>
          <td align="left"><fmt:message key='listFire0018'/></td>
          <td align="left">
              <!--<faerp:SoialunitSelectTag tagname="social_unit" beanname="social_unit" />-->
              <r:comboSelect id="social_unit"  name="social_unit"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText=""
                width="205px">
            </r:comboSelect> 
          </td>
          <td align="left"><fmt:message key='listFire0020'/></td>
          <td align="left">
                <w:date allowInput="true" id="off_post_date_from" name="off_post_date_from" format="YYYY-MM-DD" style="width:70px;"/>
                &nbsp;<fmt:message key='listFire0021'/>&nbsp;
                <w:date allowInput="true" id="off_post_date_to" name="off_post_date_to" format="YYYY-MM-DD" style="width:70px;"/>
          </td>
          <td align="left"><fmt:message key='listFire0022'/></td>
          <td align="left">
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("fire_status", -1,"TrueOrFalse","","",false) %>
          </td>
    </tr>  
     <tr>
          <td align="left"><fmt:message key='listFire0023'/></td>
          <td align="left">
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("hire_fire_status_bd", -1,"FIRE_STATUS_BD","0","onchange='fire_stauts(this)'",true) %>
          </td>
          <td align="left"><fmt:message key='listFire0024'/></td>
          <td align="left">
               <w:date allowInput="true" id="apply_off_post_date_from" name="apply_off_post_date_from" format="YYYY-MM-DD" style="width:70px;"/>
               &nbsp;<fmt:message key='listFire0021'/>&nbsp;
               <w:date allowInput="true" id="apply_off_post_date_to" name="apply_off_post_date_to" format="YYYY-MM-DD" style="width:70px;"/>
          </td>
          <td align="left"><fmt:message key='listFire0064'/>名称</td>
          <td align="left">
              <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listFire0064'/>名称" value="" maxLength="50"/>
          </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key='listFire0028'/></td>
            <td align="left">
                <input type="text" class="text_field" name="big_name" inputName="<fmt:message key='listFire0028'/>" value="" maxLength="50" />      
          </td>
          <td align="left">反馈状态</td>
          <td align="left">
          <d:select dictTypeId="FEEDBACK_STATE" id="p_fire_feedback_state" name="p_fire_feedback_state"  nullLabel="--请选择--"></d:select> 
          </td>
          <td align="left">退工提交时间</td>
          <td align="left">
             <w:date allowInput="true" id="fire_handle_submit_date_from" name="fire_handle_submit_date_from" format="YYYY-MM-DD" style="width:70px;"/>
             &nbsp;<fmt:message key='listFire0021'/>&nbsp;
             <w:date allowInput="true" id="fire_handle_submit_date_to" name="fire_handle_submit_date_to" format="YYYY-MM-DD" style="width:70px;"/>
          </td>
    </tr>   
    <tr>
        <td align="left">是否收到退工单</td>
        <td align="left">
        	<d:select dictTypeId="IS_NOT_RECEIVED" id="is_not_received" name="is_not_received" nullLabel="--请选择--"/>      
        </td>
        	<!-- tangyong 增加专员查询条件 start -->
       <td align="left">专员</td>
           <td align="left">
              <r:comboSelect id="user_id"  name="user_id"
                queryAction="/FAERP/FaerpEmployeeAction.do?cmd=getListzhuanlist"
                textField="user_name" 
                valueField="user_id" 
                xpath="EmployeeVo"
                nullText="--请选择--"
                width="205px" >
            </r:comboSelect> 
          </td>  
           	<!-- tangyong 增加专员查询条件 start --> 
           	  <td align="left">办理阶段</td>
           <td align="left">
              <select name="person_name" id="person_name" style="width:210">
                     <option value ="">请选择</option>
                     <option value="0">IA</option>
                     <option value="1">MW</option>
               </select>
          </td>
     </tr> 
     <tr>        
        <td align="left"></td>
        <td align="left">
           <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
           <input type="reset" class="icon_1"   type="button" value="<fmt:message key='listFire0030'/>" >
        </td>
    </tr>        
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right" id="div_button_0" style="display: block;"><!--
	 <ul>
	   <li class="bl_1"><a href="#" onClick="javascript:firehandle()"><fmt:message key='listFire0011'/></a></li>
	  
	   
	   <li class="nbl_1"><a href="#" onClick="javascript:firenothandle()"><fmt:message key='listFire0032'/></a></li>
	   
	   <li class="tb_1" id="cancelli"><a href="#" id="cancel" onClick="javascript:cancelfire()"><fmt:message key='listFire0033'/></a></li>
	  
	   <li class="a_2"><a href="#" onClick="javascript:tolabor()"><fmt:message key='listFire0034'/></a></li>
	   <li class="dj_1"><a href="#" onClick="javascript:fireProve()"><fmt:message key='listFire0035'/></a></li>
	   <li class="e"><a href="#" onclick="javascript:exportexcel()"><fmt:message key='listFire0036'/></a></li>
	   <li class="h_1"><a href="#" onclick="batchfire()"><fmt:message key='listFire0037'/></a></li>
	 </ul>                
-->
<input class="bl_1" type="button"   value="<fmt:message key='listFire0011'/>"  <au:authorityBtn code="tgbl_tgbl" type="1"/>  onClick="firehandle();">
<input class="a_2" type="button"   value=" <fmt:message key='listFire0034'/>"  <au:authorityBtn code="view_Ldht1" type="1"/>  onClick="tolabor();">
<input class="dj_1" type="button"   value="<fmt:message key='listFire0035'/>"  <au:authorityBtn code="tgbl_tgzm" type="1"/>  onClick="fireProve();">
<input class="e" type="button"   value=" <fmt:message key='listFire0036'/>"  <au:authorityBtn code="tgbl_exp" type="1"/>  onClick="exportexcel();">
<input class="h_1" type="button"   value=" <fmt:message key='listFire0037'/>"  <au:authorityBtn code="tgbl_batch_tg" type="1"/>  onClick="batchfire();">
<input class="i" type="button" value="未收到退工单" onClick="isNotReceived();">
<input class="r" type="button" id="elfFireHand" name="elfFireHand" value="精灵之手">
<input class="i"  type="button" id="elfFireHand_td" name="elfFireHand" value="精灵之手套打">
<input class="r" type="button"   value=" 线路转换 "  onClick="getEmpId2();">
<input class="i"  type="button" onClick="uavhandle();" value="加急处理">
</div>
<div class="button_right" id="div_button_1" style="display: none;">
    <!--<ul>
        <li class="bl_1"><a href="#" onClick="javascript:firehandle()"><fmt:message key='listFire0011'/></a></li>
       
       <li class="nbl_1"><a href="#" onClick="javascript:firenothandle()"><fmt:message key='listFire0032'/></a></li>
       
       
       <li class="tb_1" id="cancelli"><a href="#" id="cancel"   onClick="javascript:cancelfire()"><fmt:message key='listFire0033'/></a></li>
       <li class="a_2"><a href="#"   onClick="javascript:tolabor()"><fmt:message key='listFire0034'/></a></li>
       <li class="dj_1"><a href="#"  onClick="javascript:fireProve()"><fmt:message key='listFire0035'/></a></li>
       <li class="e"><a href="#"  onclick="javascript:exportexcel()"><fmt:message key='listFire0036'/></a></li>
       
       <li class="h_1"><a href="#" onclick="batchfire()"><fmt:message key='listFire0037'/></a></li>
    </ul>
-->
<input class="tb_1" type="button"   value=" <fmt:message key='listFire0033'/>"  <au:authorityBtn code="tgbl_cancel" type="1"/>  onClick="cancelfire();">
<input class="a_2" type="button"   value=" <fmt:message key='listFire0034'/>"  <au:authorityBtn code="view_Ldht1" type="1"/>  onClick="tolabor();">
<input class="dj_1" type="button"   value="<fmt:message key='listFire0035'/>"  <au:authorityBtn code="tgbl_tgzm" type="1"/>  onClick="fireProve();">
<input class="e" type="button"   value=" <fmt:message key='listFire0036'/>"  <au:authorityBtn code="tgbl_exp" type="1"/>  onClick="exportexcel();">
</div>
<!--<div class="button_right" id="div_button_2" style="display: none;">
    <ul>
	    <li class="bl_1"><a href="#" onClick="javascript:firehandle()"><fmt:message key='listFire0011'/></a></li>
       
       <li class="nbl_1"><a href="#" onClick="javascript:firenothandle()"><fmt:message key='listFire0032'/></a></li>
       
       <li class="tb_1" id="cancelli"><a href="#" id="cancel" onClick="javascript:cancelfire()"><fmt:message key='listFire0033'/></a></li>
       <li class="a_2"><a href="#" onClick="javascript:tolabor()"><fmt:message key='listFire0034'/></a></li>
       <li class="dj_1"><a href="#" onClick="javascript:fireProve()"><fmt:message key='listFire0035'/></a></li>
       <li class="e"><a href="#" onclick="javascript:exportexcel()"><fmt:message key='listFire0036'/></a></li>
       <li class="h_1"><a href="#" onclick="batchfire()"><fmt:message key='listFire0037'/></a></li>
    </ul>
</div>  
--><div class="clear"></div>            
</div>
<div style="padding: 8 10 8 8;">
<!-- 如果新增删除列表内容请通知精灵之手项目组 -->
 <r:datacell id="datacell1" queryAction="/FAERP/HirefireAction.do?cmd=queryFireData" width="98%" height="318px" xpath="HirefireVo" paramFormId="datacell_formid">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <!--<r:field fieldName="id" messagekey='listFire0061' width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>-->
    <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
    </r:field>
    <r:field fieldName="emp_id" label="<fmt:message key='listFire0062'/>ID" width="0px"></r:field>
    <r:field fieldName="emp_post_id" label="<fmt:message key='listFire0063'/>ID" width="0px"></r:field>
    <r:field fieldName="cust_id" label="<fmt:message key='listFire0064'/>ID" width="0px"></r:field>
    <r:field fieldName="fire_feedback_state"  label="反馈状态" width="70px" allowModify="false">
		<d:select dictTypeId="FEEDBACK_STATE"></d:select> 
	</r:field>
    <r:field fieldName="fire_feedback_info" label="反馈信息" width="140px"></r:field>
    <r:field fieldName="emp_name" label="<fmt:message key='listFire0062'/>姓名" onRefreshFunc="setEmp"></r:field>
    <r:field fieldName="emp_code" messagekey='listFire0015'></r:field>
    <r:field fieldName="id_card" messagekey='listFire0067'></r:field> 
    <r:field fieldName="bigname" messagekey='listFire0068' width="180px;"></r:field>
    <r:field fieldName="cust_name" label="客户名称" width="150px;"></r:field>
    <r:field fieldName="cust_code" label="客户编号" width="150px;"></r:field>
    <r:field fieldName="social_unit" messagekey='listFire0018' allowModify="false">
        <r:comboSelect id="com2" queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit" textField="hire_unit_short_name" 
         valueField="id" xpath="SocialunitVo" nullText="<fmt:message key='listFire0019'/>"></r:comboSelect> 
    </r:field>
    <r:field fieldName="off_post_date" messagekey='listFire0020' allowModify="false">
        <w:date format="YYYY-MM-DD"/>
    </r:field>
    <r:field fieldName="apply_off_post_date" messagekey='listFire0073' allowModify="false">
        <w:date format="YYYY-MM-DD"/>
    </r:field>
    <r:field fieldName="stop_reason_bd" sortAt="none" messagekey='listFire0074' width="100px" allowModify="false">
            <d:select dictTypeId="OFF_POST_REASON" nullLabel="<fmt:message key='listFire0019'/>"/>  
	      </r:field>
    <r:field fieldName="fire_handle_date" messagekey='listFire0076'>
        <w:date format="YYYY-MM-DD" name="fire_handle_date" id="fire_handle_date" onSelectFunc="batch_change_date"/>
    </r:field>   

  
    <r:field fieldName="cs_name" messagekey='listFire0080'></r:field>
    
    <r:field fieldName="off_post_desc" messagekey='listFire0081'></r:field>
    <r:field fieldName="back_reason" messagekey='listFire0083'>
        <h:text name="back_reason" value="" />
    </r:field>
    <r:field fieldName="cancel_reason" messagekey='listFire0084'>
        <h:text name="cancel_reason" value=""/>
    </r:field>
    <r:field fieldName="fire_memo" messagekey='listFire0085'>
        <h:text name="fire_memo" value=""/>
    </r:field>
    <r:field fieldName="id" label="ID" width="0px;"></r:field>
    <r:field fieldName="apply_on_post_date" label='入职时间' allowModify="false">
        <w:date format="YYYY-MM-DD"/>
    </r:field>
    <r:field fieldName="fire_handle_submit_date" label='退工提交时间' allowModify="false">
        <w:date format="YYYY-MM-DD"/>
    </r:field>
    <r:field fieldName="is_not_received" sortAt="none" label='是否未收到退工单' width="100px" allowModify="false">
         <d:select dictTypeId="IS_NOT_RECEIVED"/>  
    </r:field>
     <r:field fieldName="hire_start_date" label='用工时间' width="0px;" allowModify="false">
        <w:date format="YYYY-MM-DD"/>
    </r:field>
    <r:field fieldName="resident_addresss" label='户口所在地' width="0px;"></r:field>
    <r:field fieldName="service_desc" label='入职分类备注' width="0px;"></r:field>
    <r:field fieldName="resident_address1" label='区、县' width="0px;"></r:field>
    <r:field fieldName="resident_address2" label='街道、乡、镇' width="0px;"></r:field>
    <r:field fieldName="resident_address3" label='路' width="0px;"></r:field>
    <r:field fieldName="resident_address4" label='弄、村' width="0px;"></r:field>
    <r:field fieldName="resident_address5" label='号' width="0px;"></r:field>
    <r:field fieldName="resident_address6" label='室、队' width="0px;"></r:field>
    <r:field fieldName="archives_address" label='现档案所在地' width="0px;"></r:field>
    <r:field fieldName="jname" label='组织机构代码' width="0px;"></r:field>
    <r:field fieldName="account" label='员工公积金账号' width="0px;"></r:field>
    <r:field fieldName="bc_account" label='员工补充公积金账号' width="0px;"></r:field>
     <r:field fieldName="uav_line_name" label="办理阶段" sortAt="none"></r:field>
		<r:field fieldName="user_name" label="专员" sortAt="none"></r:field>
		<r:field fieldName="apply_on_post_date" label="用工时间"
			allowModify="false" sortAt="none">
			<w:date format="yyyy-MM-dd" />
		</r:field>
	<r:field fieldName="uav_status" width="0px;" sortAt="none"></r:field>
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
<%  //表单回写
    if(request.getAttribute(IHirefireConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IHirefireConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
