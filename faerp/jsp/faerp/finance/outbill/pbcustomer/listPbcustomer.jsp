<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="rayoo.common.pub.UtilsDate"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.finance.outbill.pbcustomer.vo.PbcustomerVo"%>
<%@ page
	import="rayoo.finance.outbill.pbcustomer.util.IPbcustomerConstants"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.finance.outbill.pbcustomer.pbcustomer_resource" prefix="rayoo.finance.outbill.pbcustomer.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	<script language="javascript">
 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
    }



	function simpleQuery_onClick(){  //简单的模糊查询
        var frm = $name("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
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
  ///      $id("datacell1").addParam("query_customer_name",customer_name);
        $id("datacell1").loadData();
        $id("datacell2").refresh();
    }
  	
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/finance/outbill/pbcustomer/insertPbcustomer.jsp";
		form.submit();
	}


         //选择客服
        function rtnFuncCS(arg){
            var lookup = $id("lk_cs");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            jQuery("#cust_id").val(arg[0]);        
            return false;
        }
</script>
	</head>
	<body>

	<h:form checkType="blur" name="datacell_formid" method="post" id="datacell_formid">
	<h:hidden name="cust_id" id="cust_id"/>

		<div id="right"><script language="javascript">
	writeTableTopFesco("<fmt:message key='page_pbcustomer'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
		<div class="ringht_s">


		<div id="ccChild0" class="search">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
				<td width="174" rowspan="10" style="padding-top: 0;">
				<div class="search_title"><fmt:message key='title_search'/></div>
				</td>

				<td />
				<td />
				<td></td>
				<td />
			</tr>
			<tr>
				<td align="right"><font color="red">* </font><fmt:message key='bill_year_month'/></td>
				<td align="left"><h:text id="bill_year_month"
					property="currentbillym/pValue" name="bill_year_month"
					validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" />
				<fmt:message key='date_format'/></td>

				<td align="right"><fmt:message key='query_customer_name'/></td>
				<td align="left"><input type="text" class="text_field"
					id="query_customer_name" name="query_customer_name"
					inputName="query_customer_name" maxLength="50" /></td>
				<td align="right"><fmt:message key='bill_created_bd'/></td>
				<td " align="left"><d:select dictTypeId="bill_created_bd"
					nullLabel="全部..." id="bill_created_bd" name="bill_created_bd"></d:select>

				</td>
				<td align="right"></td>
				<td align="left"></td>
				<td align="right"></td>
			</tr>

			<tr>
				<td align="right"><fmt:message key='lk_cs'/></td>
				<td align="left"><w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" name="lk_cs"  lookupUrl="/CustServiceAction.do?cmd=toCustService" messagekey="select_lk_cs" height="500" width="400" /></td>
				</td>

				<td align="right"><fmt:message key='date_from'/></td>
				<td align="left"><w:date allowInput="false" id="w_from" name="date_from" format="yyyy-MM-dd" style="width:90px;" />
				<w:date allowInput="false" id="w_to" name="date_to" format="yyyy-MM-dd" style="width:90px;" /></td>
				<td><input name="button_ok_1" class="icon_3" style="" type="button" value='<fmt:message key="query1"/>' onClick="javascript:simpleQuery_onClick1()"> 
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()"></td>
				<td />
			</tr>
		</table>
		</div>
    </h:form>
		<div id="ccParent1" class="button">
		<div class="button_right">
		<!--<ul>
			<li class="a"><a onClick="javascript:viewBillDetail();">账单明细</a>
			</li>
			<li class="a"><a onClick="javascript:goGenBill();">生成账单</a>
			</li>
		</ul>
		--><input class="a_1" type="button"   value="<fmt:message key='zdmx'/>"  <au:authorityBtn code="cztj_zdmx" type="1"/>  onClick="list2approvalItem();">
		<!-- input class="a_1" type="button"   value="生成账单"  <au:authorityBtn code="cztj_sczd" type="1"/>  onClick="goGenBill();"> -->
		</div>
		<div class="clear"></div>
		</div>

		<r:datacell id="datacell1"
			queryAction="/FAERP/PbcustomerAction.do?cmd=queryCreatedBill" isCount="false"
			width="100%" xpath="BillCreatedInfoVo" submitXpath="BillCreatedInfoVo" readonly="true"
			paramFormId="datacell_formid" height="320px">
			<r:toolbar location="bottom" tools="nav,pagesize,info" />

			<r:field fieldName="customer_name" width="250px" messagekey="customer_name" sortAt="server">
			</r:field>
			<r:field fieldName="customer_code" width="100px" messagekey="customer_code" sortAt="server">
			</r:field>
			<r:field fieldName="cost_center_name" width="250px" messagekey="cost_center_name" sortAt="server">
			</r:field>
			<r:field fieldName="bill_created_bd" width="62px" messagekey="bill_created_bd" sortAt="server">
			     <d:select dictTypeId="bill_created_bd"></d:select>
			</r:field>
			<r:field fieldName="bill_amount" width="150px" messagekey="bill_amount" sortAt="server">
			</r:field>
            <r:field fieldName="bill_type_bd" width="100px" messagekey="bill_type_bd" sortAt="server">
               <d:select  dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd" name="bill_type_bd" />
            </r:field>
            <r:field fieldName="last_update_date" width="150px" messagekey="date_from"  sortAt="server">
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

function goGenBill() {
  
    var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var cost_center_id = entity.getValue("cost_center_id");
    var bill_year_month = $id("bill_year_month").getValue();

     if (cost_center_id && bill_year_month) {
         window.location.href =  "'/FAERP/BillCreateAction.do?cmd=queryAll&cost_center_id=" + cost_center_id+"&bill_year_month="+bill_year_month;
     }


}
function viewBillDetail() {
  
    var dc = $id("datacell1");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var bill_id = entity.getValue("bill_id");
    alert(bill_id);
    _$.ajax({
        type : "post",
        url : "/FAERP/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data) {
                alert(data);
            } else {
                if (bill_id) {
                    window.location.href =  "/FAERP/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                }
            }
        }
    });

}

function list2approvalItem() {
	var dc = $id("datacell1");
	    var entity = dc.getActiveEntity();
	    //alert(entity.getValue("bill_id"));
	    if(!entity){
	        alert("<fmt:message key='alert_select_one'/>");
	        return ;
	    }
	    if(!entity.getValue("bill_id")){
	    	alert("<fmt:message key='alert_cost_center_err'/>");
	    	return;
	    }
	    var bill_id = entity.getValue("bill_id");
	    _$.ajax({
	        type : "post",
	        url : "/FAERP/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
	        dataType : "html",
	        success : function(data) {
	            if (data!=""&&data=="此账单无明细，数据可能异常。") {
	                alert("<fmt:message key='alert_err'/>");
	            } else {
	                if (bill_id) {
	                    //w为窗口宽度，h为高度
	                    var w = 1250;
	                    var h = 600;
	                    var l = 70;//(screen.width - w) / 2;
	                    var t = 70;//(screen.height - h) / 2;
	                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
	                    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
	                    var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
	                    window.open(url, 'newwindow', s);
	                    //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
	                }
	            }
	        }
	    });
}	

</script>
