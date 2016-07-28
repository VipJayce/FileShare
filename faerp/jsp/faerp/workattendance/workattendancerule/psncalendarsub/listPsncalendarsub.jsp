<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.workattendancerule.psncalendarsub.vo.PsncalendarsubVo" %>
<%@ page import="rayoo.workattendance.workattendancerule.psncalendarsub.util.IPsncalendarsubConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IPsncalendarsubConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPsncalendarsubConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PsncalendarsubVo resultVo = null;  //定义一个临时的vo变量
%>
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
		form.action="<%=request.getContextPath()%>/PsncalendarsubAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/PsncalendarsubAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancerule/psncalendarsub/insertPsncalendarsub.jsp";
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
		form.action="<%=request.getContextPath()%>/PsncalendarsubAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post" action="<%=request.getContextPath()%>/PsncalendarsubAction.do">
<input type="hidden" name="cmd" value="">
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;<fmt:message key="query_by_condition"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td align="right">开始截至时间</td>
			<td align="left">
				<input type="text" class="text_field" name="ksto" inputName="开始截至时间" maxLength="4"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">下班是否打卡</td>
			<td align="left">
				<input type="text" class="text_field" name="checkoutflag" inputName="下班是否打卡" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">时段序号</td>
			<td align="left">
				<input type="text" class="text_field_half" name="timeid_from" inputName="时段序号" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="timeid_to" inputName="时段序号" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">上班是否打卡</td>
			<td align="left">
				<input type="text" class="text_field" name="checkinflag" inputName="上班是否打卡" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">是否跨天</td>
			<td align="left">
				<input type="text" class="text_field" name="sfkt" inputName="是否跨天" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">结束截止时间</td>
			<td align="left">
				<input type="text" class="text_field" name="jsto" inputName="结束截止时间" maxLength="4"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">结束时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="jssj_from" id="jssj_from" inputName="结束时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('jssj_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="jssj_to" id="jssj_to" inputName="结束时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('jssj_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">开始时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="kssj_from" id="kssj_from" inputName="开始时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('kssj_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="kssj_to" id="kssj_to" inputName="开始时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('kssj_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">公司编码</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="公司编码" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">作息时间ID</td>
			<td align="left">
				<input type="text" class="text_field" name="pk_wtid" inputName="作息时间ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">人员工作日历主键</td>
			<td align="left">
				<input type="text" class="text_field" name="pk_psncalendar" inputName="人员工作日历主键" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">是否有效</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="是否有效" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">是否删除</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="是否删除" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">最后修改人</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="最后修改人" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">最后修改日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="最后修改日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="最后修改日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">分公司id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="分公司id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td/>
            <td>
                <input name="button_ok" class="button_ellipse" type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="button_ellipse" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
			<td/>
			<td/>
		</tr>
	</table>

</td></tr>
</table>
</div>
					
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr>
					<td class="button_ellipse" onClick="javascript:detail_onClick();"><img src="<%=request.getContextPath()%>/images/icon/search.gif" class="div_control_image"><fmt:message key="view"/></td>
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="insert"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content2">
	<tr>
		<td>
		<layout:collection name="beans" id="rmBean" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
			
			<layout:collectionItem width="1%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="checkbox" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="3%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="开始截至时间" property="ksto" sortable="true"/>
			
			<layout:collectionItem width="8%" title="下班是否打卡" property="checkoutflag" sortable="true"/>
			
			<layout:collectionItem width="8%" title="时段序号" property="timeid" sortable="true"/>
			
			<layout:collectionItem width="8%" title="上班是否打卡" property="checkinflag" sortable="true"/>
			
			<layout:collectionItem width="8%" title="是否跨天" property="sfkt" sortable="true"/>
			
			<layout:collectionItem width="8%" title="结束截止时间" property="jsto" sortable="true"/>
			
			<layout:collectionItem width="8%" title="结束时间" property="jssj" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="jssj"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="开始时间" property="kssj" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="kssj"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="公司编码" property="cust_code" sortable="true"/>
			
			<layout:collectionItem width="8%" title="作息时间ID" property="pk_wtid" sortable="true"/>
			
			<layout:collectionItem width="8%" title="人员工作日历主键" property="pk_psncalendar" sortable="true"/>
			
			<layout:collectionItem width="8%" title="是否有效" property="is_valid" sortable="true"/>
			
			<layout:collectionItem width="8%" title="是否删除" property="is_del" sortable="true"/>
			
			<layout:collectionItem width="8%" title="最后修改人" property="last_update_user_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="最后修改日期" property="last_update_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="last_update_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="分公司id" property="company_id" sortable="true"/>
			
			</layout:collection>
		
		<!-- 下边这句是翻页, 如果去掉就不带翻页了,同时注意Action中也要调整方法 -->
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IPsncalendarsubConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPsncalendarsubConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
