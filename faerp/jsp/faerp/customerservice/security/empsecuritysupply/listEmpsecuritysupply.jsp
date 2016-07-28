<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupply.vo.EmpsecuritysupplyVo" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupply.util.IEmpsecuritysupplyConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IEmpsecuritysupplyConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IEmpsecuritysupplyConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	EmpsecuritysupplyVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/EmpsecuritysupplyAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/EmpsecuritysupplyAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecuritysupply/insertEmpsecuritysupply.jsp";
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
		form.action="<%=request.getContextPath()%>/EmpsecuritysupplyAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EmpsecuritysupplyAction.do">
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
			<td align="right">社保公积金ID</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_security_id" inputName="社保公积金ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">产品ID</td>
			<td align="left">
				<input type="text" class="text_field" name="product_id" inputName="产品ID" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">正常汇缴起始月</td>
			<td align="left">
				<input type="text" class="text_field" name="fund_month" inputName="正常汇缴起始月" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">缴费起始月</td>
			<td align="left">
				<input type="text" class="text_field" name="start_month" inputName="缴费起始月" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">缴费结束月</td>
			<td align="left">
				<input type="text" class="text_field" name="end_month" inputName="缴费结束月" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">补缴类型</td>
			<td align="left">
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("supply_type_bd", -1, gap.rm.project.RmGlobalReference.get(IEmpsecuritysupplyConstants.DICTIONARY_), "", "inputName='补缴类型'", true) %>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">基数</td>
			<td align="left">
				<input type="text" class="text_field_half" name="base_from" inputName="基数" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="base_to" inputName="基数" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="money_from" inputName="金额" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="money_to" inputName="金额" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">企业金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_money_from" inputName="企业金额" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_money_to" inputName="企业金额" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">个人金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_money_from" inputName="个人金额" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_money_to" inputName="个人金额" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">企业滞纳金</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_latefee_from" inputName="企业滞纳金" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_latefee_to" inputName="企业滞纳金" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">个人滞纳金</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_latefee_from" inputName="个人滞纳金" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_latefee_to" inputName="个人滞纳金" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">企业附加金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="e_add_money_from" inputName="企业附加金额" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="e_add_money_to" inputName="企业附加金额" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">个人附加金额</td>
			<td align="left">
				<input type="text" class="text_field_half" name="p_add_money_from" inputName="个人附加金额" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="p_add_money_to" inputName="个人附加金额" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">备注</td>
			<td align="left">
				<input type="text" class="text_field" name="remarks" inputName="备注" maxLength="1000"/>
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
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
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
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_security_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_security_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_security_id")%>">
           	</a>	
       
			 社保公积金ID</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_id")%>">
           	</a>	
       
			 产品ID</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fund_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fund_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fund_month")%>">
           	</a>	
       
			 正常汇缴起始月</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"start_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"start_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"start_month")%>">
           	</a>	
       
			 缴费起始月</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"end_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"end_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"end_month")%>">
           	</a>	
       
			 缴费结束月</th>
			<th>
					
					<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"supply_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"supply_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"supply_type_bd")%>">
           	</a>	
       
	 补缴类型</th>
     	<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"base")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"base")%>">
           	</a>	
       
			 基数</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"money")%>">
           	</a>	
       
			 金额</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_money")%>">
           	</a>	
       
			 企业金额</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_money")%>">
           	</a>	
       
			 个人金额</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_latefee")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_latefee")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_latefee")%>">
           	</a>	
       
			 企业滞纳金</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_latefee")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_latefee")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_latefee")%>">
           	</a>	
       
			 个人滞纳金</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_add_money")%>">
           	</a>	
       
			 企业附加金额</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_add_money")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_add_money")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_add_money")%>">
           	</a>	
       
			 个人附加金额</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remarks")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remarks")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remarks")%>">
           	</a>	
       
			 备注</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 最后修改人</th>
			<th>
							
				 	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			最后修改日期</th>
			<th>
				
			  	<a href="/FAERP/EmpsecuritysupplyAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="emp_security_id"/>   </td>
			
			<td><bean:write name="data" property="product_id"/>   </td>
			
			<td><bean:write name="data" property="fund_month"/>   </td>
			
			<td><bean:write name="data" property="start_month"/>   </td>
			
			<td><bean:write name="data" property="end_month"/>   </td>
			
			<td><bean:write name="data" property="supply_type_bd"/>   </td>		
			<td><bean:write name="data" property="base"/>   </td>
			
			<td><bean:write name="data" property="money"/>   </td>
			
			<td><bean:write name="data" property="e_money"/>   </td>
			
			<td><bean:write name="data" property="p_money"/>   </td>
			
			<td><bean:write name="data" property="e_latefee"/>   </td>
			
			<td><bean:write name="data" property="p_latefee"/>   </td>
			
			<td><bean:write name="data" property="e_add_money"/>   </td>
			
			<td><bean:write name="data" property="p_add_money"/>   </td>
			
			<td><bean:write name="data" property="remarks"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="is_del"/>   </td>
			
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
	if(request.getAttribute(IEmpsecuritysupplyConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEmpsecuritysupplyConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
