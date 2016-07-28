<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empentry.emphirefire.vo.EmphirefireVo" %>
<%@ page import="rayoo.employeepost.empentry.emphirefire.util.IEmphirefireConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IEmphirefireConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IEmphirefireConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	EmphirefireVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emphirefire.emphirefire_resource" prefix="rayoo.employeepost.empentry.emphirefire.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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
		form.action="<%=request.getContextPath()%>/EmphirefireAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/EmphirefireAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emphirefire/insertEmphirefire.jsp";
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
		form.action="<%=request.getContextPath()%>/EmphirefireAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EmphirefireAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right"><fmt:message key="now_the_files_are_located"/></td>
			<td align="left">
				<input type="text" class="text_field" name="archives_address" inputName="现档案所在地" maxLength="75"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="employment_begin_date"/></td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="hire_start_date_from" id="hire_start_date_from" inputName="用工起始日"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_start_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="hire_start_date_to" id="hire_start_date_to" inputName="用工起始日"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_start_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="employment_address"/></td>
			<td align="left">
				<input type="text" class="text_field" name="hire_address" inputName="用工所在地" maxLength="75"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="handle_employment_date"/></td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="hire_handle_date_from" id="hire_handle_date_from" inputName="办理用工日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_handle_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="hire_handle_date_to" id="hire_handle_date_to" inputName="办理用工日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_handle_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="archive_cards"/></td>
			<td align="left">
				<input type="text" class="text_field" name="file_card" inputName="存档卡" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="office_srfm_labor_and_employment"/></td>
			<td align="left">
				<input type="text" class="text_field" name="hire_handler_id" inputName="办用工劳动专管员id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="hire_operate_date"/></td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="hire_operate_date_from" id="hire_operate_date_from" inputName="系统记录用工日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_operate_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="hire_operate_date_to" id="hire_operate_date_to" inputName="系统记录用工日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_operate_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="social_unit"/></td>
			<td align="left">
				<input type="text" class="text_field" name="social_unit" inputName="用工方" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="hire_fire_status"/></td>
			<td align="left">
				<input type="text" class="text_field" name="hire_fire_status_bd" inputName="用退工状态" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="fire_handle_date"/></td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="fire_handle_date_from" id="fire_handle_date_from" inputName="办理退工日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('fire_handle_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="fire_handle_date_to" id="fire_handle_date_to" inputName="办理退工日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('fire_handle_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="fire_mode"/></td>
			<td align="left">
				<input type="text" class="text_field" name="fire_mode_bd" inputName="退工方式" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="fire_memo"/></td>
			<td align="left">
				<input type="text" class="text_field" name="fire_memo" inputName="退工备注" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="hire_memo"/></td>
			<td align="left">
				<input type="text" class="text_field" name="hire_memo" inputName="用工备注" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="fire_resident_address"/></td>
			<td align="left">
				<input type="text" class="text_field" name="fire_resident_address" inputName="退工户籍地址" maxLength="75"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="cancel_reason"/></td>
			<td align="left">
				<input type="text" class="text_field" name="cancel_reason" inputName="撤销原因" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="back_reason"/></td>
			<td align="left">
				<input type="text" class="text_field" name="back_reason" inputName="回退原因" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="transfer_type"/></td>
			<td align="left">
				<input type="text" class="text_field" name="transfer_type_bd" inputName="退工证明转移方式" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="last_icst_id"/></td>
			<td align="left">
				<input type="text" class="text_field" name="last_icst_id" inputName="上次用工服务明细ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="last_eoop_id"/></td>
			<td align="left">
				<input type="text" class="text_field" name="last_eoop_id" inputName="上次用工入离职ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="is_laborbook"/></td>
			<td align="left">
				<input type="text" class="text_field" name="is_laborbook_bd" inputName="是否有劳动手册" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="is_fire_prove"/></td>
			<td align="left">
				<input type="text" class="text_field" name="is_fire_prove_bd" inputName="是否有退工单" maxLength="64"/>
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
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"archives_address")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"archives_address")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"archives_address")%>">
           	</a>	
       
			 <fmt:message key="now_the_files_are_located"/></th>
			<th>
							
				 	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_start_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_start_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_start_date")%>">
           	</a>	
       
			<fmt:message key="employment_begin_date"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_address")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_address")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_address")%>">
           	</a>	
       
			 <fmt:message key="employment_address"/></th>
			<th>
							
				 	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_handle_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_handle_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_handle_date")%>">
           	</a>	
       
			<fmt:message key="handle_employment_date"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"file_card")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"file_card")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"file_card")%>">
           	</a>	
       
			 <fmt:message key="archive_cards"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_handler_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_handler_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_handler_id")%>">
           	</a>	
       
			 <fmt:message key="office_srfm_labor_and_employment"/></th>
			<th>
							
				 	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_operate_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_operate_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_operate_date")%>">
           	</a>	
       
			<fmt:message key="hire_operate_date"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_unit")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_unit")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_unit")%>">
           	</a>	
       
			 <fmt:message key="social_unit"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_fire_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_fire_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_fire_status_bd")%>">
           	</a>	
       
			 <fmt:message key="hire_fire_status"/></th>
			<th>
							
				 	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fire_handle_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fire_handle_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fire_handle_date")%>">
           	</a>	
       
			<fmt:message key="fire_handle_date"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fire_mode_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fire_mode_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fire_mode_bd")%>">
           	</a>	
       
			 <fmt:message key="fire_mode"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fire_memo")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fire_memo")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fire_memo")%>">
           	</a>	
       
			 <fmt:message key="fire_memo"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hire_memo")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hire_memo")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hire_memo")%>">
           	</a>	
       
			 <fmt:message key="hire_memo"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fire_resident_address")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fire_resident_address")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fire_resident_address")%>">
           	</a>	
       
			 <fmt:message key="fire_resident_address"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cancel_reason")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cancel_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cancel_reason")%>">
           	</a>	
       
			 <fmt:message key="cancel_reason"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"back_reason")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"back_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"back_reason")%>">
           	</a>	
       
			 <fmt:message key="back_reason"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"transfer_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"transfer_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"transfer_type_bd")%>">
           	</a>	
       
			 <fmt:message key="transfer_type"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_icst_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_icst_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_icst_id")%>">
           	</a>	
       
			 <fmt:message key="last_icst_id"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_eoop_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_eoop_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_eoop_id")%>">
           	</a>	
       
			 <fmt:message key="last_eoop_id"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_laborbook_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_laborbook_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_laborbook_bd")%>">
           	</a>	
       
			 <fmt:message key="is_laborbook"/></th>
			<th>
				
			  	<a href="/FAERP/EmphirefireAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_fire_prove_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_fire_prove_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_fire_prove_bd")%>">
           	</a>	
       
			 <fmt:message key="is_fire_prove"/></th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="archives_address"/>   </td>
			
			<td><bean:write name="data" property="hire_start_date"/>   </td>
			<td><bean:write name="data" property="hire_address"/>   </td>
			
			<td><bean:write name="data" property="hire_handle_date"/>   </td>
			<td><bean:write name="data" property="file_card"/>   </td>
			
			<td><bean:write name="data" property="hire_handler_id"/>   </td>
			
			<td><bean:write name="data" property="hire_operate_date"/>   </td>
			<td><bean:write name="data" property="social_unit"/>   </td>
			
			<td><bean:write name="data" property="hire_fire_status_bd"/>   </td>
			
			<td><bean:write name="data" property="fire_handle_date"/>   </td>
			<td><bean:write name="data" property="fire_mode_bd"/>   </td>
			
			<td><bean:write name="data" property="fire_memo"/>   </td>
			
			<td><bean:write name="data" property="hire_memo"/>   </td>
			
			<td><bean:write name="data" property="fire_resident_address"/>   </td>
			
			<td><bean:write name="data" property="cancel_reason"/>   </td>
			
			<td><bean:write name="data" property="back_reason"/>   </td>
			
			<td><bean:write name="data" property="transfer_type_bd"/>   </td>
			
			<td><bean:write name="data" property="last_icst_id"/>   </td>
			
			<td><bean:write name="data" property="last_eoop_id"/>   </td>
			
			<td><bean:write name="data" property="is_laborbook_bd"/>   </td>
			
			<td><bean:write name="data" property="is_fire_prove_bd"/>   </td>
			
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
	if(request.getAttribute(IEmphirefireConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmphirefireConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
