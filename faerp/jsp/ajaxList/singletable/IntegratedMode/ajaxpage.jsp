<%@ page contentType="text/html; charset=UTF-8" language="java" %>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tfoot>
		<tr valign="middle">
			<td id="pageDetail" ondblclick="changePageSize(this)">当前<span class='page_text01'>0</span>页/共<span class='page_text01'>0</span>页&nbsp;&nbsp;每页<span class='page_text01'>0</span>条/共<span class='page_text01'>0</span>条记录&nbsp;&nbsp;第
	            <input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="x"  style="border:1px solid #90b3cf; margin-right:4px;">页
	            <input name="goAppointedButton" type="button" class="button_ellipse" value="GO" onclick="JavaScript:pageVo.goAppointedPage();" style="width:30px;">
            </td>
			<td width="25"><a href="JavaScript:pageVo.firstPage();"><img src="<%=request.getContextPath()%>/images/icon_page_frist.gif" width="10" height="12" border='0' alt="首页"></a></td>
			<td width="25"><a href="JavaScript:pageVo.upPage();"><img src="<%=request.getContextPath()%>/images/icon_page_prev.gif" width="7" height="12" border='0' alt="上一页"></a></td>
			<td width="25"><a href="JavaScript:pageVo.downPage();"><img src="<%=request.getContextPath()%>/images/icon_page_next.gif" width="7" height="12" border='0' alt="下一页"></a></td>
			<td width="25"><a href="JavaScript:pageVo.lastPage();"><img src="<%=request.getContextPath()%>/images/icon_page_last.gif" width="10" height="12" border='0' alt="末页"></a></td>
		</tr>
	</tfoot>
	</table>
<script language="javascript">

function getMapResult(data){
	//alert(dwr.util.toDescriptiveString(data, 2));
	pageVo.updatePageVo(data.pageObj);
	fillTable(data.dataList);
	setPageDetail($("pageDetail"));
} 

function setPageDetail(tdObj){
	var pageDetail = "当前<span class='page_text01'>"+pageVo.currentPage+"</span>页/共<span class='page_text01'>"+pageVo.pageCount+"</span>页&nbsp;&nbsp;每页<span class='page_text01'>"+pageVo.pageSize+"</span>条/共<span class='page_text01'>"+pageVo.recordCount+"</span>条记录&nbsp;&nbsp;转到"
	var pageNo = document.createElement('<input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">');
	//var pageGoButton = tdObj.lastChild;
	if(tdObj.childNodes.length==13){
		tdObj.innerHTML = pageDetail+pageNo.outerHTML+"页"+tdObj.childNodes[11].outerHTML;
	}else{
		tdObj.innerHTML = pageDetail+pageNo.outerHTML+"页"+tdObj.lastChild.outerHTML;
	}
	return tdObj;
}

function changePageSize(tdObj){
	var pageSizeObj = document.createElement('<input name="VENUS_PAGE_SIZE_INPUT" type="text" size="2" onblur="pageVo.setPageSize(this.value)" maxlength="10" value="">');
	var pageDetail = "当前<span class='page_text01'>"+pageVo.currentPage+"</span>页/共<span class='page_text01'>"+pageVo.pageCount+"</span>页&nbsp;&nbsp;每页<span class='page_text01'>"+pageSizeObj.outerHTML+"</span>条/共<span class='page_text01'>"+pageVo.recordCount+"</span>条记录&nbsp;&nbsp;转到"
	var pageNo = document.createElement('<input name="VENUS_PAGE_NO_KEY_INPUT" type="text" size="2" maxlength="10" value="" style="border:1px solid #90b3cf; margin-right:4px;">');
	//var pageGoButton = tdObj.lastChild;
	tdObj.innerHTML = pageDetail+pageNo.outerHTML+"页"+tdObj.childNodes[11].outerHTML;
	return tdObj;
}
</script>
