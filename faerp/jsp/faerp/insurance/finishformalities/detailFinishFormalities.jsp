<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.finishformalities.vo.FinishFormalitiesVo" %>
<%@ page import="rayoo.insurance.finishformalities.util.IFinishFormalitiesConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
    FinishFormalitiesVo resultVo = null;  //定义一个临时的vo变量
    if(request.getAttribute(IFinishFormalitiesConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        resultVo = (FinishFormalitiesVo)request.getAttribute(IFinishFormalitiesConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=queryAll";
        form.submit();
        //window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
<input type="hidden" id="id" name="id" />
<input type="hidden" id="company_id" name="company_id" />
<div id="right">
<script language="javascript">
        writeTableTopFesco('查看已办完信息','<%=request.getContextPath()%>/');
</script> 
<div id="ccChild1"  class="box_xinzeng" style="height: 100%;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >唯一号</td>
            <td class="td_2 ">${bean.emp_code }</td>
            <td class="td_1" >姓名</td>
            <td class="td_2" >${bean.emp_name }</td>
            <td class="td_1" >员工状态</td>
            <td class="td_2" >${bean.emp_status }</td>
        </tr>
        <tr>
            <td  class="td_1" >商编</td>
            <td  class="td_2" >${bean.agent_code }</td>
            <td  class="td_1" >辅编</td>
            <td  class="td_2" >${bean.auxiliary_code }</td>
            <td  class="td_1" >公司名称</td>
            <td  class="td_2" >${bean.cust_name }</td>
        </tr>
        <tr>
            <td  class="td_1" >派往地区</td>
            <td  class="td_2" >${bean.sentoregional }</td>
            <td  class="td_1" >供应商</td>
            <td  class="td_2" >${bean.agent_name }</td>
            <td  class="td_1" >业务员</td>
            <td  class="td_2" >${bean.sales_man }</td>
        </tr>
        <tr>
            <td  class="td_1" >是否外呼</td>
            <td  class="td_2" >${bean.is_outbound }</td>
            <td  class="td_1" >入职日期</td>
            <td  class="td_2" >${bean.on_post_date }</td>
            <td  class="td_1" >办派手续</td>
            <td  class="td_2" >${bean.do_send_formalities }</td>
        </tr>
        <tr>
            <td  class="td_1" >操作日期</td>
            <td  class="td_2" >${bean.create_date }</td>
            <td  class="td_1" >社保标准</td>
            <td  class="td_2" >${bean.ssecurity_standard }</td>
            <td  class="td_1" >手续发布时间</td>
            <td  class="td_2" >${bean.publish_formalite_date }</td>
        </tr>
         <tr>
            <td  class="td_1" >手续类别</td>
            <td  class="td_2" >${bean.procedure_category }</td>
            <td  class="td_1" >通知员工时间</td>
            <td  class="td_2" >${bean.notify_emp_date }</td>
            <td  class="td_1" >人事手续办理时间</td>
            <td  class="td_2" >${bean.person_formalite_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >养老手续办理时间</td>
            <td  class="td_2" >${bean.pension_formalite_date }</td>
            <td  class="td_1" >医疗手续办理时间</td>
            <td  class="td_2" >${bean.medical_formalite_date }</td>
            <td  class="td_1" >公积金手续办理时间</td>
            <td  class="td_2" >${bean.fund_formalite_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >户口所在地</td>
            <td  class="td_2" >${bean.resident_addresss }</td>
            <td  class="td_1" >存档单位</td>
            <td  class="td_2" >${bean.archive_card }</td>
            <td  class="td_1" >与员工联系备注</td>
            <td  class="td_2" >${bean.contact_with_emp_remark }</td>
        </tr>
        <tr>
            <td  class="td_1" >与员工联系办理时间</td>
            <td  class="td_2" >${bean.contact_with_emp_date }</td>
            <td  class="td_1" >办理进度</td>
            <td  class="td_2" >${bean.check_progress }</td>
            <td  class="td_1" >办理进度办理时间</td>
            <td  class="td_2" >${bean.check_progress_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >特殊委托</td>
            <td  class="td_2" >${bean.special_entrust }</td>
            <td  class="td_1" >特殊委托办理时间</td>
            <td  class="td_2" >${bean.special_entrust_date }</td>
            <td  class="td_1" >只存档</td>
            <td  class="td_2" >${bean.is_archive }</td>
        </tr>
        <tr>
            <td  class="td_1" >只存档办理时间</td>
            <td  class="td_2" >${bean.is_archive_date }</td>
            <td  class="td_1" >入职体检</td>
            <td  class="td_2" >${bean.on_post_checkup }</td>
            <td  class="td_1" >入职体检办理时间</td>
            <td  class="td_2" >${bean.on_post_checkup_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >劳动合同</td>
            <td  class="td_2" >${bean.labor_contract }</td>
            <td  class="td_1" >劳动合同办理时间</td>
            <td  class="td_2" >${bean.labor_contract_date }</td>
            <td  class="td_1" >背景调查</td>
            <td  class="td_2" >${bean.bg_investigation }</td>
        </tr>
        <tr>
            <td  class="td_1" >背景调查办理时间</td>
            <td  class="td_2" >${bean.bg_investigation_date }</td>
            <td  class="td_1" >调档备注</td>
            <td  class="td_2" >${bean.tiaodang_remarks }</td>
            <td  class="td_1" >调档办理时间</td>
            <td  class="td_2" >${bean.tiaodang_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >存档单位备注</td>
            <td  class="td_2" >${bean.archive_unit_remarks }</td>
            <td  class="td_1" >存档单位办理时间</td>
            <td  class="td_2" >${bean.archive_unit_date }</td>
            <td  class="td_1" >离职手续发布时间</td>
            <td  class="td_2" >${bean.separat_prod_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续通知员工时间</td>
            <td  class="td_2" >${bean.sp_send_emp_date }</td>
            <td  class="td_1" >离职手续人事手续办理时间</td>
            <td  class="td_2" >${bean.sp_person_handle_date }</td>
            <td  class="td_1" >离职手续养老手续办理时间</td>
            <td  class="td_2" >${bean.sp_pension_handle_date }</td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续医疗手续办理时间</td>
            <td  class="td_2" >${bean.sp_medical_handle_date }</td>
            <td  class="td_1" >离职手续公积金手续办理时间</td>
            <td  class="td_2" >${bean.sp_fund_handle_date }</td>
            <td  class="td_1" >离职手续户口所在地</td>
            <td  class="td_2" >${bean.sp_resident_addresss }</td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续存档单位</td>
            <td  class="td_2" >${bean.sp_archive_card }</td>
            <td  class="td_1" >离职手续与员工联系备注</td>
            <td  class="td_2" >${bean.sp_cwith_emp_remark }</td>
            <td  class="td_1" >离职手续养老个人账号</td>
            <td  class="td_2" >${bean.sp_pension_account }</td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续医疗个人账号</td>
            <td  class="td_2" >${bean.sp_medical_account }</td>
            <td  class="td_1" >离职手续公积金个人账号</td>
            <td  class="td_2" >${bean.sp_fund_account }</td>
            <td  class="td_1" >离职手续办理进度</td>
            <td  class="td_2" >${bean.sp_check_progress }</td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续特殊委托</td>
            <td  class="td_2" >${bean.sp_special_entrust }</td>
            <td  class="td_1" >离职手续只存档</td>
            <td  class="td_2" >${bean.sp_is_archive }</td>
            <td  class="td_1" >离职手续入职体检</td>
            <td  class="td_2" >${bean.sp_on_post_checkup }</td>
        </tr>
         <tr>
            <td  class="td_1" >离职手续劳动合同</td>
            <td  class="td_2" >${bean.sp_labor_contract }</td>
            <td  class="td_1" >离职手续背景调查</td>
            <td  class="td_2" >${bean.sp_bg_investigation }</td>
            <td  class="td_1" >离职手续调档备注</td>
            <td  class="td_2" >${bean.sp_tiaodang_remarks }</td>
        </tr>
        <tr>
            <td class="td_1">离职手续存档单位备注</td>            
            <td colspan="5" class="td_2">${bean.sp_archive_unit_remarks }</td>
        </tr>
    </table>
    <div class="mx_button" style="margin: 10px 0px 0px 10px;" align="center">
        <input type="button" class="icon_2" value='返回'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
