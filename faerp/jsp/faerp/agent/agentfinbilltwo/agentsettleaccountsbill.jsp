<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
.fex_row_top
 {
  top:expression(document.getElementById('div_top').scrollTop-2); 
     position:relative; 
     z-index:1;
     background-color: #DEE7FE;
 }
</style>
<script language="JavaScript" src="../../scripts/common.js"></script>


<script type="text/javascript">
    function settle_accounts(){
            if(confirm("当前期次为${bill_year_month}，确定要结账么？")){
		            jQuery("#settleaccounts").attr("disabled", "disabled");
		                 var url="<%=request.getContextPath()%>/AgentFinBillTwoAction.do?cmd=AgentBillSettleAccounts&bill_year_month=${requestScope.bill_year_month}";
		                 url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
		                 jQuery.post(url,function(data){
			                   if(data!=""){
			                      alert(data);
			                      location.reload();
			                   }
		                });
            }
    }
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">账单结账</div></div>
    <div class="ringht_s">
   	<!--表格2-->
    <div class="box_3"></div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox" ><!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title">结账</div>
    <div class="box_3" style="height:30px;">
      <div><div style="width:500px; float:left;"> 本操作将对<span  style="color:red;font-size:1.1em">${requestScope.bill_year_month}</span>月份所有客户的应收、实收数据进行结账！&nbsp;结帐操作无法恢复！</div><div style="width:100px; float:right;"><span class="td_2">
        <input name="settleaccounts" id="settleaccounts" type="button"  class="icon_1" value="结账" onclick="settle_accounts()"/>
      </span></div> </div>
    </div>

    <!--表格 end-->
    </div>
    <!--社保公积金 end-->
    <!--福利项目--><!--福利项目 end-->
    </div>
</div>
</form>
</body>
</html>
