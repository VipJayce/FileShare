<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentialsmateria.credentialsmateria_resource" prefix="rayoo.customerservice.credentialsmateria.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function showListData(){
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function toOK_onClick() {
        var dc_checkBox = jQuery('input[name="checkbox_template"]:checked');
        if(dc_checkBox.length == 0){
            alert("<fmt:message key='select_records'/>");
            return false;
        }
        
        var ids = "";
        dc_checkBox.each(function(){    
            if (ids.length > 0){
                ids+=",";
            }
            ids += jQuery(this).attr("returnVal");
        });    
        window.returnValue= "[" + ids + "]";
        window.close();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        var material_name = entity.getProperty("material_name");
        var remark = entity.getProperty("remark");
        var returnVal = "{\"id\":\"" + value + "\",\"material_name\":\"" 
                                     + material_name + "\",\"remark\":\""
                                     + remark + "\"}";
        return "<input type='checkbox' name='checkbox_template' value='"+value+"' returnVal='"+returnVal+"'>";
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
 
<div id="right">
<div class="ringht_s" >
 
 
<div id="ccChild0" class="search"> 
<table width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="175" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key="Query_conditions"/></div>
            </td>
        </tr>
        <tr>
            <td width="23%" align="right"><fmt:message key="material_name"/></td>
            <td width="27%" align="left">
              <input type="text" class="text_field" name="material_name" maxLength="10"/>          </td>
          <td align="right"></td>
          <td align="left">
              <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">          
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
          </td>
        </tr>
</table>
</div>

<div id="ccParent1" class="button"> 
     <div class="button_right">
        <ul>
            <li class="g">      <a onClick="javascript:toOK_onClick();"><fmt:message key="confirm"/></a></li>
        </ul>
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/CredentialsMateriaAction.do?cmd=simpleQuery"
        width="95%"
        xpath="CredentialsMateriaVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="id" messagekey="Operation" width="50px" align="center" onRefreshFunc="setCheckboxStatus" ></r:field>
      <r:field fieldName="material_name" messagekey="material_name" width="100px">
           <h:text disabled="true"/>
       </r:field>
      <r:field fieldName="remark" messagekey="remark" width="150px">
        <h:text disabled="true"/>
      </r:field>
    </r:datacell>
</div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
