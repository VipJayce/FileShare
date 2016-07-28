<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salarydoc.salarydoc_resource" prefix="rayoo.salary.salarydoc.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="view_repeat_data"/></title>
</head>
<script type="text/javascript">
function expSalarydocRepeatData(){
    if($id("dc_repeat_data").dataset.getLength() < 1){
        alert("<fmt:message key='no_output_record'/>");
        return;
    }
    $id("formRepeatData").submit();
}
    
</script>
<body>
    <form id="formRepeatData" action="<%=request.getContextPath()%>/SalarydocAction.do">
        <input type="hidden" name="cmd" value="export"/>
        <input type="hidden" id="h_clzId" name="clzId" value="<%=request.getParameter("clzId")%>"/>
        </br>
        <r:datacell 
              id="dc_repeat_data"
              queryAction="/FAERP/SalarydocAction.do?cmd=queryRepeatData"
              submitAction="/FAERP/SalarydocAction.do?cmd=update"
              width="100%"
              xpath="SalarydocVo"
              submitXpath="SalarydocVo"
              paramFormId="formRepeatData"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      
              <r:field fieldName="emp_code" messagekey="emp_code" >
              </r:field>
              <r:field fieldName="emp_name" messagekey="emp_name" >
              </r:field>
              <r:field fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field fieldName="customer_name" messagekey="customer_name" >
              </r:field>
              <r:field fieldName="sa_class_name" messagekey="salary_type" >
              </r:field>
              <r:field fieldName="post_status_bd" messagekey="post_status_bd" >
                <d:select dictTypeId="POST_STATUS_BD"/>
              </r:field>
        </r:datacell>
     <div class="foot_button">
      <input id="btn_exp" onclick="expSalarydocRepeatData()" type="button" class="foot_icon_2" value="<fmt:message key='button_output_exl'/>" />
     </div> 
     </form>
              
</body>
</fmt:bundle>
</html>
