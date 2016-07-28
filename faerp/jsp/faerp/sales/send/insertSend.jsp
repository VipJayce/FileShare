<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.project.IToolsConstants"%>

<html>
<fmt:bundle basename="rayoo.salse.send.send_resource" prefix="rayoo.salse.send.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="add_send"/></title>
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
  	    checkSubmit();
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/SendAction.do?cmd=update";
        form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
       // form.action="<%=request.getContextPath()%>/SendAction.do?cmd=queryAll&backFlag=false";
       // form.submit();
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
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/faerp/sales/send/insertsend.js"></script>
</head>
<body>

<form name="form" method="post" id="newinsert">

<div id="right">
<script language="javascript">
        writeTableTopFesco('<fmt:message key="add_send"/>','<%=request.getContextPath()%>/');
</script>
<div class="ringht_x">
<div id="ccChild1" class="box_xinzeng" style="width: 100%;height :100%;"> 
<div class="box_3">
    <!-- 新增 -->
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"><fmt:message key="choose_contract"/></td>
          <td class="td_2" >
          <w:lookup onReturnFunc="toFindContract"
          readonly="true" id="contract_id"
          name="contract_id" 
          displayValue="${salcontractVo.contract_name }"
          value="${salcontractVo.id }"
          lookupUrl="/jsp/faerp/common/sales/alllistSalcontract.jsp"
          messagekey="choose_contract"
          height="444" width="800" style="width:188px"/>
          </td>
          <td class="td_1"><fmt:message key="customer_name"/></td>
          <td class="td_2">
          <input type="text" class="text_field" id="customer_name" name="customer_name" value="${salcontractVo.customer_name }"/>
          <input type="hidden" name="customer_id" value="${salcontractVo.customer_id }">
          <input type="hidden" name="customer_code" value="${salcontractVo.customer_code }">
          <!-- 合同表中的合同客服，为委派单表中的派单客服  -->
          <input type="hidden" name="send_cs_id" value="${salcontractVo.service_user_id }">
          </td>
          <td class="td_2">
            <div class="button_right">
                <ul>
                    <!-- <li class="c_1"><a href="#" onclick="sendinsert();">添加</a></li>-->
                    <!-- <li class="a_1"><a href="#" onclick="contractdetail();" ><fmt:message key="contract_query"/></a></li> -->
                    <li class="a_1"><a href="#" onclick="noticeSend();" >委派单指南</a></li><!--2015-2-3  yangyuting 把上面的合同查看替换为委派单指南 -->
                </ul>
            </div>
          </td>
        </tr>
    </table>
</div>
<c:if test="${open == 'block' }">
 <div class="box_3" >
     <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="send_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="send_name" name="send_name" value=""/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cost_center"/></td>
            <td class="td_2 ">
            <!-- 2014-6-25 yangyuting -->
            <r:comboSelect id="cost_center_id" name="cost_center_id" value="${cost_center_id   }"
                       queryAction="/FAERP/SendAction.do?cmd=getListData&contract_id=${contract_id}"
                       textField="cost_center_name"
                       valueField="id"
                       xpath="CostcenterVo"
                       width="265px"
                      messagekey="please_choose" ></r:comboSelect>
                      <!--
                 <faerp:costCenterSelectTag tagname="cost_center_id" 
                  beanname="cost_center_id" param="customer_id"
                paramvalue="${salcontractVo.customer_id }"  style="width: 265px"/>
          --></td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_send_name"/></td>
            <td class="td_2 ">
            <input type="hidden" id="cust_send_id" name="cust_send_id" value="${sendVo.cust_send_id }">
            <input type="text" class="text_field" style="width: 265px" readonly="readonly" id="cust_send_name" name="cust_send_name" value="${sendVo.cust_send_name }">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_receive_name"/></td>
            <td class="td_2 ">
                <select name="cust_receive_id" id="cust_receive_id" style="width:250">
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_payee_name"/></td>
            <td class="td_2 ">
                <select name="cust_payee_id" id="cust_payee_id" style="width:250">
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_bill_name"/></td>
            <td class="td_2 ">
                <select name="cust_bill_id" id="cust_bill_id" style="width:250">
                     <option value="<%=IToolsConstants.AGENT_SH%>">北京外企德科人力资源服务上海有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_BJ%>">北京外企人力资源服务有限公司</option>
                     <option value="<%=IToolsConstants.AGENT_WD%>">外地供应商</option>
               </select>
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><span class="style_required_red">* </span><fmt:message key="payment_day"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="payment_day" name="payment_day" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="payment_month"/></td>
            <td class="td_2 ">
                <d:select id="payment_month" name="payment_month" dictTypeId="PAYMENT_MONTH" value="0"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="receive_cs_name"/></td>
            <td class="td_2 ">
            <input type="hidden" id="receive_cs_id_hidden" name="receive_cs_id" value="${loginid}">
            <input type="text" class="text_field" id="loginname" name="loginname" value="${loginname }" readonly="readonly">
            <!-- 
            r:comboSelect id="receive_cs_id" name="receive_cs_id" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                textField="name" valueField="partyid" xpath="Partyrelation" width="200px"  nullText="--请选择--"
                readonly="true" property="loginid"
              -->
                <!-- 本来是要把合同的合同客服作为委派单的接单客服使用，但现在此业务取消 property="salcontractVo/service_user_id" -->
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>是否CSS服务</td>
            <td class="td_2 ">
                <d:select id="is_employ_notice" name="is_employ_notice" dictTypeId="TrueOrFalse"  nullLabel="请选择"></d:select>
            </td>
        </tr>
        <tr>   
            <td class="td_1" ><span class="style_required_red">* </span>社保福利办理方</td>
            <td class="td_2 ">
            <r:comboSelect id="security_unit_id"  name="security_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey="please_choose"
                width="200px"
            >
            </r:comboSelect>
            <!-- property="sendVo/security_unit_id"  此为默认值，但现在默认改为空 -->
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_physical_examination"/></td>
            <td class="td_2 ">
                <d:select id="is_physical_examination" name="is_physical_examination" dictTypeId="TrueOrFalse" value="0"></d:select>
            </td>
        </tr>
        <tr>   
            <td class="td_1" ><span class="style_required_red">* </span>公积金福利办理方</td>
            <td class="td_2 ">
            <r:comboSelect id="fund_security_unit_id"  name="fund_security_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey="please_choose"
                width="200px"
            >
            </r:comboSelect>
            <!-- property="sendVo/security_unit_id"  此为默认值，但现在默认改为空 -->
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>用退工福利办理方</td>
            <td class="td_2 ">
            <r:comboSelect id="hire_security_unit_id"  name="hire_security_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunitNew"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey="please_choose"
                width="200px"
            >
            </r:comboSelect>
            <!-- property="sendVo/security_unit_id"  此为默认值，但现在默认改为空 -->
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_handicapped_monthly"/></td>
            <td class="td_2 ">
                <d:select id="is_handicapped_monthly_bd" name="is_handicapped_monthly_bd" dictTypeId="TrueOrFalse" nullLabel="请选择"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>收费属性</td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_preget", -1, "ISPREGET", "", "", false)%>
                <!--<d:select id="is_preget" name="is_preget" dictTypeId="ISPREGET" value="0"></d:select>-->
            </td>
        </tr>
        <tr>    
            <td  class="td_1" ><fmt:message key="subpackage_cost"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="subpackage_cost" name="subpackage_cost" />
            </td> 
            <td class="td_1" ><fmt:message key="contract_person"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contract_person" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_security"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_security" name="is_exclusive_security" dictTypeId="TrueOrFalse" value="1"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_accumulation"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_accumulation" name="is_exclusive_accumulation" dictTypeId="TrueOrFalse" value="1"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*  </span><fmt:message key="is_exclusive_salary"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_salary" name="is_exclusive_salary" dictTypeId="TrueOrFalse" value="1"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_tax"/></td>
            <td class="td_2 ">
                <d:select id="is_exclusive_tax" name="is_exclusive_tax" dictTypeId="TrueOrFalse" value="1"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key="city_name"/></td>
            <td class="td_2" >
                <r:comboSelect id="city_id" name="city_id" value="${city_id }"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                      messagekey="please_choose" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_fesco_report_tax"/></td>
            <td class="td_2 ">
                <d:select id="is_tax" name="is_tax" dictTypeId="TAX_FLAG"  nullLabel="--请选择--"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*</span>补医保开始日期规则</td>
            <td class="td_2 ">
                <d:select id="supp_medicare_start_rule" name="supp_medicare_start_rule" dictTypeId="SUPP_MED_START_RULE_BD" value="${sendVo.supp_medicare_start_rule }"></d:select>
            </td>
            <!-- 2015-6-5 yangyuting add start -->
            <td class="td_1" >是否收取劳动手册</td>
            <td class="td_2 ">
                <d:select id="is_laborbook" name="is_laborbook" dictTypeId="TrueOrFalse" nullLabel="请选择"></d:select>
            </td>
            <!-- 2015-6-5 yangyuting add end -->
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="remark"/></td>
                <td colspan="3" class="td_2" ><span class="td_2 ">
	            <textarea name="remarks" rows="3" class="xText_d" id="text22" style="width:96%;color: black;"></textarea>
	          </span>
            </td>
        </tr>
    </table>
 </div>
<div class="mx_button">
    <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="insert_onClick('save')" /><!-- yangyuting 2014-7-16判断提交的是更新还是新增 -->
    <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
</div>
</c:if>

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

