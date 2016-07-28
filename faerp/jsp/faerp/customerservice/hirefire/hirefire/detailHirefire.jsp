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
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.detailHirefire_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

</script>
</head>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="false">
<div id="right">
    <!--<script language="javascript">
    writeTableTopFesco('用<fmt:message key='detailHirefire0034'/>查看','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    
 --><div class="ringht_s">
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='detailHirefire0001'/></div>
    <!--<fmt:message key='detailHirefire0002'/>1-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr><!-- <input type="text" class="text_field" readonly="readonly" value=""/> -->
            <td class="td_1"><fmt:message key='detailHirefire0003'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("emp_name") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0004'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("emp_code") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0005'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("id_card") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0006'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("cust_name") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0007'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("resident_addresss") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0008'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("apply_on_post_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0009'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("start_date") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0010'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("end_date") %>"/></td>
            </tr>
                      <tr>
                     <!--  
            <td class="td_1"><fmt:message key='detailHirefire0011'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("bigname") %>"/></td>
            --> <td class="td_1"><fmt:message key='detailHirefire0012'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("position") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0013'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("apply_off_post_date") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0014'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("on_post_desc") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0015'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("service_desc") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0016'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("pocicy_bd")==null?"":BaseDataHelper.getNameByCode("POCICY_BD",empinfo.get("pocicy_bd").toString())%>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0017'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("file_card") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0018'/>1</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("mobile") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0018'/>2</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("tel") %>"/></td>
            </tr>
                      <tr>
            <td class="td_1"><fmt:message key='detailHirefire0020'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("address") %>"/></td>
            <td class="td_1">E_MAIL</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("email") %>"/></td>
            </tr>
            <!-- 
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0012'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=empinfo.get("position") %>"/></td>
            <td class="td_1">&nbsp;</td>
            <td class="td_2"></td>
          </tr>
           -->
           
           <tr>
            <td class="td_1">反馈状态</td>
            <td class="td_2">
            <input type="text" class="text_field" readonly="readonly" value="${empinfo.fire_feedback_state}"/>
            </td>
            <td class="td_1">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
          </tr>
          
           <tr>
            <td class="td_1">查档日期</td>
            <td class="td_2">
            <input type="text" class="text_field" readonly="readonly" value="${empinfo.feedback_date}"/>
            </td>
            <td class="td_1">调档反馈信息</td>
            <td class="td_2"><textarea name="feedback_message" rows="3" class="xText_d" readonly="readonly">${empinfo.feedback_message }</textarea></td>
          </tr>
          
        </table>
    </div>
    <!--<fmt:message key='detailHirefire0002'/>1 end-->
        </div>
    </td>
    </tr>
</table>
    

    
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='detailHirefire0023'/></div>
        <!--<fmt:message key='detailHirefire0002'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0025'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${hirehandle.social_unit }<%//=hirehandle.get("social_unit") %>" /></td>
            <td class="td_1"><fmt:message key='detailHirefire0026'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${hirehandle.archives_address }<%//=hirehandle.get("archives_address") %>" /></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0027'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" " inputName="<fmt:message key='detailHirefire0027'/>" value="<fmt:formatDate value="${hirehandle.hire_start_date }" pattern="yyyy-MM-dd"/><%//=hirehandle.get("hire_start_date") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0029'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${hirehandle.hire_address }<%//=hirehandle.get("hire_address") %>" /></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0030'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" inputName="<fmt:message key='detailHirefire0030'/>" value="<fmt:formatDate value="${hirehandle.hire_handle_date }" pattern="yyyy-MM-dd"/><%//=hirehandle.get("hire_handle_date") %>"/></td>
            <td class="td_1"></td>
            <td class="td_2"></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0032'/></td>
            <td colspan="3" class="td_2">
            <input type="text" class="text_field" readonly="readonly"  value="${hirehandle.hire_memo }<%//=hirehandle.get("hire_memo") %>" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1">用工反馈信息</td>
            <td colspan="3" class="td_2"><textarea readonly="readonly" class="xText_d" >${hirehandle.feedback_info}</textarea></td>
            </tr>
            
        </table>
    </div>
    <!--<fmt:message key='detailHirefire0002'/>3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='detailHirefire0034'/></div>
        <!--<fmt:message key='detailHirefire0002'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0036'/></td>
            <td class="td_2">
            <input type="text" class="text_field" readonly="readonly" inputName="<fmt:message key='detailHirefire0036'/>" value="<%=firehandle.get("fire_handle_date") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0038'/></td>
            <td class="td_2">
            <input type="text" class="text_field" readonly="readonly" inputName="<fmt:message key='detailHirefire0038'/>" value="<%=firehandle.get("fire_mode_bd")==null?"":BaseDataHelper.getNameByCode("FIRE_MODE_BD",firehandle.get("fire_mode_bd").toString()) %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0040'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=firehandle.get("fire_resident_address") %>"/></td>
            <td class="td_1"></td>
            <td class="td_2"></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0041'/></td>
            <td class="td_2">
            <%
            String book = firehandle.get("is_laborbook_bd").toString();
            if(book == "1" || book.equals("1")){
                %>
                <input type="checkbox" id="is_laborbook_bd" name="is_laborbook_bd" value="${hirehandle.is_laborbook_bd }" checked="checked" >
                <%
            }else{
                %>
                <input type="checkbox" id="is_laborbook_bd" name="is_laborbook_bd" value="${hirehandle.is_laborbook_bd }">
                <%
            }
            %>
            </td>
            <td class="td_1"><fmt:message key='detailHirefire0042'/></td>
            <td class="td_2">
            <%
            String prove = firehandle.get("is_fire_prove_bd").toString();
            if(prove == "1" || prove.equals("1")){
                %>
                <input type="checkbox" name="is_fire_prove_bd" id="is_fire_prove_bd" value="${hirehandle.is_fire_prove_bd }" checked="checked"  />
                <%
            }else{
                %>
                <input type="checkbox" name="is_fire_prove_bd" id="is_fire_prove_bd" value="${hirehandle.is_fire_prove_bd }" />
                <%
            }
            %>
            
            </td>
            </tr>
            <tr id="tr1">
            <td class="td_1"><fmt:message key='detailHirefire0043'/></td>
            <td class="td_2">  
                <d:select dictTypeId="CLAIM_METHOD" name="claim_method" id='claim_method' value="${hirehandle.claim_method }" nullLabel="" style="width: 205px"/>
            <td class="td_1">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0045'/></td>
            <td colspan="3" class="td_2"><textarea readonly="readonly" class="xText_d" ><%=firehandle.get("fire_memo") %></textarea></td>
            </tr>
            
            <tr>
            <td class="td_1">退工反馈信息</td>
            <td colspan="3" class="td_2"><textarea readonly="readonly" class="xText_d" >${hirehandle.fire_feedback_info}</textarea></td>
            </tr>
        </table>
    </div>
    <!--<fmt:message key='detailHirefire0002'/>3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title">
          <LABEL><fmt:message key='detailHirefire0047'/></LABEL>
        </div>
        <!--<fmt:message key='detailHirefire0002'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0049'/></td>
            <td class="td_2">
            <input type="text" class="text_field" readonly="readonly" inputName="<fmt:message key='detailHirefire0038'/>" value="<%=BaseDataHelper.getNameByCode("TRANSFER_TYPE_BD",firehandle.get("transfer_type_bd").toString().trim()) %>"/></td>
         </tr>
       </table>
    </div>
    <!--<fmt:message key='detailHirefire0002'/>3 end-->
        </div>
    </td>
    </tr>
</table>
 <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"><fmt:message key='detailHirefire0052'/></div>
        <!--<fmt:message key='detailHirefire0002'/>3-->
    <div class="box_3">
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0054'/>、<fmt:message key='detailHirefire0055'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address1") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0056'/>、<fmt:message key='detailHirefire0057'/>、<fmt:message key='detailHirefire0058'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address2") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0059'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address3") %>"/></td>
            </tr>
          <tr>
            <td class="td_1"><fmt:message key='detailHirefire0060'/>、<fmt:message key='detailHirefire0061'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address4") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0062'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address5") %>"/></td>
            <td class="td_1"><fmt:message key='detailHirefire0063'/>、<fmt:message key='detailHirefire0064'/></td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=residentaddress.get("resident_address6") %>"/></td>
            </tr>
          
        </table>
    </div>
    <!--<fmt:message key='detailHirefire0002'/>3 end-->
        </div>
    </td>
    </tr>
</table>
   
        
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>