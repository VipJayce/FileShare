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
        
        var  awayid = jQuery("#awayid").val();
        if(!awayid){
            alert("请填写出差单编码");
            jQuery("#awayid").focus();
            return false;
        }
        
        var  awaybeginday = jQuery("#awaybeginday_input").val();
        if(!awaybeginday){
            alert("请填写出差开始日期");
            jQuery("#awaybeginday_input").focus();
            return false;
        }
        
        var  awayendday = jQuery("#awayendday_input").val();
        if(!awayendday){
            alert("请填写出差结束日期");
            jQuery("#awayendday_input").focus();
            return false;
        }
        
        var awaybegintime = $id("awaybegintime").getValue();
        if (!awaybegintime){
            alert("请填写出差开始时间");
            return false;
        }
        
        var awayendtime = $id("awayendtime").getValue();
        if (!awayendtime){
            alert("请填写出差结束时间");
            return false;
        }
        
        var  awaynote = jQuery("#awaynote").val();
        if(!awaynote){
            alert("请填写出差事由");
            jQuery("#awaynote").focus();
            return false;
        }
        
        var  awayaddress = jQuery("#awayaddress").val();
        if(!awayaddress){
            alert("请填写出差目的地");
            jQuery("#awayaddress").focus();
            return false;
        }
        
        var  awaysumhour = jQuery("#awaysumhour").val();
        if(awaysumhour && isNaN(awaysumhour)){
            alert("出差合计时数必须是数字");
            jQuery("#awaysumhour").focus();
            return false;
        }
        
        var  aheadfee = jQuery("#aheadfee").val();
        if(aheadfee && isNaN(aheadfee)){
            alert("预支费用必须是数字");
            jQuery("#aheadfee").focus();
            return false;
        }
        return true;
    }

    function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/AwaybAction.do?cmd=update&id="+code;
            }else{
                form.action="<%=request.getContextPath()%>/AwaybAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/AwaybAction.do?cmd=queryAll&backFlag=true";
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
            <td  class="td_1"  width="23%" ><span style="color:red;">*</span>出差单编码</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="awayid" id="awayid" inputName="出差单编码" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.awayid}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>出差开始日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="awaybeginday" name="awaybeginday" format="YYYY-MM-DD" property="bean/awaybeginday" width="190px"/>         
            </td>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>出差结束日期</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="awayendday" name="awayendday" format="YYYY-MM-DD" property="bean/awayendday" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" >出差开始时间</td>
            <td class="td_2 " width="28%">
                <w:time name="awaybegintime" id="awaybegintime"  property="bean/awaybegintime" defaultNull="false"/>
            </td>
            <td class="td_1"  width="23%" >出差结束时间</td>
            <td class="td_2 " width="28%">
                <w:time name="awayendtime" id="awayendtime"  property="bean/awayendtime" defaultNull="false"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>出差事由</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="awaynote" id="awaynote" inputName="出差事由" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.awaynote}"/>         
            </td>
            <td class="td_1"  width="23%" ><span style="color:red;">*</span>出差目的地</td>
            <td class="td_2 " width="28%">
                <input type="text" class="text_field" name="awayaddress" id="awayaddress" inputName="出差目的地" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.awayaddress}"/>       
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >出差合计时数</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="awaysumhour" id="awaysumhour" inputName="出差合计时数" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.awaysumhour}"/>
            </td>
            <td  class="td_1"  width="23%" >申请日期</td>
            <td  class="td_2 " width="28%" >
                <w:date allowInput="true" id="applydate" name="applydate" format="YYYY-MM-DD" property="bean/applydate" width="190px"/>       
            </td>
        </tr>
        <tr>
            <td  class="td_1" width="23%" >预支费用</td>
            <td  class="td_2" width="28%">
                <input type="text" class="text_field" name="aheadfee" id="aheadfee" inputName="预支费用" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.aheadfee}"/>
            </td>
            <td  class="td_1"  width="23%" >出差工作完成情况</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="workfinish" id="workfinish" inputName="出差工作完成情况" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.workfinish}"/>
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

