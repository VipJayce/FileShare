<%@ include file="/jsp/authority/tree/include/globalTreeCache.jsp" %>
<%@ page contentType="text/xml;charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.tree.DeepTreeXmlHandler"%>
<%@ page import="org.springframework.jdbc.core.RowMapper"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="gap.authority.util.tree.DeepTreeVo"%>
<%@ page import="gap.authority.util.ProjTools"%>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="gap.authority.au.auauthorize.bs.IAuAuthorizeBS"%>
<%@ page import="gap.authority.au.auauthorize.util.IConstants"%>
<%@ page import="gap.authority.au.auauthorize.vo.AuAuthorizeVo"%>
<%@ page import="gap.authority.au.auvisitor.bs.IAuVisitorBS"%>
<%@ page import="gap.authority.au.auvisitor.vo.AuVisitorVo"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%
try {
	//父级编码
	String parent_code = request.getParameter("parent_code");
	String relId = request.getParameter("relId");
	String pType = request.getParameter("pType");
    	
	String partyTypeId = "";
    if(parent_code.startsWith(GlobalConstants.getRelaType_role())){
        partyTypeId = GlobalConstants.getPartyType_role();
    }else if(parent_code.startsWith(GlobalConstants.getRelaType_proxy())){
        partyTypeId = GlobalConstants.getPartyType_proxy();
    }
    String strsql = "select * from au_partyrelation where parent_code='"+parent_code+"' "+("".equals(partyTypeId)?"":("and partytype_id='"+partyTypeId+"'"))+" order by order_code";
    List lParty = ProjTools.getCommonBsInstance().doQuery(strsql, new RowMapper() {
            public Object mapRow(ResultSet rs, int no) throws SQLException {
                HashMap map = new HashMap();
                map.put("id",rs.getString("id"));
				map.put("name",rs.getString("name"));
				map.put("code",rs.getString("code"));
				map.put("partyid",rs.getString("partyid"));
				map.put("is_leaf",rs.getString("is_leaf"));
				map.put("type_is_leaf",rs.getString("type_is_leaf"));
				map.put("relationtype_id",rs.getString("relationtype_id"));
				map.put("partytype_id",rs.getString("partytype_id"));
				return map;
            }
        });
	IAuVisitorBS visiBs = (IAuVisitorBS) Helper.getBean(gap.authority.au.auvisitor.util.IConstants.BS_KEY);
    AuVisitorVo visiVo = visiBs.queryByRelationId(relId, pType);
    
	String rType = GlobalConstants.getResType_orga();//记录
	IAuAuthorizeBS auBs = (IAuAuthorizeBS) Helper.getBean(IConstants.BS_KEY);
	//获取该访问者自身拥有权限的节点
    Map selIdMap = auBs.getAuByVisitorId(visiVo.getId(), rType);
    HashMap selCodeMap = new HashMap();
    for(Iterator it=selIdMap.keySet().iterator(); it.hasNext(); ) {
    	AuAuthorizeVo auVo = (AuAuthorizeVo)selIdMap.get((String)it.next());
    	selCodeMap.put(auVo.getResource_code(),"");
    }
    Set selSet = selCodeMap.keySet();
    //获取该访问者继承权限的节点
    Map extIdMap = auBs.getExtendAuByVisitorCode(visiVo.getCode(), rType);
    HashMap extCodeMap = new HashMap();
    for(Iterator it=extIdMap.keySet().iterator(); it.hasNext(); ) {
    	AuAuthorizeVo auVo = (AuAuthorizeVo)extIdMap.get((String)it.next());
    	extCodeMap.put(auVo.getResource_code(),"");
    }
    Set extSet = extCodeMap.keySet();
    
	DeepTreeXmlHandler dt = new DeepTreeXmlHandler();
	for(Iterator it = lParty.iterator(); it.hasNext(); ) {
		//获取节点的数据
		HashMap m_Party = (HashMap) it.next();
		String id = (String)m_Party.get("id");
		String name = (String)m_Party.get("name");
		String code = (String)m_Party.get("code");
		String partyId = (String)m_Party.get("partyid");
		String isLeaf = (String)m_Party.get("is_leaf");
		String typeIsLeaf = (String)m_Party.get("type_is_leaf");
		String relationType = (String)m_Party.get("relationtype_id");
		String partyType = (String)m_Party.get("partytype_id");
		
		//取当前操作者的数据权限，实现分级授权
		int authorize = 0; //表示：0不显示，1显示但不可操作，2可操作
		String[] data = null;
		if(LoginHelper.getIsAdmin(request)) {//超级管理员
			authorize = 2;
		}else {
			data = LoginHelper.getOwnerOrgWithoutHistory(request);
			if( data!=null) {
				for(int i=0; i<data.length; i++) {
					if(code.length()>data[i].length()) {
						if(code.substring(0,data[i].length()).equals(data[i])) {
							authorize = 2;
							break;
						}
					}
					else if(code.length()==data[i].length()){
						if(code.equals(data[i])) {
							authorize = 2;
							break;
						}
					}else {
						if(code.equals(data[i].substring(0,code.length()))) {
							authorize = 1;
							continue;
						}
					}
				}
			}
		}
		if(authorize==0) {
			continue; 
		}
				
		//构造节点
		DeepTreeVo dtv = new DeepTreeVo(code, name, "1".equals(isLeaf) ? "0" : "1", 
			request.getContextPath()+"/jsp/authority/au/auauthorize/org.jsp?parent_code="+code+"&relId="+relId+"&pType="+pType);
		//勾中已授权的节点
		if(extSet.contains(code)) {
			dtv.setIndeterminate("1");//因继承而拥有权限的节点置为不确定状态
		}
		if(selSet.contains(code)) {
			dtv.setIsSelected("1");//自身拥有权限的节点置为选中状态
		}

		if(authorize < 2) { //判断当前操作者是否有权限授权
			dtv.setIsSubmit("0");
		}
		
		//设置返回值
		dtv.setReturnValue(code);
		//设置返回类型
		dtv.setDetailedType(partyType);
		
		dt.addTreeNode(dtv);
	} 
    String xmlStr = dt.getStringFromDocument();
    out.print(xmlStr);
} catch(Exception e) {
	e.printStackTrace();
}
%>

