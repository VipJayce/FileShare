<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.customerservice.credentialstype.credentialstype_resource" prefix="rayoo.customerservice.credentialstype.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
  <title>
  <fmt:message key="credentialsType"/>
  </title>
  <script language="javascript">
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="statusCellValues" id="statusCellValues">
    <input type="hidden" name="materiaCellValues" id="materiaCellValues">
    <div id="right" style="height: 140px;">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='credentialsType_maintenance'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_x" style="height: 150px;">
    <div id="ccChild1"     class="box_xinzeng" style="height: 150px;">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"  width="25%"><fmt:message key='credentials_type_bd'/></td>
          <td class="td_2 " width="25%"><%
          rayoo.customerservice.credentialstype.vo.CredentialsTypeVo beanVo = (rayoo.customerservice.credentialstype.vo.CredentialsTypeVo)request.getAttribute("bean");
          String credentials_type_bd = "";
          String emp_post_type_bd = "";
          String  acceptance= "";
          if (beanVo != null){
              credentials_type_bd = String.valueOf(beanVo.getCredentials_type_bd());
              emp_post_type_bd = String.valueOf(beanVo.getEmp_bd());
              acceptance=String.valueOf(beanVo.getAcceptance());
          }
                 %>
                <%=BaseDataHelper.getNameByCode("MATERIALS_DEFINE",credentials_type_bd)%>
          <td class="td_1"  width="25%"><fmt:message key='credentials_name'/></td>
          <td class="td_2 " width="25%">${bean.credentials_name}
          </td>
          </tr>
          <tr>
           <td class="td_1"  width="25%"><fmt:message key='emp_bd'/></td>
          <td class="td_2 " width="25%">
            <%=BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",emp_post_type_bd)%> </td>
            <td class="td_1"  width="25%"><fmt:message key='acceptance'/></td>
          <td class="td_2 " width="25%">
            <%=BaseDataHelper.getNameByCode("ACCEPTANCE",acceptance)%> </td>
            </tr>
        <tr>
          <td class="td_1"  width="23%"><fmt:message key='remark'/></td>
          <td class="td_2 " colspan="3"><textarea rows="5" cols="60" name="remark" readonly="readonly">${bean.remark}</textarea>
          </td>
        </tr>
      </table>
    </div>
    <div>
    <div class="xz_title">
      <fmt:message key='credentialsMateria'/>
    </div>
    <div style="padding: 8 10 8 8;">
      <r:datacell id="datacell2" 
                  queryAction="/FAERP/CredentialsTypeAction.do?cmd=queryMateria&credentials_type_id=${bean.id}"
                  submitAction="/FAERP/CredentialsTypeAction.do?cmd=updateMateria"   
                  width="94%" height="200px" 
                  xpath="ReCredentialsMateriaVo" 
                  paramFormId="credentialsTypeForm" 
                  readonly="false" pageSize="100">
        <r:field fieldName="id" label="" width="0" ></r:field>
        <r:field fieldName="credentials_materia_id" label="" width="0" ></r:field>
        <r:field fieldName="material_name" messagekey="material_name" width="135px">
        </r:field>
         <r:field fieldName="isMust" messagekey="material_isMust" width="135px" allowModify="false">
          <h:select name="isMust" property="isMust">
               <h:option value="0" label="必选"></h:option>
                <h:option value="1" label="非必选"></h:option>
                <h:option value="2" label="不定项"></h:option>
       </h:select>
        </r:field>
         <r:field fieldName="remark" messagekey="remark" width="135px">
        </r:field>
        <r:field fieldName="explain" messagekey="explain" width="135px">
        </r:field>
      </r:datacell>
    </div>
    
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
      <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
  </form>
</body>
</fmt:bundle>
</html>
