<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.settlementclaim.vo.SettlementclaimVo" %>
<%@ page import="rayoo.insurance.settlementclaim.util.ISettlementclaimConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<% 
    SettlementclaimVo resultVo = null;  //定义一个临时的vo变量
    if(request.getAttribute(ISettlementclaimConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (SettlementclaimVo)request.getAttribute(ISettlementclaimConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm."><script language="JavaScript" src="../../scripts/common.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    //tab切换
    function setTabSyn ( i )
    {
        selectTabSyn(i);
    }
    
    function selectTabSyn ( i )
    {    
        switch(i){
            case 1:
            document.getElementById('bg').className='social_xixi1';
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById('bg').className='social_xixi2';
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }
</script>
</head>
<body>
<form name="form" method="post"><div id="right">
<div class="ringht_s">
    <!--表格2-->
    <!--表格2 end-->
    <!--社保公积金-->
    <!--表格 -->
     <div class="social_tab">
       <div id="bg" class="social_xixi1">
         <div id="font1" class="social_tab1" onMouseDown="setTabSyn(1);"> 保险公司初给的理赔申请 </div>
         <div id="font2" class="social_tab2" onMouseDown="setTabSyn(2);"> 保险公司理赔结果 </div>
       </div>
       <div id="TabCon1" style="display:block;">
         <!--表格1-->
         <div class="xz_title" style="margin-top:10px;">保险公司初给的理赔申请</div>
         <div class="box_3">
           <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1" width="10%">批次号</td>
            <td class="td_2" width="15%"><%=RmStringHelper.prt(resultVo.getBatch_code()) %></td>
            <td class="td_1" width="10%">保单编号</td>
            <td class="td_2" width="25%"><%=RmStringHelper.prt(resultVo.getPolicy_code()) %></td>
            <td class="td_1" width="10%">申请人名称</td>
            <td class="td_2" width="30%"><%=RmStringHelper.prt(resultVo.getEmp_name()) %></td>
        </tr>
        <tr>
            <td class="td_1" >证件号</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getId_card()) %></td>
            <td class="td_1" >申请人唯一号</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getEmp_code()) %></td>
              <td class="td_1" >附险人姓名</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getAdditional_name()) %></td>
        </tr>
        <tr>
            <td class="td_1" >发票编号</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getInvoice_code()) %></td>
            <td class="td_1" >就诊医院</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getVisiting_hospital()) %></td>
            <td class="td_1" >疾病名称</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getDisease_name()) %></td>
        </tr>
        <tr>
            <td  class="td_1" >票面金额</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getFace_amount()) %></td>
            <td class="td_1" >出险日期</td>
            <td class="td_2 "><fmt:formatDate value="${bean.issuing_date}" pattern="yyyy-MM-dd"/></td>
            <td class="td_1" >就诊日期</td>
            <td class="td_2 "><fmt:formatDate value="${bean.visting_date}" pattern="yyyy-MM-dd"/></td>
        </tr>
    </table> 
    <div class="foot_button">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
    </div>    
    </div>
   </div>
       <div id="TabCon2" style="display:none;">
         <div class="xz_title" style="margin-top:10px;">保险公司理赔结果 </div>
         <div class="box_3">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <input type="hidden" id="id" name="id" />
  <tr>
            <td class="td_1" width="10%">理赔号</td>
            <td class="td_2" width="15%"><%=RmStringHelper.prt(resultVo.getClaim_no()) %></td>
            <td class="td_1" width="10%">交接日期</td>
            <td class="td_2" width="25%"><fmt:formatDate value="${bean.takingover_date}" pattern="yyyy-MM-dd"/></td>
            <td class="td_1" width="10%">项目名称</td>
            <td class="td_2" width="30%"><%=RmStringHelper.prt(resultVo.getItem_name_bd()) %></td>
        </tr>
        <tr>
            <td  class="td_1" >实际申请金额</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getReal_applied_amount()) %></td>
            <td class="td_1">自费</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getPayAmount()) %></td>
            <td  class="td_1" >统筹支付</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getWholly_payment()) %></td>
        </tr>
        <tr>
            <td  class="td_1" >附加支付</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getAttached_payment()) %></td>
            <td  class="td_1" >分类自负</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getConceitedAmount()) %></td>
            <td class="td_1">免赔额</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getDeductible_amount()) %></td>
        </tr>
        <tr>
            <td  class="td_1" >赔付比例</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getPercentage_claims()) %></td>
            <td class="td_1">实际赔付金额</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getReal_claims_amount()) %></td>
            <td class="td_1">总实际赔付</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getTotal_real_claims()) %></td>
        </tr>
        <tr>
            <td  class="td_1" >拒赔原因</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getReason_refuse()) %></td>
            <td class="td_1">缺少材料</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getAbsent_docs()) %></td>
            <td class="td_1">拒赔内容</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getContents_absent_docs()) %></td>
        </tr>
        <tr>
            <td class="td_1" >拒赔张数</td>
            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getClaims_rejected_bd()) %></td>
            <td  class="td_1" >拒赔金额</td>
            <td  class="td_2" ><%=RmStringHelper.prt(resultVo.getRejected_amount()) %></td>
            <td class="td_1">&nbsp;</td>
            <td class="td_2" >&nbsp;</td>
        </tr>
    </table> 
    <div class="foot_button">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
    </div>
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
