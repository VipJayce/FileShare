<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.insurance.insuranceaegnt.vo.InsuranceAegntVo" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%@ page import="rayoo.insurance.insuranceaegnt.util.IInsuranceAegntConstants" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	InsuranceAegntVo resultVo = null;  //定义一个临时的vo变量
    AttachmentfileVo avo=null;//附件VO    
    String Insurance_agent_type = "";  //供应商类型
    String Security_agent_type = "";  //保险供应商
	if(request.getAttribute(IInsuranceAegntConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (InsuranceAegntVo)request.getAttribute(IInsuranceAegntConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	    Insurance_agent_type = resultVo.getInsurance_agent_type();
	    Security_agent_type = resultVo.getSecurity_agent_type();
	}
	if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
        avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
    }
	String attachName = avo==null?"":avo.getAttachment_file_name().toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
<div id="right">
<!--<script language="javascript">
     writeTableTopFesco('查看保险供应商','<%=request.getContextPath()%>/');
</script> 
 --><div class="ringht_s">
<div id="ccChild0"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="25%">供应商编号</td>
			<td class="td_2 " width="25%"><%=resultVo.getAgent_code() %></td>
			<td class="td_1" width="25%">供应商名称</td>
			<td class="td_2 " width="25%"><%=resultVo.getAgent_name() %></td>
		</tr>
		<tr>
            <td class="td_1" >供应商地址</td>
            <td class="td_2 "><%=resultVo.getAgent_address()==null?"":resultVo.getAgent_address() %></td>
            <td class="td_1" >保险公司业务员</td>
            <td class="td_2 "><%=resultVo.getSales_man()==null?"":resultVo.getSales_man() %></td>
        </tr>
        <tr>
            <td class="td_1" >保险公司业务员电话</td>
            <td class="td_2 "><%=resultVo.getSales_tel()==null?"":resultVo.getSales_tel() %></td>
            <td class="td_1" >保险公司业务员手机号码</td>
            <td class="td_2 "><%=resultVo.getSales_mobile()==null?"":resultVo.getSales_mobile() %></td>
        </tr>
        <tr>
            <td class="td_1" >保险公司业务员邮箱地址</td>
            <td class="td_2 "><%=resultVo.getSales_email()==null?"":resultVo.getSales_email() %></td>
            <td class="td_1" >供应商开户行</td>
            <td class="td_2 "><%=resultVo.getOpening_bank() %></td>            
        </tr>
        <tr>
            <td class="td_1" >银行账号</td>
            <td class="td_2 "><%=resultVo.getAccount() %></td>
            <td class="td_1" >保全时效</td>
            <td class="td_2 "><%=resultVo.getBq_validity()==null?"":resultVo.getBq_validity() %></td>
        </tr>
        <tr>
            <td class="td_1" >理赔时效</td>
            <td class="td_2 "><%=resultVo.getLp_validity()==null?"":resultVo.getLp_validity() %></td>
            <td class="td_1" >退单时效</td>
            <td class="td_2 "><%=resultVo.getTd_validity()==null?"":resultVo.getTd_validity() %></td> 
        </tr>
        <tr>
            <td class="td_1" >供应商类型</td>
            <td class="td_2 "><%= BaseDataHelper.getNameByCode("INSURANCE_AGENT_TYPE",String.valueOf(Insurance_agent_type)) %></td>
            <td class="td_1" ><%if(Insurance_agent_type.equals("")||Insurance_agent_type.equals("2")){ %>&nbsp;<%}else{ %>保险供应商类型<%} %></td>
            <td class="td_2 "><%if(Insurance_agent_type.equals("")||Insurance_agent_type.equals("2")){ %>&nbsp;<%}else{ %><%=BaseDataHelper.getNameByCode("SECURITY_AGENT_TYPE",String.valueOf(Security_agent_type))%><%} %></td>
        </tr>
		<tr>			
			<td class="td_1" >渠道类型</td>
            <td class="td_2 "><%= BaseDataHelper.getNameByCode("CHANNEL_TYPE_BD",String.valueOf(resultVo.getChannel_type_bd())) %></td>
            <td class="td_1" >&nbsp;</td>
            <td class="td_2 ">&nbsp;</td>
		</tr>		
		<tr>			
			<td class="td_1" >经纪公司</td>
            <td class="td_2 "><%=resultVo.getEconomic_cust()==null?"":resultVo.getEconomic_cust() %></td>
            <td class="td_1" >是否有效</td>
            <td class="td_2 "><%= BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_valid())) %></td>
		</tr>		
		<tr>
		    <td class="td_1">有效期限开始日期</td>
            <td class="td_2"><fmt:formatDate value="${bean.validity_str}" pattern="yyyy-MM-dd"/></td>
            <td class="td_1">有效期限截止日期</td>
            <td class="td_2"><fmt:formatDate value="${bean.validity_end}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td class="td_1" >上传附件</td>
			<td class="td_2" colspan="3">
                <span><% out.print("<font color=blue>"+attachName+"</font>");%>&nbsp;</span>
			</td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="3" class="td_2" ><%=resultVo.getRemark()==null?"":resultVo.getRemark() %></td>
		</tr>
	</table>
</div>
    <div class="mx_button" align="center">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div></div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
%>
</script>
