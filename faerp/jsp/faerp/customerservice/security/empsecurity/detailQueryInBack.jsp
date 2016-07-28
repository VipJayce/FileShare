<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.QuerySocialSecurityVo" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%  //取出本条记录
    QuerySocialSecurityVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (QuerySocialSecurityVo)request.getAttribute(IEmpsecurityConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    String types = request.getAttribute("types")==null ? "" : request.getAttribute("types").toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.detailQueryInBack_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='detailQueryInBack0003'/></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
    window.close();
       /* var types = document.getElementById("types").value;
        if(types == "social_security_in_back"){
	        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryInBackFirst";
	        form.submit();
        }else if(types == "provident_fund_in_back"){
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryProvidentFundInBackFirst";
            form.submit();
        }else if(types == "town_insurance_in_back"){
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryTownInsuranceInBackFirst";
            form.submit();
        }else if(types == "complex_insurance_in_back"){
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryComplexInsuranceInBackFirst";
            form.submit();
        }else if(types == "offsite_social_security_in_back"){
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryOffsiteSocialSecurityInBackFirst";
            form.submit();
        }else if(types == "offsite_provident_fund_in_back"){
            form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=listQueryOffsiteProvidentFundInBackFirst";
            form.submit();
        }
        */
    }
</script>
</head>
<body>
 
<form name="form" method="post">
<input type="hidden" id="types" name="types" value="${types }"/>   
<div id="right">
   <div class="right_title_bg">
   <%if(types.equals("social_security_in_back")){ %>
    <div class=" right_title"><fmt:message key='detailQueryInBack0004'/></div>
    <%}else if(types.equals("provident_fund_in_back")){ %>
    <div class=" right_title"><fmt:message key='detailQueryInBack0005'/></div>
    <%}else if(types.equals("town_insurance_in_back")){ %>
    <div class=" right_title"><fmt:message key='detailQueryInBack0006'/></div>
    <%}else if(types.equals("complex_insurance_in_back")){ %>
    <div class=" right_title"><fmt:message key='detailQueryInBack0007'/></div>
    <%}else if(types.equals("offsite_social_security_in_back")){ %>
    <div class=" right_title"><fmt:message key='detailQueryInBack0008'/></div>
    <%}else if(types.equals("offsite_provident_fund_in_back")){ %>
    <div class=" right_title"><fmt:message key='detailQueryInBack0009'/></div>
    <%} %>
</div>
<div class="ringht_s">

<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0010'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0010'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0012'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0012'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >18<fmt:message key='detailQueryInBack0014'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0015'/>" value="<%=RmStringHelper.prt(resultVo.getId_card())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0016'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0016'/>" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0018'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0018'/>" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0020'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0020'/>" value="<%=RmStringHelper.prt(resultVo.getInternal_code())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0022'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0022'/>" value="<%=RmStringHelper.prt(resultVo.getBig_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0024'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0024'/>" value="<%=RmStringHelper.prt(resultVo.getSmall_name())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0026'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0026'/>" value="<%=RmStringHelper.prt(resultVo.getHire_unit_real_name())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0028'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0028'/>" value="<%=RmStringHelper.prt(resultVo.getStart_month())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0030'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0057'/>截止月" value="<%=RmStringHelper.prt(resultVo.getStop_date())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0032'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0032'/>" value="<%=RmStringHelper.prt(resultVo.getMonth_num())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0034'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0034'/>" value="<%=RmStringHelper.prt(resultVo.getPay_base())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0036'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0037'/>" value="<%=RmStringHelper.prt(resultVo.getMoney())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0038'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0038'/>" value="<%=RmStringHelper.prt(resultVo.getE_money())%>" readonly="readonly" />
            </td>
            <td class="td_1" ><fmt:message key='detailQueryInBack0040'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0040'/>" value="<%=RmStringHelper.prt(resultVo.getP_money())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='detailQueryInBack0042'/></td>
            <td class="td_2" >
                <input type="text" class="text_field" inputName="<fmt:message key='detailQueryInBack0057'/>办理日期" value="<%=RmStringHelper.prt(resultVo.getCreate_date(),10)%>" readonly="readonly" />
            </td>
            <td class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
    </table>
    
    </div> 
    <p></p>
    <div class="xz_title"><fmt:message key='detailQueryInBack0044'/></div>
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=searchUnremittedData&securityId=${securityId}"
        width="99%"
        height="320px"
        xpath="EmpsecurityitemVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="product_name" messagekey='detailQueryInBack0045'>
            <h:text/>
          </r:field>
          <r:field fieldName="product_ratio_name" messagekey='detailQueryInBack0046'>
               <h:text/>   
           </r:field>    
          <r:field fieldName="base" messagekey='detailQueryInBack0034'>
               <h:text/>
           </r:field>
          <r:field fieldName="e_ratio" messagekey='detailQueryInBack0048'>
            <h:text/>
          </r:field>
          <r:field fieldName="p_ratio" messagekey='detailQueryInBack0049'>
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey='detailQueryInBack0037'>
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey='detailQueryInBack0051'>
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey='detailQueryInBack0040'>
            <h:text/>
          </r:field>
          <r:field fieldName="e_add_money" messagekey='detailQueryInBack0053'>
            <h:text/>
          </r:field>
          <r:field fieldName="stop_man" messagekey='detailQueryInBack0054'>
            <h:text/>
          </r:field>
          <r:field fieldName="stop_date" messagekey='detailQueryInBack0055'>
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="stop_remarks" messagekey='detailQueryInBack0056'>
            <h:text/>
          </r:field>
    </r:datacell>
    </div>
    
    <p></p>
    <div class="xz_title"><fmt:message key='detailQueryInBack0057'/></div>
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell2"
        queryAction="/FAERP/EmpsecurityAction.do?cmd=searchInBackData&securityId=${securityId}"
        width="99%"
        height="320px"
        xpath="EmpsecuritysupplyVo"
        paramFormId="datacell_formid"
        readonly="true"
        >

          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="start_month" messagekey='detailQueryInBack0028'>
            <h:text/>
          </r:field>
          <r:field fieldName="end_month" messagekey="detailQueryInBack0030">
               <h:text/>   
           </r:field>    
          <r:field fieldName="fund_month" messagekey='detailQueryInBack0060'>
               <h:text/>   
           </r:field>    
          <r:field fieldName="base" messagekey='detailQueryInBack0034'>
               <h:text/>
           </r:field>
          <r:field fieldName="month_inback" messagekey="detailQueryInBack0062">
            <h:text/>
          </r:field>
          <r:field fieldName="money" messagekey='detailQueryInBack0037'>
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" messagekey='detailQueryInBack0051'>
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" messagekey='detailQueryInBack0040'>
            <h:text/>
          </r:field>
          <r:field fieldName="remarks" messagekey='detailQueryInBack0066' width="300px">
            <h:text/>
          </r:field>
    </r:datacell>
    </div>

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
</fmt:bundle>
</html>
