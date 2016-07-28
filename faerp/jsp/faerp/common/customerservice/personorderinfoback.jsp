<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.List" %>
<%@ page import="gap.rm.tools.helper.*"%>
<%@ page import="rayoo.employeepost.empentry.epemporder.vo.EpemporderVo" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.vo.EpempordersummoneyVo" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%  //取出本条记录
    EpemporderVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (EpemporderVo)request.getAttribute("vo");  //从request中取出vo, 赋值给resultVo
    EpempordersummoneyVo vo1 = null;
    vo1 = (EpempordersummoneyVo)request.getAttribute("vo1");
    String postId = request.getAttribute("postId").toString();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self"> 
<script type="text/javascript">
    function back_onClick(){
        var postId = document.form.postId.value;
        form.action='<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+postId;
        form.submit();
    }
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>费用段详细</title>

 </head>
<body>
<form name="form" action="" method="post"> 
<input type="hidden" id="postId" name="postId" value="<%=postId %>">
<input type="hidden" id="sumMoney" name="sumMoney" value="<%=vo1.getSum_money() %>">
<input type="hidden" id="sumEMoney" name="sumEMoney" value="<%=vo1.getSum_emoney() %>">
<input type="hidden" id="sumPMoney" name="sumPMoney" value="<%=vo1.getSum_pmoney() %>">

<div id="right">
 <div class="ringht_s">
 
 
<div id="ccChild0" class="box_3">  

     <div class="xz_title">  </div>
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"> 起始时间 </td>
            <td class="td_2"><input name="text" type="text" class="xText" id="text4" value="<%=RmStringHelper.prt(resultVo.getStart_date(), 10)%>"/></td>
            <td class="td_1"> 结束时间 </td>
            <td class="td_2"><input name="text2" type="text" class="xText" id="text5" value="<%=RmStringHelper.prt(resultVo.getEnd_date(), 10)%>"/></td>
          </tr>
          <tr>
            <td class="td_1"> 输入时间 </td>
            <td class="td_2"><input type="text" value="<%=RmStringHelper.prt(resultVo.getApply_date(), 10) %>" class="xText" id="user3"/></td>
            <td class="td_1"> 金额 </td>
            <td class="td_2"><input name="text22" type="text" class="xText" id="text22" value="<fmt:formatNumber value='<%=resultVo.getOrder_amount() %>' pattern='###,###,###,###.##'  minFractionDigits='2'/>"/></td>
          </tr>
          <tr>
            <td class="td_1"> 最后修改人 </td>
            <%
            if(resultVo.getLast_update_user_id()!=null&&resultVo.getLast_update_user_id()!=""&&resultVo.getLast_update_user_id()!="null"){
            %>   
            <td class="td_2"><input name="text3" type="text" class="xText" id="text6" value="<%=OrgHelper.getPartyVoByID(resultVo.getLast_update_user_id()).getName() %>"/></td>
            <%}else{%>
            <td class="td_2"><input name="text3" type="text" class="xText" id="text6" value=""/></td>
            <%} %>
            <td class="td_1"> 最后修改时间 </td>
            <%
            if(resultVo.getLast_update_date()!=null){ %>
            <td class="td_2"><input name="text5" type="text" class="xText" id="text8" value="<%=RmStringHelper.prt(resultVo.getLast_update_date(), 10) %>"/></td>
            <%}else{ %>
            <td class="td_2"><input name="text5" type="text" class="xText" id="text8" value=""/></td>
            <%} %>
          </tr>
        
     </table>
    </div>
    
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=searchDetailPerOrderItemDataBack&orderId=${orderId}&backType=${backType }"
        width="97%"
        height="320px"
        xpath="EpemporderitemVo"
        paramFormId="datacell_formid"
        pageSize="-1"
        >
          <r:field fieldName="product_name" label="产品名称" allowModify="false">
               <h:text/>   
           </r:field>    
          <r:field fieldName="group_name" label="社保组" allowModify="false">
               <h:text/>   
           </r:field>    
          <r:field fieldName="base" label="基数" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="money" label="总金额" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="e_money" label="企业金额" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="p_money" label="个人金额" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="e_ratio" label="企业比例" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="p_ratio" label="个人比例" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="e_add_money" label="企业附加金额" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="p_add_money" label="个人附加金额" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="is_prepay" label="是否预收" allowModify="false">
            <d:select dictTypeId="IS_PHYSICAL_EXAM" />
          </r:field>
          <r:field fieldName="frequency_bd" label="收费频率" allowModify="false">
            <d:select dictTypeId="FREQUENCY_BD" />
          </r:field>
          <r:field fieldName="is_preget" label="收费属性" allowModify="false">
            <d:select dictTypeId="ISPREGET"/>
          </r:field>
          <r:field fieldName="start_date" label="收费开始" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="end_date" label="收费结束" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="is_effected" label="状态" allowModify="false">
            <d:select dictTypeId="IS_EFFECTED" />
          </r:field>
          <r:field fieldName="last_update_user_name" label="最后修改人" allowModify="false">
            <h:text/>
          </r:field>
          <r:field fieldName="last_update_date" label="最后修改时间" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
          </r:field>
    </r:datacell>
    </div>
          
    <div class="foot_button">
       <input type="button" class="foot_icon_1" value='返回'  onclick="javascript:back_onClick();" />
    </div>
    
</div>
</div>
</form>
</body>
</html>

<script type="text/javascript">
jQuery(document).ready(function() {
    $id("datacell1").afterRefresh = function() {
         var a = jQuery("#sumMoney").val();
         var b = jQuery("#sumEMoney").val();
         var c = jQuery("#sumPMoney").val();
         $id("datacell1").addRow();
         $id("datacell1").endEdit();
         jQuery(".eos-body-div tr").last().find("td[fieldId^='product_name']").find("div").text("合计");
         if(a != null && a != "" && a != "null"){
            jQuery(".eos-body-div tr").last().find("td[fieldId^='money']").find("div").text(jQuery("#sumMoney").val());
         }else{
            jQuery(".eos-body-div tr").last().find("td[fieldId^='money']").find("div").text("0.00");
         }
         if(b != null && b != "" && b != "null"){
            jQuery(".eos-body-div tr").last().find("td[fieldId^='e_money']").find("div").text(jQuery("#sumEMoney").val());
         }else{
            jQuery(".eos-body-div tr").last().find("td[fieldId^='e_money']").find("div").text("0.00");
         }
         if(c != null && c != "" && c != "null"){
            jQuery(".eos-body-div tr").last().find("td[fieldId^='p_money']").find("div").text(jQuery("#sumPMoney").val());
         }else{
            jQuery(".eos-body-div tr").last().find("td[fieldId^='p_money']").find("div").text("0.00");
         }
    }

});
</script>

