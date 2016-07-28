<%@ page contentType="text/html; charset=UTF-8" language="java" %>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tfoot>
		<tr valign="middle">
			<td id="pageDetail" ondblclick="changePageSize(this)">当前<span class='page_text01'>0</span>页/共<span class='page_text01'>0</span>页&nbsp;&nbsp;每页<span class='page_text01'>0</span>条/共<span class='page_text01'>0</span>条记录&nbsp;&nbsp;第
	            <input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="x"  style="border:1px solid #90b3cf; margin-right:4px;">页
	            <input name="goAppointedButton" type="button" class="button_ellipse" value="GO" onclick="JavaScript:pageVo.goAppointedPage();" style="width:30px;">
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
	//alert(dwr.util.toDescriptiveString(data, 2));
	pageVo.updatePageVo(data.pageObj);
	fillTable(data.dataList);
	setPageDetail(dwr.util.byId("pageDetail"));
	setPageDiv();
} 

function setPageDetail(tdObj){
    var pageDetail = i18n_dd.page_text(pageVo.currentPage,pageVo.pageCount,pageVo.pageSize,pageVo.recordCount);
    var pageNo = '<input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">';
    var button = '<input name="goAppointedButton" type="button" class="button_ellipse" value="GO" onclick="JavaScript:pageVo.goAppointedPage();" style="width:30px;">'
    tdObj.innerHTML = pageDetail+pageNo+i18n.page+button;
    return tdObj;
}

function changePageSize(tdObj){
    var pageSizeObj = '<input name="VENUS_PAGE_SIZE_INPUT" type="text" size="2" onblur="pageVo.setPageSize(this.value)" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">';
    var pageDetail = i18n_dd.page_text(pageVo.currentPage,pageVo.pageCount,pageSizeObj,pageVo.recordCount);
    
    var pageNo = '<input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">';
    var button = '<input name="goAppointedButton" type="button" class="button_ellipse" value="GO" onclick="JavaScript:pageVo.goAppointedPage();" style="width:30px;">'
    tdObj.innerHTML = pageDetail+pageNo+i18n.page+button;
    
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
		    jQuery("#divFirstPage").html('<a href="JavaScript:pageVo.firstPage();"><img src="<%=request.getContextPath()%>/images/icon_page_frist.gif" width="10" height="12" border="0" alt="首页"></a>');
		} else {
			jQuery("#divFirstPage").html('<img src="<%=request.getContextPath()%>/images/icon_page_frist1.gif" width="10" height="12" border="0" alt="首页">');
		}
	}

	function setDivUpPage(){
		if (pageVo.getCurrentPage() > 1) {
			jQuery("#divUpPage").html('<a href="JavaScript:pageVo.upPage();"><img src="<%=request.getContextPath()%>/images/icon_page_prev.gif" width="7" height="12" border="0" alt="上一页"></a>');
		}else{
			jQuery("#divUpPage").html('<img src="<%=request.getContextPath()%>/images/icon_page_prev1.gif" width="7" height="12" border="0" alt="上一页">');
		}
	}
	
	function setDivDownPage(){
		if (pageVo.getPageCount()>=pageVo.getCurrentPage()+1) {
			jQuery("#divDownPage").html('<a href="JavaScript:pageVo.downPage();"><img src="<%=request.getContextPath()%>/images/icon_page_next.gif" width="7" height="12" border="0" alt="下一页"></a>');
		}else{
			jQuery("#divDownPage").html('<img src="<%=request.getContextPath()%>/images/icon_page_next1.gif" width="7" height="12" border="0" alt="下一页">');
		}
	}
	
	function setDivLastPage(){
		if (pageVo.getPageCount()>=pageVo.getCurrentPage()+1) {
			jQuery("#divLastPage").html('<a href="JavaScript:pageVo.lastPage();"><img src="<%=request.getContextPath()%>/images/icon_page_last.gif" width="10" height="12" border="0" alt="末页"></a>');
		}else{
			jQuery("#divLastPage").html('<img src="<%=request.getContextPath()%>/images/icon_page_last1.gif" width="10" height="12" border="0" alt="末页">');
		}
	}
</script>