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
    function exportEXCEL_onClick(){
        var create_date_from = document.form.create_date_from.value;
        var create_date_to = document.form.create_date_to.value;
        var cust_id = document.form.cust_id.value;
        if(cust_id==null || cust_id==""){
            alert("请选择客户！");
            return;
        }
        if(create_date_from==null || create_date_from==""){
            alert("请输入药品申领时间！");
            return;
        }else{
            if(create_date_to==null || create_date_to==""){
	            alert("请输入完整的药品申领时间！");
	            return;
	        }    
        }
        if(create_date_to!=null&&create_date_to.trim().length!=0){
           var beginTime =create_date_from.trim();
           var endTime = create_date_to.trim();
           var beginTimes=beginTime.substring(0,10).split('-');
           var endTimes=endTime.substring(0,10).split('-');
           beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
           endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
           if(beginTime>endTime){
               alert("药品申领终止日期小于药品申领起始日期！");
               return;
           }
       }              
        $id("form").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showMedicalkitStablesReport.jsp?raq=report_medicalkit_tables.raq&arg1="+cust_id+"&arg2="+create_date_from+"&arg3="+create_date_to;
        $id("form").submit();              
    }
    
    function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        jQuery("#customer_name").val(arg[2]);
        return false;
    }
</script>
	</head>
	<body>

<form name="form" method="post" id="form">
	<div id="right">
	<script language="javascript">
	   writeTableTopFesco('利润报表','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<div class="ringht_s">
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title">查询条件</div>
			<!--表格1-->
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0"
				cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1"><span>*</span>客户名称</td>
					<td class="td_2">
                        <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px"  readonly="true" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition&Medicalkit=true" dialogTitle="选择客户" height="500" width="810"/>
                        <input type="hidden" name="customer_name" id="customer_name"/>
                        <input type="hidden" name="cust_id" id="cust_id"/>
					</td>
					<td class="td_1"><span>*</span>药品申领时间</td>
					<td class="td_2">
                       <w:date format="yyyy-MM-dd" id="create_date_from" name="create_date_from" width="85px"/>到<w:date format="yyyy-MM-dd" id="create_date_to" name="create_date_to" width="85px"/>
                    </td>
                    <td class="td_2" colspan="2"><input name="button" type="button" class="icon_1" <au:authorityBtn code="xyxlr_exp" type="1"/> value="导出报表" onclick="javascript:exportEXCEL_onClick();" /></td>
				</tr>
			</table>
			</div>
			<!--表格1 end--></div>
			</td>
		</tr>
	</table>
	</form>
</fmt:bundle>
</body>
</html>
