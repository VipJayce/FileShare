<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.sal_quotation_tpl.vo.Sal_quotation_tplVo" %>
<%@ page import="rayoo.sales.sal_quotation_tpl.util.ISal_quotation_tplConstants" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
    Sal_quotation_tplVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (Sal_quotation_tplVo)request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    boolean isView = request.getAttribute("isView") == null ? false : true;
    
    String id = "";
    if(resultVo != null) {
        id = resultVo.getId();
    }
%>
<html>
<fmt:bundle basename="rayoo.salse.sal_quotation_tpl.sal_quotation_tpl_resource" prefix="rayoo.salse.sal_quotation_tpl.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
var isView = "${isView}";
jQuery(function(){
    if(isView=="true"){//查看页面
        jQuery(".button_right ul li").hide();
        jQuery("#update_button").hide();
        jQuery("#checkButton").hide();
    }else{
        
    }
    jQuery("#button_content").show();

    $id("datacell_sc").isQueryFirst = false;// 
    $id("datacell_tpl_para").isQueryFirst = false;// 
    $id("datacell_sc_item").isQueryFirst = false;// 
    var id= jQuery("#tpl_id").val();
    if(id){
        simpleQuery_onClick();
        var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
        tpl_sc_list_div.show();
    }
});
function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell_sc").loadData();
    $id("datacell_sc").refresh();
    
    $id("datacell_tpl_para").loadData();
    $id("datacell_tpl_para").refresh();
}
function checkAllForms(){
    var form = jQuery("#insert_sal_tpl_form");
    var name = form.find("input[name=name]").val();
    var code = form.find("input[name=code]").val();
    if(!name){
        alert("<fmt:message key="template_name_not_null"/>");
        return false;
    } 
    if(!code){
        alert("<fmt:message key="code_not_null"/>");
        return false;
    }else {
        if(containCH(code)){
            alert("<fmt:message key="code_not_china"/>");
            return false;
        }
    }
    return true;

}
    function insert_onClick(){  //插入单条数据
        if(checkAllForms()){
        
        
            var form = jQuery("#insert_sal_tpl_form");
            var update_button = jQuery("#update_button");
            update_button.attr({"disabled":"disabled"});
            form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?cmd=insert";
            
            
            ajaxRequest(form,
                function(data){
                    if(true != data.error){
	                    jQuery("#sal_quotation_tpl_id").val(data.id);
	                    jQuery("#tpl_id").val(data.id);
	                    //simpleQuery_onClick();
	                    var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
	                    tpl_sc_list_div.show();
                    }else {
                        alert(data.message);
                        update_button.removeAttr("disabled");
                    }
                  
                } , 
                function(){
                    alert("error.");
                }
            )
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
           if(checkAllForms()){
            var form = jQuery("#insert_sal_tpl_form");
	        form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?cmd=update";
	        
	        ajaxRequest(form,
                function(data){
                    if(true != data.error){
                        alert("<fmt:message key="modify_success"/>");
		                var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
		                tpl_sc_list_div.show();
                    }else {
                        alert(data.message);
                    }
                  
                  
                } , 
                function(){
                    alert("error.");
                }
            )
        
        }
    }

    function checkTpl_onClick(){  //检查 相关 公式是否合法
        var id = jq("#tpl_id").val();
        if(id){
	        var form = jQuery("#insert_sal_tpl_form");
            form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?cmd=checkFormula&date="+new Date().getTime()+"&id=" + id ;
            
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
            alert("<fmt:message key="save_template"/>");
        }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    

    
</script>
</head>
<body>
<!--<textarea rows="2" cols="80" name="test" id="console" style="display: "><%=id %></textarea>-->
<input type="hidden" id="tpl_id" value="<%=id %>">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>



 
<div class="ringht">
<div id="ccChild1"     class="box_xinzeng" style="height: 130px">
<div class="xz_title" style="padding-top: 10px"><fmt:message key="basic_info"/></div>
<form name="form" method="post" id="insert_sal_tpl_form">
    <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1" >*<fmt:message key="template_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="name" inputName="name" value="${bean.name }" maxLength="100" />
                <input type="hidden" name="id" value="${bean.id }" />
            </td>
            
            <td class="td_1" rowspan="3" style="" align="right">
               <fmt:message key="remark"/>
            </td>  
             <td rowspan="3" style="" align="left">
             <div  id="button_content" style="display: none;">
                <textarea rows="3" cols="80" name="remark" >${bean.remark }</textarea>
             
                <input id="update_button" type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
                <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
                
                <input type="button" id="checkButton" class="icon_2" value='<fmt:message key="check_template"/>'  onClick="javascript:checkTpl_onClick()"/>
            </td>
            </div>
        </tr>
        <tr>
            <td class="td_1" >*<fmt:message key="code"/></td>
            <td class="td_2" ><input type="text" class="text_field" name="code" inputName="code" value="${bean.code }" maxLength="100" /></td>
        </tr>
        <tr>
            <td class="td_1" >定价方式</td>
            <td class="td_2" >
                <%
                rayoo.sales.sal_quotation_tpl.vo.Sal_quotation_tplVo beanVo = (rayoo.sales.sal_quotation_tpl.vo.Sal_quotation_tplVo)request.getAttribute("bean");
	            String price_type_bd = "";
	            if (beanVo != null){
	                price_type_bd = String.valueOf(beanVo.getPrice_type_bd());
	            }
                %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("price_type_bd", -1, "PRICE_TYPE_BD", price_type_bd, "", false) %>
            </td>
        </tr>
    </table>
</form>
</div>
   

<!-- 模板大项的列表 -->

<script language="javascript"><!--
    
    function deleteMulti_onClick(){
        
        var datacell = $id("datacell_sc");
        
        
        
        //var dataset1 = obj.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        
       
        
        activeRow_sc = activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="cite_not_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="sure_delete_row_data"/>')) {  //如果用户在确认对话框按"确定"
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
            alert("<fmt:message key="downing"/>");
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
            alert("<fmt:message key="uppering"/>");
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
	            datasettr.setProperty("sal_quotation_tpl_id",jQuery("#sal_quotation_tpl_id").val());
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
	        jQuery("#sal_quotation_tpl_sc_id").val(id);
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
            alert("<fmt:message key="uppering"/>");
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
            alert("<fmt:message key="downing"/>");
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
            alert('<fmt:message key="cite_not_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="sure_delete_row_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
              //datacell.dataset.removeEntity(datacell.dataset.getActiveEntity(),true);
              //dataset1.removeEntity(obj.getActiveEntity(),true);
           }
       }
    }
    
    
    function toAdd_onClick_sc_item() {  //到增加记录页面
    
            var val=jQuery('input:radio[name="radio_sc"]:checked').val();
            if(val==null){
                alert("<fmt:message key="choose_big_service"/>");
                return false;
            }
            else{
                //var selected_sal_quotation_tpl_id = jQuery("#sal_quotation_tpl_id").val();
                if(val==""){
                    alert("<fmt:message key="save_big_service"/>");
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
	            
	            datasettr.setProperty("sal_quotation_tpl_id",jQuery("#sal_quotation_tpl_id").val());
	            datasettr.setProperty("sal_quotation_tpl_sc_id",jQuery("#sal_quotation_tpl_sc_id").val());
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
        
        var datacell = $id("datacell_tpl_para");
        //var dataset1 = obj.dataset;//取得页面的datacell
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="cite_not_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="sure_delete_row_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
              //datacell.dataset.removeEntity(datacell.dataset.getActiveEntity(),true);
              //dataset1.removeEntity(obj.getActiveEntity(),true);
           }
       }
    }
    
    
    function toAdd_onClick_para() {  //到增加记录页面
            
            var datacell = $id("datacell_tpl_para");
            datacell.addRow();
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            datasettr.setProperty("is_indie_bd",'0');
    }
    
    function toSave_onClick_para() { 
        var datacell1 = $id("datacell_tpl_para");
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
	                alert('<fmt:message key="input_default_value"/>');
	                return;
	            }
	            
	            
	            datasettr.setProperty("quotation_tpl_id",jQuery("#sal_quotation_tpl_id").val());
            }
            
        }
        if(datacell1.submit()){
            alert("<fmt:message key="save_success"/>");
        }
    }
    
    // end 
    
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
    
        url +=  "?isRich=true&fromTpl=true&tpl_id="+jQuery("#sal_quotation_tpl_id").val()+
                "&sc_id="+sc_id;
    }
        
    window.open(url, 'newwindow', s);

}
--></script>




<div id="tpl_sc_list_div"  style="display:none ;">

    <!--服务费大项-->
        <div style="padding: 8 10 8 8;">
        
            <form action="" id="tpl_sc_form" method="post">
            <input type="hidden" id="sal_quotation_tpl_id" name="sal_quotation_tpl_id" value="<%=id %>">
            </form>
            
            <div class="xz_title" style="padding-top: 10px"><fmt:message key="big_service"/></div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
                                <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                                <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                                
                                <li class="e">      <a onClick="javascript:moveUp_onClick_sc();"><fmt:message key="upper"/></a></li>
                                <li class="e">      <a onClick="javascript:moveDown_onClick_sc();"><fmt:message key="down"/></a></li>
                                
                                <li class="c">      <a onClick="javascript:toSave_onClick();"><fmt:message key="save"/></a></li>
                            </ul>
                            
                        </div>
            </div>
            
              <r:datacell id="datacell_sc" 
                queryAction="/FAERP/Sal_quotation_tpl_scAction.do?cmd=queryForDatacell" width="80%" height="138px"
                submitAction="/FAERP/Sal_quotation_tpl_scAction.do?cmd=saveList"
                xpath="Sal_quotation_tpl_scVo" paramFormId="tpl_sc_form"
                submitXpath="Sal_quotation_tpl_scVo"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" messagekey="operation" width="100px" onRefreshFunc="setCheckboxStatus_sc"  align="center" ></r:field>
              <r:field fieldName="name" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
              <r:field fieldName="code" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
              <r:field fieldName="formula" messagekey="formula" width="300px" ><h:text ondblclick="toSetFormual(this,true);"  validateAttr="maxLength=500;message=输入有误;"/></r:field>
              
              <r:field fieldName="remark" messagekey="remark" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
              
              </r:datacell>
        </div>
           
           
           
           
           
<table width="100%" border="0">
  <tr>
    <td>
    
        <!--    服务费小项-->
     <div style="padding: 8 10 8 8;float:left;" >
        <form action="" id="tpl_sc_item_form" method="post">
        <input type="hidden" id="sal_quotation_tpl_sc_id" name="sal_quotation_tpl_sc_id" value="">
        </form>
        <div class="xz_title" style="padding-top: 10px"><fmt:message key="small_service"/></div> 
        <div id="ccParent1" class="button"> 
         <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick_sc_item();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick_sc_item();"><fmt:message key="delete"/> </a> </li>
                            
                            
                            <li class="e">      <a onClick="javascript:moveUp_onClick_sc_item();"><fmt:message key="upper"/></a></li>
                            <li class="e">      <a onClick="javascript:moveDown_onClick_sc_item();"><fmt:message key="down"/></a></li>
                            
                            <li class="c">      <a onClick="javascript:toSave_onClick_sc_item();"><fmt:message key="save"/></a></li>
                        </ul>
                        
                 </div>
        </div>
        
          <r:datacell id="datacell_sc_item" 
            queryAction="/FAERP/Sal_quotation_tpl_sc_itemAction.do?cmd=queryForDatacell" width="100%" height="198px"
            submitAction="/FAERP/Sal_quotation_tpl_sc_itemAction.do?cmd=saveList"
            xpath="Sal_quotation_tpl_sc_itemVo" paramFormId="tpl_sc_item_form"
            submitXpath="Sal_quotation_tpl_sc_itemVo"
                >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="name" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="code" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
          <r:field fieldName="formula" messagekey="formula" width="300px" ><h:text ondblclick="toSetFormual(this);" validateAttr="maxLength=500;message=输入有误;" /></r:field>
          <r:field fieldName="remark" messagekey="remark" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          
          </r:datacell>
        </div>
           

<!---->
    
    
    </td>
    <td>
    
     <!-- 服务费参数  -->
    <div style="padding: 8 10 8 8;" >
        <div class="xz_title" style="padding-top: 10px"><fmt:message key="service_data"/></div> 
        <div id="ccParent1" class="button"> 
         <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick_para();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick_para();"><fmt:message key="delete"/> </a> </li>
                            <li class="c">      <a onClick="javascript:toSave_onClick_para();"><fmt:message key="save"/></a></li>
                        </ul>
                        
                 </div>
        </div>
        
          <r:datacell id="datacell_tpl_para" 
            queryAction="/FAERP/Sal_quotation_tpl_paraAction.do?cmd=queryForDatacell" width="90%" height="198px"
            submitAction="/FAERP/Sal_quotation_tpl_paraAction.do?cmd=saveList"
            xpath="Sal_quotation_tpl_paraVo" paramFormId="tpl_sc_form"
            submitXpath="Sal_quotation_tpl_paraVo"
            >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="name" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="code" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
          <r:field fieldName="data_type" messagekey="data_type" width="100px" >
            <d:select dictTypeId="DATA_TYPE_DB" extAttr="validateAttr='allowNull=false'"/>
          </r:field>
          <r:field fieldName="default_value" messagekey="default_value" width="100px" ><h:text validateAttr="type=tpl_para;maxLength=100;"/></r:field>    
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

function f_check_tpl_para(obj) {
    var str = obj.value;
    var datacell = $id("datacell_tpl_para");
    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);// 得到当前操作的行dataset
    
    if (datasettr.getProperty("data_type") == '0') {
        if (isNaN(str)) {
            f_alert(obj, "<fmt:message key="data_type_count"/>");
            return false;
        }
    }
    return true;
}

</script>
