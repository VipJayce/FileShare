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
	<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/sararyCal.js"></script>
	<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/calcommon.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
        /*_$(function(){
		    $id("batchListdatacell").isQueryFirst = false;
		    
		    //魏佳新增--默认工资所属年月为当前日期的年月
	        var myDate = new Date();
	        var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
	        var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
	        //var day = myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
	        if(month<10){
	          month = "0"+month;
	        }
	        var ym = year+month;
	        document.getElementById("pay_year_month_from").value=ym;
	        document.getElementById("pay_year_month_to").value=ym;
		});
		*/
		function exportAllDetail(){
	var entity_re = getSelectedEntity();
    if (entity_re[0]==0) {
        alert("请先选择一条记录");
        return false;
    }
    if(entity_re[0]>1){
         alert("只能选择一条记录");
        return false;
    }
    var entity=entity_re[1];
		    var batch_id = entity.getValue("id");
		    var sa_class_id = entity.getValue("sa_class_id");
		    
		    $id("datacell_formid").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=expSalaryDetail&batchId=" + batch_id + "&clzId=" + sa_class_id;
		    $id("datacell_formid").submit();
		}
		/******************增加checkbox多选和批量确认功能******************/
		   function checkAll(item) {
        if (_$(item).attr("checked")) {
            changeEntityChk(true);
            _$(":checkbox").attr("checked", true);
        } else {
            changeEntityChk(false);
            _$(":checkbox").attr("checked", false);
        }
    }
        function changeEntityChk(flag) {
        var dc1 = $id("batchListdatacell").dataset;
        var values = dc1.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }
    
    //批量确认
    function  affirm_batch(){
      var myids=selectIds();
      var errorinfo=check_status();
      if(myids.length==0){
        alert("请先选择数据！");
        return;
      }
      if(errorinfo!=""){
      alert(errorinfo);
       return;
      }
      showProgressBar();
    _$.ajax({
       type: "POST",
       url: venusbase + "/SalarybatchAction.do?cmd=sureBybatch&id=" + myids,
       dataType: "html",
       success: function(msg){
         if (msg && msg == '1') {
            hideProgressBar();
            alert("确认成功。");
            $id("batchListdatacell").reload();
         } else {
            hideProgressBar();
            alert(msg);
         }
       }
    });
    }
    
    //获取选中的id
      function selectIds() {
        var myids = new Array(0);
        var dc = $id("batchListdatacell");
        _$("input[type='checkbox']").each(function(i) {
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                myids.push(entity.getValue("id"));
            }
        });
        return myids;
    }
    
    //校验信息
     function  check_status() {                   
       var dc = $id("batchListdatacell");
       var message="";
       jQuery("input[type='checkbox']").each(function (i){
         if (i != 0 && _$(this).attr("checked")) {
             var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
             var entity = dc.getEntity(row);
             var  apply_state = entity.getValue('apply_state');
             var  audit_state = entity.getValue('audit_state');
             var  is_verify = entity.getValue('is_verify');
             var  batch_code=entity.getValue('sa_batch_code');
             message=checkState4batch(batch_code,is_verify,apply_state,audit_state);
            }
        });
       return message;
    } 
    
    //重新定义一个这样的校验函数
    function checkState4batch(batch_code,is_verify, apply_state, audit_state) {
    var message = "";
    if (is_verify == '1' || is_verify == '是') {
        message =  "批次："+batch_code+"  已确认，不能提交审核。";
        return message;
    }
    if (apply_state == '0'
    || (apply_state == '1' && audit_state == '2')) {
        //正常CASE
    } else if (apply_state == '1' && audit_state == '0') {
        message = '批次：'+batch_code+'   已提交，正待审核。';
    } else if (apply_state == '1' && audit_state == '1') {
        message = '批次：'+batch_code+'   已通过审核。';
    } else if (apply_state == '1' && audit_state == '3') {
        message = '批次：'+batch_code+'   已完成审核。';
    } else {
        message = '批次：'+batch_code+'   审核状态异常。';
    }
    return message;
}

/*****批量提交财务审核***/
    function  submit2fin_batch(){
      var myids=selectIds();
      var errorinfo=check_status();
      if(myids.length==0){
        alert("请先选择数据！");
        return;
      }
      if(errorinfo!=""){
      alert(errorinfo);
       return;
      }
 showProgressBar();
    _$.ajax({
       type: "POST",
       url: venusbase + "/SalarybatchAction.do?cmd=toapproveDataBybatch&id=" + myids,
       dataType: "html",
       success: function(msg){
         if (msg && msg == '1') {
            hideProgressBar();
            alert("提交完成！");
            $id("batchListdatacell").reload();
         }else {
            hideProgressBar();
            alert(msg);
         }
       }
    });
   
    }
    
    function submit_ge_salary() {
        var entitys = getSelectedEntity();
        if (entitys[0]==0) {
            alert("请先选择一条记录");
            return false;
        }
        if(entitys[0]>1){
            alert("只能选择一条记录");
            return false;
        }
        var entity = entitys[1];
        var batch_id = entity.getValue("id");
        if (entity.getValue("pps_batch_id") == '是') {
            alert("由PPS导入的数据不能再修改。");
            return false;
        }
        if (entity.getValue("is_verify") == '是') {
            alert("确认后的数据不能再修改。");
            return false;
        }
        if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '0') {
            alert("此薪资批次已提交，正待审核。");
            return false;
        } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '1') {
            alert("此薪资批次已通过审核。");
            return false;
        } else if (entity.getValue('apply_state') == '1' && entity.getValue('audit_state') == '3') {
            alert("此薪资批次已完成审核。");
            return false;
        } else if (entity.getValue('apply_state') == '0' || 
            (entity.getValue('apply_state') == '1' && 
            entity.getValue('audit_state') == '2')) {
	        var queryString = _$("form").serialize();
	        
             _$.ajax({
                type: "POST",
                url: venusbase + "/SalarydataAction.do?cmd=calGeSalary&batch_id=" + batch_id,
                dataType: "html",
                success: function(msg) {
                    if (msg && msg != 'false') {
                        hideProgressBar();
                        alert("计算完成！");
                        $id("batchListdatacell").reload();
                    } else {
                        hideProgressBar();
                        alert("对不起计算失败，请联系IT！");
                    }
                }
            });
	    } else {
	        alert("此薪资批次审核状态异常。");
	        return false;
	    }
    }
    </script>
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
        <td width="85"/>
        <td width="196"/>
        <td width="143"/>
        <td width="240"/>
    </tr>
    <tr>
        <td align="right"><fmt:message key='pay_year_month'/></td>
        <td align="left">
            <input type="text" id="pay_year_month_from" name="pay_year_month_from" class="text_field" style="width: 90px;" value="${pay_year_month_from }">
            -
            <input type="text" id="pay_year_month_to" name="pay_year_month_to" class="text_field" style="width: 90px;" value="${pay_year_month_to }">
        </td>
        <td align="right"><fmt:message key='salary_type'/></td>
        <td align="left">
             <w:lookup onReturnFunc="clz_rtnFunc" readonly="true"
				id="sa_class_id" name="sa_class_id" lookupUrl="/SalaryclassAction.do?cmd=toSalartClzLookup"
				messagekey="select_salaryclass" height="500" width="810" style="width:187px;" />
        </td>
        <td width="100" align="right"><fmt:message key='is_verify'/></td>
        <td width="213" align="left">
           <d:select dictTypeId="TrueOrFalse" id="is_verify" name="is_verify" value="0" nullLabel="--请选择--"></d:select>
        </td>
    </tr>
    <tr>
        <td align="right"><fmt:message key='sa_batch_code'/></td>
        <td align="left">
            <input name="sa_batch_code" class="text_field" maxLength="50" value="${sa_batch_code }">
        </td>
        <td align="right"><fmt:message key='customer_code'/></td>
        <td align="left">
            <input type="text" name="customer_code" class="text_field" maxLength="50" value="${customer_code }"/>
        </td>
        <td align="right"><fmt:message key='batch_code_qg'/></td>
        <td align="left">
            <input name="batch_code_qg" class="text_field" maxLength="50">
        </td>
    </tr>
    <tr>
    <td align="right">申请人</td>
    <td align="left"><input name="submit_user" class="text_field" maxLength="50"></td>
        <td align="center" colspan="4">
             <input onclick="listquery();" id="batchListquery" class="icon_1" type="button" value="<fmt:message key='button_search'/>"/>
             <input type="reset" class="icon_1" value="重置"/>
        </td>
    </tr>
    </table>
    
</div>

<div class="button_right" style="margin: 5px;"><!--
   <ul>
       <li class="dj_3" onclick="showIssuePage();"><a href="###">生成发放数据</a></li>
       <li class="bl_1" onclick="editdata();"><a href="####">编辑数据</a></li>
       <li class="d" onclick="deldata();"><a href="####">删除</a></li>
       <li class="a_1" onclick="toitemdata();"><a href="####">明细数据</a></li>
       <li class="g_1" onclick="affirm(1);"><a href="####">数据确认</a></li>
        <li class="d" onclick=""><a href="####">撤销数据确认</a></li>  
       <li class="h_2" onclick="approval2fin(1);"><a href="####">提交财务审核</a></li>
   </ul>
   -->
   <input class="dj_3" type="button"   value="<fmt:message key='button_scffsj'/>" <au:authorityBtn code="xzjs_scffsj" type="1"/>  onClick="showIssuePage();">
     <input class="bl_1" type="button"   value="<fmt:message key='button_bjsj'/>"  <au:authorityBtn code="xzjs_bjsj" type="1"/>  onClick="editdata();">
      <input class="d" type="button"   value="<fmt:message key='button_del'/>"  <au:authorityBtn code="xzjs_del" type="1"/>  onClick="deldata();">
      <input class="xz_1" type="button"   value="导出excel"  <au:authorityBtn code="xzjs_item" type="1"/>  onClick="exportAllDetail();">   
      <input class="a_1" type="button"   value="<fmt:message key='button_item'/>"  <au:authorityBtn code="xzjs_item" type="1"/>  onClick="toitemdata();">   
      <input class="g_1" type="button"   value="<fmt:message key='button_sjqr'/>"  <au:authorityBtn code="xzjs_sjqr" type="1"/>  onClick="affirm(1);">
      <input class="h_2" type="button"   value="<fmt:message key='button_tjsh'/>"  <au:authorityBtn code="xzjs_tjsh" type="1"/>  onClick="approval2fin(1);">
      <input class="bl" type="button"  <au:authorityBtn code="xzjs_delaydata" type="1"/>  value="<fmt:message key='button_hf'/>" onClick="delayData();">
      <input class="bl_1" type="button"   <au:authorityBtn code="xzjs_delaydata_exp" type="1"/>    value="<fmt:message key='button_delay_state_export_tpl'/>"   onClick="delayStateExmportTpl();">
      <input class="bl_1" type="button"  <au:authorityBtn code="xzjs_delaydata_imp" type="1"/>  value="<fmt:message key='button_delay_state_import'/>"   onClick="delayStateImport();">
       <!-- 批量数据确认按钮2014年6月19日 -->
       <input class="g_1" type="button"   value="批量确认"  <au:authorityBtn code="xzjs_plsjqr" type="1"/>  onClick="affirm_batch();"> 
        <input class="h_2" type="button"   value="批量提交审核"  <au:authorityBtn code="xzjs_pltjcwsh" type="1"/>  onClick="submit2fin_batch();"> 
        <input class="js_3" type="button"   value="GE工资计算"  <au:authorityBtn code="ge_salary_cal" type="1"/>  onClick="submit_ge_salary();"> 
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
      <r:field allowModify="false" fieldName="chk"
           label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
           sortAt="none" width="30px">
           <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
       </r:field>
      <r:field fieldName="sa_batch_code" messagekey="sa_batch_code" width="100px;"></r:field>
      <r:field fieldName="pps_batch_id" messagekey="is_pps_batch" width="50px;"></r:field>
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
      <r:field fieldName="submit_user" label="申请人" width="60px;"></r:field><!--  -->
      <r:field fieldName="delete_verify_state" label="删除审核状态" width="0px;"></r:field>
       <r:field fieldName="pay_state" label="发放状态" width="0px;"></r:field>
        <r:field fieldName="apply_pay_state" label="发放申请状态" width="0px;"></r:field>
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

</script>
