<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>休假申请</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    function vailform(){
        var  custId = jQuery("#cust_id").val();
        if(!custId){
            alert("请选择客户");
            return false;
        }
        
        var  billname = jQuery("#billname").val();
        if(!billname){
            alert("请填写申请单据名称");
            jQuery("#billname").focus();
            return false;
        }
        
        var  applier = jQuery("#applier_id").val();
        if(!applier){
            alert("请填写申请人");
            return false;
        }
        
        var  applydept = jQuery("#applydept").val();
        if(!applydept){
            alert("请填写申请部门");
            jQuery("#applydept").focus();
            return false;
        }
        
        var  leavebeginday = jQuery("#leavebeginday_input").val();
        if(!leavebeginday){
            alert("请填写休假开始日期");
            jQuery("#leavebeginday_input").focus();
            return false;
        }
        
        var  leaveendday = jQuery("#leaveendday_input").val();
        if(!leaveendday){
            alert("请填写休假结束日期");
            jQuery("#leaveendday_input").focus();
            return false;
        }
        
        var leavebegintime = $id("leavebegintime").getValue();
        if (!leavebegintime){
            alert("请填写休假开始时间");
            return false;
        }
        
        var leaveendtime = $id("leaveendtime").getValue();
        if (!leaveendtime){
            alert("请填写休假结束时间");
            return false;
        }
        
        var  leavenote = jQuery("#leavenote").val();
        if(!leavenote){
            alert("请填写休假事由");
            jQuery("#leavenote").focus();
            return false;
        }
        
        var  leavesumhour = jQuery("#leavesumhour").val();
        if(!leavesumhour || isNaN(leavesumhour)){
            alert("休假合计工时必须是数字");
            jQuery("#leavesumhour").focus();
            return false;
        }
        
        var  sumhour = jQuery("#sumhour").val();
        if(isNaN(sumhour)){
            alert("实际休假时长必须是数字");
            jQuery("#sumhour").focus();
            return false;
        }
        
        var  restdayorhour = jQuery("#restdayorhour").val();
        if(isNaN(restdayorhour)){
            alert("结余天数/小时必须是数字");
            jQuery("#restdayorhour").focus();
            return false;
        }
        
        var  realdayorhour = jQuery("#realdayorhour").val();
        if(isNaN(realdayorhour)){
            alert("享有天数/小时必须是数字");
            jQuery("#realdayorhour").focus();
            return false;
        }
        
        var  relatetel = jQuery("#relatetel").val();
        if(!relatetel){
            alert("请填写假期联系电话");
            jQuery("#relatetel").focus();
            return false;
        }
        return true;
    }

    function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/LeavehAction.do?cmd=update&id="+code;
            }else{
                form.action="<%=request.getContextPath()%>/LeavehAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/LeavehAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
 
     function rtnFunc(arg){
        var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    
    function rtnFuncApplier(arg){
        var lookup = $id("applier_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        jQuery("#applier_id").val(arg[0]);
        return false;
    }
    
     function rtnFuncEmployee(arg){
        var lookup = $id("emp_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        jQuery("#emp_id").val(arg[0]);
        return false;
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td  class="td_1" width="23%" ><span style="color:red;">*</span>客户名称</td>
            <td  class="td_2" colspan="3">
                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" ><span style="color:red;">*</span>申请单据名称</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="billname" id="billname" inputName="申请单据名称" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.billname}"/>
            </td>
            <td  class="td_1"  width="23%" ><span style="color:red;">*</span>申请人</td>
            <td  class="td_2 " width="28%" >
                <input type="hidden" name="applier" id="applier_id" value="${bean.applier}">
                <w:lookup onReturnFunc="rtnFuncApplier" readonly="true" id="applier_name" name= "applier_name" displayValue="${bean.applier_name}" 
                                   lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" dialogTitle="选择员工" height="450" width="800"  style="width:190px"/>
            </td>
        </tr>
         <tr>
            <td  class="td_1" width="23%" ><span style="color:red;">*</span>申请部门</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="applydept" id="applydept" inputName="申请部门" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.applydept}"/>
            </td>
            <td  class="td_1"  width="23%" ><span style="color:red;">*</span>休假假别</td>
            <td  class="td_2 " width="28%" >
                <%
                rayoo.workattendance.workattendanceapply.leaveh.vo.LeavehVo beanVo = (rayoo.workattendance.workattendanceapply.leaveh.vo.LeavehVo)request.getAttribute("bean");
                String bean_leavetype = "";
                if (beanVo != null){
                    bean_leavetype = String.valueOf(beanVo.getLeavetype());
                }
                %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("leavetype", -1, "LEAVE_TYPE", bean_leavetype, "", true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>休假开始日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="leavebeginday" name="leavebeginday" format="YYYY-MM-DD" property="bean/leavebeginday" width="190px"/>         
            </td>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>休假结束日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="leaveendday" name="leaveendday" format="YYYY-MM-DD" property="bean/leaveendday" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>休假开始时间</td>
            <td class="td_2 " width="28%">
                <w:time name="leavebegintime" id="leavebegintime"  property="bean/leavebegintime" defaultNull="false"/>
            </td>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>休假结束时间</td>
            <td class="td_2 " width="28%">
                <w:time name="leaveendtime" id="leaveendtime"  property="bean/leaveendtime" defaultNull="false"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >计划开始日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="planbeginday" name="planbeginday" format="YYYY-MM-DD" property="bean/planbeginday" width="190px"/>         
            </td>
            <td class="td_1"  width="23%" >计划结束日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="planendday" name="planendday" format="YYYY-MM-DD" property="bean/planendday" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>休假事由</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="leavenote" id="leavenote" inputName="休假事由" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.leavenote}"/>         
            </td>
            <td class="td_1"  width="23%" >假别周期开始日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="leavecycbegindate" name="leavecycbegindate" format="YYYY-MM-DD" property="bean/leavecycbegindate" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" ><span style="color:red;">*</span>休假合计工时</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="leavesumhour" id="leavesumhour" inputName="休假合计工时" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.leavesumhour}"/>
            </td>
            <td  class="td_1"  width="23%" >实际休假时长</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="sumhour" id="sumhour" inputName="实际休假时长" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.sumhour}"/>
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >结余天数/小时</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="restdayorhour" id="restdayorhour" inputName="结余天数/小时" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.restdayorhour}"/>
            </td>
            <td  class="td_1"  width="23%" >享有天数/小时</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="realdayorhour" id="realdayorhour" inputName="享有天数/小时" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.realdayorhour}"/>
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >工作交接情况</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="workprocess" id="workprocess" inputName="工作交接情况" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.workprocess}"/>
            </td>
            <td  class="td_1"  width="23%" >工作交接人</td>
            <td  class="td_2 " width="28%" >
                <input type="hidden" name="emp_id" id="emp_id" value="${bean.emp_id}">
                <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="emp_name" name= "emp_name"  displayValue="${bean.emp_name}" 
                                   lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" dialogTitle="选择员工" height="450" width="800"  style="width:190px"/>
                
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >销假状态</td>
            <td  class="td_2" width="28%">
                 <%
                String bean_leaveoffstatus = "";
                if (beanVo != null){
                    bean_leaveoffstatus = String.valueOf(beanVo.getLeaveoffstatus());
                }
                %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("leaveoffstatus", -1, "LEAVE_OFF_STATUS", bean_leaveoffstatus, "", false) %> 
            </td>
            <td  class="td_1"  width="23%" >销假日期</td>
            <td  class="td_2 " width="28%" >
                <w:date allowInput="true" id="backdate" name="backdate" format="YYYY-MM-DD" property="bean/backdate" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" ><span style="color:red;">*</span>假期联系电话</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="relatetel" id="relatetel" inputName="假期联系电话" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.relatetel}"/>
            </td>
            <td  class="td_1"  width="23%" >备注</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="remark" id="remark" inputName="备注" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.remark}"/>
            </td>
        </tr>
	</table>
   
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>  
</div>         
            
<input type="hidden" name="id" id="edit_id" value="${bean.id}">

</form>
</body>
</html>
