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
String emp_code = request.getAttribute("emp_code")==null?"":request.getAttribute("emp_code").toString();
String cust_id = request.getAttribute("cust_id")==null?"":request.getAttribute("cust_id").toString();
String c_email=request.getAttribute("c_email")==null?"":request.getAttribute("c_email").toString();
String user_name = request.getAttribute("user_name")==null?"":request.getAttribute("user_name").toString();
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.fireHandle_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function firesave(){
        var is_fire_prove_bd = $id('is_fire_prove_bd').value;
        var is_laborbook_bd= $id('is_laborbook_bd').value;
        var claim_method = $id('claim_method').value;
         if(is_fire_prove_bd=='1' || is_laborbook_bd=='1'){
            if(claim_method==''||claim_method==null){
                alert("请输入劳动手册和<fmt:message key='fireHandle0069'/>单的<fmt:message key='fireHandle0046'/>！");
                return ;
            }
         }  
	    var action="<%=request.getContextPath()%>/HirefireAction.do?cmd=fireSave";
        var myAjax = new Ajax(action);
        myAjax.addParam('fire_handle_date', document.form.fire_handle_date.value);
        myAjax.addParam('file_card', document.form.file_card.value);
        myAjax.addParam('fire_memo', document.form.fire_memo.value);
        myAjax.addParam('fire_mode_bd', document.getElementById('fire_mode_bd').value);
        myAjax.addParam('fire_resident_address', document.form.fire_resident_address.value);
        myAjax.addParam('is_fire_prove_bd', document.getElementById('is_fire_prove_bd').value);
        myAjax.addParam('is_laborbook_bd', document.getElementById('is_laborbook_bd').value);
        myAjax.addParam('transfer_type_bd', document.getElementById('transfer_type_bd').value);
        myAjax.addParam('emp_post_id', document.form.emp_post_id.value);
        myAjax.addParam('id', document.form.id.value);
        myAjax.addParam('emp_id', document.form.emp_id.value);
        //认领方式
        myAjax.addParam('claim_method', document.getElementById('claim_method').value);
        //拆分过的<fmt:message key='fireHandle0013'/>
        myAjax.addParam('resident_address1', document.getElementById('resident_address1').value);
        myAjax.addParam('resident_address2', document.getElementById('resident_address2').value);
        myAjax.addParam('resident_address3', document.getElementById('resident_address3').value);
        myAjax.addParam('resident_address4', document.getElementById('resident_address4').value);
        myAjax.addParam('resident_address5', document.getElementById('resident_address5').value);
        myAjax.addParam('resident_address6', document.getElementById('resident_address6').value);
        myAjax.addParam('fire_feedback_state', document.getElementById('fire_feedback_state').value);
        myAjax.addParam('fire_feedback_info', document.getElementById('fire_feedback_info').value);
        myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
              window.opener.callBack();
         }
        //form.action="<%=request.getContextPath()%>/HirefireAction.do?";
        //form.cmd.value = "fireSave";
        //form.submit();
        //window.close();
    }
    
    function firehandle(){
        var fire_handle_date = document.form.fire_handle_date.value;
        if(fire_handle_date == null || fire_handle_date == ''){
            alert('办理<fmt:message key='fireHandle0069'/>日期不能为空！');
            return;
        }
        var is_fire_prove_bd = $id('is_fire_prove_bd').value;
        var is_laborbook_bd= $id('is_laborbook_bd').value;
        var claim_method = $id('claim_method').value;
         if(is_fire_prove_bd=='1' || is_laborbook_bd=='1'){
            if(claim_method==''||claim_method==null){
                alert("请输入劳动手册和<fmt:message key='fireHandle0069'/>单的<fmt:message key='fireHandle0046'/>！");
                return ;
            }
         } 
         if(claim_method!=""&&(is_fire_prove_bd==""||is_fire_prove_bd=="0")&&(is_laborbook_bd==""||is_laborbook_bd=="0") ){
         alert("<fmt:message key='fireHandle0003'/>");
         return;
         }
        var action="<%=request.getContextPath()%>/HirefireAction.do?cmd=fireHandle";
        var myAjax = new Ajax(action);
        myAjax.addParam('fire_handle_date', fire_handle_date);
        myAjax.addParam('file_card', document.form.file_card.value);
        myAjax.addParam('fire_memo', document.form.fire_memo.value);
        myAjax.addParam('fire_mode_bd', document.getElementById('fire_mode_bd').value);
        myAjax.addParam('fire_resident_address', document.form.fire_resident_address.value);
        myAjax.addParam('is_fire_prove_bd', document.getElementById('is_fire_prove_bd').value);
        myAjax.addParam('is_laborbook_bd', document.getElementById('is_laborbook_bd').value);
        myAjax.addParam('transfer_type_bd', document.getElementById('transfer_type_bd').value);
        myAjax.addParam('emp_post_id', document.form.emp_post_id.value);
        myAjax.addParam('id', document.form.id.value);
        myAjax.addParam('emp_id', document.form.emp_id.value);
            //认领方式
        myAjax.addParam('claim_method', document.getElementById('claim_method').value);
         //拆分过的<fmt:message key='fireHandle0013'/>
        myAjax.addParam('resident_address1', document.getElementById('resident_address1').value);
        myAjax.addParam('resident_address2', document.getElementById('resident_address2').value);
        myAjax.addParam('resident_address3', document.getElementById('resident_address3').value);
        myAjax.addParam('resident_address4', document.getElementById('resident_address4').value);
        myAjax.addParam('resident_address5', document.getElementById('resident_address5').value);
        myAjax.addParam('resident_address6', document.getElementById('resident_address6').value);
        //客服邮箱
         myAjax.addParam('c_email', '<%=c_email%>');
         //<fmt:message key='fireHandle0009'/>
        myAjax.addParam('emp_name', document.getElementById('emp_name').value);
        myAjax.addParam('emp_code',document.getElementById('emp_code').value);
        myAjax.addParam('id_card',document.getElementById('id_card').value);
        myAjax.addParam('cust_name',document.getElementById('cust_name').value);
        myAjax.addParam('cust_code',document.getElementById('cust_code').value);
        myAjax.addParam('user_name',document.getElementById('user_name').value);
        myAjax.addParam('fire_feedback_state', document.getElementById('fire_feedback_state').value);
        myAjax.addParam('fire_feedback_info', document.getElementById('fire_feedback_info').value);
        myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
              window.opener.callBack();
         }
        //form.action="<%//=request.getContextPath()%>/HirefireAction.do?";
        //form.cmd.value = "fireHandle";
        //form.submit();
        //window.close();
    }
    
    function is_book(){
        if(document.getElementById('is_laborbook_bd').checked){
           document.getElementById('is_laborbook_bd').value = '1';
            //isHidden();
        }else{
            document.getElementById('is_laborbook_bd').value = '0';
            //Hidden();
        }
    }
    
    function is_prove(){
        if(document.getElementById('is_fire_prove_bd').checked){
           document.getElementById('is_fire_prove_bd').value = '1';
            //isHidden();
        }else{
            document.getElementById('is_fire_prove_bd').value = '0';
            //Hidden();
        }
    }
    
    
 function  taoda(){
  var   social_unit  =  document.getElementById('social_unit_id').value ;
  var emp_id=document.getElementById('emp_id').value ;  //员工ID  emp_id
  var emp_post_id=document.getElementById('emp_post_id').value ;  //员工ID  emp_id
  var cust_id="<%=cust_id%>";   // <fmt:message key='fireHandle0004'/>ID
   var url="<%=request.getContextPath()%>/SocialunitAction.do?cmd=getInstCode&social_unit_id="+social_unit+"&cust_id="+cust_id+"&date="+new Date();
     jQuery.getJSON(url,{"ids":social_unit},  function(json){
             var instCode=json.instCode;
             if(instCode==null||instCode==""||instCode=="undefined"||instCode=="null"){
             instCode="";
             }
			            var join_date = "${hirehandle.hire_start_date }";
			            var file_now = "${hirehandle.archives_address}";
			            var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/hirefire/taodacanshu.jsp?raq=shanghaituigongtaoda.raq&arg1="+emp_id+"&emp_post_id="+emp_post_id+"&arg2="+instCode+"&arg5=10"+"&join_date="+join_date+"&file_now="+file_now;
                        showModalCenter(url, window, callBack, 400, 185, "<fmt:message key='fireHandle0005'/>");
			            //$id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/taoda.jsp?raq=shanghaituigongtaoda.raq&arg1="+emp_id+"&emp_post_id="+emp_post_id+"&arg2="+instCode+"&arg5=10";
			            // $id("datacell_formid").submit();
			            //alert(url);
        });      
    }
    
    function callBack(reg){ 
    
    }
    function isHidden(){
     var vDiv = document.getElementById("tr1");
     vDiv.style.display ='block';
    }
     function Hidden(){
     var vDiv = document.getElementById("tr1");
     vDiv.style.display ='none';
    }
    
</script>
</head>
<body>
<form name="form"   id="datacell_formid"  method="post" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="false">
<div id="right"><!--
    <script language="javascript">
    writeTableTopFesco('<fmt:message key='fireHandle0006'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    
 --><div class="ringht_s">
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='fireHandle0007'/></div>
    <!--<fmt:message key='fireHandle0008'/>1-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr><!-- <input type="text" class="text_field" readonly="readonly" value=""/> -->
            <td class="td_1"><fmt:message key='fireHandle0009'/></td>
            <td class="td_2"><input type="text" id="emp_name" class="text_field" readonly="readonly" value="<%=empinfo.get("emp_name")==null?"":empinfo.get("emp_name") %>"/></td>
            <td class="td_1">唯一<fmt:message key='fireHandle0064'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" id="emp_code" name="emp_code" value="<%=empinfo.get("emp_code")==null?"":empinfo.get("emp_code") %>"/></td>
                                         <input type="hidden"  id="emp_id"   class="text_field" readonly="readonly" value="<%=empinfo.get("id")==null?"":empinfo.get("id") %>"/>
                                          <input type="hidden" name="user_name" id="user_name" value="<%=user_name %>">
            </tr>
          <tr>
            <td class="td_1">身份证<fmt:message key='fireHandle0064'/></td>
            <td class="td_2"><input type="text" name="id_card" id="id_card" class="text_field" readonly="readonly" value="<%=empinfo.get("id_card")==null?"":empinfo.get("id_card") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0004'/>名称</td>
            <td class="td_2"><input type="text" class="text_field" name="cust_name" id="cust_name" readonly="readonly" value="<%=empinfo.get("cust_name")==null?"":empinfo.get("cust_name") %>"/>
            <input type="hidden" name="cust_code" id="cust_code" value="<%=empinfo.get("cust_code")==null?"":empinfo.get("cust_code") %>"></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0013'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("resident_addresss")==null?"":empinfo.get("resident_addresss") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0014'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("apply_on_post_date")==null?"":empinfo.get("apply_on_post_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0015'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("start_date")==null?"":empinfo.get("start_date") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0016'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("end_date")==null?"":empinfo.get("end_date") %>"/></td>
            </tr>
                      <tr>
                      <!--  
            <td class="td_1"><fmt:message key='fireHandle0017'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("bigname")==null?"":empinfo.get("bigname") %>"/></td>
            -->
            <td class="td_1"><fmt:message key='fireHandle0018'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("position")==null?"":empinfo.get("position") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0019'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("apply_off_post_date")==null?"":empinfo.get("apply_off_post_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0020'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("on_post_desc")==null?"":empinfo.get("on_post_desc") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0021'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("service_desc")==null?"":empinfo.get("service_desc") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0022'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("pocicy_bd")==null?"":BaseDataHelper.getNameByCode("POCICY_BD",empinfo.get("pocicy_bd").toString())%>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0023'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("file_card")==null?"":empinfo.get("file_card") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0024'/>1</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("mobile")==null?"":empinfo.get("mobile") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0024'/>2</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("tel")==null?"":empinfo.get("tel") %>"/></td>
            </tr>
                      <tr>
            <td class="td_1"><fmt:message key='fireHandle0026'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("address")==null?"":empinfo.get("address") %>"/></td>
            <td class="td_1">E_MAIL</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("email")==null?"":empinfo.get("email") %>"/></td>
            </tr>
            <tr>
            <td class="td_1"><fmt:message key='fireHandle0027'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("off_post_date")==null?"":empinfo.get("off_post_date") %>"/></td>
            <td class="td_1">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
            </tr>
            <input type="hidden" class="text_field" name="emp_post_id" value="<%=empinfo.get("emp_post_id")==null?"":empinfo.get("emp_post_id") %>"/>
        </table>
    </div>
    <!--<fmt:message key='fireHandle0008'/>1 end-->
        </div>
    </td>
    </tr>
</table>
    

    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='fireHandle0029'/></div>
        <!--<fmt:message key='fireHandle0008'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0031'/></td>
            <td class="td_2">
            <input type="hidden" id="id" name="id" value="${hirehandle.id }">
            <input type="hidden" id="social_unit_id" value="${hirehandle.social_unit }">
            <input type="text" class="text_field" readonly="readonly"    id="social_unit"   value="${hirehandle.hire_unit_short_name }<%//=hirehandle.get("social_unit") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0032'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<fmt:formatDate value="${hirehandle.hire_start_date }" pattern="yyyy-MM-dd"/><%//=hirehandle.get("hire_start_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0033'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${hirehandle.archives_address }<%//=hirehandle.get("archives_address") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0034'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${hirehandle.hire_address }<%//=hirehandle.get("hire_address") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0035'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<fmt:formatDate value="${hirehandle.hire_handle_date }" pattern="yyyy-MM-dd"/><%//=hirehandle.get("hire_handle_date") %>"/></td>
            <td class="td_1">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0036'/></td>
            <td colspan="3" class="td_2"><textarea readonly="readonly" rows="3" class="xText_d" id="user4">${hirehandle.hire_memo }<%//=hirehandle.get("hire_memo") %></textarea></td>
            </tr>
        </table>
    </div>
    <!--<fmt:message key='fireHandle0008'/>3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='fireHandle0038'/></div>
        <!--<fmt:message key='fireHandle0008'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><span>*</span>办理<fmt:message key='fireHandle0069'/>日期</td>
            <td class="td_2">
            <w:date allowInput="true" id="fire_handle_date" name="fire_handle_date" format="YYYY-MM-DD" property="firehandle/fire_handle_date" />            
            <td class="td_1"><fmt:message key='fireHandle0069'/>方式</td>
            <td class="td_2">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("fire_mode_bd", -1,"FIRE_MODE_BD",firehandle.get("fire_mode_bd").toString(),"",false) %></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0069'/>户籍地址</td>
            <td class="td_2"><input type="text" class="text_field" name="fire_resident_address" value="<%=firehandle.get("fire_resident_address") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0043'/></td>
            <td class="td_2"><input type="text" class="text_field" name="file_card" value="<%=firehandle.get("file_card") %>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0044'/></td>
            <td class="td_2">
            <%
            String book = firehandle.get("is_laborbook_bd").toString();
            if(book.equals("1")){
                %>
                <input type="checkbox" id="is_laborbook_bd" name="is_laborbook_bd" value="${hirehandle.is_laborbook_bd }" checked="checked" onclick="is_book();">
                <%
            }else{
                %>
                <input type="checkbox" id="is_laborbook_bd" name="is_laborbook_bd" value="${hirehandle.is_laborbook_bd }" onclick="is_book();">
                <%
            }
            %>
            </td>
            <td class="td_1">是否有<fmt:message key='fireHandle0069'/>单</td>
            <td class="td_2">
            <%
            String prove = firehandle.get("is_fire_prove_bd").toString();
            if(prove.equals("1")){
                %>
                <input type="checkbox" name="is_fire_prove_bd" id="is_fire_prove_bd" value="${hirehandle.is_fire_prove_bd }" checked="checked" onclick="is_prove();" />
                <%
            }else{
                %>
                <input type="checkbox" name="is_fire_prove_bd" id="is_fire_prove_bd" value="${hirehandle.is_fire_prove_bd }" onclick="is_prove();" />
                <%
            }
            %>
            
            </td>
            </tr>
            <tr id="tr1">
            <td class="td_1"><fmt:message key='fireHandle0046'/></td>
            <td class="td_2">  
                <d:select dictTypeId="CLAIM_METHOD" name="claim_method" id='claim_method' value="${hirehandle.claim_method }" nullLabel="--请选择--" style="width: 205px"/>
            <td class="td_1">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
          </tr>
          <tr id="tr1">
            <td class="td_1">反馈状态</td>
            <td class="td_2">  
                <d:select dictTypeId="FEEDBACK_STATE" name="fire_feedback_state" id='fire_feedback_state' value="${hirehandle.fire_feedback_state }" nullLabel="--请选择--" style="width: 205px"/>
            <td class="td_1">反馈信息</td>
            <td class="td_2"><input type="text" class="text_field" id="fire_feedback_info" name="fire_feedback_info" value="${hirehandle.fire_feedback_info }"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0069'/>备注</td>
            <td colspan="3" class="td_2"><textarea name="fire_memo" rows="3" class="xText_d" ><%=firehandle.get("fire_memo") %></textarea></td>
            </tr>
        </table>
    </div>
    <!--<fmt:message key='fireHandle0008'/>3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title">
          <LABEL><fmt:message key='fireHandle0069'/>证明</LABEL>
        </div>
        <!--<fmt:message key='fireHandle0008'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0052'/></td>
            <td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("transfer_type_bd", -1,"TRANSFER_TYPE_BD",firehandle.get("transfer_type_bd").toString(),"",false) %></td>
         </tr>
       </table>
    </div>
    <!--<fmt:message key='fireHandle0008'/>3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='fireHandle0054'/></div>
        <!--<fmt:message key='fireHandle0008'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0056'/>、<fmt:message key='fireHandle0057'/></td>
            <td class="td_2"><input type="text" class="text_field"  name="resident_address1" value="<%=residentaddress.get("resident_address1") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0058'/>、<fmt:message key='fireHandle0059'/>、<fmt:message key='fireHandle0060'/></td>
            <td class="td_2"><input type="text" class="text_field" name="resident_address2"  value="<%=residentaddress.get("resident_address2") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0061'/></td>
            <td class="td_2"><input type="text" class="text_field" name="resident_address3" value="<%=residentaddress.get("resident_address3") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='fireHandle0062'/>、<fmt:message key='fireHandle0063'/></td>
            <td class="td_2"><input type="text" class="text_field" name="resident_address4" value="<%=residentaddress.get("resident_address4") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0064'/></td>
            <td class="td_2"><input type="text" class="text_field" name="resident_address5" value="<%=residentaddress.get("resident_address5") %>"/></td>
            <td class="td_1"><fmt:message key='fireHandle0065'/>、<fmt:message key='fireHandle0066'/></td>
            <td class="td_2"><input type="text" class="text_field" name="resident_address6" value="<%=residentaddress.get("resident_address6") %>"/></td>
            </tr>
          
        </table>
    </div>
    <!--<fmt:message key='fireHandle0008'/>3 end-->
        </div>
    </td>
    </tr>
</table>
    <div class="foot_button">
      <input  type="button" class="foot_icon_1" value="<fmt:message key='fireHandle0068'/>" onclick="firesave();"/>
      <input  type="button" class="foot_icon_1" value="<fmt:message key='fireHandle0069'/>" onclick="firehandle();"/>
      <input  type="button" class="foot_icon_1" value="<fmt:message key='fireHandle0070'/>"     onclick="taoda();"           />
      
    </div>
        
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>