<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.employeepost.emppostclass.emppostclass_resource" prefix="rayoo.employeepost.emppostclass.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="choose_quotation"/></title>
</head>
<script type="text/javascript">
//执行查询
function qry(){
    $id("dc_quotation_clz").reload();
}
function doChoose(){
    var dc = $id("dc_quotation_clz");
    var clz = dc.getActiveEntity();
    var clzid = clz.getValue("id");
    var quotation_code = clz.getValue("quotation_code");
    var quotation_name = clz.getValue("quotation_name");
    var rtn = new Array();
    rtn[0] = clzid;
    rtn[1] = quotation_code;
    rtn[2] = quotation_name;
    window.returnValue = rtn;
    window.close();
}
</script>
<body>
<div id="right">
    <div class="ringht_s">
	<div class="social_tab">
		<form id="form_qry" name="form_qry" action="/EmppostAction.do?cmd=quotationClzLookup" method="post">
		<input  type="hidden" name="send_customerid" id="send_customerid" value="${send_customerid}" />
          <div class="box_tab">
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1"><fmt:message key="quotation_code"/></td>
              <td class="td_2"><input name="quotation_code" inputName="报价单编号" maxLength="100" class="sText"/></td>
              <td class="td_1"><fmt:message key="quotation_name"/></td>
              <td class="td_2"><input name="quotation_name" inputName="报价单名称" maxLength="100"/></td>
            </tr>
            <tr>
              <td class="td_1">&nbsp;</td>
              <td class="td_2">&nbsp;</td>
              <td class="td_1">&nbsp;</td>
              <td class="td_2"><input onclick="qry()" type="button" class="icon_1" value="<fmt:message key="query"/>" /></td>
            </tr>
            </table>
          </div>
          <div class="button_salary">
            <div class="button_right">
              <ul>
                <li class="bc"><a onclick="doChoose()"><fmt:message key="choose"/></a></li>
              </ul>
            </div>
            <div class="clear"></div>
          </div>          
          <r:datacell 
              id="dc_quotation_clz"
              queryAction="/FAERP/EmppostAction.do?cmd=quotationClzLookup"
              submitAction="/FAERP/EmppostAction.do?cmd=update"
              width="99%"
              xpath="BeanVo"
              submitXpath="BeanVo"
              paramFormId="form_qry" readonly="true">
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field width="300" fieldName="quotation_code" messagekey="quotation_code" >
                <h:text/>
              </r:field>
               <r:field width="300" fieldName="quotation_name" messagekey="quotation_name" >
              </r:field>
            </r:datacell>
		</div>
	</form>
    <!-- 查询标签页 -->
</div>
</div>
</body>
</fmt:bundle>
</html>

<script type="text/javascript">
$id("dc_quotation_clz").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    doChoose();
}
</script>
