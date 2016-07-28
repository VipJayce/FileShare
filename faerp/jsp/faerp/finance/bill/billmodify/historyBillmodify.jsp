<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>账单明细查看</title>
	<script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/historybillmodify.js"></script>
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <script language="javascript">
        function exportEXCEL_onClick(){
	        var bill_id = $id("bill_id").value;
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
    </script>
</head>
<body onUnload="afterClose();">
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
   writeTableTopFesco('账单明细查看','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
	<div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细</div>
    <div class="button">
       <div class="button_right">
           <ul>
             <li class="e_3"><a href="###" onClick="javascript:exportEXCEL_onClick();">导出excel</a></li>
           </ul>
           <li style="font-size:12px; font-weight:inherit; width:300px; margin-left:70%;">账单号：${billVo.bill_code }</li>
         <div class="clear"></div>
       </div>
    </div>
    <input type="hidden" value="${billVo.cost_center_name }" name="cost_center_name">
    <input type="hidden" value="${billVo.bill_year_month }" name="bill_year_month">
    <input type="hidden" value="${billVo.bill_code }" name="bill_code">
    <input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
    <input type="hidden" value="${billVo.id }" name="bill_id" id="bill_id">
    <input type="hidden" value="${requestScope.bill_temp_id }" name="bill_temp_id" id="bill_temp_id">
    <!-- /FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell -->
	<div style="padding: 0 0 8 8;">
	        <r:datacell pageSize="51"
	        id="datacell2"
	        paramFormId="datacell_formid"
	        queryAction="#"
	        submitAction="#"
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
	        <r:field fieldName="service_year_month" label="服务年月"></r:field><!--
	        <r:field fieldName="bill_imp_type_db" label="收费属性"></r:field>
	        --><logic:iterate name="titleList" id="smalltitles" scope="request" indexId="indexs">
	           <c:choose>
	               <c:when test="${smalltitles[0] == 1 }">
	                   <logic:iterate name="smalltitles" id="title" scope="page">
						  <c:choose>
						    <c:when test="${fn:contains(title, '_city') }">
						        <r:field fieldName="${title }" label="城市" groupval="${smalltitles[8] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_base') }">
						        <r:field fieldName="${title }" label="基数" groupval="${smalltitles[8] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_amount') }">
						    
						      <r:field fieldName="${title }" label="总额" groupval="${smalltitles[8] }" allowModify="true" width="70">
						      </r:field>
						      
						    </c:when>
						    <c:when test="${fn:contains(title, '_eratio') }">
						       <r:field fieldName="${title }" label="单位比例" groupval="${smalltitles[8] }" allowModify="true" width="70">
						       </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_emoney') }">
						        <r:field fieldName="${title }" label="单位金额" groupval="${smalltitles[8] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pratio') }">
						        <r:field fieldName="${title }" label="个人比例" groupval="${smalltitles[8] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pmoney') }">
						        <r:field fieldName="${title }" label="个人金额" groupval="${smalltitles[8] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_bill_imp_type_db') }">
						        <r:field fieldName="${title }" label="收费属性" groupval="${smalltitles[9] }" allowModify="true" width="70">
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
	 <div class="foot_button">
       <input type="button" onclick="javascript:history.go(-1);" value="返回" class="foot_icon_1">
    </div>
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


    function closewin () {
        afterClose();
        window.close();
    }
</script>
