<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
 <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>  
 <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script> 
 <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList.js"></script>
 <fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<title>查询模板</title>
	<%
	String factoryidClone=(String)request.getAttribute("factoryidclone");
	String nameClone=(String)request.getAttribute("nameclone");
	%>
<script>
	var flag="";
	function simpleQuery_onClick(){  //简单的模糊查询
//		form.queryCondition.value = buildQueryCondition();
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function detail_onClick(thisId){
		form.action = "<venus:base/>/AjaxSingleTableAction.do?cmd=find&ids=" + thisId;
		form.submit();
	}
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids += "'" + elementCheckbox[i].value + "',";
			}
		}
		if(ids.length>0) {
			ids = ids.substr(0,ids.length-1);	
		}
		if(number == 0) {
	  		alert(i18n.please_choose_record_to_delete);
	  		return;
		}
		if(confirm(i18n.confirm_to_delete_record)) {
	    	form.action="<venus:base/>/AjaxSingleTableAction.do?cmd=delete&ids=" + ids;
    		form.submit();
		}
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	
	
	/*ajax代码*/
	//工厂列表参照
	function getFactoryList() {
	    var event = window.event?window.event:getFactoryList.caller.arguments[0];
        var obj = window.showModalDialog('<venus:base/>/jsp/ajaxList/singletable/reference.jsp?flag=factory','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
        if(obj) {
			document.form.factoryName.value = obj[1];
			document.form.factoryid.value = obj[0];
		}
	}
	//载入查询页面
	function toQuery_onClick(){
		if(flag=="query"){
			return;
		}
		var div=document.getElementById("ccParent0");
		div.innerHTML="";
		var pageobj="/jsp/ajaxList/singletable/IndependentMode/query.jsp";
		AjaxControl.getInclude(pageobj,function(data) {dwr.util.setValue('ccParent0', data, { escapeHtml:false });});
		flag="query";
	}
	//载入新增页面
	function includeAddPage(){
		var div=document.getElementById("ccParent0");
		div.innerHTML="";
		var pageobj="/jsp/ajaxList/singletable/IndependentMode/insert.jsp";
		AjaxControl.getInclude(pageobj,function(data) {dwr.util.setValue('ccParent0', data, { escapeHtml:false });AjaxControl.getEnumList("ProductType",function(data){setSelect(data,"categoryid");});});
	}
	//载入修改页面页面
	function includeEditPage(ids){
		var div=document.getElementById("ccParent0");
		div.innerHTML="";
		var pageobj="/jsp/ajaxList/singletable/IndependentMode/insert.jsp";
		AjaxControl.getInclude(pageobj,function(data) {
										dwr.util.setValue('ccParent0', data, { escapeHtml:false });
										AjaxControl.getEnumList("ProductType",function(data){setSelect(data,"categoryid");});
										AjaxControl.findProduct(ids,setForms);});
	}
  	//点击添加按钮
  	function toAdd_onClick(){
  		if(flag=="add"){
  			return;
  		}
  		includeAddPage();
  		flag="add";
  	}
  	function insert_onClick(){  
  	     if(checkAllForms()){
		        var id=document.getElementById("productid");
		        if(id.value==""){
		            form.action = "<venus:base/>/AjaxSingleTableAction.do?cmd=insert";
		        }else{
		            form.action = "<venus:base/>/AjaxSingleTableAction.do?cmd=update";
		        }
		        form.submit();
  	     }
  	}
  	function findCheckbox_onClick(ids) {  //从多选框到修改页面
  		if(flag=="find" || flag=="add"){
  			AjaxControl.findProduct(ids,setForms);
  			flag="find";
  			return;
  		}
		includeEditPage(ids);
		flag="find";
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="singletable.IndependentMode.single_table"/>','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/AjaxSingleTableAction.do">
<input type="hidden" name="cmd" value="queryAll">

<input type="hidden" name="factoryidclone" value="<%=factoryidClone%>">
<input type="hidden" name="nameclone" value="<%=nameClone%>">
<!-- 查询开始 -->
<div id="ccParent0"> 


</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message  key="table.detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toQuery_onClick();"><img src="<venus:base/>/images/icon/search.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="query"/></td>
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="refresh"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection onRowDblClick="findCheckbox_onClick(getRowHiddenId(event))" name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="productid"/>
					<input type="checkbox" name="checkbox_template" value="<%=wy3%>"/>
					<input type="hidden" signName="hiddenId" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
		
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.factory_name")%>' property="factoryid" sortable="true">
				<bean:define id="wy6" name="wy1" property="factoryid"/>
					<%=ReferenceFilter.get(String.valueOf(wy6))%>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.product_name")%>' property="name" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.product_price")%>' property="price" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.product_type")%>' property="categoryid" sortable="true">
				<bean:define id="wy2" name="wy1" property="categoryid"/>
					<%=ReferenceFilter.get("ProductType",String.valueOf(wy2))%>
			</layout:collectionItem>
			<layout:collectionItem width="12%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.production_date")%>' property="beginDate" sortable="true">
			<bean:define id="wy7" name="wy1" property="beginDate"/>
					<%
						java.text.SimpleDateFormat  formatBeginDate = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(formatBeginDate.format(formatBeginDate.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
			<layout:collectionItem width="12%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.shelf_life_date")%>' property="endDate" sortable="true">
			<bean:define id="wy7" name="wy1" property="endDate"/>
					<%
						java.text.SimpleDateFormat  formatEndDate = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(formatEndDate.format(formatEndDate.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>