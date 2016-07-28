<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
//简单的模糊查询
    function simpleQuery_onClick(){  
        //工资所属年月
        var pay_year_month = _$("#pay_year_month").val();
        if(null == pay_year_month || "" == pay_year_month){
            alert("请输入工资所属年月");
            return;
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //选择客户的返回方法
    function rtnFuncCustomer(arg){
        var lookup = $id("customer_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        return false;
    }
    
    //导出薪资明细
        function salary_download(){
            //工资所属年月
            var pay_year_month = _$("#pay_year_month").val();
            //客户id
            var customer_id = _$("#customer_id_hidden").val();
            
            if(null == pay_year_month || "" == pay_year_month){
                alert("请输入工资所属年月");
                return;
            }
            var url = "<%=request.getContextPath()%>/SalaryStatisticsAction.do?cmd=expSalaryData&pay_year_month="+pay_year_month+"&customer_id="+customer_id;
            form.action=url;
            form.submit();
        }
</script>
 

</head>
<body>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/SalaryStatisticsAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('工资数据下载','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;" height="40px;"><div class="search_title">查询条件</div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
                <tr>
            <td align="left">工资所属年月</td>
            <td align="left">
                <input type="text" class="text_field" id="pay_year_month"  name="pay_year_month" value="" inputName="账单年月"/>
            </td>
             <td align="left">选择客户</td>
            <td class="td_2">
	           <div>
		           <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
		            id="customer_id" name="customer_id" property="customer_id"
		            displayProperty="customer_name"
		            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
		            dialogTitle="选择客户" height="450" width="610" style="width:172px"  />
	            </div>
	        </td>
            <td align="left">                 
                <input name="button_ok" class="icon_1"   type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
        </tr>
</table>
</div>
 

 

                    
<div id="ccParent1" class="button"> 
    <div class="button_right">
         <input class="bl_3" type="button"   value="工资导出"   onClick="salary_download();" />
     </div>
     <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/SalaryStatisticsAction.do?cmd=searchSalaryData" 
 width="100%" height="318px" xpath="SalaryStatisticsVo" paramFormId="datacell_formid" readonly="true" pageSize="200">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="pay_year_month" label="工资所属月"   > </r:field>    
 <r:field fieldName="verify_name" label="审核人" ></r:field>
 <r:field fieldName="emp_name" label="员工姓名"   ></r:field>
 <r:field fieldName="id_card" label="证件号码"  ></r:field>
 <r:field fieldName="def35" label="养老自付" ></r:field>
 <r:field fieldName="def34" label="医疗自付" ></r:field>
  <r:field fieldName="def33" label="失业自付" ></r:field>
  <r:field fieldName="def31" label="公积金自付"  ></r:field>
 <r:field fieldName="def3" label="实发合计"   ></r:field>
 <r:field fieldName="def6" label="本次扣税"   ></r:field>
 <r:field fieldName="account_name" label="账户名"   ></r:field>
 <r:field fieldName="bank_name" label="开户行"   ></r:field>
 <r:field fieldName="account_num" label="开户账号"  >  </r:field>
 <r:field fieldName="province_name" label="账号省名"  ></r:field>
  <r:field fieldName="city_area_name" label="账号市区名"  ></r:field>
 <r:field fieldName="cyber_bank" label="网银发放所属银行"  ></r:field>
 <r:field fieldName="customer_name" label="客户名称"  ></r:field>
 <r:field fieldName="service_name" label="客服"  ></r:field>
 <r:field fieldName="real_pay_day" label="工资实际发放日期" ><w:date format="YYYY-MM-DD" /></r:field>
 </r:datacell>
</div>

</div>
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>   
