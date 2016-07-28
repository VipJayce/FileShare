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
<title>加班申请</title>


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
        
        var  overtimebeginday = jQuery("#overtimebeginday_input").val();
        if(!overtimebeginday){
            alert("请填写加班开始日期");
            jQuery("#overtimebeginday_input").focus();
            return false;
        }
        
        var  overtimeendday = jQuery("#overtimeendday_input").val();
        if(!overtimeendday){
            alert("请填写加班结束日期");
            jQuery("#overtimeendday_input").focus();
            return false;
        } 
        
        var  reason = jQuery("#reason").val();
        if(!reason){
            alert("请填写加班原因");
            jQuery("#reason").focus();
            return false;
        }
        
        var  applydate = jQuery("#applydate_input").val();
        if(!applydate){
            alert("请填写申请日期");
            jQuery("#applydate_input").focus();
            return false;
        }
        
        return true;
    }

    function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/OvertimehAction.do?cmd=update&id="+code;
            }else{
                form.action="<%=request.getContextPath()%>/OvertimehAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/OvertimehAction.do?cmd=queryAll&backFlag=true";
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
            <td  class="td_1"  width="23%" >加班类别</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="overtimetype" id="overtimetype" inputName="加班类别" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.overtimetype}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>加班开始日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="overtimebeginday" name="overtimebeginday" format="YYYY-MM-DD" property="bean/overtimebeginday" width="190px"/>         
            </td>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>加班结束日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="overtimeendday" name="overtimeendday" format="YYYY-MM-DD" property="bean/overtimeendday" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班开始时间</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="overtimebegintime" id="overtimebegintime" inputName="加班开始时间" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.overtimebegintime}"/>      
            </td>
            <td class="td_1"  width="23%" >加班结束时间</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="overtimeendtime" id="overtimeendtime" inputName="加班开始时间" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.overtimeendtime}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班考勤开始日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="kqstartdate" name="kqstartdate" format="YYYY-MM-DD" property="bean/kqstartdate" width="190px"/>         
            </td>
            <td class="td_1"  width="23%" >加班考勤结束日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="kqenddate" name="kqenddate" format="YYYY-MM-DD" property="bean/kqenddate" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >加班考勤开始时间</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="kqstarttime" id="kqstarttime" inputName="加班考勤开始时间" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.kqstarttime}"/>      
            </td>
            <td class="td_1"  width="23%" >加班考勤结束时间</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="kqendtime" id="kqendtime" inputName="加班考勤结束时间" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.kqendtime}"/>
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
            <td class="td_1"  width="23%" >计划开始时间</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="planbegintime" id="planbegintime" inputName="计划开始时间" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.planbegintime}"/>      
            </td>
            <td class="td_1"  width="23%" >计划结束时间</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="planendtime" id="planendtime" inputName="计划结束时间" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.planendtime}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>加班原因</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="reason" id="reason" inputName="加班原因" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.reason}"/>         
            </td>
            <td  class="td_1"  width="23%" >实际加班时长</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="sumhour" id="sumhour" inputName="实际加班时长" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.sumhour}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>申请日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="applydate" name="applydate" format="YYYY-MM-DD" property="bean/applydate" width="190px"/>
            </td>
            <td  class="td_1"  width="23%" >合计加班工时</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="overtimesumhour" id="overtimesumhour" inputName="合计加班工时" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.overtimesumhour}"/>
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" ><span style="color:red;">*</span>是否转调休</td>
            <td  class="td_2" width="28%">
                <%
                rayoo.workattendance.workattendanceapply.overtimeh.vo.OvertimehVo beanVo = (rayoo.workattendance.workattendanceapply.overtimeh.vo.OvertimehVo)request.getAttribute("bean");
                String bean_isstorest = "";
                if (beanVo != null){
                    bean_isstorest = String.valueOf(beanVo.getIstorest());
                }
                %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("istorest", -1, "TrueOrFalse", bean_isstorest, "", true) %>
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
