<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.nonnativemedical.nonnativemedical_resource" prefix="nonnativemedical.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='title_xz_xixi1'/></title>
<script type="text/javascript"><!--
jQuery(function(){
    
});

function insertMedical(){
 
      if(!$id("id_card").value){
       alert("<fmt:message key='not_null'/>");
       return;
    }
     if(!$id("city").value ){
        alert("<fmt:message key='not_null'/>");
        return;
    }
    if(!$id("tel").value){
       alert("<fmt:message key='not_null'/>");
       return;
    }
     if(!$id("zip_code").value ){
        alert("<fmt:message key='not_null'/>");
        return;
    }
    if(!$id("address").value){
       alert("<fmt:message key='not_null'/>");
       return;
    }
    

    var _param = jQuery("#formMedical").serialize();
    jQuery.post("<%=request.getContextPath()%>/NONNativeMedicalAction.do?cmd=insert&"+_param,function(data){
           if(data > 0){
            window.returnValue = data;
            window.close();
           }else{
            alert(data);
           }
    });
    
}
function rtnFuncEmployee(arg){
    var lookup = $id("emp_name");
    lookup.displayValue = arg[0]; 
    $id("id_card").value = arg[3];
    $id("tel").value = arg[7]==null?"":args[7];
}
</script>
</head>
<body>
<form id="formMedical" action="<%=request.getContextPath()%>/NONNativeMedicalAction.do" method="post">
<input type="hidden" name="cmd" value="insert"/>

<div class="box_xinzeng_sa">
  <div>
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='emp_name'/></td>
            <td class="td_2">
            <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="emp_name" name= "emp_name" 
            lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" messagekey="choose_emp" height="450" width="800"  style="width:140px"/>
            </td>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='id_card'/></td>
            <td class="td_2"><input id="id_card" name="id_card" readonly="readonly"/></td>
            <h:hidden id="emp_id" name="emp_id" />
            <h:hidden id="emp_code" name="emp_code" />
           
          </tr>
          <tr>
          <td class="td_1"><span style="color:red;">*</span><fmt:message key='city'/></td>
            <td class="td_2"><input id="city" name="city"/></td>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='tel'/></td>
            <td class="td_2"><input id="tel" name="tel"/></td>
           
          </tr>
          <tr>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='zip_code'/></td>
            <td class="td_2"><input id="zip_code" name="zip_code"/></td>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='address'/></td>
            <td class="td_2"><input id="address" name="address"/></td>
          </tr>
          <tr>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='is_big_hz_area'/></td>
            <td class="td_2">
            <input checked type="radio" name="is_big_hz_area" value="1"/><fmt:message key='is_1'/>
            <input type="radio" name="is_big_hz_area" value="0"/><fmt:message key='is_0'/>
            </td>
            <td class="td_1"><span style="color:red;">*</span><fmt:message key='is_in_province'/></td>
            <td class="td_2">
            <input checked type="radio" name="is_in_province" value="330002"/><fmt:message key='in'/>
            <input type="radio" name="is_in_province" value="330001"/><fmt:message key='out'/>
            </td>
          </tr>
        </table>
  </div>
  <div class="foot_button">
     <input type="button" onclick="insertMedical()" class="foot_icon_1" value="<fmt:message key='button_submit'/>"/>
  </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
