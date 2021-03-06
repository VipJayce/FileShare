<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.authority.org.auparty.vo.PartyVo"%>
<%@ page import="gap.authority.au.auuser.vo.AuUserVo"%>
<%@ page import="gap.authority.org.auparty.util.IConstants" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="gap.commons.xmlenum.EnumRepository" %>
<%@ page import="gap.commons.xmlenum.EnumValueMap" %>
<%
	//加载信息资源
	EnumRepository er = EnumRepository.getInstance();
	er.loadFromDir();
	EnumValueMap msgResourceMap = er.getEnumValueMap("MessageResource");	

    PartyVo vo = (PartyVo)request.getAttribute(IConstants.REQUEST_BEAN_VALUE);
    AuUserVo userVo = (AuUserVo)request.getAttribute("UserVo");
	String userPartyId = gap.authority.helper.LoginHelper.getPartyId(request);
	if(userPartyId==null) {
		userPartyId = "";
	}
%>
<base target="_self">
<title><fmt:message key='gap.authority.View_Company' bundle='${applicationAuResources}' /></title>
<script language="javascript">
	function getLayoutHiddenObjectById(id) {
		if(id == null) {
			return null;
		}
		var allInput = document.getElementsByTagName("input");
		for(var i=0; i<allInput.length; i++) {
		    var aput = jQuery(allInput[i]);
			if(aput.attr("type") == "hidden" && aput.attr("signName") == "hiddenId" && aput.attr("value") == id) {
				return allInput[i];
			}
		}
		return null;
	}
	function view_onButton(){
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		view_onClick(id);
	}
	
	function view_onClick(id){
		document.getElementById("myTree").src="<venus:base/>/jsp/authority/tree/deeptree_iframe.jsp?rootXmlSource=<venus:base/>/jsp/authority/tree/partyDetailTreeRoot.jsp?submit_all%3Dno%26return_type%3Dparty_id%26id%3D"+id;
	}
	
	function goBack_onClick(){
	   if(window.dialogArguments){
	       window.close();
	   }else{
		  form.action="<venus:base/>/AuVisitorAction.do?cmd=queryAllByTypes";
    	  form.submit();
    	}
	}
	
	function toAuPage(cmd, rType) {
		var partyId = form.partyId.value;
		if(partyId=="<%=userPartyId%>") {
			alert("<fmt:message key='gap.authority.Can_not_give_his_authority_' bundle='${applicationAuResources}' />");
			return;
		}
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var relId = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				relId = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var thisHidden = getLayoutHiddenObjectById(relId);
		var pType = jQuery(thisHidden).attr("party_type");
		treePath = "<venus:base/>/jsp/authority/au/auauthorize/auFrame.jsp?cmd="+cmd+"&relId="+relId+"&pType="+pType+"&rType="+rType;
		window.showModalDialog(treePath, new Object(),'dialogWidth=700px;dialogHeight=800px;resizable:yes;status:no;scroll:auto;');
	}	
	function toOrgAuPage(rootCode,relationType){
		var partyId = form.partyId.value;
		if(partyId=="<%=userPartyId%>") {
			alert("<fmt:message key='gap.authority.Can_not_give_his_authority_' bundle='${applicationAuResources}' />");
			return;
		}
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var relId = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				relId = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var thisHidden = getLayoutHiddenObjectById(relId);
		var pType = jQuery(thisHidden).attr("party_type");
		
		var treePath = "<venus:base/>/jsp/authority/tree/treeRef4Au.jsp?inputType=checkbox&nodeRelationType="+relationType+"&relId="+relId+"&pType="+pType+"&rootXmlSource="
				+"<venus:base/>/jsp/authority/au/auauthorize/org.jsp?parent_code%3D"+rootCode+"%26relId%3D"+relId+"%26pType%3D"+pType;
        window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
		
	}
	
	function toRelationAuPage(relationType){
        var partyId = form.partyId.value;
        if(partyId=="<%=userPartyId%>") {
            alert("<fmt:message key='gap.authority.Can_not_give_his_authority_' bundle='${applicationAuResources}' />");
            return;
        }
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var number = 0;
        var relId = null;
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                number += 1;
                relId = elementCheckbox[i].value;
            }
        }
        if(number == 0) {
            alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
            return;
        }
        if(number > 1) {
            alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
            return;
        }
        var thisHidden = getLayoutHiddenObjectById(relId);
        var pType = jQuery(thisHidden).attr("party_type");
        
        var treePath = "<venus:base/>/jsp/authority/tree/treeChooseRef4Au.jsp?inputType=checkbox&nodeRelationType="+relationType+"&relId="+relId+"&pType="+pType+"&rootXmlSource="
                +"<venus:base/>/jsp/authority/au/auauthorize/org.jsp?relId%3D"+relId+"%26pType%3D"+pType;
        window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
        
    }
	
	function toHisAuPage() {
		var partyId = form.partyId.value;
		if(partyId=="<%=userPartyId%>") {
			alert("<fmt:message key='gap.authority.Can_not_give_his_authority_' bundle='${applicationAuResources}' />");
			return;
		}
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var relId;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				relId = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var thisHidden = jQuery(getLayoutHiddenObjectById(relId));
		var pType = thisHidden.attr("party_type");
		var code = thisHidden.attr("code");
				
		var treePath = "<venus:base/>/jsp/authority/history/authorizeLogFrame.jsp?relId="+relId+"&pType="+pType+"&visiCode="+code;
		window.showModalDialog(treePath, new Object(),'dialogHeight=650px;dialogWidth=1000px;resizable:yes;status:no;scroll:auto;');
	}	
	
	function toAuOrgPage(cmd, rType,rootCode,isRelation) {
		var partyId = form.partyId.value;
		if(partyId=="<%=userPartyId%>") {
			alert("<fmt:message key='gap.authority.Can_not_give_his_authority_' bundle='${applicationAuResources}' />");
			return;
		}
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var relId = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				relId = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var thisHidden = getLayoutHiddenObjectById(relId);
		var pType = jQuery(thisHidden).attr("party_type");
		
		if(isRelation){
		  treePath = "<venus:base/>/jsp/authority/au/auauthorize/auOrgFrameRelation.jsp?cmd="+cmd+"&relId="+relId+"&pType="+pType+"&rType="+rType;
		}else{
		  treePath = "<venus:base/>/jsp/authority/au/auauthorize/auOrgFrame.jsp?cmd="+cmd+"&relId="+relId+"&pType="+pType+"&rType="+rType+"&rootCode="+rootCode;
		}
		window.showModalDialog(treePath, new Object(),'dialogWidth=1100px;dialogHeight=800px;resizable:yes;status:no;scroll:auto;');
	}	
	
	function viewAllAu() {
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var relId = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				relId = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record_of_their_relationship' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var thisHidden = getLayoutHiddenObjectById(relId);
		var code = jQuery(thisHidden).attr("code");
		var pType = jQuery(thisHidden).attr("party_type");
		var partyId = form.partyId.value;
		
		form.action="<venus:base/>/jsp/authority/au/auauthorize/viewAllAu.jsp?vCode="+code+"&partyId="+partyId+"&partyTypeId="+pType;
    	form.submit();
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Details' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>
<form name="form" method="post"> 
<input type="hidden" name="partyId" value="<%=vo.getId()%>">
<input type="hidden" name="partyTypes" value="<%=(String)request.getAttribute("pageFlag")%>">
<table class="table_noframe" width="97%" align="center">
	<tr>
		<td valign="left">			
			<input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onClick="goBack_onClick('<%=vo.getPartytype_id()%>');">
		</td>
	</tr>
</table>
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.Basic_Information' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="auDivChild0"> 
<table class="table_div_content">
	<tr>
		<td>
		<%
			if(userVo!=null) {
		%>
			<table border="1" bordercolordark="#FFFFFF" bordercolorlight="#7EBAFF" cellpadding="5" cellspacing="0" width="100%" align="center"> 	
				<tr> 
					<td width="15%" align="right"><fmt:message key='gap.authority.Account_' bundle='${applicationAuResources}' /></td> 
					<td width="35%" align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(userVo.getLogin_id())%></td> 
					<td width="15%" align="right"><fmt:message key='gap.authority.Real_Name_' bundle='${applicationAuResources}' /></td> 
					<td width="35%" align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(userVo.getName())%></td> 
				</tr> 		
				<tr> 
					<td align="right"><fmt:message key='gap.authority.Added_' bundle='${applicationAuResources}' /></td> 
					<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(userVo.getCreate_date(),19)%></td> 
					<td align="right"><fmt:message key='gap.authority.Modified_' bundle='${applicationAuResources}' /></td> 
					<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(userVo.getModify_date(),19)%></td> 
				</tr>
			</table> 
		<%
			}else {
		%>
			<table border="1" bordercolordark="#FFFFFF" bordercolorlight="#7EBAFF" cellpadding="5" cellspacing="0" width="100%" align="center"> 	
				<tr> 
					<td width="15%" align="right"><fmt:message key='gap.authority.Name_' bundle='${applicationAuResources}' /></td> 
					<td width="35%" align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(vo.getName())%></td> 
					<td width="15%" align="right"><fmt:message key='gap.authority.Type_' bundle='${applicationAuResources}' /></td> 
					<td width="35%" align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(vo.getPartyname())%></td> 
				</tr> 		
				<tr> 
					<td align="right"><fmt:message key='gap.authority.Added_' bundle='${applicationAuResources}' /></td> 
					<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(vo.getCreate_date(),19)%></td> 
					<td align="right"><fmt:message key='gap.authority.Modified_' bundle='${applicationAuResources}' /></td> 
					<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(vo.getModify_date(),19)%></td> 
				</tr>
			</table>
		<%
			}
		%>
		</td>
	</tr>
</table>
</div>
<div id="auDivParent1"> 
<table class="table_div_doublecontrol">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Their_relationship' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("funcDesc") %>" onClick="javascript:toAuPage('getFuncAu','<%=GlobalConstants.getResType_menu()%>');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Functional_competence' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("orgDataDesc") %>" onClick="javascript:toOrgAuPage('<%=GlobalConstants.getRelaType_comp()%>','noRelation');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Agency_data_rights' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("orgDataDesc") %>" onClick="javascript:toRelationAuPage('noRelation');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Relation_data_rights' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("roleDataDesc") %>" onClick="javascript:toOrgAuPage('<%=GlobalConstants.getRelaType_role()%>','hasRelation');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.The_role_of_data_rights' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("agentDataDesc") %>" onClick="javascript:toOrgAuPage('<%=GlobalConstants.getRelaType_proxy()%>','hasRelation');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Agency_data_rights0' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("hisDataDesc") %>" onClick="javascript:toHisAuPage();" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Historical_data_permissions' bundle='${applicationAuResources}' /></td>
				</tr>
                <tr>
                	<td class="button_ellipse" title="<%=msgResourceMap.getLabel("funcDataDesc") %>" onClick="javascript:toAuOrgPage('getFuncOrgAu','<%=GlobalConstants.getResType_menu()%>','<%=GlobalConstants.getRelaType_comp()%>',false);" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Functional_data_permissions' bundle='${applicationAuResources}' /></td>
                	<td class="button_ellipse" title="<%=msgResourceMap.getLabel("funcDataDesc") %>" onClick="javascript:toAuOrgPage('getFuncOrgAu','<%=GlobalConstants.getResType_menu()%>','',true);" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Functional_relation_permissions' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("charDataDesc") %>" onClick="javascript:toAuPage('getDataAu','<%=GlobalConstants.getResType_fild()%>');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Field_level_data_permissions' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("recordDataDesc") %>" onClick="javascript:toAuPage('getDataAu','<%=GlobalConstants.getResType_recd()%>');" ><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Record_level_data_permissions' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" title="<%=msgResourceMap.getLabel("viewAuDesc") %>" onClick="javascript:viewAllAu();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message key='gap.authority.View_authorization' bundle='${applicationAuResources}' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id="auDivChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="list" id="pfau" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="30" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Selected") %>' style="text-align:center;">
				<bean:define id="myId" name="pfau" property="id"/>
				<input type="radio" name="checkbox_template" value="<%=myId%>" onclick="javascript:view_onClick('<%=myId%>')"/>
			</layout:collectionItem>
			<%="<a onclick='javascript:view_onClick(getRowHiddenId())'>"%>
			<layout:collectionItem width="30"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="myId" name="pfau" property="id"/>
				<bean:define id="isLeaf" name="pfau" property="is_leaf"/>
				<bean:define id="partytype_id" name="pfau" property="partytype_id"/>
				<bean:define id="code" name="pfau" property="code"/>
				<input type="hidden" signName="hiddenId" value="<%=myId%>" is_leaf="<%=isLeaf%>" party_type="<%=partytype_id%>" code="<%=code%>"/>
			</layout:collectionItem>
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Name") %>' property="name" />
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Higher_node_name") %>' property="parent_partyname" />
			<layout:collectionItem width="80" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Their_type_of_relationship") %>' property="relationtype_name" />
            <layout:collectionItem width="80" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Whether_the_leaf_node") %>'> 
            	<bean:define id="isLeaf" name="pfau" property="is_leaf"/>
					<%="1".equals(isLeaf)?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Be"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.No0")%>
			</layout:collectionItem> 
			<%="</a>"%>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>   
<div id="auDivParent2"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild2',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Tree' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>
<div id="auDivChild2"> 
<table class="table_div_content">
	<tr>
		<td>
             <table bgcolor="#FFFFFF" width="100%"> 
                <tr>
                    <td width="5%" align="right">&nbsp;</td>
                    <td width="90%" align="left"><iframe id="myTree" name="myTree" width="100%" height="250" frameborder="0"></iframe>
                    </td> 
                    <td width="5%" align="left">&nbsp;</td> 
                </tr> 
            </table> 
		</td> 
	</tr>
</table>
</div>
</form> 
<script language="javascript">
	writeTableBottom('<venus:base/>/');
	
	try{ 
		var inputRadio = document.getElementsByName("checkbox_template");
		inputRadio[0].checked=true;
		view_onClick(jQuery(inputRadio[0]).val());
	}catch(e){
	    alert("<fmt:message key='gap.authority.Does_not_have_a_relationship_a_relationship_first_' bundle='${applicationAuResources}' />");
	}  
</script>
</body>
</html>

