<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.org.auparty.vo.PartyVo" %>
<%@ page import="gap.authority.org.auparty.util.IConstants" %>
<%--!
	List empList = new ArrayList();
--%>
<%--
	String ids = "";
    List list = (List) request.getAttribute("linkedUserList");
    for (int i = 0; i < list.size(); i++) {
		AuPartyRelationVo vo = (AuPartyRelationVo) list.get(i);
		ids += "'" + vo.getPartyid() + "',";
    }
    if (ids != null && !"".equals(ids)) {
		ids = ids.substring(0, ids.length() - 1);
		String strsql = "SELECT * FROM AU_EMPLOYEE  WHERE ID IN (" + ids + ")";
		empList = ProjTools.getCommonBsInstance().doQuery(strsql,new RowMapper() {
			    public Object mapRow(ResultSet rs, int no) throws SQLException {
				HashMap map = new HashMap();
				map.put("id", rs.getString("id"));
				map.put("sex", rs.getString("sex"));
				map.put("email", rs.getString("email"));
				return map;
			    }
			});
    }
--%>
<%--!
	//根据partyid找到人员vo
    public Map getEmployee(Object partyId) {
		Map empMap = new HashMap();
		for (Iterator i = empList.iterator(); i.hasNext();) {
		    //获取节点的数据
		    empMap = (HashMap) i.next();
		    if (((String)partyId).equals((String)empMap.get("id")))
				break;
		}
		return empMap;
    }
--%>
<%
    //取出本条记录
    PartyVo resultVo = null; //定义一个临时的vo变量
    resultVo = (PartyVo) request.getAttribute(IConstants.REQUEST_BEAN_VALUE); //从request中取出vo, 赋值给resultVo
    VoHelperTools.replaceToHtml(resultVo); //把vo中的每个值过滤

    //判断是否为只读页面
    boolean isReadOnly = false; //定义变量,标识本页面是否修改(或者新增)
    if (request.getParameter("isReadOnly") != null) { //如果从request获得参数"isReadOnly"不为空
		isReadOnly = true; //赋值isReadOnly为true
    }
%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GAP<fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
<script language="javascript">
	function toAddRole_onClick() {  //到增加记录页面
		var relationId = document.form.relationId.value;
		window.location="<%=request.getContextPath()%>/jsp/authority/au/aurole/insertAuRole.jsp?parentRelId="+relationId;
	}
	function toAddUser_onClick() {  //到增加记录页面
		var id = document.form.id.value;
		var refPath = "<venus:base/>/jsp/authority/au/aurole/userRefFrame.jsp?roleId="+id;
		var rtObj = window.showModalDialog(refPath, new Object(),'dialogHeight=600px;dialogWidth=1000px;resizable:yes;status:no;scroll:auto;');
		if(rtObj != undefined && rtObj.length > 0) {
			var partyIds = "";
			for(var i=0; i<rtObj.length-1; i++) {
				partyIds += rtObj[i] + ",";
			}
			partyIds += rtObj[rtObj.length-1];
			
			var relationId = document.form.relationId.value;
			form.action="<%=request.getContextPath()%>/AuRoleAction.do?cmd=addMultiRelation&partyIds="+partyIds+"&parentRelId="+relationId;
			form.submit();
		}
	}
	function toDelUser_onClick() {
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("<fmt:message key='gap.authority.Please_Select_Records' bundle='${applicationAuResources}' />!")
			return;
		}
		if(confirm("<fmt:message key='gap.authority.It_completely_remove_the_data_' bundle='${applicationAuResources}' />")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/AuRoleAction.do?cmd=deleteMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function toSort_onClick() {  //到排序页面
		var parentRelId = document.form.AuRoleId.value;
		window.location="<%=request.getContextPath()%>/jsp/authority/sample/AuRole/sort.jsp?parentRelId="+parentRelId;
	}
	function find_onClick(){  //直接点到修改页面
		form.action="<%=request.getContextPath()%>/AuRoleAction.do?cmd=find";
		form.submit();
	}
	function delete_onClick(){  //直接点删除单条记录
		if(!confirm("<fmt:message key='gap.authority.It_completely_remove_the_role_' bundle='${applicationAuResources}' />")) {
			return false;
		}
		form.action="<%=request.getContextPath()%>/AuRoleAction.do?cmd=delete";
		form.target="_parent";
		form.submit();
	}
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				ids.push(elementCheckbox[i].value);  //加入选中的checkbox
			}
		}
		return ids;
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		if(checkAllForms()){
			form.action = "<%=request.getContextPath()%>/AuRoleAction.do?cmd=detail";
    		form.submit();
    	}
  	}	
	function clear_onClick() { //清空查询条件
		form.name.value = "";
	}  	
	function search_onKeyDown() {//回车后执行页面查询功能
		if (event.keyCode == 13) { 
			simpleQuery_onClick();
		}
	}		
</script>
</head>
<body>

<form name="form" method="post">

<div class="tissue_right">
  <div class="ringht_s">
    <!--查询 --><!--查询 end-->
    <!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div class="xz_title" style="background:#f2fbff; overflow: auto;" >详细页面</div>
    <div class="button">
      <div class="button_right">
        <ul>
 

			<% if (isReadOnly) {%>
				<input name="button_back" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onclick="javascript:returnBack()" >
			<li class="a"><a onClick="javascript:returnBack()"><fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' /></a></li>
			<%} else {%>
			<!--input name="button_sort" class="button_ellipse" type="button" value="排序" onClick="javascript:toSort_onClick();"-->
			          <li class="a"><a onClick="javascript:toAddRole_onClick();">添加下级角色</a></li>
			
			  <li class="a"><a onClick="javascript:find_onClick();">修改角色</a></li>
          <li class="d"><a onclick="javascript:delete_onClick();">删除角色</a></li>
           <li class="a"><a onClick="javascript:toAddUser_onClick();">关联用户</a></li>
          <li class="d"><a onclick="javascript:toDelUser_onClick();">删除用户</a></li>
			<%}%>


 
        

        </ul>
      </div>
      <div class="clear"></div>
    </div>
    <div class="box" style="height:200px;">
      
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th colspan="2"  class="fex_row">角色的详细信息</th>
          </tr>
       <tr>
		    </tr>
        <tr>
          <td width="10%" class="fex_row">角色名称</td>
          <td class="fex_row"><%=StringHelperTools.prt(resultVo.getName())%></td>
          </tr>
        <tr>
          <td class="fex_row">备注</td>
          <td class="fex_row"><%=StringHelperTools.prt(resultVo.getRemark())%></td>
          </tr>
        <tr>
          <td class="fex_row">创建时间</td>
          <td class="fex_row"><%=StringHelperTools.prt(resultVo.getCreate_date(),
				    19)%></td>
        </tr>
        <tr>
          <td class="fex_row">修改时间</td>
          <td class="fex_row"><%=StringHelperTools.prt(resultVo.getModify_date(),
				    19)%></td>
          </tr>

      </table>
</div>
    <div class="box" style="height:180px; overflow: auto;">
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th colspan="5"  class="fex_row">已关联用户列表</th>
          </tr>
        <tr>
          <td width="5%" align="right" class="fex_row">名称</td>
          <td colspan="4" class="fex_row"><input name="name" type="text" class="sText" id="name" value=""/><!-- 修改了ID和NAME的值 siqp修改 -->
            <input type="button" name="button" id="button" value="查询" onclick="javascript:simpleQuery_onClick()"> <input type="reset" name="button" id="button" value="清空"></td>
          </tr>
        <tr>
          <td bgcolor="#ebebeb" class="fex_row"><input type="checkbox" name="checkbox22" value="checkbox"></td>
          <td bgcolor="#ebebeb" class="fex_row">序号</td>
          <td bgcolor="#ebebeb" class="fex_row">编号</td>
          <td bgcolor="#ebebeb" class="fex_row">名称</td>
          <td bgcolor="#ebebeb" class="fex_row">邮箱</td>
          </tr>
     <logic:iterate     name="linkedUserList"  id="linkedUserList" scope="request" indexId="orderNumber">
		<tr>
		<td class="fex_row"> 	<bean:define id="partyRelationId" name="linkedUserList" property="id"/>
					<input type="checkbox" name="checkbox_template" value="<%=partyRelationId%>"/></td>
 <td>${orderNumber}  </td>
<td><bean:write name="linkedUserList" property="partyid"/>   </td>
			
			<td><bean:write name="linkedUserList" property="name"/>   </td>
			
			<td><bean:write name="linkedUserList" property="email"/>   </td>
			
			</tr>
</logic:iterate>
      
      </table>
    </div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
	 <!--表格2--><!--表格2 end-->
    </div>
</div>


<input type="hidden" name="id" value="<%=resultVo.getId()%>">
<input type="hidden" name="relationId" value="<%=request.getParameter("relationId")%>">
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%
    //表单回写
    if (request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map) request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
    }
%>

