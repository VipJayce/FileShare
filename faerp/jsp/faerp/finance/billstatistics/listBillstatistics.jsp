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
        var bill_year_month = _$("#bill_year_month").val();
        if(null == bill_year_month || "" == bill_year_month){
            alert("请输入账单所属年月");
            return;
        }
        
        if(isNaN(bill_year_month) ){
            alert("请输入正确的所属年月");
            return;
        }
         if((bill_year_month+"").length !=6){
            alert("请输入正确的6位年月");
            return;
         }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
        
    }
    
    //导出出账单率
    function rateExp(){
         //工资所属年月
        var bill_year_month = _$("#bill_year_month").val();
         //客服id
        var user_id = _$("#user_id_hidden").val();
        var url = "<%=request.getContextPath()%>/BillStatisticsAction.do?cmd=expBillRate&bill_year_month="+bill_year_month+"&user_id="+user_id;
        _$("#exp_form").attr("action",url);
        _$("#exp_form").submit();
    }
    //导出已出和未出账单
    function billExp(type){
        //工资所属年月
        var bill_year_month = _$("#bill_year_month").val();
         //客服id
        var user_id = _$("#user_id_hidden").val();
        var url = "<%=request.getContextPath()%>/BillStatisticsAction.do?cmd=expBillDetail&bill_year_month="+bill_year_month+"&user_id="+user_id+"&type="+type;
        _$("#exp_form").attr("action",url);
        _$("#exp_form").submit();
    }
    
</script>
 

</head>
<body>
 <form id="exp_form" name="exp_form" method="post" action="">
 </form>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/BillStatisticsAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('出账单率统计','<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td align="left">账单所属年月</td>
            <td align="left">
                <input type="text" class="text_field" id="bill_year_month"  name="bill_year_month" value="" inputName="账单年月"/>
            </td>
             <td align="left">选择客服</td>
            <td class="td_2">
                <r:comboSelect id="user_id" name="user_id"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=${kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select" />
            </td>
            <td align="left">                 
                <input name="button_ok" class="icon_1"   type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
        </tr>
</table>
</div>
 <!-- 查询end -->
 <!-- button start -->
     <div class="button">
            <div class="button_right">
                <input class="bl_3" type="button"   value="出账单率导出"   onClick="rateExp();">
                <input class="bl_3" type="button"    value="已出账单导出"    onClick="billExp(1);">
                <input class="bl_3" type="button"    value="未出账单导出"    onClick="billExp(0);">
            </div>
            <div class="clear"></div>
        </div>
<!-- button end -->
<!-- div start --> 
<div style="padding: 8 10 8 8;">
	 <r:datacell id="datacell1" queryAction="/FAERP/BillStatisticsAction.do?cmd=searchBillAmountData" 
	 width="99%" height="318px" xpath="BillStatisticsVo" paramFormId="datacell_formid">
		  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		  <r:field fieldName="user_id" label="客服ID" width="0px;"></r:field>
		 <r:field fieldName="user_name" label="客服名称" ></r:field>
		 <r:field fieldName="yc_amount" label="已出账单数"  onRefreshFunc="showLink"></r:field>
		 <r:field fieldName="wc_amount" label="未出账单数" onRefreshFunc="showLink" ></r:field>
		 <r:field fieldName="sc_amount" label="应出账单数"   ></r:field>
		 <r:field fieldName="bill_rate" label="出账单率"   ></r:field>
		 <r:field fieldName="bill_year_month" label="账单所属年月"   width="0px;"></r:field>
	 </r:datacell>
</div>
<!-- div end -->
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
    $id("datacell1").onComplete = function (){
        //获得datacell的总记录数
        var dc = $id("datacell1");
        var rc = dc.getCurrentRowCount();
        //已出账单数
        var sc_amount;
        //应出账单数
        var yc_amount;
        //账单年月
        var bill_year_month;
        //客服id
        var user_id
        for(var i=0;i<rc;i++){
           yc_amount = dc.getCellValue(dc.getCell(i,2));
           sc_amount = dc.getCellValue(dc.getCell(i,4));
           
           bill_year_month = dc.getCellValue(dc.getCell(i,6));
           user_id = dc.getCellValue(dc.getCell(i,0));
           //计算出未出账单数
           var wc_amount = sc_amount-yc_amount;
           
           //设置到表格
           dc.setCellValue(dc.getCell(i,3),"<a href=\"###\" style=\"color: #0033CC; font-weight: bold;\" onClick=\"toDetail('"+bill_year_month+"','"+user_id.toString()+"','"+0+"')\">"+wc_amount+"</a>");
           //设置已出账单数的链接
           dc.setCellValue(dc.getCell(i,2),"<a href=\"###\" style=\"color: #0033CC; font-weight: bold;\" onClick=\"toDetail('"+bill_year_month+"','"+user_id+"','"+1+"')\">"+yc_amount+"</a>");
           //计算出出账单率
           dc.setCellValue(dc.getCell(i,5),returnFloat2(yc_amount/sc_amount*100)+"%");
        }
        //在改完值之后 把值设为false 让datacell 不做修改监视
        $id("datacell1").isModefied  =false;
    }
});

    
//保留两位小数点，一位小数自动补零
function returnFloat2(value) {     
    value = Math.round(parseFloat(value) * 100)/100;
    var xsd = value.toString().split(".");
    if(xsd.length==1){
         value = value.toString()+".00";
         return value;
    }
    if(xsd.length>1){
         if(xsd[1].length<2){
          value = value.toString()+"0";  
         }
         return value;
    }
}
//显示一般的链接
    function showLink(value,entity,rowNo,cellNo){
        if(value){
           // return "<a href='<%=request.getContextPath()%>/BillStatisticsAction.do?cmd=toDetail&bill_year_month="+entity.getProperty("bill_year_month")+"&user_id="+entity.getProperty("user_id")+"&type=1"+"'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>"+value+"</a>";\
           return "<a href='###'  style='color: #0033CC; font-weight: bold; text-decoration: underline;display:none;'>"+value+"</a>";
        }
        
    }

function toDetail(bill_year_month,user_id,type){
    window.open('<%=request.getContextPath()%>/BillStatisticsAction.do?cmd=toDetail&bill_year_month='+bill_year_month+'&user_id='+user_id+'&type='+type,'','height=400px,width=400px,top=200,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
}
</script>   
