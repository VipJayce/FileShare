<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle
    basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
    prefix="rayoo.certificate.certificateTransaction.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <title><fmt:message key="credentialsType_maintenance_history" /></title>
    <script language="javascript">
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
        function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell2").addParam("lastDate",  $id("lastDate").value);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
</script>
    </head>
    <body>
    
    <div id="right" style="height: 140px;"><script
        language="javascript">
        writeTableTopFesco("<fmt:message key='credentialsType_maintenance_history'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
     rayoo.certificate.certificateTransaction.vo.CertifiCateTranInfoDef beanVo = (rayoo.certificate.certificateTransaction.vo.CertifiCateTranInfoDef) request.getAttribute("bean");
 %>
    <div class="ringht_x" style="height: 150px;">
    <form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/CertificateTransactionAction.do"><input
        type="hidden" name="id" id="edit_id" value="${bean.id}"> <input
        type="hidden" name="statusCellValues" id="statusCellValues"> <input
        type="hidden" name="materiaCellValues" id="materiaCellValues">
    <div id="ccChild1" class="box_xinzeng" style="height: 80px;">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="25%"><fmt:message key='companyName' /></td>
            <td class="td_2 " width="25%">
                            ${bean.companyName}
            </td>
            <td class="td_1" width="25%"><fmt:message key='companyNumber' /></td>
            <td class="td_2 " width="25%" id="companyNumber">
                     ${bean.companyNumber}
             </td>
        </tr>
        <tr>
            <td class="td_1" width="25%"><fmt:message
                key='credentials_type_bd' /></td>
            <td class="td_2 " width="25%">
                    <%=BaseDataHelper.getNameByCode("CREDENTIALS_TYPE", beanVo.getCredentialsTypeBdID())%>
             </td>
            <td class="td_1" width="25%"><fmt:message key='credentials_name' /></td>
            <td class="td_2 " width="25%">
                            ${bean.credentialsTypeName}
            </td>
        </tr>
     <!--  <tr>           
           <td class="td_1" width="25%"><fmt:message key='modifyTime'/></td>
          <td class="td_2" width="25%">
          <w:date format="yyyy-MM-dd"   name="lastDate" id="lastDate" style="width: 125px" />之后
           </td>
           <td class="td_2 " colspan="2"> <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()"></td>
            </tr>
          -->
    </table>
    </div>
    <div>
    <div class="xz_title">
      <fmt:message key='credentialsMateria'/>
    </div>
    <div style="padding: 8 10 8 8;">
      <r:datacell id="datacell2" 
                  queryAction="/FAERP/CertificateTransactionAction.do?cmd=simpleQueryTranDefHIS&oldId=${bean.id}"
                  width="94%" height="200px" 
                  xpath="CertifiCateTranInfoDefHISVO" 
                  paramFormId="datacell_formid" 
                  readonly="ture" pageSize="100">
                  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field fieldName="id" label="" width="0" ></r:field>
        <r:field fieldName="updateDate" messagekey="modifyTime" label="" width="135px" >
            <w:date format="yyyy-MM-dd"/>
        </r:field>
        <r:field fieldName="updateUserName" messagekey="modifyPerson" width="135px">
        </r:field>
         <r:field fieldName="companyAccount" messagekey="companyAccount" width="135px" allowModify="false">
        </r:field>
         <r:field fieldName="companyAccountPassword" messagekey="companyAccountPassword" width="135px">
        </r:field>
      </r:datacell>
    </div>
        </form>
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
     <input type="button"   class="icon_2" value='<fmt:message key="go_back"/>' onClick="javascript:cancel_onClick()" /></div>

</fmt:bundle>
</body>
</html>
