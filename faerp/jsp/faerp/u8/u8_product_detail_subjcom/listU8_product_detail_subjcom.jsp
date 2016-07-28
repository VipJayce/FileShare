<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8_product_detail_subjcom.vo.U8_product_detail_subjcomVo" %>
<%@ page import="rayoo.u8.u8_product_detail_subjcom.util.IU8_product_detail_subjcomConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IU8_product_detail_subjcomConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IU8_product_detail_subjcomConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	U8_product_detail_subjcomVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/u8/u8_product_detail_subjcom/insertU8_product_detail_subjcom.jsp";
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
		form.action="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do">
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
			<td align="right">分公司</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="分公司" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">部门编码(party_id)</td>
			<td align="left">
				<input type="text" class="text_field" name="dept_id" inputName="部门编码(party_id)" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">科目编码</td>
			<td align="left">
				<input type="text" class="text_field" name="subjcode" inputName="科目编码" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">对照生效日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="startend_from" id="startend_from" inputName="对照生效日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('startend_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="startend_to" id="startend_to" inputName="对照生效日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('startend_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">对照截止日期</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="enddate_from" id="enddate_from" inputName="对照截止日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('enddate_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="enddate_to" id="enddate_to" inputName="对照截止日期"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('enddate_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">备注</td>
			<td align="left">
				<input type="text" class="text_field" name="mark" inputName="备注" maxLength="100"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否删除 0:正常　1:删除</td>
			<td align="left">
				<input type="text" class="text_field" name="id_del" inputName="是否删除 0:正常　1:删除" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">一级科目对照主键</td>
			<td align="left">
				<input type="text" class="text_field" name="product_master_subjcom_id" inputName="一级科目对照主键" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">上级节点的主键</td>
			<td align="left">
				<input type="text" class="text_field" name="parent_id" inputName="上级节点的主键" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">级别(树结构的层次级别 2级开始 )</td>
			<td align="left">
				<input type="text" class="text_field" name="type_level" inputName="级别(树结构的层次级别 2级开始 )" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">下级节点主键</td>
			<td align="left">
				<input type="text" class="text_field" name="child_id" inputName="下级节点主键" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">0 借方 1贷方</td>
			<td align="left">
				<input type="text" class="text_field" name="classtype" inputName="0 借方 1贷方" maxLength="1"/>
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
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 分公司</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dept_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dept_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dept_id")%>">
           	</a>	
       
			 部门编码(party_id)</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"subjcode")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"subjcode")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"subjcode")%>">
           	</a>	
       
			 科目编码</th>
			<th>
							
				 	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"startend")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"startend")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"startend")%>">
           	</a>	
       
			对照生效日期</th>
			<th>
							
				 	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"enddate")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"enddate")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"enddate")%>">
           	</a>	
       
			对照截止日期</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"mark")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"mark")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"mark")%>">
           	</a>	
       
			 备注</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_del")%>">
           	</a>	
       
			 是否删除 0:正常　1:删除</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_master_subjcom_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_master_subjcom_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_master_subjcom_id")%>">
           	</a>	
       
			 一级科目对照主键</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"parent_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"parent_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"parent_id")%>">
           	</a>	
       
			 上级节点的主键</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"type_level")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"type_level")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"type_level")%>">
           	</a>	
       
			 级别(树结构的层次级别 2级开始 )</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"child_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"child_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"child_id")%>">
           	</a>	
       
			 下级节点主键</th>
			<th>
				
			  	<a href="/FAERP/U8_product_detail_subjcomAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"classtype")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"classtype")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"classtype")%>">
           	</a>	
       
			 0 借方 1贷方</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="dept_id"/>   </td>
			
			<td><bean:write name="data" property="subjcode"/>   </td>
			
			<td><bean:write name="data" property="startend"/>   </td>
			<td><bean:write name="data" property="enddate"/>   </td>
			<td><bean:write name="data" property="mark"/>   </td>
			
			<td><bean:write name="data" property="id_del"/>   </td>
			
			<td><bean:write name="data" property="product_master_subjcom_id"/>   </td>
			
			<td><bean:write name="data" property="parent_id"/>   </td>
			
			<td><bean:write name="data" property="type_level"/>   </td>
			
			<td><bean:write name="data" property="child_id"/>   </td>
			
			<td><bean:write name="data" property="classtype"/>   </td>
			
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
	if(request.getAttribute(IU8_product_detail_subjcomConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IU8_product_detail_subjcomConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
