<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%
Map empinfo = request.getAttribute("empinfo")==null?new HashMap():(Map)request.getAttribute("empinfo");
Map firehandle = request.getAttribute("firehandle")==null?new HashMap():(Map)request.getAttribute("firehandle");
//Map hirehandle = request.getAttribute("hirehandle")==null?new HashMap():(Map)request.getAttribute("hirehandle");
Map residentaddress = request.getAttribute("residentaddress")==null?new HashMap():(Map)request.getAttribute("residentaddress");
String post_id = request.getParameter("post_id").toString();
String cust_id = request.getAttribute("cust_id")==null?"":request.getAttribute("cust_id").toString();
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.updateHirefire_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function save(){
        var social_unit = document.form.social_unit.value;
        var action="<%=request.getContextPath()%>/HirefireAction.do?cmd=update";
        var myAjax = new Ajax(action);
        myAjax.addParam('social_unit', social_unit);
        myAjax.addParam('archives_address', document.form.archives_address.value);
        myAjax.addParam('hire_start_date', document.form.hire_start_date.value);
        myAjax.addParam('hire_address', document.form.hire_address.value);
        myAjax.addParam('hire_handle_date', document.form.hire_handle_date.value);
        myAjax.addParam('hire_memo', document.form.hire_memo.value);
        myAjax.addParam('fire_handle_date', document.form.fire_handle_date.value);
        myAjax.addParam('fire_mode_bd', document.getElementById('fire_mode_bd').value);
        myAjax.addParam('fire_resident_address', document.form.fire_resident_address.value);
        myAjax.addParam('fire_memo', document.form.fire_memo.value);
        myAjax.addParam('feedback_info', document.form.feedback_info.value);
        myAjax.addParam('fire_feedback_info', document.form.fire_feedback_info.value);
        myAjax.addParam('transfer_type_bd', document.getElementById('transfer_type_bd').value);
        myAjax.addParam('hirefireId', document.form.hirefireId.value);
        myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
              window.opener.callBack();
         }
        //form.action="<%=request.getContextPath()%>/HirefireAction.do?";
        //form.cmd.value = "update";
       // form.submit();
        //window.close();
    }
    
    function  taoda(){
		  var   social_unit  =  document.getElementById('social_unit_id').value ;
		  var emp_id=document.getElementById('emp_id').value ;  //员工ID  emp_id
		  var emp_post_id=document.getElementById('emp_post_id').value ;
		  var cust_id="<%=cust_id%>";   // <fmt:message key='updateHirefire0000'/>ID
		  var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=getInstCode&social_unit_id="+social_unit+"&cust_id="+cust_id+"&date="+new Date();
	      jQuery.getJSON(url,{"ids":social_unit},  function(json){
             var instCode=json.instCode;
             if(instCode==null||instCode==""||instCode=="undefined"||instCode=="null"){
                   instCode="";
             }
               var join_date = "${hirehandle.hire_start_date}";
			   var file_now = "${hirehandle.archives_address}";
			   var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/hirefire/taodacanshu.jsp?raq=shanghaituigongtaoda.raq&arg1="+emp_id+"&emp_post_id="+emp_post_id+"&arg2="+instCode+"&arg5=10"+"&join_date="+join_date+"&file_now="+file_now;
               showModalCenter(url, window, callBack, 400, 185, "套打参数");
               // $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/taoda.jsp?raq=shanghaituigongtaoda.raq&arg1="+emp_id+"&emp_post_id="+emp_post_id+"&arg2="+instCode+"&arg5=10";
               // $id("datacell_formid").submit();
	      });      
    }
    function callBack()
    {
    
    }
    function close1(){
        window.close();
    }
</script>
</head>
<body>
<form name="form" id="datacell_formid"  method="post" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="false">
<div id="right">
    <!--<script language="javascript">
    writeTableTopFesco('<fmt:message key='updateHirefire0002'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    
 --><div class="ringht_s">
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='updateHirefire0003'/></div>
    <!--表格1-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr><!-- <input type="text" class="text_field" readonly="readonly" value=""/> -->
            <td class="td_1"><fmt:message key='updateHirefire0005'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("emp_name") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0006'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("emp_code") %>"/></td>
            <input type="hidden"  id="emp_id"   class="text_field" value="<%=empinfo.get("id")==null?"":empinfo.get("id") %>"/>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0007'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("id_card") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0008'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("cust_name") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0009'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("resident_addresss") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0010'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("apply_on_post_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0011'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("start_date") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0012'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("end_date") %>"/></td>
            </tr>
                      <tr>
            <td class="td_1"><fmt:message key='updateHirefire0013'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("bigname") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0014'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("apply_off_post_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0015'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("on_post_desc") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0016'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("service_desc") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0017'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("province_bd") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0018'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("file_card") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0019'/>1</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("mobile") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0019'/>2</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("tel") %>"/></td>
            </tr>
                      <tr>
            <td class="td_1"><fmt:message key='updateHirefire0021'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("address") %>"/></td>
            <td class="td_1">E_MAIL</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("email") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0022'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("position") %>"/></td>
            <td class="td_1">查档日期</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${empinfo.feedback_date}"/><input type="hidden" class="text_field" name="emp_post_id" value="<%=post_id %>"/></td>
          </tr>
          
          <tr>
            <td class="td_1">调档反馈信息</td>
            <td class="td_2">
            <textarea name="feedback_message" rows="3" class="xText_d" readonly="readonly">${empinfo.feedback_message }</textarea>
            </td>
            <td class="td_1">反馈状态</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${empinfo.fire_feedback_state}"/></td>
          </tr>
          
        </table>
    </div>
    <!--表格1 end-->
        </div>
    </td>
    </tr>
</table>
    

    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='updateHirefire0024'/></div>
        <!--表格3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0026'/></td>
            <td class="td_2">
            <input type="hidden" id="social_unit_id" value="${hirehandle.social_unit }">
            <r:comboSelect id="social_unit" name="social_unit" queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew" textField="hire_unit_short_name" 
             valueField="id" xpath="SocialunitVo" property="social_unit" nullText="--请选择--"></r:comboSelect> 
            <!--<faerp:SoialunitSelectTag tagname="social_unit" beanname="social_unit" />--></td>
            <td class="td_1"><fmt:message key='updateHirefire0028'/></td>
            <td class="td_2"><input type="text" class="text_field" name="archives_address" value="${hirehandle.archives_address }<%//=hirehandle.get("archives_address") %>" /></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0029'/></td>
            <td class="td_2"><w:date allowInput="true" id="hire_start_date" name="hire_start_date" format="YYYY-MM-DD" property="hirehandle/hire_start_date"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0030'/></td>
            <td class="td_2"><input type="text" class="text_field" name="hire_address" value="${hirehandle.hire_address }<%//=hirehandle.get("hire_address") %>" /></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0031'/></td>
            <td class="td_2"><w:date allowInput="true" id="hire_handle_date" name="hire_handle_date" format="YYYY-MM-DD" property="hirehandle/hire_handle_date"/> </td>
            <td class="td_1"></td>
            <td class="td_2"></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0032'/></td>
            <td class="td_2">
            <input type="text" class="text_field" name="hire_memo" value="${hirehandle.hire_memo }<%//=hirehandle.get("hire_memo") %>" />
            <input type="hidden" name="hirefireId" value="${hirehandle.id }">
            </td>
            
             <td class="td_1">用工反馈信息</td>
            <td class="td_2">
            <input type="text" class="text_field" name="feedback_info" value="${hirehandle.feedback_info }" />
            </td>
            
            </tr>
        </table>
    </div>
    <!--表格3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='updateHirefire0034'/></div>
        <!--表格3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0036'/></td>
            <td class="td_2"><w:date allowInput="true" id="fire_handle_date" name="fire_handle_date" format="YYYY-MM-DD" property="firehandle/fire_handle_date"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0037'/></td>
            <td class="td_2">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("fire_mode_bd", -1,"FIRE_MODE_BD",firehandle.get("fire_mode_bd").toString(),"",false) %></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0038'/></td>
            <td class="td_2"><input type="text" class="text_field" name="fire_resident_address" value="<%=firehandle.get("fire_resident_address") %>"/></td>
            <td class="td_1"></td>
            <td class="td_2"></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0039'/></td>
            <td class="td_2"><textarea name="fire_memo" rows="3" class="xText_d" ><%=firehandle.get("fire_memo") %></textarea></td>
            
            <td class="td_1">退工反馈信息</td>
            <td class="td_2"><textarea name="fire_feedback_info" rows="3" class="xText_d" >${hirehandle.fire_feedback_info }</textarea></td>
            </tr>
        </table>
    </div>
    <!--表格3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title">
          <LABEL><fmt:message key='updateHirefire0041'/></LABEL>
        </div>
        <!--表格3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0043'/></td>
            <td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("transfer_type_bd", -1,"TRANSFER_TYPE_BD",firehandle.get("transfer_type_bd").toString().trim(),"",false) %></td>
         </tr>
       </table>
    </div>
    <!--表格3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='updateHirefire0045'/></div>
        <!--表格3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0047'/>、<fmt:message key='updateHirefire0048'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address1") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0049'/>、<fmt:message key='updateHirefire0050'/>、<fmt:message key='updateHirefire0051'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address2") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0052'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address3") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='updateHirefire0053'/>、<fmt:message key='updateHirefire0054'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address4") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0055'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address5") %>"/></td>
            <td class="td_1"><fmt:message key='updateHirefire0056'/>、<fmt:message key='updateHirefire0057'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address6") %>"/></td>
            </tr>
          
        </table>
    </div>
    <!--表格3 end-->
        </div>
    </td>
    </tr>
</table>
    <div class="foot_button">
      <input  type="button" class="foot_icon_1" value="<fmt:message key='updateHirefire0059'/>" onclick="save();"/>
      <input  type="button" class="foot_icon_1" value="套打" onclick="taoda();"/>
      <input  type="button" class="foot_icon_1" value="<fmt:message key='updateHirefire0061'/>" onclick="close1();"/>
    </div>
        
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>