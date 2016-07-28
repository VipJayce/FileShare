<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%  //判断是否为修改页面
    EmppostVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;
    if(request.getParameter("isModify") != null) {
        isModify = true;
		if(request.getAttribute("bean") != null) {  //如果request中取出的bean不为空
	  		resultVo = (EmppostVo)request.getAttribute("bean");  //从request中取出vo, 赋值给resultVo
	  	}
    }
%>
<html>
<fmt:bundle basename="rayoo.employeepost.emp_into_resignation_query.emp_into_resignation_query_resource" prefix="rayoo.employeepost.emp_into_resignation_query.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="emp_on_post_modify_page"/></title>
<script language="javascript">
    //不能修改唯一号的保存方法
  	function update_onClick(id){
		if(checkAllForms()){
            var applydate = $id("apply_on_post_date").getValue();
            if(applydate==null || applydate==''){
                alert('<fmt:message key="please_check_in_emp_on_post_date"/>');
                return false;
            }
	        
	      if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
              return false;
          }
          //使用ajax方式提交
	      //form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpIntoResign";
          //form.submit();
		   var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpIntoResign";
            var myAjax = new Ajax(action);
            var form = document.forms[0];
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }           
             myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  if(""+myAjax.getProperty("returnValue")=="修改成功！"){
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  window.opener.showListData();
                  }
             }
		   
    	}
	}
	
	//可以修改唯一号的保存方法，已经作废
	function update_onClick1(id){
        
        if(checkAllForms()){
            
            var emp_code = jQuery("#emp_code").val();
            if(emp_code==null || emp_code.trim()==''){
                alert('<fmt:message key="please_check_in_emp_code"/>');
                return false;
            }
            var applydate = $id("apply_on_post_date").getValue();
            if(applydate==null || applydate==''){
                alert('<fmt:message key="please_check_in_emp_on_post_date"/>');
                return false;
            }
            var default_emp_code = jQuery("#default_emp_code").val();
            if(emp_code!=default_emp_code){
                //验证唯一号是否已被其他员工占用
                jQuery.ajax({
                   url: '<%=request.getContextPath()%>/EmppostAction.do?cmd=checkEmpcode&emp_code='+emp_code+'&date='+new Date()+'',
                   type: 'GET',
                   async: false,
                   dataType: 'html',
                   timeout: 10000,
                   error: function(){
                       alert('Error loading XML document');
                           return  null;
                       },
                   success: function(text){
                       if(text==1){
                             alert('<fmt:message key="please_check_in_again"/>');
                             jQuery("#emp_code").val(default_emp_code);
                             return false;
                       }else{
                            if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
                                return false;
                            }
                            form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpIntoResign";
                            form.submit();
                       }
                   }
               });
           }else{
              if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
                  return false;
              }
              form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpIntoResign";
              form.submit();
           }
            
        }
    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=toListEmpIntoResignationPage";
        //form.submit();
        window.close();
    }
    
</script>
</head>
<body>

<form  name="form" id="datacell_formid" method="post">

<div id="right">
<script language="javascript">
        writeTableTopFesco('<fmt:message key="emp_on_post_modify_page"/>','<%=request.getContextPath()%>/');
</script>

 <div class="ringht_s">
<div id="ccChild0" class="box_3"> 
<div class="xz_title"><fmt:message key="base_info"/></div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" ><fmt:message key="emp_code"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" id="emp_code1" name="emp_code1" inputName="唯一号" value="<%=RmStringHelper.prt(resultVo.getEmp_code()) %>" disabled="disabled"/>			</td>
			    <input type="hidden" name="emp_code" id="emp_code" value="<%=RmStringHelper.prt(resultVo.getEmp_code()) %>"/>
			<td class="td_1" ><fmt:message key="emp_name"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="emp_name" inputName="员工姓名" value="<%=RmStringHelper.prt(resultVo.getEmp_name()) %>" disabled="disabled"/>            </td>
			<td class="td_1" ><fmt:message key="cust_code"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="cust_code" inputName="客户编号" value="<%=RmStringHelper.prt(resultVo.getCust_code()) %>" disabled="disabled"/></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="cust_name"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="cust_name" inputName="客户名称" value="<%=RmStringHelper.prt(resultVo.getCust_name()) %>" disabled="disabled"/></td>
			<td class="td_1" ><fmt:message key="credentials_type"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="id_card_type_bd" inputName="证件类型" value="<%=resultVo.getId_card_type_bd()==null?"":BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",resultVo.getId_card_type_bd())%>" disabled="disabled"/></td>
			<td class="td_1" ><fmt:message key="emp_card_no1"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="id_card" inputName="证件号码" value="<%=RmStringHelper.prt(resultVo.getId_card()) %>" disabled="disabled"/>            </td>
		</tr>
		<tr>
		  <td class="td_1" ><fmt:message key="tel1"/></td>
		  <td class="td_2 "><input type="text" class="text_field" name="contact_tel1" inputName="电话" value="<%=RmStringHelper.prt(resultVo.getContact_tel1()) %>" disabled="disabled"/>          </td>
			<td class="td_1" ><fmt:message key="mobile1"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="mobile" inputName="手机" value="<%=RmStringHelper.prt(resultVo.getMobile()) %>" disabled="disabled"/>            </td>
			<td class="td_1" ><fmt:message key="cust_send_name"/></td>
			<td class="td_2">
			  <input type="text" class="text_field" name="cust_send_name" inputName="委派单位" value="<%=RmStringHelper.prt(resultVo.getCust_send_name()) %>" disabled="disabled"/>
			</td>
		</tr>
		<tr>
		  <td class="td_1" ><fmt:message key="cust_receive_id"/></td>
		  <td class="td_2">
            <input type="text" class="text_field" name="cust_receive_name" inputName="接收单位" value="<%=RmStringHelper.prt(resultVo.getCust_receive_name()) %>" disabled="disabled"/>
          </td>
		  <td class="td_1" ><fmt:message key="emp_type"/></td>
			<td class="td_2 "><input type="text" class="text_field" inputName="员工类别" value="<%=resultVo.getEmp_post_type_bd()==null?"":BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",resultVo.getEmp_post_type_bd())%>" disabled="disabled"/></td>
			<td class="td_1" >&nbsp;</td>
			<td class="td_2 ">&nbsp;</td>
		</tr>
	</table>
	<p></p>
    <div class="xz_title"><fmt:message key="post_info"/></div>
	<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="20%" class="td_1" ><fmt:message key="send"/></td>
			<td width="20%" class="td_2 ">
		  <input type="text" class="text_field" name="send_name" inputName="委派单" value="<%=RmStringHelper.prt(resultVo.getSend_name()) %>" disabled="disabled" /></td>
			<td class="td_1" ><fmt:message key="internal_code"/></td>
			<td class="td_2 "><input type="text" class="text_field" name="internal_code" inputName="客户方编号" value="<%=RmStringHelper.prt(resultVo.getInternal_code()) %>" maxLength="64" />            </td>
			<td class="td_1" ><fmt:message key="status_name"/></td>
			<td class="td_2 "><%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd", -1, "POST_STATUS_BD", resultVo.getPost_status_bd(), "", false) %></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fee_begin"/></td>
			<td class="td_2 ">
		      <!--<input type="text" class="text_field_reference_readonly" name="charge_start_date" id="charge_start_date" inputName="收费开始" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(),10) %>"/>
                <img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('charge_start_date','<venus:base/>/');"/>-->
		      <w:date format="yyyy-MM-dd" id="charge_start_date" name="charge_start_date" property="bean/charge_start_date" width="200px"/>
		    </td>
			<td class="td_1" ><fmt:message key="fee_end"/></td>
			<td class="td_2 ">
                <!--<input type="text" class="text_field_reference_readonly" name="charge_end_date" id="charge_end_date" inputName="收费截止" value="<%=RmStringHelper.prt(resultVo.getCharge_end_date(),10) %>"/>
                <img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('charge_end_date','<venus:base/>/');"/>-->
                <w:date format="yyyy-MM-dd" id="charge_end_date" name="charge_end_date" property="bean/charge_end_date" width="200px"/>
            </td>
			<td class="td_1" ><fmt:message key="apply_on_post_date"/></td>
			<td class="td_2 ">
                <!--<input type="text" class="text_field_reference_readonly" name="apply_on_post_date" id="apply_on_post_date" inputName="入职时间" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(),10) %>"/>
                <img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date','<venus:base/>/');"/>-->
                <w:date allowNull="false" format="yyyy-MM-dd" id="apply_on_post_date" name="apply_on_post_date" property="bean/apply_on_post_date" width="200px"/>
            </td>
		</tr>
		<tr>
		  <td class="td_1" ><fmt:message key="on_post_date"/></td>
		  <td class="td_2 ">
             <input type="text" class="text_field" name="on_post_date" id="on_post_date" inputName="入职时间" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(),19) %>"/>
          </td>
		  <td class="td_1" ><fmt:message key="on_post_user_id"/></td>
		  <td class="td_2" >
		      <input type="text" class="text_field" name="on_post_user_name" inputName="报入职人" value="<%=RmStringHelper.prt(resultVo.getOn_post_user_name()) %>" disabled="disabled"/>
		  </td>
		  
          <td class="td_1"><fmt:message key="emp_entry"/></td>
          <td class="td_2"><d:select name="emp_entry_bd" id="emp_entry_bd" dictTypeId="EMP_ENTRY_BD" property="bean/emp_entry_bd" style="width: 205px"/></td>
	    </tr>
		<tr>
		  <td class="td_1" >社保福利办理方</td>
          <td class="td_2" ><r:comboSelect id="security_unit_id" name="security_unit_id"
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose"
                                value="<%=RmStringHelper.prt(resultVo.getSecurity_unit_id()) %>">
                            </r:comboSelect>        </td>
          <td class="td_1" >公积金福利办理方</td>
          <td class="td_2" ><r:comboSelect id="fund_security_unit_id" name="fund_security_unit_id"
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose"
                                value="<%=RmStringHelper.prt(resultVo.getFund_security_unit_id()) %>">
                            </r:comboSelect>        </td>
          <td class="td_1" >用退工福利办理方</td>
          <td class="td_2" ><r:comboSelect id="hire_security_unit_id" name="hire_security_unit_id"
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose"
                                value="<%=RmStringHelper.prt(resultVo.getHire_security_unit_id()) %>">
                            </r:comboSelect>        </td>
        </tr>
        <tr>
          <td class="td_1" ><fmt:message key="is_import_client"/></td>
          <td class="td_2" ><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_import_client", -1, "IS_PHYSICAL_EXAM", resultVo.getIs_import_client(), "", false) %></td>
          <td class="td_1" ><fmt:message key="on_post_desc"/></td>
		  <td colspan="3" class="td_2 "><textarea rows="3" name="on_post_desc" style="width: 340px" inputName="入职备注" maxLength="100"><%=RmStringHelper.prt(resultVo.getOn_post_desc()) %></textarea></td>
	    </tr>
		<tr>
		  <td class="td_1" ><fmt:message key="off_post_date1"/></td>
		  <td class="td_2 ">
		          <!--<input type="text" class="text_field_reference_readonly" name="apply_off_post_date" id="apply_off_post_date" inputName="离职时间" value="<%=RmStringHelper.prt(resultVo.getApply_off_post_date(),10) %>"/>
                <img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_off_post_date','<venus:base/>/');"/>-->
		      <%if(resultVo.getApply_off_post_date() != null){%>
		         <w:date format="yyyy-MM-dd" name="apply_off_post_date" property="bean/apply_off_post_date" width="200px"/>
		      <%} else{%>
		          <input type="text" class="text_field" name="apply_off_post_date" id="apply_off_post_date" inputName="离职时间" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getApply_off_post_date(),19) %>"/>
		         <!--<w:date format="yyyy-MM-dd" name="apply_off_post_date" property="bean/apply_off_post_date" width="200px" disabled="disabled"/>-->
		      <%}%>
		  </td>
		  <td class="td_1" ><fmt:message key="off_post_date"/></td>
		  <td class="td_2" >
            <input type="text" class="text_field" name="off_post_date" id="off_post_date" inputName="离职时间" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getOff_post_date(),19) %>"/>
         </td>
		  <td class="td_1" ><fmt:message key="off_post_user_id"/></td>
          <td class="td_2 "><input type="text" class="text_field" name="off_post_user_name" inputName="报离职人" value="<%=RmStringHelper.prt(resultVo.getOff_post_user_name()) %>" disabled="disabled"/></td>
          
	    </tr>
		<tr>
		  <td class="td_1" ><fmt:message key="off_post_reason"/></td>
          <td class="td_2" >
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("off_post_reason", -1,"OFF_POST_REASON", RmStringHelper.prt(resultVo.getOff_post_reason()), "style='width:210'", false) %>
              <!-- <input type="text" class="text_field" name="off_post_reason" inputName="离职原因" value="<%=BaseDataHelper.getNameByCode("OFF_POST_REASON",RmStringHelper.prt(resultVo.getOff_post_reason()))%>" maxLength="100" /> -->
          </td>
          <td class="td_1" ><fmt:message key="ge_off_post_reason"/></td>
          <td class="td_2" >
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("ge_off_post_reason", -1,"GE_OFF_POST_REASON", RmStringHelper.prt(resultVo.getGe_off_post_reason()), "style='width:210'", false) %>
              <!-- <input type="text" class="text_field" name="ge_off_post_reason" inputName="GE离职原因" value="<%=BaseDataHelper.getNameByCode("GE_OFF_POST_REASON",RmStringHelper.prt(resultVo.getGe_off_post_reason()))%>" maxLength="100" /> -->
          </td>
		  <td class="td_1" >是否线上</td>
		  <td class="td_2" >
		      <%=gap.rm.tools.helper.RmJspHelper.getSelectField("isonline", -1,"TrueOrFalse", RmStringHelper.prt(resultVo.getIsonline()), "style='width:210'", false) %>
		  </td>
	    </tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_desc"/></td>
			<td colspan="5" class="td_2 "><textarea rows="3" name="off_post_desc" style="width: 340px" inputName="离职备注" maxLength="100"><%=RmStringHelper.prt(resultVo.getOff_post_desc()) %></textarea></td>
		</tr>
	</table>
	
 
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />
        <input type="button" class="foot_icon_1" value='<fmt:message key="close"/>'  onClick="javascript:cancel_onClick()"/>
      </div>
</div>
</div>         
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />
<input type="hidden" name="postid" id="postid" value="<%=resultVo.getId() %>">
<input type="hidden" name="empid" id="empid" value="<%=resultVo.getEid() %>">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
