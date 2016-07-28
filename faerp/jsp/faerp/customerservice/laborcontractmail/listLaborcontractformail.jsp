<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo" %>
<%@ page import="rayoo.customerservice.laborcontract.util.ILaborcontractConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(ILaborcontractConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(ILaborcontractConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    LaborcontractVo resultVo = null;  //定义一个临时的vo变量
    Map map = request.getAttribute("map") == null?new HashMap():(Map)request.getAttribute("map");
    //从首页跳转过来的标志flag
    String flag=request.getParameter("flag")==null?"false":request.getParameter("flag");
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.listLaborcontract_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/LaborcontractAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" name="backFlag" id="backFlag" value="true"> 
<input type="hidden" name="flag" id="flag" value="<%=flag %>">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key='listLaborcontract0006'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="125px" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listLaborcontract0007'/></div> </td>
           </tr>
           
           <tr>
            <td align="left"><fmt:message key='listLaborcontract0008'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listLaborcontract0009'/>" value="" maxLength="50"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0010'/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listLaborcontract0010'/>" value="" maxLength="64"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0050'/></td>
            <td align="left">
                <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listLaborcontract0050'/>" value="" maxLength="50"/>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key='listLaborcontract0014'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='listLaborcontract0014'/>" value="" maxLength="64"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0016'/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listLaborcontract0017'/>" value="" maxLength="50"/>
            </td>
            <td align="left"><fmt:message key='listLaborcontract0032'/></td>
            <td align="left">
                <r:comboSelect id="combo_cs" name="user_id" queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                 textField="name" valueField="partyId" xpath="CustServiceVo" width="200px" nullText="" />
            </td>
            <td align="left" colspan="2">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="listLaborcontract0173"/>' onClick="javascript:simpleQuery_onClick()">
            <input type="reset" class="icon_1"   type="button" value="<fmt:message key='listLaborcontract0034'/>" >
            </td>
        </tr>
</table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
    <input class="g" type="button" value="<fmt:message key='listLaborcontract0035'/>"  <au:authorityBtn code="ldhtgl_tj" type="1"/>  onClick="submit_onClick(true);">
 </div>
 <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/LaborcontractAction.do?cmd=queryLaborDataForMail" 
    submitAction="" width="98%" height="320px" xpath="LaborcontractVo" 
    paramFormId="datacell_formid" pageSize="10">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field fieldName="id" label="<input type='checkbox' id='chkbox_all' name='checkAll' onclick='checkAllPro(this);'/>" 
        width="35px" sortAt="none" onRefreshFunc="setCheckBoxStatus"  align="center"></r:field> 
    <r:field fieldName="emp_post_id" messagekey='listLaborcontract0047' width="0px;"></r:field>
    <r:field fieldName="emp_name" messagekey='listLaborcontract0009'></r:field>   
    <r:field fieldName="emp_code" messagekey='listLaborcontract0049'></r:field>
    <r:field fieldName="id_card" messagekey='listLaborcontract0050'></r:field>
    <r:field fieldName="cust_name" messagekey='listLaborcontract0052'></r:field>
    <r:field fieldName="user_name" messagekey='listLaborcontract0032'></r:field>
    <r:field fieldName="contract_properties" messagekey='listLaborcontract0175' allowModify="false">
        <d:select dictTypeId="CONTRACT_PROPERTIES"></d:select>
    </r:field>
    <r:field fieldName="labor_status_bd" messagekey='listLaborcontract0028' allowModify="false">
        <d:select dictTypeId="LABOR_STATUS_BD"></d:select>
    </r:field>
    <r:field fieldName="welfare_address" messagekey='listLaborcontract0058' allowModify="false">
       <h:text name="welfare_address" value=""/>
    </r:field>
    <r:field fieldName="is_mailcontract" messagekey='listLaborcontract0072'>
        <d:select dictTypeId="CONTRACTMAIL_TYPE"></d:select>
    </r:field>
    <r:field fieldName="contractmail_status_bd" messagekey='listLaborcontract0073'>
        <d:select dictTypeId="CONTRACTMAIL_BD"></d:select>
    </r:field>
 </r:datacell>
</div> 
 
 
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
	<%  //表单回写
	    if(request.getAttribute(ILaborcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
	        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ILaborcontractConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	    }
	%>
	$id("datacell1").beforeRefreshCell = function(cell,field){
	        if(field && field.fieldId && field.fieldId.indexOf("id") >= 0){
	            return false;
	        }
	        return true;
	    } 
	//初始化不加载页面信息<siqp<fmt:message key='listLaborcontract0074'/>>
	var temp=<%=flag%>;
	jQuery(function(){
	if(!temp){
	    $id("datacell1").isQueryFirst = false;
	}}
	);
	
    //全选
    function checkAllPro(item){
        if (jQuery(item).attr("checked")) {
            chkAllEntity(1);
            jQuery(":checkbox").attr("checked", true);
        } else {
            chkAllEntity(0);
            jQuery(":checkbox").attr("checked", false);
        }
    }
    
    //显示一列chkbox
    function setCheckBoxStatus(value,entity,rowNo,cellNo){
        //初始化checkbox时设置是否选中
        if(value != "" && value !="null" && value != null){//设置最后一行合计不添加复选框
            var flag = entity.getProperty("chk")=="1"? "checked" : "";
            return "<input "+flag+" onclick='chkEntity("+rowNo+");' type='checkbox' name='checkbox_template' value='" + value + "' />";
        }
    }
    
    //设置ENTITY的chk属性
    function chkEntity(rowNo){
        var emps = $id("datacell1").dataset.values;
        var entity = emps[rowNo];
        var chk = entity.getProperty("chk");
        entity.setProperty("chk",1-chk);
    }
    
    //设置选中ENTITY的chk属性
    function chkAllEntity(flag){
        var ds = $id("datacell1").dataset;
        var values = ds.values;
        for(var i=0; i<values.length; i++){
            var entity = values[i];
            entity.setProperty("chk", flag);
        }
    }
    
    //修改cell值以后操作
     $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
       var rc = this.dataset.getLength();
       var orderitems = this.dataset.values;
       for(var i=0; i<rc; i++){
          var entity = orderitems[i];
          var chk = entity.getProperty("chk");
          if(chk == "1"){
           var curCell = this.getCell(i,activeCell.cellIndex);
           this.setCellValue(curCell,newValue); 
          }
       }
    }
    
    /**
	 * 选择行后返回ids
	 */
	function selectIds() {
	    var myids = new Array(0);
	    var dc = $id("datacell1");
	    var ds = dc.dataset;
	    var xmlString = "<root><data>";//<?xml version='1.0' encoding='UTF-8'?>
	    _$("input[type='checkbox']").each(function(i) {
	        //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            xmlString += entity.toString();
	            myids.push(entity.getValue("id"));
	        }
	    });
	    xmlString += "</data><data><returnValue>true</returnValue></data></root>";
	    return xmlString;
	}
    
    /**
	 * 提交按钮事件
	 */
	function submit_onClick(flag){
        var xmlString = selectIds();
	    var dataset1 = Dataset.create(xmlString ,"root/data/LaborcontractVo","dataset1");
	    var action = "/FAERP/LaborcontractmailAction.do?cmd=Save";
        var myAjax = new Ajax(action);
        var xmlSubmit = dataset1.toString();
        var form = $id("datacell_formid");
        if (form) {
            for (var i = 0; i < form.elements.length; i++) {
                var elem = form.elements[i];
                if (elem.name) {
                    myAjax.addParam(elem.name, getElementValue(elem));
                }
            }
        }           
         myAjax.submitXML(xmlSubmit, 'UTF-8');
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
             if( myAjax.getValue("root/data/returnValue")==0 ) {
                if(flag){
                    alert("提交成功！");
                }
                simpleQuery_onClick();
             } else {
                if(flag){
                    alert("提交失败！");
                }
             }
         }
    }
    
    $id("datacell1").beforeSubmit = function(){
        submit_onClick(false);
    } 
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
</script>   
