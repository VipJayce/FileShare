<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>查看明细</title>
</head>

<body>
<form id="formItem" action="" method="post"> 
<input type="hidden" id="batchid" name="batchid" value="<%=request.getParameter("batchId")%>"/>
<input type="hidden" id="emp_id" name="emp_id" value="<%=request.getParameter("emp_id")%>"/>
<input type="hidden" id="h_cmd" name="cmd" />
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">查看明细</div>
	</div>
  <div class="ringht_s">
    <!--表格 -->
    <r:datacell id="dc_salary_data" 
        width="100%"
        freezeNumber="2"
        paramFormId="formItem"
        queryAction="/FAERP/SalaryorderreleaseAction.do?cmd=orderreleasedetail"
        submitAction="/FAERP/SalaryorderreleaseAction.do?cmd=update"
	    submitXpath="SalarydataVo" 
	    xpath="SalarydataVo">
	  <r:toolbar  tools="nav,pagesize,info"/>
	  
	  <r:field fieldName="emp_code" label="唯一号">
	    
	  </r:field>
	  <r:field fieldName="emp_name" label="姓名">
	    
	  </r:field>
	  <r:field fieldName="pay_year_month" label="年月">
	    
	  </r:field>
	  <r:field fieldName="def1" label="应发合计">
	    
	  </r:field>
	  <r:field fieldName="def2" label="扣款合计">
	    
	  </r:field>
	  <r:field fieldName="def3" label="实发合计">
	    
	  </r:field>
	  <r:field fieldName="def4" label="税前总额">
	    
	  </r:field>
	  <r:field fieldName="def5" label="扣税基数">
	    
	  </r:field>
	  <r:field fieldName="def6" label="本次扣税">
	    
	  </r:field>
	  <r:field fieldName="def7" label="基本工资">
	    
	  </r:field>
	  <r:field fieldName="def8" label="加班费">
	    
	  </r:field>
	  <r:field fieldName="def9" label="补贴">
	    
	  </r:field>
	  <r:field fieldName="def10" label="补其他">
	    
	  </r:field>
	  <r:field fieldName="def11" label="十三薪">
	    
	  </r:field>
	  <r:field fieldName="def12" label="奖金">
	    
	  </r:field>
	  <r:field fieldName="def13" label="年终奖金">
	    
	  </r:field>
	  <r:field fieldName="def14" label="社保基数">
	    
	  </r:field>
	  <r:field fieldName="def15" label="养老自付">
	    
	  </r:field>
	  <r:field fieldName="def16" label="医疗支付">
	    
	  </r:field>
	  <r:field fieldName="def17" label="失业支付">
	    
	  </r:field>
	  <r:field fieldName="def19" label="公积金基数">
	    
	  </r:field>
	  <r:field fieldName="def18" label="公积金支付">
	    
	  </r:field>
	  <r:field fieldName="def20" label="个人社保总计">
	    
	  </r:field>
	  <r:field fieldName="def21" label="补充公积金（企业部分）">
	    
	  </r:field>
	  <r:field fieldName="def22" label="补充公积金（个人部分）">
	    
	  </r:field>
	  <r:field fieldName="def23" label="税后扣除">
	    
	  </r:field>
	  <r:field fieldName="def24" label="税后增加">
	    
	  </r:field>
	  <r:field fieldName="def25" label="工资代收代付">
	    
	  </r:field>
	  <r:field fieldName="def26" label="备注">
	    
	  </r:field>
	  <!-- 
	  <r:field fieldName="def27" label="def27">
	    
	  </r:field>
	  <r:field fieldName="def29" label="def29">
	    
	  </r:field>
	  <r:field fieldName="def28" label="def28">
	    
	  </r:field>
	  <r:field fieldName="def30" label="def30">
	    
	  </r:field>
	  <r:field fieldName="def31" label="def31">
	    
	  </r:field>
	  <r:field fieldName="def32" label="def32">
	    
	  </r:field>
	  <r:field fieldName="def33" label="def33">
	    
	  </r:field>
	  <r:field fieldName="def34" label="def34">
	    
	  </r:field>
	  <r:field fieldName="def35" label="def35">
	    
	  </r:field>
	  <r:field fieldName="def36" label="def36">
	    
	  </r:field>
	  <r:field fieldName="def37" label="def37">
	    
	  </r:field>
	  <r:field fieldName="def38" label="def38">
	    
	  </r:field> -->
	</r:datacell>
    <!--表格 end-->
	<div class="foot_button">
	  <input onclick="location.href='javascript:history.go(-1);'" type="button" class="foot_icon_1" value="返回"/>
	  <input onclick="exportPayroll()" type="button" class="foot_icon_3" value="导出excel工资条"/>
	  <input onclick="exportDetail()" type="button" class="foot_icon_2" value="导出excel"/>
	</div>
  </div>
</div>
</form>
</body>
<script type="text/javascript">
jQuery(function(){
    //$id("dc_sa_pay_audit").isQueryFirst = false;
});

//导出薪资明细
function exportDetail(){
    //var batchid = $id("batchid").value;
    //var emp_id = $id("emp_id").value;
    $id("formItem").action = "<%=request.getContextPath()%>/SalaryorderreleaseAction.do?cmd=expSalaryOrderReleaseDetail" ;
    $id("formItem").submit();
}
//导出薪资明细
function exportPayroll(){
   // var batchid = $id("batchid").value;
    //var emp_id = $id("emp_id").value;
    $id("formItem").action = "<%=request.getContextPath()%>/SalaryorderreleaseAction.do?cmd=expPayroll" ;
    $id("formItem").submit();
}
</script>
</html>
