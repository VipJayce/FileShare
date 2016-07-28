<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.sample.position.util.IPositionConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Post_Management' bundle='${applicationAuResources}' /></title>
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
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		form.action="<%=request.getContextPath()%>/PositionAction.do?cmd=find&id=" + ids;
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("<fmt:message key='gap.authority.Please_Select_Records' bundle='${applicationAuResources}' />!")
			return;
		}
		if(confirm("<fmt:message key='gap.authority.It_completely_remove_the_data_' bundle='${applicationAuResources}' />")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/PositionAction.do?cmd=deleteMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		form.action="<%=request.getContextPath()%>/PositionAction.do?cmd=simpleQuery";
    	form.submit();
  	}
	function queryAll_onClick(){  //查询全部数据列表
		form.action="<%=request.getContextPath()%>/PositionAction.do?cmd=queryAll";
		form.submit();
	}	
	function toAdd_onClick() {  //到增加记录页面
		window.location="<%=request.getContextPath()%>/jsp/authority/sample/position/insertPosition.jsp";
	}
	function refresh_onClick(){  //刷新本页
		window.location.reload();
	}
	function detail_onClick(thisId){  //实现转到详细页面
		form.id.value = thisId;  //赋值thisId给隐藏值id
		form.action="<%=request.getContextPath()%>/PositionAction.do?cmd=detail&isReadOnly=1";
		form.submit();
	}
	function checkAllList_onClick(thisObj){  //全选，全不选
		if(thisObj.checked) {  //如果选中
			selectAllRows('template');  //全选checkbox
		} else {
			unSelectAllRows('template');  //全不选checkbox
		}
	}
	function clean_onClick() {  //清空查询条件
		form.position_no.value = "";
		form.position_name.value = "";
		form.position_flag.value = "";
		form.leader_flag[0].checked = false;
		form.leader_flag[1].checked = false;
	}
	function getRowHiddenId() {  //从事件取得本行的id
		var thisA = event.srcElement;  //定义事件来源对象
		var thisTr = thisA.parentElement.parentElement.parentElement;  //定义本行的tr对象
		var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
		if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
			return thisHidden.value;
		} else {
			return null;
		}
	}
	function getObjectByNameRecursive(thisObj, thisName) {  //从thisObj递归的取出name是thisName的对象
		var rtHiddenInput = null;  //定义返回的变量
		for(var i=0; i<thisObj.childNodes.length; i++) {  //循环thisObj的字节点
			var tempObj = thisObj.childNodes[i];  //定义当前临时节点
			if(jQuery(tempObj).attr("signName") == thisName) {  //如果当前临时节点的name等于thisName
				rtHiddenInput = tempObj;  //当前临时节点就是返回的对象
				break;  //完成了目标对象的查询,退出循环
			} else {
				rtHiddenInput = getObjectByNameRecursive(tempObj, thisName);  //递归的找自己的子节点
				if(rtHiddenInput != null) {  //如果返回值不为空
					break;  //完成了目标对象的查询,退出循环
				}
			}
		}
		return rtHiddenInput;
	}  
	function view_onClick(){//查看详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		detail_onClick(ids);
	}
</script>
</head>
<body>


<form name="form" method="post" action="">
 
 <input type="hidden" name="id" value="">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('岗位信息管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
				<td width="15%" align="right"><fmt:message key='gap.authority.Post_Code0' bundle='${applicationAuResources}' /></td>
					<td width="35%" align="left">
						<input type="text" class="text_field" validate="isSearch" name="position_no" inputName="<fmt:message key='gap.authority.Post_Code0' bundle='${applicationAuResources}' />" maxLength="50"/>
					</td>
					<td width="15%" align="right"><fmt:message key='gap.authority.Job_Title' bundle='${applicationAuResources}' /></td>
					<td width="35%" align="left">
						<input type="text" class="text_field" validate="isSearch" name="position_name" inputName="<fmt:message key='gap.authority.Job_Title' bundle='${applicationAuResources}' />" maxLength="50"/>
					</td>
			<td align="right"></td>
		</tr>
		<tr>
					<td align="right"><fmt:message key='gap.authority.Post_identity' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="position_flag" inputName="<fmt:message key='gap.authority.Post_identity' bundle='${applicationAuResources}' />" maxLength="50"/>
					</td>
					<td align="right"><fmt:message key='gap.authority.Whether_the_leadership' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="radio" name="leader_flag" inputName="<fmt:message key='gap.authority.Whether_the_leadership' bundle='${applicationAuResources}' />" value="1"><fmt:message key='gap.authority.Be' bundle='${applicationAuResources}' />
						<input type="radio" name="leader_flag" inputName="<fmt:message key='gap.authority.Whether_the_leadership' bundle='${applicationAuResources}' />" value="0"><fmt:message key='gap.authority.No0' bundle='${applicationAuResources}' />
					</td>
			<td align="right"></td>
		</tr>
		
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
        <input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onClickTo="javascript:simpleQuery_onClick()">
						<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Empty' bundle='${applicationAuResources}' />" onClick="javascript:clean_onClick()">
				</td>
            	<td/>
		</tr>
</table>
</div>


 		
					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:view_onClick();"><fmt:message key='gap.authority.View' bundle='${applicationAuResources}' /> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="gap.authority.Added"  bundle='${applicationAuResources}' /> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="gap.authority.Delete"  bundle='${applicationAuResources}' /> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="gap.authority.Modify"  bundle='${applicationAuResources}' /> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" style="background:#f2fbff; overflow: auto;" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>编号</th>
<th> 岗位名称</th>
<th> 岗位标识</th>
<th> 是否领导</th> 
<th> 创建时间</th>	
  
			
			</tr>
<logic:iterate     name="beans"  id="rmBean" scope="request" indexId="indexs">
		<tr>
		<td  >

		<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="checkbox" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
</td>

 
			
			<td><bean:write name="rmBean" property="position_no"/>   </td>
			<td><bean:write name="rmBean" property="position_name"/>   </td>
			<td><bean:write name="rmBean" property="position_flag"/>   </td>
			<td>
				<bean:define id="leader_flag" name="rmBean" property="leader_flag"/>
			    <%="1".equals(leader_flag)?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Be"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.No0")%>
			
			  </td>
		    <td><bean:define id="create_date" name="rmBean" property="create_date"/>
		    	<%=StringHelperTools.prt(create_date,19)%>  </td>
		 
			</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

</div>
</div>
 
</form>


<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%  //表单回写
	if(request.getAttribute(IPositionConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute(IPositionConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
		out.print("</script>");  //输出script的声明结束
	}
%>
	
