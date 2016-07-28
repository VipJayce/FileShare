<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.billimport.finbillimpdatacountry.vo.FinbillimpdatacountryVo" %>
<%@ page import="rayoo.finance.billimport.finbillimpdatacountry.util.IFinbillimpdatacountryConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	String id = request.getParameter("cid")==null?"":request.getParameter("cid");
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid">
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	全国系统账单导入明细
	 </div>
	 </div>
	 </div>
<input type="hidden" name="cid"  id="cid" value="<%=id %>">
  <r:datacell 
               id="celllist2"
               queryAction="/FAERP/FinbillimpbatchnAction.do?cmd=queryNationalSystemBill&cid=<%=id %>"
               width="100%"
               height="360px" 
               xpath="FinbillimpdatacountryVo"
               paramFormId="datacell_formid"
               >
               
               <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       
               <r:field fieldName="failure_reason" label="异常原因" width="300px">
               </r:field>
               <r:field fieldName="cust_name" label="客户名称" width="300px">
               </r:field>
               <r:field fieldName="cust_code" label="客户编号">
               </r:field>
               <r:field fieldName="emp_name" label="姓名">
               </r:field>
               <r:field fieldName="emp_code" label="唯一号">
               </r:field>
               <r:field fieldName="emp_id_card_no" label="身份证" width="150px">
               </r:field>
               <r:field fieldName="a1" label="合同号" width="200px">
               </r:field>
               <r:field fieldName="a2" label="内部编号">
               </r:field>
               <r:field fieldName="a3" label="协议" width="150px">
               </r:field>
               <r:field fieldName="a4" label="主供应商" width="300px">
               </r:field>
               <r:field fieldName="a5" label="供应商分支机构" width="300pxs">
               </r:field>
               <r:field fieldName="a6" label="客户分支机构" width="300px">
               </r:field>
               <r:field fieldName="a7" label="业务部" width="150px">
               </r:field>
               <r:field fieldName="a8" label="业务员">
               </r:field>
               <r:field fieldName="a9" label="入职日期">
               </r:field>
               <r:field fieldName="a10" label="开始收费日期">
               </r:field>
               <r:field fieldName="a11" label="产品供应商">
               </r:field>
               <r:field fieldName="a12" label="数据年月">
               </r:field>
               <r:field fieldName="a13" label="个人缴费">
               </r:field>
               <r:field fieldName="a14" label="企业缴费">
               </r:field>
               <r:field fieldName="a15" label="合计缴费">
               </r:field>
               <r:field fieldName="a16" label="代理费用">
               </r:field>
               <r:field fieldName="a17" label="实用缴费">
                   <h:text/>
               </r:field>
               <r:field fieldName="a18" label="工资合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="a19" label="工资中扣除个人部分">
                   <h:text/>
               </r:field>
               <r:field fieldName="a20" label="北京福利合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="a21" label="外地福利合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="a22" label="服务费合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="a23" label="收费合计">
                   <h:text/>
               </r:field>
               <r:field fieldName="a24" label="养老保险基数">
                   <h:text/>
               </r:field>
               <r:field fieldName="a25" label="养老保险个人比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="a26" label="养老保险个人金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="a27" label="养老保险企业比例">
                   <h:text/>
               </r:field>
               <r:field fieldName="a28" label="养老保险企业金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="a29" label="养老保险金额">
                   <h:text/>
               </r:field>
               <r:field fieldName="a30" label="养老保险支付方式">
                   <h:text/>
               </r:field>
               <r:field fieldName="a31" label="失业保险基数">
                   <h:text/>
               </r:field>
                <r:field fieldName="a32" label="失业保险个人比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a33" label="失业保险个人金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a34" label="失业保险企业比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a35" label="失业保险企业金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a36" label="失业保险金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a37" label="失业保险支付方式">
                   <h:text/>
               </r:field>
                <r:field fieldName="a38" label="工伤保险基数">
                   <h:text/>
               </r:field>
                <r:field fieldName="a39" label="工伤保险个人比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a40" label="工伤保险个人金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a41" label="工伤保险企业比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a42" label= "工伤保险企业金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a43" label="工伤保险金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a44" label="工伤保险支付方式">
                   <h:text/>
               </r:field>
                <r:field fieldName="a45" label="生育保险基数">
                   <h:text/>
               </r:field>
                <r:field fieldName="a46" label="生育保险个人比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a47" label="生育保险个人金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a48" label="生育保险企业比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a49" label="生育保险企业金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a50" label="生育保险金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a51" label="生育保险支付方式">
                   <h:text/>
               </r:field>
                <r:field fieldName="a52" label="基本医疗保险基数">
                   <h:text/>
               </r:field>
                <r:field fieldName="a53" label="基本医疗保险个人比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a54" label="基本医疗保险个人金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a55" label="基本医疗保险企业比例">
                   <h:text/>
               </r:field>
                <r:field fieldName="a56" label="基本医疗保险企业金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a57" label="基本医疗保险金额">
                   <h:text/>
               </r:field>
                <r:field fieldName="a58" label="基本医疗保险支付方式">
                   <h:text/>
               </r:field>
                <r:field fieldName="a59" label="大病附加保险基数">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a60" label="大病附加保险个人比例">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a61" label="大病附加保险个人金额">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a62" label="大病附加保险企业比例">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a63" label="大病附加保险企业金额">
                   <h:text/>
               </r:field>
         
                 <r:field fieldName="a64" label="大病附加保险金额">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a65" label="大病附加保险支付方式">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a66" label="综合保险基数">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a67" label="综合保险个人比例">
                   <h:text/>
               </r:field>
          
                 <r:field fieldName="a68" label="综合保险个人金额">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a69" label="综合保险企业比例">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a70" label="综合保险企业金额">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a71" label="综合保险金额">
                   <h:text/>
               </r:field> 
             
                <r:field fieldName="a72" label="综合保险支付方式">
                   <h:text/>
               </r:field>
            
                    <r:field fieldName="a73" label="住房公积金基数">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a74" label="住房公积金个人比例">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a75" label="住房公积金个人金额">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a76" label="住房公积金企业比例">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a77" label="住房公积金企业金额">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a78" label="住房公积金金额">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a79" label="住房公积金支付方式">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a80" label="北京服务费金额">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a81" label="北京服务费支付方式">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a82" label="服务费金额">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a83" label="服务费支付方式">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a84" label="一次性收费个人社保金额">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a85" label="一次性收费企业社保金额">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a86" label="一次性收费社保金额">
                   <h:text/>
               </r:field>
             
   <r:field fieldName="a87" label="一次性收费社保备注">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a88" label="一次性收费社保支付方式">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a89" label="一次性收费福利个人金额">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a90" label="一次性收费福利企业金额">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a91" label="一次性收费福利金额">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a92" label="一次性收费福利备注">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a93" label="补充住房公积金基数">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a94" label="补充住房公积金个人比例">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a95" label="补充住房公积金个人金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a96" label="补充住房公积金企业比例">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a97" label="补充住房公积金企业金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a139" label="补充住房公积金额">
                   <h:text/>
               </r:field>
                 <r:field fieldName="a98" label="补充住房公积支付方式">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a99" label="投保城市">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a100" label="基本工资">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a101" label="奖金">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a102" label="双薪">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a103" label="加班费">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a104" label="代报税金">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a105" label="补其他">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a106" label="年奖">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a107" label="补贴（计税）">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a108" label="津贴（免税）">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a109" label="备注">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a110" label="离岗补贴金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a111" label="服装费金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a112" label="综合福利金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a113" label="人身意外保障金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a114" label="体检保健金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a115" label="员工活动金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a116" label="子女医疗保险金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a117" label="重大疾病金额">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a118" label="独生子女福利金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a119" label="住院补贴金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a120" label="降温取暖费金额">
                   <h:text/>
               </r:field>
            
                 <r:field fieldName="a121" label="家庭财产保障金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a122" label="风险补助金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a123" label="营业税金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a124" label="补充医疗保障金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a125" label="存档费金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a126" label="慰问与联谊金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a127" label="代发工资金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a128" label="节日补贴金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a129" label="生日礼品金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a130" label="旅游金额">
                   <h:text/>
               </r:field>
                
                 <r:field fieldName="a131" label="其他福利金额">
                   <h:text/>
               </r:field>
                 
                 <r:field fieldName="a132" label="补助医疗金金额">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a133" label="商业保险金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a134" label="探亲福利金额">
                   <h:text/>
               </r:field>
              
                 <r:field fieldName="a135" label="联谊金额">
                   <h:text/>
               </r:field>
             
                 <r:field fieldName="a136" label="子女门诊医疗金额">
                   <h:text/>
               </r:field>
               
                 <r:field fieldName="a137" label="子女意外或住院金额">
                   <h:text/>
               </r:field>
           
                 <r:field fieldName="a138" label="职称评定金额">
                   <h:text/>
               </r:field>
           
             </r:datacell>
</fmt:bundle>
</form>
</body>
</html>
