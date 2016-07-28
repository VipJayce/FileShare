<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="rayoo.sales.send.vo.SendVo"%>
<%@ page import="gap.rm.project.IToolsConstants"%>
<% pageContext.setAttribute("AGENT_SH",IToolsConstants.AGENT_SH);%>
<% pageContext.setAttribute("AGENT_BJ",IToolsConstants.AGENT_BJ);%>
<% pageContext.setAttribute("AGENT_WD",IToolsConstants.AGENT_WD);%>


<html>
<fmt:bundle basename="rayoo.salse.send.send_resource" prefix="rayoo.salse.send.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="modify_send"/></title>
<%
SendVo sendVo = (SendVo)request.getAttribute("sendVo");
%>
<script language="javascript">
    var venusbase = "<%=request.getContextPath()%>";
    var AGENT_BJ = "<%=IToolsConstants.AGENT_BJ%>";
    var AGENT_SH = "<%=IToolsConstants.AGENT_SH%>";
    var AGENT_WD = "<%=IToolsConstants.AGENT_WD%>";
    var CITY_ID_SH = "<%=IToolsConstants.CITY_ID_SH%>";
    var CITY_ID_BJ = "<%=IToolsConstants.CITY_ID_BJ%>"; 
    /*
     * modify by mahongmin
     */
  	function update_onClick(){  //保存修改后的单条数据
  	alert("in");
  	    checkSubmit("update");
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/SendAction.do?cmd=update";
        form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面<siqiaopeng修改>
       /* form.action="<%=request.getContextPath()%>/SendAction.do?cmd=queryAll&backFlag=false";
        form.submit();
        */
        window.close();
    }
    
    function todetailcontract(){
        form.action="<%=request.getContextPath()%>/SendAction.do?cmd=detailContract"
        form.submit();
    }
    //2015-2-3 yangyuting add 委派单填写指南 
    function noticeSend(){
    window.open('<%=request.getContextPath()%>/jsp/faerp/sales/send/noticeSend.jsp')
    }
    
    
    /**
     * @author 马宏敏
     * 选择合同后，点击添加按钮
     */
    function sendinsert(){
        var id = document.getElementById('contract_id_hidden').value;
        if(id==null || id == '') {
            alert('<fmt:message key="please_choose_contract"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/SendAction.do?cmd=querySendAdd&id=" + id;
        form.submit();
    }
	
	//页面加载完成后，用来判断委派单
	//共7个不能修改
	//已经在派出员工（合同签署）中被引用，那么委派单名称、派出公司、接收公司、收款方、帐单方、成本中心、接单客服就不允许修改，其他属性可以修改；
	_$(document).ready(function() {
        if (${allow_modify_all != null && allow_modify_all != '' }) {
          // _$("#send_name").attr("readonly", true);
        }
	});
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/faerp/sales/send/insertsend.js"></script>
</head>
<body>

<form name="form" method="post" id="newupdate">

<div id="right">
<script language="javascript">
        writeTableTopFesco('<fmt:message key="modify_send"/>','<%=request.getContextPath()%>/');
</script>

<div class="ringht_x">
<div id="ccChild1" class="box_xinzeng" style="width: 100%;height :100%;">
<div class="box_3">
    <!-- 修改 -->
    <input type="hidden" id="id" name="id" value="${sendVo.id }">
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"><fmt:message key="choose_contract"/></td>
          <td class="td_2" >
             <input type="hidden"" id="contract_id_hidden" name="contract_id" value="${sendVo.contract_id }"/>
             <input type="text" readonly="readonly" class="text_field" id="contract_name" name="contract_name" value="${sendVo.contract_name }"/>
          </td>
          <td class="td_1"><fmt:message key="customer_name"/></td>
          <td class="td_2">
          <input type="text" readonly="readonly" class="text_field" id="customer_name" name="customer_name" value="${sendVo.customer_name }"/>
          <input type="hidden" name="customer_id" value="${sendVo.customer_id }">
          <input type="hidden" name="customer_code" value="${sendVo.customer_code }">
          </td>
          <td class="td_2"><div class="button_right">
                <ul>
                    <!-- <li class="c_1"><a href="#" onclick="sendinsert();">添加</a></li>  -->
                    <!-- <li class="a_1"><a href="#" onclick="contractdetail();" ><fmt:message key="contract_query"/></a></li> -->
                    <li class="a_1"><a href="#" onclick="noticeSend();" >委派单指南</a></li><!--2015-2-3  yangyuting 把上面的合同查看替换为委派单指南 -->
                </ul>
            </div></td>
        </tr>
      </table>
    </div>
 <div class="box_3" >
     <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="send_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="send_name" name="send_name" value="${sendVo.send_name }"/>
            </td>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="cost_center"/></td>
            <td class="td_2 ">
            <c:choose>
                <c:when test="${allow_modify_all != null && allow_modify_all != '' }">
                    <input readonly="readonly" class="text_field" type="text" name="cost_center_name" id="cost_center_name" value="${sendVo.cost_center_name }"/>
                    <input type="hidden" name="cost_center_id" id="cost_center_id" value="${sendVo.cost_center_id }"/>
                </c:when>
                <c:otherwise>
                    <faerp:costCenterSelectTag tagname="cost_center_id"
		                beanname="sendVo" param="customer_id"
		                paramvalue="${sendVo.customer_id }" attribute="cost_center_id"/>
                </c:otherwise>
            </c:choose>    
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="cust_send_name"/></td>
            <td class="td_2 ">
            <c:choose>
                <c:when test="${allow_modify_all != null && allow_modify_all != '' }">
                    <input type="hidden" id="cust_send_id" name="cust_send_id" value="${sendVo.cust_send_id }">
                    <input readonly="readonly" class="text_field" type="text" id="cust_send_name" name="cust_send_name" value="${sendVo.cust_send_name }">
                </c:when>
                <c:otherwise>
                    <w:lookup 
		                onReturnFunc="rtnFunc" 
		                displayValue="${sendVo.cust_send_name }"
		                value="${sendVo.cust_send_id }"
		                lookupWidth="250px"  
		                id="cust_send_id" 
		                name="cust_send_id"
		                lookupUrl="/AgentAction.do?cmd=queryAllGetByID&queryType=2" 
		                messagekey="cust_send_name" height="430" width="680"
		                readonly="true"
		            />
		            <input type="hidden" id="cust_send_name" name="cust_send_name" value="${sendVo.cust_send_name }">
                </c:otherwise>
            </c:choose>
	        
            </td>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="cust_receive_name"/></td>
            <td class="td_2 "><!--
            <c:choose>
                <c:when test="${allow_modify_all == null && allow_modify_all == '' }">
                    <input type="hidden" id="cust_receive_id" name="cust_receive_id" value="${sendVo.cust_receive_id }">
                    <input readonly="readonly" class="text_field" type="text" id="cust_receive_name" name="cust_receive_name" value="${sendVo.cust_receive_name }">
                </c:when>
                <c:otherwise> -->
               <select name="cust_receive_id" id="cust_receive_id" style="width:250">
                     <option value="<%=IToolsConstants.AGENT_SH%>" <c:if test="${sendVo.cust_receive_id == AGENT_SH }">selected="selected"</c:if>>北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>" <c:if test="${sendVo.cust_receive_id == AGENT_BJ }">selected="selected"</c:if> >北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>" <c:if test="${sendVo.cust_receive_id ==AGENT_WD }">selected="selected"</c:if>>外地供应商</option>
               </select>
               <!-- </c:otherwise>
            </c:choose>
            --></td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="cust_payee_name"/></td>
            <td class="td_2 ">
            <c:choose>
                <c:when test="${allow_modify_all != null && allow_modify_all != '' }">
                    <input type="hidden" id="cust_payee_id" name="cust_payee_id" value="${sendVo.cust_payee_id }">
                    <input readonly="readonly" class="text_field" type="text" id="cust_payee_name" name="cust_payee_name" value="${sendVo.cust_payee_name }">
                </c:when>
                <c:otherwise>
                     <select name="cust_payee_id" id="cust_payee_id" style="width:250">
                        <option value="<%=IToolsConstants.AGENT_SH%>" <c:if test="${sendVo.cust_payee_id == AGENT_SH }">selected="selected"</c:if>>北京外企德科人力资源服务上海有限公司</option>
                        <option value="<%=IToolsConstants.AGENT_BJ%>" <c:if test="${sendVo.cust_payee_id == AGENT_BJ }">selected="selected"</c:if> >北京外企人力资源服务有限公司</option>
                        <option value="<%=IToolsConstants.AGENT_WD%>" <c:if test="${sendVo.cust_payee_id == AGENT_WD }">selected="selected"</c:if>>外地供应商</option>
               </select>
                </c:otherwise>
            </c:choose>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_bill_name"/></td>
            <td class="td_2 ">
            <c:choose>
	            <c:when test="${allow_modify_all != null && allow_modify_all != '' }">
	               <input readonly="readonly" class="" type="hidden" id="cust_bill_id" name="cust_bill_id" value="${sendVo.cust_bill_id }">
                   <input readonly="readonly" class="text_field" readonly="readonly" type="text" id="cust_bill_name" name="cust_bill_name" value="${sendVo.cust_bill_name }">
	            </c:when>
	            <c:otherwise>
	               <select name="cust_bill_id" id="cust_bill_id" style="width:250">
                        <option value="<%=IToolsConstants.AGENT_SH%>" <c:if test="${sendVo.cust_bill_id == AGENT_SH }">selected="selected"</c:if>>北京外企德科人力资源服务上海有限公司</option>
                        <option value="<%=IToolsConstants.AGENT_BJ%>" <c:if test="${sendVo.cust_bill_id == AGENT_BJ}">selected="selected"</c:if> >北京外企人力资源服务有限公司</option>
                        <option value="<%=IToolsConstants.AGENT_WD%>" <c:if test="${sendVo.cust_bill_id == AGENT_WD }">selected="selected"</c:if>>外地供应商</option>
                 </select>
	            </c:otherwise>
            </c:choose>
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><span class="style_required_red">*</span><fmt:message key="payment_day"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="payment_day" name="payment_day" value="${sendVo.payment_day }"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="payment_month"/></td>
            <td class="td_2 ">
                <d:select id="payment_month" name="payment_month" dictTypeId="PAYMENT_MONTH" value="${sendVo.payment_month }"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="receive_cs_name"/></td>
            <td class="td_2 ">
               <input readonly="readonly" class="text_field" type="hidden" id="receive_cs_id_hidden" name="receive_cs_id" value="${sendVo.receive_cs_id }">
               <input readonly="readonly" class="text_field" type="text" id="receive_cs_name" name="receive_cs_name" value="${sendVo.receive_cs_name }">
            </td>
            <td class="td_1" ><span class="style_required_red">*</span>是否CSS服务</td>
            <td class="td_2 ">
                <d:select id="is_employ_notice" name="is_employ_notice" dictTypeId="TrueOrFalse"  value="${sendVo.is_employ_notice }" ></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span>社保福利办理方</td>
            <td class="td_2 ">
                <!-- 
                <faerp:SoialunitSelectTag  tagname="security_unit_id" beanname="sendVo" attribute="security_unit_id"/>
                 -->
                 <r:comboSelect id="security_unit_id"  name="security_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
               messagekey="please_choose"
                width="200px"
                property="sendVo/security_unit_id"
            >
            </r:comboSelect>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_physical_examination"/></td>
            <td class="td_2 ">
                <d:select id="is_physical_examination" name="is_physical_examination" dictTypeId="TrueOrFalse" value="${sendVo.is_physical_examination }"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span>公积金福利办理方</td>
            <td class="td_2 ">
                <!-- 
                <faerp:SoialunitSelectTag  tagname="fund_security_unit_id" beanname="sendVo" attribute="fund_security_unit_id"/>
                 -->
                 <r:comboSelect id="fund_security_unit_id"  name="fund_security_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
               messagekey="please_choose"
                width="200px"
                property="sendVo/fund_security_unit_id"
            >
            </r:comboSelect>
            </td>
            <td class="td_1" ><span class="style_required_red">*</span>用退工福利办理方</td>
            <td class="td_2 ">
                <!-- 
                <faerp:SoialunitSelectTag  tagname="hire_security_unit_id" beanname="sendVo" attribute="hire_security_unit_id"/>
                 -->
                 <r:comboSelect id="hire_security_unit_id"  name="hire_security_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
               messagekey="please_choose"
                width="200px"
                property="sendVo/hire_security_unit_id"
            >
            </r:comboSelect>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="is_handicapped_monthly"/></td>
            <td class="td_2 ">
                <d:select id="is_handicapped_monthly_bd" name="is_handicapped_monthly_bd" dictTypeId="TrueOrFalse" value="${sendVo.is_handicapped_monthly_bd }"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>收费属性</td>
            <td class="td_2 ">
                    <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_preget", -1, "ISPREGET", sendVo.getIs_preget(), "", false)%>
                <!--<d:select id="is_preget" name="is_preget" dictTypeId="ISPREGET" value="${sendVo.is_preget }" ></d:select>-->
            </td>
        </tr>
        <tr>  
            <td  class="td_1" ><fmt:message key="subpackage_cost"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="subpackage_cost" name="subpackage_cost" value="${sendVo.subpackage_cost }"/>
            </td>
            <td class="td_1" ><fmt:message key="contract_person"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contract_person" value="${sendVo.contract_person }"/>
            </td>
        </tr>
        <tr>  
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="is_exclusive_security"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_security" name="is_exclusive_security" dictTypeId="TrueOrFalse" value="${sendVo.is_exclusive_security }"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="is_exclusive_accumulation"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_accumulation" name="is_exclusive_accumulation" dictTypeId="TrueOrFalse" value="${sendVo.is_exclusive_accumulation }"></d:select>
            </td>
        </tr>
        <tr>  
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_salary"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_salary" name="is_exclusive_salary" dictTypeId="TrueOrFalse" value="${sendVo.is_exclusive_salary }"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="is_exclusive_tax"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_tax" name="is_exclusive_tax" dictTypeId="TrueOrFalse" value="${sendVo.is_exclusive_tax }"></d:select>
            </td>
        </tr>
        <tr>  
           <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_fesco_report_tax"/></td>
            <td class="td_2 ">
                <d:select id="is_tax" name="is_tax" dictTypeId="TAX_FLAG" nullLabel="--请选择--" value="${sendVo.is_tax }"></d:select>
            </td> 
            <td class="td_1" ><span class="style_required_red">*</span><fmt:message key="city_name"/></td>
            <td class="td_2">
                <r:comboSelect id="city_id" name="city_id" value="${sendVo.city_id }"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                    messagekey="please_choose" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span>补医保开始日期规则</td>
            <td class="td_2 " >
                <d:select id="supp_medicare_start_rule" name="supp_medicare_start_rule" dictTypeId="SUPP_MED_START_RULE_BD" value="${sendVo.supp_medicare_start_rule }"></d:select>
            </td>
            <!-- 2015-6-9 yangyuting add start -->
            <td class="td_1" >是否收取劳动手册</td>
            <td class="td_2 ">
                <d:select id="is_laborbook" name="is_laborbook" dictTypeId="TrueOrFalse" nullLabel="请选择" value='${sendVo.is_laborBook }'></d:select>
            </td>
            <!-- 2015-6-9 yangyuting add end -->
        </tr>
         <tr>   
            <td class="td_1" ><fmt:message key="remark"/></td>
                <td colspan="3" class="td_2" ><span class="td_2 ">
                <textarea name="remarks" rows="3" class="xText_d" id="text22" style="width:96%;color: black;">${sendVo.remarks }</textarea>
              </span>
            </td>
        </tr>
        
    </table>
</div>
<div class="mx_button">
    <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="insert_onClick('update')" /><!-- yangyuting 2014-7-16判断提交的是更新还是新增 -->
    <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
</div>
</div>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    if (${msg != null && msg != '' }) {
        alert('${msg}');
    }
</script>
</body>
</html>

