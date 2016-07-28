<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工账号信息</title>
<script language="javascript">

    function cancel_onClick(){  //取消后返回列表页面
     window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
 <div class="ringht_x">
<div id="ccChild0" class="box_3"> 
    <div class="xz_title" style="padding-top: 10px">基本信息</div>
<table  width="100%" height="313" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        
        <tr>
        <td class="td_1"  nowrap="nowrap">员工所属客户</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cust_name" inputName="员工所属客户" value="${bean.cust_name }" maxLength="50" readonly="readonly" />
            </td>
           <td class="td_1"  nowrap="nowrap">员工唯一号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_code" inputName="员工唯一号" value="${bean.emp_code }" maxLength="50" readonly="readonly" />
            </td>
        </tr>
            <tr>
            <td class="td_1"  nowrap="nowrap">员工姓名</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" value="${bean.emp_name }" maxLength="50" readonly="readonly" />
            </td>
           <td class="td_1"  nowrap="nowrap">员工入离职状态</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="post_status_bd" inputName="员工入离职状态" value="${bean.post_status_bd }" maxLength="50" readonly="readonly" />
            </td>
    
          
        </tr>
        <tr>
            <td class="td_1"  nowrap="nowrap">员工社保账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="social_security_account" inputName="员工社保账号" value="${bean.social_security_account }" maxLength="50" readonly="readonly" />
            </td>
           <td class="td_1"  nowrap="nowrap">员工住房公积金账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="housing_fund_account" inputName="员工住房公积金账号" value="${bean.housing_fund_account }" maxLength="50" readonly="readonly" />
            </td>
        </tr>
                <tr>
            <td class="td_1"  nowrap="nowrap">员工医保账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="medical_insurance_account" inputName="员工医保账号" value="${bean.medical_insurance_account }" maxLength="50" readonly="readonly" />
            </td>
        
        </tr>

    </table>
    </div>
    <div class="foot_button">

        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>           
</div>                 
<input type="hidden" name="id" value="">
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
