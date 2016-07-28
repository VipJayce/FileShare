<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%
//siqp添加
String security_product_id=request.getParameter("security_product_id");
System.out.println("security_product_id="+security_product_id);
%>
<html>
<body>
<form name="datacell_formid" method="post" id="datacell_formid">
<div  id="div1" style="margin:5px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/SecurityproductitemAction.do?cmd=searchDataBySecurityProductID&security_product_id=${param.security_product_id}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="98%" height="190px" 
                            xpath="SecurityproductitemVo"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info" />
                          <r:field fieldName="start_month" label="起始月">
                          </r:field>
                          <r:field fieldName="end_month" label="终止月">
                          </r:field>
                          <r:field fieldName="company_fixed_radix" label="企业固定基数">
                          </r:field>
                          <r:field fieldName="personal_fixed_radix" label="个人固定基数">
                          </r:field>
                          <r:field fieldName="social_average_salary" label="社会平均工资">
                          </r:field>
                          <r:field fieldName="personal_top_radix" label="个人最高基数">
                          </r:field>
                          <r:field fieldName="personal_low_base" label="个人最低基数">
                          </r:field>
                          <r:field fieldName="company_top_radix" label="企业最高基数">
                          </r:field>
                          <r:field fieldName="company_low_radix" label="企业最低基数">
                          </r:field>
                        </r:datacell>
            </div>
            </form>
</body>
</html>