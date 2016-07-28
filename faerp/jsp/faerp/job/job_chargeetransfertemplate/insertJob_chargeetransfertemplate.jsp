<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.vo.Job_chargeetransfertemplateVo" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.util.IJob_chargeetransfertemplateConstants" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
Job_chargeetransfertemplateVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (Job_chargeetransfertemplateVo)request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
    //$id("datacell_sc").refresh();
    
    $id("datacell_tpl_para").loadData();
    //$id("datacell_tpl_para").refresh();
}
function checkAllForms(){
    var form = jQuery("#insert_job_tpl_form");
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
            var form = jQuery("#insert_job_tpl_form");
            var update_button = jQuery("#update_button");
            update_button.attr({"disabled":"disabled"});
            form.action="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=insert";
            ajaxRequest(form,
                function(data){
                    if(true != data.error){
	                    jQuery("#chargetransfertemplate_id").val(data.id);
	                    jQuery("#tpl_id").val(data.id);
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
            var form = jQuery("#insert_job_tpl_form");
	        form.action="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=update";
	        ajaxRequest(form,
                function(data){
                    if(true != data.error){
                        alert("<fmt:message key="modify_success"/>");
		                var tpl_sc_list_div = jQuery("#tpl_sc_list_div");
		                $id("datacell_sc").loadData();
	                    $id("datacell_sc").refresh();
	                    $id("datacell_sc_item").loadData();
	                    $id("datacell_sc_item").refresh();
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
	        var form = jQuery("#insert_job_tpl_form");
            form.action="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=checkFormula&date="+new Date().getTime()+"&id=" + id ;
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
            alert("请先保存模板主表!");
        }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Job_chargeetransfertemplateAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    

    
</script>
</head>
<body>
<input type="hidden" id="tpl_id" value="<%=id %>">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>



 
<div class="ringht">
<div id="ccChild1"     class="box_xinzeng" style="height: 180px">
<div class="xz_title" style="padding-top: 10px"><fmt:message key="basic_info"/></div>
<form name="form" method="post" id="insert_job_tpl_form">
    <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1" width="23%">模板编号</td>
            <td class="td_2">
                <input type="text" class="text_field" name="code" inputName="code" value="${bean.code }" maxLength="100" />
                <input type="hidden" name="id" value="${bean.id }" />
            </td>
            <td class="td_1" >模板名称</td>
            <td class="td_2" >
            	<input type="text" class="text_field" name="name" inputName="name" value="${bean.name }" maxLength="100" />
            </td>
        </tr>
        <tr>
          <td class="td_1" >生效日期</td>
          <td class="td_2" >
          	<w:date id="effectivedate" style="width=200px" name="effectivedate" format="YYYY-MM-DD"  property="bean/effectivedate"/>
          </td>
          <td class="td_1" >失效日期</td>
          <td class="td_2" >
          	<w:date id="expirydate" style="width=200px" name="expirydate" format="YYYY-MM-DD" property="bean/expirydate" />
          </td>
        </tr>
        <tr>
          <td class="td_1" >费用划出部门</td>
          <td class="td_2" >
          	<!-- <input type="hide"  name="outdept_id"  value="${bean.outdept_id }" />  -->
          	<r:comboSelect id="outdept_id" name="outdept_id"
		            queryAction="/FAERP/Job_chargeetransfertemplateAction.do?cmd=getAllDept"
		            textField="dept_name" valueField="id" xpath="DepartmentVo" value="${bean.outdept_id}"  width="180" nullText="请选择部门" />                
          </td>
          <td class="td_1" >模板状态</td>
          <td class="td_2" >
           	<d:select id="status" name="status" dictTypeId="JOB_TRANS_TBL_STATUS" value="${bean.status}" ></d:select>
           </td>
        </tr>
        <tr>
          <td class="td_1" >备注</td>  
          <td class="td_2">
            <textarea rows="2" cols="40" name="description" >${bean.description }</textarea>
          </td>
	      <td align="left" colspan="2">   
			<div  id="button_content" style="display: none;">
        	 	<input id="update_button" type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
                <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
                <input type="button" id="checkButton" class="icon_2" value='<fmt:message key="check_template"/>'  onClick="javascript:checkTpl_onClick()"/>
        	</div>
        	</td>
        </tr>
        
    </table>
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
	<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
	<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
	<input type="hidden" name="create_user_name" id="create_user_name" value="${bean.create_user_name}">
	<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
</form>
</div>
   

<!-- 模板大项的列表 -->

<script language="javascript">
    
    function deleteMulti_onClick(){
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        activeRow_sc = activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="cite_not_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="sure_delete_row_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
           }
       }
    }
    
    var activeRow_sc = null;
    function moveDown_onClick_sc() {  //到增加记录页面
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var itemnumber = datasettr.getProperty("itemnumber");
        var next = activeRow.nextSibling;
        if(next == null){
            alert("<fmt:message key="downing"/>");
            return;
        }else {
            datacell.isModefied = true;
            var datasettr_next = datacell.getEntity(next);
            var itemnumber2 = datasettr_next.getProperty("itemnumber");
            datasettr.setProperty("itemnumber", itemnumber2);
            datasettr_next.setProperty("itemnumber", itemnumber);
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            datacell.rowMoveDown(activeRow);
        }
        
        
     }

    function moveUp_onClick_sc() { 
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var itemnumber = datasettr.getProperty("itemnumber")
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("<fmt:message key="uppering"/>");
            return;
        }else {
            datacell.isModefied = true;
            var datasettr_pre = datacell.getEntity(pre);
            var itemnumber2 = datasettr_pre.getProperty("itemnumber");
            datasettr.setProperty("itemnumber", itemnumber2);
            datasettr_pre.setProperty("itemnumber", itemnumber);
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            datacell.rowMoveUp(activeRow);
        }
    }
    
    function toAdd_onClick() {  //到增加记录页面
            var datacell = $id("datacell_sc");
            datacell.addRow();
            var outdept_id = document.getElementById("outdept_id").value;
            var activeRow = datacell.activeRow;
            var itemnumber = 1;
            var pre = activeRow.previousSibling;
            if(pre != null){
            	var datasettrpre = datacell.getEntity(pre);
            	itemnumber = parseInt(datasettrpre.getProperty("itemnumber"))+1;
        	}
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            datasettr.setProperty("outdept_id",outdept_id);  
            datasettr.setProperty("indept_id",null);  
            datasettr.setProperty("itemnumber",itemnumber);  
    }
    
    function toSave_onClick() { 
        var datacell1 = $id("datacell_sc");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("itemname")==null || datasettr.getProperty("name")==''){
	                alert('项目名称不能为空!');
	                return;
	            }
	            if(datasettr.getProperty("itemcode")==null || datasettr.getProperty("code")==''){
	                alert('项目代码不能为空!');
	                return;
	            }
	            if(datasettr.getProperty("formula")==null || datasettr.getProperty("formula")==''){
	                alert('公式不能为空!');
	                return;
	            }
	            datasettr.setProperty("chargetransfertemplate_id",jQuery("#chargetransfertemplate_id").val());
            }
            
        }
        var result = datacell1.submit();
        if(result == true){
            alert("<fmt:message key="save_success"/>");
        }
    }
    
    
    function setCheckboxStatus_sc(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='radio_sc' value='"  + entity.getProperty("id") + "'  onClick=clickRow_sc(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";//
    }

    function clickRow_sc(id,value){
        if(id){
	        jQuery("#chargebigitem_id").val(id);
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
        var itemnumber = datasettr.getProperty("itemnumber")
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("<fmt:message key="uppering"/>");
            return;
        }else {
            datacell.isModefied = true;
            var datasettr_pre = datacell.getEntity(pre);
            var itemnumber2 = datasettr_pre.getProperty("itemnumber");
            datasettr.setProperty("itemnumber", itemnumber2);
            datasettr_pre.setProperty("itemnumber", itemnumber);
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            datacell.rowMoveUp(activeRow);
        }
    }
    
    function moveDown_onClick_sc_item() {  //到增加记录页面
        var datacell = $id("datacell_sc_item");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var itemnumber = datasettr.getProperty("itemnumber")
        var next = activeRow.nextSibling;
        if(next == null){
            alert("<fmt:message key="downing"/>");
            return;
        }else {
            datacell.isModefied = true;
            var datasettr_next = datacell.getEntity(next);
            var itemnumber2 = datasettr_next.getProperty("itemnumber");
            datasettr.setProperty("itemnumber", itemnumber2);
            datasettr_next.setProperty("itemnumber", itemnumber);
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            datacell.rowMoveDown(activeRow);
        }
     }
     
    function deleteMulti_onClick_sc_item(){
        var datacell = $id("datacell_sc_item");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="cite_not_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="sure_delete_row_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
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
                if(val==""){
                    alert("<fmt:message key="save_big_service"/>");
                }else {
                    var datacell = $id("datacell_sc_item");
	                datacell.addRow();
	                var activeRow = datacell.activeRow;
	                var itemnumber = 1;
            		var pre = activeRow.previousSibling;
            		if(pre != null){
            			var datasettrpre = datacell.getEntity(pre);
            			itemnumber = parseInt(datasettrpre.getProperty("itemnumber"))+1;
        			}
	                var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            		datasettr.setProperty("itemnumber",itemnumber);
                }
            }
    }
    
    function toSave_onClick_sc_item() { 
        var datacell1 = $id("datacell_sc_item");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
            
                if(datasettr.getProperty("itemname")==null || datasettr.getProperty("itemname")==''){
	                alert('<fmt:message key="input_name"/>');
	                return;
	            }
	            if(datasettr.getProperty("itemcode")==null || datasettr.getProperty("itemcode")==''){
	                alert('<fmt:message key="input_code"/>');
	                return;
	            }
	            if(datasettr.getProperty("formula")==null || datasettr.getProperty("formula")==''){
	                alert('<fmt:message key="input_formula"/>');
	                return;
	            }
	            datasettr.setProperty("chargetransfertemplate_id",jQuery("#chargetransfertemplate_id").val());
	            datasettr.setProperty("chargebigitem_id",jQuery("#chargebigitem_id").val());
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
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        if(datasettr.getProperty("is_use")=='1'){
            alert('<fmt:message key="cite_not_delete"/>');
            return;
        }else{
           if(confirm('<fmt:message key="sure_delete_row_data"/>')) {  //如果用户在确认对话框按"确定"
              datacell.deleteRow();
           }
       }
    }
    
    
    function toAdd_onClick_para() {  //到增加记录页面
            var datacell = $id("datacell_tpl_para");
            datacell.addRow();
            var activeRow = datacell.activeRow;
            var itemnumber = 1;
            var pre = activeRow.previousSibling;
            if(pre != null){
            	var datasettrpre = datacell.getEntity(pre);
            	itemnumber = parseInt(datasettrpre.getProperty("itemnumber"))+1;
        	}
	        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            datasettr.setProperty("itemnumber",itemnumber);
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    }
    
    function toSave_onClick_para() { 
        var datacell1 = $id("datacell_tpl_para");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var datasettr = dataset1.get(i);
            if(datasettr.status == Entity.STATUS_NEW || datasettr.status == Entity.STATUS_MODIFIED){
                if(datasettr.getProperty("paramname")==null || datasettr.getProperty("paramname")==''){
	                alert('<fmt:message key="input_name"/>');
	                return;
	            }
	            if(datasettr.getProperty("paramcode")==null || datasettr.getProperty("paramcode")==''){
	                alert('<fmt:message key="input_code"/>');
	                return;
	            }
	            if(datasettr.getProperty("datatype")==null || datasettr.getProperty("datatype")==''){
	                alert('<fmt:message key="input_data_type"/>');
	                return;
	            }
	            if(datasettr.getProperty("defaultvalue")==null || datasettr.getProperty("defaultvalue")==''){
	                alert('<fmt:message key="input_default_value"/>');
	                return;
	            }
	            datasettr.setProperty("chargetransfertemplate_id",jQuery("#chargetransfertemplate_id").val());
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
    var url = "<%=request.getContextPath()%>/jsp/faerp/job/job_chargeetransfertemplate/tosetformual4quotation.jsp";
    if(isBig){
    
        var datacell = $id("datacell_sc");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var sc_id = datasettr.getProperty("id");
    
        url +=  "?isRich=true&fromTpl=true&tpl_id="+jQuery("#chargetransfertemplate_id").val()+
                "&sc_id="+sc_id;
    }else{
    	url +=  "?tpl_id="+jQuery("#chargetransfertemplate_id").val()+
                "&sc_id="+sc_id;
    }
        
    window.open(url, 'newwindow', s);

}
</script>




<div id="tpl_sc_list_div"  style="display:none ;">

    <!--费用大项-->
        <div style="padding: 8 10 8 8;">
        
            <form action="" id="tpl_sc_form" method="post">
            <input type="hidden" id="chargetransfertemplate_id" name="chargetransfertemplate_id" value="<%=id %>">
            </form>
            
            <div class="xz_title" style="padding-top: 10px">费用大项</div> 
            <div id="ccParent1" class="button">
                        <div class="button_right">
                            <ul>
                                <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                                <li class="d">      <a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                                <li class="e">      <a onClick="javascript:moveUp_onClick_sc();"><fmt:message key="upper"/></a></li>
                                <li class="e">      <a onClick="javascript:moveDown_onClick_sc();"><fmt:message key="down"/></a></li>
                                <li class="c">      <a onClick="javascript:toSave_onClick();"><fmt:message key="save"/></a></li>
                            </ul>
                            
                        </div>
            </div>
            
              <r:datacell id="datacell_sc" 
                queryAction="/FAERP/Job_chargebigitemAction.do?cmd=queryForDatacell" width="80%" height="138px"
                submitAction="/FAERP/Job_chargebigitemAction.do?cmd=saveList"
                xpath="Job_chargebigitemVo" paramFormId="tpl_sc_form"
                submitXpath="Job_chargebigitemVo"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" messagekey="operation" width="100px" onRefreshFunc="setCheckboxStatus_sc"  align="center" ></r:field>
              <r:field fieldName="itemname" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
              <r:field fieldName="itemcode" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
              <r:field fieldName="outdept_id" label="划出部门" width="100px" allowModify="false" >
              	 <r:comboSelect id="outdept_ids" name="outdept_ids"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="true"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
              </r:field>  
              <r:field fieldName="indept_id" label="划入部门" width="100px" >
              	   <r:comboSelect id="indept_ids" name="indept_ids"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
              </r:field>  
              <r:field fieldName="formula" messagekey="formula" width="300px" ><h:text ondblclick="toSetFormual(this,true);"  validateAttr="maxLength=500;message=输入有误;"/></r:field>
              <r:field fieldName="description" label="备注" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
              </r:datacell>
        </div>
           
           
           
           
           
<table width="100%" border="0">
  <tr>
    <td>
    
        <!--    费用小项-->
     <div style="padding: 8 10 8 8;float:left;" >
        <form action="" id="tpl_sc_item_form" method="post">
        <input type="hidden" id="chargebigitem_id" name="chargebigitem_id" value="">
        </form>
        <div class="xz_title" style="padding-top: 10px">费用小项</div> 
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
            queryAction="/FAERP/Job_chargemiditemAction.do?cmd=queryForDatacell" width="100%" height="198px"
            submitAction="/FAERP/Job_chargemiditemAction.do?cmd=saveList"
            xpath="Job_chargemiditemVo" paramFormId="tpl_sc_item_form"
            submitXpath="Job_chargemiditemVo"
                >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="itemname" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="itemcode" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
          <r:field fieldName="formula" messagekey="formula" width="300px" ><h:text ondblclick="toSetFormual(this);" validateAttr="maxLength=500;message=输入有误;" /></r:field>
          <r:field fieldName="description" label="备注" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          </r:datacell>
        </div>
    </td>
    <td>
    <!-- 费用参数  -->
    <div style="padding: 8 10 8 8;" >
        <div class="xz_title" style="padding-top: 10px">费用参数</div> 
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
            queryAction="/FAERP/Job_chargeparamAction.do?cmd=queryForDatacell" width="90%" height="198px"
            submitAction="/FAERP/Job_chargeparamAction.do?cmd=saveList"
            xpath="Job_chargeparamVo" paramFormId="tpl_sc_form"
            submitXpath="Job_chargeparamVo"
            >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="paramname" messagekey="name" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          <r:field fieldName="paramcode" messagekey="code" width="100px" ><h:text validateAttr="maxLength=100;type=code;"/></r:field>    
          <r:field fieldName="datatype" messagekey="data_type" width="100px" >
            <d:select dictTypeId="DATA_TYPE_DB" extAttr="validateAttr='allowNull=false'"/>
          </r:field>
          <r:field fieldName="defaultvalue" messagekey="default_value" width="100px" ><h:text validateAttr="type=tpl_para;maxLength=100;"/></r:field>    
          <r:field fieldName="description" label="备注" width="100px" ><h:text validateAttr="maxLength=100;message=输入有误;"/></r:field>    
          
          </r:datacell>
     </div>
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
