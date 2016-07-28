<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<html>
<head>
<title>Tab Pane Demo (WebFX)</title>
<script type="text/javascript" src="js/ajax/tabpanel/local/webfxlayout.js"></script>
<link id="luna-tab-style-sheet" type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/ajax/tabpanel/tab.css" disabled="disabled" />
<link id="webfx-tab-style-sheet" type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/ajax/tabpanel/tab.webfx.css" disabled="disabled" />
<link id="winclassic-tab-style-sheet" type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/ajax/tabpanel/tab.winclassic.css"  disabled="disabled" />
<!-- the id is not needed. It is used here to be able to change css file at runtime -->
<style type="text/css">
.dynamic-tab-pane-control .tab-page {
	height:		200px;
}
.dynamic-tab-pane-control .tab-page .dynamic-tab-pane-control .tab-page {
	height:		100px;
}
.dynamic-tab-pane-control h2 {
	text-align:	center;
	width:		auto;
}
.dynamic-tab-pane-control h2 a {
	display:	inline;
	width:		auto;
}
.dynamic-tab-pane-control a:hover {
	background: transparent;
}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/tabpanel/tabpane.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/UnifiedSubmitAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-masterdetail-unifiedSubmit.js"></script>


<script language="javascript">
var masterFlag="query"; 
var sessionid = "<%=request.getSession().getId()%>";
var basepath = "<venus:base/>";
var masterid = '<%=request.getAttribute("factoryid")%>';


//当前页面初始化时加载子页面和对子页面内的控件进行赋值。
function includeTabPage(param){
	include('masterView_edit',getPageobj('masterView_edit'));
	include('detail1View_list',getPageobj('detail1View_list'));
	include('detail2View_list',getPageobj('detail2View_list'));
	initMDTabPage(param);
}

  	/*
	 *清除OSCache缓存
	 */
  	function clearMasterDetailData_onClick(){
	UnifiedSubmitAjax.clearMasterDetailCache(sessionid);
}

//通过sessionId验证当前用户在缓存中是否有未提交的数据，有，给出提示，无，继续用户的操作
function validateCacheBySessionId(){
	//判断主表是否有修改，有，主表信息和子表信息一起保存。无，继续执行。
	if(masterFlag=="insert" || masterFlag=="update"){
		var r=confirm(i18n4ajaxList.save_the_master_table_data)
		if (r==true)
		{
			var masterVo = getMapFromPage('masterView');
			masterVo.sessionId = sessionid;
			masterVo.state = "insert";
			if(masterFlag =="update"){
				masterVo.state = "update";
			}
			UnifiedSubmitAjax.saveMasterAndDetails(sessionid,'masterDetailBo','masterView',masterVo);
			return;
		}
	}else{
		//判断子表是否有增加，修改和删除的操作，有，保存子表信息，无，继续执行。
		UnifiedSubmitAjax.isExistenceFromCacheBySessionId(sessionid,function(data){
			if(data) {
				var r=confirm(i18n4ajaxList.save_the_detail_table_data)
				if (r==true)
				{
					UnifiedSubmitAjax.updateMasterDetailCache(sessionid,'masterDetailBo');
				}
			}
		});
	}
}

</script>
</head>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<body onload="javascript:clearMasterDetailData_onClick();includeTabPage(masterid);" onbeforeunload="validateCacheBySessionId();">
<script type="text/javascript">
//<![CDATA[

function setLinkSrc( sStyle ) {
	document.getElementById( "luna-tab-style-sheet" ).disabled = sStyle != "luna";
	document.getElementById( "webfx-tab-style-sheet" ).disabled = sStyle != "webfx"
	document.getElementById( "winclassic-tab-style-sheet" ).disabled = sStyle != "winclassic"
	document.documentElement.style.background = 
	document.body.style.background = sStyle == "webfx" ? "white" : "ThreeDFace";
}
setLinkSrc( "webfx" );
//]]>
</script>
<script language="javascript">
	writeTableTop('<fmt:message key="masterdetailtable.single_table"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/MasterDetailAction.do">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="sessionid" value="<%=request.getSession().getId()%>">
<div class="tab-pane" id="tabPane1">
<script type="text/javascript">
tp1 = new WebFXTabPane( document.getElementById( "tabPane1" ) );
tp1.selectedIndex = 0;
</script>
	<div class="tab-page" id="tabPage1">
		<h2 class="tab">主表</h2>
		<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage1" ) );</script>
		<div class="tab-pane" id="tabPane1_1">
			<div id="masterView_edit"></div>
		</div>
	</div>
	<div class="tab-page" id="tabPage2">
		<h2 class="tab">子表一</h2>
		<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage2" ) );</script>
		<div class="tab-pane" id="tabPane2">
		<script type="text/javascript">
			tp1_2 = new WebFXTabPane( document.getElementById( "tabPane2" ) );
		</script>
				<div id="detail1View_list"></div>
		</div>
	</div>
	<div class="tab-page" id="tabPage3">
		<h2 class="tab">子表二</h2>
		<script type="text/javascript">tp1.addTabPage( document.getElementById( "tabPage3" ) );</script>
		<div class="tab-pane" id="tabPane3">
		<script type="text/javascript">
			tp1_3 = new WebFXTabPane( document.getElementById( "tabPane3" ) );
		</script>
				<div id="detail2View_list"></div>
		</div>
	</div>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
<script type="text/javascript">
//<![CDATA[
setupAllTabs();
//]]>
</script>
</body>
</fmt:bundle>
</html>