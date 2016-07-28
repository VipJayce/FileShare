<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%String costCenterIds=request.getParameter("costCenterIds");
%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账单批量生成参数配置</title>
<script language="javascript">
/*******************************************************************************************************/
//账单生成
function generate_onClick (){
    var costCenterIds=document.getElementById("costCenterIds").value;
    var batchName=document.getElementById("batchName").value;
    var searchBillGenerateType=document.getElementById("searchBillGenerateType").value;
    var billYearMonth=document.getElementById("billYearMonth").value;
    var isSendERP=document.getElementById("isSendERP").value;
    if(batchName==""){
	    alert("请输入批次名称！");
	    return;
    }
    if(searchBillGenerateType==""){
	    alert("请选择账单类型！");
	    return;
    }
    if(billYearMonth==""){
	    alert("请输入账单年月！");
	    return;
    }
	if (validDate(billYearMonth) == null) {
        alert("输入错误，请输入'yyyyMM'六位数字格式");
        return;
	}
	var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=generateBatchBill";
    var myAjax = new Ajax(action);
    myAjax.addParam("costCenterIds",costCenterIds);
    myAjax.addParam("batchName",batchName);
    myAjax.addParam("searchBillGenerateType",searchBillGenerateType);
    myAjax.addParam("billYearMonth",billYearMonth);
    myAjax.addParam("isSendERP",isSendERP);
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
     if( returnNode ) {
           var flag = ""+myAjax.getProperty("returnValue");
           var msg = ""+myAjax.getProperty("returnMessage");
           alert(msg);
           alert(flag);
           if(flag == "true"){
		       window['returnValue'] = msg;
		       window.close();
		       window.opener.showListData();//回调父页面函数
           }
     }
}

</script>
</head>
<body>

<form name="form" method="post">
<input  type="hidden"  value="<%=costCenterIds %>" id="costCenterIds"/>
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height:220px "> 
<table  width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_2" ><span class="style_required_red">* </span>请输入批次名称</td>
            <td class="td_2">
                <input style="width:190px" id="batchName">
            </td>
        </tr>
        <tr>
            <td class="td_2"><span class="style_required_red">* </span>账单生成类型</td>
            <td class="td_2">
                <h:select id="searchBillGenerateType" style="width:190px">
                    <h:option label="仅社保福利" value="2"/>
                    <h:option label="社保福利加薪资" value="1"/>
                    <h:option label="仅工资" value="3"/>
                </h:select>
            </td>
        </tr>
        <tr>
	        <td class="td_2" ><span class="style_required_red">* </span> 请输入账单年月</td>
	        <td class="td_2" ><input  style="width:190px" id="billYearMonth" /> </td>
        </tr>
        <tr>
            <td class="td_2"> <span class="style_required_red">* </span>是否回写ERP</td>
            <td class="td_2"  >
               <h:select id="isSendERP" style="width:190px">
                   <h:option label="否" value="0"/>
                   <h:option label="是" value="1"/>
               </h:select>
            </td>
        </tr>
        <tr>
        <td class="td_2"  colspan="2"  align="center">
            <input type="button" class="icon_2" value='生成' onClick="javascript:generate_onClick();"  />
        </td>
        </tr>
        </table>
        </div>
        </div>
        </form>

<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	window.onload = function(){
		document.getElementById("billYearMonth").value = getNowFormatDate();
	}
	//日期格式话：yyyyMM
	function getNowFormatDate() {
	    var date = new Date();
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    var currentdate = date.getFullYear() + month;
	    return currentdate;
	}
	//验证输入日期格式yyyyMM
	function validDate(date) {
	    var reg = /^\b[1-3]\d{3}(0[1-9]|1[0-2])$/;
	    return flg = date.match(reg);
	}
</script>
</body>
</fmt:bundle>
</html>


