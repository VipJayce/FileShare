<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.hirefire.hirefire.vo.HirefireVo" %>
<%@ page import="rayoo.customerservice.hirefire.hirefire.util.IHirefireConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IHirefireConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IHirefireConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	HirefireVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.listHirefire_resource' prefix='auto.'>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

function toDetailLabor(){
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert('<fmt:message key='listHirefire0006'/>');
        return;
    }
    if(ids.length > 1) {//如果ids<fmt:message key='listHirefire0007'/>2条以上的纪录
        alert('<fmt:message key='listHirefire0009'/>');
        return;
    }
    var post_id = ids;
    var url = "<%=request.getContextPath()%>/HirefireAction.do?cmd=toDetailLabor&post_id="
    + post_id + "&_ts=" + (new Date()).getTime();
    window.open(url,'','height=320px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listHirefire0078'/>劳动合同');
    //showModalCenter(url, window, callBack, 1024, 320, "<fmt:message key='listHirefire0078'/>劳动合同"); 
}

_$(function(){
    $id("datacell1").isQueryFirst = false;
});
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所<fmt:message key='listHirefire0007'/>的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数<fmt:message key='listHirefire0015'/>
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox<fmt:message key='listHirefire0015'/>
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
	function findCheckbox_onClick() {  //从多选框<fmt:message key='listHirefire0062'/><fmt:message key='listHirefire0079'/>页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids<fmt:message key='listHirefire0007'/>2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/HirefireAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"<fmt:message key='listHirefire0020'/>"
	    	form.action="<%=request.getContextPath()%>/HirefireAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊<fmt:message key='query'/>
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //<fmt:message key='listHirefire0062'/>增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/hirefire/insertHirefire.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转<fmt:message key='listHirefire0062'/>详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids<fmt:message key='listHirefire0007'/>2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/HirefireAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
	
	function toupdate(){
	   //var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	   var ids = selectIds();
	   var cesid = selectCesid();
        if(ids == null || ids == '') {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listHirefire0007'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        //var post_id = document.getElementById(ids+'emp_post_id').value;
        //form.action="<%=request.getContextPath()%>/HirefireAction.do?id="+ids+"&post_id="+post_id;
        //form.cmd.value = "toUpdateHireFire";
        //form.submit();
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;
        var attr = dataset.findEntity("id",ids);
        var cust_id = attr.getProperty("cust_id");
        //var cehf_id = attr.getProperty("hfid");
        var cehf_id = selectHfid();
        var url = "<%=request.getContextPath()%>/HirefireAction.do?cmd=toUpdateHireFire&post_id=" + ids+"&cesid=" + cesid+"&cehf_id=" + cehf_id+"&&cust_id=" + cust_id+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=480px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listHirefire0027'/>');
        //showModalCenter(url, window, callBack, 1024, 480, "<fmt:message key='listHirefire0027'/>"); 
	}
    
    function todetail(){
        //var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        var ids = selectIds();
        var cesid = selectCesid();
        if(ids == null || ids == '') {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids<fmt:message key='listHirefire0007'/>2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var datacell = $id("datacell1");
        var dataset = datacell.dataset;
        var attr = dataset.findEntity("id",ids);
        //var cehf_id = attr.getProperty("hfid");
        var cehf_id = selectHfid();
        var url = "<%=request.getContextPath()%>/HirefireAction.do?cmd=toDetailHireFire&post_id=" + ids+"&cesid=" + cesid+"&cehf_id=" + cehf_id+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=480px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=<fmt:message key='listHirefire0032'/>');
        //showModalCenter(url, window, callBack, 1024, 480, "<fmt:message key='listHirefire0032'/>"); 
        //form.action="<%=request.getContextPath()%>/HirefireAction.do?id="+ids+"&post_id="+post_id;
        //form.cmd.value = "toDetailHireFire";
        //form.submit();
    }
    
    function callBack(reg){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function exportexcel(){
        form.action="<%=request.getContextPath()%>/HirefireAction.do";
        form.cmd.value = "exportExcel";
        form.submit();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    function rtnFuncCS(obj){
        document.getElementById('user_name').value=obj[0];
    }
    
    /**
	 * <fmt:message key='listHirefire0034'/>
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
	
	    /**
     * 选择行后返回cesid
     */
    function selectCesid() {
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
                myids.push(entity.getValue("cesid"));
            }
        });
        return myids;
    }
    
        /**
     * 选择行后返回hfid
     */   
        function selectHfid() {
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
                myids.push(entity.getValue("hfid"));
            }
        });
        return myids;
    }
	
	/**
	 * 输入用工不需办理的原因后，把打钩的每一行都改成此原因
	 */
	function batch_change_reason() {
	    var dc = $id("datacell1");
	    var entity = dc.activeEntity;
	    var reason = entity.getValue("back_reason");
	    if (entity.getValue("chk") == '1') {
	        _$("input[type='checkbox']").each(function(i) {
	            //第0个为全选按钮
	            if (i != 0 && _$(this).attr("checked")) {
	                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	                var entity = dc.getEntity(row);
	                entity.setProperty("back_reason", reason);
	            }
	        });
	    }
	}
	
	function batch_cancel_reason() {
	    var dc = $id("datacell1");
	    var entity = dc.activeEntity;
	    var reason = entity.getValue("cancel_reason");
	    if (entity.getValue("chk") == '1') {
	        _$("input[type='checkbox']").each(function(i) {
	            //第0个为全选按钮
	            if (i != 0 && _$(this).attr("checked")) {
	                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	                var entity = dc.getEntity(row);
	                entity.setProperty("cancel_reason", reason);
	            }
	        });
	    }
	}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/HirefireAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('用退工<fmt:message key='query'/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="125" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='listHirefire0048'/></div> </td>
    </tr>
	<tr>
	     <td align="left"><fmt:message key='listHirefire0049'/></td>
         <td align="left">
             <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='listHirefire0050'/>" value="" maxLength="50"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0051'/></td>
         <td align="left">
             <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='listHirefire0051'/>" value="" maxLength="50"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0053'/></td>
         <td align="left">
             <input type="text" class="text_field" name="id_card" inputName="<fmt:message key='listHirefire0053'/>" value="" maxLength="50"/>
         </td>
	</tr>
	<tr>
         <td align="left"><fmt:message key='listHirefire0055'/></td>
         <td align="left">
             <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='listHirefire0055'/>" value="" maxLength="50"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0057'/></td>
         <td align="left">
             <!--<faerp:SoialunitSelectTag tagname="social_unit" beanname="social_unit" />-->
             <r:comboSelect id="social_unit" name="social_unit" queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit" textField="hire_unit_short_name" 
             valueField="id" xpath="SocialunitVo" nullText=""></r:comboSelect> 
         </td>
         <td align="left"><fmt:message key='listHirefire0059'/></td>
         <td align="left">
            <r:comboSelect id="combo_cs" name="user_id" queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                 textField="name" valueField="partyId" xpath="CustServiceVo" width="200px" nullText="" />           
         </td>
    </tr>
    <tr>
         <td align="left"><fmt:message key='listHirefire0061'/></td>
         <td align="left">
            <w:date allowInput="true" id="classify_date_from" name="classify_date_from" format="YYYY-MM-DD" style="width:90px;"/>
            &nbsp;<fmt:message key='listHirefire0062'/>&nbsp;
            <w:date allowInput="true" id="classify_date_to" name="classify_date_to" format="YYYY-MM-DD" style="width:90px;"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0063'/></td>
         <td align="left">
            <w:date allowInput="true" id="on_post_date_from" name="on_post_date_from" format="YYYY-MM-DD" style="width:90px;"/>
            &nbsp;<fmt:message key='listHirefire0062'/>&nbsp;
            <w:date allowInput="true" id="on_post_date_to" name="on_post_date_to" format="YYYY-MM-DD" style="width:90px;"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0065'/></td>
         <td align="left">
            <w:date allowInput="true" id="off_post_date_from" name="off_post_date_from" format="YYYY-MM-DD" style="width:90px;"/>
            &nbsp;<fmt:message key='listHirefire0062'/>&nbsp;
            <w:date allowInput="true" id="off_post_date_to" name="off_post_date_to" format="YYYY-MM-DD" style="width:90px;" />
         </td>
    </tr>
    <tr>
         <td align="left"><fmt:message key='listHirefire0067'/></td>
         <td align="left">
            <w:date allowInput="true" id="hire_handle_date_from" name="hire_handle_date_from" format="YYYY-MM-DD" style="width:90px;"/>
            &nbsp;<fmt:message key='listHirefire0062'/>&nbsp;
            <w:date allowInput="true" id="hire_handle_date_to" name="hire_handle_date_to" format="YYYY-MM-DD" style="width:90px;"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0069'/></td>
         <td align="left">
            <w:date allowInput="true" id="fire_handle_date_from" name="fire_handle_date_from" format="YYYY-MM-DD" style="width:90px;"/>
            &nbsp;<fmt:message key='listHirefire0062'/>&nbsp;
            <w:date allowInput="true" id="fire_handle_date_to" name="fire_handle_date_to" format="YYYY-MM-DD" style="width:90px;"/>
         </td>
         <td align="left"><fmt:message key='listHirefire0071'/></td>
         <td align="left">
             <input type="text" class="text_field" name="bigname" inputName="<fmt:message key='listHirefire0071'/>" value="" maxLength="50"/>
         </td>
    </tr>
    <tr>
         <td align="left"><fmt:message key='listHirefire0073'/></td>
         <td align="left">
             <d:select dictTypeId="HIRE_FIRE_STATUS_BD"
				id="hire_fire_status_bd" name="hire_fire_status_bd" filterOp="in" filterStr="0,1,2,3" nullLabel=""></d:select>
         </td>
         <td align="left">反馈状态</td>
            <td align="left">
            <d:select dictTypeId="FEEDBACK_STATE" id="p_feedback_state" name="p_feedback_state"  nullLabel="--请选择--"></d:select> 
         </td>
         <td align="left"></td>
         <td align="left">
             <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             <input type="reset" class="icon_1"   type="button" value="<fmt:message key='listHirefire0075'/>" >
         </td>
    </tr>			
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
        <div class="button_right">
				<!--<ul>
				  <li class="dj_2"><a href="#"><fmt:message key='listHirefire0076'/></a></li>未明确，<fmt:message key='listHirefire0062'/>时再做
                 
                  <li class="a">     <a href="#" onclick="javascript:todetail()"><fmt:message key='listHirefire0078'/></a></li>
                  <li class="b">     <a href="#" onclick="javascript:toupdate()"><fmt:message key='listHirefire0079'/></a></li>
                 
                  <li class="dj_1"> <a href="#"><fmt:message key='listHirefire0080'/></a></li>未明确，<fmt:message key='listHirefire0062'/>时再做
                  
                  <li class="e">      <a href="#" onclick="javascript:exportexcel()"><fmt:message key='listHirefire0082'/></a></li>
				</ul>			
		 -->
		 <input class="a_2" type="button"   value=" <fmt:message key='listHirefire0010'/>"  <au:authorityBtn code="ytgcx_ckldht" type="1"/>  onClick="toDetailLabor();">
		 <input class="a" type="button"   value="<fmt:message key='listHirefire0078'/>"  <au:authorityBtn code="ytgcx_view" type="1"/>  onClick="todetail();">
		 <input class="b" type="button"   value="<fmt:message key='listHirefire0079'/>"  <au:authorityBtn code="ytgcx_modify" type="1"/>  onClick="toupdate();">
		 <input class="e" type="button"   value="<fmt:message key='listHirefire0082'/>"  <au:authorityBtn code="ytgcx_exp" type="1"/>  onClick="exportexcel();">
		 </div>
           <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/HirefireAction.do?cmd=queryHireFireData" width="98%" height="318px" xpath="HirefireVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <!--<r:field fieldName="id" messagekey='listHirefire0087' width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>-->
 <r:field allowModify="false" fieldName="chk"
            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
            sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
                uncheckedValue="0" />
        </r:field>
 <r:field fieldName="emp_name" messagekey='listHirefire0050'></r:field>
 <r:field fieldName="emp_code" messagekey='listHirefire0051'></r:field>
 <r:field fieldName="id_card" messagekey='listHirefire0090'></r:field>
 <r:field fieldName="cust_name" messagekey='listHirefire0055' width="150px;"></r:field>
 <r:field fieldName="user_name" messagekey='listHirefire0059'></r:field>
 <r:field fieldName="bigname" messagekey='listHirefire0093' width="150px;"></r:field>
 <r:field fieldName="apply_on_post_date" messagekey='listHirefire0094' allowModify="false">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="apply_off_post_date" messagekey='listHirefire0095' allowModify="false">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="hire_address" messagekey='listHirefire0096'></r:field>
 <r:field fieldName="hire_fire_status_bd" messagekey='listHirefire0073' allowModify="false">
    <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />
 </r:field>
 <r:field fieldName="back_reason" messagekey='listHirefire0098' width="150px;">
     <h:text name="back_reason" value="back_reason" onblur="batch_change_reason();"/>
 </r:field>
 <r:field fieldName="cancel_reason" messagekey='listHirefire0099' width="150px;">
     <h:text name="cancel_reason" value="cancel_reason" onblur="batch_cancel_reason();"/>
 </r:field>
 <r:field fieldName="is_laborbook_bd" messagekey='listHirefire0100' allowModify="false">
    <d:select dictTypeId="TrueOrFalse"/>
 </r:field>
 <r:field fieldName="is_fire_prove_bd" messagekey='listHirefire0101' allowModify="false">
    <d:select dictTypeId="TrueOrFalse"/>
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
</fmt:bundle>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IHirefireConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IHirefireConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
