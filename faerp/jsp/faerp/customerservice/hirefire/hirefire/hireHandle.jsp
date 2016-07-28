
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
<%
Map empinfo = request.getAttribute("empinfo") == null?new HashMap():(Map)request.getAttribute("empinfo");
String post_id = request.getAttribute("post_id")==null?"":request.getAttribute("post_id").toString();
HirefireVo ftemp=request.getAttribute("handleinfo")==null?new HirefireVo():(HirefireVo)request.getAttribute("handleinfo");
String fselect=ftemp.getArchives_address()==null?"":ftemp.getArchives_address().toString();
String f1select=ftemp.getHire_address()==null?"":ftemp.getHire_address();
%>
<%@page import="rayoo.customerservice.hirefire.hirefire.vo.HirefireVo"%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.hireHandle_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='hireHandle0000'/></title>
<script type="text/javascript">
_$(document).ready(function(){
    //<fmt:message key='hireHandle0000'/>的<fmt:message key='hireHandle0082'/>按钮 
});
if (${msg != null && msg != '' }) {
    if (${msg == '1' }) {
        alert('此<fmt:message key='hireHandle0002'/>异常。');
        window.close();
    } else {
        alert('${msg }');
    }
}
</script>
<script language="javascript" src="<venus:base/>/jsp/faerp/customerservice/hirefire/hirefire/listhire.js"></script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="false">
 <input type="hidden" name="post_id" value="<%=post_id %>">
<div id="right">    
 <div class="ringht_s">
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox" style="cursor:hand">
        <div class="xz_title" onClick="isHidden('div1')"><fmt:message key='hireHandle0002'/></div>
    <!--<fmt:message key='hireHandle0003'/>1-->
    <div class="box_3" id="div1">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1">
                <fmt:message key='hireHandle0004'/>
                <input type="hidden" name="employee_id" value="<%=empinfo.get("employee_id") %>"/>
            </td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("emp_name") %>"/></td>
            <td class="td_1"><fmt:message key='hireHandle0005'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("emp_code") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0006'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("id_card") %>"/></td>
            <td class="td_1"><fmt:message key='hireHandle0007'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("cust_name") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0008'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("apply_on_post_date") %>"/></td>
            <td class="td_1"><fmt:message key='hireHandle0009'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("start_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0010'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("end_date") %>"/></td>
            <td class="td_1"><fmt:message key='hireHandle0011'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("service_desc") %>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0012'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("on_post_desc") %>"/></td>
            <td class="td_1"><fmt:message key='hireHandle0013'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("pocicy_bd") %>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0014'/></td>
            <td class="td_2"><input type="text" class="text_field" name="resident_addresss" value="${empinfo.resident_addresss == 'null' ?'' :  empinfo.resident_addresss}"/></td>
            <td class="td_1"><fmt:message key='hireHandle0015'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="<%=empinfo.get("position") %>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0016'/></td>
            <td class="td_2"><input type="text" class="text_field" name="emp_archives_address" value="${handleinfo.emp_archives_address  == 'null' ?'' :  handleinfo.emp_archives_address}"/></td>
            <td class="td_1"><fmt:message key='hireHandle0017'/></td>
            <td class="td_2"><input type="text" class="text_field" style="background:#f0f0f0;" readonly="readonly" value="${handleinfo.is_tiaodang} "/></td>
            </tr>
        </table>
    </div>
    <!--<fmt:message key='hireHandle0003'/>1 end-->
        </div>
    </td>
    </tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox"  >
        <div class="xz_title" style="cursor:hand"  onClick="isHidden('div3')"><fmt:message key='hireHandle0019'/></div>
        <input type="hidden" name="hfid" id="hfid" value="${handleinfo.id }">
        <!--<fmt:message key='hireHandle0003'/>3-->
    <div class="box_3" id="div3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><span class="style_required_red">*</span><fmt:message key='hireHandle0021'/></td>
            <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit" beanname="social_unit"/></td>
            <td class="td_1"><fmt:message key='hireHandle0022'/></td>
            <td class="td_2"><!-- <input type="text" class="text_field" name="archives_address2222" value="${handleinfo.archives_address }" /> -->
                                         <!--   <d:select dictTypeId="H_ARCHIVES_ADDRESS" id="archivesaddress1" name="archives_address"  value="${handleinfo.archives_address}"></d:select>
                                           <select id="archivesaddress" name="archives_address" onkeydown="Select12.del(this,event)" onkeypress="Select12.write(this,event)" onchange="doChange()">-->
                                      <!--      <select id="archivesaddress" name="archives_address"  onchange="doChange()">
                                           <option value="" ></option>
                                      -->       
                                           
                                     <select id="archivesaddress"  name="archives_address" onkeydown="catch_keydown(this)" onkeypress="catch_press(this)" onfocus="catch_focus(this)">
                                            <option value=''>--<fmt:message key='hireHandle0023'/>--</option>
                                            <option value='<fmt:message key='hireHandle0024'/>'><fmt:message key='hireHandle0024'/></option>
                                            <option value='<fmt:message key='hireHandle0025'/>'><fmt:message key='hireHandle0025'/></option>
                                            <option value='<fmt:message key='hireHandle0026'/>'><fmt:message key='hireHandle0026'/></option>
                                            <option value='<fmt:message key='hireHandle0027'/>'><fmt:message key='hireHandle0027'/></option>
                                            <option value='<fmt:message key='hireHandle0028'/>'><fmt:message key='hireHandle0028'/></option>
                                            <option value='<fmt:message key='hireHandle0029'/>'><fmt:message key='hireHandle0029'/></option>
                                            <option value='<fmt:message key='hireHandle0039'/>区人才服务中心'><fmt:message key='hireHandle0039'/>区人才服务中心</option>
                                            <option value='<fmt:message key='hireHandle0043'/>区人才服务中心'><fmt:message key='hireHandle0043'/>区人才服务中心</option>
                                            <option value='<fmt:message key='hireHandle0048'/>区人才服务中心'><fmt:message key='hireHandle0048'/>区人才服务中心</option>
                                            <option value='<fmt:message key='hireHandle0033'/>'><fmt:message key='hireHandle0033'/></option>
                                            <option value='<fmt:message key='hireHandle0034'/>'><fmt:message key='hireHandle0034'/></option>
                                            <option value='<fmt:message key='hireHandle0039'/>职介'><fmt:message key='hireHandle0039'/>职介</option>
                                            <option value='<fmt:message key='hireHandle0052'/>职介'><fmt:message key='hireHandle0052'/>职介</option>

           </select>         
           <span id="archId"></span>                      
            </td>
            </tr>
          <tr>
            <td class="td_1"><span class="style_required_red">*</span><fmt:message key='hireHandle0037'/></td>
            <td class="td_2">
            <w:date allowInput="true" id="hire_start_date" name="hire_start_date" format="yyyy-MM-dd" style="width:90px;" property="empinfo/apply_on_post_date"/>
            </td>
            <td class="td_1"><fmt:message key='hireHandle0038'/></td>
            <td class="td_2"><!--  <input type="text" class="text_field" name="hire_address" value="${handleinfo.hire_address }" />-->
                                           <!-- <d:select dictTypeId="H_HIRE_ADDRESS" id="hireaddress" name="hire_address"  value="${handleinfo.hire_address }"></d:select> --> 
                                       <select  id="hireaddress" name="hire_address" onkeydown="Select12.del(this,event)" onkeypress="Select12.write(this,event)" >
                                            <option value=''>--<fmt:message key='hireHandle0023'/>--</option>
                                            <option value='<fmt:message key='hireHandle0039'/>'><fmt:message key='hireHandle0039'/></option>
                                            <option value='<fmt:message key='hireHandle0040'/>'><fmt:message key='hireHandle0040'/></option>
                                            <option value='<fmt:message key='hireHandle0041'/>'><fmt:message key='hireHandle0041'/></option>
                                            <option value='<fmt:message key='hireHandle0042'/>'><fmt:message key='hireHandle0042'/></option>
                                            <option value='<fmt:message key='hireHandle0043'/>'><fmt:message key='hireHandle0043'/></option>
                                            <option value='<fmt:message key='hireHandle0044'/>'><fmt:message key='hireHandle0044'/></option>
                                            <option value='<fmt:message key='hireHandle0045'/>'><fmt:message key='hireHandle0045'/></option>
                                            <option value='<fmt:message key='hireHandle0046'/>'><fmt:message key='hireHandle0046'/></option>
                                            <option value='<fmt:message key='hireHandle0047'/>'><fmt:message key='hireHandle0047'/></option>
                                            <option value='<fmt:message key='hireHandle0048'/>'><fmt:message key='hireHandle0048'/></option>
                                            <option value='<fmt:message key='hireHandle0049'/>'><fmt:message key='hireHandle0049'/></option>
                                            <option value='<fmt:message key='hireHandle0050'/>'><fmt:message key='hireHandle0050'/></option>
                                            <option value='<fmt:message key='hireHandle0051'/>'><fmt:message key='hireHandle0051'/></option>
                                            <option value='<fmt:message key='hireHandle0052'/>'><fmt:message key='hireHandle0052'/></option>
                                            <option value='<fmt:message key='hireHandle0053'/>'><fmt:message key='hireHandle0053'/></option>
                                            <option value='<fmt:message key='hireHandle0054'/>'><fmt:message key='hireHandle0054'/></option>
                                            <option value='<fmt:message key='hireHandle0055'/>'><fmt:message key='hireHandle0055'/></option>
                                            <option value='<fmt:message key='hireHandle0056'/>'><fmt:message key='hireHandle0056'/></option>
                                            <option value='<fmt:message key='hireHandle0057'/>'><fmt:message key='hireHandle0057'/></option>
                                       </select>
            </td>
            </tr>
          <tr>
            <td class="td_1"><span class="style_required_red">*</span><fmt:message key='hireHandle0058'/></td>
            <td class="td_2">
            <w:date allowInput="true" id="hire_handle_date" name="hire_handle_date" format="yyyy-MM-dd" style="width:90px;" property="handleinfo/hire_handle_date"/>           
            </td>
            <td class="td_1"><fmt:message key='hireHandle0059'/></td>
            <td class="td_2"><input type="text" class="text_field" name="file_card" value="${handleinfo.file_card }" /></td>
            </tr>
            <tr>
            <td class="td_1">反馈状态</td>
            <td class="td_2">  
                <d:select dictTypeId="FEEDBACK_STATE" name="feedback_state" id='feedback_state' value="${handleinfo.feedback_state }" nullLabel="--请选择--" style="width: 205px"/>
            <td class="td_1">反馈信息</td>
            <td class="td_2"><input type="text" class="text_field" id="feedback_info" name="feedback_info" value="${handleinfo.feedback_info }"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='hireHandle0060'/></td>
            <td colspan="3" class="td_2">
            <input type="text" class="text_field" name="hire_memo" value="${handleinfo.hire_memo }" />
            <input type="hidden" name="emp_post_id" value="<%=post_id %>">
            <input type="hidden" name="service_classify_item_id" value="<%=empinfo.get("service_classify_item_id")==null?"":empinfo.get("service_classify_item_id")%>"/>
            <input type="hidden" name="emp_service_id" value="${empinfo.emp_service_id }"/>
            </td>
            </tr>
        </table>
    </div>
    <!--<fmt:message key='hireHandle0003'/>3 end-->
        </div>
    </td>
    </tr>
</table>





    
     <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title" style="cursor:hand" onClick="isHidden('dingdan')">
          <LABEL><fmt:message key='hireHandle0062'/></LABEL>
        </div>
        <!--<fmt:message key='hireHandle0003'/>2 -->
        <!-- modify by mahongmin 修改，加点击社保后隐藏此div -->
        <div id="dingdan" class="zbox">
        <div style="padding: 8 10 8 8;">
            <r:datacell id="datacell_order" queryAction="/FAERP/HirefireAction.do?cmd=queryOrderInfo" width="98%" 
            height="158px" xpath="HireOrderInfoVo" paramFormId="datacell_formid">
            <r:field fieldName="apply_date" messagekey='hireHandle0065' allowModify="false" >
                <w:date format="YYYY-MM-DD"/>
            </r:field>
            <r:field fieldName="start_date" messagekey='hireHandle0066' allowModify="false" >
                <w:date format="YYYY-MM-DD"/>
            </r:field>
            <r:field fieldName="end_date" messagekey='hireHandle0067' allowModify="false" >
                <w:date format="YYYY-MM-DD"/>
            </r:field>
            </r:datacell>
         </div>
       </div> 
     </div>
      
      <div class="zbox">
        <div class="xz_title" style="cursor:hand" onClick="isHidden('shebao')">
          <LABEL><fmt:message key='hireHandle0068'/></LABEL>
        </div>
        <!-- modify by mahongmin 修改，加点击社保后隐藏此div -->
        <div id="shebao" class="zbox">
        <div style="padding: 8 10 8 8;">
            <r:datacell id="datacell_security" queryAction="/FAERP/HirefireAction.do?cmd=querySecurityInfoData" width="98%" 
            height="158px" xpath="HireSecurityInfoVo" paramFormId="datacell_formid">
            <r:field fieldName="apply_man" messagekey='hireHandle0070' ></r:field>
            <r:field fieldName="apply_date" messagekey='hireHandle0065' allowModify="false" >
                <w:date format="YYYY-MM-DD"/>
            </r:field>
            <r:field fieldName="transact_man" messagekey='hireHandle0072' ></r:field>
            <r:field fieldName="transact_date" messagekey='hireHandle0073' allowModify="false" >
                <w:date format="YYYY-MM-DD"/>
            </r:field>
            <r:field fieldName="transact_remarks" messagekey='hireHandle0074' ></r:field>
            <r:field fieldName="security_status_bd" messagekey='hireHandle0075' allowModify="false" >
                <d:select dictTypeId="SECURITY_STATUS_BD"></d:select>
            </r:field>
            <r:field fieldName="start_month" messagekey='hireHandle0076' ></r:field>
            <r:field fieldName="end_month" messagekey='hireHandle0077' ></r:field>
            <r:field fieldName="fund_month" messagekey='hireHandle0078' ></r:field>
            <r:field fieldName="stop_man" messagekey='hireHandle0079'></r:field>
            <r:field fieldName="stop_date" messagekey='hireHandle0080' allowModify="false" >
                <w:date format="YYYY-MM-DD" />
            </r:field>
            <r:field fieldName="stop_remarks" messagekey='hireHandle0081' ></r:field>
            </r:datacell>
       </div>
       </div>
    </div>
    </td>
    </tr>
</table>
    
    <div class="foot_button">
        <c:choose>
            <c:when test="${ismodfy == 'insert' }">
                <input type="button" id="btn_save" class="foot_icon_1" value="<fmt:message key='hireHandle0082'/>" onclick="hiresave(1);"/>
            </c:when>
            <c:otherwise>
                <input type="button" id="btn_save" class="foot_icon_1" value="<fmt:message key='hireHandle0082'/>" onclick="hiresave(2);"/>
            </c:otherwise>
        </c:choose>
        &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="foot_icon_1" value="<fmt:message key='hireHandle0000'/>" onclick="hirehandle();"/>
    </div>
        
    </div>
</div>
</form>
</body>
</fmt:bundle>
<script type="text/javascript">
//<fmt:message key='hireHandle0022'/>下拉框
//var selectIndex = document.getElementById("archivesaddress").selectedIndex;//获得是第几个被选中了
//document.getElementById("archivesaddress").options[selectIndex].value="<%=fselect%>";//设置value值
//document.getElementById("archivesaddress").options[selectIndex].innerHTML="<%=fselect%>"; //设置显示值
//<fmt:message key='hireHandle0038'/>下拉
var selectIndex = document.getElementById("hireaddress").selectedIndex;//获得是第几个被选中了
document.getElementById("hireaddress").options[selectIndex].value="<%=f1select%>";//设置value值
document.getElementById("hireaddress").options[selectIndex].innerHTML="<%=f1select%>"; //设置显示值
 var Select12 = {   
     del : function(obj,e){   
         if((e.keyCode||e.which||e.charCode) == 8){   
             var opt = obj.options[0];   
             opt.text = opt.value = opt.value.substring(0, opt.value.length>0?opt.value.length-1:0);   
         }   
     },   
     write : function(obj,e){   
         if((e.keyCode||e.which||e.charCode) == 8)return ;   
          var opt = obj.options[0];   
          opt.selected = "selected";   
          opt.text = opt.value += String.fromCharCode(e.charCode||e.which||e.keyCode);   
     }   
} 



  //定义 select 原值
  var oldValue,oldText;
  //select下拉框的onkeydown<fmt:message key='hireHandle0089'/>
  function catch_keydown(sel){
   switch(event.keyCode) {
    case 13: //回车键
     event.returnValue = false;
     break;
    case 27: //Esc键
     sel.options[sel.selectedIndex].text = oldText;
     sel.options[sel.selectedIndex].value = oldValue;
     event.returnValue = false;
     break;
    case 8:  //空格健
     var s = sel.options[sel.selectedIndex].text;
     s = s.substr(0,s.length-1);
     if (sel.options[sel.selectedIndex].value==sel.options[sel.selectedIndex].text){
      sel.options[sel.selectedIndex].value=s;
      sel.options[sel.selectedIndex].text=s;
     }
     event.returnValue = false;
     break;
   }
   if (!event.returnValue && sel.onchange)
    sel.onchange(sel)
  }

  //select下拉框的onkeypress<fmt:message key='hireHandle0089'/>
  function catch_press(sel){
   if(sel.selectedIndex>=0){
    var s = sel.options[sel.selectedIndex].text + String.fromCharCode(event.keyCode);
    if (sel.options[sel.selectedIndex].value==sel.options[sel.selectedIndex].text){
     sel.options[sel.selectedIndex].value=s;
     sel.options[sel.selectedIndex].text=s;
    }
    event.returnValue = false;
    if (!event.returnValue && sel.onchange)
     sel.onchange(sel)
   }
  }

	  //select下拉框的onfocus事件，<fmt:message key='hireHandle0082'/>下拉框原来的值
	  function catch_focus(sel) {
	   oldText = sel.options[sel.selectedIndex].value;
	   oldValue = sel.options[sel.selectedIndex].value;
	  }
	 var archivesa_ddress ="${handleinfo.archives_address}";
	 var o1=document.getElementById("archivesaddress");
	 o1.options.add(new Option(archivesa_ddress,archivesa_ddress));
	 o1.options[o1.options.length-1].selected="selected";  



</script>
</html>
