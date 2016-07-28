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
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IFinishFormalitiesConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (FinishFormalitiesVo)request.getAttribute(IFinishFormalitiesConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        if(checkAllForms()){
            form.action="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=insert";
            form.submit();
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        if(checkAllForms()){
            form.action="<%=request.getContextPath()%>/FinishFormalitiesAction.do?cmd=update";
            form.submit();
        }
    }

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
    if(<%=isModify%>)
        writeTableTopFesco('修改已办完信息','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('新增已办完信息','<%=request.getContextPath()%>/');
</script> 
<div id="ccChild1"  class="box_xinzeng" style="height: 100%;"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >唯一号</td>
            <td class="td_2 "><input type="text" class="text_field" name="emp_code" id="emp_code" inputName="唯一号" /></td>
            <td class="td_1" >姓名</td>
            <td class="td_2" ><input type="text" class="text_field" name="emp_name" id="emp_name" inputName="姓名" /></td>
            <td class="td_1" >员工状态</td>
            <td class="td_2" ><input type="text" class="text_field" name="emp_status" id="emp_status" inputName="员工状态" /></td>
        </tr>
        <tr>
            <td  class="td_1" >商编</td>
            <td  class="td_2" ><input type="text" class="text_field" name="agent_code" id="agent_code" inputName="商编" /></td>
            <td  class="td_1" >辅编</td>
            <td  class="td_2" ><input type="text" class="text_field" name="auxiliary_code" id="auxiliary_code" inputName="辅编" /></td>
            <td  class="td_1" >公司名称</td>
            <td  class="td_2" ><input type="text" class="text_field" name="cust_name" id="cust_name" inputName="公司名称" /></td>
        </tr>
        <tr>
            <td  class="td_1" >派往地区</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sentoregional" id="sentoregional" inputName="派往地区" /></td>
            <td  class="td_1" >供应商</td>
            <td  class="td_2" ><input type="text" class="text_field" name="agent_name" id="agent_name" inputName="供应商" /></td>
            <td  class="td_1" >业务员</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sales_man" id="sales_man" inputName="业务员" /></td>
        </tr>
        <tr>
            <td  class="td_1" >是否外呼</td>
            <td  class="td_2" ><input type="text" class="text_field" name="is_outbound" id="is_outbound" inputName="是否外呼" /></td>
            <td  class="td_1" >入职日期</td>
            <td  class="td_2" ><input type="text" class="text_field" name="on_post_date" id="on_post_date" inputName="入职日期" /></td>
            <td  class="td_1" >办派手续</td>
            <td  class="td_2" ><input type="text" class="text_field" name="do_send_formalities" id="do_send_formalities" inputName="办派手续" /></td>
        </tr>
        <tr>
            <td  class="td_1" >操作日期</td>
            <td  class="td_2" ><input type="text" class="text_field" name="create_date" id="create_date" inputName="操作日期" /></td>
            <td  class="td_1" >社保标准</td>
            <td  class="td_2" ><input type="text" class="text_field" name="ssecurity_standard" id="ssecurity_standard" inputName="社保标准" /></td>
            <td  class="td_1" >手续发布时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="publish_formalite_date" id="publish_formalite_date" inputName="手续发布时间" /></td>
        </tr>
         <tr>
            <td  class="td_1" >手续类别</td>
            <td  class="td_2" ><input type="text" class="text_field" name="procedure_category" id="procedure_category" inputName="手续类别" /></td>
            <td  class="td_1" >通知员工时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="notify_emp_date" id="notify_emp_date" inputName="通知员工时间" /></td>
            <td  class="td_1" >人事手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="person_formalite_date" id="person_formalite_date" inputName="手续发布时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >养老手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="pension_formalite_date" id="pension_formalite_date" inputName="养老手续办理时间" /></td>
            <td  class="td_1" >医疗手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="medical_formalite_date" id="medical_formalite_date" inputName="医疗手续办理时间" /></td>
            <td  class="td_1" >公积金手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="fund_formalite_date" id="fund_formalite_date" inputName="公积金手续办理时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >户口所在地</td>
            <td  class="td_2" ><input type="text" class="text_field" name="resident_addresss" id="resident_addresss" inputName="户口所在地" /></td>
            <td  class="td_1" >存档单位</td>
            <td  class="td_2" ><input type="text" class="text_field" name="archive_card" id="archive_card" inputName="存档单位" /></td>
            <td  class="td_1" >与员工联系备注</td>
            <td  class="td_2" ><input type="text" class="text_field" name="contact_with_emp_remark" id="contact_with_emp_remark" inputName="与员工联系备注" /></td>
        </tr>
        <tr>
            <td  class="td_1" >与员工联系办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="contact_with_emp_date" id="contact_with_emp_date" inputName="与员工联系办理时间" /></td>
            <td  class="td_1" >办理进度</td>
            <td  class="td_2" ><input type="text" class="text_field" name="check_progress" id="check_progress" inputName="办理进度" /></td>
            <td  class="td_1" >办理进度办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="check_progress_date" id="check_progress_date" inputName="办理进度办理时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >特殊委托</td>
            <td  class="td_2" ><input type="text" class="text_field" name="special_entrust" id="special_entrust" inputName="特殊委托" /></td>
            <td  class="td_1" >特殊委托办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="special_entrust_date" id="special_entrust_date" inputName="特殊委托办理时间" /></td>
            <td  class="td_1" >只存档</td>
            <td  class="td_2" ><input type="text" class="text_field" name="is_archive" id="is_archive" inputName="只存档" /></td>
        </tr>
        <tr>
            <td  class="td_1" >只存档办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="is_archive_date" id="is_archive_date" inputName="只存档办理时间" /></td>
            <td  class="td_1" >入职体检</td>
            <td  class="td_2" ><input type="text" class="text_field" name="on_post_checkup" id="on_post_checkup" inputName="入职体检" /></td>
            <td  class="td_1" >入职体检办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="on_post_checkup_date" id="on_post_checkup_date" inputName="入职体检办理时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >劳动合同</td>
            <td  class="td_2" ><input type="text" class="text_field" name="labor_contract" id="labor_contract" inputName="劳动合同" /></td>
            <td  class="td_1" >劳动合同办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="labor_contract_date" id="labor_contract_date" inputName="劳动合同办理时间" /></td>
            <td  class="td_1" >背景调查</td>
            <td  class="td_2" ><input type="text" class="text_field" name="bg_investigation" id="bg_investigation" inputName="背景调查" /></td>
        </tr>
        <tr>
            <td  class="td_1" >背景调查办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="bg_investigation_date" id="bg_investigation_date" inputName="背景调查办理时间" /></td>
            <td  class="td_1" >调档备注</td>
            <td  class="td_2" ><input type="text" class="text_field" name="tiaodang_remarks" id="tiaodang_remarks" inputName="调档备注" /></td>
            <td  class="td_1" >调档办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="tiaodang_date" id="tiaodang_date" inputName="调档办理时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >存档单位备注</td>
            <td  class="td_2" ><input type="text" class="text_field" name="archive_unit_remarks" id="archive_unit_remarks" inputName="存档单位备注" /></td>
            <td  class="td_1" >存档单位办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="archive_unit_date" id="archive_unit_date" inputName="存档单位办理时间" /></td>
            <td  class="td_1" >离职手续发布时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="separat_prod_date" id="separat_prod_date" inputName="离职手续发布时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续通知员工时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_send_emp_date" id="sp_send_emp_date" inputName="离职手续通知员工时间" /></td>
            <td  class="td_1" >离职手续人事手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_person_handle_date" id="sp_person_handle_date" inputName="离职手续人事手续办理时间" /></td>
            <td  class="td_1" >离职手续养老手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_pension_handle_date" id="sp_pension_handle_date" inputName="离职手续养老手续办理时间" /></td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续医疗手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_medical_handle_date" id="sp_medical_handle_date" inputName="离职手续医疗手续办理时间" /></td>
            <td  class="td_1" >离职手续公积金手续办理时间</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_fund_handle_date" id="sp_fund_handle_date" inputName="离职手续公积金手续办理时间" /></td>
            <td  class="td_1" >离职手续户口所在地</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_resident_addresss" id="sp_resident_addresss" inputName="离职手续户口所在地" /></td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续存档单位</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_archive_card" id="sp_archive_card" inputName="离职手续存档单位" /></td>
            <td  class="td_1" >离职手续与员工联系备注</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_cwith_emp_remark" id="sp_cwith_emp_remark" inputName="离职手续与员工联系备注" /></td>
            <td  class="td_1" >离职手续养老个人账号</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_pension_account" id="sp_pension_account" inputName="离职手续养老个人账号" /></td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续医疗个人账号</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_medical_account" id="sp_medical_account" inputName="离职手续医疗个人账号" /></td>
            <td  class="td_1" >离职手续公积金个人账号</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_fund_account" id="sp_fund_account" inputName="离职手续公积金个人账号" /></td>
            <td  class="td_1" >离职手续办理进度</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_check_progress" id="sp_check_progress" inputName="离职手续办理进度" /></td>
        </tr>
        <tr>
            <td  class="td_1" >离职手续特殊委托</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_special_entrust" id="sp_special_entrust" inputName="离职手续特殊委托" /></td>
            <td  class="td_1" >离职手续只存档</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_is_archive" id="sp_is_archive" inputName="离职手续只存档" /></td>
            <td  class="td_1" >离职手续入职体检</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_on_post_checkup" id="sp_on_post_checkup" inputName="离职手续入职体检" /></td>
        </tr>
         <tr>
            <td  class="td_1" >离职手续劳动合同</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_labor_contract" id="sp_labor_contract" inputName="离职手续劳动合同" /></td>
            <td  class="td_1" >离职手续背景调查</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_bg_investigation" id="sp_bg_investigation" inputName="离职手续背景调查" /></td>
            <td  class="td_1" >离职手续调档备注</td>
            <td  class="td_2" ><input type="text" class="text_field" name="sp_tiaodang_remarks" id="sp_tiaodang_remarks" inputName="离职手续调档备注" /></td>
        </tr>
        <tr>
            <td class="td_1">离职手续存档单位备注</td>            
            <td colspan="5" class="td_2"><textarea class="textarea_limit_words" cols="60" rows="2" name="sp_archive_unit_remarks" id="sp_archive_unit_remarks" inputName="离职手续存档单位备注"></textarea></td>
        </tr>
    </table>
    <div class="mx_button" style="margin: 10px 0px 0px 10px;" align="center">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
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

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
</script>
