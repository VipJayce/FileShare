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
<fmt:bundle basename="rayoo.ibd.ibdcontractproductemp.ibdcontractproductemp_resource" prefix="rayoo.ibd.ibdcontractproductemp.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function showListData(){
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function toOK_onClick() {
        var dc = $id("datacell2");
        var itemCount =  dc.getCurrentRowCount();
        var str = "";
        dc.selectFirstRow(); 
        var datacellValue = "";
        var returnVal = "";
        for(var i=0;i<itemCount;i++){
            var activeTr = dc.getActiveRow();
            var activeEntity = dc.getActiveEntity();
            if(jQuery(activeTr).find('input').is(":checked")){
                if (returnVal.length > 0){
                    returnVal += ",";
                }
            
                returnVal += 
                         "{\"id\":\"" + activeEntity.getProperty("id") + "\","
                        +"\"emp_name\":\""+ activeEntity.getProperty("emp_name") + "\","
                        +"\"emp_code\":\""+ activeEntity.getProperty("emp_code") + "\","
                        +"\"id_card_type_bd\":\""+ activeEntity.getProperty("id_card_type_bd") + "\","
                        +"\"address\":\""+ activeEntity.getProperty("address") + "\","
                        +"\"mobile\":\""+ activeEntity.getProperty("mobile") + "\","
                        +"\"id_card\":\""+ activeEntity.getProperty("id_card") + "\"}";
            } 
            dc.selectNextRow();
        }
        window.close();
        window.opener.selectEmpCallBack("[" + returnVal + "]");
    }
    
    function choose_row(dcId){
        dc = $id(dcId);
        obj = dc.getActiveEntity();
        if(!obj){
           alert("<fmt:message key='select_one_record'/>");
           return;
        }
        return obj;
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox' name='checkbox_template' value='"+value+"'>";
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="employee_formid">
 
<div id="right">
<div class="ringht_s" >
 
 
<div id="ccChild0" class="search"> 
<table width="90%" border="0" cellspacing="0" cellpadding="0">
    <input type="hidden" name="cust_id" value="${cust_id }">
        <tr>
            <td width="175" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key='Query_conditions'/></div>
            </td>
        </tr>
        <tr>
            <td width="23%" align="right"><fmt:message key='empName'/></td>
            <td width="27%" align="left">
              <input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="10"/>          </td>
            <td width="21%" align="right"><fmt:message key='empCode'/></td>
            <td width="29%" align="left">
              <input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="64"/>            </td>
            </tr>
        <tr>
          <td align="right"><fmt:message key='id_card'/></td>
          <td align="left"><input type="text" class="text_field" name="id_card1" inputName="身份证号" maxLength="64"/>          </td>
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
            <li class="g">      <a onClick="javascript:toOK_onClick();"><fmt:message key='confirm'/></a></li>
        </ul>
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/IbdContractProductEmpAction.do?cmd=empSimpleQuery"
        width="95%"
        xpath="EmployeeVo"
        paramFormId="employee_formid"
        readonly="true"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="id" messagekey="Operation" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      <r:field fieldName="emp_name" messagekey="empName" width="100px">
           <h:text disabled="true"/>
       </r:field>    
      <r:field fieldName="emp_code" messagekey="empCode">
        <h:text disabled="true"/>
      </r:field>
      <r:field fieldName="id_card_type_bd" messagekey="id_card_type" width="150px">
        <d:select dictTypeId="ID_CARD_TYPE_BD" />
      </r:field>
      <r:field fieldName="id_card" messagekey="id_card" width="150px">
        <h:text disabled="true"/>
      </r:field>
      <r:field fieldName="address" messagekey="address" width="150px">
        <h:text disabled="true"/>
      </r:field>
      <r:field fieldName="mobile" messagekey="mobile" width="150px">
        <h:text disabled="true"/>
      </r:field>
    </r:datacell>
</div>

</div>
</div>
</form>
</fmt:bundle>
<script type="text/javascript">
</script>
</body>
</html>
