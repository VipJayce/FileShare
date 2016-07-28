<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<!-- 此页面全部单选操作，没有批量操作 -->
<fmt:bundle basename="rayoo.salary.issue.calculation.calculation_resource" prefix="rayoo.salary.issue.calculation.">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key='calculation'/></title>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='calculation'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='calculation_search'/></div> </td>
    </tr>
    <tr>
        <td align="left"><fmt:message key='salary_type'/></td>
        <td align="left">
             <w:lookup onReturnFunc="clz_rtnFunc" readonly="true"
                id="sa_class_id" name="sa_class_id" lookupUrl="/SalaryclassAction.do?cmd=toSalartClzLookup"
                messagekey="select_salaryclass" height="500" width="810" style="width:187px;" />
        </td>
        <td align="left"><fmt:message key='sa_batch_code'/></td>
        <td align="left">
            <input name="sa_batch_code" class="text_field" maxLength="50" value="">
        </td>
    </tr>
    <tr>
        <td align="left">工资所属年月</td>
        <td align="left">
            <input type="text" name="salary_year_month" id="salary_year_month" class="text_field"  value="">
        </td>
        <td align="left" colspan="6">
             <input onclick="listquery();" id="batchListquery" class="icon_1" type="button" value="<fmt:message key='button_search'/>"/>
        </td>
    </tr>
</table>
    
</div>

<div class="button_right" style="margin: 5px;">
   <input class="dj_3" type="button"   value="薪资重算"  onClick="salaryReCal();">
</div>
<div class="clear"></div>
<div style="padding: 0 0 8 8;">
    <r:datacell 
        id="batchListdatacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/SalarybatchAction.do?cmd=queryAll4datacell"
        width="98%"
        height="304px"
        pageSize="100"
        xpath="SalarybatchVo"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="sa_batch_code" messagekey="sa_batch_code" width="100px;"></r:field>
      <r:field fieldName="batch_code_qg" messagekey="batch_code_qg" width="120px;"></r:field>
      <r:field fieldName="pay_name" messagekey="pay_name" width="100px;"></r:field>
      <r:field fieldName="pay_year_month" messagekey="pay_year_month"></r:field>
      <r:field fieldName="sa_class_name" messagekey="salary_type" width="200px;"></r:field>
      <r:field fieldName="tax_month" messagekey="tax_month"></r:field>
      <r:field fieldName="create_date" messagekey="create_date" allowModify="false">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="is_verify" messagekey="is_verify" allowModify="false">
        <d:select dictTypeId="TrueOrFalse"></d:select>
      </r:field>
      <r:field fieldName="verify_time" messagekey="verify_time" allowModify="false">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="bill_year_month" messagekey="bill_year_month"></r:field>
      
      <r:field  fieldName="reject_reason" label="驳回原因" allowModify="false">
         <d:select name= "reject_reason" id="reject_reason" dictTypeId= "REJECT_REASON" ></d:select >
      </r:field>
      <r:field  fieldName="reject_number" label="驳回人数">
      
      </r:field>
      <r:field fieldName="reject_cause" label="驳回备注" width="146px;"></r:field>
      <r:field fieldName="apply_state" messagekey="apply_state" allowModify="false">
        <h:select name="list_apply_state" property="apply_state">
            <h:option value="0" label="未申请"></h:option>
            <h:option value="1" label="已申请"></h:option>
        </h:select>
      </r:field>
      <r:field fieldName="delete_verify_state" label="删除审核状态" width="0px;"></r:field>
      <r:field fieldName="pay_state" label="发放状态" width="0px;"></r:field>
      <r:field fieldName="apply_pay_state" label="发放申请状态" width="0px;"></r:field>
      <r:field  fieldName="total_amount" label="总金额" ></r:field>
    </r:datacell>
</div>
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script language="javascript">
if (${msg != null } && ${msg != "" }) {
    alert('${msg}');
}
_$(function(){
    $id("batchListdatacell").isQueryFirst = false;
});

/**
 * batchList页面点击查询按钮
 */
function listquery() {
   var salary_year_month = _$("#salary_year_month").val();//工资所属年月
   $id("batchListdatacell").addParam("is_verify","1");
   $id("batchListdatacell").addParam("pay_year_month_from",salary_year_month);
   $id("batchListdatacell").addParam("pay_year_month_to",salary_year_month);
   
   $id("batchListdatacell").reload();
   $id("batchListdatacell").refresh();
}

//查询薪资类别的返回方法
function clz_rtnFunc(arg){
    var lookup = $id("sa_class_id");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    return false;
}

//薪资重算
function salaryReCal(){
    var entity = $id("batchListdatacell").getActiveEntity();
     if(entity == "" || entity == null){
          alert("请选择一个薪资批次！");
          return;
     }
     if(confirm("你确定要进行薪资重算吗！")){
           _$.ajax({
                       type: "POST",
                       url: venusbase +"/SalarybatchAction.do?cmd=salaryReCal&id=" +entity.getValue("id"),
                       data:"",
                       dataType: "html",
                       success: function(msg){
		                       if(msg.substring(0,1) == 5){
		                            //未红冲 邮件通知AR
				                   if(confirm("账单数据财务已入账，是否邮件通知财务AR组取消入账！")){
					                       _$.ajax({
					                            type : "post",
					                            url : venusbase + "/FinbillAction.do?cmd=sendEmailToARTeam&bill_id=" + msg.substring(2),
					                            dataType : "html",
					                            success : function(data) {
					                                                   alert(data);
					                                             }
				                        });
		                             }
		                        }else{
                                     alert(msg);
                                     listquery();
                               }
                       }
            });
     }
}
</script>
