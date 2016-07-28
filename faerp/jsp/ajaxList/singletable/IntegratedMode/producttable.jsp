<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import="gap.ajax.function.core.AjaxControl" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%
	AjaxControl ajaxControl = new AjaxControl();
	List list = ajaxControl.getProductsList(1,15);
	request.setAttribute("wy", list);
%>
<script language="javascript">
document.write('<div id="loading" style="background:#CC4444;color:#FFF;width:80px;padding-left:5px;position:absolute;line-height:22px">正在读取...</div>');
</script>
<form name="form" method="post" action="<venus:base/>/AjaxSingleTableAction.do?cmd=queryAll">
<div id="ccParent1"> 
<table class="table_div_control">
	<tr>
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
			查询列表
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table id="dataTable" class="table_div_content" >
	<tbody id="peoplebody" >
    <tr id="pattern" >
		<td>
		<layout:collection name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>'  style="text-align:center;">
				<input type="hidden" name="checkbox_template" value=""/>
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.factory_name")%>' property="factoryid" >
				<bean:define id="wy6" name="wy1" property="factoryid"/>
					<%=ReferenceFilter.get(String.valueOf(wy6))%>
					<input type="hidden" signName="factoryid" value="<%=wy6%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.product_name")%>' property="name" />
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.product_price")%>' property="price" />
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.product_type")%>' property="categoryid" >
				<bean:define id="wy2" name="wy1" property="categoryid"/>
					<%=ReferenceFilter.get("ProductType",String.valueOf(wy2))%>
				<input type="hidden" signName="categoryid" value="<%=wy2%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="12%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.production_date")%>' property="beginDate" >
			<bean:define id="wy7" name="wy1" property="beginDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
			<layout:collectionItem width="12%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.shelf_life_date")%>' property="endDate">
			<bean:define id="wy7" name="wy1" property="endDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
		</layout:collection>
		</td>
	</tr>
	</tbody>
</table>
</div>
</form>