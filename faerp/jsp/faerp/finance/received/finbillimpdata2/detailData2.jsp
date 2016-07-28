<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>北京大表明细</title>
</head>

<body>
    <form name="form" method="post" id="formDetailData">
        <input type="hidden" id="batch_id" name="batch_id" value="<%=request.getParameter("batch_id")%>"/>
        </br>
        <r:datacell 
               id="celllist1"
               queryAction="/FAERP/Finbillimpdata2Action.do?cmd=queryDetailFinbillimpdata2Data"
               width="100%"
               height="320px"
               xpath="Finbillimpdata2Vo"
               paramFormId="formDetailData"
               readonly="true"
               >
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="cust_code" label="客户编号">
                   <h:text/>
               </r:field>
               <r:field fieldName="cust_name" label="客户名称">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_code" label="唯一号">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_name" label="姓名">
                   <h:text/>
               </r:field>
               <r:field fieldName="emp_id_card_no" label="身份证">
                   <h:text/>
               </r:field>
               <r:field fieldName="bill_year_month" label="账单年月">
                   <h:text/>
               </r:field>
               <r:field fieldName="is_failure" label="是否错误" width="70">
                   <d:select dictTypeId="IS_FOREIGNER"/>
               </r:field>
               <r:field fieldName="failure_reason" label="错误原因" width="260">
                   <h:text/>
               </r:field>
               <r:field fieldName="d" label="派工单状态">
                   <h:text/>
               </r:field>
               <r:field fieldName="e" label="投保地点">
                   <h:text/>
               </r:field>
               <r:field fieldName="f" label="协议">
                   <h:text/>
               </r:field>
               <r:field fieldName="g" label="主供应商">
                   <h:text/>
               </r:field>
               <r:field fieldName="h" label="供应商分支机构">
                   <h:text/>
               </r:field>
               <r:field fieldName="i" label="商社编号">
                   <h:text/>
               </r:field>
               <r:field fieldName="j" label="辅助编号">
                   <h:text/>
               </r:field>
               <r:field fieldName="k" label="客户">
                   <h:text/>
               </r:field>
               <r:field fieldName="l" label="业务部">
                   <h:text/>
               </r:field>
               <r:field fieldName="m" label="业务员">
                   <h:text/>
               </r:field>
               <r:field fieldName="n" label="入职日期">
                   <h:text/>
               </r:field>
               <r:field fieldName="o" label="开始付费日期">
                   <h:text/>
               </r:field>
               <r:field fieldName="p" label="产品供应商">
                   <h:text/>
               </r:field>
               <r:field fieldName="q" label="数据年月">
                   <h:text/>
               </r:field>
               <r:field fieldName="r" label="个人缴费">
                   <h:text/>
               </r:field>
               <r:field fieldName="s" label="企业缴费">
                   <h:text/>
               </r:field>
               <r:field fieldName="t" label="合计缴费">
                   <h:text/>
               </r:field>
               <r:field fieldName="u" label="代理费用">
                   <h:text/>
               </r:field>
               <r:field fieldName="v" label="实付缴费">
                   <h:text/>
               </r:field>
               <r:field fieldName="w" label="工资合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="x" label="工资中扣除个人部分">
                   <h:text/>
               </r:field>
               <r:field fieldName="y" label="外地福利合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="z" label="服务费合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="aa" label="其他付费合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="ab" label="付费合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="ac" label="养老保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="ad" label="养老保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="ae" label="养老保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="af" label="养老保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="ag" label="养老保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ah" label="养老保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="ai" label="失业保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="aj" label="失业保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="ak" label="失业保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="al" label="失业保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="am" label="失业保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="an" label="失业保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="ao" label="工伤保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="ap" label="工伤保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="aq" label="工伤保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ar" label="工伤保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="as1" label="工伤保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="at" label="工伤保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="au" label="生育保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="av" label="生育保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="aw" label="生育保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ax" label="生育保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="ay" label="生育保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="az" label="生育保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="ba" label="基本医疗保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="bb" label="基本医疗保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bc" label="基本医疗保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bd" label="基本医疗保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="be" label="基本医疗保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bf" label="基本医疗保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="bg" label="大病附加保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="bh" label="大病附加保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bi" label="大病附加保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bj" label="大病附加保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bk" label="大病附加保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bl" label="大病附加保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="bm" label="综合保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="bn" label="综合保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bo" label="综合保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bp" label="综合保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bq" label="综合保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="br" label="综合保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="bs" label="住房公积金基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="bt" label="住房公积金个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bu" label="住房公积金个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bv" label="住房公积金企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="bw" label="住房公积金企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="bx" label="住房公积金支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="by1" label="补充住房公积金基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="bz" label="补充住房公积金个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="ca" label="补充住房公积金个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cb" label="补充住房公积金企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="cc" label="补充住房公积金企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cd" label="补充住房公积金支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="ce" label="综合福利金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cf" label="意外和补充医疗保障-全国金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cg" label="年度体检服务金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ch" label="员工活动金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ci" label="员工子女医疗保障金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cj" label="员工大病救助金金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ck" label="员工子女福利金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cl" label="员工住院补贴金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cm" label="供暖补贴金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cn" label="家庭财产保障金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="co" label="员工本人补充医疗保障金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cp" label="慰问与联谊金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cq" label="节日补贴金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cr" label="其他福利金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cs" label="探亲补助金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="ct" label="电影票金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cu" label="员工综合福利补助金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cv" label="丧葬补助金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cw" label="学习补助金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cx" label="员工重疾安康保障金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cy" label="员工综合福利-全国金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="cz" label="人身意外保障金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="da" label="北京服务费金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="db" label="服务费金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="dc" label="一次性付费社保个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="dd" label="一次性付费社保企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="de" label="一次性付费社保金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="df" label="一次性付费社保备注">
                   <h:text/>
               </r:field>
               <r:field fieldName="dg" label="一次性付费福利个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="dh" label="一次性付费福利企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="di" label="一次性付费福利金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="dj" label="一次性付费福利备注">
                   <h:text/>
               </r:field>
               <r:field fieldName="dk" label="基本工资">
                   <h:text/>
               </r:field>
               <r:field fieldName="dl" label="奖金">
                   <h:text/>
               </r:field>
               <r:field fieldName="dm" label="双薪">
                   <h:text/>
               </r:field>
               <r:field fieldName="dn" label="加班费">
                   <h:text/>
               </r:field>
               <r:field fieldName="do1" label="代报税金">
                   <h:text/>
               </r:field>
               <r:field fieldName="dp" label="补其他">
                   <h:text/>
               </r:field>
               <r:field fieldName="dq" label="年奖">
                   <h:text/>
               </r:field>
               <r:field fieldName="dr" label="补贴(计税)">
                   <h:text/>
               </r:field>
               <r:field fieldName="ds" label="津贴(免税)">
                   <h:text/>
               </r:field>
               <r:field fieldName="dt" label="劳务费">
                   <h:text/>
               </r:field>
               <r:field fieldName="du" label="备注">
                   <h:text/>
               </r:field>
               <r:field fieldName="create_user_name" label="导入人">
                   <h:text/>
               </r:field>
             </r:datacell>
     </form>
              
</body>
</html>
