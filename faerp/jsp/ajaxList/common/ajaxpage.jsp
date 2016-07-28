<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tfoot>
		<tr valign="middle">
			<td id="pageDetail" ondblclick="changePageSize(this)">

            </td>
			<td width="25">
				<div id="divFirstPage"></div>
			</td>
			<td width="25">
				<div id="divUpPage"></div>
			</td>
			<td width="25">
				<div id="divDownPage"></div>
			</td>
			<td width="25">
				<div id="divLastPage"></div>
			</td>
		</tr>
	</tfoot>
	</table>
<script language="javascript">

function getMapResult(data){
	pageVo.updatePageVo(data.pageObj);
	fillTable(data.dataList);
	setPageDetail(dwr.util.byId("pageDetail"));
	setPageDiv();
} 

function setPageDetail(tdObj){
    var pageDetail = i18n4ajaxList.page_text(pageVo.currentPage,pageVo.pageCount,pageVo.pageSize,pageVo.recordCount);
    var pageNo = '<input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">';
    var button = '<input name="goAppointedButton" type="button" class="button_ellipse" value="GO" onclick="JavaScript:pageVo.goAppointedPage();" style="width:30px;">'
    tdObj.innerHTML = pageDetail+pageNo+i18n4ajaxList.page+button;
    
    return tdObj;
}

function changePageSize(tdObj){
    var pageSizeObj = '<input name="VENUS_PAGE_SIZE_INPUT" type="text" size="2" onblur="pageVo.setPageSize(this.value)" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">';
    var pageDetail = i18n4ajaxList.page_text(pageVo.currentPage,pageVo.pageCount,pageSizeObj,pageVo.recordCount);
    
    var pageNo = '<input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">';
    var button = '<input name="goAppointedButton" type="button" class="button_ellipse" value="GO" onclick="JavaScript:pageVo.goAppointedPage();" style="width:30px;">'
    tdObj.innerHTML = pageDetail+pageNo+i18n4ajaxList.page+button;
    
    return tdObj;
}
</script>
	
<script language="javascript">
	function setPageDiv(){
		setDivFirstPage();
		setDivUpPage();
		setDivDownPage();
		setDivLastPage();
	}
	function setDivFirstPage(){
		if (pageVo.getCurrentPage() > 1) {
		    divFirstPage.innerHTML = '<a href="JavaScript:pageVo.firstPage();"><img src="<%=request.getContextPath()%>/images/icon_page_frist.gif" width="10" height="12" border="0" alt='+i18n.home+'></a>';
		} else {
			divFirstPage.innerHTML = '<img src="<%=request.getContextPath()%>/images/icon_page_frist1.gif" width="10" height="12" border="0" alt='+i18n.home+'>';
		}
	}

	function setDivUpPage(){
		if (pageVo.getCurrentPage() > 1) {
			divUpPage.innerHTML ='<a href="JavaScript:pageVo.upPage();"><img src="<%=request.getContextPath()%>/images/icon_page_prev.gif" width="7" height="12" border="0" alt='+i18n.previous+'></a>';
		}else{
			divUpPage.innerHTML ='<img src="<%=request.getContextPath()%>/images/icon_page_prev1.gif" width="7" height="12" border="0" alt='+i18n.previous+'>';
		}
	}
	
	function setDivDownPage(){
		if (pageVo.getPageCount()>=pageVo.getCurrentPage()+1) {
			divDownPage.innerHTML ='<a href="JavaScript:pageVo.downPage();"><img src="<%=request.getContextPath()%>/images/icon_page_next.gif" width="7" height="12" border="0" alt='+i18n.next+'></a>';
		}else{
			divDownPage.innerHTML ='<img src="<%=request.getContextPath()%>/images/icon_page_next1.gif" width="7" height="12" border="0" alt='+i18n.next+'>';
		}
	}
	
	function setDivLastPage(){
		if (pageVo.getPageCount()>=pageVo.getCurrentPage()+1) {
			divLastPage.innerHTML ='<a href="JavaScript:pageVo.lastPage();"><img src="<%=request.getContextPath()%>/images/icon_page_last.gif" width="10" height="12" border="0" alt='+i18n.last_page+'></a>';
		}else{
			divLastPage.innerHTML ='<img src="<%=request.getContextPath()%>/images/icon_page_last1.gif" width="10" height="12" border="0" alt='+i18n.last_page+'>';
		}
	}
</script>