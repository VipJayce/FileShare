<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/css/gap-css.jsp" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/dd/folderDocTree.js" type=text/javascript></script>
<title>案例库</title>
</head>
<body onLoad="init_onLoad()">
<table width="175" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top" nowrap>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#AFAFAF">
			<tr>
				<td valign="top" bgcolor="#F1F8FB" nowrap>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="center">
							<img title="刷新" onClick="location.reload();" src="<%=request.getContextPath()%>/images/dd/refreshTree.gif" class="div_control_image">&nbsp;&nbsp;
							<img title="全部展开" onClick="expandAllNode()" src="<%=request.getContextPath()%>/images/dd/expandall.gif" class="div_control_image">&nbsp;&nbsp;
							<img title="全部折叠" onClick="collapseAllNode();" src="<%=request.getContextPath()%>/images/dd/collapseall.gif" class="div_control_image">
						</td>
					</tr>
					<tr>
						<td valign="top">
<script language="javascript">
function expandAllNode() {
	for(var i=0; i<indexOfEntries.length; i++) {
		//try {
			if(indexOfEntries[i].setState != null) {
				indexOfEntries[i].setState(true);
			}
	
		//} catch(e) { }
	
	}
}

function collapseAllNode() {
	//try {
		indexOfEntries[0].setState(false);
	//} catch(e) { }
}

var USETEXTLINKS = 1;
var STARTALLOPEN = 1;
classPath = "<%=request.getContextPath()%>/js/newtree/icon/";
ftv2blank = "ftv2blank.gif";
ftv2doc = "ftv2doc.gif";
ftv2folderclosed = "ftv2folderclosed.gif";
ftv2folderopen = "ftv2folderopen.gif";
ftv2lastnode = "ftv2lastnode.gif";
ftv2link = "ftv2link.gif";
ftv2mlastnode = "ftv2mlastnode.gif";
ftv2mnode = "ftv2mnode.gif";
ftv2node = "ftv2node.gif";
ftv2plastnode = "ftv2plastnode.gif";
ftv2pnode = "ftv2pnode.gif";
ftv2vertline = "tv2vertline.gif";
basefrm="contentFrame";

foldersTree = gFld("&nbsp;案例库","","diffFolder.gif","diffFolder-0.gif");

codeGenerationRoot = insFld(foldersTree, gFld ("&nbsp;案例展示", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));

<!--IAmHere-->

		codeGenerationjmmda = insFld(codeGenerationRoot, gFld ("&nbsp;加贸主子表管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		codeGenerationjmmda_detail = insDoc(codeGenerationjmmda, gLnk("0","&nbsp;加贸主子表A", encodeURI('<%=request.getContextPath()%>/jsp/dd/scenario/jmerp/mda/list.jsp?moduleName=加贸主子表A&tableView=ERPCustomiseTableview&detailView=ERPCustomiseEditview&queryView=ERPCustomiseQueryview&toolView=ERPCustomiseToolview'), "ftv2link.gif"));
		codeGenerationjmmdb_detail = insDoc(codeGenerationjmmda, gLnk("0","&nbsp;加贸主子表B", encodeURI('<%=request.getContextPath()%>/jsp/dd/scenario/jmerp/mdb/list.jsp?moduleName=加贸主子表B&tableView=ERPCustomiseTableview&detailView=ERPCustomiseEditview&queryView=ERPCustomiseQueryview&toolView=ERPCustomiseToolview'), "ftv2link.gif"));
		
		codeGenerationtemplate = insFld(codeGenerationRoot, gFld ("&nbsp;标准普通模板管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		codeGenerationcommonTemplate = insDoc(codeGenerationtemplate, gLnk("0","&nbsp;标准普通模板", encodeURI('<%=request.getContextPath()%>/jsp/dd/scenario/template/commonTemplate/list.jsp?moduleName=标准普通模板&tableView=ERP_Core_Country_Listview&detailView=ERP_Core_Country_Editview&queryView=ERP_Core_Country_Queryview&toolView=ERP_Core_Country_Toolview'), "ftv2link.gif"));
	
	
			
/* 数据字典类型生成在功能树中 */

initializeDocument();
</script>

						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
