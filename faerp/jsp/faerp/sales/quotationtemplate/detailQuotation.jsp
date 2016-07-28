<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="gap.rm.tools.helper.*"%>
<%@ page import="rayoo.sales.quotationtemplate.vo.QuotationVo"%>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@ page import="rayoo.sales.quotationtemplate.util.IQuotationConstants"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%
    //取出本条记录
    QuotationVo resultVo = null; //定义一个临时的vo变量
    List list =null;
    resultVo = (QuotationVo) request
            .getAttribute(IQuotationConstants.REQUEST_BEAN); //从request中取出vo, 赋值给resultVo
    String isDetailBD = resultVo.getIs_detail_bd();
    
    if(request.getAttribute("list") != null) {  //如果request中取出的bean不为空
        list = (List)request.getAttribute("list");  
    }
%>
<html>
<fmt:bundle basename="rayoo.salse.quotationtemplate.quotationtemplate_resource" prefix="rayoo.salse.quotationtemplate.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/QuotationtemplateAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    

</script>
	</head>
	<body>

	<form name="form" method="post">

	       <div id="right">

        <div class="ringht_s">
 
<div id="ccParent0" class="box_3"> 
 <div class="xz_title"><fmt:message key="basic_information"/></div>
   <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="30%" class="td_1"><fmt:message key="template_name"/>：</td>
            <td width="24%" class="td_2">
                 <input type="text" class="text_field" inputName="模板名称"
                  value="<%=RmStringHelper.prt(resultVo.getQuotation_template_name())%>" readonly="readonly"/>
            </td>
            <td width="26%" class="td_1"><fmt:message key="salse_type"/>：</td>
            <td width="20%" class="td_2">
                <input type="text" class="text_field" inputName="业务类别"
                      value="<%=BaseDataHelper.getNameByCode("SAL_QUO_BIZ_TYPE_BD",RmStringHelper.prt(resultVo.getBiz_type_bd()))%>" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="effect_date"/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="生效日期"
                  value="<%=RmStringHelper.prt(resultVo.getEffect_date(), 10)%>" readonly="readonly"/>
            </td>
            <td class="td_1"><fmt:message key="lapse_date"/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="失效日期"
                  value="<%=RmStringHelper.prt(resultVo.getLapse_date(), 10)%>" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="product_info_desc"/>：</td>
            <%if(isDetailBD!=null&&isDetailBD.equals("1")) {%>
            <td class="td_2">
                 <input type='checkbox' name="pro_desc" checked="checked" disabled="disabled"/>
            </td>
            <%}else{ %>
            <td class="td_2">
                 <input type='checkbox' name="pro_desc" disabled="disabled"/>
            </td>
            <%} %>
            <td class="td_1"><fmt:message key="remark"/>：</td>
            <td class="td_2">
                 <textarea rows="1" name="remark" style="width:350px" readonly="readonly"
                inputName="备注"><%=RmStringHelper.prt(resultVo.getRemark())%></textarea>
            </td>
        </tr>
    </table>
</div>
 <div class="xz_title"><fmt:message key="product_information"/></div>
    <r:datacell 
        id="datacell1"
       queryAction="/FAERP/QuotationtemplateAction.do?cmd=getProduct&quotationtemlateid='${bean.id}'"
        width="98%"
        xpath="QuotationitemVo"
        submitXpath="QuotationitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        >  
       <r:field fieldName="product_name" width="200px" messagekey="product_name" >
       </r:field>   
       <r:field fieldName="scheme_type" width="150px" messagekey="scheme_type" >
       </r:field> 
       <r:field fieldName="big_type_id" width="150px" messagekey="big_type_id" >
       </r:field> 
       <r:field fieldName="small_type_id" width="150px" messagekey="small_type_id" >
       </r:field> 
       <r:field fieldName="three_type_id" width="150px" messagekey="three_type_id" >
       </r:field> 
       <r:field fieldName="product_price" width="80px" messagekey="product_price" >
       </r:field> 
       <r:field fieldName="product_desc" width="200px" messagekey="product_desc" >
       </r:field> 
          
    </r:datacell>
</div>   


</div>


     </div>
	<input type="hidden" name="id"
		value="<%=RmStringHelper.prt(resultVo.getId())%>"></div>

	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
