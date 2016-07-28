<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salaryclass.salaryclass_resource" prefix="rayoo.salary.salaryclass.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='select_salaryclass'/></title>
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
    clzname = clz.getValue("sa_class_name");
    var cust_id = clz.getValue("customer_id");
    var cust_name = clz.getValue("customer_name");
    var cust_code = clz.getValue("customer_code");
    var rtn = new Array();
    rtn[0] = clzid;
    rtn[1] = clzname;
    rtn[2] = cust_id;
    rtn[3] = cust_code;
    rtn[4] = cust_name;
    window.returnValue = rtn;
    window.close();
    //alert(clzid+"---"+clzname);
}
</script>
<body>
<div id="right">
	
    <div class="ringht_s">
	<div class="social_tab">
		<form id="form_qry" name="form_qry" action="/SalaryclassAction.do?cmd=toSalartClzLookup" method="post">
          <div class="box_tab">
            
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1"><fmt:message key='sa_class_name'/></td>
              <td class="td_2"><input name="sa_class_name" inputName="薪资类别名称" maxLength="100" class="sText"/></td>
              <td class="td_1"><fmt:message key='customer_name'/></td>
              <td class="td_2"><input name="customer_name" inputName="客户名称" maxLength="100"/></td>
            </tr>
            <tr>
              <td class="td_1"><fmt:message key='customer_code'/></td>
              <td class="td_2"><input name="customer_code" inputName="客户名称" maxLength="100" class="sText"/></td>
              <td class="td_1">&nbsp;</td>
              <td class="td_2"><input onclick="qry()" type="button" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
            </tr>
            </table>
               
          </div>
          <div class="button_salary">
            <div class="button_right">
              <ul>
                <li class="bc"><a onclick="doChoose()"><fmt:message key='button_select'/></a></li>
              </ul>
            </div>
            <div class="clear"></div>
          </div>          
          <r:datacell 
              id="dc_salary_clz"
              queryAction="/FAERP/SalaryclassAction.do?cmd=salaryClzLookup"
              submitAction="/FAERP/SalaryclassAction.do?cmd=update"
              width="99%"
              xpath="SalaryclassVo"
              submitXpath="SalaryclassVo"
              paramFormId="form_qry" readonly="true"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      
              <r:field width="300" fieldName="sa_class_name" messagekey="salary_type">
                <h:text/>
              </r:field>
               <r:field width="300" fieldName="customer_name" messagekey="customer_name">
              </r:field>
               
              <r:field fieldName="payday" messagekey="payday">
                <h:text/>
              </r:field>
              <r:field fieldName="is_si" messagekey="is_si" >
	                <h:select property="is_si">
	                     <h:option value="1" label="获取"/>
	                     <h:option value="0" label="不获取"/>
	                </h:select>            
              </r:field>
              <r:field fieldName="get_month_bd" messagekey="get_month_bd">
	               <h:select property="get_month_bd">
	                     <h:option value="0" label="本月"/>
	                     <h:option value="1" label="上月"/>
	               </h:select>
              </r:field>
              <r:field fieldName="si_source" messagekey="si_source">
	              <h:select property="si_source">
	                   <h:option value="0" label="账单"/>
	              </h:select>
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
$id("dc_salary_clz").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
	doChoose();
}
</script>