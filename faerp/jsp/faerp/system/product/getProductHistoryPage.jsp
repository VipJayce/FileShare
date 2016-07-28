<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>历史修改记录</title>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" method="post"> 
<div id="right">
         <div  id="div1" style="margin:13px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/ProductAction.do?cmd=getProductHistoryListData&product_id=${requestScope.product_id}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="99%" height="250px" 
                            xpath="PbproducthistoryVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="product_cost" label="历史标准成本">
                                <h:text/>
                          </r:field>
                          <r:field fieldName="product_price" label="历史标准价格" >
                                <h:text/>
                          </r:field>                         
                          <r:field fieldName="last_update_user" label="修改人">
                                <h:text/>
                          </r:field>
                          <r:field fieldName="last_update_date" label="修改时间" >
                                <w:date format="yyyy-MM-dd"/>
                          </r:field>                              
                        </r:datacell>
            </div>
  </div>

</form>
</body>
</html>
