<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.sal_quotation_tpl.vo.Sal_quotation_tplVo" %>
<%@ page import="rayoo.sales.sal_quotation_tpl.util.ISal_quotation_tplConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISal_quotation_tplConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Sal_quotation_tplVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.salse.sal_quotation_tpl.sal_quotation_tpl_resource" prefix="rayoo.salse.sal_quotation_tpl.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}
	function view_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?id=" + ids;
		form.cmd.value = "view";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		for(var i = 0 ; i < ids.length; i++){
             var id = ids[i];
             var entity = datacellDatas[id];
             var is_use = entity.getValue("is_use");
             if(is_use == "1"){
                 alert(entity.getValue("name") + " <fmt:message key="cite_not_delete"/>");
                 return;
             }else {
             }
        }
		
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/sales/sal_quotation_tpl/insertSal_quotation_tpl.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
function setCheckboxStatus(value,entity,rowNo,cellNo){
    datacellDatas[value] = entity;
    return "<input type='checkbox' name='checkbox_template' value='"+value+"' is_use='" + entity.getValue("is_use") + "'>";
}
var datacellDatas = {};
function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell1").loadData();
    $id("datacell1").refresh();
}
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/Sal_quotation_tplAction.do" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right"><fmt:message key="template_name"/>&nbsp;&nbsp;</td>
			<td align="left">
				<input type="text" class="text_field" name="name" inputName="name" maxLength="100" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="b">  	<a  onClick="javascript:view_onClick();"><fmt:message key="view"/></a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
<!-- <div id="values_div" class="box" > -->
      <div style="padding: 8 10 8 8;">
		 <r:datacell id="datacell1" queryAction="/FAERP/Sal_quotation_tplAction.do?cmd=queryForDatacell" width="98%" height="318px" 
		 xpath="Sal_quotation_tplVo" paramFormId="datacell_formid">
		 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		 <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
		 <r:field fieldName="name" messagekey="template_name" width="250px" ></r:field>
		 <r:field fieldName="tpl_status" messagekey="tpl_status" width="80px" onRefreshFunc="showTplStatus4onRefreshFunc">
		 </r:field>
		 <r:field fieldName="create_date" messagekey="create_date" width="250px" onRefreshFunc="">
		      <w:date format="yyyy-MM-dd HH:mm" readOnly="true"/>
         </r:field>
		 <r:field fieldName="create_user_name" messagekey="create_user_name" width="250px" ></r:field>    
		 
		 </r:datacell>
	   </div>
<!--</div>-->
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
function showTplStatus4onRefreshFunc(value,entity,rowNo,cellNo){
    var result = "未校验";
    if(value=="1"){
        result = "已校验";
    }else {
        
    }
    return result;
}

</script>
</body>
</html>
