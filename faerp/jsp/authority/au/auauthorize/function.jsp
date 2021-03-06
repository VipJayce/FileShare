<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="gap.authority.au.aufunctree.vo.AuFunctreeVo"%>
<%@ page import="gap.authority.au.auauthorize.vo.AuAuthorizeVo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map"%>
<%
try {
	//获取该用户自身拥有权限的节点
    Map selfMap = (Map)request.getAttribute("SEL_AU_MAP");

    //获取该用户继承权限的节点
    Map extMap = (Map)request.getAttribute("EXT_AU_MAP");

	//获取全部功能节点
	List lFunctree = (List)request.getAttribute("FUNC_LIST");

	//获取公开访问的节点
	Map resMap = (Map)request.getAttribute("PUB_RES_MAP");

%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Functional_authority' bundle='${applicationAuResources}' /></title>
</head>
<body>
	<form name="form" method="post" action="">
	<table class="table_noFrame" width="96%" align="center"> 
        <tr> 
			<td align="left">
<!--菜单树开始-->   
		<script language="javascript">
			var basePath="<venus:base/>";
			var checkboxType = "";
			var selTxtArray = new Array("<fmt:message key='gap.authority.Refusal' bundle='${applicationAuResources}' />","<fmt:message key='gap.authority.Allow' bundle='${applicationAuResources}' />","<fmt:message key='gap.authority.May_authorize' bundle='${applicationAuResources}' />");
			var selValArray = new Array('0','1','2');
		</script>
		<script language="javascript" src="<venus:base/>/js/au/tree4au.js"></script>
		<script language="javascript">
			if (document.getElementById){
<%
		String rootCode = "";
		Iterator itLTree = lFunctree.iterator(); 
		//根节点
		if(itLTree.hasNext()) {
			AuFunctreeVo vo = (AuFunctreeVo) itLTree.next();
			rootCode = vo.getTotal_code();
%>
				var t0=new WebFXTree('<b><%=vo.getName()%></b>','',selTxtArray,selValArray);
				t0.setBehavior('classic');
<%				
		}
		while(itLTree.hasNext()) {
			AuFunctreeVo vo = (AuFunctreeVo) itLTree.next();
			String isDisable = "";
			String selfType = "";
			String selfAccs = "";
			String extType = "";
			String extAccs = "";
			//勾中已授权的节点
			AuAuthorizeVo auVo = (AuAuthorizeVo)selfMap.get(vo.getId());
			if(auVo!=null) {
				selfType = auVo.getAuthorize_status();
				selfAccs = auVo.getAccess_type();
			}
			AuAuthorizeVo extAuVo = (AuAuthorizeVo)extMap.get(vo.getId());
			if(extAuVo!=null) {
				extType = extAuVo.getAuthorize_status();
				extAccs = extAuVo.getAccess_type();
			}
			//将公开节点置为不可用
			if(resMap.keySet().contains(vo.getId())) {
				isDisable = "disabled";
			}
			if("1".equals(vo.getIs_leaf()) || "1".equals(vo.getType_is_leaf())) {
			
%>
				//参数如下：WebFXTreeItem(sText,sTitle,treeID,selCode,selTxt,selVal,selWhoEx,selWho,isDisable,sType)
				//sText：节点名称, sTitle：鼠标悬停提示, treeID：节点checkbox的name, selCode:节点编码
				//selTxt：选项名称数组, selVal：选项值数组, selWhoEx 继承权限数组, selWho：已有权限数组, isDisable：是否禁用, sType：资源类型
				var node<%=vo.getTotal_code()%> = new WebFXTreeItem("<%=vo.getName()%><%=resMap.keySet().contains(vo.getId())?"[<fmt:message key='gap.authority.Open' bundle='${applicationAuResources}' />]":""%>",
					"<%=vo.getName()%>", "<%=vo.getId()%>", "<%=vo.getTotal_code()%>", selTxtArray, selValArray,
					new Array('<%=extType%>','<%=extAccs%>'), new Array('<%=selfType%>','<%=selfAccs%>'),"<%=isDisable%>","<%=vo.getType()%>");
<%
			}else {
%>
				var node<%=vo.getTotal_code()%> = new WebFXTreeItem("<%=vo.getName()%>","<%=vo.getName()%>","<%=vo.getId()%>",
					"<%=vo.getTotal_code()%>",new Array(0),new Array(0),new Array(0),new Array(0),"");
<%
			}
			if( ! rootCode.equals(vo.getParent_code())) {//有父节点存在
%>
				node<%=vo.getParent_code()%>.add(node<%=vo.getTotal_code()%>);
<%					
			}else{
%>
				t0.add(node<%=vo.getTotal_code()%>);
<%				
			}
		}
%>				
				document.write(t0);t0.expand();
			}
		</script>
<!--菜单树结束-->
			<input type="hidden" name="cmd" value="saveAuByVisitor">
			<input type="hidden" name="ids" value="">
			<input type="hidden" name="codes" value="">
			<input type="hidden" name="status" value="">
			<input type="hidden" name="types" value="">
			<input type="hidden" name="access" value="">
			<input type="hidden" name="vId" value="<%=(String)request.getAttribute("vId")%>">
			<input type="hidden" name="vCode" value="<%=(String)request.getAttribute("vCode")%>">
			<input type="hidden" name="vType" value="<%=(String)request.getAttribute("vType")%>">
			<input type="hidden" name="auType" value="<%=GlobalConstants.getResType_menu()%>">
			</td> 
		</tr> 
    </table>
<script language="javascript">
	function saveOnClick() {
	
		var ids = "";
		var codes = "";
		var types = "";
		var status = "";
		var access = "";
		
		for(var i=0; i<inputArray.length; i++) {
			var cbx = inputArray[i];	//全部的checkbox
			var selCbx = new Array(0);	//选中的checkbox
			for(var j=0; j<cbx.length; j++) {
				if(cbx[j].checked && !cbx[j].disabled) {
					selCbx[selCbx.length] = cbx[j];
				}
			}
			if(selCbx.length>0) {
				var selStatus = "2";//授权状态（拒绝0，允许1）
				var selAccess = 1; 	//权限种类（用素数表示，例如：可授权2，只读3，可写5...）
				for(var k=0; k<selCbx.length; k++) {
					if(selCbx[k].value=="0" || selCbx[k].value=="1") {
						selStatus = selCbx[k].value;
					}else {
						selAccess = selAccess * selCbx[k].value;//用素数的乘积表示多种权限种类的组合
					}
				}
				status += selStatus + ",";
				access += selAccess + ",";
				ids += selCbx[0].name + ",";
				codes += jQuery(selCbx[0]).attr("code") + ",";
				types += jQuery(selCbx[0]).attr("sType") + ",";
			}
		}
		if(ids!="") {
			ids = ids.substring(0,ids.length-1);
			document.form.ids.value=ids;
		}
		if(codes!="") {
			codes = codes.substring(0,codes.length-1);
			document.form.codes.value=codes;
		}
		if(types!="") {
			types = types.substring(0,types.length-1);
			document.form.types.value=types;
		}
		if(status!="") {
			status = status.substring(0,status.length-1);
			document.form.status.value=status;
		}
		if(access!="") {
			access = access.substring(0,access.length-1);
			document.form.access.value=access;
		}

		form.action="<venus:base/>/AuAuthorizeAction.do";
		form.submit();
	}
</script>
</form>
</body>
</html>
<%
} catch(Exception e) {
	e.printStackTrace();
}
%>

