<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看失败员工</title>
</head>
<body>
<div class="box_xinzeng">
    <form id="formfail" action="<%=request.getContextPath()%>/SalaryPayAuditAction.do">
        <input type="hidden" name="cmd" value="expFail"/>
        <input type="hidden" name="batchId" value="<b:write property='batchId' propertyType='parameter'/>" />
	    <r:datacell id="dc_view_fail" 
	                queryAction="/FAERP/SalaryPayAuditAction.do?cmd=viewFail"
	                submitAction=""
	                width="100%"
	                paramFormId="formfail"
	                submitXpath="EbankFailVo" 
	                xpath="EbankFailVo">
	              <r:field fieldName="emp_code" label="唯一号">
	              </r:field>
	              <r:field fieldName="emp_name" label="姓名">
	              </r:field>
	              <r:field fieldName="bank_acco_no" label="银行账号">
	              </r:field>
		          <r:field fieldName="failed_info" label="失败信息">
		          </r:field>
	     </r:datacell>
	    <div class="foot_button">
            <input onclick="expFail()" type="button" class="foot_icon_2" value="导出结果" />
        </div>
     </form>
</div>
</body>
<script type="text/javascript">
function expFail(){
    if($id("dc_view_fail").dataset.getLength() < 1){
        alert("没有可导出的数据");
        return;
    }
    $id("formfail").submit();
}
    
</script>
</html>
