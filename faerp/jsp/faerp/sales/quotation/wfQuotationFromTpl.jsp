<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="rayoo.sales.quotation.vo.QuotationVo"%>
<%@page import="rayoo.sales.quotation.util.IQuotationConstants"%>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<h:script src="/js/common/taxGenerate.js"/>

<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>

<%  //判断是否为修改页面
    String is_renewal_sign = request.getParameter("is_renewal_sign")==null ? "":request.getParameter("is_renewal_sign").toString();
    String customer_id = request.getParameter("customer_id")==null ? "":request.getParameter("customer_id").toString();
    String customer_code = request.getParameter("customer_code")==null ? "11111" :request.getParameter("customer_code").toString();
    String product_price = request.getParameter("product_price")==null ? "0" :request.getParameter("product_price").toString();
    //String count = request.getParameter("count")==null ? "0" :request.getParameter("count").toString();
    String company_id = request.getParameter("company_id")==null ? "" :  request.getParameter("company_id").toString().trim().replace(" ","");
    String add_type_bd = request.getParameter("add_type_bd")==null ? "" :  request.getParameter("add_type_bd").toString();
    String contract_id = request.getParameter("contract_id")==null ? "" :request.getParameter("contract_id").toString();
    String quotationcode= request.getAttribute("quotationcode") == null ? "" : request.getAttribute("quotationcode").toString();
    String customer_name=request.getAttribute("customer_name")==null?"":request.getAttribute("customer_name").toString();
    String  old_quotation_id=request.getParameter("old_quotation_id")==null?"":request.getParameter("quotation_id").toString();
    String  tpl_id=request.getParameter("tpl_id")==null?"":request.getParameter("tpl_id").toString();
    String  taxrate=request.getAttribute("taxrate")==null?"":request.getAttribute("taxrate").toString();
    String  add_taxrate=request.getAttribute("add_taxrate")==null?"":request.getAttribute("add_taxrate").toString();
    String  taxrateBu=request.getAttribute("taxrateBu")==null?"":request.getAttribute("taxrateBu").toString();
    String  add_taxrateBu=request.getAttribute("add_taxrateBu")==null?"":request.getAttribute("add_taxrateBu").toString();

    QuotationVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    boolean isDetail = request.getAttribute("isDetail")!=null ? Boolean.valueOf(request.getAttribute("isDetail").toString()) : false;
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IQuotationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (QuotationVo)request.getAttribute(IQuotationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
            is_renewal_sign = resultVo.getIs_renewal_sign();
            customer_id = resultVo.getCustomer_id();
            customer_code = resultVo.getCustomer_code();
            company_id = resultVo.getCompany_id();
            add_type_bd = resultVo.getAdd_type_bd();
            contract_id = resultVo.getContract_id();
            quotationcode= resultVo.getQuotation_code();
            customer_name=resultVo.getCustomer_name();
            old_quotation_id=resultVo.getOld_quotation_id();
        }
    }
    
    //
    String id = "";
    if(resultVo != null) {
        id = resultVo.getId();
  
    }
    boolean wfShow = false;
    if(request.getAttribute("wfShow") != null){
        wfShow = true;
    }
%>

<html>
<fmt:bundle basename="rayoo.salse.quotation.quotation_resource" prefix="rayoo.salse.quotation.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

    <script language="javascript">
    var taxrate = parseFloat(<%=taxrate %>);
	var add_taxrate = parseFloat(<%=add_taxrate %>);
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
        //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
            var message =addAppReason("<%=request.getContextPath()%>");
            if(message==null)return;
            form.action="/FAERP/QuotationAction.do?message="+message[0]+ "";
            document.getElementById("cmd").value="auditAccess";
            form.submit();
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/QuotationAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
    }
    
    
var toAddFromTpl = "${toAddFromTpl}";
var toAddFromOldSpQuotation = "${toAddFromOldSpQuotation}";
var isDetail = "${isDetail}";
var form;
jQuery(function() {
    form = jQuery("#insert_sal_form")[0];
    
    $id("datacell_sc_item").isQueryFirst = false;// 


    if (isDetail == "true") {//杨旭 查看专项外包报价单
        $id("datacell_sc").isQueryFirst = false;// 
        $id("datacell_para").isQueryFirst = false;// 
        jQuery(".button_right ul li").hide();
        jQuery("#update_button").hide();
        jQuery("#checkButton").hide();
    }
    if (toAddFromTpl == "true") {// ADD NEW 
        $id("datacell_sc").isQueryFirst = false;// 
        $id("datacell_para").isQueryFirst = false;// 
        jQuery(".button_right ul li").hide();
        
        // setTimeout('jQuery(".button_right ul li").show()', 1000);
        $id("datacell_sc").beforeInit()
        {
            var id = jq("#tpl_id").val();
            jQuery.getJSON(
                    "<venus:base/>/Sal_quotation_scAction.do?cmd=getAll&date="
                            + new Date() + "", {
                        "tpl_id" : id
                    }, function(json) {
    
                        if (json.beans != null && json.beans != "") {
                            for (var i = 0; i < json.beans.length; i++) {
                                var newEntity = $id("datacell_sc").styleEntity
                                        .clone(true);// 只克隆行样式，不带值
                                newEntity.setProperty("name", json.beans[i].name);
                                newEntity.setProperty("code", json.beans[i].code);
                                newEntity.setProperty("formula",
                                        json.beans[i].formula);
                                newEntity.setProperty("remark",
                                        json.beans[i].remark);
                                $id("datacell_sc").addRow(newEntity);
                            }
                        }
                    });
        }
        $id("datacell_para").beforeInit()
        {
            var id = jq("#tpl_id").val();
            jQuery.getJSON(
                    "<venus:base/>/Sal_quotation_sc_paraAction.do?cmd=getAll&date="
                            + new Date() + "", {
                        "tpl_id" : id
                    }, function(json) {
    
                        if (json.beans != null && json.beans != "") {
                            for (var i = 0; i < json.beans.length; i++) {
                                var newEntity = $id("datacell_para").styleEntity
                                        .clone(true);// 只克隆行样式，不带值
                                newEntity.setProperty("name", json.beans[i].name);
                                newEntity.setProperty("code", json.beans[i].code);
                                newEntity.setProperty("data_type",
                                        json.beans[i].data_type);
                                newEntity.setProperty("default_value",
                                        json.beans[i].default_value);
                                newEntity.setProperty("remark",
                                        json.beans[i].remark);
                                $id("datacell_para").addRow(newEntity);
                            }
                        }
                    });
        }
    }if (toAddFromOldSpQuotation == "true") {// ADD from old sp quotation
        $id("datacell_sc").isQueryFirst = false;// 
        $id("datacell_para").isQueryFirst = false;// 
        jQuery(".button_right ul li").hide();
        
        // setTimeout('jQuery(".button_right ul li").show()', 1000);
        $id("datacell_sc").beforeInit()
        {
            var parent_quotation_id = jQuery("#parent_quotation_id").val();
            jQuery.getJSON(
                    "<venus:base/>/Sal_quotation_scAction.do?cmd=getAll&date="
                            + new Date() + "", {
                        "parent_quotation_id" : parent_quotation_id
                    }, function(json) {
    
                        if (json.beans != null && json.beans != "") {
                            for (var i = 0; i < json.beans.length; i++) {
                                var newEntity = $id("datacell_sc").styleEntity
                                        .clone(true);// 只克隆行样式，不带值
                                newEntity.setProperty("name", json.beans[i].name);
                                newEntity.setProperty("code", json.beans[i].code);
                                newEntity.setProperty("formula",
                                        json.beans[i].formula);
                                newEntity.setProperty("remark",
                                        json.beans[i].remark);
                                $id("datacell_sc").addRow(newEntity);
                            }
                        }
                    });
        }
        $id("datacell_para").beforeInit()
        {
            var parent_quotation_id = jQuery("#parent_quotation_id").val();
            jQuery.getJSON(
                    "<venus:base/>/Sal_quotation_sc_paraAction.do?cmd=getAll&date="
                            + new Date() + "", {
                        "parent_quotation_id" : parent_quotation_id
                    }, function(json) {
    
                        if (json.beans != null && json.beans != "") {
                            for (var i = 0; i < json.beans.length; i++) {
                                var newEntity = $id("datacell_para").styleEntity
                                        .clone(true);// 只克隆行样式，不带值
                                newEntity.setProperty("name", json.beans[i].name);
                                newEntity.setProperty("code", json.beans[i].code);
                                newEntity.setProperty("data_type",
                                        json.beans[i].data_type);
                                newEntity.setProperty("default_value",
                                        json.beans[i].default_value);
                                newEntity.setProperty("remark",
                                        json.beans[i].remark);
                                $id("datacell_para").addRow(newEntity);
                            }
                        }
                    });
        }
    }else {// update
        //load 三个datacell 的数据
        
        $id("datacell_sc").isQueryFirst = true;// 
        $id("datacell_para").isQueryFirst = true;// 
        
        
    }
    
    
    
    
    
    var flag ;
    <%if(resultVo!=null && resultVo.getIs_renewal_sign().equals("1")) {%>
        flag = 1;
        <%} %>
    var a;
    var b;
     $id("datacell_product").afterRefresh = function(){
     
        var Me = $id("datacell_product");
     
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
                    }
                }else{
                    if(field.fieldName=="standard_price"){
                        a =entity1.getProperty(field.fieldName);
                    }
                }
                
                if(field.fieldName=="product_price"){
                    b =entity1.getProperty(field.fieldName);
                    if(a != b){
                        cell.style.backgroundColor = "red";
                    }
                }
            }
            
        }
        checkSum();
        
        /* jQuery.getJSON("<venus:base/>/QuotationAction.do?cmd=getTaxrate",{},   function(json){
			$name("taxrate").value=json.taxrate;//增值税税率 */
			//checkPrice('product_price','vat_amount','add_vat_amount','产品价格');
		//});
    }
    

});
function simpleQuery_onClick() { // 简单的模糊查询
    $id("datacell_sc").loadData();
    $id("datacell_sc").refresh();

    $id("datacell_para").loadData();
    $id("datacell_para").refresh();
}
function checkAllForms() {
    var form = jQuery("#insert_sal_form");
    var quotation_name = form.find("input[name=quotation_name]").val();
    if (!quotation_name) {
        alert("<fmt:message key="quotation_not_null"/>");
        return false;
    }
    var isrenewalsign = document.getElementById("is_renewal_sign_checkbox").checked;
    if(!!isrenewalsign)
    {
        form.find("[name=is_renewal_sign]").val(1);
    }
    else
    {
        form.find("[name=is_renewal_sign]").val(0);
    }
    return true;

}
function insert_onClick() { // 插入单条数据
    if (checkAllForms()) {
        if (toAddFromTpl) {
        }
        var tpl_id = jQuery("#tpl_id").val();

        var form = jQuery("#insert_sal_form");
        var update_button = jQuery("#update_button");
        update_button.attr({
            "disabled" : "disabled"
        });
        if(toAddFromOldSpQuotation == "true"){
        
            form.find("[name=cmd]").val("addFromOldSpQuotation");
            //form.find("[name=add_type_bd]").val(5);
            form.action = "<%=request.getContextPath()%>/QuotationAction.do?oldid=${parent_quotation_id}";
        }else {
            form.find("[name=cmd]").val("addFromTpl");
            //form.find("[name=add_type_bd]").val(5);
            form.action = "<%=request.getContextPath()%>/QuotationAction.do?tpl_id="
                    + tpl_id;
        }
        
        form.submit();

        /*
         * ajaxRequest(form, function(data){
         * jQuery("#sal_quotation_id").val(data.id); //simpleQuery_onClick();
         * var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
         * tpl_sc_list_div.show();
         *  } , function(){ alert("error."); } )
         */
    }
}

function update_onClick(id) { // 保存修改后的单条数据
    if (!getConfirm()) { // 如果用户在确认对话框中点"取消"
        return false;
    }
    if (checkAllForms()) {
        var form = jQuery("#insert_sal_form");
        form.action = "<%=request.getContextPath()%>/QuotationAction.do?cmd=updateFromTpl";
        //form.find("[name=add_type_bd]").val(5);
        ajaxRequest(form, function(data) {
            if(data){
                alert("<fmt:message key="update_success"/>");
                
            }
        }, function() {
            alert("error.");
        })

    }
}


var currentFormulaText = null;
function toSetFormual(th,isBig) {
    currentFormulaText = th;
    // w为窗口宽度，h为高度
    var w = 1250;
    var h = 600;
    var l = 70;// (screen.width - w) / 2;
    var t = 70;// (screen.height - h) / 2;
    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=yes,resizable=yes,location=no,status=no';
    var url = "<%=request.getContextPath()%>/jsp/faerp/sales/sal_quotation_tpl/tosetformual4quotation.jsp";
    if(isBig){
    
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var sc_id = datasettr.getProperty("id");
    
        url +=  "?isRich=true&sal_quotation_id="+jQuery("#sal_quotation_id").val()+
                "&sc_id="+sc_id;
    }
        
    window.open(url, 'newwindow', s);

}

function checkQuotation_onClick(){  ////检查 相关 公式是否合法
    
    var id = jq("#sal_quotation_id").val();
    if(id){
        var form = jQuery("#insert_sal_form");
        form.action="<%=request.getContextPath()%>/QuotationAction.do?cmd=checkFormula&date="+new Date().getTime()+"&id=" + id ;
        
        ajaxRequest(form,
            function(data){
                alert(data.message);
                if(data.isOk==true){
                    cancel_onClick();
                }else{
                    
                }
            } , 
            function(){
                alert("error.");
            }
        )
    }else {
        alert("<fmt:message key="save_templete"/>");
    }
}
</script>
</head>
<body>
<!--<textarea rows="2" cols="80" name="test" id="console" style="display: "><%=id %></textarea>-->

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>



 
<div class="ringht">

<!--模板的基本信息 -->

<div id="ccParent0" class="box_3">
<form action="" id="insert_sal_form" name="form" method="post">
    <div class="xz_title">报价单审批</div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0"
        bgcolor="#c5dbe2">
    
        <tr>
            <input type="hidden" id="parent_quotation_id" name="parent_quotation_id" value="${parent_quotation_id }" />
            <input type="hidden" name="id" value="<%=id %>" />
            <input type="hidden" name="cmd" value="" id="cmd"/>
            <input type="hidden" value="${taskuid }" name="taskuid" id="taskuid">
            <input type="hidden" name="contract_id" value="<%=contract_id%>" />
            <input type="hidden" name="customer_id" value="<%=customer_id%>" />
            <input type="hidden" name="customer_code" value="<%=customer_code %>" />
            <input type="hidden" name="add_type_bd" value="5" />
            <input type="hidden" name="biz_type_bd" value="7"/>
            <input type="hidden" name="company_id" value="<%=company_id %>" />
            
            <input type="hidden" name="oldid" value="${parent_quotation_id }" />
            <input type="hidden" name="count" value="1" />
            <input type="hidden" name="quotation_status" value="0" />
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_code"/></td>
            <td class="td_2 "><input type="text" class="text_field"
                name="quotation_code" inputName="报价单名称编号" maxLength="50"
                readonly="true" value="<%=quotationcode %>"/></td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="quotation_name"/></td>
            <td class="td_2 "><input type="text" class="text_field" value="${bean.quotation_name }"
                name="quotation_name" inputName="报价单名称" maxLength="50" /></td>
    
        </tr>
    
        <tr>
    
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 " colspan='3'><input type="text"
                class="text_field" name="customer_name" inputName="客户名称" value="<%=customer_name%>" maxLength="50" readonly="true"
            validate="notNull;notNullWithoutTrim" /></td>
            <!-- td class="td_1">业务类别</td>
                <td class="td_2"><%=gap.rm.tools.helper.RmJspHelper.getSelectField( "biz_type_bd", -1, "SAL_QUO_BIZ_TYPE_BD", "0", "",  false)%></td> -->
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
            <td class="td_1"><fmt:message key="is_renewal_sign"/></td>
    
            <td class="td_2" class="td_2" colspan='3'><input type='checkbox' <%="1".equals(is_renewal_sign)?"checked":"" %>
                name="is_renewal_sign_checkbox" pdType='control' control='checkbox_template' />
                <input type="hidden" name="is_renewal_sign" />
            </td>
    
        </tr>
        <tr>
    
            <td class="td_1"><fmt:message key="remark"/></td>
            <td class="td_2"><textarea rows="3"
                class="textarea_limit_words" name="remark">${bean.remark }</textarea></td>
            <td colspan="2" class="td_1" >
            
                <%if(isDetail == false ){ %>
                    <input id="update_button" type="button" class="icon_2"
                    value='<%=isModify?"保存修改":"新增保存"%>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
                    
                    
                    <%if(isModify){ %>
                        <input type="button" class="icon_2" value='<fmt:message key="checkquotation"/>'  onClick="javascript:checkQuotation_onClick()"  id="checkButton"/>
                    <%} %>
                 <%} %>
                
                
                <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:history.go(-1);"/>
                
                
                <%if(wfShow) {%>
                    <input name="button_app" class="icon_2" type="button" value="<fmt:message key="examine"/>"
                    onclick="javascript:appOperate_onClick();"> 
                    <input name="button_back" class="icon_2" type="button" value="<fmt:message key="button_back"/>"
                    onclick="javascript:backOperate_onClick();">
                <%} %>
            </td>
        </tr>
    
    
    </table>
</form>
</div>



<!--模板的基本信息 -->


   

<!-- 模板大项的列表 -->

<script language="javascript">
    
    function deleteMulti_onClick(){
        
        var datacell = $id("datacell_sc");
        
        
        
        //var dataset1 = obj.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        
       
        
        activeRow_sc = activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="yinyong_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="query_delete_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
              //datacell.dataset.removeEntity(datacell.dataset.getActiveEntity(),true);
              //dataset1.removeEntity(obj.getActiveEntity(),true);
           }
       }
    }
    
    var activeRow_sc = null
    function moveDown_onClick_sc() {  //到增加记录页面
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var order_col = datasettr.getProperty("order_col")
        
        
        var next = activeRow.nextSibling;
        if(next == null){
            alert("<fmt:message key="query_lower_end"/>");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_next = datacell.getEntity(next);
            var order_col2 = datasettr_next.getProperty("order_col");
            
            datasettr.setProperty("order_col", order_col2);
            datasettr_next.setProperty("order_col", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveDown(activeRow);
        }
        
        
     }
    function moveUp_onClick_sc() {  //到增加记录页面
        
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var order_col = datasettr.getProperty("order_col")
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("<fmt:message key="query_lower"/>");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_pre = datacell.getEntity(pre);
            var order_col2 = datasettr_pre.getProperty("order_col");
            
            datasettr.setProperty("order_col", order_col2);
            datasettr_pre.setProperty("order_col", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveUp(activeRow);
        }
        
        
    }
    
    function toAdd_onClick() {  //到增加记录页面
            var datacell = $id("datacell_sc");
            datacell.addRow();
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            datasettr.setProperty("is_indie_bd",'0');
    }
    
    function toSave_onClick() { 
        var datacell1 = $id("datacell_sc");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("name")==null || datasettr.getProperty("name")==''){
                    alert('<fmt:message key="input_name"/>');
                    return;
                }
                if(datasettr.getProperty("code")==null || datasettr.getProperty("code")==''){
                    alert('<fmt:message key="input_code"/>');
                    return;
                }
                if(datasettr.getProperty("formula")==null || datasettr.getProperty("formula")==''){
                    alert('<fmt:message key="input_formula"/>');
                    return;
                }
                //alert(datasettr.getProperty("name") + " / " + datasettr.getProperty("order_col") );
                datasettr.setProperty("sal_quotation_id",jQuery("#sal_quotation_id").val());
            }
            
        }
        var result = datacell1.submit();
        if(result == true){
            alert("<fmt:message key="save_success"/>");
        }
    }
    
    
    function setCheckboxStatus_sc(value,entity,rowNo,cellNo){
        /*
        for(var pops in entity){
            alert(pops + "=" + entity[pops]);
        }
        */
       return "<input type='radio'  name='radio_sc' value='"  + entity.getProperty("id") + "'  onClick=clickRow_sc(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";//
    }

    function clickRow_sc(id,value){
        if(id){
            jQuery("#sal_quotation_sc_id").val(id);
            $id("datacell_sc_item").loadData();
            $id("datacell_sc_item").refresh();
        }
        
    }
    
    
    //服务小项
    
    var activeRow_sc_item = null
    function moveUp_onClick_sc_item() {  //到增加记录页面
        
        var datacell = $id("datacell_sc_item");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var order_col = datasettr.getProperty("order_col")
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("<fmt:message key="query_lower"/>");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_pre = datacell.getEntity(pre);
            var order_col2 = datasettr_pre.getProperty("order_col");
            
            datasettr.setProperty("order_col", order_col2);
            datasettr_pre.setProperty("order_col", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveUp(activeRow);
        }
        
            
            
    }
    
    function moveDown_onClick_sc_item() {  //到增加记录页面
        var datacell = $id("datacell_sc_item");
        var activeRow = datacell.activeRow;
        
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var order_col = datasettr.getProperty("order_col")
        
        
        var next = activeRow.nextSibling;
        if(next == null){
            alert("<fmt:message key="query_lower_end"/>");
            return;
        }else {
            datacell.isModefied = true;
            
            var datasettr_next = datacell.getEntity(next);
            var order_col2 = datasettr_next.getProperty("order_col");
            
            datasettr.setProperty("order_col", order_col2);
            datasettr_next.setProperty("order_col", order_col);
            
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveDown(activeRow);
        }
        
        
     }
     
    function deleteMulti_onClick_sc_item(){
        
        var datacell = $id("datacell_sc_item");
        //var dataset1 = obj.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="yinyong_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="query_delete_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
              //datacell.dataset.removeEntity(datacell.dataset.getActiveEntity(),true);
              //dataset1.removeEntity(obj.getActiveEntity(),true);
           }
       }
    }
    
    
    function toAdd_onClick_sc_item() {  //到增加记录页面
    
            var val=jQuery('input:radio[name="radio_sc"]:checked').val();
            if(val==null){
                alert("<fmt:message key="choose_radio"/>");
                return false;
            }
            else{
                //var selected_sal_quotation_id = jQuery("#sal_quotation_id").val();
                if(val==""){
                    alert("<fmt:message key="choose_save_radio"/>");
                }else {
                    var datacell = $id("datacell_sc_item");
                    datacell.addRow();
                    var activeRow = datacell.activeRow;
                    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
                    
                    datasettr.setProperty("is_indie_bd",'0');
                }
                
            }
            
            
    }
    
    function toSave_onClick_sc_item() { 
        var datacell1 = $id("datacell_sc_item");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
            
                if(datasettr.getProperty("name")==null || datasettr.getProperty("name")==''){
                    alert('<fmt:message key="input_name"/>');
                    return;
                }
                if(datasettr.getProperty("code")==null || datasettr.getProperty("code")==''){
                    alert('<fmt:message key="input_code"/>');
                    return;
                }
                if(datasettr.getProperty("formula")==null || datasettr.getProperty("formula")==''){
                    alert('<fmt:message key="input_formula"/>');
                    return;
                }
                
                datasettr.setProperty("sal_quotation_id",jQuery("#sal_quotation_id").val());
                datasettr.setProperty("sal_quotation_sc_id",jQuery("#sal_quotation_sc_id").val());
            }
            
        }
        if(datacell1.submit()){
            if(activeRow_sc != null){
                var datacell = $id("datacell_sc");
                var datasettr = datacell.getEntity(activeRow_sc);//得到当前操作的行dataset
                datasettr.setProperty("is_use","1");
            }
        
            alert("<fmt:message key="save_success"/>");
        }
    }
    // end 
    
    //参数
    
    function deleteMulti_onClick_para(){
        
        var datacell = $id("datacell_para");
        //var dataset1 = obj.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="yinyong_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="query_delete_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
              //datacell.dataset.removeEntity(datacell.dataset.getActiveEntity(),true);
              //dataset1.removeEntity(obj.getActiveEntity(),true);
           }
       }
    }
    
    
    function toAdd_onClick_para() {  //到增加记录页面
            
            var datacell = $id("datacell_para");
            datacell.addRow();
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            datasettr.setProperty("is_indie_bd",'0');
    }
    
    function toSave_onClick_para() { 
        var datacell1 = $id("datacell_para");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("name")==null || datasettr.getProperty("name")==''){
                    alert('<fmt:message key="input_name"/>');
                    return;
                }
                if(datasettr.getProperty("code")==null || datasettr.getProperty("code")==''){
                    alert('<fmt:message key="input_code"/>');
                    return;
                }
                if(datasettr.getProperty("data_type")==null || datasettr.getProperty("data_type")==''){
                    alert('<fmt:message key="input_data_type"/>');
                    return;
                }
                if(datasettr.getProperty("default_value")==null || datasettr.getProperty("default_value")==''){
                    alert('<fmt:message key="input_acquiescence"/>');
                    return;
                }
                
                
                datasettr.setProperty("sal_quotation_id",jQuery("#sal_quotation_id").val());
            }
            
        }
        if(datacell1.submit()){
            alert("<fmt:message key="save_success"/>");
        }
    }
    
    // end 
    
    
</script>




<div id="sc_list_div"  style="display: ;">

    
           
           
           
           
           
<table width="100%" border="0">


<tr>
    <td>
    <!--服务费大项-->
         <div style="padding: 8 10 8 8;float:left;" >
            <form action="/fjalsdfj" id="sc_form" method="post" >
            <input type="hidden" id="sal_quotation_id" name="sal_quotation_id" value="<%=id %>">
            <input type="hidden" id="tpl_id" name="tpl_id" value="<%=tpl_id %>">
            <input type="hidden" id="tpl_id" name="oldid" value="${parent_quotation_id }">
            </form>
            
            <div class="xz_title" style="padding-top: 10px"><fmt:message key="big_service"/></div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
                                <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                                <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                                
                                <li class="e">      <a onClick="javascript:moveUp_onClick_sc();"><fmt:message key="upper_move"/></a></li>
                                <li class="e">      <a onClick="javascript:moveDown_onClick_sc();"><fmt:message key="down_move"/></a></li>
                                
                                <li class="c">      <a onClick="javascript:toSave_onClick();"><fmt:message key="save"/></a></li>
                            </ul>
                            
                        </div>
            </div>
            
              <r:datacell id="datacell_sc" 
                queryAction="/FAERP/Sal_quotation_scAction.do?cmd=queryForDatacell" width="100%" height="138px"
                submitAction="/FAERP/Sal_quotation_scAction.do?cmd=saveList"
                xpath="Sal_quotation_scVo" paramFormId="sc_form"
                submitXpath="Sal_quotation_scVo"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" messagekey="operation" width="100px" onRefreshFunc="setCheckboxStatus_sc"  align="center" ></r:field>
              <r:field fieldName="name" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
              <r:field fieldName="code" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
              <r:field fieldName="formula" messagekey="formula" width="200px" ><h:text ondblclick="toSetFormual(this,true);" validateAttr="maxLength=500;message=输入有误;"/></r:field>
              
              <r:field fieldName="charge_start_date" messagekey="charge_start_date" width="100px" >
                <w:date format="yyyy-MM-dd" width="100px"/>
              </r:field>
              <r:field fieldName="charge_end_date" messagekey="charge_end_date" width="100px" >
                <w:date format="yyyy-MM-dd" width="100px"/>
              </r:field>
              <r:field fieldName="booked_start_date" messagekey="booked_start_date" width="100px" >
                <w:date format="yyyy-MM-dd" width="100px"/>
              </r:field>
              <r:field fieldName="booked_end_date" messagekey="booked_end_date" width="100px" >
                <w:date format="yyyy-MM-dd" width="100px"/>
              </r:field>
              
              <r:field fieldName="remark" messagekey="remark" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
              
              </r:datacell>
        </div>
        
           

<!---->
    
    
    </td>
    <td>

        <!--产品-->
<script type="text/javascript">
// 
//添加产品


function checkpageproduct(obj) {
    var addids = "";
    var deleteids = "";
    var productid = document.getElementsByName("product_id");
    var ids = obj;
    for (var i = 0; i < ids.length; i++) {
        var istrue = 'false';
        for (var j = 0; j < productid.length; j++) {
            var entity = $id("datacell_product").dataset.get(j);
            if (entity.getProperty("product_id") == (ids + ",").split(",")[i]) {
                istrue = "true";
                deleteids += entity.getProperty("product_name")
                        + "<fmt:message key="not_add_delete"/>\n";
                break;
            } else {
                istrue = "false";
            }
        }
        if (istrue == 'false') {
            addids += (ids + ",").split(",")[i] + ",";
        }
    }
    var returnAry = new Array();
    returnAry[0] = addids;
    returnAry[1] = deleteids;
    return returnAry;
}
function toaddProductlistrollback(obj) {
    var ids = checkpageproduct(obj);
    if (ids[1] != null && ids[1] != "") {
        alert(ids[1]);
    }
    if (ids[0] != null && ids[0] != "") {
        jQuery.getJSON(
                "<venus:base/>/QuotationitemAction.do?cmd=addProduct&date="
                        + new Date() + "", {
                    "ids" : ids[0]
                }, function(json) {
                    if (json.error != null && json.error != "") {
                        alert(json.error);
                    }
                    if (json.beans != null && json.beans != "") {

                        for (var i = 0; i < json.beans.length; i++) {
                        	if("Y"==json.beans[i].if_dept_bu){
                    			taxrate = <%=taxrateBu %>;
                    			add_taxrate = <%=add_taxrateBu %>;
                    		}else{
                    			taxrate = <%=taxrate %>;
                    			add_taxrate = <%=add_taxrate %>;
                    		} 
                            var newEntity = $id("datacell_product").styleEntity
                                    .clone(true);// 只克隆行样式，不带值
                            newEntity.setProperty("if_dept_bu",
                                    json.beans[i].if_dept_bu);
                            newEntity.setProperty("product_id",
                                    json.beans[i].id);
                            newEntity.setProperty("product_name",
                                    json.beans[i].product_name);
                            newEntity.setProperty("product_price",
                                    json.beans[i].product_price);
                            var returnValue = taxGenerate(parseFloat(json.beans[i].product_price),parseFloat(taxrate),add_taxrate);//获取增值税、附加税金额
                            newEntity.setProperty("vat_amount", returnValue[0]);
                            newEntity.setProperty("add_vat_amount", returnValue[1]);
                            newEntity.setProperty("add_vat_rate", add_taxrate);
                            newEntity.setProperty("vat_rate", taxrate);
                            newEntity.setProperty("product_desc",
                                    json.beans[i].product_desc);
                            newEntity.setProperty("count", "1");
                            $id("datacell_product").addRow(newEntity);
                            delProducts[json.beans[i].id] = false;
                        }
                    }
                });
    }
    //checkPrice('product_price','vat_amount','add_vat_amount','产品价格');
    checkSum();

}
function addProductList() {
    var url = "<%=request.getContextPath()%>/ProductAction.do?cmd=queryAllProduct&checkQuotation=true";
    showModalCenter(url, window, toaddProductlistrollback, 780, 447, "<fmt:message key="add_product"/>");
}

function setCheckboxStatus_product(value, entity, rowNo, cellNo) {
    return "<input type='checkbox'  name='product_id'  value ="
            + entity.getProperty("product_id") + " onClick=ClickRow(\""
            + entity.getProperty("product_id") + "\");>";
}

function ClickRow() {
}
var delProducts = {};
function removeProduct()
{
    var datacell = $id("datacell_product");
       var elementCheckbox = document.getElementsByName("product_id");
       for(var i=elementCheckbox.length-1;i>=0;i--){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
            	var row = datacell.getRow(i);
                var datasettr = datacell.getEntity(row);
                var id = datasettr.getProperty("product_id");
                delProducts[id] = true;
                datacell.deleteRow(i);
            }
        }
      // checkPrice('product_price','vat_amount','add_vat_amount','产品价格');
      checkSum();

} 


function toSave_onClick_product() {
    var datacell1 = $id("datacell_product");
    
    var dataset1 = datacell1.dataset;// 取得页面的datacell
    for (var i = 0; i < dataset1.getLength(); i++) {
        var datasettr = dataset1.get(i);
        datasettr.setProperty("quotation_id",jQuery("#sal_quotation_id").val());
        var id = datasettr.getProperty("product_id");
        if(delProducts[id] == true){
            datasettr.status = Entity.STATUS_DELT;
        }
        /*
        if (datasettr.status == Entity.STATUS_NEW
                || datasettr.status == Entity.STATUS_MODIFIED) {
            if (datasettr.getProperty("name") == null
                    || datasettr.getProperty("name") == '') {
                alert('请输入名称！');
                return;
            }
        }
        */
    }
    if (datacell1.submit()) {
        alert("<fmt:message key="save_success"/>");
    }
}

function checkSum(){
	   var datacell = $id("datacell_product");
    var dataset = datacell.dataset;//取得页面的datacell
	 //联动总额
	      var serviceSum=0;
	      var addedSum=0;
	      var surtaxSum=0;
	      var quotationSum=0;
	      for(var i=0; i<dataset.getLength(); i++){
	   	   var product_id = dataset.get(i).getProperty("product_id");
	   	   var product_price = dataset.get(i).getProperty("product_price");
	   	   var vat_amount = dataset.get(i).getProperty("vat_amount");
	   	   var add_vat_amount = dataset.get(i).getProperty("add_vat_amount");
	   	   if(delProducts[product_id] != true){
	   		   if(product_price!=null&&product_price!=''&&product_price!='0'){
	           	   serviceSum+=parseFloat(product_price);
	       	   }
	       	   if(vat_amount!=null&&vat_amount!=''){
	           	   addedSum+=parseFloat(vat_amount);
	       	   }
	       	   if(add_vat_amount!=null&&add_vat_amount!=''){
	       		   surtaxSum+=parseFloat(add_vat_amount);
	       	   }
	   	   }
	     }
	      
	      /* for(var i=0; i<dataset.getLength(); i++){
	   	   var product_id = dataset.get(i).getProperty("product_id");
	          if(delProducts[product_id] != true){
	       	   serviceSum+=parseFloat(dataset.get(i).getProperty("product_price"));
	       	   addedSum+=parseFloat(dataset.get(i).getProperty("vat_amount"));
	       	   surtaxSum+=parseFloat(dataset.get(i).getProperty("add_vat_amount"));
	          }
	     } */
	      $name("serviceSum").innerText = "服务费合计："+serviceSum.toFixed(2);
	      //$name("serviceSum").value="服务费合计："+serviceSum.toFixed(2);
	      $name("addedSum").innerText="  增值税合计："+addedSum.toFixed(2);
	      $name("surtaxSum").innerText="  附加税合计："+surtaxSum.toFixed(2);
	      $name("quotationSum").innerText="  报价单总额："+parseFloat(serviceSum+addedSum+surtaxSum).toFixed(2);
}

function formatNumber(srcStr, formatStr){
	  //var srcStr,
	  formatStr = ""+formatStr+"";
	  formatLen = formatStr.length;
	  formatPos = formatStr.indexOf(".",0);
	  nAfterDot = formatPos == -1 ? 0 : formatLen - formatPos - 1;
	  isFill = formatStr.substring(formatLen-1, formatLen)=="0";//是否补0

	  var resultStr, nTen;
	  srcStr = ""+srcStr+"";
	  strLen = srcStr.length;
	  dotPos = srcStr.indexOf(".",0);
	  if (dotPos == -1){
	    if(nAfterDot >0 && isFill){
	      resultStr = srcStr + ".";
	      for (i=0; i<nAfterDot; i++)
	        resultStr = resultStr+"0";
	    }
	    else
	      resultStr = srcStr;
	    return resultStr;
	  }
	  else
	  {
	    if ((strLen - dotPos - 1) >= nAfterDot){
	      nAfter = dotPos + nAfterDot + 1;
	      nTen =1;
	      for(j=0;j<nAfterDot;j++){
	        nTen = nTen*10;
	      }
	      resultStr = Math.round(parseFloat(srcStr)*nTen)/nTen;
	      //if(isFill)
	        //return formatNumber(resultStr, formatStr);
	      return resultStr;
	    }
	    else{
	      resultStr = srcStr;
	      for (i=0; isFill && i<(nAfterDot - strLen + dotPos + 1); i++){
	        resultStr = resultStr+"0";
	      }
	      return resultStr;
	    }
	  }
	}


function  checkPrice(fieldname,freshFiledname1,freshFiledname2,msgname){
    var datacell = $id("datacell_product");
    var dataset = datacell.dataset;//取得页面的datacell

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    if(dataset.getLength()>0){
    	var price = datasettr.getProperty(fieldname);
   	 var if_dept_bu = datasettr.getProperty("if_dept_bu");
	       if(!checkFloat(price)){
	           alert(msgname+"输入有误！");
	           datasettr.setProperty(fieldname,"0");
	           return;
	       } 
	       
	       //var taxrate = $name("taxrate").value;
	       if("Y"==if_dept_bu){
      			taxrate = <%=taxrateBu %>;
      			add_taxrate = <%=add_taxrateBu %>;
      		}else{
      			taxrate = <%=taxrate %>;
      			add_taxrate = <%=add_taxrate %>;
      		}
	       //计算附加税和增值税
	       var returnValue = taxGenerate(price,parseFloat(taxrate),add_taxrate);//获取增值税、附加税金额
	       datasettr.setProperty(freshFiledname1,returnValue[0]);
	       datasettr.setProperty(freshFiledname2,returnValue[1]);
    }
	checkSum();

}

//检查输入参数是否为浮点数
function checkFloat(str){
    var rc=true;
    oneDecimal=false;
    if (str+"" == "undefined" || str == null || str==''){
        rc=false;
    } else{
        for(i=0;i<str.length;i++){
            ch=str.charAt(i);
            if(i==0 && ch=='-'){
                continue;
            }
            if(ch=="." && !oneDecimal){
            oneDecimal=true;
                continue;
            }
            if ((ch< "0") || (ch >'9')){
                rc=false;
                break;
            }
        }
    }
    return rc;
}
</script>
        <div style="padding: 8 10 8 8;">
        
            <form action="/fjalsdfj" id="sc_form" method="post">
            <input type="hidden" id="sal_quotation_id" name="sal_quotation_id" value="<%=id %>">
            <input type="hidden" id="tpl_id" name="tpl_id" value="<%=tpl_id %>">
            
            </form>
            
            <div class="xz_title" style="padding-top: 10px"><fmt:message key="product"/></div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
                                <li class="c_1"  id="add" style="display:block"><a onClick="javascript:addProductList();"><fmt:message key="add_product"/></a></li>
                                <li class="d"  id="del" style="display:block"><a onClick="javascript:removeProduct();"><fmt:message key="delete"/></a></li>
                                <li   class="approdetial" ><a onClick="javascript:toSave_onClick_product();"><fmt:message key="save"/></a></li>
                            </ul>
                            
                        </div>
            </div>
            <div class="clear" ></div> 
     <div>
     <label name="serviceSum" id="serviceSum" color="blue"></label>
     		     		<label name="addedSum" id="addedSum" color="blue"></label>
     		
     		     		<label name="surtaxSum" id="surtaxSum" color="blue"></label>
     		
     		     		<label name="quotationSum" id="quotationSum" color="blue"></label>
           <!--  <input name="serviceSum" type="text"  id="serviceSum" onchange="" style="width:150px;"/>
            <input name="addedSum" type="text"  id="addedSum" onchange="" style="width:150px;"/>
            <input name="surtaxSum" type="text"  id="surtaxSum" onchange="" style="width:150px;"/>
            <input name="quotationSum" type="text" id="quotationSum" onchange="" style="width:150px;"/> -->
     </div>
            
              <r:datacell 
                    id="datacell_product"
                   queryAction="/FAERP/QuotationAction.do?cmd=getProduct&quotationid='${bean.id}${parent_quotation_id }'"
                   submitAction="/FAERP/QuotationAction.do?cmd=saveQuotationitemList"
                    width="98%" height="138px"
                    xpath="QuotationitemVo"
                    submitXpath="QuotationitemVo"
                    paramFormId="datacell_formid"
                    pageSize="-1"
                    
                    >
                   <%-- <r:field fieldName="id"  messagekey="operation" width="100px" onRefreshFunc="setCheckboxStatus_product" align="center">
                         
                   </r:field>   --%> 
                   <r:field fieldName="product_name" width="100px" messagekey="product_name">
                   </r:field>   
            
                   <r:field fieldName="standard_price" width="100px" messagekey="biaozhun_price">
			        </r:field>
			        <%if(resultVo!=null && resultVo.getIs_renewal_sign().equals("1")) {%>
			        <r:field fieldName="old_price" width="100px" messagekey="oid_price">
			        </r:field>
			        <%} %>
			        <r:field fieldName="product_price" width="100px" messagekey="one_price" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
			            <h:text validateAttr="allowNull=false;type=float;message=不是数字或精度有误！;" onchange="javascript:checkPrice('product_price','vat_amount','add_vat_amount','产品价格');"/>
			        </r:field>
			        
			         <r:field fieldName="vat_amount" width="100px" label="增值税" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
       </r:field> 
       <r:field fieldName="vat_rate" width="100px" label="增值税税率">
       </r:field>
       <r:field fieldName="add_vat_amount" width="100px" label="附加税" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
       </r:field>
       <r:field fieldName="add_vat_rate" width="100px" label="附加税税率">
       </r:field> 
                  
                   <r:field fieldName="product_desc" width="100px" messagekey="product_desc">
                   </r:field> 
                      
                </r:datacell>
        </div>
        
<!--           end-->
    
    
    </td>
  </tr>


  <tr>
    <td>
    
        <!--    服务费小项-->
     <div style="padding: 8 10 8 8;float:left;" >
        <form action="/fjalsdfj" id="sc_item_form" method="post">
        <input type="hidden" id="sal_quotation_sc_id" name="sal_quotation_sc_id" value="">
        </form>
        <div class="xz_title" style="padding-top: 10px"><fmt:message key="service_price_small"/></div> 
        <div id="ccParent1" class="button"> 
         <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick_sc_item();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick_sc_item();"><fmt:message key="delete"/> </a> </li>
                            
                            
                            <li class="e">      <a onClick="javascript:moveUp_onClick_sc_item();"><fmt:message key="upper_move"/></a></li>
                            <li class="e">      <a onClick="javascript:moveDown_onClick_sc_item();"><fmt:message key="down_move"/></a></li>
                            
                            <li class="c">      <a onClick="javascript:toSave_onClick_sc_item();"><fmt:message key="down_move"/>save</a></li>
                        </ul>
                        
                 </div>
        </div>
        
          <r:datacell id="datacell_sc_item" 
            queryAction="/FAERP/Sal_quotation_sc_itemAction.do?cmd=queryForDatacell" width="100%" height="198px"
            submitAction="/FAERP/Sal_quotation_sc_itemAction.do?cmd=saveList"
            xpath="Sal_quotation_sc_itemVo" paramFormId="sc_item_form"
            submitXpath="Sal_quotation_sc_itemVo"
                >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="name" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="code" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
          <r:field fieldName="formula" messagekey="formula" width="300px" ><h:text ondblclick="toSetFormual(this);" validateAttr="maxLength=500;message=输入有误;"/></r:field>    
          <r:field fieldName="remark" messagekey="remark" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          
          </r:datacell>
        </div>
           

<!---->
    
    
    </td>
    <td>
    
     <!-- 服务费参数  -->
    <div style="padding: 8 10 8 8;" >
        <div class="xz_title" style="padding-top: 10px"> </div> 
        <div id="ccParent1" class="button"> 
         <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick_para();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick_para();"><fmt:message key="delete"/> </a> </li>
                            <li class="c">      <a onClick="javascript:toSave_onClick_para();"><fmt:message key="save"/></a></li>
                        </ul>
                        
                 </div>
        </div>
        
          <r:datacell id="datacell_para" 
            queryAction="/FAERP/Sal_quotation_sc_paraAction.do?cmd=queryForDatacell" width="98%" height="198px"
            submitAction="/FAERP/Sal_quotation_sc_paraAction.do?cmd=saveList"
            xpath="Sal_quotation_sc_paraVo" paramFormId="sc_form"
            submitXpath="Sal_quotation_sc_paraVo"
            >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="name" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="code" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
          <r:field fieldName="data_type" messagekey="data_type" width="100px" >
            <d:select dictTypeId="DATA_TYPE_DB" extAttr="validateAttr='allowNull=false'"/>
          </r:field>
          <r:field fieldName="default_value" messagekey="acquiescence" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="remark" messagekey="remark" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          
          </r:datacell>
     </div>
<!--           end-->
    
    
    </td>
  </tr>
</table>



    



   
           
    
    
    
    
    


      </div>
        
        
        
   </div>
</div>
    








</fmt:bundle>
</body>
</html>

<script language="javascript">



</script>
