<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.datainterface.datainterface_resource" prefix="rayoo.salary.datainterface.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='input_data_fail'/></title>
</head>
<body>
<form name="failform" id="failform" method="post" action="<%=request.getContextPath()%>/SaimportfailedAction.do?cmd=expFailData">
<input type="hidden" name="batchIds" id="batchIds" value="<%=request.getParameter("batchIds") %>"/>
<input type="hidden" name="pay_name" id="pay_name" value="<%=request.getParameter("pay_name") %>"/>
  <div id="values_div">
    <r:datacell id="dc_faildata"
            queryAction="/FAERP/SaimportfailedAction.do?cmd=viewFailData"
            submitAction=""
            width="98%" xpath="SaimportfailedVo" submitXpath="SaimportfailedVo"
            paramFormId="failform" height="320px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            
            <r:field fieldName="pay_name" messagekey="pay_name" width="150px">
            </r:field>
            <r:field fieldName="import_batch_id" messagekey="import_batch_id" width="150px">
            </r:field>
            <r:field fieldName="emp_name" messagekey="emp_name" width="150px" >
            </r:field>          
            <r:field fieldName="id_card" messagekey="id_card" width="150px">
            </r:field>
            <r:field fieldName="remarks" messagekey="remarks" width="250px">
            </r:field>          
        </r:datacell>
  </div>
  <div class="foot_button">
 <input type="submit" class="foot_icon_2" value="<fmt:message key='button_output_exl'/>" />
</div>
</form>
</body>
</fmt:bundle>
</html>

