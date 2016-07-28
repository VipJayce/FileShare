<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.productbasedata.vo.ProductbasedataVo" %>
<%@ page import="rayoo.system.productbasedata.util.IProductbasedataConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IProductbasedataConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IProductbasedataConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	ProductbasedataVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/productbasedata/insertProductbasedata.jsp";
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
		form.action="<%=request.getContextPath()%>/ProductbasedataAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/ProductbasedataAction.do">
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
			<td align="right">code</td>
			<td align="left">
				<input type="text" class="text_field" name="code" inputName="code" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">typeid</td>
			<td align="left">
				<input type="text" class="text_field" name="typeid" inputName="typeid" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">typecode</td>
			<td align="left">
				<input type="text" class="text_field" name="typecode" inputName="typecode" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">levelnum</td>
			<td align="left">
				<input type="text" class="text_field_half" name="levelnum_from" inputName="levelnum" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="levelnum_to" inputName="levelnum" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">isleaf</td>
			<td align="left">
				<input type="text" class="text_field" name="isleaf" inputName="isleaf" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">name</td>
			<td align="left">
				<input type="text" class="text_field" name="name" inputName="name" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">isbncode</td>
			<td align="left">
				<input type="text" class="text_field" name="isbncode" inputName="isbncode" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">hintcode</td>
			<td align="left">
				<input type="text" class="text_field" name="hintcode" inputName="hintcode" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">status</td>
			<td align="left">
				<input type="text" class="text_field" name="status" inputName="status" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">startdate</td>
			<td align="left">
				<input type="text" class="text_field" name="startdate" inputName="startdate" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">enddate</td>
			<td align="left">
				<input type="text" class="text_field" name="enddate" inputName="enddate" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">description</td>
			<td align="left">
				<input type="text" class="text_field" name="description" inputName="description" maxLength="128"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">treecode</td>
			<td align="left">
				<input type="text" class="text_field" name="treecode" inputName="treecode" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">seqno</td>
			<td align="left">
				<input type="text" class="text_field_half" name="seqno_from" inputName="seqno" value="0 " columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="seqno_to" inputName="seqno" value="0 " columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">createdby</td>
			<td align="left">
				<input type="text" class="text_field" name="createdby" inputName="createdby" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">updatedby</td>
			<td align="left">
				<input type="text" class="text_field" name="updatedby" inputName="updatedby" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">created</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="created_from" id="created_from" inputName="created"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('created_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="created_to" id="created_to" inputName="created"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('created_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">updated</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="updated_from" id="updated_from" inputName="updated"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('updated_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="updated_to" id="updated_to" inputName="updated"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('updated_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">parentid</td>
			<td align="left">
				<input type="text" class="text_field" name="parentid" inputName="parentid" maxLength="32"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">spare1</td>
			<td align="left">
				<input type="text" class="text_field_half" name="spare1_from" inputName="spare1" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="spare1_to" inputName="spare1" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">spare2</td>
			<td align="left">
				<input type="text" class="text_field" name="spare2" inputName="spare2" maxLength="512"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">spare3</td>
			<td align="left">
				<input type="text" class="text_field" name="spare3" inputName="spare3" maxLength="512"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">spare4</td>
			<td align="left">
				<input type="text" class="text_field" name="spare4" inputName="spare4" maxLength="512"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">spare5</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="spare5_from" id="spare5_from" inputName="spare5"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('spare5_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="spare5_to" id="spare5_to" inputName="spare5"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('spare5_to','<venus:base/>/');"/>
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
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"code")%>">
           	</a>	
       
			 code</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"typeid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"typeid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"typeid")%>">
           	</a>	
       
			 typeid</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"typecode")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"typecode")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"typecode")%>">
           	</a>	
       
			 typecode</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"levelnum")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"levelnum")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"levelnum")%>">
           	</a>	
       
			 levelnum</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"isleaf")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"isleaf")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"isleaf")%>">
           	</a>	
       
			 isleaf</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"name")%>">
           	</a>	
       
			 name</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"isbncode")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"isbncode")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"isbncode")%>">
           	</a>	
       
			 isbncode</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"hintcode")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"hintcode")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"hintcode")%>">
           	</a>	
       
			 hintcode</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"status")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"status")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"status")%>">
           	</a>	
       
			 status</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"startdate")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"startdate")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"startdate")%>">
           	</a>	
       
			 startdate</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"enddate")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"enddate")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"enddate")%>">
           	</a>	
       
			 enddate</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"description")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"description")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"description")%>">
           	</a>	
       
			 description</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"treecode")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"treecode")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"treecode")%>">
           	</a>	
       
			 treecode</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"seqno")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"seqno")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"seqno")%>">
           	</a>	
       
			 seqno</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"createdby")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"createdby")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"createdby")%>">
           	</a>	
       
			 createdby</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"updatedby")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"updatedby")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"updatedby")%>">
           	</a>	
       
			 updatedby</th>
			<th>
							
				 	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"created")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"created")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"created")%>">
           	</a>	
       
			created</th>
			<th>
							
				 	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"updated")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"updated")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"updated")%>">
           	</a>	
       
			updated</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"parentid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"parentid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"parentid")%>">
           	</a>	
       
			 parentid</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"spare1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"spare1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"spare1")%>">
           	</a>	
       
			 spare1</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"spare2")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"spare2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"spare2")%>">
           	</a>	
       
			 spare2</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"spare3")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"spare3")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"spare3")%>">
           	</a>	
       
			 spare3</th>
			<th>
				
			  	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"spare4")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"spare4")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"spare4")%>">
           	</a>	
       
			 spare4</th>
			<th>
							
				 	<a href="/FAERP/ProductbasedataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"spare5")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"spare5")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"spare5")%>">
           	</a>	
       
			spare5</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="code"/>   </td>
			
			<td><bean:write name="data" property="typeid"/>   </td>
			
			<td><bean:write name="data" property="typecode"/>   </td>
			
			<td><bean:write name="data" property="levelnum"/>   </td>
			
			<td><bean:write name="data" property="isleaf"/>   </td>
			
			<td><bean:write name="data" property="name"/>   </td>
			
			<td><bean:write name="data" property="isbncode"/>   </td>
			
			<td><bean:write name="data" property="hintcode"/>   </td>
			
			<td><bean:write name="data" property="status"/>   </td>
			
			<td><bean:write name="data" property="startdate"/>   </td>
			
			<td><bean:write name="data" property="enddate"/>   </td>
			
			<td><bean:write name="data" property="description"/>   </td>
			
			<td><bean:write name="data" property="treecode"/>   </td>
			
			<td><bean:write name="data" property="seqno"/>   </td>
			
			<td><bean:write name="data" property="createdby"/>   </td>
			
			<td><bean:write name="data" property="updatedby"/>   </td>
			
			<td><bean:write name="data" property="created"/>   </td>
			<td><bean:write name="data" property="updated"/>   </td>
			<td><bean:write name="data" property="parentid"/>   </td>
			
			<td><bean:write name="data" property="spare1"/>   </td>
			
			<td><bean:write name="data" property="spare2"/>   </td>
			
			<td><bean:write name="data" property="spare3"/>   </td>
			
			<td><bean:write name="data" property="spare4"/>   </td>
			
			<td><bean:write name="data" property="spare5"/>   </td>
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
	if(request.getAttribute(IProductbasedataConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IProductbasedataConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
