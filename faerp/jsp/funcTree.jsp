<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/css/gap-css.jsp" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/tree/folderDocTree.js" type=text/javascript></script>
<title>代码生成框架</title>
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
							<img title="刷新" onClick="location.reload();" src="<%=request.getContextPath()%>/images/icon/refreshTree.gif" class="div_control_image">&nbsp;&nbsp;
							<img title="全部展开" onClick="expandAllNode()" src="<%=request.getContextPath()%>/images/icon/expandall.gif" class="div_control_image">&nbsp;&nbsp;
							<img title="全部折叠" onClick="collapseAllNode();" src="<%=request.getContextPath()%>/images/icon/collapseall.gif" class="div_control_image">
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
classPath = "<%=request.getContextPath()%>/js/tree/icon/";
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

foldersTree = gFld("&nbsp;我的工作台","","diffFolder.gif","diffFolder-0.gif");

rmCodeGenerationRoot = insFld(foldersTree, gFld ("&nbsp;生成的代码", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));

<!--IAmHere-->

		/* PPS_ERP_SA_DATA_ERR生成在功能树中 */
		rmCodeGenerationPpsSaDataErr = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PPS_ERP_SA_DATA_ERR管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPpsSaDataErr_maintenance = insDoc(rmCodeGenerationPpsSaDataErr, gLnk("0","&nbsp;维护PPS_ERP_SA_DATA_ERR", "<%=request.getContextPath()%>/PpsSaDataErrAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PPS帐套与ERP薪资类别对应表生成在功能树中 */
		rmCodeGenerationPps_erp_salary_relation = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PPS帐套与ERP薪资类别对应表管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPps_erp_salary_relation_maintenance = insDoc(rmCodeGenerationPps_erp_salary_relation, gLnk("0","&nbsp;维护PPS帐套与ERP薪资类别对应表", "<%=request.getContextPath()%>/Pps_erp_salary_relationAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PPS帐套项目与ERP薪资项目映射表生成在功能树中 */
		rmCodeGenerationPps_erp_saitem_relation = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PPS帐套项目与ERP薪资项目映射表管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPps_erp_saitem_relation_maintenance = insDoc(rmCodeGenerationPps_erp_saitem_relation, gLnk("0","&nbsp;维护PPS帐套项目与ERP薪资项目映射表", "<%=request.getContextPath()%>/Pps_erp_saitem_relationAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PPS客户与ERP客户关联生成在功能树中 */
		rmCodeGenerationPps_erp_cust_relation = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PPS客户与ERP客户关联管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPps_erp_cust_relation_maintenance = insDoc(rmCodeGenerationPps_erp_cust_relation, gLnk("0","&nbsp;维护PPS客户与ERP客户关联", "<%=request.getContextPath()%>/Pps_erp_cust_relationAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PPS客户与PPS复核客户对应表生成在功能树中 */
		rmCodeGenerationPps_au_party_check_relation = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PPS客户与PPS复核客户对应表管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPps_au_party_check_relation_maintenance = insDoc(rmCodeGenerationPps_au_party_check_relation, gLnk("0","&nbsp;维护PPS客户与PPS复核客户对应表", "<%=request.getContextPath()%>/Pps_au_party_check_relationAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* IBD_CREDENTIALS_STEP生成在功能树中 */
		rmCodeGenerationIbdCredentialStep = insFld(rmCodeGenerationRoot, gFld ("&nbsp;IBD_CREDENTIALS_STEP管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationIbdCredentialStep_maintenance = insDoc(rmCodeGenerationIbdCredentialStep, gLnk("0","&nbsp;维护IBD_CREDENTIALS_STEP", "<%=request.getContextPath()%>/IbdCredentialStepAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* job_orderchargeparam生成在功能树中 */
		rmCodeGenerationJob_orderchargeparam = insFld(rmCodeGenerationRoot, gFld ("&nbsp;job_orderchargeparam管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationJob_orderchargeparam_maintenance = insDoc(rmCodeGenerationJob_orderchargeparam, gLnk("0","&nbsp;维护job_orderchargeparam", "<%=request.getContextPath()%>/Job_orderchargeparamAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* job_orderchargemiditem生成在功能树中 */
		rmCodeGenerationJob_orderchargemiditem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;job_orderchargemiditem管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationJob_orderchargemiditem_maintenance = insDoc(rmCodeGenerationJob_orderchargemiditem, gLnk("0","&nbsp;维护job_orderchargemiditem", "<%=request.getContextPath()%>/Job_orderchargemiditemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* job_orderchargebigitem生成在功能树中 */
		rmCodeGenerationJob_orderchargebigitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;job_orderchargebigitem管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationJob_orderchargebigitem_maintenance = insDoc(rmCodeGenerationJob_orderchargebigitem, gLnk("0","&nbsp;维护job_orderchargebigitem", "<%=request.getContextPath()%>/Job_orderchargebigitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* job_orderchargetransferset生成在功能树中 */
		rmCodeGenerationJob_orderchargetransferset = insFld(rmCodeGenerationRoot, gFld ("&nbsp;job_orderchargetransferset管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationJob_orderchargetransferset_maintenance = insDoc(rmCodeGenerationJob_orderchargetransferset, gLnk("0","&nbsp;维护job_orderchargetransferset", "<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* agentempaccount生成在功能树中 */
		rmCodeGenerationAgentempaccount = insFld(rmCodeGenerationRoot, gFld ("&nbsp;agentempaccount管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentempaccount_maintenance = insDoc(rmCodeGenerationAgentempaccount, gLnk("0","&nbsp;维护agentempaccount", "<%=request.getContextPath()%>/AgentempaccountAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* agentempaccount生成在功能树中 */
		rmCodeGeneration = insFld(rmCodeGenerationRoot, gFld ("&nbsp;agentempaccount管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGeneration_maintenance = insDoc(rmCodeGeneration, gLnk("0","&nbsp;维护agentempaccount", "<%=request.getContextPath()%>/Action.do?cmd=queryAll", "ftv2link.gif"));
	
		/* IBD_CONTRACT_PRODUCT_EMP生成在功能树中 */
		rmCodeGenerationIbdContractProductEmp = insFld(rmCodeGenerationRoot, gFld ("&nbsp;IBD_CONTRACT_PRODUCT_EMP管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationIbdContractProductEmp_maintenance = insDoc(rmCodeGenerationIbdContractProductEmp, gLnk("0","&nbsp;维护IBD_CONTRACT_PRODUCT_EMP", "<%=request.getContextPath()%>/IbdContractProductEmpAction.do?cmd=queryAll", "ftv2link.gif"));
	


		/* JOB_RECRUITREWARD生成在功能树中 */
		rmCodeGenerationRecruitreward = insFld(rmCodeGenerationRoot, gFld ("&nbsp;JOB_RECRUITREWARD管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationRecruitreward_maintenance = insDoc(rmCodeGenerationRecruitreward, gLnk("0","&nbsp;维护JOB_RECRUITREWARD", "<%=request.getContextPath()%>/RecruitrewardAction.do?cmd=queryAll", "ftv2link.gif"));
	


		/* CS_CREDENTIALS_MATERIA生成在功能树中 */
		rmCodeGenerationCredentialsMateria = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_CREDENTIALS_MATERIA管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationCredentialsMateria_maintenance = insDoc(rmCodeGenerationCredentialsMateria, gLnk("0","&nbsp;维护CS_CREDENTIALS_MATERIA", "<%=request.getContextPath()%>/CredentialsMateriaAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* CS_CREDENTIALS_TYPE生成在功能树中 */
		rmCodeGenerationCredentialsType = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_CREDENTIALS_TYPE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationCredentialsType_maintenance = insDoc(rmCodeGenerationCredentialsType, gLnk("0","&nbsp;维护CS_CREDENTIALS_TYPE", "<%=request.getContextPath()%>/CredentialsTypeAction.do?cmd=queryAll", "ftv2link.gif"));
	

		/* JOB_CANDIDATE生成在功能树中 */
		rmCodeGenerationJobcandidate = insFld(rmCodeGenerationRoot, gFld ("&nbsp;JOB_CANDIDATE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationJobcandidate_maintenance = insDoc(rmCodeGenerationJobcandidate, gLnk("0","&nbsp;维护JOB_CANDIDATE", "<%=request.getContextPath()%>/JobcandidateAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* JOB_CANDIDATE生成在功能树中 */
		rmCodeGeneration = insFld(rmCodeGenerationRoot, gFld ("&nbsp;JOB_CANDIDATE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGeneration_maintenance = insDoc(rmCodeGeneration, gLnk("0","&nbsp;维护JOB_CANDIDATE", "<%=request.getContextPath()%>/Action.do?cmd=queryAll", "ftv2link.gif"));
	
		/* JOB_CANDIDATE生成在功能树中 */
		rmCodeGeneration = insFld(rmCodeGenerationRoot, gFld ("&nbsp;JOB_CANDIDATE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGeneration_maintenance = insDoc(rmCodeGeneration, gLnk("0","&nbsp;维护JOB_CANDIDATE", "<%=request.getContextPath()%>/Action.do?cmd=queryAll", "ftv2link.gif"));
	

		/* JOB_ADVISER生成在功能树中 */
		rmCodeGenerationJob_adviser = insFld(rmCodeGenerationRoot, gFld ("&nbsp;JOB_ADVISER管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationJob_adviser_maintenance = insDoc(rmCodeGenerationJob_adviser, gLnk("0","&nbsp;维护JOB_ADVISER", "<%=request.getContextPath()%>/Job_adviserAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SERVICE_ITEM生成在功能树中 */
		rmCodeGenerationServiceitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SERVICE_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationServiceitem_maintenance = insDoc(rmCodeGenerationServiceitem, gLnk("0","&nbsp;维护SERVICE_ITEM", "<%=request.getContextPath()%>/ServiceitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_INVOICE生成在功能树中 */
		rmCodeGenerationAgentInvoice = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_INVOICE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentInvoice_maintenance = insDoc(rmCodeGenerationAgentInvoice, gLnk("0","&nbsp;维护AGENT_INVOICE", "<%=request.getContextPath()%>/AgentInvoiceAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_SECURITY_PRODUCT生成在功能树中 */
		rmCodeGenerationAgentsecurityproduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_SECURITY_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentsecurityproduct_maintenance = insDoc(rmCodeGenerationAgentsecurityproduct, gLnk("0","&nbsp;维护AGENT_SECURITY_PRODUCT", "<%=request.getContextPath()%>/AgentsecurityproductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_SECURITY_PRODUCT生成在功能树中 */
		rmCodeGenerationAGENT_SECURITY_PRODUCT = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_SECURITY_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAGENT_SECURITY_PRODUCT_maintenance = insDoc(rmCodeGenerationAGENT_SECURITY_PRODUCT, gLnk("0","&nbsp;维护AGENT_SECURITY_PRODUCT", "<%=request.getContextPath()%>/AGENT_SECURITY_PRODUCTAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PROJECTBOOK生成在功能树中 */
		rmCodeGenerationDetailprojectbook = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PROJECTBOOK管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationDetailprojectbook_maintenance = insDoc(rmCodeGenerationDetailprojectbook, gLnk("0","&nbsp;维护AGENT_PROJECTBOOK", "<%=request.getContextPath()%>/DetailprojectbookAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PB_SERVICE_PRODUCT生成在功能树中 */
		rmCodeGenerationAgentpbserviceproduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PB_SERVICE_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentpbserviceproduct_maintenance = insDoc(rmCodeGenerationAgentpbserviceproduct, gLnk("0","&nbsp;维护AGENT_PB_SERVICE_PRODUCT", "<%=request.getContextPath()%>/AgentpbserviceproductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PB_SERVICE_ITEM生成在功能树中 */
		rmCodeGenerationAgentpbserviceitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PB_SERVICE_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentpbserviceitem_maintenance = insDoc(rmCodeGenerationAgentpbserviceitem, gLnk("0","&nbsp;维护AGENT_PB_SERVICE_ITEM", "<%=request.getContextPath()%>/AgentpbserviceitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_CONTACT_PERSON生成在功能树中 */
		rmCodeGenerationAgentcontactperson = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_CONTACT_PERSON管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentcontactperson_maintenance = insDoc(rmCodeGenerationAgentcontactperson, gLnk("0","&nbsp;维护AGENT_CONTACT_PERSON", "<%=request.getContextPath()%>/AgentcontactpersonAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PROJECTBOOK生成在功能树中 */
		rmCodeGenerationAgentprojectbook = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PROJECTBOOK管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentprojectbook_maintenance = insDoc(rmCodeGenerationAgentprojectbook, gLnk("0","&nbsp;维护AGENT_PROJECTBOOK", "<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PB_SERVICE_ITEM生成在功能树中 */
		rmCodeGenerationAgentpbitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PB_SERVICE_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentpbitem_maintenance = insDoc(rmCodeGenerationAgentpbitem, gLnk("0","&nbsp;维护AGENT_PB_SERVICE_ITEM", "<%=request.getContextPath()%>/AgentpbitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PB_SERVICE_PRODUCT生成在功能树中 */
		rmCodeGenerationAgentpbproduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PB_SERVICE_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentpbproduct_maintenance = insDoc(rmCodeGenerationAgentpbproduct, gLnk("0","&nbsp;维护AGENT_PB_SERVICE_PRODUCT", "<%=request.getContextPath()%>/AgentpbproductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_PB_TEMPLETE生成在功能树中 */
		rmCodeGenerationAgenttemplete = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_PB_TEMPLETE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgenttemplete_maintenance = insDoc(rmCodeGenerationAgenttemplete, gLnk("0","&nbsp;维护AGENT_PB_TEMPLETE", "<%=request.getContextPath()%>/AgenttempleteAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_CONTACT_PERSON生成在功能树中 */
		rmCodeGenerationAgentcontactperson = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_CONTACT_PERSON管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentcontactperson_maintenance = insDoc(rmCodeGenerationAgentcontactperson, gLnk("0","&nbsp;维护AGENT_CONTACT_PERSON", "<%=request.getContextPath()%>/AgentcontactpersonAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_SENDPOST_ORDER生成在功能树中 */
		rmCodeGenerationAgentSendPostOrder = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_SENDPOST_ORDER管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentSendPostOrder_maintenance = insDoc(rmCodeGenerationAgentSendPostOrder, gLnk("0","&nbsp;维护AGENT_SENDPOST_ORDER", "<%=request.getContextPath()%>/AgentSendPostOrderAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* AGENT_EMP_SENDPOST生成在功能树中 */
		rmCodeGenerationAgentEmpSendPost = insFld(rmCodeGenerationRoot, gFld ("&nbsp;AGENT_EMP_SENDPOST管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAgentEmpSendPost_maintenance = insDoc(rmCodeGenerationAgentEmpSendPost, gLnk("0","&nbsp;维护AGENT_EMP_SENDPOST", "<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_IMPORTDATA生成在功能树中 */
		rmCodeGenerationImportdata = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_IMPORTDATA管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationImportdata_maintenance = insDoc(rmCodeGenerationImportdata, gLnk("0","&nbsp;维护SP_IMPORTDATA", "<%=request.getContextPath()%>/ImportdataAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_IMPORTDATA生成在功能树中 */
		rmCodeGenerationSP_IMPORTDATA = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_IMPORTDATA管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSP_IMPORTDATA_maintenance = insDoc(rmCodeGenerationSP_IMPORTDATA, gLnk("0","&nbsp;维护SP_IMPORTDATA", "<%=request.getContextPath()%>/SP_IMPORTDATAAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_SIGNH生成在功能树中 */
		rmCodeGenerationSignh = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_SIGNH管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSignh_maintenance = insDoc(rmCodeGenerationSignh, gLnk("0","&nbsp;维护SP_SIGNH", "<%=request.getContextPath()%>/SignhAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_SIGNH生成在功能树中 */
		rmCodeGenerationQianka = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_SIGNH管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationQianka_maintenance = insDoc(rmCodeGenerationQianka, gLnk("0","&nbsp;维护SP_SIGNH", "<%=request.getContextPath()%>/QiankaAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_FZQXJB生成在功能树中 */
		rmCodeGenerationFzqxjb = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_FZQXJB管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFzqxjb_maintenance = insDoc(rmCodeGenerationFzqxjb, gLnk("0","&nbsp;维护SP_FZQXJB", "<%=request.getContextPath()%>/FzqxjbAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_WORKREST生成在功能树中 */
		rmCodeGenerationWorkrest = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_WORKREST管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationWorkrest_maintenance = insDoc(rmCodeGenerationWorkrest, gLnk("0","&nbsp;维护SP_WORKREST", "<%=request.getContextPath()%>/WorkrestAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SIGNEMP生成在功能树中 */
		rmCodeGenerationSignemp = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SIGNEMP管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSignemp_maintenance = insDoc(rmCodeGenerationSignemp, gLnk("0","&nbsp;维护SIGNEMP", "<%=request.getContextPath()%>/SignempAction.do?cmd=queryAll", "ftv2link.gif"));
	

        rmCodeGenerationFinishFormalities = insFld(rmCodeGenerationRoot, gFld ("&nbsp;管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));


		/* SP_IMHOLIDAY生成在功能树中 */
		rmCodeGenerationImHoliday = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_IMHOLIDAY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationImHoliday_maintenance = insDoc(rmCodeGenerationImHoliday, gLnk("0","&nbsp;维护SP_IMHOLIDAY", "<%=request.getContextPath()%>/ImHolidayAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_OVERTIMEH生成在功能树中 */
		rmCodeGenerationOvertimeh = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_OVERTIMEH管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationOvertimeh_maintenance = insDoc(rmCodeGenerationOvertimeh, gLnk("0","&nbsp;维护SP_OVERTIMEH", "<%=request.getContextPath()%>/OvertimehAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SP_AWAYB生成在功能树中 */
		rmCodeGenerationAwayb = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_AWAYB管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAwayb_maintenance = insDoc(rmCodeGenerationAwayb, gLnk("0","&nbsp;维护SP_AWAYB", "<%=request.getContextPath()%>/AwaybAction.do?cmd=queryAll", "ftv2link.gif"));
	
/* 生成在功能树中 */
        rmCodeGenerationFinishFormalities = insFld(rmCodeGenerationRoot, gFld ("&nbsp;管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
        rmCodeGenerationFinishFormalities_maintenance = insDoc(rmCodeGenerationFinishFormalities, gLnk("0","&nbsp;维护", "<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=queryAll", "ftv2link.gif"));


		/* SP_CHANGECLASS生成在功能树中 */
		rmCodeGenerationChangeclass = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_CHANGECLASS管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationChangeclass_maintenance = insDoc(rmCodeGenerationChangeclass, gLnk("0","&nbsp;维护SP_CHANGECLASS", "<%=request.getContextPath()%>/ChangeclassAction.do?cmd=queryAll", "ftv2link.gif"));
	

		/* SP_LEAVEH生成在功能树中 */
		rmCodeGenerationLeaveh = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SP_LEAVEH管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationLeaveh_maintenance = insDoc(rmCodeGenerationLeaveh, gLnk("0","&nbsp;维护SP_LEAVEH", "<%=request.getContextPath()%>/LeavehAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* ANNUALLEAVERULE生成在功能树中 */
		rmCodeGenerationAnnualLeaveRule = insFld(rmCodeGenerationRoot, gFld ("&nbsp;ANNUALLEAVERULE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAnnualLeaveRule_maintenance = insDoc(rmCodeGenerationAnnualLeaveRule, gLnk("0","&nbsp;维护ANNUALLEAVERULE", "<%=request.getContextPath()%>/AnnualLeaveRuleAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SS_SETTLEMENT_CLAIM_PAY生成在功能树中 */
		rmCodeGenerationSettlementclaimpay = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_SETTLEMENT_CLAIM_PAY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSettlementclaimpay_maintenance = insDoc(rmCodeGenerationSettlementclaimpay, gLnk("0","&nbsp;维护SS_SETTLEMENT_CLAIM_PAY", "<%=request.getContextPath()%>/SettlementclaimpayAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SS_SETTLEMENT_CLAIM_PAY生成在功能树中 */
		rmCodeGenerationClaim = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_SETTLEMENT_CLAIM_PAY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationClaim_maintenance = insDoc(rmCodeGenerationClaim, gLnk("0","&nbsp;维护SS_SETTLEMENT_CLAIM_PAY", "<%=request.getContextPath()%>/ClaimAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SS_MEDICINE_CHEST生成在功能树中 */
		rmCodeGenerationMedicalkit = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_MEDICINE_CHEST管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationMedicalkit_maintenance = insDoc(rmCodeGenerationMedicalkit, gLnk("0","&nbsp;维护SS_MEDICINE_CHEST", "<%=request.getContextPath()%>/MedicalkitAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_PRODUCT_GRANT_RULE_SET生成在功能树中 */
		rmCodeGenerationProductGrantRule = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_PRODUCT_GRANT_RULE_SET管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationProductGrantRule_maintenance = insDoc(rmCodeGenerationProductGrantRule, gLnk("0","&nbsp;维护PB_PRODUCT_GRANT_RULE_SET", "<%=request.getContextPath()%>/ProductGrantRuleAction.do?cmd=queryAll", "ftv2link.gif"));
			/* SS_POLICY生成在功能树中 */
		rmCodeGenerationPolicy = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_POLICY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPolicy_maintenance = insDoc(rmCodeGenerationPolicy, gLnk("0","&nbsp;维护SS_POLICY", "<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SS_POLICY生成在功能树中 */
		rmCodeGenerationPolicy = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_POLICY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPolicy_maintenance = insDoc(rmCodeGenerationPolicy, gLnk("0","&nbsp;维护SS_POLICY", "<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SS_POLICY生成在功能树中 */
		rmCodeGenerationPolicy = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_POLICY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPolicy_maintenance = insDoc(rmCodeGenerationPolicy, gLnk("0","&nbsp;维护SS_POLICY", "<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SS_POLICY生成在功能树中 */
		rmCodeGenerationSS_POLICY = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_POLICY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSS_POLICY_maintenance = insDoc(rmCodeGenerationSS_POLICY, gLnk("0","&nbsp;维护SS_POLICY", "<%=request.getContextPath()%>/SS_POLICYAction.do?cmd=queryAll", "ftv2link.gif"));
			/* SS_INSURANCE_AGENT生成在功能树中 */
		rmCodeGenerationInsuranceAegnt = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SS_INSURANCE_AGENT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationInsuranceAegnt_maintenance = insDoc(rmCodeGenerationInsuranceAegnt, gLnk("0","&nbsp;维护SS_INSURANCE_AGENT", "<%=request.getContextPath()%>/InsuranceAegntAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_PRODUCT生成在功能树中 */
		rmCodeGenerationWelfareProduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationWelfareProduct_maintenance = insDoc(rmCodeGenerationWelfareProduct, gLnk("0","&nbsp;维护PB_PRODUCT", "<%=request.getContextPath()%>/WelfareProductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_PRODUCT生成在功能树中 */
		rmCodeGenerationWelfareProduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationWelfareProduct_maintenance = insDoc(rmCodeGenerationWelfareProduct, gLnk("0","&nbsp;维护PB_PRODUCT", "<%=request.getContextPath()%>/WelfareProductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_PRODUCT生成在功能树中 */
		rmCodeGenerationWelfareProduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationWelfareProduct_maintenance = insDoc(rmCodeGenerationWelfareProduct, gLnk("0","&nbsp;维护PB_PRODUCT", "<%=request.getContextPath()%>/WelfareProductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_PRODUCT生成在功能树中 */
		rmCodeGeneration福利产品维护 = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGeneration福利产品维护_maintenance = insDoc(rmCodeGeneration福利产品维护, gLnk("0","&nbsp;维护PB_PRODUCT", "<%=request.getContextPath()%>/福利产品维护Action.do?cmd=queryAll", "ftv2link.gif"));

		/* FIN_BILL_SALARY_REL生成在功能树中 */
		rmCodeGenerationFIN_BILL_SALARY_REL = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_BILL_SALARY_REL管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFIN_BILL_SALARY_REL_maintenance = insDoc(rmCodeGenerationFIN_BILL_SALARY_REL, gLnk("0","&nbsp;维护FIN_BILL_SALARY_REL", "<%=request.getContextPath()%>/FIN_BILL_SALARY_RELAction.do?cmd=queryAll", "ftv2link.gif"));

		/* CS_SS_RPT_INFO生成在功能树中 */
		rmCodeGenerationCsssrptinfo = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_SS_RPT_INFO管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationCsssrptinfo_maintenance = insDoc(rmCodeGenerationCsssrptinfo, gLnk("0","&nbsp;维护CS_SS_RPT_INFO", "<%=request.getContextPath()%>/CsssrptinfoAction.do?cmd=queryAll", "ftv2link.gif"));


		/* FIN_VERIFICATION生成在功能树中 */
		rmCodeGenerationFinverifcation = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_VERIFICATION管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFinverifcation_maintenance = insDoc(rmCodeGenerationFinverifcation, gLnk("0","&nbsp;维护FIN_VERIFICATION", "<%=request.getContextPath()%>/FinverifcationAction.do?cmd=queryAll", "ftv2link.gif"));
	

		/* CS_SS_RPT_INFO生成在功能树中 */
		rmCodeGenerationCsssrptinfo = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_SS_RPT_INFO管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationCsssrptinfo_maintenance = insDoc(rmCodeGenerationCsssrptinfo, gLnk("0","&nbsp;维护CS_SS_RPT_INFO", "<%=request.getContextPath()%>/CsssrptinfoAction.do?cmd=queryAll", "ftv2link.gif"));

		/* FIN_PAYMENT_ITEM生成在功能树中 */
		rmCodeGenerationFinpaymentitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_PAYMENT_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFinpaymentitem_maintenance = insDoc(rmCodeGenerationFinpaymentitem, gLnk("0","&nbsp;维护FIN_PAYMENT_ITEM", "<%=request.getContextPath()%>/FinpaymentitemAction.do?cmd=queryAll", "ftv2link.gif"));

		/* FIN_BILL_IMP_DATA生成在功能树中 */
		rmCodeGenerationFinbillimpdata = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_BILL_IMP_DATA管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFinbillimpdata_maintenance = insDoc(rmCodeGenerationFinbillimpdata, gLnk("0","&nbsp;维护FIN_BILL_IMP_DATA", "<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* FIN_BILL_IMP_BATCH生成在功能树中 */
		rmCodeGenerationFinbillimpbatch = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_BILL_IMP_BATCH管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFinbillimpbatch_maintenance = insDoc(rmCodeGenerationFinbillimpbatch, gLnk("0","&nbsp;维护FIN_BILL_IMP_BATCH", "<%=request.getContextPath()%>/FinbillimpbatchAction.do?cmd=queryAll", "ftv2link.gif"));

		/* CS_EMP_SECURITY_SUPPLY生成在功能树中 */
		rmCodeGenerationEmpsecuritysupply = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_EMP_SECURITY_SUPPLY管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmpsecuritysupply_maintenance = insDoc(rmCodeGenerationEmpsecuritysupply, gLnk("0","&nbsp;维护CS_EMP_SECURITY_SUPPLY", "<%=request.getContextPath()%>/EmpsecuritysupplyAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* CS_EMP_SECURITY_ITEM生成在功能树中 */
		rmCodeGenerationEmpsecurityitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_EMP_SECURITY_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmpsecurityitem_maintenance = insDoc(rmCodeGenerationEmpsecurityitem, gLnk("0","&nbsp;维护CS_EMP_SECURITY_ITEM", "<%=request.getContextPath()%>/EmpsecurityitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* FIN_INVOICE生成在功能树中 */
		rmCodeGenerationFininvoice = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_INVOICE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFininvoice_maintenance = insDoc(rmCodeGenerationFininvoice, gLnk("0","&nbsp;维护FIN_INVOICE", "<%=request.getContextPath()%>/FininvoiceAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_IMPERR生成在功能树中 */
		rmCodeGenerationEpempimperr = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_IMPERR管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpempimperr_maintenance = insDoc(rmCodeGenerationEpempimperr, gLnk("0","&nbsp;维护EP_EMP_IMPERR", "<%=request.getContextPath()%>/EpempimperrAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_IMPERR生成在功能树中 */
		rmCodeGenerationEpempimperr = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_IMPERR管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpempimperr_maintenance = insDoc(rmCodeGenerationEpempimperr, gLnk("0","&nbsp;维护EP_EMP_IMPERR", "<%=request.getContextPath()%>/EpempimperrAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_CARD_ERR生成在功能树中 */
		rmCodeGenerationEpempcarderr = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_CARD_ERR管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpempcarderr_maintenance = insDoc(rmCodeGenerationEpempcarderr, gLnk("0","&nbsp;维护EP_EMP_CARD_ERR", "<%=request.getContextPath()%>/EpempcarderrAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_CARD生成在功能树中 */
		rmCodeGenerationEpempcard = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_CARD管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpempcard_maintenance = insDoc(rmCodeGenerationEpempcard, gLnk("0","&nbsp;维护EP_EMP_CARD", "<%=request.getContextPath()%>/EpempcardAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_ORDER生成在功能树中 */
		rmCodeGenerationEpemporder = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_ORDER管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpemporder_maintenance = insDoc(rmCodeGenerationEpemporder, gLnk("0","&nbsp;维护EP_EMP_ORDER", "<%=request.getContextPath()%>/EpemporderAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_ORDER_ITEM生成在功能树中 */
		rmCodeGenerationEpemporderitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_ORDER_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpemporderitem_maintenance = insDoc(rmCodeGenerationEpemporderitem, gLnk("0","&nbsp;维护EP_EMP_ORDER_ITEM", "<%=request.getContextPath()%>/EpemporderitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_ORDER生成在功能树中 */
		rmCodeGenerationEmemporder = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_ORDER管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmemporder_maintenance = insDoc(rmCodeGenerationEmemporder, gLnk("0","&nbsp;维护EP_EMP_ORDER", "<%=request.getContextPath()%>/EmemporderAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* CS_EMP_HIRE_FIRE生成在功能树中 */
		rmCodeGenerationEmphirefire = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_EMP_HIRE_FIRE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmphirefire_maintenance = insDoc(rmCodeGenerationEmphirefire, gLnk("0","&nbsp;维护CS_EMP_HIRE_FIRE", "<%=request.getContextPath()%>/EmphirefireAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* CS_EMP_SERVICE_ITEM生成在功能树中 */
		rmCodeGenerationEmpserviceitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_EMP_SERVICE_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmpserviceitem_maintenance = insDoc(rmCodeGenerationEmpserviceitem, gLnk("0","&nbsp;维护CS_EMP_SERVICE_ITEM", "<%=request.getContextPath()%>/EmpserviceitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* CS_EMP_SERVICE_ITEM生成在功能树中 */
		rmCodeGenerationEmpserviceitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;CS_EMP_SERVICE_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmpserviceitem_maintenance = insDoc(rmCodeGenerationEmpserviceitem, gLnk("0","&nbsp;维护CS_EMP_SERVICE_ITEM", "<%=request.getContextPath()%>/EmpserviceitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_SEND_QUO_REL生成在功能树中 */
		rmCodeGenerationEpsendinfo = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_SEND_QUO_REL管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEpsendinfo_maintenance = insDoc(rmCodeGenerationEpsendinfo, gLnk("0","&nbsp;维护EP_SEND_QUO_REL", "<%=request.getContextPath()%>/EpsendinfoAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* EP_EMP_SIBLING生成在功能树中 */
		rmCodeGenerationEmpsibling = insFld(rmCodeGenerationRoot, gFld ("&nbsp;EP_EMP_SIBLING管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmpsibling_maintenance = insDoc(rmCodeGenerationEmpsibling, gLnk("0","&nbsp;维护EP_EMP_SIBLING", "<%=request.getContextPath()%>/EmpsiblingAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_EMPLOYEE生成在功能树中 */
		rmCodeGenerationEmployee = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_EMPLOYEE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationEmployee_maintenance = insDoc(rmCodeGenerationEmployee, gLnk("0","&nbsp;维护PB_EMPLOYEE", "<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryAll", "ftv2link.gif"));

		/* PB_SECURITY_GROUP_STOP生成在功能树中 */
		rmCodeGenerationSecuritygroupstop = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SECURITY_GROUP_STOP管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSecuritygroupstop_maintenance = insDoc(rmCodeGenerationSecuritygroupstop, gLnk("0","&nbsp;维护PB_SECURITY_GROUP_STOP", "<%=request.getContextPath()%>/SecuritygroupstopAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_SECURITY_GROUP_NEW生成在功能树中 */
		rmCodeGenerationSecuritygroupnew = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SECURITY_GROUP_NEW管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSecuritygroupnew_maintenance = insDoc(rmCodeGenerationSecuritygroupnew, gLnk("0","&nbsp;维护PB_SECURITY_GROUP_NEW", "<%=request.getContextPath()%>/SecuritygroupnewAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_SERVICE_SMALL_TYPE生成在功能树中 */
		rmCodeGenerationPbServiceSmallType = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SERVICE_SMALL_TYPE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPbServiceSmallType_maintenance = insDoc(rmCodeGenerationPbServiceSmallType, gLnk("0","&nbsp;维护PB_SERVICE_SMALL_TYPE", "<%=request.getContextPath()%>/PbServiceSmallTypeAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_SERVICE生成在功能树中 */
		rmCodeGenerationPbservice = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SERVICE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPbservice_maintenance = insDoc(rmCodeGenerationPbservice, gLnk("0","&nbsp;维护PB_SERVICE", "<%=request.getContextPath()%>/PbserviceAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_SERVICE_BIG_TYPE生成在功能树中 */
		rmCodeGenerationPbservicebigtype = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SERVICE_BIG_TYPE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationPbservicebigtype_maintenance = insDoc(rmCodeGenerationPbservicebigtype, gLnk("0","&nbsp;维护PB_SERVICE_BIG_TYPE", "<%=request.getContextPath()%>/PbservicebigtypeAction.do?cmd=queryAll", "ftv2link.gif"));

		/* PB_SECURITY_GROUP_REL生成在功能树中 */
		rmCodeGenerationSecuritygrouprel = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SECURITY_GROUP_REL管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSecuritygrouprel_maintenance = insDoc(rmCodeGenerationSecuritygrouprel, gLnk("0","&nbsp;维护PB_SECURITY_GROUP_REL", "<%=request.getContextPath()%>/SecuritygrouprelAction.do?cmd=queryAll", "ftv2link.gif"));

		/* SAL_QUOTATION生成在功能树中 */
		rmCodeGenerationQuotation = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SAL_QUOTATION管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationQuotation_maintenance = insDoc(rmCodeGenerationQuotation, gLnk("0","&nbsp;维护SAL_QUOTATION", "<%=request.getContextPath()%>/QuotationAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SAL_QUOTATION_ITEM生成在功能树中 */
		rmCodeGenerationQuotationitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SAL_QUOTATION_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationQuotationitem_maintenance = insDoc(rmCodeGenerationQuotationitem, gLnk("0","&nbsp;维护SAL_QUOTATION_ITEM", "<%=request.getContextPath()%>/QuotationitemAction.do?cmd=queryAll", "ftv2link.gif"));

		/* PB_SECURITY_GROUP生成在功能树中 */
		rmCodeGenerationSecuritygroup = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SECURITY_GROUP管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSecuritygroup_maintenance = insDoc(rmCodeGenerationSecuritygroup, gLnk("0","&nbsp;维护PB_SECURITY_GROUP", "<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=queryAll", "ftv2link.gif"));

		/* FIN_INCOMING生成在功能树中 */
		rmCodeGenerationFININCOMING = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_INCOMING管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFININCOMING_maintenance = insDoc(rmCodeGenerationFININCOMING, gLnk("0","&nbsp;维护FIN_INCOMING", "<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* FIN_BILL生成在功能树中 */
		rmCodeGenerationFinbill = insFld(rmCodeGenerationRoot, gFld ("&nbsp;FIN_BILL管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationFinbill_maintenance = insDoc(rmCodeGenerationFinbill, gLnk("0","&nbsp;维护FIN_BILL", "<%=request.getContextPath()%>/FinbillAction.do?cmd=queryAll", "ftv2link.gif"));

		/* PB_SECURITY_PRODUCT_ITEM生成在功能树中 */
		rmCodeGenerationSecurityproductitem = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SECURITY_PRODUCT_ITEM管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSecurityproductitem_maintenance = insDoc(rmCodeGenerationSecurityproductitem, gLnk("0","&nbsp;维护PB_SECURITY_PRODUCT_ITEM", "<%=request.getContextPath()%>/SecurityproductitemAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_SECURITY_PRODUCT生成在功能树中 */
		rmCodeGenerationSecurityproduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SECURITY_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationSecurityproduct_maintenance = insDoc(rmCodeGenerationSecurityproduct, gLnk("0","&nbsp;维护PB_SECURITY_PRODUCT", "<%=request.getContextPath()%>/SecurityproductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_CUSTOMER生成在功能树中 */
		rmCodeGenerationCustomer = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_CUSTOMER管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationCustomer_maintenance = insDoc(rmCodeGenerationCustomer, gLnk("0","&nbsp;维护PB_CUSTOMER", "<%=request.getContextPath()%>/CustomerAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* SAL_CUSTOMER生成在功能树中 */
		rmCodeGenerationCustomer = insFld(rmCodeGenerationRoot, gFld ("&nbsp;SAL_CUSTOMER管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationCustomer_maintenance = insDoc(rmCodeGenerationCustomer, gLnk("0","&nbsp;维护SAL_CUSTOMER", "<%=request.getContextPath()%>/CustomerAction.do?cmd=queryAll", "ftv2link.gif"));

		/* PB_ATTACHMENT_FILE生成在功能树中 */
		rmCodeGenerationAttachmentfile = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_ATTACHMENT_FILE管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationAttachmentfile_maintenance = insDoc(rmCodeGenerationAttachmentfile, gLnk("0","&nbsp;维护PB_ATTACHMENT_FILE", "<%=request.getContextPath()%>/AttachmentfileAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* DD_BASEDATA生成在功能树中 */
		rmCodeGenerationProductbasedata = insFld(rmCodeGenerationRoot, gFld ("&nbsp;DD_BASEDATA管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationProductbasedata_maintenance = insDoc(rmCodeGenerationProductbasedata, gLnk("0","&nbsp;维护DD_BASEDATA", "<%=request.getContextPath()%>/ProductbasedataAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_SCHEME_PRODUCT生成在功能树中 */
		rmCodeGenerationProductscheme = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_SCHEME_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationProductscheme_maintenance = insDoc(rmCodeGenerationProductscheme, gLnk("0","&nbsp;维护PB_SCHEME_PRODUCT", "<%=request.getContextPath()%>/ProductschemeAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* PB_PRODUCT生成在功能树中 */
		rmCodeGenerationProduct = insFld(rmCodeGenerationRoot, gFld ("&nbsp;PB_PRODUCT管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationProduct_maintenance = insDoc(rmCodeGenerationProduct, gLnk("0","&nbsp;维护PB_PRODUCT", "<%=request.getContextPath()%>/ProductAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
		/* student生成在功能树中 */
		rmCodeGenerationStudent = insFld(rmCodeGenerationRoot, gFld ("&nbsp;student管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
		rmCodeGenerationStudent_maintenance = insDoc(rmCodeGenerationStudent, gLnk("0","&nbsp;维护student", "<%=request.getContextPath()%>/StudentAction.do?cmd=queryAll", "ftv2link.gif"));
	
rmCodeGenerationRmDictionaryType = insFld(rmCodeGenerationRoot, gFld ("&nbsp;数据字典管理", "", "ftv2folderopen.gif", "ftv2folderclosed.gif"));
rmCodeGenerationRmDictionaryType_insert = insDoc(rmCodeGenerationRmDictionaryType, gLnk("0","&nbsp;新增数据类型", "<%=request.getContextPath()%>/jsp/dictionary/rmdictionarytype/insertRmDictionaryType.jsp", "ftv2link.gif"));
rmCodeGenerationRmDictionaryType_maintenance = insDoc(rmCodeGenerationRmDictionaryType, gLnk("0","&nbsp;维护数据字典", "<%=request.getContextPath()%>/RmDictionaryTypeAction.do?cmd=queryAll", "ftv2link.gif"));

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
