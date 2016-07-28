<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<jsp:useBean id="finpaymentitemaction" class="rayoo.finance.payment.finpaymentitem.action.FinpaymentitemAction" scope="page" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
<link href="<%=request.getContextPath()%>/style/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/style/index.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/scripts/common.js"></script>

</head>
<%
String payment_month=request.getParameter("payment_month");
String bill_source_bd=request.getParameter("bill_source_bd");
//账单数据来源（1本地生成2全国系统3海拉尔）
if(bill_source_bd!=null&&!bill_source_bd.equals("")){
    bill_source_bd= bill_source_bd.equals("7") ? "2" : "3";
}
StringBuffer strsql=new StringBuffer();
strsql.append("   select sum(shebao + gongjijin + fuwufei) sumdate from(  ");
strsql.append("   select cust_code,cust_name,bill_year_month,sum(decode(small_type_id,'1', amount,0)) as shebao, ");
strsql.append("   sum(decode(small_type_id,'2', amount,0)) as gongjijin,sum(case when (small_type_id<>'1' and small_type_id<>'2')  ");
strsql.append("   then amount else 0 END) as fuwufei from (select cust_code,small_type_id,cust_name,bill_year_month, amount from (");
strsql.append("   select e.cust_code,p.small_type_id,e.cust_name,bi.bill_year_month,sum(bi.amount) amount from fin_bill_item bi ");
strsql.append("   left join pb_product p on bi.product_id=p.id left join pb_employee e on bi.employee_id=e.id  where 1=1 ");

if(bill_source_bd!=null&&bill_source_bd.length()>0&&!bill_source_bd.equals("null")){
    strsql.append("  and bi.bill_source_bd='"+bill_source_bd+"' ");
}
if(payment_month!=null&&payment_month.length()>0&&!payment_month.equals("null")){
    strsql.append("   and  bi.bill_year_month='"+payment_month+"'");
 }

strsql.append("   group by e.cust_code,p.small_type_id,e.cust_name,bi.bill_year_month ) group by cust_code,small_type_id,cust_name,");
strsql.append("   bill_year_month, amount) group by cust_code,cust_name,bill_year_month  order by cust_code,cust_name,bill_year_month)");
String sumdate=finpaymentitemaction.getSumDate(strsql.toString(),"sumdate");


%>
<body>
<form name="datacell_formid" id="datacell_formid" method="post"> 
            <div id="ccParent1" class="button"> 
             <div class="button_right">
                            <ul>
                                <li class="g">      <a onClick="javascript:toretfun_onClick();">确定</a></li>
                            </ul>
                     </div>
                       <div class="clear"></div>            
            </div>
<div id="right">
         <div  id="div1" style="margin:3px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/FinpaymentAction.do?cmd=getRemoteCostDetails&payment_month=${param.payment_month}&bill_source_bd=${param.bill_source_bd}"
                            id="celllist1"
                            paramFormId="datacell_formid" 
                            width="99%" height="310px" 
                            xpath="RemoteCostDetailVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="cust_code" label="客户唯一号">
                            <h:text />
                          </r:field>
                          <r:field fieldName="cust_name" label="客户名称">
                            <h:text />
                          </r:field>
                          <r:field fieldName="bill_year_month" label="支出年月" >
                            <h:text />
                          </r:field>
                          <r:field fieldName="shebao" label="社保保险" >
                          <h:text />
                          </r:field>
                          <r:field fieldName="gongjijin" label="公积金" >
                          <h:text />
                          </r:field>
                          <r:field fieldName="fuwufei" label="服务费" >
                          <h:text />
                          </r:field>
                          <r:field fieldName="sumdate" label="小计" >
                          <h:text />
                          </r:field>
                        </r:datacell>
            </div>
           
           </div>
           <p> <p>
  </div>

</form>
</body>
</html>
<script language="javascript">
	function toretfun_onClick(){
	        window['returnValue'] = [<%=sumdate%>];
            window.close(); //关闭
	}
</script>
