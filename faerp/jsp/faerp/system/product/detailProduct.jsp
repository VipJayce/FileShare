<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="gap.dd.util.GapDDHelper" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@ page import="rayoo.system.product.util.IProductConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />

<%  //取出本条记录
	ProductVo resultVo = null;  //定义一个临时的vo变量
    AttachmentfileVo avo=null;//附件VO
    List list =null;
    boolean isModify = true;  //定义变量,标识本页面是否修改(或者新增)
	resultVo = (ProductVo)request.getAttribute(IProductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	//RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
    if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
        avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
    }
	
    if(request.getAttribute("sublist") != null) {  //如果request中取出的bean不为空
        list = (List)request.getAttribute("sublist");  
    }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function historyshow(falg){
         var url="<%=request.getContextPath()%>/ProductAction.do?cmd=getProductHistoryPage&product_id="+falg;
         url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
         showModalCenter(url, window, "", 500, 300, "历史修改记录");  //增加子岗位
    }
</script>
</head>
<body>
 
<form name="form" method="post">
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
<div id="ccChild0" class="box_3"> 

	<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="12%" class="td_1" >产品大类</td>
            <td width="19%" class="td_2" ><%=BaseDataHelper.getNameByCode("big_type_id",RmStringHelper.prt(resultVo.getBig_type_id()))%></td>
            <td width="17%" class="td_1" >产品小类</td>
            <td width="22%" class="td_2" ><%=BaseDataHelper.getNameByCode("big_type_id",RmStringHelper.prt(resultVo.getSmall_type_id()))%> </td>
            <td width="12%" class="td_1" >产品三级分类</td>
            <td width="18%" class="td_2" ><%=BaseDataHelper.getNameByCode("big_type_id",RmStringHelper.prt(resultVo.getThree_type_id()))%></td>
        </tr>
        <tr>
          <td class="td_1" >产品名称</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_name())%></td>
               <td class="td_1" >产品英文名称</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_en_name())%></td>
          <td class="td_1" ></td>
          <td class="td_2" ></td>
        </tr>
        <tr>
         <td class="td_1" >是否定方案产品</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_scheme()))%></td>
          <td class="td_1" >方案类型</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("scheme_type",RmStringHelper.prt(resultVo.getScheme_type()))%></td>
          <td class="td_1" ></td>
          <td class="td_2" ></td>
        </tr>
        <tr>
          <td class="td_1" >生效日期</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getEffect_date(), 10)%></td>
          <td class="td_1" >失效日期</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getLapse_date(), 10)%></td>
          <td class="td_1" >标准成本</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_cost())%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <% 
          int count_history=GapDDHelper.queryForInt(" select count(*) from pb_product_history p where p.product_id='"+resultVo.getId()+"' ");
          if(count_history>0){
              out.print("<a href=\"###\" onClick=\"javascript:historyshow('"+resultVo.getId()+"');\"><font color=blue>修改记录</font></a>");
          }
          %>
          </td>
        </tr>
        <tr>
          <td class="td_1" >标准价格</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_price())%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <% 
          if(count_history>0){
              out.print("<a href=\"###\" onClick=\"javascript:historyshow('"+resultVo.getId()+"');\"><font color=blue>修改记录</font></a>");
          }
          %>
          </td>
          <td class="td_1" >是否可报销</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_reimbursement()))%></td>
          <td class="td_1" >是否按天计算</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_calculate_per_day()))%></td>
        </tr>
        <tr>
          <td class="td_1" >是否一次性付款</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_payall()))%></td>
          <td class="td_1" >入职时是否可修改</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getOnpost_input()))%></td>
          <td class="td_1" >产品供应商名称</td>
          <td class="td_2" >
          <%= (resultVo.getProduct_supplier()!=null&&resultVo.getProduct_supplier()!="") ? agentaction.getAgentNameByID(resultVo.getProduct_supplier().toString()) : ""%> 
          </td>
        </tr>
        <tr>
          <td class="td_1" >是否可补收</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_subpay()))%></td>
          <td class="td_1" >产品所属部门</td>
          <td class="td_2" >
            <%=(resultVo.getProduct_dept()!=null&&resultVo.getProduct_dept()!="")  ? OrgHelper.getPartyVoByID(resultVo.getProduct_dept().toString()).getName() : ""%>
          </td>
          <td class="td_1" >收费频率(财务外包)</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("FINOUT_PRODUCT_TYPE",RmStringHelper.prt(resultVo.getCharging_frequency()))%></td>
        </tr>
        <%
        if((BaseDataHelper.getNameByCode("big_type_id",RmStringHelper.prt(resultVo.getBig_type_id())).equals("福利产品"))) {%>
        <tr>
          <td class="td_1" >发放频率</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("GRANT_FREQUENCY",RmStringHelper.prt(resultVo.getGrant_frequency()))%></td>
          <td class="td_1" >发放张数</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getGrant_counts())%></td>
          <td class="td_2" >&nbsp;</td>
          <td class="td_2" ></td>
        </tr>
        <%} %>
        
       <tr>
          <td class="td_1" >财务汇总科目</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("FIN_BIG_SUBJECTS_BD",RmStringHelper.prt(resultVo.getFin_big_subjects_bd()))%></td>
          <td class="td_1" >财务明细科目</td>
          <td class="td_2" ><%=BaseDataHelper.getNameByCode("FIN_SUBJECTS_BD",RmStringHelper.prt(resultVo.getFin_small_subjects_bd()))%></td>
          <td class="td_1" >排序</td>
          <td class="td_2" ><%=resultVo.getSirial_no()!=null ? resultVo.getSirial_no() : "" %>&nbsp;</td>
        </tr>
        <tr>
          <td class="td_1" >创建人</td>
          <td class="td_2" ><%=OrgHelper.getPartyVoByID(resultVo.getCreate_user().toString()).getName()%></td>
          <td class="td_1" >创建日期</td>
          <td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_date(), 10)%></td>
          <td class="td_2" >&nbsp;</td>
          <td class="td_2" ></td>
        </tr>
        <tr>
          <td class="td_1" >产品简单描述</td>
          <td colspan="5" class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_simple_desc())%></td>
          </tr>
        <tr>
          <td class="td_1" >产品详细描述</td>
          <td colspan="5" class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_detail_desc())%></td>
          </tr>
		    <%
			if(avo!=null){
			%>      
          <tr>
          <td class="td_1" >附件名称</td>
          <td colspan="5" class="td_2" ><% if(isModify&&avo!=null){out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");}%>&nbsp;</td>
          </tr>
          <%}%>
	</table>
</div>


<%
if(list!=null&&list.size()>0){
%>
<div class="box_xinzeng_table">
<table  id="tab" width="100%" cellspacing="0"  class="datagrid1">
<tr>
  <th>序号</th>
  <th>产品名称</th>
  <th>产品大类</th>
  <th>产品小类</th>
  <th>产品三级分类</th>
</tr>
 <%
         for(int i=0;i<list.size();i++){
             ProductVo pvo=(ProductVo)list.get(i);
         {%>
   <tr id="tr<%=pvo.getId()%>">
   <td><%=i+1%></td>
   <input type="hidden" name="trid" value="<%=pvo.getId()%>">
   <td >&nbsp;<%=pvo.getProduct_name()%></td>
   <td>&nbsp;<%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getBig_type_id()))%></td>
   <td>&nbsp;<%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getSmall_type_id()))%></td>
   <td>&nbsp;<%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getThree_type_id()))%></td>
 </tr>
 <%}}%>
</table>
</div>
 <%} %>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
