<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo" %>
<%@ page import="rayoo.customerservice.laborcontract.util.ILaborcontractConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
    LaborcontractVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ILaborcontractConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (LaborcontractVo)request.getAttribute(ILaborcontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.insertLaborcontract_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        if(checkAllForms()){
        form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=insert";
        form.submit();
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"<fmt:message key='insertLaborcontract0010'/>"
            return false;
        }
            if(checkAllForms()){

        form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=update";
        form.submit();
        }
    }

    function cancel_onClick(){  //<fmt:message key='insertLaborcontract0010'/>后返回列表页面
        form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=queryAll";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0011'/>ID</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="company_id" inputName="<fmt:message key='insertLaborcontract0011'/>ID" value="" maxLength="9.5" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0013'/>ID</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_post_id" inputName="<fmt:message key='insertLaborcontract0013'/>ID" value="" maxLength="9.5" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0015'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_code" inputName="<fmt:message key='insertLaborcontract0015'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0017'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_name" inputName="<fmt:message key='insertLaborcontract0017'/>" value="" maxLength="50" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0019'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='insertLaborcontract0019'/>" value="" maxLength="50" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0021'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='insertLaborcontract0021'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0023'/>ID</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_id" inputName="<fmt:message key='insertLaborcontract0023'/>ID" value="" maxLength="20" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0025'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="start_date" id="start_date" inputName="<fmt:message key='insertLaborcontract0025'/>" /><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0027'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="end_date" id="end_date" inputName="<fmt:message key='insertLaborcontract0027'/>" /><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td  class="td_1" ><fmt:message key='insertLaborcontract0029'/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" name="salary" inputName="<fmt:message key='insertLaborcontract0029'/>" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_2"></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0031'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="try_start_date" id="try_start_date" inputName="<fmt:message key='insertLaborcontract0031'/>" /><img class="refButtonClass"    src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('try_start_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0033'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="try_end_date" id="try_end_date" inputName="<fmt:message key='insertLaborcontract0033'/>" /><img class="refButtonClass"    src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('try_end_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td  class="td_1" ><fmt:message key='insertLaborcontract0035'/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" name="try_salary" inputName="<fmt:message key='insertLaborcontract0035'/>" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
            <td class="td_2"></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0037'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="subscribe_date" id="subscribe_date" inputName="<fmt:message key='insertLaborcontract0037'/>" /><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('subscribe_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0039'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contract_status_bd" inputName="<fmt:message key='insertLaborcontract0039'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0041'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contract_type_bd" inputName="<fmt:message key='insertLaborcontract0041'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0043'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="is_deadline" inputName="<fmt:message key='insertLaborcontract0043'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0045'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="is_work_out" inputName="<fmt:message key='insertLaborcontract0045'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0047'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="welfare_address" inputName="<fmt:message key='insertLaborcontract0047'/>" value="" maxLength="50" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0049'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="working_bd" inputName="<fmt:message key='insertLaborcontract0049'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0051'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="send_start_date" id="send_start_date" inputName="<fmt:message key='insertLaborcontract0051'/>" /><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('send_start_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0053'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="send_end_date" id="send_end_date" inputName="<fmt:message key='insertLaborcontract0053'/>" /><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('send_end_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0055'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="state_bd" inputName="<fmt:message key='insertLaborcontract0055'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0057'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="position" inputName="<fmt:message key='insertLaborcontract0057'/>" value="" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='insertLaborcontract0059'/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="<fmt:message key='insertLaborcontract0059'/>" maxLength="1000" ></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0061'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="last_update_user_id" inputName="<fmt:message key='insertLaborcontract0061'/>" value="" maxLength="9.5" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0063'/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="<fmt:message key='insertLaborcontract0063'/>" /><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
            </td>
            <td  class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='insertLaborcontract0065'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="is_del" inputName="<fmt:message key='insertLaborcontract0065'/>" value="'0'" maxLength="64" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
        <tr>
            <td class="td_1"></td>
            <td class="td_2"></td>
            <td class="td_2"></td>
            <td class="td_2"></td>
        </tr>
    </table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
</script>
