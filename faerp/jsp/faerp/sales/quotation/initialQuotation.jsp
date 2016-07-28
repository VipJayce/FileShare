<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.quotation.vo.QuotationVo"%>
<%@ page import="rayoo.sales.quotation.util.IQuotationConstants"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@ page import="java.util.*"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%
    //取出List

    SalcontractVo resultVo = null; //定义一个临时的vo变量
    String contract_code = request.getParameter("contract_code") == null ? ""
            : request.getParameter("contract_code").toString();
    String contract_name = request.getParameter("contract_name") == null ? ""
            : request.getParameter("contract_name").toString();

    String customer_code = request.getParameter("customer_code") == null ? ""
            : request.getParameter("customer_code").toString();
    String customer_name = request.getParameter("customer_name") == null ? ""
            : request.getParameter("customer_name").toString();
    String quotation_name = request.getParameter("quotation_name") == null ? ""
            : request.getParameter("quotation_name").toString();
    String Quotation_template_name = request
            .getParameter("Quotation_template_name") == null ? ""
            : request.getParameter("Quotation_template_name")
                    .toString();
    String Quotation_template_code = request
            .getParameter("Quotation_template_code") == null ? ""
            : request.getParameter("Quotation_template_code")
                    .toString();
    String add_type_bd = request.getAttribute("add_type_bd") == null ? ""
            : request.getAttribute("add_type_bd").toString();
    String company_id = request.getAttribute("company_id") == null ? ""
            : request.getAttribute("company_id").toString();
    String quotation_code = request.getAttribute("QuotationCode") == null ? ""
            :request.getAttribute("QuotationCode").toString();

%>

<html>
<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	
	var quotation_biz_type_bd = '';//选择的报价单的类型
	var add_type_bd_select_options = null;
	jQuery(function(){
        var add_type_bd_select = jq("select[name=add_type_bd]");
        var options = add_type_bd_select.find("option");
        add_type_bd_select_options = options.clone(true);
        
        
    });
	
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/jsp/faerp/sales/quotation/insertQuotation.jsp";
		form.submit();
	}


    function cancel_onClick(){  //取消后返回列表页面
        window.close();
        //form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
    }
       //查询合同
     function toFindContract(obj)
    {
        document.form.contract_id.value=obj[0];
        document.form.contract_name.value=obj[1];
        document.form.customer_name.value=obj[3];
        document.form.company_id.value=obj[5];
        document.form.customer_id.value=obj[2];
        document.form.customer_code.value=obj[4];
        
        //cc
        var contract_type_bd = obj[6];
        document.form.contract_type_bd.value = contract_type_bd;//合同类型 1:劳务派遣协议 2:人事委托服务合同 3:服务外包合同 4:体检服务协议 4:补充福利 5:其他
        var add_type_bd_select = jq("select[name=add_type_bd]");
        var options = add_type_bd_select.find("option");
        options.remove();
        add_type_bd_select.append(add_type_bd_select_options.clone(true));
        options = add_type_bd_select.find("option");
        //alert(contract_type_bd);
        /*专项外包的合同新增方式的控制
        if(contract_type_bd == 7){//专项外包的合同
	        //options
	        options.each(function(){
	            if(jq(this).attr("value") == 3){
	               jq(this).remove();
	            }
	        });
        }else {//
            options.each(function(){
                if(jq(this).attr("value") == 1){
                   jq(this).remove();
                }
            });
        }
        */
        document.all.templete.style.display='none';
        document.all.quotation.style.display='none';
        //displayValue
        //$id("quotation_name").displayValue = "";
        
        var lookup = $id("quotation_name");
	    lookup.setValue("");
        lookup.setDisplayValue("");
    
    }

     function toFindQuotation(obj) {
       document.form.quotation_id.value=obj[0];
       var lookup = $id("quotation_name");
       lookup.displayValue = obj[1];
       document.form.quotation_name.value=obj[1];
       quotation_biz_type_bd = obj[3];
       return false;
    }
     function toFindQuotationtemplete(obj)
    {
       document.form.quotation_template_id.value=obj[0];
       document.form.quotation_tpl_id.value=obj[0];
       document.form.quotation_template_name.value=obj[1];
    }
   
    function changefanshi(){//选择方式
            var contract_name=document.form.contract_name.value;
            var add_type_bd=document.all.add_type_bd.value; 
            if(contract_name==""||contract_name==null){
                alert("<fmt:message key="contact_not_null"/>");
                document.form.add_type_bd.value='';
                return;
            }
            if(add_type_bd=='1'){
                  document.all.templete.style.display='';
                  document.all.quotation.style.display='none';
            }else if(add_type_bd=='2'){
                 document.all.templete.style.display='none';
                 document.all.quotation.style.display='';
            }else if(add_type_bd=='3'){
                 document.all.templete.style.display='none';
                 document.all.quotation.style.display='none';
            }
        }
 

/*
<option value="1">引用模板</option>
<option value="2">引用报价单</option>
<option value="3">定制</option>
*/
function update_onClick() { // 保存修改后的单条数据
    if (checkAllForms()) {
        var contract_name = document.form.contract_name.value;
        var quotation_template_name = document.form.quotation_template_name;
        var quotation_name = document.form.quotation_name;
        var add_type_bd = document.all.add_type_bd.value;

        if (contract_name == "" || contract_name == null) {
            alert("<fmt:message key="contact_not_null"/>");
            return;
        }
        if (add_type_bd <= 0) {
            alert("<fmt:message key="choose_add"/>");
            return;
        }
        
        if (add_type_bd == 1) {
            /*
            var ids = document.form.quotation_template_id.value;
            var quotationcode = document.form.quotation_code.value;
            form.action = "<%=request.getContextPath()%>/QuotationtemplateAction.do?cmd=findtemplete&id="
                    + ids + "&quotationcode=" + quotationcode;
            form.submit();
            */
            var id = document.form.quotation_tpl_id.value;
            //alert(" 引用模板 " + id);
            if (id == null || id == "") {
                alert("<fmt:message key="choose_templete"/>");
                return;
            }
            var ids = document.form.quotation_id.value;
            var quotationcode = document.form.quotation_code.value;
            form.action = "<%=request.getContextPath()%>/QuotationAction.do?tpl_id=" + id;
            form.cmd.value = "toAddFromTpl";
            form.submit();
            
            
        } else if (add_type_bd == 2) {
        
            if (!$id("quotation_name").displayValue) {
                alert("<fmt:message key="choose_quotation"/>");
                return;
            }
            
            
            var ids = document.form.quotation_id.value;
            var quotationcode = document.form.quotation_code.value;
            
            if(document.form.contract_type_bd.value == "7" || quotation_biz_type_bd == "7" ){//专项外包的
	            form.action = "<%=request.getContextPath()%>/QuotationAction.do?id="
	                    + ids + "&quotation_code=" + quotationcode;
	            form.cmd.value = "toAddFromOldSpQuotation";
            }else {
                form.action = "<%=request.getContextPath()%>/QuotationAction.do?id="
                    + ids + "&quotation_code=" + quotationcode;
                form.cmd.value = "find1";
            }
            
            form.submit();
        } else {
            var cust_id = document.form.customer_id.value;
            form.action = "<%=request.getContextPath()%>/jsp/faerp/sales/quotation/insertQuotation.jsp?customer_id="
                    + cust_id+"&com_id=${com_id}";
            form.submit();
        }
    }
}


</script>
	</head>
	<body>

	<form name="form" method="post">
    <input type="hidden" name="cmd">
	<div id="right">

	<div class="ringht_x">
	<div id="ccChild1" class="box_xinzeng">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">

		<tr>
			<input type="hidden" id="quotation_code" name="quotation_code"
				value="<%=quotation_code %>" />
			<input type="hidden" id="company_id" name="company_id" />
			<input type="hidden" id="contract_id" name="contract_id" />
			<input type="hidden" id="customer_id" name="customer_id" />
			<input type="hidden" id="customer_name" name="customer_name" />
			<input type="hidden" id="contract_type_bd" name="contract_type_bd" />
			<input type="hidden" id="customer_code" name="customer_code"
				value="<%= customer_code%>" />
			<input type="hidden" id="quotation_id" name="quotation_id" value="" />
			<input type="hidden" id="quotation_templete_id"
				name="quotation_templete_id" />

			<td class="td_1"><span class="style_required_red">* </span><fmt:message
				key="choose_contact" /></td>

			<td class="td_2"><input type="hidden" name="contract_code" /> <w:lookup
				onReturnFunc="toFindContract" readonly="true" id="contract_name"
				name="contract_name"
				lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"
				messagekey="choose_contact" height="444" width="764"
				style="width:188px" />
			<td class="td_1"><span class="style_required_red">* </span><fmt:message
				key="add_fangshi" /></td>

			<td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField(
                            "add_type_bd", -1, "SAL_QUO_ADD_TYPE_BD",
                            add_type_bd, "onchange='changefanshi()'", false)%></td>

		</tr>


		<tr style="display: none" id="quotation">
			<td class="td_1"><span class="style_required_red">* </span><fmt:message
				key="choose_quotation_name" /></td>
			<td class="td_2"><w:lookup onReturnFunc="toFindQuotation"
				readonly="true" id="quotation_name" name="quotation_name"
				lookupUrl="/jsp/faerp/common/sales/allQuotation.jsp?"
				messagekey="choose_quotation_name" height="440" width="720"
				style="width:188px" /></td>

			<script type="text/javascript">

jq(function(){

    function beforeOpen(lookup){
        
        lookup.params = [];
        var contract_type_bd = document.form.contract_type_bd.value;//合同类型 1:劳务派遣协议 2:人事委托服务合同 3:服务外包合同 4:体检服务协议 4:补充福利 5:其他
        var biz_type_bd = "";
        if(contract_type_bd == "7"){
            biz_type_bd = "7";
        }else {
            biz_type_bd = "";
        }
        lookup.addParam("biz_type_bd",biz_type_bd);
        
        return true;
    }
    
    $id("quotation_name").beforeOpenDialog= beforeOpen;
    

});
</script>

			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
		</tr>
		</tr>
		<tr style="display: none" id="templete">
			<td class="td_1"><span class="style_required_red">* </span><fmt:message
				key="choose_add_templete" /></td>
			<td class="td_2"><input type="hidden"
				name="quotation_template_id" /> <input type="hidden"
				name="quotation_tpl_id" /> <w:lookup
				onReturnFunc="toFindQuotationtemplete" readonly="true"
				id="quotation_template_name" name="quotation_template_name"
				lookupUrl="/jsp/faerp/common/sales/alllistSalQuotationTpl.jsp"
				messagekey="choose_quotation_templete" height="444" width="764"
				style="width:188px" /></td>
			</td>

			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>

		</tr>

	</table>



	<div class="mx_button">
		<input type="button" class="icon_2" value='<fmt:message key="confirm"/>' onClick="javascript:update_onClick()" />
		<input type="button" class="icon_2" value='<fmt:message key="go_back"/>' onClick="javascript:cancel_onClick()" /></div>
	</div>

	<input type="hidden" name="id" value=""> <input type="hidden"
		name="create_date" />
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	 /*
	 $id("quotation_name").beforeOpenDialog = function(lookup){
      lookup.params = [];
      lookup.addParam("contract_id", $id("contract_id").value);
      return true;
    }
    */
	
</script>
</body>
</html>


