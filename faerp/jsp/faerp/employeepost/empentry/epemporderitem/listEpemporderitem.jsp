<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.vo.EpemporderitemVo" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.util.IEpemporderitemConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IEpemporderitemConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IEpemporderitemConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	EpemporderitemVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/EpemporderitemAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/EpemporderitemAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/epemporderitem/insertEpemporderitem.jsp";
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
		form.action="<%=request.getContextPath()%>/EpemporderitemAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EpemporderitemAction.do">
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
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right">基数</td>
			<td align="left">
				<input type="text" class="text_field_half" name="base_from" inputName="基数" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="base_to" inputName="基数" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="money_from" inputName="金额" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="money_to" inputName="金额" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">个人金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_money_from" inputName="个人金额" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_money_to" inputName="个人金额" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">企业金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_money_from" inputName="企业金额" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_money_to" inputName="企业金额" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">个人比例</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_ratio_from" inputName="个人比例" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_ratio_to" inputName="个人比例" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">企业比例</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_ratio_from" inputName="企业比例" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_ratio_to" inputName="企业比例" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">收费开始时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="start_date_from" id="start_date_from" inputName="收费开始时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="start_date_to" id="start_date_to" inputName="收费开始时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">收费截止时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="end_date_from" id="end_date_from" inputName="收费截止时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="end_date_to" id="end_date_to" inputName="收费截止时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">财务计算申报的起始时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="on_apply_date_from" id="on_apply_date_from" inputName="财务计算申报的起始时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_apply_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="on_apply_date_to" id="on_apply_date_to" inputName="财务计算申报的起始时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_apply_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">报入职时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="start_apply_date_from" id="start_apply_date_from" inputName="报入职时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_apply_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="start_apply_date_to" id="start_apply_date_to" inputName="报入职时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_apply_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">财务计算申报的截止时间</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="off_apply_date_from" id="off_apply_date_from" inputName="财务计算申报的截止时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('off_apply_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="off_apply_date_to" id="off_apply_date_to" inputName="财务计算申报的截止时间"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('off_apply_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">报离职日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="end_apply_date_from" id="end_apply_date_from" inputName="报离职日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_apply_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="end_apply_date_to" id="end_apply_date_to" inputName="报离职日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_apply_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">单位附加金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_add_money_from" inputName="单位附加金额" value="0.00 " columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_add_money_to" inputName="单位附加金额" value="0.00 " columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">个人附加金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_add_money_from" inputName="个人附加金额" value="0.00 " columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_add_money_to" inputName="个人附加金额" value="0.00 " columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否预收</td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_prepay", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='是否预收'", true) %>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">收费频率</td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("frequency_bd", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='收费频率'", true) %>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否服务办理好收费</td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_charge_on_security", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='是否服务办理好收费'", true) %>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">最后修改人</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="最后修改人" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">最后修改日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="最后修改日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="最后修改日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">收费状态</td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_effected", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='收费状态'", true) %>
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
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"base")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"base")%>">
           	</a>	
       
			 基数</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"money")%>">
           	</a>	
       
			 金额</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_money")%>">
           	</a>	
       
			 个人金额</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_money")%>">
           	</a>	
       
			 企业金额</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_ratio")%>">
           	</a>	
       
			 个人比例</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_ratio")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_ratio")%>">
           	</a>	
       
			 企业比例</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"start_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"start_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"start_date")%>">
           	</a>	
       
			收费开始时间</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"end_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"end_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"end_date")%>">
           	</a>	
       
			收费截止时间</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"on_apply_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"on_apply_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"on_apply_date")%>">
           	</a>	
       
			财务计算申报的起始时间</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"start_apply_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"start_apply_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"start_apply_date")%>">
           	</a>	
       
			报入职时间</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"off_apply_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"off_apply_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"off_apply_date")%>">
           	</a>	
       
			财务计算申报的截止时间</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"end_apply_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"end_apply_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"end_apply_date")%>">
           	</a>	
       
			报离职日期</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_add_money")%>">
           	</a>	
       
			 单位附加金额</th>
			<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_add_money")%>">
           	</a>	
       
			 个人附加金额</th>
			<th>
					
					<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_prepay")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_prepay")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_prepay")%>">
           	</a>	
       
	 是否预收</th>
     	<th>
					
					<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"frequency_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"frequency_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"frequency_bd")%>">
           	</a>	
       
	 收费频率</th>
     	<th>
					
					<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_charge_on_security")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_charge_on_security")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_charge_on_security")%>">
           	</a>	
       
	 是否服务办理好收费</th>
     	<th>
				
			  	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 最后修改人</th>
			<th>
							
				 	<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			最后修改日期</th>
			<th>
					
					<a href="/FAERP/EpemporderitemAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_effected")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_effected")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_effected")%>">
           	</a>	
       
	 收费状态</th>
     	</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="base"/>   </td>
			
			<td><bean:write name="data" property="money"/>   </td>
			
			<td><bean:write name="data" property="p_money"/>   </td>
			
			<td><bean:write name="data" property="e_money"/>   </td>
			
			<td><bean:write name="data" property="p_ratio"/>   </td>
			
			<td><bean:write name="data" property="e_ratio"/>   </td>
			
			<td><bean:write name="data" property="start_date"/>   </td>
			<td><bean:write name="data" property="end_date"/>   </td>
			<td><bean:write name="data" property="on_apply_date"/>   </td>
			<td><bean:write name="data" property="start_apply_date"/>   </td>
			<td><bean:write name="data" property="off_apply_date"/>   </td>
			<td><bean:write name="data" property="end_apply_date"/>   </td>
			<td><bean:write name="data" property="e_add_money"/>   </td>
			
			<td><bean:write name="data" property="p_add_money"/>   </td>
			
			<td><bean:write name="data" property="is_prepay"/>   </td>		
			<td><bean:write name="data" property="frequency_bd"/>   </td>		
			<td><bean:write name="data" property="is_charge_on_security"/>   </td>		
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="is_effected"/>   </td>		
			</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

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
	if(request.getAttribute(IEpemporderitemConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEpemporderitemConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
