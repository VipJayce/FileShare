<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>选择薪资类别</title>
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
    clzname = clz.getValue("product_name");
    var rtn = new Array();
    rtn[0] = clzid;
    rtn[1] = clzname;
    var order_product_data_bd = $id("order_product_data_bd").value ;
    rtn[2] = order_product_data_bd ;
    window.returnValue= rtn;
    //var product_name_return =  window.opener.document.getElementById("product_name_return")  ;
    //alert(product_name_return) ;
    //product_name_return.value =rtn[0] ;
    window.close();
    //alert(clzid+"---"+clzname);
}
</script>
<body>
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">选择产品</div>
	</div>
    <div class="ringht_s">
	<div class="social_tab">
		<form id="form_qry" name="form_qry" action="/SalaryclassAction.do?cmd=toSalartClzLookup" method="post">
		  <input name="salary_class_id" id="salary_class_id" type="hidden" value="<%=request.getParameter("sa_class_id") %>"/>
          <div class="button_salary">
            <div class="clear"></div>
          </div>          
          <r:datacell 
              id="dc_salary_clz"
              queryAction="/FAERP/ProductAction.do?cmd=seachProductBySalaryClass"
              submitAction="/FAERP/ProductAction.do?cmd=updateProductBySalaryClass"
              width="100%"
              xpath="ProductVo"
              submitXpath="ProductVo"
              paramFormId="form_qry" readonly="true"
              >
              <r:field width="300" fieldName="product_name" label="合同服务产品名称" >
              </r:field>
            </r:datacell>
		</div>
		<div>
		  公司个人&nbsp;&nbsp;&nbsp;<select name="order_product_data_bd" id="order_product_data_bd">
		  <option value="个人部分">个人部分</option>
		  <option value="公司部分">公司部分</option>
		  <option value="基数">基数</option>
		  <option value="总额">总额</option>
		  </select>
		</div>
		<div class="button_right" align="center">
              <ul>
              <br/>
              <br/>
                <li class="bc" align="center"><a onclick="doChoose()">确定</a></li>
            </div>
	</form>
    <!-- 查询标签页 -->
</div>
</div>
</body>
</html>
