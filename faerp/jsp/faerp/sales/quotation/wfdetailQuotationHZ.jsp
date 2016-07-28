<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.*"%>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo"%>
<%@ page import="rayoo.system.product.vo.ProductVo"%>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants"%>
<%@ page import="rayoo.sales.quotationitem.vo.QuotationitemVo"%>

<%@ page import="java.util.*"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //取出本条记录
	QuotationVo resultVo = null;  //定义一个临时的vo变量
    List list =null;
	List qtitemlist = null;
    if(request.getAttribute("list") != null) {  //如果request中取出的bean不为空
        list = (List)request.getAttribute("list");  
    if(request.getAttribute("qtitemlist")!=null)
    {
        qtitemlist=(List)request.getAttribute("qtitemlist");
    }
    }
    
    String quotationitemID="";
    for (int i=0;i<qtitemlist.size(); i++ ){
        //获得报价单中的产品
        QuotationitemVo quotationItemVo=(QuotationitemVo)qtitemlist.get(i);
        quotationitemID += quotationItemVo.getProduct_id();
        if(i!=qtitemlist.size()-1){
            quotationitemID +=",";
        }
    }


    
	resultVo = (QuotationVo)request.getAttribute(IQuotationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	//RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
     //审批流程信息
         String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
%>
<html>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
    
    //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=${done}";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
    
			var message =addAppReason("<%=request.getContextPath()%>");
			if(message==null)return;
			form.action="<venus:base/>/QuotationAction.do?message="+message[0]+ "&date=" + new Date();
			document.getElementById("cmd").value="appOperateHZ";
			form.submit();
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/QuotationAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperateHZ";
        form.submit();
    }
</script>

	</head>
	<body>

	<form name="form" method="post"><input type="hidden" value=""
		name="cmd" id="cmd"> <input type="hidden"
		value="<%=taskuid%>" name="taskuid" id="taskuid">
<input  type="hidden"  value="${done }" name="done" id="done"  >
	<table class="table_noFrame">
		<tr>
			<td>
			     <c:if test="${done=='true'}">
		                <div class="foot_button">
		                    <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
		                </div>
		        </c:if>
		        <c:if test="${done=='false'}">
		              <div class="foot_button">
		                    <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
		                    <input name="button_app" class="icon_2" type="button" value="<fmt:message key="examine"/>"  onclick="javascript:appOperate_onClick();" >
		                    <input name="button_back" class="icon_2"  type="button" value="<fmt:message key="button_back"/>"  onclick="javascript:backOperate_onClick();" >
		              </div>
		        </c:if>
			</td>
		</tr>
	</table>

	<div id="right">
	<div class="right_title_bg">
	<div class=" right_title"><fmt:message key="detail_page" /></div>
	</div>
	<div class="ringht_s">

	<div id="ccParent0" class="box_3">
	<div class="xz_title"><fmt:message key="basic_information"/></div>
	<table width="100%" border="0" cellspacing="1" cellpadding="0"
		bgcolor="#c5dbe2">

		<tr>

			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_code"/></td>
			<td class="td_2"><%=RmStringHelper.prt(resultVo.getQuotation_code())%></td>
			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_name"/></td>
			<td class="td_2"><%=RmStringHelper.prt(resultVo.getQuotation_name())%></td>

		</tr>

		<tr>

			<td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
			<td class="td_2"><%=RmStringHelper.prt(resultVo.getCustomer_name())%></td>
			<td class="td_1"><fmt:message key="is_renewal_sign"/></td>
			<td class="td_2">
			<%if(resultVo==null){ %> <input type='checkbox' name="is_renewal_sign"
				disabled="disabled" value="1" pdType='control'
				control='checkbox_template' /> <%}else{ if((resultVo.getIs_renewal_sign())!=null&&(resultVo.getIs_renewal_sign()).equals("1")) {%>
			<input type='checkbox' name="is_renewal_sign" disabled="disabled"
				value="1" pdType='control' control='checkbox_template'
				checked="checked" /> <%}else {%> <input type='checkbox'
				name="is_renewal_sign" disabled="disabled" value="1"
				pdType='control' control='checkbox_template' /> <%}} %>
			</td>
		</tr>
        <tr>
            <td class="td_1">客户编号</td>
            <td class="td_2">
                <input type="text" class="text_field" name="customer_code" inputName="客户编号" value="${customer_code }" readonly="true" />
             </td>
            <td class="td_1">提交审批人</td>
            <td class="td_2">
                <input type="text" class="text_field" name="creator" inputName="提交审批人" value="${creator }" readonly="true" />
            </td>
        </tr>
		<tr>
			<td class="td_1"><fmt:message key="remark"/></td>
			<td colspan="3" class="td_2"><textarea rows="3"
				class="textarea_limit_words" name="remark" readonly="true"><%=RmStringHelper.prt(resultVo.getRemark())%></textarea></td>
		</tr>


	</table>
	</div>
	<div class="xz_title"><fmt:message key="product_information"/></div>
	<div class="clear"></div>
	<div style="margin: 0px;"><r:datacell id="datacell1"
		queryAction="/FAERP/QuotationAction.do?cmd=getProduct&quotationid='${bean.id}'"
		width="98%" xpath="QuotationitemVo" submitXpath="QuotationitemVo"
		paramFormId="datacell_formid" pageSize="-1">
		<r:field fieldName="pid" label="" width="50px" align="center">

		</r:field>
		<r:field fieldName="product_name" width="250px" messagekey="product_name">
		</r:field>

		<r:field fieldName="standard_price" width="100px" messagekey="biaozhun_price">
		</r:field>
		<%if(resultVo!=null && resultVo.getIs_renewal_sign().equals("1")) {%>
		<r:field fieldName="old_price" width="100px" messagekey="oid_price">
		</r:field>
		<%} %>
		<r:field fieldName="product_price" width="100px" messagekey="one_price">
		</r:field>
		
		<r:field fieldName="product_desc" width="426px" messagekey="product_desc">
		</r:field>

	</r:datacell></div>
	</div>
	</div>
	<input type="hidden" name="id"
		value="<%=RmStringHelper.prt(resultVo.getId())%>"> <input
		type="hidden" name="isZj" value="${isZj}" />
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	var flag ;
	<%if(resultVo!=null && resultVo.getIs_renewal_sign().equals("1")) {%>
		flag = 1;
		<%} %>
	var a;
	var b;
	$id("datacell1").afterRefresh = function(){
		var Me = $id("datacell1");
		var rows = Me.allTR;
		for (var i=0;i<rows.length;i++ ){
			var entity1 = Me.dataset.get(i);
			var cells = rows[i].cells;
			for (var j=0;j<cells.length;j++ ){
				var cell = cells[j];
				var field = Me.getField(cell);
				
				if(flag == 1){
					if(field.fieldName=="old_price"){
					    a =entity1.getProperty(field.fieldName);
					  //  alert(1111112 + a);
					}
				}else{
					if(field.fieldName=="standard_price"){
					    a =entity1.getProperty(field.fieldName);
					   // alert(22221 + a);
					}
				}
				if(field.fieldName=="product_price"){
				    b =entity1.getProperty(field.fieldName);
				    if(a != b){
				    	//alert(a+ "====" + b);
						cell.style.backgroundColor = "red";
					}
				}
			}
			
		}
	}
</script>
</body>
</html>
