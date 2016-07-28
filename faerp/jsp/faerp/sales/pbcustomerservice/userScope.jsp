<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ taglib uri="http://taglib.gapext.com/tags/richweb" prefix="r"%>
<%@ taglib uri="http://taglib.gapext.com/tags/webcomp" prefix="w"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Function_Menu_Management' bundle='${applicationAuResources}' /></title>
<script type="text/javascript">
    function sendSubmit(){
    	var selectedNode = document.getElementById("righttree");
    	
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?";
        form.cmd.value = "userScopeSubmit";
        form.submit();
    }

function checkPerson(node){	
	var partyid = node.getProperty("partyid");
	document.getElementById("manager").value = partyid;
	document.getElementById("righttree").src="/FAERP/PbcustomerserviceAction.do?cmd=queryUserForRightTree&partyid=" + partyid;
	document.getElementById("righttree").reload();
	
}


function checkObjTree(node){	
	document.getElementById("manager").value = "1";
}
function getParam(){
	
	return "<params><param><key>parent_partyid</key><value>1099100700000000004</value></param></params>"
}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Function_Menu_Management' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr> 
  	<td width="380" valign="top" >
      <table width="100%" height="460"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#7EBAFF">
        <tr> 
          <td bgcolor="#FFFFFF" valign="top"> 
	        <r:rtree id="leftTree">
				<r:treeRoot
					action="/FAERP/PbcustomerserviceAction.do?cmd=getTreeObjList"
					childEntities="TreeObj" display="公司" initParamFunc="getParam" />
	
				<r:treeNode nodeType="TreeObj" submitXpath="TreeObj" showField="name"
					action="/FAERP/PbcustomerserviceAction.do?cmd=getTreeObjNode" 
					childEntities="TreeObj,PersonObj" onClickFunc="checkObjTree">
				</r:treeNode>
				<r:treeNode nodeType="PersonObj" submitXpath="PersonObj" showField="name"
					icon="/images/seat_icon_1.gif"  preload="true" onClickFunc="checkPerson">
				</r:treeNode>	
			</r:rtree>
          </td>
        </tr>
      </table>
    </td>
    <td valign="top">
    <input type="hidden" name="manager" id="manager" value="1"/>
     	<iframe id="righttree" name="righttree" height="700" width="100%" border="0" frameborder="0" 
     	src="/FAERP/PbcustomerserviceAction.do?cmd=queryUserForRightTree&partyid=" scrolling="yes"></iframe>
     	
    </td>    
  </tr>
</table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
           