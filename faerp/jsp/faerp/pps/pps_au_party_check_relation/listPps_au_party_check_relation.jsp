<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.pps_au_party_check_relation.util.IPps_au_party_check_relationConstants" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
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
		$id("datacell1").isModefied = false;
        var url="<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 300, "修改PPS客户与PPS复核客户关联"); 
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	document.form.action="<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=deleteMulti&ids=" + ids;
	    	document.form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		var url="<%=request.getContextPath()%>/jsp/faerp/pps/pps_au_party_check_relation/insertPps_au_party_check_relation.jsp";
		url=url+'?_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 300, "新增PPS客户与PPS复核客户关联"); 
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
		var url="<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 300, "查看PPS客户与PPS复核客户关联"); 
	}

	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' value='"+ entity.getProperty("id")+"' name='checkbox_template' >";
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco('PPS客户与复核客户关联','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right">PPS客户编号</td>
			<td align="left">
				<input type="text" class="text_field" id="pps_customer_code"  name="pps_customer_code" inputName="PPS客户编号" maxLength="25"/>
			</td>
			<td align="right">PPS客户名称</td>
			<td align="left">
				<input type="text" class="text_field" id="pps_customer_name"  name="pps_customer_name" inputName="PPS客户名称" maxLength="25"/>
			</td>
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
	<input class="a" type="button"   value="<fmt:message key="view"/>"  onClick="javascript:detail_onClick();">
	<input class="c" type="button"   value="<fmt:message key="insert"/>"  onClick="javascript:toAdd_onClick();">
	<input class="d" type="button"   value="<fmt:message key="delete"/>"  onClick="javascript:deleteMulti_onClick();">
	<input class="b" type="button"   value="<fmt:message key="modify"/>"  onClick="javascript:findCheckbox_onClick();">
 </div>
 <div class="clear"></div>			
</div>
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Pps_au_party_check_relationAction.do?cmd=queryData" width="98%" height="318px" xpath="Pps_au_party_check_relationVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="pps_cust_name" label="PPS客户名称" width="251px" ></r:field>    
 <r:field fieldName="pps_cust_code" label="PPS客户编号" width="251px"></r:field>
 <r:field fieldName="pps_cust_check_name" label="PPS复核客户名称" width="251px"></r:field>
 <r:field fieldName="pps_cust_check_code" label="PPS复核客户编号" width="251px"></r:field>
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
	if(request.getAttribute(IPps_au_party_check_relationConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPps_au_party_check_relationConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
