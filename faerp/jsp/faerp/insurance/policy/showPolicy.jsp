<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.policy.vo.PolicyVo" %>
<%@ page import="rayoo.insurance.policy.util.IPolicyConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	PolicyVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IPolicyConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (PolicyVo)request.getAttribute(IPolicyConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/PolicyAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' name='temp'  onClick=ClickRow(\"" + entity.getProperty("policy_item_id") + "\");>";
    }
    function ClickRow(policy_item_id){
        //alert("policy_item_id="+policy_item_id);
        $id("policy_item_id_temp").value=policy_item_id;
        $id("datacell2").addParam("policy_item_id",policy_item_id);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
</script>
</head>
<body>

<form name="form" method="post">
<input type="hidden" name="policy_item_id_temp" id="policy_item_id_temp">
<div id="right">
 <div class="ringht_s">
<div id="ccParent0" class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="25%">保单编号</td>
            <td class="td_2" width="25%"><%=resultVo.getPolicy_code() %></td>
            <td class="td_1" width="25%">保单名称</td>
            <td class="td_2" width="25%"><%=resultVo.getPolicy_name() %></td>
          </tr>
          <tr>
            <td class="td_1">保单类型</td>
            <td class="td_2"><%= BaseDataHelper.getNameByCode("POLICY_TYPE_BD",String.valueOf(resultVo.getPolicy_type())) %></td>
            <td class="td_1">保险开始日期</td>
            <td class="td_2"><fmt:formatDate value="${bean.policy_str_date}" pattern="yyyy-MM-dd"/></td>
          </tr>
          <tr>
            <td class="td_1">保险结束日期</td>
            <td class="td_2"><fmt:formatDate value="${bean.policy_end_date}" pattern="yyyy-MM-dd"/></td>
            <td class="td_1">公共保额</td>
            <td class="td_2"><%=resultVo.getPublic_insurance()==null?"":resultVo.getPublic_insurance() %></td>
          </tr>
          <tr>
            <td class="td_1">保险公司名称</td>
            <td class="td_2"><%=resultVo.getInsurance_agent_name() %></td>
            <td class="td_1">结算方式</td>
            <td class="td_2"><%= BaseDataHelper.getNameByCode("CLEARING_MODE_BD",String.valueOf(resultVo.getClearing_mode())) %></td>
          </tr> 
          <tr>
            <td class="td_1">支付方式</td>
            <td class="td_2"><%= BaseDataHelper.getNameByCode("PAY_MODE_BD",String.valueOf(resultVo.getPay_mode())) %></td>
            <td class="td_1">追溯期</td>
            <td class="td_2"><%=resultVo.getBack_stage() %></td>
          </tr>
          <tr>
            <td class="td_1">是否开放公立一级医院</td>
            <td class="td_2"><%= BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_open_pb_hospital())) %></td>
            <td class="td_1">是否开放定点私立医院</td>
            <td class="td_2"><%= BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_open_private_hospital())) %></td>
          </tr>  
          <tr>
            <td class="td_1">备注</td>
            <td colspan="5" class="td_2" ><%=resultVo.getRemark()==null?"":resultVo.getRemark() %></td>
          </tr>        
	</table></div>
    <div class="mx_button"  align="center">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
       </div>
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
