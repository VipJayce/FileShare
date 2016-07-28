<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.quotationtemplate.vo.QuotationVo"%>
<%@ page import="rayoo.sales.quotationtemplate.util.IQuotationConstants"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.salse.quotationtemplate.quotationtemplate_resource" prefix="rayoo.salse.quotationtemplate.">
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
		form.action="<%=request.getContextPath()%>/QuotationtemplateAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/QuotationtemplateAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	//form.cmd.value = "simpleQuery";
    	//form.submit();
    	$id("datacell1").addParam("quotation_template_name",$id("quotation_template_name").value); 
        $id("datacell1").addParam("biz_type_bd",$name("biz_type_bd").value); 
        $id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/sales/quotationtemplate/insertQuotation.jsp";
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
		form.action="<%=request.getContextPath()%>/QuotationtemplateAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value=" + entity.getProperty("id") + " >";
    }
</script>
	</head>
	<body>

	<form name="form" method="post"
		action="<%=request.getContextPath()%>/QuotationtemplateAction.do"><input
		type="hidden" name="cmd" value="queryAll">

	<div id="right"><script language="javascript">
	writeTableTopFesco('<fmt:message key="quotation_template"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<div class="ringht_s">

	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
			<div class="search_title"><fmt:message key="query_conditions"/></div>
			</td>
		</tr>
		<tr>
			<td width="80" align="right"><fmt:message key="template_name"/></td>
			<td width="194" align="left"><input type="text" class="text_field" id="quotation_template_name"  name="quotation_template_name"
			      inputName="模板名称"  maxLength="50" /></td>
			<td width="80" align="right"><fmt:message key="salse_type"/></td>
			<td width="249" align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("biz_type_bd", -1,"SAL_QUO_BIZ_TYPE_BD", "", "", false) %>
			</td>
			<td width="322">
			<input name="button_ok" class="icon_1"
                type="button" value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery_onClick()">
			</td>
				
		</tr>
		<tr></tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="a"><a onClick="javascript:detail_onClick();"><fmt:message
			key="view" /> </a></li>
		<li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message
			key="insert" /> </a></li>
		<li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message
			key="delete" /> </a></li>
		<li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message
			key="modify" /> </a></li>
	</ul>

	</div>
	<div class="clear"></div>
	</div>
 <div style="padding: 8 5 8 8;">
	 <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationtemplateAction.do?cmd=simpleQuery"
       submitAction="/FAERP/QuotationtemplateAction.do?cmd=insert"
        width="98%"
        xpath="QuotationVo"
        submitXpath="QuotationVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="quotation_template_name" width="250px" messagekey="template_name" >
       </r:field>    
      <r:field fieldName="effect_date" width="205px" messagekey="effect_date" allowModify="false">
       <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>    
       <r:field fieldName="lapse_date" width="205px" messagekey="lapse_date" allowModify="false">
        <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>    
       <r:field fieldName="create_date" width="210px" messagekey="create_date" allowModify="false">
       <w:date format="yyyy-MM-dd" allowNull="false;"/>
       </r:field>    
       <r:field fieldName="create_user_id" width="225px" messagekey="create_user_name">
       </r:field>      
     
    </r:datacell>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
