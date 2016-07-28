<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.send.util.ISendConstants" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salse.send.send_resource" prefix="rayoo.salse.send.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache"/> 
<title>新进客户及销售名单</title>
<script language="javascript">
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("celllist1").addParam("custIDVal",$id("custID").value);
        $id("celllist1").addParam("monthVal",$id("month").value);
        $id("celllist1").addParam("countBeginVal",$id("countBegin").value);
        $id("celllist1").addParam("countEndVal",$id("countEnd").value);
        if(!checkMonth($id("month").value)){
            return;
        }
        
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        document.getElementById("custID").value = arg[0];
        return false;
    }
    
    //设置人数，超链接事件
    function showLink(value,entity,rowNo,cellNo){
        if(value){
           return "<a href='#' onclick='toEmpDetail(\""+entity.getValue('id')+"\");'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>"+value+"</a>";
        }
    }
    
    //校验查询条件日期是否符合要求
    function checkMonth(month){
        var flag = true;
        var reg = new RegExp("^[0-9]*$");
        if(month != "" && month != "null" && month != null ){
            if(!reg.test(month) || month.length!=6){
                flag = false;
                alert("日期格式不正确，请输入6位数年月!");
            }
        }else{
            flag = false;
            alert("请填写6位数年月!");
        }
        return flag;
    }
    
    //查看新进客户人员明细
    function toEmpDetail(custID){
        var url = "<%=request.getContextPath()%>/jsp/faerp/employeepost/empinfo/employee/newCustEmployeeList.jsp?custID="+custID;
		window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新进客户员工明细');
    }
    
    
    //导出明细
    function exportExcel(){
       var custIDVal = $id("custID").value;
       var monthVal = $id("month").value;
       var countBeginVal = $id("countBegin").value;
       var countEndVal = $id("countEnd").value;
       //拼装查询条件
       var conditionStr = "&custIDVal="+custIDVal+"&monthVal="+monthVal+"&countBeginVal="+countBeginVal+"&countEndVal="+countEndVal;
       //conditionStr = encodeURI(conditionStr);//编码json
       var form = document.getElementById("datacell_formid");
       form.action="<%=request.getContextPath()%>/PbcustomerAction.do?cmd=exportNewCust&"+conditionStr;
       form.submit();
    }
</script>
</head>
<body>
	<form name="form" id="datacell_formid" method="post" action="">
		<input type="hidden" name="custID" id="custID" value="${custID }"> 
		<div id="right">
			<script language="javascript">
			    writeTableTopFesco('新进客户及销售名单','<%=request.getContextPath()%>/');  //显示本页的页眉
			</script>
			<div class="ringht_s">
				<div id="ccChild0" class="search">
					<table width="60%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="174" rowspan="10" style="padding-top: 0;">
							     <div class="search_title"><fmt:message key="query_conditions" /></div>
							</td>
						</tr>
						<tr>
				            <td align="left" ><fmt:message key="customer_name"/></td>
                            <td align="left">
                                 <w:lookup name="customer_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                    messagekey="choose_customer" height="440" width="600" style="width:195px" allowInput="false" />
                            </td>
				            
							<td align="left">统计年月</td>
							<td align="right">
							     <input type="text" class="text_field" id="month" name="month" inputName="统计年月" value="${month }" maxLength="6" />
							</td>
						</tr>
						<tr>
						    <td align="left">人数区间</td>
                            <td align="left">
                                 <input type="text" class="text_field" id="countBegin" name="countBegin" inputName="人数区间" 
                                    value="<c:if test='${empty countBeginString}'>20</c:if><c:if test='${not empty countBeginString}'>${countBeginString }</c:if>" style="width: 90px;" /> 至
                                 <input type="text" class="text_field" id="countEnd" name="countEnd" inputName="人数区间" value="${countEndString }" style="width: 90px;"/>
                            </td>
							<td align="right" colspan="2">
							     <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
				                 <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
				                 <input name="button_reset" class="icon_1" type="button" value="导出" onClick="javascript:exportExcel();">
							</td>
						</tr>
					</table>
				</div>
				<div class="clear"></div>
				<div>
				    <r:datacell id="celllist1"
					    queryAction="/FAERP/PbcustomerAction.do?cmd=getNewCust"
					    paramFormId="form" width="100%" height="320px"
					    xpath="PbcustomerVo" readonly="true" pageSize="10">
				        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				        <r:field fieldName="id" label="客户id" width="0px" allowModify="false"></r:field>
					    <r:field fieldName="customer_code" label="客户编码" width="240px" allowModify="false"></r:field>
					    <r:field fieldName="customer_name" label="客户名称" width="240px"></r:field>
				        <r:field fieldName="new_person_count" label="新进人员数量" onRefreshFunc="showLink" width="240px"></r:field>
				        <r:field fieldName="is_sale_achievement" label="是否销售业绩" width="100px"></r:field>
					    <r:field fieldName="sale_name" label="销售人员" width="240px"></r:field>
				    </r:datacell>
				</div>
			</div>
		</div>
	</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(ISendConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISendConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
if (${msg != null && msg != '' }) {
    alert('${msg }');
}
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("celllist1").isQueryFirst = false;
});
</script>   
