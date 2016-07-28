<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.workattendance.workattendancerule.workrest.vo.WorkrestVo" %>
<%@ page import="rayoo.workattendance.workattendancerule.workrest.util.IWorkrestConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	WorkrestVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IWorkrestConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (WorkrestVo)request.getAttribute(IWorkrestConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function vailform(){
        var  cust_code = jQuery("#cust_code").val();
        if(!cust_code){
            alert("请选择客户");
            return false;
        }
        /*
        var  kssj = jQuery("#kssj").val();
        if(!kssj){
            alert("请输入开始时间");
            return false;
        }
        var  jssj = jQuery("#jssj").val();
        if(!jssj){
            alert("请输入结束时间");
            return false;
        }
        var  ksto = jQuery("#ksto").val();
        if(!ksto){
            alert("请输入开始截止时间");
            return false;
        }
        var  jsto = jQuery("#jsto").val();
        if(!jsto){
            alert("请输入结束截止时间");
            return false;
        }*/
        return true;
    }
	
	function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/WorkrestAction.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/WorkrestAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/WorkrestAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#cust_code").val(arg[0]);       
	    return false;
	}
</script>
</head>
<body>
<script language="javascript">
    if(<%=isModify%>){
        	writeTableTop('作息时间修改','<%=request.getContextPath()%>/');
        }
    else{
        	writeTableTop('作息时间新增','<%=request.getContextPath()%>/');
        }
</script>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>客户名称</td>
            
            <td class="td_2 " width="28%">
                <input type="hidden" name="cust_code" id="cust_code" value="${bean.cust_code}">
                <% if(isModify) {%>
                <input  name="customer_name" id="customer_name" value="${bean.customer_name}" readonly="true">
                <% }else {%>
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
       			<%} %>
        </tr>
		<tr>
			</td>
            <td class="td_1" width="23%"><span class="style_required_red">* </span>开始时间</td>
            <td class="td_2"  width="28%">
            	<w:time  property="kssj"  id="kssj"  value="${bean.kssj}" />
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>开始截止时间</td>
			<td  class="td_2" width="28%">
				<w:time  property="ksto"  id="ksto"  value="${bean.ksto}" />
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>结束时间</td>
            <td  class="td_2 " width="28%" >
            	<w:time  property="jssj"  id="jssj"  value="${bean.jssj}" />
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>结束截止时间</td>
			<td  class="td_2" width="28%">
				<w:time  property="jsto"  id="jsto"  value="${bean.jsto}" />
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>上班是否打卡</td>
            <td  class="td_2 " width="28%" >
            	<d:select dictTypeId="TrueOrFalse" property="checkoutflag"  id="checkoutflag"  value="${bean.checkoutflag}"  style="width:207px;"  nullLabel="--请选择--"/>
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>下班是否打卡</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="TrueOrFalse" property="checkinflag"  id="checkinflag"  value="${bean.checkinflag}"  style="width:207px;"  nullLabel="--请选择--"/>
			</td>
		</tr>
    </table>
	<p></p>
</div>
		<div class="foot_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
		</div>

<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />
</form> 
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
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
