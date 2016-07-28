<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>选择保单</title>
</head>
<script type="text/javascript">
//执行查询
function qry(){
    $id("dc_policy_clz").reload();
}
//
function doChoose(){
    dc = $id("dc_policy_clz");
    clz = dc.getActiveEntity();
    clzid = clz.getValue("id");
    clzname = clz.getValue("policy_name");
    var rtn = new Array();
    rtn[0] = clzid;
    rtn[1] = clzname;
    window.returnValue = rtn;
    window.close();
}
</script>
<body>
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">选择保单</div>
	</div>
    <div class="ringht_s">
	<div class="social_tab">
		<form id="form_qry" name="form_qry" action="" method="post">
		<input  type="hidden" name="policy_type" id="policy_type" value="${requestScope.policy_type}"/>
          <div class="box_tab">
            <table width="90%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1">保单编号</td>
              <td class="td_2"><input name="policy_code_s" inputName="保单编号" maxLength="100" class="sText"/></td>
              <td class="td_1">保单名称</td>
              <td class="td_2"><input name="policy_name_s" inputName="保单名称" maxLength="100"/></td>
            </tr>
            <tr>
              <td class="td_1">&nbsp; </td>
              <td class="td_2">&nbsp; </td>
              <td class="td_1">&nbsp; </td>
              <td class="td_2"><input onclick="qry()" type="button" class="icon_1" value="查询" /></td>
            </tr>
            </table>
               
          </div>
          <div class="button_salary">
            <div class="button_right">
              <ul>
                <li class="bc"><a onclick="doChoose()">选择</a></li>
              </ul>
            </div>
            <div class="clear"></div>
          </div>          
          <r:datacell 
              id="dc_policy_clz"
              queryAction="/FAERP/PolicyAction.do?cmd=policyClzLookup"
              submitAction="/FAERP/PolicyAction.do?cmd=update"
              width="90%"
              height="300px"
              xpath="PolicyVo"
              submitXpath="PolicyVo"
              paramFormId="form_qry" readonly="true"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field width="110" fieldName="policy_code" label="保单编号" >
              </r:field>
              <r:field width="110" fieldName="policy_name" label="保单名称" >
              </r:field>
              <r:field width="110" fieldName="policy_type" label="保单类型" >
              <d:select dictTypeId="POLICY_TYPE_BD"/>
              </r:field>
              <r:field width="110" fieldName="policy_str_date" label="保险开始日期" >
              <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
              </r:field>
              <r:field width="110" fieldName="policy_end_date" label="保险结束日期" >
              <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
              </r:field>
            </r:datacell>
		</div>
	</form>
    <!-- 查询标签页 -->
</div>
</div>
</body>
</html>
<script language="javascript">
$id("dc_policy_clz").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    doChoose();
}
</script>
