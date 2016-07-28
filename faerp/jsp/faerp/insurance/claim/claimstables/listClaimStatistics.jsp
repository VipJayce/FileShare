<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
    <fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FESCO Adecco ERP系统</title>
    <script language="javascript">
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(data == undefined) return;
         document.form.cust_id.value=data[0];
         document.form.cust_name1.value=data[2];
    }
    
    function getpolicybyid(){
         var data = window.showModalDialog('<venus:base/>/PolicyAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(data == undefined) return;
         document.form.policy_id.value=data[0];
         document.form.policy_name1.value=data[2];
    }

    function showListData(){
        var start_date = document.datacell_formid.issuing_date_from.value;
        var end_date = document.datacell_formid.issuing_date_to.value;
        if(start_date!=null && start_date!=""){
            if(end_date==null || end_date==""){
	            alert("请将出险时间输入完整！");
	            return;
            }
        }
        if(end_date!=null && end_date!=""){
            if(start_date==null || start_date==""){
                alert("请将出险时间输入完整！");
                return;
            }
        }
        if(end_date!=null&&end_date.trim().length!=0){
           var beginTime =start_date.trim();
           var endTime = end_date.trim();
           var beginTimes=beginTime.substring(0,10).split('-');
           var endTimes=endTime.substring(0,10).split('-');
           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
           if(beginTime>endTime){
               alert("初险终止日期小于初险起始日期！");
               return;
           }
       }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        //jQuery("#policy_id").val(arg[0]); 
        //jQuery("#policy_name1").val(arg[2]);
        return false;
    }
</script>
    </head>
    <body>

<form name="datacell_formid" method="post" id="datacell_formid">
    <div id="right">
    <div class="right_title_bg">
      <div class=" right_title">理赔情况统计报表</div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
		    <td rowspan="2" style="padding-top:0;"><div class="search_title">查询条件</div></td>
		    <td>初险时间</td>
		    <td>
		        <w:date format="yyyy-MM-dd" id="issuing_date_from" name="issuing_date_from" width="85px"/>到
		        <w:date format="yyyy-MM-dd" id="issuing_date_to"  name="issuing_date_to" width="85px"/>
		    </td>
		    <td>保单编号</td>
		    <td>
                <!--<input type="hidden" name="policy_id" id="policy_id" value="">
                <input type="text" class="text_field" id="policy_name1" name="policy_name1" validators="isSearch" inputName="保单名称" maxLength="50" readonly="readonly"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getpolicybyid();"/>
            -->
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" name="policy_code" id="lk_cust" lookupUrl="/PolicyAction.do?cmd=queryAllGetByID" dialogTitle="选择保单" height="500" width="810"/>
                <!-- <input type="hidden" name="policy_name1" id="policy_name1"/>
                <input type="hidden" name="policy_id" id="policy_id"/> -->
            </td>
		    <td>&nbsp;<!-- 客户编号 --></td>
		    <td>&nbsp;<!-- <input type="text" value="" class="sText" id="user3"/> --></td>
		</tr>
	    <tr>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();"></td>
		    <td><input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
	    </tr>
    </table>
  </div>
  <div id="values_div"> 
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/claimsTablesAction.do?cmd=searchClaimStatisticsData"
        width="98%"
        height="318px"
        xpath="ClaimStatisticsVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="emp" label="操作" sortAt="none" width="50px" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      --><!--
      <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
        </r:field>
      -->
      <r:field fieldName="numberBulgaria" label="目前在保人数" width="140px">
      </r:field>
      <r:field fieldName="claimNumber" label="理赔人数" width="200px">
      </r:field>
      <r:field fieldName="amountCumulative" label="累计赔付金额" width="200px">
      </r:field>
      <!--<r:field fieldName="totalMonthlyIncome" label="月总收入">
      </r:field>
      --><r:field fieldName="monthlyTotalCost" label="月总成本" width="200px">
      </r:field>
      <!--<r:field fieldName="lossRatioTotalRevenue" label="总收入赔付率">
      </r:field>      
      --><r:field fieldName="costLossRatio" label="总成本赔付率" width="200px">
      </r:field><!--
      <r:field fieldName="lossRatioCapitaIncome" label="人均收入赔付率" >
      </r:field>
      --><r:field fieldName="perCapitaCostLossRatio" label="人均成本赔付率" width="200px">
      </r:field>
    </r:datacell>
</div>
    </div>
</div>
    </form>
</fmt:bundle>
</body>
</html>
