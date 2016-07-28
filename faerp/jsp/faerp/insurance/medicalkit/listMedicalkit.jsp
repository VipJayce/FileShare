<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.medicalkit.vo.MedicalkitVo" %>
<%@ page import="rayoo.insurance.medicalkit.util.IMedicalkitConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IMedicalkitConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IMedicalkitConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	MedicalkitVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
		//form.action="<%=request.getContextPath()%>/MedicalkitAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		var url="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 800, 240, "修改药箱");  
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/MedicalkitAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		//form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/medicalkit/insertMedicalkit.jsp";
		//form.submit();
		var url="<%=request.getContextPath()%>/jsp/faerp/insurance/medicalkit/insertMedicalkit.jsp";
        url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 800, 240, "新增药箱");  
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = selectIds();
        if(ids == null || ids == '') {
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
		//form.action="<%=request.getContextPath()%>/MedicalkitAction.do?id=" + ids;
		//form.cmd.value = "detail";
		//form.submit();
		var url="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 800, 240, "查看药箱");  
	}
	
	function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }

    function getcustomerList(){
        var ids = window.showModalDialog('<venus:base/>/CustomerAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids==undefined)return;
        document.form.cust_id.value=ids[0];
        document.form.customer_name.value=ids[1];
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function tolistattachment_id(value,entity,rowNo,cellNo){
        var attachment_id = entity.getProperty("attachment_id");
        if(attachment_id!=null&&attachment_id!=""){
       var url="<venus:base/>/MedicalkitAction.do?cmd=downLoad&attachment_id="+attachment_id;
            return "<a href="+url+">查看附件</a>";
        }
    }
    
    function exportExcel_onClick()
	{
	      form.action="<%=request.getContextPath()%>/MedicalkitAction.do?cmd=exportExcel" ;
	      form.submit();
	}
	
	function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[2];
	    lookup.displayValue = arg[2];
	    //jQuery("#cust_id").val(arg[0]);       
	    //jQuery("#customer_name").val(arg[2]);
	    return false;
	}
	
	/**
	 * 点击全选按钮
	 * @param {} item
	 */
	function checkAll(item) {
	    if (_$(item).attr("checked")) {
	        changeEntityChk(true);
	        _$(":checkbox").attr("checked", true);
	    } else {
	        changeEntityChk(false);
	        _$(":checkbox").attr("checked", false);
	    }
	}
	
	/**
	 * 改变datacell中的chk的值
	 * @param {} flag
	 */
	function changeEntityChk(flag) {
	    var dc1 = $id("datacell1").dataset;
	    var values = dc1.values;
	    for(var i=0; i<values.length; i++){
	        var entity = values[i];
	        entity.setProperty("chk", flag);
	    }
	}
	
	/**
	 * 选择行后返回ids
	 */
	function selectIds() {
	    var myids = new Array(0);
	    var dc = $id("datacell1");
	    var ds = dc.dataset;
	    _$("input[type='checkbox']").each(function(i) {
	        //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            //此id为post_id
	            //myids += entity.getValue("id") + ",";
	            myids.push(entity.getValue("id"));
	        }
	    });
	    return myids;
	}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('药箱管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
		</tr>
		<tr>
			<td align="left">客户名称</td>
			<td align="left">
			     <!-- <input type="text" class="text_field_reference_readonly" id="customer_name" name="customer_name"  validators="isSearch" inputName="客户名称"  maxLength="10" readonly="readonly"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getcustomerList();"/>
                 <input type="hidden" name="cust_id" id="cust_id"/>
                  -->
                 <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" name="customer_name" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition&Medicalkit=true" dialogTitle="选择客户" height="500" width="810"/>
                <!--<input type="hidden" name="customer_name" id="customer_name"/>
                <input type="hidden" name="cust_id" id="cust_id"/>
			--></td>
			<td align="left">药品价值</td>
			<td align="left">
				<input type="text" class="text_field_half" name="medicine_value" inputName="药品价值" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="left">药品成本</td>
			<td align="left">
				<input type="text" class="text_field_half" name="medicine_cost" inputName="药品成本" value="" columnSize="" decimalDigits="4" />
			</td>
		</tr>
		<tr>
			<td align="left">药箱属性</td>
			<td align="left">
			     <d:select dictTypeId="MEDICINE_ATTRIBUTES" id="medicine_attributes" name="medicine_attributes" nullLabel="请选择"/>
			     <!-- <select name="medicine_attributes" class="sSelect" id="medicine_attributes" style="width: 204px;">
                 <option value="">请选择</option>
                 <option value="0">购买</option>
                 <option value="1">赠送</option>
                </select> -->
			</td>
			<td align="right">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="right"><input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()"></td>
			<td align="left">&nbsp;&nbsp;<input name="button_ok" class="icon_1"   type="reset" value='<fmt:message key="reset"/>'></td>
		</tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
				    <li class="a">     <a  onClick="javascript:detail_onClick();"><fmt:message key="view" /> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="b">     <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="e"> <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/></a></li> 
				</ul>
				--><input class="a" type="button"   value="<fmt:message key="view" />"  <au:authorityBtn code="xyxgl_xc" type="1"/>  onClick="detail_onClick();">
				<input class="c" type="button"   value="<fmt:message key="insert"/>"  <au:authorityBtn code="xyxgl_add" type="1"/>  onClick="toAdd_onClick();">
	             <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="xyxgl_xg" type="1"/>  onClick="findCheckbox_onClick();">
	             <input class="d" type="button"   value="<fmt:message key="delete"/>"  <au:authorityBtn code="xyxgl_del" type="1"/>  onClick="deleteMulti_onClick();">   
	             <input class="e" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="xyxgl_exp" type="1"/>  onClick="exportExcel_onClick();">    
		 </div>
           <div class="clear"></div>
</div>
 <div id="values_div"> 
 <r:datacell 
        id="datacell1"
        queryAction="/FAERP/MedicalkitAction.do?cmd=searchMedicalkitData"
        width="98%"
        height="318px"
        xpath="MedicalkitVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <!--<r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
      -->
      <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
        </r:field>
      <r:field fieldName="customer_name" width="200px" label="客户名称">
      </r:field>
      <r:field fieldName="medicine_attributes" width="150px" label="药箱属性" allowModify="false">
      <d:select dictTypeId="MEDICINE_ATTRIBUTES" />
      </r:field>
      <r:field fieldName="medicine_value" width="100px" label="药品价值">
      </r:field>
      <r:field fieldName="medicine_cost" width="100px" label="药品成本">
      </r:field>
      <r:field fieldName="remark" width="395px" label="备注">
      </r:field>
      <r:field fieldName="attachment_id" width="150px" label="查看附件" onRefreshFunc="tolistattachment_id">
      </r:field>
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
	if(request.getAttribute(IMedicalkitConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IMedicalkitConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
