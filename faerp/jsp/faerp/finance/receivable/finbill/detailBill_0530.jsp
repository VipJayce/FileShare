<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
<%@ page import="gap.authority.helper.LoginHelper" %>
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>账单明细查询</title>
<script language="javascript" src="<venus:base/>/jsp/faerp/finance/receivable/finbill/detaiBill.js" defer="defer"> </script>
	<!-- - <script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodify4approval.js"></script>-->
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
		function exportEXCEL_onClick(){
	        var bill_id = document.form.bill_id.value;
	        var cost_center_name = document.form.cost_center_name.value;
	        var bill_year_month = document.form.bill_year_month.value;
	        var bill_code = document.form.bill_code.value;
	        var login_name = document.form.login_name.value;
	        if(bill_id != null && bill_id !=""){
	            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillModifyReport.jsp?raq=bill_modify.raq&arg1="+bill_id+"&arg2="+cost_center_name+"&arg3="+bill_year_month+"&arg4="+bill_code+"&arg5="+login_name;
	            $id("datacell_formid").submit();
	        }else{
	           alert("数据异常，请联系管理员！");
	           return;
	        }
	    }
	    //查询
	    function select_onClick(){
                $id("datacell2").reload() ;
        }
   //writeTableTopFesco('账单明细查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
	<div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细</div>
    <table width="100%">
            <tr>
                <td align="center">员工姓名/唯一号:&nbsp;&nbsp;<input type="text" name="empnameorcode" id="empnameorcode" /></td>
                <td align="left"><input name="button1" type="button" class="icon_1" onclick="javascript:select_onClick();"  value="查 询" /></td>
                <td align="left"><input name="button2" type="button" class="icon_1" onclick="javascript:exportEXCEL_onClick();"  value="导出excel" /></td>
                <td ><li style="font-size:12px; font-weight:inherit; width:200px; margin-left:50%;">账单号：${billVo.bill_code }</li></td>
                <td align="right" ><li>账单金额：${billVo.bill_amount }</li></td>
                <td align="left"><li>&nbsp;</li></td>
            </tr>
     
     </table>
    <input type="hidden" value="${billVo.id }" name="bill_id" id="bid">
    
    <input type="hidden" value="${billVo.cost_center_name }" name="cost_center_name">
    <input type="hidden" value="${billVo.bill_year_month }" name="bill_year_month">
    <input type="hidden" value="${billVo.bill_code }" name="bill_code">
    <input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
    <!-- /FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell -->
	<div style="padding: 0 0 8 8;">
	          <r:datacell pageSize="51"
	        id="datacell2"
	        paramFormId="datacell_formid"
	        queryAction="#"
	        submitAction="/FAERP/BillmodifyAction.do?cmd=editSaveBillItem4DataCell"
	        width="98%"
	        height="304px"
	        xpath="/root/data/itemVo"
	        submitXpath="itemVo"
	        freezeNumber="4"
	        >
	        <r:toolbar location="bottom" tools="nav,pagesize,info" /><!-- 添加分页 谭彦军 -->
	        <r:field fieldName="sno" label="编号"></r:field>
	        <r:field fieldName="emp_name" label="姓名"></r:field>
	        <r:field fieldName="emp_code" label="唯一号"></r:field>
	        <r:field fieldName="service_year_month" label="服务年月"></r:field>
	        <logic:iterate name="titleList" id="smalltitles" scope="request" indexId="indexs">
	           <c:choose>
	               <c:when test="${smalltitles[0] == 1 }">
	                   <logic:iterate name="smalltitles" id="title" scope="page">
						  <c:choose>
						    <c:when test="${fn:contains(title, '_city') }">
						        <r:field fieldName="${title }" label="城市" groupval="${smalltitles[8] }" allowModify="true">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_base') }">
						        <r:field fieldName="${title }" label="基数" groupval="${smalltitles[8] }">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_amount') }">
						      <r:field fieldName="${title }" label="总额" groupval="${smalltitles[8] }" allowModify="false">
						      </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_eratio') }">
						       <r:field fieldName="${title }" label="单位比例" groupval="${smalltitles[8] }" allowModify="false">
						       </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_emoney') }">
						        <r:field fieldName="${title }" label="单位金额" groupval="${smalltitles[8] }" allowModify="false">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pratio') }">
						        <r:field fieldName="${title }" label="个人比例" groupval="${smalltitles[8] }" allowModify="false">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pmoney') }">
						        <r:field fieldName="${title }" label="个人金额" groupval="${smalltitles[8] }" allowModify="false">
						        </r:field>
						    </c:when>
						  </c:choose>
					   </logic:iterate>
	               </c:when>
	               <c:otherwise>
                       <r:field fieldName="${smalltitles[1] }" label="${fn:substring(smalltitles[2], 4, fn:length(smalltitles[2]))}" allowModify="true">
                       </r:field>
	               </c:otherwise>
	           </c:choose>
            </logic:iterate>
            <r:field fieldName="rightsum" label="合计">
                
            </r:field>
	    </r:datacell>
	    <table>
<tr><td>编号</td><td>姓名</td><td>唯一号</td><td>服务年月</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>城市</td><td>基数</td><td>总额</td><td>单位比例</td><td>单位金额</td><td>个人比例</td><td>个人金额</td><td>一次性收费</td><td>服务费</td></tr><tr><td>1</td><td>陈凯</td><td>1273757</td><td>201305</td><td>上海</td><td>10000.00</td><td>3000.00</td><td>0.22</td><td>2200.00</td><td>0.08</td><td>800.00</td><td>上海</td><td>10000.00</td><td>1400.00</td><td>0.12</td><td>1200.00</td><td>0.02</td><td>200.00</td><td>上海</td><td>10000.00</td><td>270.00</td><td>0.017</td><td>170.00</td><td>0.01</td><td>100.00</td><td>上海</td><td>10000.00</td><td>50.00</td><td>0.005</td><td>50.00</td><td>0.00</td><td>0.00</td><td>上海</td><td>10000.00</td><td>80.00</td><td>0.008</td><td>80.00</td><td>0.00</td><td>0.00</td><td>上海</td><td>10000.00</td><td>160.00</td><td>0.016</td><td>160.00</td><td>0.00</td><td>0.00</td><td>上海</td><td>12993.00</td><td>1820.00</td><td>0.07</td><td>910.00</td><td>0.07</td><td>910.00</td><td></td><td>-1.00</td><td>0.00</td><td></td><td></td><td></td><td></td><td></td><td>-1.00</td><td>0.00</td><td></td><td>0.00</td><td></td><td>0.00</td></tr><tr><td></td><td>合计</td><td></td><td></td><td></td><td></td><td>3000.0000</td><td></td><td>2200.0000</td><td></td><td>800.0000</td><td></td><td></td><td>1400.0000</td><td></td><td>1200.0000</td><td></td><td>200.0000</td><td></td><td></td><td>270.0000</td><td></td><td>170.0000</td><td></td><td>100.0000</td><td></td><td></td><td>50.0000</td><td></td><td>50.0000</td><td></td><td>0.0000</td><td></td><td></td><td>80.0000</td><td></td><td>80.0000</td><td></td><td>0.0000</td><td></td><td></td><td>160.0000</td><td></td><td>160.0000</td><td></td><td>0.0000</td><td></td><td></td><td>1820.0000</td><td></td><td>910.0000</td><td></td><td>910.0000</td><td></td><td></td><td>0.0000</td><td></td><td>0.0000</td><td></td><td>0.0000</td><td></td><td></td><td>0.0000</td><td></td><td>0.0000</td><td></td><td>0.0000</td></tr> 
  </table>
	    
	</div>
	<div class="xz_title" style="margin-top:10px;">一次收费项目表</div>
  	 <r:datacell id="celllist1"
			queryAction="/FAERP/FinbillAction.do?cmd=queryBillOther&bill_id=${billVo.id}"
			paramFormId="datacell_formid" width="100%" height="150px"
			xpath="BillOthersVo" readonly="true">
			
			<r:field fieldName="charge_item_bd" label="项目名称" width="435px">
				<d:select dictTypeId="CHARGE_ITEM_BD"/>
			</r:field>
			<r:field fieldName="amount" label="金额" width="235px">
			</r:field>
			<r:field fieldName="charge_desc" label="备注" width="300px">
				<h:text />
			</r:field>
			<r:field fieldName="last_update_date" label="时间" width="230px">
				<w:date format="yyyy-MM-dd"/>
			</r:field>
		</r:datacell>
	
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>


<script>

    //翻页事件
    
    $id("datacell2").gotoPage = function(pageParam) {
        this.pageParam = pageParam;
        this.reload();
        this.onPageChange();
    }
    
    
</script>
