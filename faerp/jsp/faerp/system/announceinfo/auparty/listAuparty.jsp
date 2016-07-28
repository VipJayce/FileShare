<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.announceinfo.auparty.vo.AupartyVo" %>
<%@ page import="rayoo.system.announceinfo.auparty.util.IAupartyConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IAupartyConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IAupartyConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	AupartyVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/AupartyAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/AupartyAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/system/announceinfo/auparty/insertAuparty.jsp";
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
		form.action="<%=request.getContextPath()%>/AupartyAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/AupartyAction.do">
<input type="hidden" name="cmd" value="">
 
 
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
			<td align="right">partytype_id</td>
			<td align="left">
				<input type="text" class="text_field" name="partytype_id" inputName="partytype_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">partytype_keyword</td>
			<td align="left">
				<input type="text" class="text_field" name="partytype_keyword" inputName="partytype_keyword" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_inherit</td>
			<td align="left">
				<input type="text" class="text_field" name="is_inherit" inputName="is_inherit" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_real</td>
			<td align="left">
				<input type="text" class="text_field" name="is_real" inputName="is_real" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">name</td>
			<td align="left">
				<input type="text" class="text_field" name="name" inputName="name" maxLength="150"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">email</td>
			<td align="left">
				<input type="text" class="text_field" name="email" inputName="email" maxLength="150"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">owner_org</td>
			<td align="left">
				<input type="text" class="text_field" name="owner_org" inputName="owner_org" maxLength="150"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">备注</td>
			<td align="left">
				<input type="text" class="text_field" name="remark" inputName="备注" maxLength="500"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">启用/禁用状态</td>
			<td align="left">
				<input type="text" class="text_field" name="enable_status" inputName="启用/禁用状态" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">启用/禁用日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="enable_date_from" id="enable_date_from" inputName="启用/禁用日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('enable_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="enable_date_to" id="enable_date_to" inputName="启用/禁用日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('enable_date_to','<venus:base/>/');"/>
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
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
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
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"partytype_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"partytype_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"partytype_id")%>">
           	</a>	
       
			 partytype_id</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"partytype_keyword")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"partytype_keyword")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"partytype_keyword")%>">
           	</a>	
       
			 partytype_keyword</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_inherit")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_inherit")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_inherit")%>">
           	</a>	
       
			 is_inherit</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_real")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_real")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_real")%>">
           	</a>	
       
			 is_real</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"name")%>">
           	</a>	
       
			 name</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email")%>">
           	</a>	
       
			 email</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"owner_org")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"owner_org")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"owner_org")%>">
           	</a>	
       
			 owner_org</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remark")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remark")%>">
           	</a>	
       
			 备注</th>
			<th>
				
			  	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"enable_status")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"enable_status")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"enable_status")%>">
           	</a>	
       
			 启用/禁用状态</th>
			<th>
							
				 	<a href="/FAERP/AupartyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"enable_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"enable_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"enable_date")%>">
           	</a>	
       
			启用/禁用日期</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="partytype_id"/>   </td>
			
			<td><bean:write name="data" property="partytype_keyword"/>   </td>
			
			<td><bean:write name="data" property="is_inherit"/>   </td>
			
			<td><bean:write name="data" property="is_real"/>   </td>
			
			<td><bean:write name="data" property="name"/>   </td>
			
			<td><bean:write name="data" property="email"/>   </td>
			
			<td><bean:write name="data" property="owner_org"/>   </td>
			
			<td><bean:write name="data" property="remark"/>   </td>
			
			<td><bean:write name="data" property="enable_status"/>   </td>
			
			<td><bean:write name="data" property="enable_date"/>   </td>
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
	if(request.getAttribute(IAupartyConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IAupartyConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	