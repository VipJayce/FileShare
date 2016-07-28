<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.adjustarrearage.finbilladjust.vo.FinbilladjustVo" %>
<%@ page import="rayoo.finance.adjustarrearage.finbilladjust.util.IFinbilladjustConstants" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("id") + "');\">";
     }
         function ClickRow(value){
    document.getElementById("cid").value=value;
    }

    function simpleQuery_onClick(){  //简单的模糊查询
    var billyear1=document.getElementById("bill_year_month1").value;
    var billyear2=document.getElementById("bill_year_month2").value;
    var adjustamount1=document.getElementById("adjust_amount1").value;
    var adjustamount2=document.getElementById("adjust_amount2").value;
    var check=/^[0-9]{4}(0[1-9])|(1[0-2])$/;
    var frm = $name("datacell1");
    if((billyear1!=null&&billyear1!="")&&(billyear2==null || billyear2=="")) {
        if(!check.test(billyear1)){
            alert("应收年月格式错误！正确格式如：200301");
            return;
            }
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
       return;
    }
    if((billyear2!=null&&billyear2!="")&&(billyear1==null || billyear1=="")) {
        if(!check.test(billyear2)){
            alert("应收年月格式错误！正确格式如：200301");
            return;
            }
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
       return;
    }
    if((billyear1!=null&&billyear1!="")&&(billyear2!=null&&billyear2!="")) {
        if(billyear1>billyear2){
        alert("应收年月区间填写错误！");
        return;
        }
        if((check.test(billyear1))&& (check.test(billyear2))){
           $id("datacell1").paramFormId = "datacell_formid";
           $id("datacell1").loadData();
           $id("datacell1").refresh();
           return;
           }
              alert("应收年月格式错误！正确格式如：200301");
              return;
    }
    if((adjustamount1!=null&&adjustamount1!="")&&(adjustamount2!=null&&adjustamount2!="")){
           if(adjustamount1>adjustamount2){
                alert("调整金额区间错误，请检查");
                return;
           }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        return;
    }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
function showWindow(){
         var id=document.getElementById("cid").value;
         if(id==null || id==""){
          alert("请选择一条记录!");
          return;
         }
          var url="<%=request.getContextPath()%>/jsp/faerp/finance/adjustarrearage/finbilladjust/adjustarrearage.jsp?cid="+id;
          showModalCenter(url, window,refesh,600,400,"调整金额");
      }
function refesh()
    {
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    _$(document).ready(function() {
            if ($id("lk_cust")) {
                $id("lk_cust").onReturnFunc = function (returnValue){
                    var lookup = $id("lk_cust");
                    lookup.value = returnValue[0];
                    _$("#cust_name").val(returnValue[2]);
                    lookup.displayValue = returnValue[2];
                    $id("cost_center_id").addParam("cust_id", returnValue[0]);
                    $id("cost_center_id").loadData();
                    $id("cost_center_id").refresh();
                    return false;
                }
            }
    });
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" >
<div id="right">
<script language="javascript">
	writeTableTopFesco('调整欠款','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
 <div class="ringht_s">
<div id="ccChild0" class="search"> 
<input type="hidden" id="cid" name="cid"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
        <tr>
          <td align="right">选择客户&nbsp</td>
                <td align="left"><w:lookup readonly="true" id="lk_cust"
                    lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                    dialogTitle="选择客户" height="500" width="600" /></td>
                     <input type="hidden" name="cust_name" id="cust_name">
                </td>
                <td align="right">成本中心&nbsp</td>
            <td align="left">
            <r:comboSelect id="cost_center_id" name="cost_center_id"
               queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                textField="cost_center_name"
                valueField="id"
                xpath="CostcenterVo"
                width="180" nullText="--请选择--">
            </r:comboSelect>
            </td>
            <td align="right" >调整状态&nbsp</td>
        <td align="left">
             <d:select  name="adjust_status_bd1" id="adjust_status_bd1" dictTypeId="ADJUST_STATUS_BD" nullLabel="--请选择--"/>
        </td>
        </tr>
        <tr>
        <td align="right">应收年月&nbsp</td>
            <td align="left"><input  type="text" name="bill_year_month1" id="bill_year_month1"  style="width:74px"/>&nbsp<input  type="text" name="bill_year_month2" id="bill_year_month2" style="width:74px"/> </td>
       <td align="right">调整日期（大于）</td>
       <td align="left"><w:date allowInput="false" id="adjust_date1"
                    name="adjust_date1" format="yyyy-MM-dd" style="width:142px;" /> </td>
                     <td align="right">调整日期（小于）</td>
       <td align="left"><w:date allowInput="false" id="adjust_date2"
                    name="adjust_date2" format="yyyy-MM-dd" style="width:142px;" /> </td>
        </tr>
        <tr>
       <td align="right">调整金额（大于）</td>
       <td align="left"><input  type="text" name="adjust_amount1" id="adjust_amount1" /> </td>
       <td align="right">调整金额（小于）</td>
       <td align="left"><input  type="text" name="adjust_amount2" id="adjust_amount2" /> </td>
        </tr>
        <tr>
           <td> <td/>
          <td>  <td/>
          <td/>
          <td/>
           <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="reset" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
            </td>
                <td/>
        </tr>
</table>
</div> 
</form>
    <div id="ccParent1" class="button">
        <div class="button_right">
				<!--<ul>
					<li class="b">  	<a  onClick="javascript:showWindow();">提交调整 </a> </li>
				</ul>
	--><input class="b" type="button"   value="提交调整"  <au:authorityBtn code="qktz_tjtz" type="1"/>  onClick="showWindow();">
		 </div>
		 <div class="clear"></div>
</div>

 <r:datacell id="datacell1"
            queryAction="/FAERP/FinbilladjustAction.do?cmd=queryAdjustArrearage" 
            isCount="false"
            width="100%" 
            xpath="FinbilladjustVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="320px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
             <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
            <r:field fieldName="cust_code" width="100px" label="客户唯一号">
            </r:field>
            <r:field fieldName="cust_name" width="250px" label="客户名称">
            </r:field>
            <r:field fieldName="cost_center_name" width="250px" label="成本中心">
            </r:field>
            <r:field fieldName="bill_year_month" width="150px" label="应收年月">
            </r:field>
            <r:field fieldName="bill_type_bd" width="100px" label="应收类型">
          <d:select  dictTypeId="FB_BILL_TYPE_BD" id="bill_type_bd" name="bill_type_bd" />
            </r:field>
            <r:field fieldName="bill_amount" width="150px" label="应收金额" >
            </r:field>
              <r:field fieldName="verification_amount" width="150px" label="实收金额" >
            </r:field>
              <r:field fieldName="adjust_date" width="150px" label="调整日期" >
            </r:field>
              <r:field fieldName="adjust_amout" width="150px" label="调整金额" >
            </r:field>
              <r:field fieldName="adjust_desc" width="150px" label="调整备注" >
            </r:field>
              <r:field fieldName="name" width="150px" label="申请人" >
            </r:field>
              <r:field fieldName="adjust_status_bd" width="150px" label="状态" >
            <d:select  dictTypeId="ADJUST_STATUS_BD" id="adjust_status_bd" name="adjust_status_bd" />
            </r:field>
        </r:datacell></div>
</div>

</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
