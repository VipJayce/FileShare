<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>选择薪资项目</title>
</head>
<script type="text/javascript">
//执行查询
function qry(){
    $id("dc_salary_clz").reload();
}
//选择薪资类别并返回
function doChoose(){
    dc = $id("dc_salary_clz");
    clz = dc.getActiveEntity();
    clzid = clz.getValue("id");
    clzname = clz.getValue("sa_item_name");
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
	  <div class=" right_title">选择薪资项目</div>
	</div>
    <div class="ringht_s">
	<div class="social_tab">
		<form id="form_qry" name="form_qry" action="/SalaryclassAction.do?cmd=toSalartClzLookup" method="post">
          <div class="box_tab">
            <div class="xz_title" style="margin-top:10px;">查询条件</div>
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1">薪资项目名称</td>
              <td class="td_2"><input name="sa_item_name" id="sa_item_name" inputName="薪资类别名称" maxLength="100" class="sText"/></td>
              <td class="td_1">客户名称</td>
              <td class="td_2"><input name="customer_name" inputName="客户名称" maxLength="100"/></td>
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
              id="dc_salary_clz"
              queryAction="/FAERP/SaleryitemAction.do?cmd=salaryClzLookup"
              submitAction="/FAERP/SaleryitemAction.do?cmd=update"
              width="100%"
              xpath="SaleryitemVo"
              submitXpath="SaleryitemVo"
              paramFormId="form_qry" readonly="true"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field width="300" fieldName="sa_item_name" label="薪资项目名称" >
                <h:text/>
              </r:field>
               <r:field width="300" fieldName="sa_item_ename" label="薪资项目英文名称" >
              </r:field>
            </r:datacell>
		</div>
	</form>
    <!-- 查询标签页 -->
</div>
</div>
</body>
</html>
