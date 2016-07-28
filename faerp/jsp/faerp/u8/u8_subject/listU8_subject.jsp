<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8_subject.vo.U8_subjectVo" %>
<%@ page import="rayoo.u8.u8_subject.util.IU8_subjectConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IU8_subjectConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IU8_subjectConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	U8_subjectVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/U8_subjectAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/U8_subjectAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/u8/u8_subject/insertU8_subject.jsp";
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
		form.action="<%=request.getContextPath()%>/U8_subjectAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/U8_subjectAction.do">
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
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">科目类型</td>
			<td align="left">
				<input type="text" class="text_field" name="cclass" inputName="科目类型" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">科目类型英文名称</td>
			<td align="left">
				<input type="text" class="text_field" name="cclass_engl" inputName="科目类型英文名称" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">财务分析类型</td>
			<td align="left">
				<input type="text" class="text_field" name="cclassany" inputName="财务分析类型" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">财务分析类型英文名称</td>
			<td align="left">
				<input type="text" class="text_field" name="cclassany_engl" inputName="财务分析类型英文名称" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">科目编码</td>
			<td align="left">
				<input type="text" class="text_field" name="ccode" inputName="科目编码" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">科目名称</td>
			<td align="left">
				<input type="text" class="text_field" name="ccode_name" inputName="科目名称" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">科目英文名称</td>
			<td align="left">
				<input type="text" class="text_field" name="ccode_engl" inputName="科目英文名称" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">编码级次</td>
			<td align="left">
				<input type="text" class="text_field_half" name="igrade_from" inputName="编码级次" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="igrade_to" inputName="编码级次" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bproperty</td>
			<td align="left">
				<input type="text" class="text_field_half" name="bproperty_from" inputName="bproperty" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="bproperty_to" inputName="bproperty" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cbook_type</td>
			<td align="left">
				<input type="text" class="text_field" name="cbook_type" inputName="cbook_type" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cbook_type_engl</td>
			<td align="left">
				<input type="text" class="text_field" name="cbook_type_engl" inputName="cbook_type_engl" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">chelp</td>
			<td align="left">
				<input type="text" class="text_field" name="chelp" inputName="chelp" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cexch_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cexch_name" inputName="cexch_name" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cmeasure</td>
			<td align="left">
				<input type="text" class="text_field" name="cmeasure" inputName="cmeasure" maxLength="10"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否个人往来核算</td>
			<td align="left">
				<input type="text" class="text_field" name="bperson" inputName="是否个人往来核算" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否客户往来核算</td>
			<td align="left">
				<input type="text" class="text_field" name="bcus" inputName="是否客户往来核算" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否供应商往来核算</td>
			<td align="left">
				<input type="text" class="text_field" name="bsup" inputName="是否供应商往来核算" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否部门核算</td>
			<td align="left">
				<input type="text" class="text_field" name="bdept" inputName="是否部门核算" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否项目核算</td>
			<td align="left">
				<input type="text" class="text_field" name="bitem" inputName="是否项目核算" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">项目大类编码</td>
			<td align="left">
				<input type="text" class="text_field" name="cass_item" inputName="项目大类编码" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">是否日记账</td>
			<td align="left">
				<input type="text" class="text_field" name="br" inputName="是否日记账" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">be</td>
			<td align="left">
				<input type="text" class="text_field" name="be" inputName="be" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cgather</td>
			<td align="left">
				<input type="text" class="text_field" name="cgather" inputName="cgather" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bend</td>
			<td align="left">
				<input type="text" class="text_field" name="bend" inputName="bend" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bexchange</td>
			<td align="left">
				<input type="text" class="text_field" name="bexchange" inputName="bexchange" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bcash</td>
			<td align="left">
				<input type="text" class="text_field" name="bcash" inputName="bcash" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bbank</td>
			<td align="left">
				<input type="text" class="text_field" name="bbank" inputName="bbank" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bused</td>
			<td align="left">
				<input type="text" class="text_field" name="bused" inputName="bused" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bd_c</td>
			<td align="left">
				<input type="text" class="text_field_half" name="bd_c_from" inputName="bd_c" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="bd_c_to" inputName="bd_c" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dbegin</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="dbegin_from" id="dbegin_from" inputName="dbegin"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dbegin_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="dbegin_to" id="dbegin_to" inputName="dbegin"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dbegin_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">dend</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="dend_from" id="dend_from" inputName="dend"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dend_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="dend_to" id="dend_to" inputName="dend"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('dend_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">itrans</td>
			<td align="left">
				<input type="text" class="text_field_half" name="itrans_from" inputName="itrans" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="itrans_to" inputName="itrans" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bclose</td>
			<td align="left">
				<input type="text" class="text_field" name="bclose" inputName="bclose" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cother</td>
			<td align="left">
				<input type="text" class="text_field" name="cother" inputName="cother" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">iotherused</td>
			<td align="left">
				<input type="text" class="text_field_half" name="iotherused_from" inputName="iotherused" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="iotherused_to" inputName="iotherused" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="1"/>
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
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cclass")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cclass")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cclass")%>">
           	</a>	
       
			 科目类型</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cclass_engl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cclass_engl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cclass_engl")%>">
           	</a>	
       
			 科目类型英文名称</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cclassany")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cclassany")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cclassany")%>">
           	</a>	
       
			 财务分析类型</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cclassany_engl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cclassany_engl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cclassany_engl")%>">
           	</a>	
       
			 财务分析类型英文名称</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ccode")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ccode")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ccode")%>">
           	</a>	
       
			 科目编码</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ccode_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ccode_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ccode_name")%>">
           	</a>	
       
			 科目名称</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ccode_engl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ccode_engl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ccode_engl")%>">
           	</a>	
       
			 科目英文名称</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"igrade")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"igrade")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"igrade")%>">
           	</a>	
       
			 编码级次</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bproperty")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bproperty")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bproperty")%>">
           	</a>	
       
			 bproperty</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cbook_type")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cbook_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cbook_type")%>">
           	</a>	
       
			 cbook_type</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cbook_type_engl")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cbook_type_engl")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cbook_type_engl")%>">
           	</a>	
       
			 cbook_type_engl</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"chelp")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"chelp")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"chelp")%>">
           	</a>	
       
			 chelp</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cexch_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cexch_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cexch_name")%>">
           	</a>	
       
			 cexch_name</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cmeasure")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cmeasure")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cmeasure")%>">
           	</a>	
       
			 cmeasure</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bperson")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bperson")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bperson")%>">
           	</a>	
       
			 是否个人往来核算</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bcus")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bcus")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bcus")%>">
           	</a>	
       
			 是否客户往来核算</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bsup")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bsup")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bsup")%>">
           	</a>	
       
			 是否供应商往来核算</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bdept")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bdept")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bdept")%>">
           	</a>	
       
			 是否部门核算</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bitem")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bitem")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bitem")%>">
           	</a>	
       
			 是否项目核算</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cass_item")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cass_item")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cass_item")%>">
           	</a>	
       
			 项目大类编码</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"br")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"br")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"br")%>">
           	</a>	
       
			 是否日记账</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"be")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"be")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"be")%>">
           	</a>	
       
			 be</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cgather")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cgather")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cgather")%>">
           	</a>	
       
			 cgather</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bend")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bend")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bend")%>">
           	</a>	
       
			 bend</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bexchange")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bexchange")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bexchange")%>">
           	</a>	
       
			 bexchange</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bcash")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bcash")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bcash")%>">
           	</a>	
       
			 bcash</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bbank")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bbank")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bbank")%>">
           	</a>	
       
			 bbank</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bused")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bused")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bused")%>">
           	</a>	
       
			 bused</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bd_c")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bd_c")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bd_c")%>">
           	</a>	
       
			 bd_c</th>
			<th>
							
				 	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dbegin")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dbegin")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dbegin")%>">
           	</a>	
       
			dbegin</th>
			<th>
							
				 	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"dend")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"dend")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"dend")%>">
           	</a>	
       
			dend</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"itrans")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"itrans")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"itrans")%>">
           	</a>	
       
			 itrans</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bclose")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bclose")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bclose")%>">
           	</a>	
       
			 bclose</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cother")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cother")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cother")%>">
           	</a>	
       
			 cother</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"iotherused")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"iotherused")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"iotherused")%>">
           	</a>	
       
			 iotherused</th>
			<th>
				
			  	<a href="/FAERP/U8_subjectAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="cclass"/>   </td>
			
			<td><bean:write name="data" property="cclass_engl"/>   </td>
			
			<td><bean:write name="data" property="cclassany"/>   </td>
			
			<td><bean:write name="data" property="cclassany_engl"/>   </td>
			
			<td><bean:write name="data" property="ccode"/>   </td>
			
			<td><bean:write name="data" property="ccode_name"/>   </td>
			
			<td><bean:write name="data" property="ccode_engl"/>   </td>
			
			<td><bean:write name="data" property="igrade"/>   </td>
			
			<td><bean:write name="data" property="bproperty"/>   </td>
			
			<td><bean:write name="data" property="cbook_type"/>   </td>
			
			<td><bean:write name="data" property="cbook_type_engl"/>   </td>
			
			<td><bean:write name="data" property="chelp"/>   </td>
			
			<td><bean:write name="data" property="cexch_name"/>   </td>
			
			<td><bean:write name="data" property="cmeasure"/>   </td>
			
			<td><bean:write name="data" property="bperson"/>   </td>
			
			<td><bean:write name="data" property="bcus"/>   </td>
			
			<td><bean:write name="data" property="bsup"/>   </td>
			
			<td><bean:write name="data" property="bdept"/>   </td>
			
			<td><bean:write name="data" property="bitem"/>   </td>
			
			<td><bean:write name="data" property="cass_item"/>   </td>
			
			<td><bean:write name="data" property="br"/>   </td>
			
			<td><bean:write name="data" property="be"/>   </td>
			
			<td><bean:write name="data" property="cgather"/>   </td>
			
			<td><bean:write name="data" property="bend"/>   </td>
			
			<td><bean:write name="data" property="bexchange"/>   </td>
			
			<td><bean:write name="data" property="bcash"/>   </td>
			
			<td><bean:write name="data" property="bbank"/>   </td>
			
			<td><bean:write name="data" property="bused"/>   </td>
			
			<td><bean:write name="data" property="bd_c"/>   </td>
			
			<td><bean:write name="data" property="dbegin"/>   </td>
			<td><bean:write name="data" property="dend"/>   </td>
			<td><bean:write name="data" property="itrans"/>   </td>
			
			<td><bean:write name="data" property="bclose"/>   </td>
			
			<td><bean:write name="data" property="cother"/>   </td>
			
			<td><bean:write name="data" property="iotherused"/>   </td>
			
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
	if(request.getAttribute(IU8_subjectConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IU8_subjectConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
