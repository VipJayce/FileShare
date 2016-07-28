<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="rayoo.common.pub.UtilsDate"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>账单统计</title>
	<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
    }

	function simpleQuery_onClick(){  //简单的模糊查询
      var frm = $name("datacell_formid");
      //表单验证
      if(!checkForm(frm) ) {
          return false;
      }   
      $id("datacell1").paramFormId = "datacell_formid";
      $id("datacell1").loadData();
      $id("datacell1").refresh();
      return true;
  	}
  	
  	function simpleQuery_onClick1(){  //简单的模糊查询
      var frm = $name("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          return false;
      }

      $id("w_from_input").value="<%=UtilsDate.getDateStr(new Date())%>";
      $id("w_to_input").value="<%=UtilsDate.getDateStr(new Date())%>";
      $id("w_from_hidden").value="<%=UtilsDate.getDateStr(new Date())%>";
      $id("w_to_hidden").value="<%=UtilsDate.getDateStr(new Date())%>";
      $id("datacell1").paramFormId = "datacell_formid";
      $id("datacell1").loadData();
      $id("datacell1").refresh();
      return true;
    }
  	
  	 function ClickRow(name,id,card){
        $id("isClickQuery").value=true;
        $id("datacell1").loadData();
        $id("datacell2").refresh();
    }

     //选择客服
    function rtnFuncCS(arg){
        var lookup = $id("lk_cs");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#cust_id").val(arg[0]);        
        return false;
    }
    
    //选择供应商
    function rtnFuncAgent(arg){
        var lookup = $id("agent_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
</script>
	</head>
	<body>
	<h:form checkType="blur" name="datacell_formid" method="post" id="datacell_formid">
	<h:hidden name="cust_id" id="cust_id"/>
		<div id="right"><script language="javascript">
	writeTableTopFesco('出账查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
		<div class="ringht_s">
		<div id="ccChild0" class="search">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="174" rowspan="10" style="padding-top: 0;">
				<div class="search_title">查询条件</div>
				</td>
				<td />
				<td />
				<td></td>
				<td />
			</tr>
			<tr>
				<td align="right"><font color="red">* </font>账单年月</td>
				<td align="left"><h:text id="bill_year_month"
					property="currentbillym/pValue" name="bill_year_month"
					validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" />
				(格式YYYYMM)</td>
				<td align="right">公司名称</td>
				<td align="left"><input type="text" class="text_field"
					id="query_customer_name" name="query_customer_name"
					inputName="query_customer_name" maxLength="50" /></td>
				<td align="right">出账情况</td>
				<td " align="left"><d:select dictTypeId="bill_created_bd"
					nullLabel="全部..." id="bill_created_bd" name="bill_created_bd"></d:select>
				</td>
			</tr>
			<tr>
				<td align="right">客服</td>
				<td align="left"><w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" name="lk_cs"  lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" height="500" width="400" style="width:140px;" /></td>
				</td>
				<td align="right">出账时间</td>
				<td align="left"><w:date allowInput="false" id="w_from" name="date_from" format="yyyy-MM-dd" style="width:85px;" />
				<w:date allowInput="false" id="w_to" name="date_to" format="yyyy-MM-dd" style="width:85px;" /></td>
				<td align="right">供应商</td>
                <td " align="left"><w:lookup onReturnFunc="rtnFuncAgent" readonly="true" id="agent_id" name="agent_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" dialogTitle="选择供应商" height="500" width="700" style="width:185px">
                </w:lookup></td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			     <td><input name="button_ok_1" class="icon_3" style="" type="button" value='查询今日出账' onClick="javascript:simpleQuery_onClick1()"> 
                <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
			</tr>
		</table>
		</div>
    </h:form>
		<div id="ccParent1" class="button">
		<div class="button_right">
		<input class="a_1" type="button"   value="账单明细"    onClick="list2approvalItem();">
		</div>
		<div class="clear"></div>
		</div>
		<r:datacell id="datacell1"
			queryAction="/FAERP/AgentFinBillTwoAction.do?cmd=queryCreatedAgentBill" isCount="false"
			width="100%" xpath="AgentFinBillTwoVo" submitXpath="AgentFinBillTwoVo" readonly="true"
			paramFormId="datacell_formid" height="320px">
			<r:toolbar location="bottom" tools="nav,pagesize,info" />
			<r:field fieldName="agent_name" width="170px" label="供应商" sortAt="server">
            </r:field>
            <r:field fieldName="agent_code" width="100px" label="供应商编号" sortAt="server">
            </r:field>
			<r:field fieldName="cust_name" width="170px" label="公司名称" sortAt="server">
			</r:field>
			<r:field fieldName="cust_code" width="100px" label="客户唯一号" sortAt="server">
			</r:field>
			<r:field fieldName="cost_center_name" width="170px" label="成本中心" sortAt="server">
			</r:field>
			<r:field fieldName="bill_created_bd" width="62px" label="出账情况" sortAt="server">
			     <d:select dictTypeId="bill_created_bd"></d:select>
			</r:field>
			<r:field fieldName="bill_amount" width="150px" label="总金额" sortAt="server">
			</r:field>
            <r:field fieldName="bill_type_bd" width="100px" label="账单类型" sortAt="server">
               <d:select  dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd" name="bill_type_bd" />
            </r:field>
            <r:field fieldName="last_update_date" width="150px" label="出账时间"  sortAt="server">
                <w:date  />
            </r:field>
		</r:datacell></div>
		</div>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script language="javascript">
function list2approvalItem() {
	var dc = $id("datacell1");
	    var entity = dc.getActiveEntity();
	    if(!entity){
	        alert("请先选择一条记录");
	        return ;
	    }
	    if(!entity.getValue("id")){
	    	alert("该成本中心未出账或者账单数据有误！");
	    	return;
	    }
	    var bill_id = entity.getValue("id");
	    _$.ajax({
	        type : "post",
	        url : "/FAERP/AgentFinBillTwoAction.do?cmd=checklist2item&bill_id=" + bill_id,
	        dataType : "html",
	        success : function(data) {
	            if (data!=""&&data=="此账单无明细，数据可能异常。") {
	                alert(data);
	            } else {
	                if (bill_id) {
	                    //w为窗口宽度，h为高度
	                    var w = 1250;
	                    var h = 600;
	                    var l = 70;//(screen.width - w) / 2;
	                    var t = 70;//(screen.height - h) / 2;
	                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
	                    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
	                    var url = "/FAERP/AgentFinBillTwoAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
	                    window.open(url, 'newwindow', s);
	                }
	            }
	        }
	    });
}	
</script>
